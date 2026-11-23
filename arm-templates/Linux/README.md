# ![VM](../../assets/svg/vm.svg) Linux Hardened VMs

Die bereitgestellten VMs werden automatisch durch eine [Linux Security Baseline](#-linux-security-baseline) und ergänzende Sicherheitsmaßnahmen gehärtet:

Es gibt immer **paarweise Templates** für den Einsatz von Linux-VMs im [Online (Public)- und Corp (Private)-Bereichen einer regulierten Azure Cloud Plattform](/README.md#grund-voraussetzung)

Es werden nur aktuelle [Gen2 Standard Linux Images](/docs/ADVICE-AND-IMAGES.md#-auswahl--verwendung-von-azure-standard-images) verwendet, die alle Sicherheitsfunktionen in Azure unterstützen.

---

## 📌 Linux Security Baseline

Die ARM Templates wenden nach der Bereitstellung automatisiert eine Security Baseline an. Das Profil wird über den Template-Parameter `ssgProfile` gesteuert.

| Distribution | Werkzeug | Skript | Profile (Auswahl) |
|--------------|----------|--------|-------------------|
| Red Hat Enterprise Linux 9 | OpenSCAP + SCAP Security Guide (SSG) | [rhel9-ssg-apply.sh](/utils/rhel9-ssg-apply.sh) | CIS, BSI, STIG, ACSC, ANSSI, PCI-DSS, HIPAA |
| Red Hat Enterprise Linux 10 | OpenSCAP + SCAP Security Guide (SSG) | [rhel10-ssg-apply.sh](/utils/rhel10-ssg-apply.sh) | wie RHEL 9 – das Skript prüft, ob das Profil im RHEL-10-Datastream enthalten ist |
| Ubuntu 24.04 / 26.04 LTS Pro | Ubuntu Security Guide (USG) | [ubuntu-usg-apply.sh](/utils/ubuntu-usg-apply.sh) | 24.04: CIS Level 1/2 (Server/Workstation), DISA-STIG<br>26.04: ⚠️ aktuell keine Profile verfügbar |

Für Ubuntu wird der **Ubuntu Security Guide (USG)** verwendet – das offizielle Canonical-Werkzeug für CIS und DISA-STIG. USG ist Bestandteil von **Ubuntu Pro**; die Templates nutzen deshalb das `ubuntu-pro`-Image, das sich in Azure automatisch an Ubuntu Pro anbindet.

👉 **Referenzen**  

- [OpenSCAP Project](https://www.open-scap.org/)  
- [Red Hat Security Hardening Guide (RHEL 9)](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/security_hardening/)  
- [Red Hat Security Hardening Guide (RHEL 10)](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/security_hardening/)  
- [SCAP Security Guide (ComplianceAsCode)](https://github.com/ComplianceAsCode/content)
- [Ubuntu Security Guide (USG)](https://documentation.ubuntu.com/security/compliance/usg/)

> [!NOTE]
> Eine vollständige Übersicht aller SSG-Profile ist auf der offiziellen Seite des [SCAP Security Guide (ComplianceAsCode)](https://complianceascode.github.io/content-pages/guides/index.html) einsehbar.
> Nach der Remediation wird ein Systemneustart empfohlen, um alle Maßnahmen vollständig zu übernehmen. Reports liegen unter `/var/tmp/ssg-*` (RHEL) bzw. `/var/tmp/usg-*` (Ubuntu), eine Zusammenfassung unter `/etc/ssg-remediation-info`.

---

## 🌐 Online / Public VMs

### Hardened-Single-RHEL10-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🐧 Red Hat Enterprise Linux - 10.x [*latest*] | ![PIP](/assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) VNET (Ausgang über Public IP) |
| ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) | ![NIC](/assets/svg/nic.svg) Network Interface (Accelerated Networking) |
| [![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet)](/README.md#sicherheits--und-compliance) | ![NSG](/assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL10-VM-Public.json)  
👉 [Empfohlene Nacharbeiten](#-nacharbeiten)

### Hardened-Single-RHEL9-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🐧 Red Hat Enterprise Linux - 9.x [*latest*] | ![PIP](/assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) VNET (Ausgang über Public IP) |
| ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) | ![NIC](/assets/svg/nic.svg) Network Interface (Accelerated Networking) |
| [![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet)](/README.md#sicherheits--und-compliance) | ![NSG](/assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL9-VM-Public.json)  
👉 [Empfohlene Nacharbeiten](#-nacharbeiten)

### Hardened-Single-Ubuntu2604-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🐧 Ubuntu 26.04 LTS Pro [*latest*] | ![PIP](/assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) VNET (Ausgang über Public IP) |
| ![Work in Progress](https://img.shields.io/badge/status-Work%20in%20Progress-yellow) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) | ![NIC](/assets/svg/nic.svg) Network Interface (Accelerated Networking) |
| [![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet)](/README.md#sicherheits--und-compliance) | ![NSG](/assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FUbuntu%2FHardened-Single-Ubuntu2604-VM-Public.json)  
👉 [Empfohlene Nacharbeiten](#-nacharbeiten)

> [!WARNING]
> **Aktuell keine Härtungsprofile verfügbar.** Für Ubuntu 26.04 gibt es derzeit weder im Ubuntu Security Guide (USG) noch im SCAP Security Guide (SSG) CIS- oder STIG-Profile. Ein Deployment schlägt deshalb bei der Härtung fehl.
> Das Template bleibt als *Work in Progress* erhalten, bis Canonical bzw. ComplianceAsCode Profile für 26.04 liefert. Für produktive Ubuntu-VMs bitte **Ubuntu 24.04** verwenden.

### Hardened-Single-Ubuntu24-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🐧 Ubuntu 24.04 LTS Pro [*latest*] | ![PIP](/assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) VNET (Ausgang über Public IP) |
| ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) | ![NIC](/assets/svg/nic.svg) Network Interface (Accelerated Networking) |
| [![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet)](/README.md#sicherheits--und-compliance) | ![NSG](/assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FUbuntu%2FHardened-Single-Ubuntu24-VM-Public.json)  
👉 [Empfohlene Nacharbeiten](#-nacharbeiten)
---

## 🏢 Corp / Private VMs

### Hardened-Single-RHEL10-VM-Private

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🐧 Red Hat Enterprise Linux - 10.x [*latest*] | keine Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) Bestehendes Subnetz (`existing`) *oder* neues VNET (`new`) |
| ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) | ![NIC](/assets/svg/nic.svg) Network Interface (Accelerated Networking) |
| [![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet)](/README.md#sicherheits--und-compliance) | ![NSG](/assets/svg/nsg.svg) Network Security Group (nur `new` bzw. optional) |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL10-VM-Private.json)  
👉 [Empfohlene Nacharbeiten](#-nacharbeiten)

> [!TIP]
> Netzwerk-Modi und Abschalten des Standard-Internetzugangs: [Netzwerk](/README.md#netzwerk)

### Hardened-Single-RHEL9-VM-Private

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🐧 Red Hat Enterprise Linux - 9.x [*latest*] | keine Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) Bestehendes Subnetz (`existing`) *oder* neues VNET (`new`) |
| ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) | ![NIC](/assets/svg/nic.svg) Network Interface (Accelerated Networking) |
| [![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet)](/README.md#sicherheits--und-compliance) | ![NSG](/assets/svg/nsg.svg) Network Security Group (nur `new` bzw. optional) |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL9-VM-Private.json)  
👉 [Empfohlene Nacharbeiten](#-nacharbeiten)

> [!TIP]
> Netzwerk-Modi und Abschalten des Standard-Internetzugangs: [Netzwerk](/README.md#netzwerk)

### Hardened-Single-Ubuntu2604-VM-Private

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🐧 Ubuntu 26.04 LTS Pro [*latest*] | keine Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) Bestehendes Subnetz (`existing`) *oder* neues VNET (`new`) |
| ![Work in Progress](https://img.shields.io/badge/status-Work%20in%20Progress-yellow) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) | ![NIC](/assets/svg/nic.svg) Network Interface (Accelerated Networking) |
| [![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet)](/README.md#sicherheits--und-compliance) | ![NSG](/assets/svg/nsg.svg) Network Security Group (nur `new` bzw. optional) |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FUbuntu%2FHardened-Single-Ubuntu2604-VM-Private.json)  
👉 [Empfohlene Nacharbeiten](#-nacharbeiten)

> [!TIP]
> Netzwerk-Modi und Abschalten des Standard-Internetzugangs: [Netzwerk](/README.md#netzwerk)

> [!WARNING]
> **Aktuell keine Härtungsprofile verfügbar.** Für Ubuntu 26.04 gibt es derzeit weder im Ubuntu Security Guide (USG) noch im SCAP Security Guide (SSG) CIS- oder STIG-Profile. Ein Deployment schlägt deshalb bei der Härtung fehl.
> Das Template bleibt als *Work in Progress* erhalten, bis Canonical bzw. ComplianceAsCode Profile für 26.04 liefert. Für produktive Ubuntu-VMs bitte **Ubuntu 24.04** verwenden.

### Hardened-Single-Ubuntu24-VM-Private

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🐧 Ubuntu 24.04 LTS Pro [*latest*] | keine Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) Bestehendes Subnetz (`existing`) *oder* neues VNET (`new`) |
| ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) | ![NIC](/assets/svg/nic.svg) Network Interface (Accelerated Networking) |
| [![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet)](/README.md#sicherheits--und-compliance) | ![NSG](/assets/svg/nsg.svg) Network Security Group (nur `new` bzw. optional) |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FUbuntu%2FHardened-Single-Ubuntu24-VM-Private.json)  
👉 [Empfohlene Nacharbeiten](#-nacharbeiten)

> [!TIP]
> Netzwerk-Modi und Abschalten des Standard-Internetzugangs: [Netzwerk](/README.md#netzwerk)
---

## 🔧 Nacharbeiten

### CustomScriptExtension nach der Bereitstellung entfernen

Die Azure **CustomScriptExtension** wird während der Bereitstellung verwendet (hierbei handelt es sich um eine VM-Erweiterung), um die Maßnahmen zur Härtung der VM zu realisieren.  
Nach erfolgreicher Konfiguration wird die Erweiterung **nicht mehr benötigt** und sollte aufgrund von Empfehlungen von Microsoft (Azure Richtlinien) aufgelöst werden.

**Vorgehen:**

1. Im **[Azure-Portal](https://portal.azure.com)** anmelden.  
2. Zur betreffenden **virtuellen Maschine (VM)** navigieren.  
3. In der linken Seitenleiste **Extensions + applications** öffnen.  
4. Die Erweiterung **CustomScriptExtension-Linux** auswählen.  
5. Auf **Uninstall** klicken und die Deinstallation bestätigen.

> [!NOTE]  
> Bereits angewendete Sicherheitseinstellungen bleiben auf der VM bestehen. Die Entfernung betrifft nur die Erweiterung selbst.

---

## 📘 Hinweise zur Security & Compliance im Azure Portal nach der Bereitstellung

> [!NOTE]
> Es kann bis zu 24 Stunden dauern, bis Compliance- und Sicherheitshinweise und Empfehlungen im Azure Portal angezeigt werden!

Folgende Hinweise und Empfehlungen werden nach der Bereitstellung der VM angezeigt und werden vom Template nicht aufgelöst.

| **Type**      |  **Empfehlung**  | **Kurzbeschreibung**  |
|---------------|------------------|-----------------------|
| General       | [Azure Backup should be enabled for virtual machine](/docs/ADVICE-AND-IMAGES.md#azure-backup-should-be-enabled-for-virtual-machines) | VMs über einen Recovery Services Vault sichern |
| General       | [Only approved VM extensions should be installed](/docs/ADVICE-AND-IMAGES.md#only-approved-vm-extensions-should-be-installed)* | Nur geprüfte und genehmigte Erweiterungen zulassen |
| General       | [Audit flow logs configuration for every virtual network](/docs/ADVICE-AND-IMAGES.md#audit-flow-logs-configuration-for-every-virtual-network)* | Netzwerk-Flow-Logs aktivieren, um Datenverkehr zu überwachen |
| 🐧Linux      | [Machines should have vulnerability findings resolved](/docs/ADVICE-AND-IMAGES.md#machines-should-have-vulnerability-findings-resolved)* | Schwachstellen auf VMs regelmäßig prüfen und beheben |
| 🐧Linux      | [EDR solution should be installed on Virtual Machines](/docs/ADVICE-AND-IMAGES.md#edr-solution-should-be-installed-on-virtual-machines)* | Endpoint Detection & Response-Agent installieren (z. B. Defender for Servers)|

*Können durch Azure-Richtlinien (und der Verwendung des Azure Accelerators) automatisch und zentral angewandt werden!

Alle für virtuelle Maschinen relevanten Sicherheitsanforderungen – wie **Trusted Launch**, **Secure Boot**, **vTPM**, **Encryption at Host** und die Einhaltung der Microsoft-Sicherheitsrichtlinien – werden durch dieses Template aber berücksichtigt und automatisch umgesetzt.


👉 Weitere Informationen zu den Empfehlungen und deren Hintergründen findest du in der zentralen [Advice & Images Dokumentation](/docs/ADVICE-AND-IMAGES.md).

---

## ⚙️ Anforderungen

Damit die Templates fehlerfrei bereitgestellt werden können, müssen folgende **Resource Provider** in der Subscription registriert sein:

- Microsoft.Compute  
- Microsoft.Network  
- Microsoft.Storage  
- Microsoft.Insights  

Zusätzlich muss das Feature **Encryption at Host** registriert sein: `az feature register --namespace Microsoft.Compute --name EncryptionAtHost`

---

## 📝 Lizenz & Haftung

Diese Templates werden ohne Gewähr bereitgestellt.  
Sie sind als Grundlage für eine eigene und automatisierte Bereitstellung gedacht und sollten vor produktivem Einsatz an individuelle Compliance- und Sicherheitsanforderungen angepasst werden.
👉 [LICENSE](/LICENSE)

---
