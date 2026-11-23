# Azure Landing Zones Templates

Templates für VMs im Kontext der Azure Landingzones  - for free usage without warranty and support.

## Azure Templates

| Template Name | Description | Resources | Archtype / Perfect for | Links / Tags |
|---------|-----------|-----------|-------------|---------|
| [**Hardened-Single-WS25-VM-Public**](arm-templates/Windows/README.md#hardened-single-ws25-vm-public) | [💪Hardening](arm-templates/Windows/README.md#-os-config-security-baseline)<br> 🪟Windows Server 2025 Azure Edition<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) VNet<br> ![NSG](/assets/svg/nsg.svg) NSG<br> ![PIP](/assets/svg/pip.svg) Public-IP<br> | Online / Public-Facing-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHardened-Single-WS25-VM-Public.json) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#sicherheits--und-compliance) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#sicherheits--und-compliance) |
| [**Hardened-Single-WS25-VM-Private**](arm-templates/Windows/README.md#hardened-single-ws25-vm-private) | [💪Hardening](arm-templates/Windows/README.md#-os-config-security-baseline)<br> 🪟Windows Server 2025<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) Bestehendes Subnetz *oder* neues VNet<br> ![NSG](/assets/svg/nsg.svg) NSG (optional)<br> | CORP / Private-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FWindows%2FHardened-Single-WS25-VM-Private.json) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#sicherheits--und-compliance) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#sicherheits--und-compliance) |
| [**Hardened-Single-RHEL10-VM-Public**](arm-templates/Linux/README.md#hardened-single-rhel10-vm-public) | [💪Hardening](arm-templates/Linux/README.md#-linux-security-baseline)<br> 🐧Red Hat Enterprise Linux 10<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) VNet<br> ![NSG](/assets/svg/nsg.svg) NSG<br> ![PIP](/assets/svg/pip.svg) Public-IP<br> | Online / Public-Facing-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL10-VM-Public.json) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#sicherheits--und-compliance) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#sicherheits--und-compliance) |
| [**Hardened-Single-RHEL10-VM-Private**](arm-templates/Linux/README.md#hardened-single-rhel10-vm-private) | [💪Hardening](arm-templates/Linux/README.md#-linux-security-baseline)<br> 🐧Red Hat Enterprise Linux 10<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) Bestehendes Subnetz *oder* neues VNet<br> ![NSG](/assets/svg/nsg.svg) NSG (optional)<br> | CORP / Private-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL10-VM-Private.json) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#sicherheits--und-compliance) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#sicherheits--und-compliance) |
| [**Hardened-Single-RHEL9-VM-Public**](arm-templates/Linux/README.md#hardened-single-rhel9-vm-public) | [💪Hardening](arm-templates/Linux/README.md#-linux-security-baseline)<br> 🐧Red Hat Enterprise Linux 9<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) VNet<br> ![NSG](/assets/svg/nsg.svg) NSG<br> ![PIP](/assets/svg/pip.svg) Public-IP<br> | Online / Public-Facing-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL9-VM-Public.json) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#sicherheits--und-compliance) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#sicherheits--und-compliance) |
| [**Hardened-Single-RHEL9-VM-Private**](arm-templates/Linux/README.md#hardened-single-rhel9-vm-private) | [💪Hardening](arm-templates/Linux/README.md#-linux-security-baseline)<br> 🐧Red Hat Enterprise Linux 9<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) Bestehendes Subnetz *oder* neues VNet<br> ![NSG](/assets/svg/nsg.svg) NSG (optional)<br> | CORP / Private-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FRed%2520Hat%2FHardened-Single-RHEL9-VM-Private.json) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#sicherheits--und-compliance) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#sicherheits--und-compliance) |
| [**Hardened-Single-Ubuntu2604-VM-Public**](arm-templates/Linux/README.md#hardened-single-ubuntu2604-vm-public) | [💪Hardening](arm-templates/Linux/README.md#-linux-security-baseline)<br> 🐧Ubuntu 26.04 LTS Pro<br> ⚠️ aktuell keine Härtungsprofile<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) VNet<br> ![NSG](/assets/svg/nsg.svg) NSG<br> ![PIP](/assets/svg/pip.svg) Public-IP<br> | Online / Public-Facing-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FUbuntu%2FHardened-Single-Ubuntu2604-VM-Public.json) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) ![Work in Progress](https://img.shields.io/badge/status-Work%20in%20Progress-yellow) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#sicherheits--und-compliance) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#sicherheits--und-compliance) |
| [**Hardened-Single-Ubuntu2604-VM-Private**](arm-templates/Linux/README.md#hardened-single-ubuntu2604-vm-private) | [💪Hardening](arm-templates/Linux/README.md#-linux-security-baseline)<br> 🐧Ubuntu 26.04 LTS Pro<br> ⚠️ aktuell keine Härtungsprofile<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) Bestehendes Subnetz *oder* neues VNet<br> ![NSG](/assets/svg/nsg.svg) NSG (optional)<br> | CORP / Private-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FUbuntu%2FHardened-Single-Ubuntu2604-VM-Private.json) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) ![Work in Progress](https://img.shields.io/badge/status-Work%20in%20Progress-yellow) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#sicherheits--und-compliance) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#sicherheits--und-compliance) |
| [**Hardened-Single-Ubuntu24-VM-Public**](arm-templates/Linux/README.md#hardened-single-ubuntu24-vm-public) | [💪Hardening](arm-templates/Linux/README.md#-linux-security-baseline)<br> 🐧Ubuntu 24.04 LTS Pro<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) VNet<br> ![NSG](/assets/svg/nsg.svg) NSG<br> ![PIP](/assets/svg/pip.svg) Public-IP<br> | Online / Public-Facing-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FUbuntu%2FHardened-Single-Ubuntu24-VM-Public.json) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#sicherheits--und-compliance) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#sicherheits--und-compliance) |
| [**Hardened-Single-Ubuntu24-VM-Private**](arm-templates/Linux/README.md#hardened-single-ubuntu24-vm-private) | [💪Hardening](arm-templates/Linux/README.md#-linux-security-baseline)<br> 🐧Ubuntu 24.04 LTS Pro<br> | ![VM](/assets/svg/vm.svg) Az-VM<br> ![VNET](/assets/svg/vnet.svg) Bestehendes Subnetz *oder* neues VNet<br> ![NSG](/assets/svg/nsg.svg) NSG (optional)<br> | CORP / Private-Workloads | [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fthinformatics%2Fazure-lz-templates%2Frefs%2Fheads%2Fmain%2Farm-templates%2FLinux%2FUbuntu%2FHardened-Single-Ubuntu24-VM-Private.json) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![AzCompliance](https://img.shields.io/badge/ISO27001-violet)](#sicherheits--und-compliance) [![AzCompliance](https://img.shields.io/badge/CIS-violet)](#sicherheits--und-compliance) |

### Grund Voraussetzung

Die hier bereitgestellten Templates sollten in einer "regulierten Azure Cloud Umgebung" zum Einsatz kommen, idealerweise eine Azure-Umgebung die mit dem **Landing Zone Accelerator** konfiguriert wurde.  
Eine solche Umgebung basiert zumeist auf dem Microsoft [**Cloud Adoption Framework (CAF)**](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/) und stellt sicher, dass alle zentralen Governance- und Sicherheitsmechanismen bereits implementiert sind - Eine solche Umgebung hat in der Regel eine Unterteilung in mehrere Archetypen, zur Bereitstellung von "Ressourcen und Services", traditionell werden die Archetypen Corp und Online von Microsoft vorgegeben:

### Unterschied zwischen [*Corp* und *Online*](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/landing-zone/design-area/network-topology-and-connectivity) Landing Zones

- **Corp (Corporate)**  
  Wird für interne Workloads genutzt, die **nicht** öffentlich erreichbar sein dürfen.  
  Verbindungen werden typischerweise über private IP-Adressen, VPN- oder ExpressRoute-Verbindungen realisiert.  
  Fokus: *Sicherheit, Identitätsintegration und zentral koordinierte Konnektivität.*

- **Online**  
  Dient der Bereitstellung von extern erreichbaren oder öffentlich gehosteten Diensten.  
  Ressourcen können über öffentliche Endpunkte erreichbar gemacht werden, dies ist optional und kann beeinflusst werden.
  Fokus: *Skalierbarkeit, Flexibilität und schnelle Bereitstellung von Cloud-Services.*

## Sicherheits- und Compliance

Die Templates unterstützen aktiv bei der Einhaltung von Anforderungen aus **ISO27001** und den **CIS-Benchmarks**.
Die Einhaltung kann über das Azure Cloud Portal und im Bereich der bereitgestellten Ressourcen, nachverfolgt werden.
Die Templates helfen dabei Aufwände schon im Vorfeld zu reduzieren und liefern wertvolle Leitplanken:

**Trusted Launch**, **vTPM**, **Secure Boot**, **Encryption at Host** und die Integration in **Defender for Cloud** sind u.a. automatisch berücksichtigt.  

## Netzwerk

Die Anbindung an bestehende Infrastruktur (Peering, Hub-Firewall, VPN/ExpressRoute) ist nicht Teil der Templates und erfolgt nach der Bereitstellung.

### Online / Public-Templates

Die Public-Templates legen ein eigenes VNet an. Ausgehender Verkehr läuft über die direkt an der VM hängende Public IP.

### Corp / Private-Templates

Die Private-Templates bieten zwei Netzwerk-Modi (Parameter `networkMode`):

| Modus | Was wird bereitgestellt | Ausgehender Internetzugang | Einsatz |
|-------|-------------------------|----------------------------|---------|
| `new` *(Standard)* | Eigenes, isoliertes VNet mit Subnetz und NSG | Über den Standard-Internetzugang von Azure (*Default Outbound Access*) | **Labs / Tests** – kein Peering, VM nur über Serial Console oder nachträglich angebundene Bastion erreichbar |
| `existing` | Nur die Netzwerkkarte – im bestehenden Subnetz der Landing Zone (`existingSubnetId`). Optional eine leere NSG an der NIC (`attachNicNsg`). | Abhängig von der bestehenden Landing Zone | **Produktion** – VM ist über Hub, VPN/ExpressRoute und Bastion erreichbar |

> [!IMPORTANT]
> Die automatische Härtung lädt Skripte und Pakete aus dem Internet und benötigt deshalb während der Bereitstellung ausgehenden Internetzugang.
> Im Modus `existing` muss das bestehende VNet in der Region **Germany West Central** liegen.

### Standard-Internetzugang nach der Bereitstellung abschalten

Die Templates aktivieren für neu angelegte Subnetze bewusst den Standard-Internetzugang von Azure (`defaultOutboundAccess: true`), damit die Härtung ohne weitere Infrastruktur funktioniert. Microsoft empfiehlt, diesen Zugang nicht dauerhaft zu nutzen ([Default Outbound Access](https://learn.microsoft.com/azure/virtual-network/ip-services/default-outbound-access)): Die verwendete IP-Adresse gehört Microsoft und kann sich ohne Ankündigung ändern.

Nachdem die VM an die vorhandene Infrastruktur angebunden ist (z. B. Ausgang über Hub-Firewall oder NAT Gateway), den Standard-Internetzugang abschalten:

```bash
az network vnet subnet update -g <rg> --vnet-name <vnet> -n default --default-outbound-access false
az vm deallocate -g <rg> -n <vm>
az vm start -g <rg> -n <vm>
```

> [!NOTE]
> Die Änderung greift erst, nachdem die VM gestoppt (*deallocated*) und wieder gestartet wurde.
