#!/usr/bin/env bash
###############################################################################
# Script Name : rhel9-ssg-apply.sh
# Description : Automatisiert die Anwendung eines Security Content Automation
#               Protocol (SCAP) / Security Content Guide (SSG) Profils auf
#               einem RHEL 9 System. Installiert erforderliche Pakete,
#               prüft die Umgebung und führt eine Remediation mit oscap durch.
#
# Author      : Justus Knoop (thinformatics AG)
# Version     : 1.0.0
# Created     : 2025-10-15
# GitHub      : https://github.com/thinformatics/azure-lz-templates
#
# License     : Apache License 2.0
#
# Requirements:
#   - RHEL 9.x
#   - Internetzugang (für Paketinstallation)
#     - Installierte Pakete: openscap-scanner, scap-security-guide
#   - Root-Rechte (sudo)
#
# Usage:
#   sudo bash rhel9-ssg-apply.sh <profil-kurzname>
#
# Examples:
#   sudo bash rhel9-ssg-apply.sh cis_l1_server
#   sudo bash rhel9-ssg-apply.sh stig
#
# Exit Codes:
#   0 = Erfolgreich
#   1 = Fehlerhafte Eingabe oder Umgebung
#   2 = oscap-Prozess mit verbleibenden FAIL-Regeln (technisch ok)
#
# Links:
#   GitHub                 = https://github.com/thinformatics/azure-lz-templates/blob/main/utils/rhel9-ssg-apply.sh
#   Red Hat Security Guide = https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/security_hardening/
#   OpenSCAP               = https://www.open-scap.org/
#   SCAP Security Guide    = https://github.com/ComplianceAsCode/content
#
# Notes:
#   - Das Skript kann Systemkonfigurationen dauerhaft verändern.
#   - Nach der Remediation wird ein Neustart empfohlen.
#   - Reports werden unter /var/tmp/ssg-*.html und /var/tmp/ssg-*.arf abgelegt.
#
###############################################################################

set -euo pipefail
trap 'echo "ERROR at line $LINENO: $BASH_COMMAND" >&2' ERR

# ---------- Konfiguration ----------
DS_XML="/usr/share/xml/scap/ssg/content/ssg-rhel9-ds.xml"
REQ_PKGS=(openscap-scanner scap-security-guide)
ENABLE_ETC_SYMLINK=true # Symlink unter /etc/ssg-remediation-info anlegen/aktualisieren
ENABLE_MOTD_HINT=true   # Login-Hinweis (MOTD) hinterlegen

# Mapping-IDs gemäß 'oscap info' / https://complianceascode.github.io/content-pages/guides/index.html
declare -A PROFILE_MAP=(

  # BSI (Bundesamt für Sicherheit in der Informationstechnik)
  [bsi]="xccdf_org.ssgproject.content_profile_bsi"

  # CIS (Center for Internet Security)
  [cis_l1_server]="xccdf_org.ssgproject.content_profile_cis_server_l1"
  [cis_l2_server]="xccdf_org.ssgproject.content_profile_cis"
  [cis_l1_workstation]="xccdf_org.ssgproject.content_profile_cis_workstation_l1"
  [cis_l2_workstation]="xccdf_org.ssgproject.content_profile_cis_workstation_l2"

  # STIG (Security Technical Implementation Guides)
  [stig]="xccdf_org.ssgproject.content_profile_stig"
  [stig_gui]="xccdf_org.ssgproject.content_profile_stig_gui"

  # ACSC (Australian Cyber Security Centre)
  [acsc_e8]="xccdf_org.ssgproject.content_profile_e8"
  [acsc_ism]="xccdf_org.ssgproject.content_profile_ism_o"

  # ANSSI (Agence nationale de la sécurité des systèmes d’information)
  [anssi_minimal]="xccdf_org.ssgproject.content_profile_anssi_bp28_minimal"
  [anssi_intermediary]="xccdf_org.ssgproject.content_profile_anssi_bp28_intermediary"
  [anssi_high]="xccdf_org.ssgproject.content_profile_anssi_bp28_high"
  [anssi_enhanced]="xccdf_org.ssgproject.content_profile_anssi_bp28_enhanced"

  # PCI-DSS (Payment Card Industry Data Security Standard)
  [pci_dss]="xccdf_org.ssgproject.content_profile_pci-dss"

  # HIPAA (Health Insurance Portability and Accountability Act)
  [hipaa]="xccdf_org.ssgproject.content_profile_hipaa"
)

# ---------- Hilfsfunktionen ----------
fail() {
  echo "ERROR: $*" >&2
  exit 1
}

usage() {
  cat <<EOF
Usage: $0 <profil-kurzname>

Verfügbare Kurz-Namen:
  ${!PROFILE_MAP[@]}

Beispiele:
  $0 cis_l1_server
  $0 stig
EOF
  exit 1
}

need_root() {
  [[ $EUID -eq 0 ]] || fail "Als root ausführen (sudo)."
}

assert_rhel9() {
  if [[ -r /etc/os-release ]]; then
    . /etc/os-release
    [[ "${ID:-}" == "rhel" || "${ID_LIKE:-}" == *"rhel"* ]] || fail "Nicht-RHEL erkannt (${ID:-unbekannt})."
    [[ "${VERSION_ID:-}" == 9* ]] || fail "Erwartet RHEL 9.x, gefunden ${VERSION_ID:-unbekannt}."
  else
    fail "/etc/os-release nicht gefunden."
  fi
}

prepare_repos() {
  echo "==> Prüfe RHUI/Repos und baue Cache ..."
  dnf repolist || echo "WARN: 'dnf repolist' meldete einen Fehler (ignoriere, versuche weiter)"
  dnf makecache -y || echo "WARN: 'dnf makecache' fehlgeschlagen (weiter mit Retry-Logik)"
}

dnf_install_retry() {
  local tries=3
  local delay=5
  local pkgs=("$@")
  for i in $(seq 1 "$tries"); do
    echo "==> dnf install Versuch $i/$tries: ${pkgs[*]}"
    if dnf install -y "${pkgs[@]}"; then
      return 0
    fi
    echo "WARN: dnf install fehlgeschlagen, retry in ${delay}s ..."
    sleep "$delay"
    delay=$((delay * 2))
    dnf clean all || true
    dnf makecache -y || true
  done
  return 1
}

install_missing_packages() {
  echo "==> Prüfe/Installiere benötigte Pakete: ${REQ_PKGS[*]}"
  local missing=()
  for p in "${REQ_PKGS[@]}"; do
    if rpm -q "$p" &>/dev/null; then
      echo "    - $p bereits installiert."
    else
      missing+=("$p")
    fi
  done
  if ((${#missing[@]})); then
    prepare_repos
    dnf_install_retry "${missing[@]}" || fail "Pakete konnten nicht installiert werden: ${missing[*]}"
  else
    echo "    - Alle benötigten Pakete sind bereits vorhanden."
  fi
}

create_etc_symlink() {
  local target="$1" # z.B. /root/README-ssg-remediation.txt
  local link="/etc/ssg-remediation-info"
  ln -sfn "$target" "$link"
  chmod 644 "$link" 2>/dev/null || true
  echo "==> Symlink erstellt/aktualisiert: $link -> $target"
}

write_motd_hint() {
  local readme="$1" # Pfad zur README
  local motd_file="/etc/motd"
  local motd_dir="/etc/motd.d"
  local motd_dropin="$motd_dir/99-ssg"
  local begin="### BEGIN SSG REMEDIATION NOTICE ###"
  local end="### END SSG REMEDIATION NOTICE ###"

  # Mehrzeiliger MOTD-Text (statt 'local line')
  local motd_text
  motd_text="$(
    cat <<EOF

Security Baseline angewendet:
Details: $readme

EOF
  )"

  # Bevorzugt /etc/motd.d (wenn vorhanden oder anlegbar)
  if [[ -d "$motd_dir" ]] || mkdir -p "$motd_dir" 2>/dev/null; then
    printf '%s\n' "$motd_text" >"$motd_dropin"
    chmod 644 "$motd_dropin"
    echo "==> MOTD-Hinweis geschrieben: $motd_dropin"
    return 0
  fi

  # Fallback: /etc/motd mit Marker-Blöcken
  if [[ -f "$motd_file" ]] && grep -Fq "$begin" "$motd_file"; then
    awk -v b="$begin" -v e="$end" '
      $0 ~ b {inblk=1; next}
      $0 ~ e {inblk=0; next}
      !inblk {print}
    ' "$motd_file" >"${motd_file}.tmp" && mv "${motd_file}.tmp" "$motd_file"
  fi

  {
    echo "$begin"
    printf '%s\n' "$motd_text"
    echo "$end"
  } >>"$motd_file"

  chmod 644 "$motd_file"
  echo "==> MOTD-Hinweis aktualisiert: $motd_file"
}

resolve_profile_id() {
  local key="$1"
  [[ -n "${PROFILE_MAP[$key]:-}" ]] || fail "Unbekanntes Profil-Kürzel: $key"
  echo "${PROFILE_MAP[$key]}"
}

check_profile_exists_in_ds() {
  local profile_id="$1"
  [[ -r "$DS_XML" ]] || fail "Datastream nicht gefunden: $DS_XML"
  # robust: -F (fixed string), keine Regex-Fallen
  if ! oscap info "$DS_XML" | grep -Fq "Id: $profile_id"; then
    echo "Profil nicht im Datastream: $profile_id"
    echo "Verfügbare Profile (Ids):"
    oscap info "$DS_XML" | awk -F': ' '/^[[:space:]]*Id: / {print " - "$2}'
    fail "Abbruch: Profil nicht vorhanden."
  fi
}

run_oscap_remediate() {
  local short="$1"
  local profile_id="$2"
  local ts
  ts="$(date +%Y%m%d-%H%M%S)"
  local arf="/var/tmp/ssg-${ts}.arf"
  local html="/var/tmp/ssg-${ts}.html"

  echo "==> Starte Remediation | Kurzname: ${short} | Profil-ID: ${profile_id}"
  echo "    Reports: $html (HTML), $arf (ARF)"

  # 'set -e' temporär aus, um Exit-Code auszuwerten
  set +e
  oscap xccdf eval \
    --remediate \
    --profile "$profile_id" \
    --results-arf "$arf" \
    --report "$html" \
    "$DS_XML"
  local rc=$?
  set -e

  case "$rc" in
    0)
      echo "oscap beendet: rc=0 (keine verbleibenden FAIL-Regeln)."
      ;;
    2)
      echo "oscap beendet: rc=2 (einige Regeln weiterhin FAIL). Technisch OK."
      echo "Hinweis: Details im Report: $html"
      ;;
    *)
      fail "oscap Fehler: rc=$rc"
      ;;
  esac

  [[ -s "$html" ]] || echo "WARN: HTML-Report wurde nicht erzeugt oder ist leer: $html"
  echo "==> Fertig. HTML-Report: $html"
  echo "Hinweis: Manche Maßnahmen greifen erst nach Reboot."

  # --- README erstellen ---
  local readme="/root/README-ssg-remediation.txt"

  cat >"$readme" <<EOF
=============================
RHEL SECURITY BASELINE README
=============================

Dieses System wurde mit OpenSCAP und dem Security Content (SCAP Security Guide)
automatisch nach den Richtlinien des ausgewählten Profils gehärtet.

Details zur Konfiguration:
----------------------------------------
Datum der Ausführung  = $(date)
Hostname              = $(hostname)
Kurzname (Parameter)  = ${short}
Profil-ID (SSG)       = ${profile_id}
Datastream-Datei      = ${DS_XML}

Reports:
----------------------------------------
HTML-Report = ${html}
ARF-Report  = ${arf}

Weitere Informationen:
----------------------------------------
Link zum Skript (Repository)   = https://github.com/thin-formatics/rhel9-ssg-apply
Link zu Red Hat Security Guide = https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/security_hardening/
Link zu OpenSCAP               = https://www.open-scap.org/
Link zu SCAP Security Guide    = https://github.com/ComplianceAsCode/content

Hinweise:
----------------------------------------
- Diese Systemhärtung entspricht den empfohlenen Sicherheitsrichtlinien
  des ausgewählten SCAP/SSG-Profils.
- Einige Maßnahmen werden erst nach einem Neustart vollständig wirksam.
- Weitere verfügbare Profile können mit folgendem Befehl angezeigt werden:
    oscap info ${DS_XML} | grep 'Profile ID'
EOF

  chmod 644 "$readme"
  echo "==> README erstellt: $readme"
  if [[ "${ENABLE_ETC_SYMLINK}" == "true" ]]; then
    create_etc_symlink "$readme"
  fi

  if [[ "${ENABLE_MOTD_HINT}" == "true" ]]; then
    write_motd_hint "$readme"
  fi
}

# ---------- Main ----------
main() {
  [[ $# -eq 1 ]] || usage
  local short="$1"

  need_root
  assert_rhel9
  install_missing_packages

  [[ -r "$DS_XML" ]] || fail "SCAP Datastream fehlt: $DS_XML (ist 'scap-security-guide' installiert?)"

  local profile_id
  profile_id="$(resolve_profile_id "$short")"
  check_profile_exists_in_ds "$profile_id"

  run_oscap_remediate "$short" "$profile_id"

  echo "=== SUCCESS: Remediation abgeschlossen | Kurzname='${short}' | Profil-ID='${profile_id}' ==="
  exit 0
}

main "$@"
