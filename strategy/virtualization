# PacIXP Virtualization & Container Strategy

## 1. Architectural Philosophy

To ensure high availability on limited hardware (2x Physical Servers per site), we utilize a **Hybrid Virtualization Model**:
1.  **Hypervisor Layer (Proxmox VE):** Provides the base abstraction, hardware management, and VM isolation.
2.  **Virtual Machines (VMs):** Used for "Mission Critical" networking functions (Route Servers) requiring dedicated network stacks and isolation.
3.  **Containers (Docker):** Used for "Management & Tooling" functions (IXP Manager, Monitoring) for ease of upgrades and dependency management.

---

## 2. Physical to Virtual Mapping

Each site (e.g., Samoa) has two physical servers: `SRV-01` and `SRV-02`.

*   **Anti-Affinity Rule:** `RS1` and `RS2` (Route Servers) must **NEVER** run on the same physical host.
*   **Replication:** The Management VM replicates storage from `SRV-01` to `SRV-02` every 15 minutes (ZFS Replication) for quick recovery.

---

## 3. Inventory of Logical Machines

### A. The Control Plane (Mission Critical)

These machines handle the actual routing logic. If they fail, traffic exchange stops.

| VM Name | Tech Stack | Hosted On | Functions | Critical Interactions | Impact of Outage |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **PacIXP-RS1** | **VM** (Ubuntu 22.04 + BIRD) | `SRV-01` | • BGP Route Reflection<br>• RPKI Enforcement<br>• Bogon Filtering | • Peers with all Members<br>• Pulls RPKI data from Validator<br>• Push stats to IXP Mgr | **SEVERITY: HIGH**<br>Redundancy is lost. If RS2 also fails, the IXP halts. |
| **PacIXP-RS2** | **VM** (Ubuntu 22.04 + BIRD) | `SRV-02` | • *Identical to RS1*<br>(Redundant Pair) | • Peers with all Members<br>• Pulls RPKI data from Validator | **SEVERITY: HIGH**<br>Redundancy is lost. |

### B. The Management Plane (Operational Support)

These machines handle configuration and monitoring. If they fail, traffic continues, but no changes can be made.

| VM Name | Tech Stack | Hosted On | Functions | Critical Interactions | Impact of Outage |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **PacIXP-MGMT** | **VM** (Docker Host) | `SRV-01` | • **IXP Manager** (Web/DB)<br>• **Routinator** (RPKI)<br>• **Oxidized** (Backups) | • Pushes configs to RS1/RS2<br>• Polls Switches (SNMP)<br>• Hosts Member Portal | **SEVERITY: MEDIUM**<br>• Existing traffic flows OK.<br>• No new peers can be added.<br>• Blind (No stats/graphs). |
| **PacIXP-MON** | **VM** (Docker Host) | `SRV-02` | • **Smokeping** (Latency)<br>• **Syslog** Collector | • Pings Member routers<br>• Collects logs | **SEVERITY: LOW**<br>• Loss of historical data.<br>• No alerting on degradation. |

---

## 4. Container Breakdown (Inside PacIXP-MGMT)

We use **Docker Compose** inside the `PacIXP-MGMT` VM to orchestrate the application layer.

| Container Service | Image | Function | Data Persistence |
| :--- | :--- | :--- | :--- |
| `ixp-manager-web` | `inex/ixp-manager` | The PHP Application & GUI. | Stateless (Config via ENV). |
| `ixp-manager-db` | `mariadb:10` | Stores all Member, IP, and Port data. | **CRITICAL:** Volume mapped to disk. |
| `ixp-cron` | `inex/ixp-manager` | Scheduled tasks (Stats, Config Gen). | Stateless. |
| `routinator` | `nlnetlabs/routinator` | Downloads global RPKI ROAs. | RPKI Cache volume. |
| `oxidized` | `oxidized/oxidized` | Logs into switches to backup configs. | Git Repo volume. |

---

## 5. Critical Interaction Flows

### Flow 1: Route Server Config Push (The "Brain to Body" Link)
*   **Source:** `PacIXP-MGMT` (Container: `ixp-cron`)
*   **Destination:** `PacIXP-RS1` (VM)
*   **Protocol:** API / SSH
*   **Mechanism:** IXP Manager generates a new `bird.conf`, connects to RS1, validates the config, and triggers a reload.
*   **Failure Mode:** If MGMT is down, RS1 keeps running with the *old* configuration.

### Flow 2: RPKI Validation (The Security Link)
*   **Source:** `PacIXP-RS1` (VM)
*   **Destination:** `PacIXP-MGMT` (Container: `routinator`)
*   **Protocol:** RTR (Port 3323)
*   **Mechanism:** BIRD queries Routinator for the validity of a prefix (Valid/Invalid/Unknown).
*   **Failure Mode:** If Routinator is down, BIRD maintains its *last known cache* for ~1 hour. After that, it fails open (allows all) or fails closed (blocks all) depending on config. *PacIXP Default: Fail Open (Warn).*

### Flow 3: Switch Statistics (The Visibility Link)
*   **Source:** `PacIXP-MGMT` (Container: `ixp-cron`)
*   **Destination:** Physical Switches (Arista/Juniper)
*   **Protocol:** SNMPv2c
*   **Mechanism:** Polls octet counters every 5 minutes.
*   **Failure Mode:** Gaps in traffic graphs.

---

## 6. Disaster Recovery & Operations

### A. "Management VM" Death
*   **Scenario:** `SRV-01` Hardware failure.
*   **Automatic Response:** None (Automatic failover of databases can be risky).
*   **Manual Recovery:**
    1.  Log into `SRV-02` Proxmox.
    2.  Locate the Replicated `PacIXP-MGMT` VM.
    3.  Right-click -> **Start**.
    4.  Update DNS if IP changed (Use a Floating IP to avoid this).
*   **RTO (Recovery Time):** < 15 Minutes.

### B. "Route Server" Death
*   **Scenario:** `PacIXP-RS1` OS corruption.
*   **Impact:** Members lose sessions to RS1.
*   **Resilience:** Members automatically rely on `PacIXP-RS2` (Active-Active). Traffic is unaffected.
*   **Recovery:** Reinstall RS1 VM via Ansible/Script, or restore from last night's backup.

### C. Total Site Power Loss
*   **Impact:** Complete IXP outage.
*   **Recovery:**
    1.  Servers boot.
    2.  Proxmox auto-starts VMs (Priority: RS1/RS2 First, MGMT Second).
    3.  Switches boot.
    4.  BGP sessions re-establish automatically.

---

## 7. Security Isolation

1.  **Network Segmentation:**
    *   **VLAN 10 (Peering):** Only RS1/RS2 interfaces attached. **NO** Management VM access.
    *   **VLAN 99 (Mgmt):** RS1/RS2 Mgmt Interface, MGMT VM, Switch Mgmt Ports.
2.  **Container Isolation:**
    *   Docker containers run on an internal bridge network.
    *   Only `Nginx` (80/443) and `Routinator` (3323) ports are exposed to the VM host.
    *   Database port (3306) is **NOT** exposed externally.
