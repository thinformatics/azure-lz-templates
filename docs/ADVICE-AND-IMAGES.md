# ADVICE AND IMAGES

Dieses Dokument bündelt alle sicherheitsrelevanten Empfehlungen und technischen Hinweise zu den bereitgestellten ARM-Templates.  
Es beschreibt die zugrunde liegende Auswahl der verwendeten OS-Images sowie die wichtigsten Azure- und Defender-Empfehlungen, die nach der Bereitstellung von Windows- und Linux-VMs auftreten können.

- [**💽 Auswahl & Verwendung von Azure Standard-Images**](#-auswahl--verwendung-von-azure-standard-images)
- [**📘 Hinweise zur Security & Compliance im Azure Portal nach der Bereitstellung**](#-hinweise-zur-security--compliance-im-azure-portal-nach-der-bereitstellung)
- [**📑 Weitere Empfehlungen**](#-weitere-empfehlungen)

## 💽 Auswahl & Verwendung von Azure Standard-Images

Für die Bereitstellung virtueller Maschinen werden in den ARM-Templates ausschließlich **aktuelle Azure Marketplace Gen2 Standard-Images** verwendet.
Diese Images werden direkt von Microsoft bereitgestellt, regelmäßig aktualisiert und enthalten die jeweils neuesten Sicherheits- und Plattformfunktionen. Dadurch wird sichergestellt, dass Systeme immer auf einer geprüften Basis laufen.

Azure setzt standardmäßig auf Generation 2 (Gen2)-Images.
Diese basieren auf UEFI und unterstützen Secure Boot, vTPM und Trusted Launch - die Voraussetzung für moderne Sicherheitsmechanismen in Azure.
Generation 1 (Gen1)-Images sind nur noch für Legacy-Kompatibilität verfügbar und bieten keine Unterstützung für diese Sicherheitsfeatures.

### Sicherheitsrelevante Mindestanforderungen

| Feature                                        | Beschreibung                                          |
| ---------------------------------------------- | ------------------------------------------------------|
| **Secure Boot**                                | Validiert während des Systemstarts nur signierte Bootloader und Kernel-Komponenten. Schützt den Boot-Prozess vor Manipulationen (z. B. Rootkits, Bootkits) und stellt sicher, dass ausschließlich vertrauenswürdige Software geladen wird.|
| **vTPM**                                       | Stellt einen hardwarebasierten Vertrauensanker bereit. Unterstützt Verschlüsselung mit BitLocker, Measured Boot und Integritätsprüfungen. Voraussetzung für Trusted Launch. |
| **Trusted Launch**                             | Aktiviert eine manipulationssichere Startumgebung durch Kombination von Secure Boot und vTPM. Ermöglicht die Überwachung des Bootvorgangs und Integritätsberichte über Azure Defender for Cloud.                                                                                  |
| **Encryption at Host**                         | Verschlüsselt Daten bereits auf dem physischen Host, bevor sie auf den Datenträger geschrieben werden. Ergänzt die VM- und Disk-Verschlüsselung um eine zusätzliche Schutzebene gegen unbefugten Zugriff auf Infrastrukturebene. |
| **Azure Defender & Monitoring Kompatibilität** | Volle Unterstützung für **Microsoft Defender for Cloud**, **Azure Monitor**, **Azure Policy** und **Microsoft Sentinel**. Inklusive Kompatibilität der **Azure Monitor Agent (AMA)** und **Defender Agents** zur Erfassung von Security Events, Systemmetriken und Compliance-Daten. |

## 📘 Hinweise zur Security & Compliance im Azure Portal nach der Bereitstellung

> [!NOTE]
> Es kann bis zu 24 Stunden dauern, bis Compliance- und Sicherheitshinweise und Empfehlungen im Azure Portal angezeigt werden!

Folgende Hinweise und Empfehlungen werden nach der Bereitstellung der VM angezeigt und werden von den Templates nicht aufgelöst.

| **Type**  |  **Hinweis/Empfehlung**  | **Kurzbeschreibung**  |
|-----------|------------------|-----------------------|
| General      | [Azure Backup should be enabled for virtual machine](#azure-backup-should-be-enabled-for-virtual-machines) | VMs über einen Recovery Services Vault sichern |
| General      | [Only approved VM extensions should be installed](#only-approved-vm-extensions-should-be-installed) | Nur geprüfte und genehmigte Erweiterungen zulassen* |
| General      | [Audit flow logs configuration for every virtual network](#audit-flow-logs-configuration-for-every-virtual-network) | Netzwerk-Flow-Logs aktivieren, um Datenverkehr zu überwachen* |
| 🪟Windows   | [Windows Defender Exploit Guard should be enabled on machines](#windows-defender-exploit-guard-should-be-enabled-on-machines) | Exploit Guard aktivieren, um Angriffe proaktiv zu blockieren* |
| 🪟Windows   | [EDR configuration issues should be resolved on virtual machines](#edr-configuration-issues-should-be-resolved-on-virtual-machines) | EDR-Agent über Defender for Servers Plan 1 oder höher bereitstellen* |
| 🪟Windows   | [Guest Configuration extension should be installed on machines](#guest-configuration-extension-should-be-installed-on-machines) | Guest Configuration-Erweiterung für Policy-Compliance aktivieren* |
| 🐧Linux     | [Machines should have vulnerability findings resolved](#machines-should-have-vulnerability-findings-resolved) | Schwachstellen auf VMs regelmäßig prüfen und beheben |
| 🐧Linux     | [EDR solution should be installed on Virtual Machines](#edr-solution-should-be-installed-on-virtual-machines) | Endpoint Detection & Response-Agent installieren (z. B. Defender for Servers)|
| 🐧Linux     | [Guest Attestation extension should be installed on supported Linux virtual machines](#guest-attestation-extension-should-be-installed-on-supported-linux-virtual-machines) | Guest Attestation-Erweiterung aktivieren (TPM-/vTPM-Validierung)|

*Können durch Azure-Richtlinen (und der Verwendung des Azure Accelerators) automatisch und zentral angewandt werden!

Alle für virtuelle Maschinen relevanten Sicherheitsanforderungen – wie **Trusted Launch**, **Secure Boot**, **vTPM**, **Encryption at Host** und die Einhaltung der Microsoft-Sicherheitsrichtlinien – werden durch dieses Template aber berücksichtigt und automatisch umgesetzt.

### General  

---

### Azure Backup should be enabled for virtual machines

Für den Schutz vor Datenverlust sollte ein [Azure Backup](https://learn.microsoft.com/en-us/azure/backup/backup-overview) über einen Recovery Services Vault konfiguriert werden.
Dazu die VM einem vorhandenen oder neuen Vault zuweisen und eine passende Backup Policy auswählen.
Die Sicherung wird anschließend automatisch gemäß der Policy durchgeführt.
Nicht benötigte Systeme oder kurzfristige Test-VMs können in Defender for Cloud als ausgenommen (exempted) markiert werden.

### Only approved VM extensions should be installed

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

### Audit flow logs configuration for every virtual network

Für eine vollständige Überwachung des Netzwerkverkehrs sollten [NSG Flow Logs](https://learn.microsoft.com/en-us/azure/network-watcher/nsg-flow-logs-overview) aktiviert werden.
Dazu muss zunächst der Network Watcher in der jeweiligen Region aktiviert sein.
Anschließend die NSG Flow Logs auf den relevanten Network Security Groups (NSGs) aktivieren und die Protokolle an einen Storage Account oder Log Analytics Workspace senden.
Die Flow Logs ermöglichen eine detaillierte Analyse des ein- und ausgehenden Datenverkehrs und unterstützen bei der Erkennung verdächtiger Aktivitäten.

### 🪟 Windows spezifisch

---

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

### EDR configuration issues should be resolved on virtual machines

Für die Bereitstellung und automatische Registrierung des EDR-Agents ist mindestens [Defender for Servers Plan 1](#defender-for-servers-plan-1-oder-höher) erforderlich.
Der Microsoft Defender for Endpoint-Agent (EDR) wird bei aktivem Plan 1 auf unterstützten Betriebssystemen automatisch installiert und konfiguriert.

### Guest Configuration extension should be installed on machines

Die Richtlinie **„Guest Configuration extension should be installed on machines“** stellt sicher, dass die **Guest Configuration-Erweiterung** auf allen virtuellen Maschinen vorhanden ist.  
Diese Erweiterung ermöglicht es **Azure Policy**, Konfigurations- und Compliance-Prüfungen **innerhalb des Betriebssystems** durchzuführen – z. B. ob Sicherheitsrichtlinien, Benutzerrechte oder Systemkonfigurationen den Unternehmensstandards entsprechen.

In einer regulierten Azure Umgebung wird die Erweiterung **automatisch über Azure Policy** installiert.

### 🐧 Linux spezifisch

---

### Machines should have vulnerability findings resolved

Für die Erkennung von Schwachstellen ist ein [Vulnerability Assessment](https://learn.microsoft.com/en-us/azure/defender-for-cloud/auto-deploy-vulnerability-assessment)
-Tool erforderlich, das regelmäßig Sicherheitslücken auf der VM identifiziert.
In Defender for Servers Plan 1 oder 2 ist der Microsoft Defender Vulnerability Assessment Scanner bereits enthalten und kann über Defender for Cloud → Empfehlungen automatisch bereitgestellt werden.
Gefundene Schwachstellen sollten zeitnah bewertet und behoben werden, um unbefugten Zugriff, Datenverlust oder Systemausfälle zu verhindern.
Nicht relevante Systeme (z. B. Test- oder isolierte Umgebungen) können in Defender for Cloud als ausgenommen (exempted) markiert werden.

Es ist mindestens [Defender for Servers Plan 1](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-servers-overview#plan-protection-features) erforderlich.

### EDR solution should be installed on Virtual Machines

Für die Bereitstellung und automatische Registrierung des EDR-Agents ist mindestens [Defender for Servers Plan 1](#defender-for-servers-plan-1-oder-höher) erforderlich.
Der Microsoft Defender for Endpoint-Agent (EDR) wird bei aktivem Plan 1 auf unterstützten Betriebssystemen automatisch installiert und konfiguriert.

### Guest Attestation extension should be installed on supported Linux virtual machines

Für die Überprüfung der Boot-Integrität ist die Installation der Guest Attestation Extension erforderlich.
Diese wird nicht automatisch auf Linux-VMs installiert und muss über Microsoft Defender for Cloud aktiviert werden.
Die automatische Bereitstellung erfolgt, wenn in den Defender for Cloud Einstellungen unter
Defender-Pläne → Servers → Settings → Auto-Provisioning
die Option „Enable Guest Attestation extension on supported Linux machines“ aktiviert ist.
Nur Trusted Launch- oder Confidential Linux-VMs unterstützen diese Erweiterung; andere Systeme können in Defender for Cloud entsprechend ausgenommen (exempted) werden.

Es ist mindestens [Defender for Servers Plan 1](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-servers-overview#plan-protection-features) erforderlich.

---

## 📑 Weitere Empfehlungen

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
