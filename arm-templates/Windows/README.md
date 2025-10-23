# ![VM](/assets/svg/vm.svg) Windows Hardened VMs

Die bereitgestellten VMs werden automatisch druch das Microsoft [OS Config Security Baseline](#-os-config-security-baseline)-Module und ergänzde Sicherheitsmaßnahmen gehärtet:

Es gibt immer **paar Weise Templates** für den den Einsatz von Windows-VMs im [Online (Public)- und Corp (Private)-Bereichen einer regulierten Azure Cloud Plattform](/README.md#landingzones-concept-cloud-adoption-framework) 

Es werden nur aktuelle [Gen2 Standard Windows Images](#-auswahl--verwendung-von-azure-standard-images) verwendet die alle Sicherheitsfunktionen in Azure untersützen.

---

## 📌 OS Config Security Baseline

Die Templates nutzen die **Windows OS Config Security Baseline**.
Es kann aus den drei (aus unserer Sicht) relevantesten Optionen gewählt werden: AD-MemberServer, AD-DomainController, WindowsServer-ohne-AD.
Diese Baseline wird mit dem [PowerShell-Skript](/utils/Initialize-OSConfig.ps1) nach der Bereitstellung automatisch angewendet und per Parameter im Templates gesteuert.

👉 **Referenzen**  

- [Microsoft OSConfig Overview](https://learn.microsoft.com/de-de/windows-server/security/osconfig/osconfig-overview)  
- [OSConfig Security Baselines konfigurieren](https://learn.microsoft.com/en-us/windows-server/security/osconfig/osconfig-how-to-configure-security-baselines)  
- [PowerShell Gallery – Microsoft.OSConfig](https://www.powershellgallery.com/packages/Microsoft.OSConfig)

> [!NOTE]
> Eine vollständige Übersicht aller verfügbaren Baselines und deren Inhalte finden Sie im offiziellen [OS Config-Repository auf GitHub](https://github.com/microsoft/osconfig/tree/main/security/ws2025).

---

## 🌐 Online / Public VMs

### Harded-Single-WS25-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🪟 Windows Server 2025 - Gen2 [*latest*] | ![PIP](/assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) VNET |
| ![Version](https://img.shields.io/badge/Version-0.0.9-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com)| ![NIC](/assets/svg/nic.svg) Network Interface |
| ![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet) | ![NSG](/assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHarded-Single-WS25-VM-Public.json)  
👉 [Empfholene Nacharbeiten](#-nacharbeiten)

<details>
  <summary>Windows Server 2022</summary>

---

### Harded-Single-WS22-VM-Public

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🪟 Windows Server 2022 - Gen2 [*latest*] | ![PIP](/assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) VNET |
|  ![Version](https://img.shields.io/badge/Version-0.0.9-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com)| ![NIC](/assets/svg/nic.svg) Network Interface |
|  | ![NSG](/assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](./assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHarded-Single-WS22-VM-Public.json)  
👉 [Empfholene Nacharbeiten](#-nacharbeiten)

> [!NOTE]
> OS Config Baselines sind für Windows Server 2025 ausgelegt. Auch auf neuste Versionen von Windows Server 2022 lassen sich die Sicherheits-Baselines erfolgreich anwenden - der Schwerpunkt unserer Optimierung liegt jedoch auf Windows Server 2025.

</details>

---
![Version](https://img.shields.io/badge/Version-1.0.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#vorbereitung-auf-cis--iso-27001) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#vorbereitung-auf-cis--iso-27001)
## 🏢 Corp / Private VMs

### Harded-Single-WS25-VM-Private

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🪟 Windows Server 2025 - Gen2 [*latest*] | keine Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) VNET |
|![Version](https://img.shields.io/badge/Version-0.0.9-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com)  | ![NIC](/assets/svg/nic.svg) Network Interface |
|   | ![NSG](/assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHarded-Single-WS25-VM-Private.json)  
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

## Hinweise zur Security & Compliance im Azure Portal nach der Bereistellung

> [!NOTE]
> Es kann bis zu 24 Stunden dauern, bis Compliance- und Sicherheitshinweis und Empfehlungen im Azure Portal angezeigt werden!

Alle für virtuelle Maschinen relevanten Sicherheitsanforderungen – wie **Trusted Launch**, **Secure Boot**, **vTPM**, **Encryption at Host** und die Einhaltung der Microsoft-Sicherheitsrichtlinien – werden durch dieses Template bereits berücksichtigt und automatisch umgesetzt.

### Übersicht

| **Type**  |  **Hinweis/Empfehlung**  | **Kurzbeschreibung**  |
|-----------|------------------|-----------------------|
| General   | [Azure Backup should be enabled for virtual machine](#azure-backup-should-be-enabled-for-virtual-machines) | VMs über einen Recovery Services Vault sichern |
| Defender  | [Only approved VM extensions should be installed](#only-approved-vm-extensions-should-be-installed) | Nur geprüfte und genehmigte Erweiterungen zulassen |
| Defender  | [Windows Defender Exploit Guard should be enabled on machines](#windows-defender-exploit-guard-should-be-enabled-on-machines) | Exploit Guard aktivieren, um Angriffe proaktiv zu blockieren |
| Defender  | [EDR configuration issues should be resolved on virtual machines](#edr-configuration-issues-should-be-resolved-on-virtual-machines) | EDR-Agent über Defender for Servers Plan 1 oder höher bereitstellen |
| Policy    | [Guest Configuration extension should be installed on machines](#guest-configuration-extension-should-be-installed-on-machines) | Guest Configuration-Erweiterung für Policy-Compliance aktivieren |
| Policy    | [Audit flow logs configuration for every virtual network](#audit-flow-logs-configuration-for-every-virtual-network) | Netzwerk-Flow-Logs aktivieren, um Datenverkehr zu überwachen |


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

Die Richtlinie **„Only approved VM extensions should be installed“** stellt sicher, dass auf virtuellen Maschinen nur **freigegebene und geprüfte Erweiterungen** installiert werden.  
Dies betrifft auch die **standardmäßig von Azure bereitgestellten Extensions** (z. B. für Windows- oder Linux-Policies), sofern sie nicht bereits als *Approved* markiert wurden.  
Nicht genehmigte oder unbekannte Erweiterungen können potenzielle Sicherheitsrisiken darstellen und sollten daher überprüft oder ausgeschlossen werden.

In **Microsoft Defender for Cloud** können Erweiterungen, die bewusst eingesetzt und als sicher bewertet wurden, als **„Approved“** markiert werden.  
Dadurch werden sie künftig **nicht mehr als Sicherheitsabweichung** gemeldet und gelten als freigegeben.

**Vorgehen:**

1. Im **[Azure-Portal](https://portal.azure.com)** anmelden.  
2. In der oberen Suchleiste nach **„Defender for Cloud“** suchen und öffnen.  
3. Unter **Environment settings** das betreffende **Subscription** auswählen.  
4. Zu **Security policy** → **Defender plans** → **Extensions** navigieren.  
5. In der Liste der Erweiterungen die gewünschte Extension auswählen.  
6. **Mark as approved** wählen und die Änderung speichern.

### Windows Defender Exploit Guard should be enabled on machines

Der **Windows Defender Exploit Guard** schützt Server aktiv vor modernen Angriffsformen, indem potenzielle Exploits und verdächtige Aktivitäten bereits **vor einer Kompromittierung** erkannt und blockiert werden.  
Er bildet einen zentralen Bestandteil der **Microsoft Sicherheitsarchitektur** und ergänzt bestehende Schutzmechanismen um präventive Verteidigungsebenen.

Mit der Aktivierung des Exploit Guard schaffen Unternehmen die Grundlage für einen **proaktiven, mehrschichtigen Sicherheitsansatz**, wie er in regulierten Azure-Umgebungen oder nach dem **Cloud Adoption Framework (CAF)** vorgesehen ist.  
Er bietet nicht nur Schutz, sondern auch Nachvollziehbarkeit und Compliance-Sicherheit – ein entscheidender Faktor für geprüfte Cloud-Infrastrukturen.

**Empfohlene Umsetzung:**

1. **Zentrale Aktivierung über Gruppenrichtlinie (GPO) oder MDM (Intune):**  
   Der Exploit Guard kann komfortabel über bestehende Verwaltungsstrukturen ausgerollt werden.  
   So profitieren alle Systeme von einer einheitlichen, unternehmensweiten Sicherheitskonfiguration – ohne manuellen Aufwand pro Server.

2. **Einsatz empfohlener Microsoft Security Baselines:**  
   Über das  
   [**Microsoft Security Compliance Toolkit**](https://learn.microsoft.com/en-us/windows/security/threat-protection/windows-security-baselines)  
   lassen sich geprüfte Baseline-Gruppenrichtlinien direkt einbinden.  
   Diese Best Practices sind die ideale Grundlage, um Exploit Guard gemäß Microsoft-Empfehlung zu implementieren.

3. **Überwachung und Compliance in Defender for Cloud:**  
   Der aktuelle Status wird automatisch durch **Defender for Cloud** überprüft.  
   Systeme, die nicht den Sicherheitsrichtlinien entsprechen, werden sofort sichtbar – ein wichtiger Schritt für kontinuierliche Compliance-Überwachung.

#### EDR configuration issues should be resolved on virtual machines

Für die Bereitstellung und automatische Registrierung des EDR-Agents ist mindestens [Defender for Servers Plan 1](#defender-for-servers-plan-1-oder-höher) erforderlich.
Der Microsoft Defender for Endpoint-Agent (EDR) wird bei aktivem Plan 1 auf unterstützten Betriebssystemen automatisch installiert und konfiguriert.

---

### Policy

### Guest Configuration extension should be installed on machines

Die Richtlinie **„Guest Configuration extension should be installed on machines“** stellt sicher, dass die **Guest Configuration-Erweiterung** auf allen virtuellen Maschinen vorhanden ist.  
Diese Erweiterung ermöglicht es **Azure Policy**, Konfigurations- und Compliance-Prüfungen **innerhalb des Betriebssystems** durchzuführen – z. B. ob Sicherheitsrichtlinien, Benutzerrechte oder Systemkonfigurationen den Unternehmensstandards entsprechen.

In einer regulierten Azure Umgebung wird die Erweiterung **automatisch über Azure Policy** installiert.


#### Audit flow logs configuration for every virtual network

Für eine vollständige Überwachung des Netzwerkverkehrs sollten [NSG Flow Logs](https://learn.microsoft.com/en-us/azure/network-watcher/nsg-flow-logs-overview) aktiviert werden.
Dazu muss zunächst der Network Watcher in der jeweiligen Region aktiviert sein.
Anschließend die NSG Flow Logs auf den relevanten Network Security Groups (NSGs) aktivieren und die Protokolle an einen Storage Account oder Log Analytics Workspace senden.
Die Flow Logs ermöglichen eine detaillierte Analyse des ein- und ausgehenden Datenverkehrs und unterstützen bei der Erkennung verdächtiger Aktivitäten.

---

## Weitere Empfehlungen

### Defender for Servers Plan 1 oder höher

Für den vollständigen Schutz und die Umsetzung aller sicherheitsrelevanten Empfehlungen wird mindestens **Microsoft Defender for Servers Plan 1** empfohlen.  
Dieser Plan stellt sicher, dass alle sicherheitsbezogenen **Azure Policy-Überprüfungen** und **Defender for Cloud-Bewertungen** korrekt ausgeführt werden.  
In **regulierten oder bereits vorkonfigurierten Azure-Umgebungen** ist Defender for Servers in der Regel **vorausgesetzt** oder **standardmäßig integriert**, um die Einhaltung von Compliance- und Sicherheitsrichtlinien sicherzustellen.

#### **Kurz-Anleitung: Defender for Servers aktivieren**

1. Im **[Azure-Portal](https://portal.azure.com)** anmelden (Benutzerrolle: Owner/Contributor oder Security Admin).  
2. Oben in der Suchleiste **„Defender for Cloud“** suchen und öffnen.  
3. In Defender for Cloud zu **Environment settings** (oder **Pricing & settings**) navigieren.  
4. Die gewünschte **Subscription** auswählen.  
5. Unter **Defender plans / Pricing & settings** die Option **„Defender for Servers“** aktivieren und **Plan 1 (oder höher)** auswählen.  
6. Falls erforderlich, einen **Log Analytics Workspace** auswählen oder neu anlegen — dieser wird für Telemetrie, Alerts und automatische Erkennung benötigt.  
7. **Auto-Provisioning** für den Agenten (Log Analytics Agent / Azure Monitor Agent) aktivieren, damit vorhandene und neue VMs automatisch onboarded werden.  
8. Änderungen speichern und die Onboarding-Jobs überwachen (Onboarding kann einige Minuten dauern).


![Defender Plans](/assets/azure_defender_plans.png)

---

## 💽 Auswahl & Verwendung von Azure Standard-Images

Für die Bereitstellung virtueller Maschinen werden in den ARM Templates ausschließlich **aktuelle Azure Marketplace Gen2 Standard-Images** verwendet.
Diese Images werden direkt von Microsoft bereitgestellt, regelmäßig aktualisiert und enthalten die jeweils neuesten Sicherheits- und Plattformfunktionen. Dadurch wird sichergestellt, dass Systeme immer auf einer geprüften Basis laufen.

Azure setzt standardmäßig auf Generation 2 (Gen2) Images.
Diese basieren auf UEFI und unterstützen Secure Boot, vTPM und Trusted Launch - die Voraussetzung für moderne Sicherheitsmechanismen in Azure.
Generation 1 (Gen1) Images sind nur noch für Legacy-Kompatibilität verfügbar und bieten keine Unterstützung für diese Sicherheitsfeatures.

### Sicherheitsrelevante Mindestanforderungen

| Feature                                        | Beschreibung                                          |
| ---------------------------------------------- | ------------------------------------------------------|
| **Secure Boot**                                | Validiert während des Systemstarts nur signierte Bootloader und Kernel-Komponenten. Schützt den Boot-Prozess vor Manipulationen (z. B. Rootkits, Bootkits) und stellt sicher, dass ausschließlich vertrauenswürdige Software geladen wird.|
| **vTPM**                                       | Stellt einen hardwarebasierten Vertrauensanker bereit. Unterstützt Verschlüsselung mit BitLocker, Measured Boot und Integritätsprüfungen. Voraussetzung für Trusted Launch. |
| **Trusted Launch**                             | Aktiviert eine manipulationssichere Startumgebung durch Kombination von Secure Boot und vTPM. Ermöglicht die Überwachung des Bootvorgangs und Integritätsberichte über Azure Defender for Cloud.                                                                                  |
| **Encryption at Host**                         | Verschlüsselt Daten bereits auf dem physischen Host, bevor sie auf den Datenträger geschrieben werden. Ergänzt die VM- und Disk-Verschlüsselung um eine zusätzliche Schutzebene gegen unbefugten Zugriff auf Infrastrukturebene. |
| **Azure Defender & Monitoring Kompatibilität** | Volle Unterstützung für **Microsoft Defender for Cloud**, **Azure Monitor**, **Azure Policy** und **Microsoft Sentinel**. Inklusive Kompatibilität der **Azure Monitor Agent (AMA)** und **Defender Agents** zur Erfassung von Security Events, Systemmetriken und Compliance-Daten. |

---

## ⚙️ Anforderungen

Damit die Templates fehlerfrei bereitgestellt werden können, müssen folgende **Resource Provider** in der Subscription aktiviert sein:

- Microsoft.Compute  
- Microsoft.Network  
- Microsoft.Storage  
- Microsoft.Insights  
- Microsoft.GuestConfiguration  

Des Weiteren empfehlen wir die **Konfiguration und Umsetzung einer regulierten Azure-Umgebung** gemäß dem **[Cloud Adoption Framework (CAF)](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/)**.  
Dies stellt sicher, dass zentrale Sicherheits-, Governance- und Compliance-Anforderungen von Beginn an berücksichtigt und standardisiert umgesetzt werden.

---

## 📝 Lizenz & Haftung

Diese Templates werden ohne Gewähr bereitgestellt.  
Sie sind als Grundlage für eigene Deployments gedacht und sollten vor produktivem Einsatz an individuelle Compliance- und Sicherheitsanforderungen angepasst werden.  
👉 [LICENSE](/LICENSE)

---
