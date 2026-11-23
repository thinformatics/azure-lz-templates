# 🗄️ Archiv

Templates in diesem Ordner werden **nicht mehr aktiv genutzt und nicht weiterentwickelt**. Sie bleiben zur Nachvollziehbarkeit erhalten.

Für neue VMs bitte die aktuellen Templates verwenden: [Windows](/arm-templates/Windows/README.md) · [Linux](/arm-templates/Linux/README.md)

---

## 🪟 Windows

### Hardened-Single-WS22-VM-Public

Datei: [`Windows/Hardened-Single-WS22-VM-Public.json`](Windows/Hardened-Single-WS22-VM-Public.json)

| **Eigenschaften** | **Ressourcen** |
|-------------------|:--------------|
| 🪟 Windows Server 2022 - Gen2 [*latest*] | ![PIP](/assets/svg/pip.svg) Public IP |
| Region: Germany West Central | ![VNET](/assets/svg/vnet.svg) VNET (Ausgang über Public IP) |
| ![Version](https://img.shields.io/badge/Version-1.1.0-blue) [![LastUpdated](https://img.shields.io/badge/LastChange-11/2026-green)](https://thinformatics.com) | ![NIC](/assets/svg/nic.svg) Network Interface (Accelerated Networking) |
| [![AzCompliance](https://img.shields.io/badge/ISO27001-violet) ![AzCompliance](https://img.shields.io/badge/CIS-violet)](/README.md#sicherheits--und-compliance) | ![NSG](/assets/svg/nsg.svg) Network Security Group |
|  | ![DISK](/assets/svg/disk.svg) Encrypted Disk |

> [!IMPORTANT]
> Der Mainstream-Support für Windows Server 2022 endete am 13.10.2026 (Extended Support bis 14.10.2031). Für neue Workloads wird Windows Server 2025 empfohlen.

> [!NOTE]
> OS Config Baselines sind für Windows Server 2025 ausgelegt. Auch auf neueste Versionen von Windows Server 2022 lassen sich die Sicherheits-Baselines erfolgreich anwenden - der Schwerpunkt unserer Optimierung liegt jedoch auf Windows Server 2025.

---

## 🐧 Linux

### Harded-Single-Linux-VM-Public

Datei: [`Linux/Harded-Single-Linux-VM-Public.json`](Linux/Harded-Single-Linux-VM-Public.json)

![Legacy](https://img.shields.io/badge/status-Legacy-lightgrey)

Älteres Multi-Distro-Template (Ubuntu 24.04, RHEL 9, SLES 15 SP7) **ohne Trusted Launch und ohne OS-Hardening**.
