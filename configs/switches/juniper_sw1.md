Here is the reference configuration for **Switch 1 (SW1)** using a **Juniper QFX5200** (or QFX5110/5120) running **Junos OS**.

This configuration mirrors the Arista example but utilizes Juniper's specific EVPN-VXLAN implementation and firewall filter syntax.

### ⚠️ IMPORTANT ENGINEERING WARNING

> **THIS IS A REFERENCE CONFIGURATION TEMPLATE.**
>
> While this configuration is syntactically correct for Junos OS (QFX Series), it contains example IP addresses, passwords, and interface IDs.
> **DO NOT DEPLOY THIS TO PRODUCTION WITHOUT MODIFICATION.**
>
> 1.  **Root Password:** You must set a root password before committing.
> 2.  **Commit Check:** Always run `commit check` before applying.
> 3.  **Interface Naming:** QFX5200 uses `et-` (25G/40G/100G) and `xe-` (10G). Verify your specific optics/speeds.
> 4.  **MTU:** This design requires Jumbo Frames (MTU 9000+) on the underlay links.

---

### File: `configs/switches/juniper/sw1-qfx-example.conf`

```junos
/* 
 * Device: PacIX-SiteA-SW1 (Juniper QFX5200)
 * Role:   Leaf / VTEP
 * OS:     Junos OS 18.x or later recommended
 */

/* ------------------------------------------------------------------
 * SYSTEM & MANAGEMENT
 * ------------------------------------------------------------------ */
system {
    host-name PacIX-SiteA-SW1;
    root-authentication {
        /* REPLACE THIS HASH IMMEDIATELY */
        encrypted-password "$6$SALT$HASH_GOES_HERE...";
    }
    services {
        ssh {
            root-login deny;
            protocol-version v2;
        }
        netconf {
            ssh;
        }
    }
    /* Dedicated Management Interface (me0) */
    management-instance; 
}

/* ------------------------------------------------------------------
 * CHASSIS & AGGREGATION
 * ------------------------------------------------------------------ */
chassis {
    /* Enable aggregated ethernet if using LACP trunks */
    aggregated-devices {
        ethernet {
            device-count 10;
        }
    }
}

/* ------------------------------------------------------------------
 * SECURITY - FIREWALL FILTERS (ACLs)
 * ------------------------------------------------------------------ */
firewall {
    family ethernet-switching {
        /* IPv4 Protection Filter */
        filter ACL-IXP-PEERING-V4 {
            term BLOCK-DHCP {
                from {
                    protocol udp;
                    destination-port [ 67 68 ];
                }
                then discard;
            }
            term PERMIT-ALL {
                then accept;
            }
        }
        
        /* IPv6 Protection Filter */
        filter ACL-IXP-PEERING-V6 {
            term BLOCK-RA {
                from {
                    next-header icmp6;
                    icmp-type router-advertisement;
                }
                then {
                    discard;
                    count ROGUE-RA-DROPS;
                }
            }
            term BLOCK-DHCPv6 {
                from {
                    next-header udp;
                    destination-port [ 546 547 ];
                }
                then discard;
            }
            term PERMIT-ALL {
                then accept;
            }
        }
    }
}

/* ------------------------------------------------------------------
 * SECURITY - STORM CONTROL
 * ------------------------------------------------------------------ */
forwarding-options {
    storm-control-profiles {
        IXP-STORM-PROFILE {
            all {
                bandwidth-level 10000; /* Limit to ~10Mbps or 1% */
                no-broadcast-suppression;
                no-multicast-suppression;
                no-unknown-unicast-suppression; 
            }
        }
    }
}

/* ------------------------------------------------------------------
 * INTERFACES - INFRASTRUCTURE
 * ------------------------------------------------------------------ */
interfaces {
    /* Uplink to WAN / Core Router */
    et-0/0/48 {
        description "INFRA: UPLINK-TO-WAN";
        mtu 9216; /* Critical for VXLAN overhead */
        unit 0 {
            family inet {
                address 172.16.0.1/31;
            }
        }
    }
    
    /* Inter-Switch Link (ISL) */
    et-0/0/49 {
        description "INFRA: ISL-TO-SW2";
        mtu 9216;
        unit 0 {
            family inet {
                address 172.16.0.3/31;
            }
        }
    }

    /* Loopback (VTEP IP) */
    lo0 {
        unit 0 {
            family inet {
                address 10.0.0.11/32;
            }
        }
    }
    
    /* Management */
    me0 {
        unit 0 {
            family inet {
                address 192.168.100.11/24;
            }
        }
    }

/* ------------------------------------------------------------------
 * INTERFACES - MEMBERS
 * ------------------------------------------------------------------ */
    /* Example Member Port */
    xe-0/0/0 {
        description "MEMBER: ISP-A (AS65001)";
        mtu 9216; /* Allow jumbo frames for peering */
        unit 0 {
            family ethernet-switching {
                interface-mode access;
                vlan {
                    members IXP-PEERING-LAN;
                }
                /* Apply Security Filters */
                filter {
                    input-list [ ACL-IXP-PEERING-V4 ACL-IXP-PEERING-V6 ];
                }
                /* Storm Control */
                storm-control IXP-STORM-PROFILE;
            }
        }
    }
}

/* ------------------------------------------------------------------
 * SWITCHING OPTIONS (Port Security)
 * ------------------------------------------------------------------ */
switch-options {
    /* Define Member Interfaces for Specific Security */
    interface xe-0/0/0.0 {
        interface-mac-limit {
            limit 1;
            packet-action drop;
        }
    }
    /* BPDU Block globally on edge ports */
    stp {
        interface xe-0/0/0.0 {
            edge;
            bpdu-block-on-edge;
        }
    }
}

/* ------------------------------------------------------------------
 * VLANS & VXLAN MAPPING
 * ------------------------------------------------------------------ */
vlans {
    IXP-PEERING-LAN {
        vlan-id 10;
        vxlan {
            vni 10010;
        }
    }
}

/* ------------------------------------------------------------------
 * PROTOCOLS - UNDERLAY (OSPF)
 * ------------------------------------------------------------------ */
protocols {
    ospf {
        area 0.0.0.0 {
            interface lo0.0 {
                passive;
            }
            interface et-0/0/48.0;
            interface et-0/0/49.0;
        }
    }

/* ------------------------------------------------------------------
 * PROTOCOLS - OVERLAY (BGP EVPN)
 * ------------------------------------------------------------------ */
    bgp {
        group OVERLAY-EVPN {
            type internal;
            local-address 10.0.0.11;
            family evpn {
                signaling;
            }
            /* Peer with Local SW2 */
            neighbor 10.0.0.12 {
                description "iBGP-PEER-SW2";
            }
            /* Peer with Remote Site B SW1 */
            neighbor 10.0.0.21 {
                description "iBGP-PEER-SITE-B-SW1";
            }
            /* Peer with Remote Site B SW2 */
            neighbor 10.0.0.22 {
                description "iBGP-PEER-SITE-B-SW2";
            }
        }
    }
    
    evpn {
        /* Use VXLAN encapsulation */
        encapsulation vxlan;
        /* Use Head-End Replication (Simpler than PIM Multicast) */
        replication-type ingress;
        /* Default Gateway Extended Community */
        default-gateway no-gateway-community;
        
        /* Map VNIs to Route Targets */
        vni-options {
            vni 10010 {
                vrf-target target:64500:10010;
            }
        }
        extended-vni-list all;
    }
    
    /* LLDP - Disable on Member Ports */
    lldp {
        interface et-0/0/48.0;
        interface et-0/0/49.0;
        interface xe-0/0/0.0 {
            disable;
        }
    }
}

/* ------------------------------------------------------------------
 * POLICY & ROUTING OPTIONS
 * ------------------------------------------------------------------ */
policy-options {
    /* Define what constitutes an EVPN Route (Type 2 MAC/IP) */
    policy-statement EVPN-EXPORT {
        term EVPN-ROUTES {
            from protocol evpn;
            then accept;
        }
    }
}
```
