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
                address 198.51.100.64/31;
            }
            family inet6 {
                address 3fff:0:3::/127;
            }
        }
    }

    /* Inter-Switch Link (ISL) */
    et-0/0/49 {
        description "INFRA: ISL-TO-SW2";
        mtu 9216;
        unit 0 {
            family inet {
                address 198.51.100.66/31;
            }
            family inet6 {
                address 3fff:0:3::2/127;
            }
        }
    }

    /* Loopback (VTEP IP) */
    lo0 {
        unit 0 {
            family inet {
                address 198.51.100.11/32;
            }
            family inet6 {
                address 3fff:0:2::11/128;
            }
        }
    }

    /* Management */
    me0 {
        unit 0 {
            family inet {
                address 203.0.113.11/24;
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
 * ROUTING OPTIONS (BGP Confederation Identity)
 * ------------------------------------------------------------------ */
/* This switch is in sub-AS 64501 (Site A: Samoa).
 * The confederation identifier 64500 is the externally-visible AS.
 * Route Targets reference the confederation ID, not the sub-AS.
 *
 * BGP topology mirrors the physical topology:
 *   Intra-site ISL   <--> iBGP session (type internal, same sub-AS)
 *   Inter-site VXLAN <--> confederation eBGP (type external, peer sub-AS)
 */
routing-options {
    autonomous-system 64501;
    confederation 64500 {
        members [ 64501 64502 64503 ];
    }
    router-id 198.51.100.11;
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
    ospf3 {
        area 0.0.0.0 {
            interface lo0.0 {
                passive;
            }
            interface et-0/0/48.0;
            interface et-0/0/49.0;
        }
    }

/* ------------------------------------------------------------------
 * PROTOCOLS - OVERLAY (BGP EVPN CONFEDERATION)
 * ------------------------------------------------------------------ */
    bgp {
        /* Intra-Site: SW2 shares sub-AS 64501 — standard iBGP behavior.
         * This session mirrors the physical ISL between SW1 and SW2.
         * Junos type internal = same autonomous-system (sub-AS 64501). */
        group EVPN-INTRASITE {
            type internal;
            local-address 198.51.100.11;
            /* Explicit timers — do not rely on Junos defaults (30/90).
             * If this WAN path experiences jitter/flapping, increase to
             * hold-time 90 (keepalive defaults to hold-time/3 = 30). */
            hold-time 30;
            family evpn {
                signaling;
            }
            neighbor 198.51.100.12 {
                description "iBGP-INTRASITE-SW2";
            }
        }
        /* Inter-Site: Site B switches are in sub-AS 64502 — confederation eBGP.
         * These sessions mirror the physical VXLAN tunnels between sites.
         * Junos type external = different sub-AS (peer-as set per neighbor).
         *
         * no-nexthop-change: Critical — preserves the originating VTEP's
         * Loopback IP as the EVPN next-hop across the confederation boundary.
         * Without this, the VTEP IP is overwritten and VXLAN breaks. */
        group EVPN-INTERSITE {
            type external;
            local-address 198.51.100.11;
            /* Explicit timers — do not rely on Junos defaults (30/90).
             * If this WAN path experiences jitter/flapping, increase to
             * hold-time 90 (keepalive defaults to hold-time/3 = 30). */
            hold-time 30;
            no-nexthop-change;
            family evpn {
                signaling;
            }
            neighbor 198.51.100.21 {
                description "CONFED-EBGP-SITE-B-SW1";
                peer-as 64502;
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
