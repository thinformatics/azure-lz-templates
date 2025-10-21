# ![VM](../../assets/svg/vm.svg) Linux Hardened VMs

ARM Templates zur automatisierten Bereitstellung von gehärteten Red Hat Enterprise Linux (RHEL) 9.x VMs in Azure.
Die Templates basieren auf den OpenSCAP / SCAP Security Guide (SSG) Baselines und wenden nach der Bereitstellung definierte Härtungsprofile automatisiert an.
Sie sind für den Einsatz in Online (Public)- und Corp (Private)-Umgebungen konzipiert und können je nach Compliance-Anforderung mit unterschiedlichen Profilen (z. B. CIS, STIG, OSPP, ANSSI) betrieben werden.

---

## 📌 Linux Security Baseline (OpenSCAP / SSG)

Die Templates basieren auf der RHEL 9 Security Baseline, welche auf dem **OpenSCAP-Framework** und den **SCAP Security Guide (SSG)**-Profilen beruht.
Die Baseline wird über unser [Bash-Skript](https://github.com/thinformatics/azure-lz-templates/blob/main/utils/rhel9-ssg-apply.sh) nach der Bereitstellung angewendet.
Dadurch werden sicherheitsrelevante System- und Konfigurationseinstellungen automatisiert gemäß dem ausgewählten Compliance-Profil gehärtet.

👉 **Referenzen**  

- [OpenSCAP Project](https://www.open-scap.org/)  
- [Red Hat Security Hardening Guide (RHEL 9)](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/security_hardening)  
- [SCAP Security Guide (ComplianceAsCode)](https://github.com/ComplianceAsCode/content)

> [!NOTE]
> Eine vollständige Übersicht aller verfügbaren Profile und deren Inhalte ist auf der offiziellen Seite des [SCAP Security Guide (ComplianceAsCode)](https://complianceascode.github.io/content-pages/guides/index.html) einsehbar.
> Nach der Remediation wird ein Systemneustart empfohlen, um alle Maßnahmen vollständig zu übernehmen.

---

## 🌐 Online / Public VMs

### Hardened-Single-RHEL9-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🐧 Red Hat Enterprice Linux - 9.x [*latest*] | ![PIP](../../assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](../../assets/svg/vnet.svg) VNET |
| ![Version](https://img.shields.io/badge/Version-1.0.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com)| ![NIC](../../assets/svg/nic.svg) Network Interface |
|   | ![NSG](../../assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](../../assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL9-VM-Public.json)

---

## 🏢 Corp / Private VMs

### Hardened-Single-RHEL9-VM-Private

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🐧 Red Hat Enterprice Linux - 9.x [*latest*] | keine Public IP |
| Region: Germany West Central | ![VNET](../../assets/svg/vnet.svg) VNET |
|![Version](https://img.shields.io/badge/Version-1.0.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com)  | ![NIC](../../assets/svg/nic.svg) Network Interface |
|  | ![NSG](../../assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](../../assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL9-VM-Private.json)

---

## 🛡️ Security Recommendations

Nach der Bereitstellung können je nach Umgebung zusätzliche Sicherheitsempfehlungen erscheinen.  
Diese Empfehlungen müssen zentral auf Subscription-, Defender- oder Policy-Ebene umgesetzt werden.

### Übersicht

| **Type** | **Empfehlung** |
|----------|----------------|
| General | Azure Backup should be enabled for virtual machine |
| Defender | Only approved VM extensions should be installed |
| Defender | Machines should have vulnerability findings resolved |
| Defender | EDR solution should be installed on Virtual Machines |
| Policy | Guest Attestation extension should be installed on supported Linux virtual machines |
| Policy | Audit flow logs configuration for every virtual network |

---

### General

#### Azure Backup should be enabled for virtual machines

Für den Schutz vor Datenverlust sollte ein [Azure Backup](https://learn.microsoft.com/en-us/azure/backup/backup-overview) über einen Recovery Services Vault konfiguriert werden.
Dazu die VM einem vorhandenen oder neuen Vault zuweisen und eine passende Backup Policy auswählen.
Die Sicherung wird anschließend automatisch gemäß der Policy durchgeführt.
Nicht benötigte Systeme oder kurzfristige Test-VMs können in Defender for Cloud als ausgenommen (exempted) markiert werden.

---

### Defender

#### Only approved VM extensions should be installed

CustomScriptExtension-OSConfig Erweiterungen kann nach dem Deployment entfernen werden:

- VM → **Extensions** → *CustomScriptExtension-OSConfig* → **Uninstall**

Weitere gewünschte Extensions können in Defender als „Approved“ markiert werden.

### Machines should have vulnerability findings resolved

Für die Erkennung von Schwachstellen ist ein [Vulnerability Assessment](https://learn.microsoft.com/en-us/azure/defender-for-cloud/auto-deploy-vulnerability-assessment)
-Tool erforderlich, das regelmäßig Sicherheitslücken auf der VM identifiziert.
In Defender for Servers Plan 1 oder 2 ist der Microsoft Defender Vulnerability Assessment Scanner bereits enthalten und kann über Defender for Cloud → Empfehlungen automatisch bereitgestellt werden.
Gefundene Schwachstellen sollten zeitnah bewertet und behoben werden, um unbefugten Zugriff, Datenverlust oder Systemausfälle zu verhindern.
Nicht relevante Systeme (z. B. Test- oder isolierte Umgebungen) können in Defender for Cloud als ausgenommen (exempted) markiert werden.

Es ist mindestens [Defender for Servers Plan 1](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-servers-overview#plan-protection-features) erforderlich.

#### EDR solution should be installed on Virtual Machines

Für die Bereitstellung und automatische Registrierung des EDR-Agents ist mindestens [Defender for Servers Plan 1](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-servers-overview#plan-protection-features) erforderlich.
Der Microsoft Defender for Endpoint-Agent (EDR) wird bei aktivem Plan 1 auf unterstützten Betriebssystemen automatisch installiert und konfiguriert.
Nicht unterstützte oder manuell verwaltete Systeme müssen ggf. manuell onboarded oder in Defender for Cloud entsprechend ausgenommen (exempted) werden.

---

### Policy

### Guest Attestation extension should be installed on supported Linux virtual machines

Für die Überprüfung der Boot-Integrität ist die Installation der Guest Attestation Extension erforderlich.
Diese wird nicht automatisch auf Linux-VMs installiert und muss über Microsoft Defender for Cloud aktiviert werden.
Die automatische Bereitstellung erfolgt, wenn in den Defender for Cloud Einstellungen unter
Defender-Pläne → Servers → Settings → Auto-Provisioning
die Option „Enable Guest Attestation extension on supported Linux machines“ aktiviert ist.
Nur Trusted Launch- oder Confidential Linux-VMs unterstützen diese Erweiterung; andere Systeme können in Defender for Cloud entsprechend ausgenommen (exempted) werden.

Es ist mindestens [Defender for Servers Plan 1](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-servers-overview#plan-protection-features) erforderlich.

#### Audit flow logs configuration for every virtual network

Für eine vollständige Überwachung des Netzwerkverkehrs sollten [NSG Flow Logs](https://learn.microsoft.com/en-us/azure/network-watcher/nsg-flow-logs-overview) aktiviert werden.
Dazu muss zunächst der Network Watcher in der jeweiligen Region aktiviert sein.
Anschließend die NSG Flow Logs auf den relevanten Network Security Groups (NSGs) aktivieren und die Protokolle an einen Storage Account oder Log Analytics Workspace senden.
Die Flow Logs ermöglichen eine detaillierte Analyse des ein- und ausgehenden Datenverkehrs und unterstützen bei der Erkennung verdächtiger Aktivitäten.

---

## ⚙️ Anforderungen

Damit die Templates fehlerfrei deployen, müssen folgende Features in der Subscription aktiviert sein:

- Microsoft.Compute  
- Microsoft.Network  
- Microsoft.Storage  
- Microsoft.Insights  

Empfohlen:

- Network Watcher (für Flow Logs)
- Recovery Services Vault (für Backups)
- Azure Policy Assignments für Defender Baselines
- Defender for Servers Plan 1 (Für Guest Attestation, Vulnerability & EDR)

---

## 📝 Lizenz & Haftung

Diese Templates werden ohne Gewähr bereitgestellt.  
Sie sind als Grundlage für eigene Deployments gedacht und sollten vor produktivem Einsatz an individuelle Compliance- und Sicherheitsanforderungen angepasst werden.  
👉 [LICENSE](../../LICENSE)

---
