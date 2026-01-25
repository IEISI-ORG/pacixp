# Runbook: Enrolling Arista Switches into IXP Manager

| Task Details | |
| :--- | :--- |
| **Prerequisites** | Arista Switch installed; IXP Manager running; IP connectivity established. |
| **Protocol** | SNMPv2c (Data collection), SSH (Config push - optional). |
| **Role** | Infrastructure Admin |

---

## Phase 1: Prepare the Arista Switch

Before IXP Manager can talk to the switch, we must configure SNMP and ensure the management interface is accessible.

**Login to the Arista Switch (CLI) and apply:**

```eos
! Enter Configuration Mode
configure terminal

! 1. Configure SNMP (Read-Only)
! Replace 'pacix-public' with your secret community string
! This MUST match what you enter in IXP Manager later
snmp-server community pacix-public ro

! 2. Identify the Chassis
! IXP Manager needs a unique hostname and location
hostname PacIX-SiteA-SW1
snmp-server contact "NOC <noc@pacix.net>"
snmp-server location "Apia Cable Landing Station, Rack 3"

! 3. Enable sFlow (Traffic Statistics)
! This sends traffic samples to IXP Manager for graphing
! Replace 192.168.100.50 with your IXP Manager Docker Host IP
sflow source 10.0.0.11
sflow destination 192.168.100.50 6343
sflow polling-interval 20
sflow sample 1024
sflow run

! 4. Security (Allow SNMP)
! If you have a management ACL, permit UDP 161
management api http-commands
   protocol http
   no shutdown
   !
   ! Ensure SNMP is allowed in the control plane
   ! (Arista allows SNMP by default on Mgmt interface, but check ACLs)

write memory
```

### 🔍 Verification (Switch Side)
Test that the switch is listening:
```bash
show snmp
show sflow
```

---

## Phase 2: Add Switch to IXP Manager

Log in to your IXP Manager Web GUI (`http://<your-ip>/admin`).

### Step 1: Create the Cabinet (Physical Location)
1.  Navigate to **Infrastructure** -> **Cabinets**.
2.  Click **Add Cabinet**.
3.  **Name:** `Site A - Rack 1` (or similar).
4.  **Location:** Select the Colocation/Data Center facility.
5.  Click **Save**.

### Step 2: Add the Switch
1.  Navigate to **Infrastructure** -> **Switches**.
2.  Click **Add Switch**.
3.  Fill in the **General** tab:
    *   **Name:** `PacIX-SiteA-SW1`
    *   **Hostname/IP:** `192.168.100.11` (The Management IP).
    *   **Type:** `Arista Switches (EOS)`.
    *   **Cabinet:** Select `Site A - Rack 1`.
4.  Fill in the **Poller** tab (Critical for Graphs):
    *   **SNMP Community:** `pacix-public` (Must match Phase 1).
    *   **SNMP Version:** `v2c`.
    *   **Polling Status:** `Enabled`.
5.  Click **Save Changes**.

---

## Phase 3: Port Discovery & Mapping

IXP Manager needs to know which physical ports exist on the switch.

1.  In the **Switches** list, find your new switch.
2.  Click the **Poll** button (Graph Icon or "Poll Switch" in the menu).
    *   *Note:* If using Docker, this might take up to 60 seconds to run in the background.
3.  Once polled, click **Overview** (Eye Icon) -> **Port Status**.
    *   You should see a list of interfaces (`Ethernet1`, `Ethernet2`, etc.).
    *   If the list is empty, check network connectivity between the Docker container and the switch.

### Mapping Ports to Members
You don't just "assign a port." You create a **Switch Port** object that maps a physical interface to a specific purpose.

1.  Navigate to **Infrastructure** -> **Switch Ports**.
2.  Click **Add Switch Port**.
    *   **Switch:** `PacIX-SiteA-SW1`.
    *   **Type:** `Traffic / Peering`.
    *   **Name:** `Ethernet3` (Type exactly as it appears in CLI).
    *   **Configured Speed:** `10 Gbit/s`.
3.  Click **Save**.

*Repeat this for every port you intend to use.*

---

## Phase 4: Configure Traffic Graphs (MRTG/sFlow)

Traffic graphs in IXP Manager are generated via MRTG (SNMP) or sFlow.

### Option A: SNMP Polling (Easiest)
1.  Ensure the **Cron** container in Docker is running (`docker compose ps`).
2.  The system automatically generates an MRTG config file (`/etc/mrtg/mrtg.cfg`) inside the container every 15 minutes.
3.  Wait 15-30 minutes. Graphs should start appearing on the **Statistics** page.

### Option B: sFlow (Real-time)
*Requires additional setup of `sflowtool` or `nfsen` (Advanced).*
For this Reference Design, we rely on **SNMP Polling** as the primary method because it is built-in to the Docker image.

---

## Troubleshooting

**Problem: "SNMP Timeout" or "Device not reachable"**
*   **Cause:** The Docker container cannot route to the Switch Management IP.
*   **Fix:**
    *   Check if the Switch Mgmt IP (`192.168.100.11`) is reachable from the Docker Host.
    *   If using Mac/Windows Docker Desktop, routing can be tricky. On Linux, it usually works if the host can ping the switch.
    *   Try pinging from inside the container:
        ```bash
        docker compose exec ixp-manager ping 192.168.100.11
        ```

**Problem: Ports list is empty**
*   **Cause:** IXP Manager hasn't run the `update-l2-database.php` script yet.
*   **Fix:** Manually trigger a poll via the UI, or wait 15 minutes for the cron job.

**Problem: Graphs show broken images**
*   **Cause:** Permissions issue in the `storage` volume or MRTG hasn't run yet.
*   **Fix:** Check logs:
    ```bash
    docker compose logs cron
    ```
