# ![VM](../../assets/svg/vm.svg) Linux Hardened VMs

ARM Templates zur automatisierten Bereitstellung von gehärteten Linux VMs in Azure.
Die ARM Templates wenden mit der gewählten [OpenSCAP / SCAP Security Guide (SSG) Baseline](#-linux-security-baseline-openscap--ssg) automatisiert bereitgestellt.
Sie sind für den Einsatz in Online (Public)- und Corp (Private)-Umgebungen im Rahmen des Landingszone Konzeptes (Cloud Adoption Framework) konzipiert und können je nach Compliance-Anforderung mit unterschiedlichen Profilen (z. B. CIS, STIG, BSI, ANSSI) betrieben werden.
Es werden nur aktuelle [Gen2 Standard Linux Images](#-auswahl--verwendung-von-azure-standard-images) verwendet die alle Sicherheitsfunktionen in Azure verwendet.

---

## 📌 Linux Security Baseline (OpenSCAP / SSG)

Die ARM Templates wenden automatisiert eine Security Baseline an, welche auf dem **OpenSCAP-Framework** und den **SCAP Security Guide (SSG)**-Profilen beruht.
Die Baseline wird über das [Bash-Skript](/utils/rhel9-ssg-apply.sh) nach der Bereitstellung automatisch angewendet.
Dadurch werden sicherheitsrelevante System- und Konfigurationseinstellungen automatisiert gemäß dem ausgewählten Compliance-Profil umgesetzt.

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

Die **CustomScriptExtension** wird während der Bereitstellung verwendet, um das Skript zur **automatischen Anwendung der gewünschten Sicherheitsbaseline** (z. B. OSConfig oder SSG-Profil) auf der VM auszuführen.  
Nach erfolgreicher Konfiguration wird die Erweiterung **nicht mehr benötigt** und kann entfernt werden, um die Angriffsfläche zu reduzieren und die Systemhärtung abzuschließen.

**Vorgehen:**

1. Im **[Azure-Portal](https://portal.azure.com)** anmelden.  
2. Zur betreffenden **virtuellen Maschine (VM)** navigieren.  
3. In der linken Seitenleiste **Extensions + applications** öffnen.  
4. Die Erweiterung **CustomScriptExtension-OSConfig** auswählen.  
5. Auf **Uninstall** klicken und die Deinstallation bestätigen.

> [!NOTE]
> Bereits angewendete Sicherheitseinstellungen bleiben auf der VM bestehen. Die Entfernung betrifft nur die Erweiterung selbst.

---

## 🛡️ Recommendations

Nach der Bereitstellung können je nach Umgebung zusätzliche Sicherheitsempfehlungen erscheinen.  
Diese Empfehlungen müssen zentral auf Subscription-, Defender- oder Policy-Ebene umgesetzt werden.

### Übersicht

| **Type**  |  **Empfehlung**  | **Kurzbeschreibung**  |
|-----------|------------------|-----------------------|
| General | [Azure Backup should be enabled for virtual machine](#azure-backup-should-be-enabled-for-virtual-machines) | |
| Defender | [Only approved VM extensions should be installed](#only-approved-vm-extensions-should-be-installed) | |
| Defender | [Machines should have vulnerability findings resolved](#machines-should-have-vulnerability-findings-resolved) | |
| Defender | [EDR solution should be installed on Virtual Machines](#edr-solution-should-be-installed-on-virtual-machines) ||
| Policy | [Guest Attestation extension should be installed on supported Linux virtual machines](#guest-attestation-extension-should-be-installed-on-supported-linux-virtual-machines) | |
| Policy | [Audit flow logs configuration for every virtual network](#audit-flow-logs-configuration-for-every-virtual-network) | |

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

> [!NOTE]
> Das Markieren einer Erweiterung als *Approved* kennzeichnet sie als vertrauenswürdig und schließt sie künftig von Warnungen in Defender for Cloud aus.

### Machines should have vulnerability findings resolved

Für die Erkennung von Schwachstellen ist ein [Vulnerability Assessment](https://learn.microsoft.com/en-us/azure/defender-for-cloud/auto-deploy-vulnerability-assessment)
-Tool erforderlich, das regelmäßig Sicherheitslücken auf der VM identifiziert.
In Defender for Servers Plan 1 oder 2 ist der Microsoft Defender Vulnerability Assessment Scanner bereits enthalten und kann über Defender for Cloud → Empfehlungen automatisch bereitgestellt werden.
Gefundene Schwachstellen sollten zeitnah bewertet und behoben werden, um unbefugten Zugriff, Datenverlust oder Systemausfälle zu verhindern.
Nicht relevante Systeme (z. B. Test- oder isolierte Umgebungen) können in Defender for Cloud als ausgenommen (exempted) markiert werden.

Es ist mindestens [Defender for Servers Plan 1](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-servers-overview#plan-protection-features) erforderlich.

#### EDR solution should be installed on Virtual Machines

Für die Bereitstellung und automatische Registrierung des EDR-Agents ist mindestens [Defender for Servers Plan 1](#defender-for-servers-plan-1-oder-höher) erforderlich.
Der Microsoft Defender for Endpoint-Agent (EDR) wird bei aktivem Plan 1 auf unterstützten Betriebssystemen automatisch installiert und konfiguriert.

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

### Audit flow logs configuration for every virtual network

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

## Weitere Recommendations

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
8. Änderungen speichern und die Onboarding-Jobs überwachen (Onboarding kann einige Minuten dauern)

---

## ⚙️ Anforderungen

Damit die Templates fehlerfrei bereitgestellt werden können, müssen folgende Features in der Subscription aktiviert sein:

- Microsoft.Compute  
- Microsoft.Network  
- Microsoft.Storage  
- Microsoft.Insights  

Des Weiteren empfehlen wir die **Konfiguration und Umsetzung einer regulierten Azure-Umgebung** gemäß dem **[Cloud Adoption Framework (CAF)](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/)**.  
Dies stellt sicher, dass zentrale Sicherheits-, Governance- und Compliance-Anforderungen von Beginn an berücksichtigt und standardisiert umgesetzt werden.

---

## 📝 Lizenz & Haftung

Diese Templates werden ohne Gewähr bereitgestellt.  
Sie sind als Grundlage für eine eigene und automatisierte Bereitstellung gedacht und sollten vor produktivem Einsatz an individuelle Compliance- und Sicherheitsanforderungen angepasst werden.
👉 [LICENSE](/LICENSE)

---
