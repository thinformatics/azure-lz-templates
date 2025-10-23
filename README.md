# Azure Landing Zones Templates

[Azure Landing Zones Templates](#landingzones-concept-cloud-adoption-framework) - for free usage without warranty and support.

## Azure Templates

| Template Name | Description | Resources | Archtype / Perfect for | Links / Tags |
|---------|-----------|-----------|-------------|---------|
|[**Harded-Single-WS25-VM-Public**](arm-templates/Windows/README.md#harded-single-ws25-vm-public) | [💪Hardening](arm-templates/Windows/README.md#-os-config-security-baseline)<br> 🪟Windows Server 2025<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) VNet<br> ![NSG](/assets/svg/nsg.svg) NSG<br> ![PIP](/assets/svg/pip.svg) Public-IP<br> | Online / Public-Facing-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHarded-Single-WS25-VM-Public.json) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.0.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#vorbereitung-auf-cis--iso-27001) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#vorbereitung-auf-cis--iso-27001) |
| [**Harded-Single-WS22-VM-Public**](arm-templates/Windows/README.md#harded-single-ws22-vm-public) | [💪Hardening](arm-templates/Windows/README.md#-os-config-security-baseline)<br> 🪟Windows Server 2022<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) VNet<br> ![NSG](/assets/svg/nsg.svg) NSG<br> ![PIP](/assets/svg/pip.svg) Public-IP<br> | Online / Public-Facing-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHarded-Single-WS22-VM-Public.json) [![LastUpdated](https://img.shields.io/badge/LastChange-09/2025-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-0.0.9-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#vorbereitung-auf-cis--iso-27001) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#vorbereitung-auf-cis--iso-27001) |
| [**Harded-Single-WS25-VM-Private**](arm-templates/Windows/README.md#harded-single-ws25-vm-private) | [💪Hardening](arm-templates/Windows/README.md#-os-config-security-baseline)<br> 🪟Windows Server 2025<br>  | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) VNet<br> ![NSG](/assets/svg/nsg.svg) NSG<br> | CORP / Private-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHarded-Single-WS25-VM-Private.json) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.0.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#vorbereitung-auf-cis--iso-27001) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#vorbereitung-auf-cis--iso-27001) |
| [**Hardened-Single-RHEL9-VM-Public**](arm-templates/Linux/README.md#hardened-single-rhel9-vm-public) | [💪Hardening](arm-templates/Linux/README.md#-linux-security-baseline-openscap--ssg)<br> 🐧Red Hat Enterprice Linux 9<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) VNet<br> ![NSG](/assets/svg/nsg.svg) NSG<br> ![PIP](/assets/svg/pip.svg) Public-IP<br> | Online / Public-Facing-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL9-VM-Public.json)   [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.0.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#vorbereitung-auf-cis--iso-27001) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#vorbereitung-auf-cis--iso-27001) |
| [**Hardened-Single-RHEL9-VM-Private**](arm-templates/Linux/README.md#hardened-single-rhel9-vm-private) | [💪Hardening](arm-templates/Linux/README.md#-linux-security-baseline-openscap--ssg)<br> 🐧Red Hat Enterprice Linux 9<br>  | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) VNet<br> ![NSG](/assets/svg/nsg.svg) NSG<br> | CORP / Private-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL9-VM-Private.json) [![LastUpdated](https://img.shields.io/badge/LastChange-10/2025-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.0.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#vorbereitung-auf-cis--iso-27001) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#vorbereitung-auf-cis--iso-27001)|
| **Single-Linux-VM-Public** |  🐧Linux<br> <i><small>`Choices for RHEL,Ubuntu,OpenSuse`</small></i>  | ![VM](/assets/svg/vm.svg) Az-VM<br> 🧱VNet-NSG<br> ![PIP](/assets/svg/pip.svg) Public-IP<br> 🌉Az-Bastion<br> | Online / Public-Facing-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FHarded-Single-Linux-VM-Public.json) ![Work in Progress](https://img.shields.io/badge/status-Work%20in%20Progress-yellow) |

## Landingzones Concept (Cloud Adoption Framework)

Das **Landing Zone-Konzept** des [Microsoft Cloud Adoption Framework (CAF)](https://learn.microsoft.com/azure/cloud-adoption-framework/) beschreibt den standardisierten Aufbau einer **strukturierten, sicheren und skalierbaren Azure-Umgebung**.  
Eine Landing Zone bildet das Fundament für alle Workloads und stellt sicher, dass Governance-, Sicherheits-, Netzwerk- und Compliance-Anforderungen zentral umgesetzt werden.

### Unterschied zwischen [*Corp* und *Online*](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity) Landing Zones
- **Corp (Corporate)**  
  Wird für interne, vertrauenswürdige Workloads genutzt, die in das zentrale Unternehmensnetzwerk integriert sind.  
  Der Zugriff erfolgt typischerweise über private IP-Adressen, VPN- oder ExpressRoute-Verbindungen.  
  Fokus: *Sicherheit, Identitätsintegration und kontrollierte Konnektivität.*

- **Online**  
  Dient der Bereitstellung von extern erreichbaren oder öffentlich gehosteten Diensten.  
  Ressourcen verfügen in der Regel über öffentliche Endpunkte und sind für das Internet zugänglich.  
  Fokus: *Skalierbarkeit, Flexibilität und schnelle Bereitstellung von Cloud-Services.*

### Grund Voraussetzung
Dieses Template setzt eine durch den **Landing Zone Accelerator** regulierte und vollständig konfigurierte Azure-Umgebung voraus.  
Eine solche Umgebung basiert auf dem Microsoft [**Cloud Adoption Framework (CAF)**](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/) und stellt sicher, dass alle zentralen Governance- und Sicherheitsmechanismen bereits implementiert sind.

Dazu zählen unter anderem:
- Eine standardisierte **Netzwerktopologie** (z. B. Hub-and-Spoke oder Virtual WAN) mit klar definierten Zonen für Corp- und Online-Workloads.  
- Strukturiert aufgebaute **Management Groups**, **Richtlinien (Policies)** und **Blueprints**, die Compliance, Zugriffsschutz und Kostenkontrolle gewährleisten.  
- Eine aktivierte und integrierte **Microsoft Defender for Cloud**-Umgebung, die Sicherheitsbewertungen, Bedrohungserkennung und automatisierte Härtung der Workloads ermöglicht.  
- Einheitliche **Rollen- und Berechtigungsstrukturen (RBAC)**, die auf dem Prinzip der minimalen Rechtevergabe basieren.  
- Vordefinierte **Security Baselines** und **Policy-Initiativen**, die eine konsistente Umsetzung von Sicherheitsstandards über alle Subscriptions und Ressourcentypen hinweg sicherstellen.

Nur innerhalb einer solchen regulierten Umgebung ist gewährleistet, dass die bereitgestellten Ressourcen – wie virtuelle Maschinen oder Netzwerke – automatisch in die bestehenden Sicherheits-, Überwachungs- und Compliance-Prozesse des Unternehmens eingebunden werden können.

## Vorbereitung auf CIS & ISO 27001

Diese Templates unterstützen aktiv bei der Umsetzung der Anforderungen aus **ISO 27001** und den **CIS Benchmarks** für Microsoft Azure.  
Sie bilden den **ersten Schritt zur strukturierten Absicherung** von Workloads und dienen als technische Grundlage, um die wichtigsten Sicherheits- und Compliance-Vorgaben bereits während der Bereitstellung zu berücksichtigen.

Durch den Einsatz der Templates werden zentrale Sicherheitsmechanismen wie **Trusted Launch**, **vTPM**, **Secure Boot**, **Encryption at Host** und die Integration in **Defender for Cloud** automatisch aktiviert.  
Dadurch erfüllen bereitgestellte Systeme von Beginn an die wesentlichen technischen Anforderungen der genannten Standards und erleichtern den späteren **Nachweis von Compliance** im Rahmen interner oder externer Audits.