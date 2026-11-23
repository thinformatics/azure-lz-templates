# ![VM](/assets/svg/vm.svg) Windows Hardened VMs

Die bereitgestellten VMs werden automatisch durch das Microsoft [OS Config Security Baseline](#-os-config-security-baseline)-Module und ergänzende Sicherheitsmaßnahmen gehärtet:

Es gibt immer **paarweise Templates** für den Einsatz von Windows-VMs im [Online (Public)- und Corp (Private)-Bereichen einer regulierten Azure Cloud Plattform](/README.md#grund-voraussetzung)

Es werden nur aktuelle [Gen2 Standard Windows Images](/docs/ADVICE-AND-IMAGES.md#-auswahl--verwendung-von-azure-standard-images) verwendet, die alle Sicherheitsfunktionen in Azure unterstützen.

---

## 📌 OS Config Security Baseline

Die Templates nutzen die **Windows OS Config Security Baseline**.
Es kann aus den drei (aus unserer Sicht) relevantesten Optionen gewählt werden: AD-MemberServer, AD-DomainController, WindowsServer-ohne-AD.
Diese Baseline wird mit dem [PowerShell-Skript](/utils/Initialize-OSConfig.ps1) nach der Bereitstellung automatisch angewendet und per Parameter im Template gesteuert.

👉 **Referenzen**  

- [Microsoft OSConfig Overview](https://learn.microsoft.com/de-de/windows-server/security/osconfig/osconfig-overview)  
- [OSConfig Security Baselines konfigurieren](https://learn.microsoft.com/en-us/windows-server/security/osconfig/osconfig-how-to-configure-security-baselines)  
- [PowerShell Gallery – Microsoft.OSConfig](https://www.powershellgallery.com/packages/Microsoft.OSConfig)

> [!NOTE]
> Eine vollständige Übersicht aller verfügbaren Baselines und deren Inhalte finden Sie im offiziellen [OS Config-Repository auf GitHub](https://github.com/microsoft/osconfig/tree/main/security/ws2025).

> [!NOTE]
> **Hotpatching** (Updates ohne Neustart) wird von Azure nur für *Azure Edition*-Images unterstützt und ist daher nur im Template *Hardened-Single-WS25-VM-Public* aktiv.

---

## 🌐 Online / Public VMs

### Hardened-Single-WS25-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🪟 Windows Server 2025 Datacenter Azure Edition - Gen2 [*latest*] (Hotpatching) | ![PIP](/assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) VNET (Ausgang über Public IP) |
| ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) | ![NIC](/assets/svg/nic.svg) Network Interface (Accelerated Networking) |
| [![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet)](/README.md#sicherheits--und-compliance) | ![NSG](/assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHardened-Single-WS25-VM-Public.json)  
👉 [Empfohlene Nacharbeiten](#-nacharbeiten)

---

## 🏢 Corp / Private VMs

### Hardened-Single-WS25-VM-Private

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🪟 Windows Server 2025 - Gen2 [*latest*] | keine Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) Bestehendes Subnetz (`existing`) *oder* neues VNET (`new`) |
| ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) | ![NIC](/assets/svg/nic.svg) Network Interface (Accelerated Networking) |
| [![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet)](/README.md#sicherheits--und-compliance) | ![NSG](/assets/svg/nsg.svg) Network Security Group (nur `new` bzw. optional) |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHardened-Single-WS25-VM-Private.json)  
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
4. Die Erweiterung **CustomScriptExtension-OSConfig** auswählen.  
5. Auf **Uninstall** klicken und die Deinstallation bestätigen.

> [!NOTE]  
> Bereits angewendete Sicherheitseinstellungen bleiben auf der VM bestehen. Die Entfernung betrifft nur die Erweiterung selbst.

---

## 📘 Hinweise zur Security & Compliance im Azure Portal nach der Bereitstellung

> [!NOTE]
> Es kann bis zu 24 Stunden dauern, bis Compliance- und Sicherheitshinweise und Empfehlungen im Azure Portal angezeigt werden!

Folgende Hinweise und Empfehlungen werden nach der Bereitstellung der VM angezeigt und werden vom Template nicht aufgelöst.

| **Type**     |  **Hinweis/Empfehlung**  | **Kurzbeschreibung**  |
|--------------|--------------------------|-----------------------|
| General      | [Azure Backup should be enabled for virtual machine](/docs/ADVICE-AND-IMAGES.md#azure-backup-should-be-enabled-for-virtual-machines) | VMs über einen Recovery Services Vault sichern |
| General      | [Only approved VM extensions should be installed](/docs/ADVICE-AND-IMAGES.md#only-approved-vm-extensions-should-be-installed)* | Nur geprüfte und genehmigte Erweiterungen zulassen |
| General      | [Audit flow logs configuration for every virtual network](/docs/ADVICE-AND-IMAGES.md#audit-flow-logs-configuration-for-every-virtual-network)* | Netzwerk-Flow-Logs aktivieren, um Datenverkehr zu überwachen |
| 🪟Windows   | [Windows Defender Exploit Guard should be enabled on machines](/docs/ADVICE-AND-IMAGES.md#windows-defender-exploit-guard-should-be-enabled-on-machines)* | Exploit Guard aktivieren, um Angriffe proaktiv zu blockieren |
| 🪟Windows   | [EDR configuration issues should be resolved on virtual machines](/docs/ADVICE-AND-IMAGES.md#edr-configuration-issues-should-be-resolved-on-virtual-machines)* | EDR-Agent über Defender for Servers Plan 1 oder höher bereitstellen |
| 🪟Windows   | [Guest Configuration extension should be installed on machines](/docs/ADVICE-AND-IMAGES.md#guest-configuration-extension-should-be-installed-on-machines)* | Guest Configuration-Erweiterung für Policy-Compliance aktivieren |

*Können durch Azure-Richtlinien (und der Verwendung des Azure Accelerators) automatisch und zentral angewandt werden!

Alle für virtuelle Maschinen relevanten Sicherheitsanforderungen – wie **Trusted Launch**, **Secure Boot**, **vTPM**, **Encryption at Host** und die Einhaltung der Microsoft-Sicherheitsrichtlinien – werden durch dieses Template aber berücksichtigt und automatisch umgesetzt.

👉 Weitere Informationen zu den Empfehlungen und deren Hintergründen findest du in der zentralen [Advice & Images Dokumentation](/docs/ADVICE-AND-IMAGES.md).

---

## ⚙️ Anforderungen

Damit die Templates fehlerfrei bereitgestellt werden können, müssen folgende **Resource Provider** in der Subscription aktiviert sein:

- Microsoft.Compute  
- Microsoft.Network  
- Microsoft.Storage  
- Microsoft.Insights  
- Microsoft.GuestConfiguration  

Zusätzlich muss das Feature **Encryption at Host** registriert sein: `az feature register --namespace Microsoft.Compute --name EncryptionAtHost`

---

## 📝 Lizenz & Haftung

Diese Templates werden ohne Gewähr bereitgestellt.  
Sie sind als Grundlage für eigene Deployments gedacht und sollten vor produktivem Einsatz an individuelle Compliance- und Sicherheitsanforderungen angepasst werden.  
👉 [LICENSE](/LICENSE)

---
