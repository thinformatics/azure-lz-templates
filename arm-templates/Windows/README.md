# ![VM](../../assets/svg/vm.svg) Windows Hardened VMs

ARM Templates zur automatisierten Bereitstellung von gehärteten Windows Server VMs in Azure.  
Die Templates werden mit den Microsoft OS Config Security Baselines und ergänzen Sicherheitsmaßnahmen für Online (Public) und Corp (Private) Deployments erstellt.

---

## 📌 OS Config Security Baseline

Die Templates basieren auf der **Windows OS Config Security Baseline**.  
Diese Baseline wird über unser [PowerShell-Skript](../../utils/Initialize-OSConfig.ps1) nach der Bereitstellung angewendet.  
Dadurch werden sicherheitsrelevante Betriebssystemeinstellungen automatisiert konfiguriert.

👉 **Referenzen**  

- [Microsoft OSConfig Overview](https://learn.microsoft.com/de-de/windows-server/security/osconfig/osconfig-overview)  
- [OSConfig Security Baselines konfigurieren](https://learn.microsoft.com/en-us/windows-server/security/osconfig/osconfig-how-to-configure-security-baselines)  
- [PowerShell Gallery – Microsoft.OSConfig](https://www.powershellgallery.com/packages/Microsoft.OSConfig)

---

## 🌐 Online / Public VMs

### Harded-Single-WS25-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🪟 Windows Server 2025 - Gen2 [*latest*] | ![PIP](../../assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](../../assets/svg/vnet.svg) VNET |
| ![Version](https://img.shields.io/badge/Version-0.0.9-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com)| ![NIC](../../assets/svg/nic.svg) Network Interface |
| ![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet) | ![NSG](../../assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](../../assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHarded-Single-WS25-VM-Public.json)

---

### Harded-Single-WS22-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🪟 Windows Server 2022 - Gen2 [*latest*] | ![PIP](../../assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](../../assets/svg/vnet.svg) VNET |
|  ![Version](https://img.shields.io/badge/Version-0.0.9-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com)| ![NIC](../../assets/svg/nic.svg) Network Interface |
|  | ![NSG](../../assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](../../assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHarded-Single-WS22-VM-Public.json)

---

## 🏢 Corp / Private VMs

### Harded-Single-WS25-VM-Private

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🪟 Windows Server 2025 - Gen2 [*latest*] | keine Public IP |
| Region: Germany West Central | ![VNET](../../assets/svg/vnet.svg) VNET |
|![Version](https://img.shields.io/badge/Version-0.0.9-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com)  | ![NIC](../../assets/svg/nic.svg) Network Interface |
|  | ![NSG](../../assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](../../assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHarded-Single-WS25-VM-Private.json)

---

## 🛡️ Security Recommendations

Nach der Bereitstellung können je nach Umgebung zusätzliche Sicherheitsempfehlungen erscheinen.  
Diese Empfehlungen müssen zentral auf Subscription-, Defender- oder Policy-Ebene umgesetzt werden.

### Übersicht

| **Type** | **Empfehlung** |
|----------|----------------|
| General | Azure Backup should be enabled for virtual machine |
| Defender | Only approved VM extensions should be installed |
| Defender | Windows Defender Exploit Guard should be enabled on machines |
| Defender | EDR configuration issues should be resolved on virtual machines |
| Policy | Guest Configuration extension should be installed on machines |
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

#### Windows Defender Exploit Guard should be enabled on machines

Exploit Guard über GPO oder MDM aktivieren. Baseline GPOs können über Security Compliance Toolkit eingebunden werden.

#### EDR configuration issues should be resolved on virtual machines

Für die Bereitstellung und automatische Registrierung des EDR-Agents ist mindestens [Defender for Servers Plan 1](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-servers-overview#plan-protection-features) erforderlich.
Der Microsoft Defender for Endpoint-Agent (EDR) wird bei aktivem Plan 1 auf unterstützten Betriebssystemen automatisch installiert und konfiguriert.
Nicht unterstützte oder manuell verwaltete Systeme müssen ggf. manuell onboarded oder in Defender for Cloud entsprechend ausgenommen (exempted) werden.

---

### Policy

#### Guest Configuration extension should be installed on machines

Wird nachträglich über Azure Policy installiert. (Umgebungsabhängig) Warnung kann erscheinen, wenn der Scan vor der automatischen Installation erfolgte.

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
- Microsoft.GuestConfiguration  

Empfohlen:

- Network Watcher (für Flow Logs)
- Recovery Services Vault (für Backups)
- Azure Policy Assignments für Defender Baselines
- Defender for Servers Plan 1

---

## 📝 Lizenz & Haftung

Diese Templates werden ohne Gewähr bereitgestellt.  
Sie sind als Grundlage für eigene Deployments gedacht und sollten vor produktivem Einsatz an individuelle Compliance- und Sicherheitsanforderungen angepasst werden.  
👉 [LICENSE](../../LICENSE)

---
