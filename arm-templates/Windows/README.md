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

> [!NOTE]  
> Die Baseline ist für **Windows Server 2025** entwickelt. Windows Server 2022 ist ab einem bestimmten Build kompatibel, wurde jedoch bislang nur für die Installation, nicht aber für alle Security Settings von uns getestet.

---

## 🌐 Online / Public VMs

### Harded-Single-WS25-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| Windows Server 2025 - Gen. 2 [*latest*] | ![PIP](../../assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](../../assets/svg/vnet.svg) VNET |
| ![Version](https://img.shields.io/badge/Version-0.0.9-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com)| ![NIC](../../assets/svg/nic.svg) Network Interface |
| ![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet) | ![NSG](../../assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](../../assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHarded-Single-WS25-VM-Public.json)

---

### Harded-Single-WS22-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| Windows Server 2022 - Gen. 2 [*latest*] | ![PIP](../../assets/svg/pip.svg) Public IP |
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
| Windows Server 2025 - Gen. 2 [*latest*] | kein Public IP |
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

Backup aktivieren über Recovery Services Vault und entsprechende Backup Policy zuweisen.

---

### Defender

#### Only approved VM extensions should be installed

CustomScriptExtension-OSConfig Erweiterungen kann nach dem Deployment entfernen werden:

- VM → **Extensions** → *CustomScriptExtension-OSConfig* → **Uninstall**

Weitere gewünschte Extensions können in Defender als „Approved“ markieren.

#### Windows Defender Exploit Guard should be enabled on machines

Exploit Guard über GPO oder MDM aktivieren. Baseline GPOs können über Security Compliance Toolkit eingebunden werden.

#### EDR configuration issues should be resolved on virtual machines

EDR-Agent (z. B. Microsoft Defender for Endpoint) korrekt onboarden und Richtlinien prüfen.

---

### Policy

#### Guest Configuration extension should be installed on machines

Wird nachträglich über Azure Policy installiert. Warnung kann erscheinen, wenn der Scan vor der automatischen Installation erfolgte.

#### Audit flow logs configuration for every virtual network

NSG Flow Logs aktivieren:

- Network Watcher aktivieren
- NSG Flow Logs konfigurieren
- Logs an Storage Account oder Log Analytics senden

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

---

## 📝 Lizenz & Haftung

Diese Templates werden ohne Gewähr bereitgestellt.  
Sie sind als Grundlage für eigene Deployments gedacht und sollten vor produktivem Einsatz an individuelle Compliance- und Sicherheitsanforderungen angepasst werden.  
👉 [LICENSE](../../LICENSE)

---
