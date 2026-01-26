# Running the Lab

1.  **Deploy:**
    ```bash
    sudo containerlab deploy --topo pacixp.clab.yml
    ```

2.  **Verify VXLAN (L2 Stretch):**
    Ping from Member 1 (on SW1) to Member 5 (on SW2).
    ```bash
    docker exec -it clab-pacixp-member1 ping 192.0.2.5
    ```

3.  **Verify BGP Peering:**
    Check the Route Server status.
    ```bash
    docker exec -it clab-pacixp-rs1 birdc show protocols
    ```
    *You should see 5 sessions in `Established` state.*

4.  **Verify Route Exchange:**
    Check if Member 1 learned Member 5's loopback (1.1.1.5) via the RS.
    ```bash
    docker exec -it clab-pacixp-member1 vtysh -c "show ip bgp"
    ```

*   **Member 1, 2, 3** are local to `sw1`.
*   **Member 4, 5** are local to `sw2`.
*   **RS1** is only on `sw1`.
*   When Member 5 peers with RS1, the traffic traverses the VXLAN tunnel between switches. This proves the **EVPN Overlay** is working correctly for the peering LAN.
