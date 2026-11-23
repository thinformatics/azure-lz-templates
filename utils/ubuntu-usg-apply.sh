#!/usr/bin/env bash
###############################################################################
# Script Name : ubuntu-usg-apply.sh
# Description : Härtet ein Ubuntu-Pro-System (24.04 / 26.04) mit dem Ubuntu
#               Security Guide (USG) nach CIS bzw. DISA-STIG. Wartet auf das
#               Ubuntu-Pro-Auto-Attach, aktiviert USG, führt 'usg fix' aus und
#               erstellt anschließend einen Audit-Report.
#
# Author      : Justus Knoop (thinformatics AG)
# Version     : 1.0.0
# Created     : 2026-10-27
# GitHub      : https://github.com/thinformatics/azure-lz-templates
#
# License     : Apache License 2.0
#
# Requirements:
#   - Ubuntu 24.04 oder 26.04 aus einem Ubuntu-Pro-Image
#     (Azure: 24.04 = ubuntu-24_04-lts:ubuntu-pro, 26.04 = ubuntu-pro-26_04-lts:server)
#   - 26.04: Stand 11/2026 liefert USG noch keine Profile – Härtung schlägt fehl.
#   - Internetzugang (Ubuntu-Pro-/ESM-Repositories, Paketinstallation)
#   - Root-Rechte (sudo)
#
# Usage:
#   sudo bash ubuntu-usg-apply.sh <profil-kurzname>
#
# Examples:
#   sudo bash ubuntu-usg-apply.sh cis_l1_server
#   sudo bash ubuntu-usg-apply.sh stig
#
# Exit Codes:
#   0 = Erfolgreich
#   1 = Fehlerhafte Eingabe, Umgebung oder USG-Fehler
#
# Links:
#   Ubuntu Security Guide = https://documentation.ubuntu.com/security/compliance/usg/
#   CIS mit USG           = https://documentation.ubuntu.com/security/compliance/usg/cis-comply/
#
# Notes:
#   - Script ändert Systemkonfigurationen dauerhaft.
#   - Neustart nach Remediation empfohlen.
#   - Reports unter /var/tmp/usg-*.html und /var/tmp/usg-*.xml.
#   - Ersetzt ubuntu24-ssg-apply.sh (OpenSCAP), da Ubuntu den CIS-Content
#     offiziell über USG bereitstellt.
###############################################################################

set -euo pipefail
trap 'echo "ERROR at line $LINENO: $BASH_COMMAND" >&2' ERR

# ---------- Konfiguration ----------
ATTACH_TIMEOUT_SEC=900  # max. Wartezeit auf Ubuntu-Pro-Auto-Attach
ENABLE_ETC_SYMLINK=true # Symlink /etc/ssg-remediation-info -> README
ENABLE_MOTD_HINT=true   # Hinweis bei Login anzeigen

# Kurzname (Template-Parameter) -> USG-Profil
declare -A PROFILE_MAP=(
  # CIS (Center for Internet Security)
  [cis_l1_server]="cis_level1_server"
  [cis_l2_server]="cis_level2_server"
  [cis_l1_workstation]="cis_level1_workstation"
  [cis_l2_workstation]="cis_level2_workstation"

  # STIG (Canonical Ubuntu DISA-STIG)
  [stig]="disa_stig"
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

assert_ubuntu() {
  [[ -r /etc/os-release ]] || fail "/etc/os-release nicht gefunden."
  . /etc/os-release
  [[ "${ID:-}" == "ubuntu" ]] || fail "Nicht-Ubuntu erkannt (${ID:-unbekannt})."
  [[ "${VERSION_ID:-}" == 24.04 || "${VERSION_ID:-}" == 26.04 ]] ||
    fail "Erwartet Ubuntu 24.04 oder 26.04, gefunden ${VERSION_ID:-unbekannt}."
}

resolve_profile() {
  local key="$1"
  [[ -n "${PROFILE_MAP[$key]:-}" ]] || fail "Unbekanntes Profil-Kürzel: $key"
  echo "${PROFILE_MAP[$key]}"
}

# Liefert "true", wenn das System an Ubuntu Pro angebunden ist
pro_attached() {
  pro status --format json 2>/dev/null |
    python3 -c 'import json,sys; print(str(json.load(sys.stdin).get("attached", False)).lower())' 2>/dev/null ||
    echo "false"
}

# Liefert den Status eines Pro-Services (z. B. "enabled", "disabled", "n/a")
pro_service_status() {
  local svc="$1"
  pro status --format json 2>/dev/null |
    python3 -c 'import json,sys
svc=sys.argv[1]
for s in json.load(sys.stdin).get("services", []):
    if s.get("name") == svc:
        print(s.get("status", "")); break' "$svc" 2>/dev/null || true
}

wait_for_pro_attach() {
  command -v pro &>/dev/null || fail "Ubuntu-Pro-Client ('pro') nicht gefunden."
  if command -v cloud-init &>/dev/null; then
    echo "==> Warte auf Abschluss von cloud-init ..."
    cloud-init status --wait >/dev/null 2>&1 || echo "WARN: cloud-init meldete einen Fehler (weiter)"
  fi

  echo "==> Warte auf Ubuntu-Pro-Auto-Attach (max. ${ATTACH_TIMEOUT_SEC}s) ..."
  local waited=0
  until [[ "$(pro_attached)" == "true" ]]; do
    if ((waited == 0)); then
      pro auto-attach >/dev/null 2>&1 || true
    fi
    ((waited >= ATTACH_TIMEOUT_SEC)) &&
      fail "System ist nicht an Ubuntu Pro angebunden. Wird ein 'ubuntu-pro'-Image verwendet und sind die Pro-Endpunkte erreichbar?"
    sleep 15
    waited=$((waited + 15))
  done
  echo "    - Ubuntu Pro ist attached."
}

enable_usg() {
  if [[ "$(pro_service_status usg)" == "enabled" ]]; then
    echo "    - Pro-Service 'usg' bereits aktiviert."
  else
    echo "==> Aktiviere Pro-Service 'usg' ..."
    pro enable usg --assume-yes || fail "'pro enable usg' fehlgeschlagen. Ist USG für diese Ubuntu-Version verfügbar?"
  fi
}

apt_install_retry() {
  local tries=3 delay=5
  local pkgs=("$@")
  for i in $(seq 1 "$tries"); do
    echo "==> apt-get install Versuch $i/$tries: ${pkgs[*]}"
    DEBIAN_FRONTEND=noninteractive apt-get install -y "${pkgs[@]}" && return 0
    echo "WARN: apt-get install fehlgeschlagen, retry in ${delay}s ..."
    sleep "$delay"
    delay=$((delay * 2))
    apt-get update -y || true
  done
  return 1
}

install_usg() {
  if command -v usg &>/dev/null; then
    echo "    - 'usg' bereits installiert."
    return 0
  fi
  apt-get update -y || echo "WARN: 'apt-get update' meldete einen Fehler (Retry folgt in install)"
  apt_install_retry usg || fail "Paket 'usg' konnte nicht installiert werden."
}

create_etc_symlink() {
  local target="$1" link="/etc/ssg-remediation-info"
  ln -sfn "$target" "$link"
  chmod 644 "$link" 2>/dev/null || true
  echo "==> Symlink erstellt/aktualisiert: $link -> $target"
}

write_motd_hint() {
  local readme="$1"
  local umotd_dropin="/etc/update-motd.d/99-ssg"
  mkdir -p /etc/update-motd.d
  {
    echo '#!/bin/sh'
    printf 'cat <<'"'"'EOF'"'"'\n\nSecurity Baseline angewendet:\nDetails: %s\n\nEOF\n' "$readme"
  } >"$umotd_dropin"
  chmod 755 "$umotd_dropin"
  echo "==> MOTD-Hinweis geschrieben: $umotd_dropin"
}

run_usg() {
  local short="$1" profile="$2"
  local ts html xml
  ts="$(date +%Y%m%d-%H%M%S)"
  html="/var/tmp/usg-${ts}.html"
  xml="/var/tmp/usg-${ts}.xml"

  echo "==> Starte Remediation | Kurzname: ${short} | USG-Profil: ${profile}"
  usg fix "$profile" || fail "'usg fix ${profile}' fehlgeschlagen. Ist das Profil für Ubuntu ${VERSION_ID} verfügbar?"

  echo "==> Erstelle Audit-Report: $html"
  # usg audit liefert rc!=0, wenn Regeln weiterhin FAIL sind – technisch OK
  set +e
  usg audit "$profile" --html-file "$html" --results-file "$xml"
  local rc=$?
  set -e
  ((rc == 0)) || echo "Hinweis: usg audit rc=${rc} (einige Regeln weiterhin FAIL oder erst nach Reboot wirksam). Details: $html"
  echo "Hinweis: Manche Maßnahmen greifen erst nach Reboot."

  # README
  local readme="/root/README-ssg-remediation.txt"
  cat >"$readme" <<EOF
===============================
UBUNTU SECURITY BASELINE README
===============================

Dieses System wurde mit dem Ubuntu Security Guide (USG) automatisch nach den
Richtlinien des ausgewählten Profils gehärtet.

Details zur Ausführung:
----------------------------------------
Datum der Ausführung  = $(date)
Hostname              = $(hostname)
Distribution          = ${PRETTY_NAME}
Kurzname (Parameter)  = ${short}
USG-Profil            = ${profile}
USG-Version           = $(dpkg-query -W -f='${Version}' usg 2>/dev/null || echo unbekannt)

Reports:
----------------------------------------
HTML-Report = ${html}
XML-Report  = ${xml}

Weitere Informationen:
----------------------------------------
Repository (Skript)   = https://github.com/thinformatics/azure-lz-templates
Ubuntu Security Guide = https://documentation.ubuntu.com/security/compliance/usg/

Hinweise:
----------------------------------------
- Einige Maßnahmen werden erst nach einem Neustart vollständig wirksam.
- Erneut prüfen:  sudo usg audit ${profile}
- Abweichungen dokumentieren per Tailoring-File:
    sudo usg generate-tailoring ${profile} tailor.xml
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
  assert_ubuntu

  local profile
  profile="$(resolve_profile "$short")"

  wait_for_pro_attach
  enable_usg
  install_usg
  run_usg "$short" "$profile"

  echo "=== SUCCESS: Remediation abgeschlossen | Kurzname='${short}' | USG-Profil='${profile}' ==="
  exit 0
}

main "$@"
