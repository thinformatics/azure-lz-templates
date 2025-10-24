# ![VM](../../assets/svg/vm.svg) Linux Hardened VMs

Die bereitgestellten VMs werden automatisch druch das die [OpenSCAP / SCAP Security Guide (SSG) Baseline](#-linux-security-baseline-openscap--ssg) und ergänzde Sicherheitsmaßnahmen gehärtet:

Es gibt immer **paar Weise Templates** für den den Einsatz von Windows-VMs im [Online (Public)- und Corp (Private)-Bereichen einer regulierten Azure Cloud Plattform](/README.md#grund-voraussetzung)

Es werden nur aktuelle [Gen2 Standard Linux Images](/docs/ADVICE-AND-IMAGES.md#-auswahl--verwendung-von-azure-standard-images) verwendet die alle Sicherheitsfunktionen in Azure verwendet.

---

## 📌 Linux Security Baseline (OpenSCAP / SSG)

Die ARM Templates wenden automatisiert eine Security Baseline an, welche auf dem **OpenSCAP-Framework** und den **SCAP Security Guide (SSG)**-Profilen beruht.
Es kann aus den (aus unserer Sicht) relevantesten Konfigurationsprofilen gewählt werden: CIS, ACSC, ANSSI, BSI
Die Baseline wird über das [Bash-Skript](/utils/rhel9-ssg-apply.sh) nach der Bereitstellung automatisch angewendet und per Parameter im Templates gesteuert. Dadurch werden sicherheitsrelevante System- und Konfigurationseinstellungen automatisiert gemäß dem ausgewählten Compliance-Profil umgesetzt.

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
| 🐧 Red Hat Enterprice Linux - 9.x [*latest*] | ![PIP](/assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) VNET |
| ![Version](https://img.shields.io/badge/Version-1.0.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com)| ![NIC](/assets/svg/nic.svg) Network Interface |
|   | ![NSG](/assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL9-VM-Public.json)  
👉 [Empfholene Nacharbeiten](#-nacharbeiten)

---

## 🏢 Corp / Private VMs

### Hardened-Single-RHEL9-VM-Private

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🐧 Red Hat Enterprice Linux - 9.x [*latest*] | keine Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) VNET |
|![Version](https://img.shields.io/badge/Version-1.0.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com)  | ![NIC](/assets/svg/nic.svg) Network Interface |
|  | ![NSG](/assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL9-VM-Private.json)  
👉 [Empfholene Nacharbeiten](#-nacharbeiten)

---

## 🔧 Nacharbeiten

### CustomScriptExtension nach der Bereitstellung entfernen

Die Azure **CustomScriptExtension** wird während der Bereitstellung verwendet (hierbei handelt es sich um eine VM-Erweiterung), um die Maßnahmen zur Härtung der VM zu realisieren.  
Nach erfolgreicher Konfiguration wird die Erweiterung **nicht mehr benötigt** und sollte aufgrund von Empfehlungen von Microsoft (Azure Richtlinien) aufgelöst werden.

**Vorgehen:**

1. Im **[Azure-Portal](https://portal.azure.com)** anmelden.  
2. Zur betreffenden **virtuellen Maschine (VM)** navigieren.  
3. In der linken Seitenleiste **Extensions + applications** öffnen.  
4. Die Erweiterung **CustomScriptExtension-OSConfig** auswählen.  
5. Auf **Uninstall** klicken und die Deinstallation bestätigen.

> [!NOTE]  
> Bereits angewendete Sicherheitseinstellungen bleiben auf der VM bestehen. Die Entfernung betrifft nur die Erweiterung selbst.

---

## 📘 Hinweise zur Security & Compliance im Azure Portal nach der Bereistellung

> [!NOTE]
> Es kann bis zu 24 Stunden dauern, bis Compliance- und Sicherheitshinweis und Empfehlungen im Azure Portal angezeigt werden!

Folgende Hinweise und Empfehlungen werden nach der Bereistellung der VM angezeigt und werden vom Templates nicht aufgelöst.

| **Type**      |  **Empfehlung**  | **Kurzbeschreibung**  |
|---------------|------------------|-----------------------|
| General       | [Azure Backup should be enabled for virtual machine](/docs/ADVICE-AND-IMAGES.md#azure-backup-should-be-enabled-for-virtual-machines) | VMs über einen Recovery Services Vault sichern |
| General       | [Only approved VM extensions should be installed](/docs/ADVICE-AND-IMAGES.md#only-approved-vm-extensions-should-be-installed)* | Nur geprüfte und genehmigte Erweiterungen zulassen |
| General       | [Audit flow logs configuration for every virtual network](/docs/ADVICE-AND-IMAGES.md#audit-flow-logs-configuration-for-every-virtual-network)* | Netzwerk-Flow-Logs aktivieren, um Datenverkehr zu überwachen |
| 🐧Linux      | [Machines should have vulnerability findings resolved](/docs/ADVICE-AND-IMAGES.md#machines-should-have-vulnerability-findings-resolved)* | Schwachstellen auf VMs regelmäßig prüfen und beheben |
| 🐧Linux      | [EDR solution should be installed on Virtual Machines](/docs/ADVICE-AND-IMAGES.md#edr-solution-should-be-installed-on-virtual-machines)* | Endpoint Detection & Response-Agent installieren (z. B. Defender for Servers)|
| 🐧Linux      | [Guest Attestation extension should be installed on supported Linux virtual machines](/docs/ADVICE-AND-IMAGES.md#guest-attestation-extension-should-be-installed-on-supported-linux-virtual-machines)* | Guest Attestation-Erweiterung aktivieren (TPM-/vTPM-Validierung)|

*Können durch Azure-Richtlinen (und der Verwendung des Azure Accelerators) automatisch und zentral angewandt werden!

Alle für virtuelle Maschinen relevanten Sicherheitsanforderungen – wie **Trusted Launch**, **Secure Boot**, **vTPM**, **Encryption at Host** und die Einhaltung der Microsoft-Sicherheitsrichtlinien – werden durch dieses Template aber berücksichtigt und automatisch umgesetzt.

👉 Weitere Informationen zu den Empfehlungen und deren Hintergründen findest du in der zentralen [Advice & Images Dokumentation](/docs/ADVICE-AND-IMAGES.md).

---

## ⚙️ Anforderungen

Damit die Templates fehlerfrei bereitgestellt werden können, müssen folgende Features in der Subscription aktiviert sein:

- Microsoft.Compute  
- Microsoft.Network  
- Microsoft.Storage  
- Microsoft.Insights  

---

## 📝 Lizenz & Haftung

Diese Templates werden ohne Gewähr bereitgestellt.  
Sie sind als Grundlage für eine eigene und automatisierte Bereitstellung gedacht und sollten vor produktivem Einsatz an individuelle Compliance- und Sicherheitsanforderungen angepasst werden.
👉 [LICENSE](/LICENSE)

---
