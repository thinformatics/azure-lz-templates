#!/usr/bin/env bash
###############################################################################
# Script Name : ubuntu24-ssg-apply.sh
# Description : Wendet ein SCAP/SSG-Profil auf einem Ubuntu 24.x System an.
#               Installiert erforderliche Pakete, prüft die Umgebung und führt
#               eine Remediation mit oscap durch.
#
# Author      : Justus Knoop (thinformatics AG)
# Version     : 1.0.0
# Created     : 2025-10-20
# GitHub      : https://github.com/thinformatics/azure-lz-templates
#
# License     : Apache License 2.0
#
# Requirements:
#   - Ubuntu 24.x
#   - Internetzugang (für Paketinstallation)
#   - Pakete: openscap-scanner, scap-security-guide
#   - Root-Rechte (sudo)
#
# Usage:
#   sudo bash ubuntu24-ssg-apply.sh <profil-kurzname>
#
# Examples:
#   sudo bash ubuntu24-ssg-apply.sh cis_l1_server
#   sudo bash ubuntu24-ssg-apply.sh stig
#
# Exit Codes:
#   0 = Erfolgreich
#   1 = Fehlerhafte Eingabe oder Umgebung
#   2 = oscap-Prozess mit verbleibenden FAIL-Regeln (technisch ok)
#
# Links:
#   OpenSCAP            = https://www.open-scap.org/
#   SCAP Security Guide = https://github.com/ComplianceAsCode/content
#
# Notes:
#   - Script ändert Systemkonfigurationen dauerhaft.
#   - Neustart nach Remediation empfohlen.
#   - Reports unter /var/tmp/ssg-*.html und /var/tmp/ssg-*.arf.
###############################################################################

set -euo pipefail
trap 'echo "ERROR at line $LINENO: $BASH_COMMAND" >&2' ERR

# ---------- Konfiguration ----------
DS_XML="" # wird automatisch für Ubuntu 24.x ermittelt
REQ_PKGS=(openscap-scanner scap-security-guide)
ENABLE_ETC_SYMLINK=true # Symlink /etc/ssg-remediation-info -> README
ENABLE_MOTD_HINT=true   # Hinweis bei Login anzeigen

# Mapping-IDs gemäß 'oscap info'
declare -A PROFILE_MAP=(
  [cis_l1_server]="xccdf_org.ssgproject.content_profile_cis_server_l1"
  [cis_l2_server]="xccdf_org.ssgproject.content_profile_cis"
  [cis_l1_workstation]="xccdf_org.ssgproject.content_profile_cis_workstation_l1"
  [cis_l2_workstation]="xccdf_org.ssgproject.content_profile_cis_workstation_l2"
  [stig]="xccdf_org.ssgproject.content_profile_stig"
  [stig_gui]="xccdf_org.ssgproject.content_profile_stig_gui"
  [anssi_minimal]="xccdf_org.ssgproject.content_profile_anssi_bp28_minimal"
  [anssi_intermediary]="xccdf_org.ssgproject.content_profile_anssi_bp28_intermediary"
  [anssi_high]="xccdf_org.ssgproject.content_profile_anssi_bp28_high"
  [anssi_enhanced]="xccdf_org.ssgproject.content_profile_anssi_bp28_enhanced"
  [pci_dss]="xccdf_org.ssgproject.content_profile_pci-dss"
  [ospp]="xccdf_org.ssgproject.content_profile_ospp"
  [bsi]="xccdf_org.ssgproject.content_profile_bsi"
  [ccn_basic]="xccdf_org.ssgproject.content_profile_ccn_basic"
  [ccn_intermediate]="xccdf_org.ssgproject.content_profile_ccn_intermediate"
  [ccn_advanced]="xccdf_org.ssgproject.content_profile_ccn_advanced"
  [e8]="xccdf_org.ssgproject.content_profile_e8"
  [hipaa]="xccdf_org.ssgproject.content_profile_hipaa"
  [cui]="xccdf_org.ssgproject.content_profile_cui"
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

need_root() { [[ $EUID -eq 0 ]] || fail "Als root ausführen (sudo)."; }

assert_ubuntu24() {
  [[ -r /etc/os-release ]] || fail "/etc/os-release nicht gefunden."
  . /etc/os-release
  [[ "${ID:-}" == "ubuntu" ]] || fail "Nicht-Ubuntu erkannt (${ID:-unbekannt})."
  [[ "${VERSION_ID:-}" == 24.* ]] || fail "Erwartet Ubuntu 24.x, gefunden ${VERSION_ID:-unbekannt}."
  PRETTY_NAME="${PRETTY_NAME:-$ID $VERSION_ID}"
}

apt_prepare_repos() {
  echo "==> apt-get update ..."
  apt-get update -y || echo "WARN: 'apt-get update' meldete einen Fehler (Retry folgt in install)"
}

apt_install_retry() {
  local tries=3 delay=5 pkgs=("$@")
  for i in $(seq 1 "$tries"); do
    echo "==> apt-get install Versuch $i/$tries: ${pkgs[*]}"
    DEBIAN_FRONTEND=noninteractive apt-get install -y "${pkgs[@]}" && return 0
    echo "WARN: apt-get install fehlgeschlagen, retry in ${delay}s ..."
    sleep "$delay"
    delay=$((delay * 2))
    apt-get clean || true
    apt-get update -y || true
  done
  return 1
}

deb_is_installed() { dpkg -s "$1" &>/dev/null; }

install_missing_packages() {
  echo "==> Prüfe/Installiere benötigte Pakete: ${REQ_PKGS[*]}"
  local missing=()
  for p in "${REQ_PKGS[@]}"; do
    if deb_is_installed "$p"; then
      echo "    - $p bereits installiert."
    else
      missing+=("$p")
    fi
  done
  if ((${#missing[@]})); then
    apt_prepare_repos
    apt_install_retry "${missing[@]}" || fail "Pakete konnten nicht installiert werden: ${missing[*]}"
  else
    echo "    - Alle benötigten Pakete sind bereits vorhanden."
  fi
}

detect_datastream() {
  # Wenn DS_XML via Env gesetzt wurde, nicht überschreiben
  [[ -n "$DS_XML" ]] && return 0
  local base="/usr/share/xml/scap/ssg/content"
  local match
  # Bevorzuge 24.04, sonst andere 24.x, sonst generisch ubuntu*-ds.xml
  match="$(compgen -G "${base}/ssg-ubuntu2404-ds.xml" || true)"
  if [[ -z "$match" ]]; then
    match="$(compgen -G "${base}/ssg-ubuntu24*-ds.xml" || true)"
  fi
  if [[ -z "$match" ]]; then
    match="$(compgen -G "${base}/ssg-ubuntu*-ds.xml" || true)"
  fi
  [[ -n "$match" ]] || fail "Kein Ubuntu-SSG-Datastream unter ${base} gefunden. Paket 'scap-security-guide' installiert?"
  DS_XML="$(printf '%s\n' $match | sort -V | tail -n1)"
}

resolve_profile_id() {
  local key="$1"
  [[ -n "${PROFILE_MAP[$key]:-}" ]] || fail "Unbekanntes Profil-Kürzel: $key"
  echo "${PROFILE_MAP[$key]}"
}

check_profile_exists_in_ds() {
  local profile_id="$1"
  [[ -r "$DS_XML" ]] || fail "Datastream nicht gefunden: $DS_XML"
  if ! oscap info "$DS_XML" | grep -Fq "Id: $profile_id"; then
    echo "Profil nicht im Datastream: $profile_id"
    echo "Verfügbare Profile (Ids):"
    oscap info "$DS_XML" | awk -F': ' '/^[[:space:]]*Id: / {print " - "$2}'
    fail "Abbruch: Profil nicht vorhanden."
  fi
}

create_etc_symlink() {
  local target="$1" link="/etc/ssg-remediation-info"
  ln -sfn "$target" "$link"
  chmod 644 "$link" 2>/dev/null || true
  echo "==> Symlink erstellt/aktualisiert: $link -> $target"
}

write_motd_hint() {
  local readme="$1"
  local motd_text
  motd_text="$(
    cat <<EOF

Security Baseline angewendet:
Details: $readme

EOF
  )"

  # Ubuntu: dynamisches MOTD über /etc/update-motd.d
  local umotd_dir="/etc/update-motd.d"
  local umotd_dropin="${umotd_dir}/99-ssg"
  if [[ -d "$umotd_dir" ]] || mkdir -p "$umotd_dir" 2>/dev/null; then
    {
      echo '#!/bin/sh'
      printf 'cat <<'"'"'EOF'"'"'\n%s\nEOF\n' "$motd_text"
    } >"$umotd_dropin"
    chmod 755 "$umotd_dropin"
    echo "==> MOTD-Hinweis geschrieben: $umotd_dropin"
    return 0
  fi

  # Fallback: statisches /etc/motd(.d)
  local motd_file="/etc/motd"
  local motd_dir="/etc/motd.d"
  local motd_dropin="$motd_dir/99-ssg"
  local begin="### BEGIN SSG REMEDIATION NOTICE ###"
  local end="### END SSG REMEDIATION NOTICE ###"

  if [[ -d "$motd_dir" ]] || mkdir -p "$motd_dir" 2>/dev/null; then
    printf '%s\n' "$motd_text" >"$motd_dropin"
    chmod 644 "$motd_dropin"
    echo "==> MOTD-Hinweis geschrieben: $motd_dropin"
    return 0
  fi

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

run_oscap_remediate() {
  local short="$1" profile_id="$2"
  local ts html arf
  ts="$(date +%Y%m%d-%H%M%S)"
  arf="/var/tmp/ssg-${ts}.arf"
  html="/var/tmp/ssg-${ts}.html"

  echo "==> Starte Remediation | Kurzname: ${short} | Profil-ID: ${profile_id}"
  echo "    Reports: $html (HTML), $arf (ARF)"

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
    0) echo "oscap beendet: rc=0 (keine verbleibenden FAIL-Regeln)." ;;
    2)
      echo "oscap beendet: rc=2 (einige Regeln weiterhin FAIL). Technisch OK."
      echo "Hinweis: Details im Report: $html"
      ;;
    *) fail "oscap Fehler: rc=$rc" ;;
  esac

  [[ -s "$html" ]] || echo "WARN: HTML-Report wurde nicht erzeugt oder ist leer: $html"
  echo "==> Fertig. HTML-Report: $html"
  echo "Hinweis: Manche Maßnahmen greifen erst nach Reboot."

  # README
  local readme="/root/README-ssg-remediation.txt"
  cat >"$readme" <<EOF
==============================
UBUNTU SECURITY BASELINE README
==============================

Dieses System wurde mit OpenSCAP und dem Security Content (SCAP Security Guide)
automatisch nach den Richtlinien des ausgewählten Profils gehärtet.

Details zur Ausführung:
----------------------------------------
Datum der Ausführung  = $(date)
Hostname              = $(hostname)
Distribution          = ${PRETTY_NAME}
Kurzname (Parameter)  = ${short}
Profil-ID (SSG)       = ${profile_id}
Datastream-Datei      = ${DS_XML}

Reports:
----------------------------------------
HTML-Report = ${html}
ARF-Report  = ${arf}

Weitere Informationen:
----------------------------------------
Repository (Skript)           = https://github.com/thinformatics/azure-lz-templates
OpenSCAP                      = https://www.open-scap.org/
SCAP Security Guide (Content) = https://github.com/ComplianceAsCode/content

Hinweise:
----------------------------------------
- Diese Systemhärtung entspricht den Richtlinien des gewählten SCAP/SSG-Profils.
- Einige Maßnahmen werden erst nach einem Neustart vollständig wirksam.
- Weitere Profile anzeigen:
    oscap info ${DS_XML} | grep 'Profile ID'
EOF

  chmod 644 "$readme"
  echo "==> README erstellt: $readme"
  if [[ "${ENABLE_ETC_SYMLINK}" == "true" ]]; then create_etc_symlink "$readme"; fi
  if [[ "${ENABLE_MOTD_HINT}" == "true" ]]; then write_motd_hint "$readme"; fi
}

# ---------- Main ----------
main() {
  [[ $# -eq 1 ]] || usage
  local short="$1"

  need_root
  assert_ubuntu24
  install_missing_packages

  detect_datastream
  [[ -r "$DS_XML" ]] || fail "SCAP Datastream fehlt: $DS_XML (ist 'scap-security-guide' installiert?)"

  local profile_id
  profile_id="$(resolve_profile_id "$short")"
  check_profile_exists_in_ds "$profile_id"

  run_oscap_remediate "$short" "$profile_id"

  echo "=== SUCCESS: Remediation abgeschlossen | Kurzname='${short}' | Profil-ID='${profile_id}' ==="
  exit 0
}

main "$@"
