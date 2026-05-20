Pacific IXP:
Operating Guideline
23 November 2021

Pacific-IXP Operating Guidelines (August 2021) 1
This report is formatted for double-sided printing.
If printing a hard-copy, please reduce paper use by
printing on both sides of the paper.

Pacific-IXP Operating Guidelines (August 2021) 2
Declaration and Disclaimer
Declaration and Disclaimer
This Report has been prepared by Dr Paul Brooks of Layer 10 for the United Nations Economic and
Social Commission for Asia and the Pacific, in support of the Asia-Pacific Information Superhighway
initiative.
In preparing this report, Layer 10 has relied primarily on information from publicly available
sources, best practices documents and our domain expertise. While reasonable measures
were taken to confirm, verify and validate these sources, we offer no warranty, express or
implied, regarding any information referenced within.
The findings and recommendations of the study should not be reported as representing the
views of the United Nations. The views expressed herein are those of the author(s). The
study has been issued without formal editing, and the designations employed and material
presented do not imply the expression of any opinion whatsoever on the part of the
Secretariat of the United Nations concerning the legal status of any country, territory, city or
area, or of its authorities, or concerning the delimitation of its frontiers or boundaries.
To follow up aspects of this report, please contact:
Dr Paul Brooks
Director
Layer 10 Pty Ltd
29 Willis Avenue
St Ives NSW 2075
pbrooks@layer10.com.au
Telephone: +61-2-8004-7961

  Pacific-IXP Operating Guidelines (August 2021)  3

Table of Contents

| Declaration and Disclaimer  |     |     |     |     |     |     | 3   |
| --------------------------- | --- | --- | --- | --- | --- | --- | --- |
| Table of Contents           |     |     |     |     |     |     | 4   |
|                             |     |     |     |     |     |     |     |
| Table of Figures            |     |     |     |     |     |     | 6   |
|                             |     |     |     |     |     |     |     |
| Glossary of Terms           |     |     |     |     |     |     | 7   |

| 1. Introduction                                          |     |     |     |     |     |     | 7   |
| -------------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
| 1.1 Current status                                       |     |     |     |     |     |     | 7   |
| 1.2 Sources and Resources                                |     |     |     |     |     |     | 8   |
| 2. The Pacific-IXP Proposal                              |     |     |     |     |     |     | 9   |
| 2.1 Topology                                             |     |     |     |     |     |     | 10  |
| 2.2 Inter-Node Links                                     |     |     |     |     |     |     | 12  |
| 2.3 Suggested Physical Infrastructure at each node site  |     |     |     |     |     |     | 13  |
| 3. Organisation Structure                                |     |     |     |     |     |     | 14  |
| 3.1 Governance                                           |     |     |     |     |     |     | 15  |
| 3.2 Leadership and Management                            |     |     |     |     |     |     | 15  |
| 3.3 Operational staffing                                 |     |     |     |     |     |     | 16  |
| 3.4 Ownership of Equipment and Services                  |     |     |     |     |     |     | 16  |
| 3.5 Policy Development Process                           |     |     |     |     |     |     | 16  |
| 4. Peering & Interconnection Policies                    |     |     |     |     |     |     | 17  |
| 5. Questions to be resolved                              |     |     |     |     |     |     | 19  |
| 5.1 Organisational                                       |     |     |     |     |     |     | 19  |
1. In which country (or countries) should the ‘IXP Association’ be registered as an entity?  19
2. Can this entity operate in each node-hosting country (execute contracts, engage staff or
contractors, comply with local telecommunications laws operating the IXP equipment)
without requiring a local subsidiary to be formed? Or will a local subsidiary entity be
| required?                            |     |     |     |     |     |     | 19  |
| ------------------------------------ | --- | --- | --- | --- | --- | --- | --- |
| 5.2 Regulatory - telecommunications  |     |     |     |     |     |     | 19  |
3. In New Zealand, Fiji and Samoa, what telecommunications-specific licenses and permits
| are required to operate the IXP infrastructure?  |     |     |     |     |     |     | 19  |
| ------------------------------------------------ | --- | --- | --- | --- | --- | --- | --- |
4. In New Zealand, Fiji and Samoa, what telecommunications-specific licenses and permits
are required by an Internet provider in a different country to connect to the IXP infrastructure
| using a subsea cable into that country?  |     |     |     |     |     |     | 20  |
| ---------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
| 5.3 Regulatory – national security       |     |     |     |     |     |     | 20  |
5. In New Zealand, Fiji and Samoa, are there national security obligations or ‘critical-
infrastructure’ requirements that the IXP will need to comply with?  20
| 5.4 Fairness – node-hosting vs long-line countries  |     |     |     |     |     |     | 20  |
| --------------------------------------------------- | --- | --- | --- | --- | --- | --- | --- |
6. How can costs and fees charged to service providers of New Zealand, Fiji and Samoa be

Pacific-IXP Operating Guidelines (August 2021) 4
adjusted in a fair way to counteract their cost advantage from avoiding requirement to acquire
subsea cable capacity compared to providers in non-node-hosting countries which are required
to pay for the international cable capacity to connect? 20
6. Next Steps 21
6.1 Constitution 21
7. Service Providers, IXPs, Regulators - please nominate up to 3 representatives to be involved
and work within the working-groups to actively draft the constitution, and discuss the
registration and formation of the entity to own and operate the Pacific IXP. 21
6.2 Multilateral Peering Agreement 21
6.3 Business Plan 22
6.4 Infrastructure 22

Pacific-IXP Operating Guidelines (August 2021) 5
Table of Figures
Figure 1. AP-IS Initiative Objectives 7
Figure 2. North-Pacific and South-Pacific Island Nations and Subsea cables 9
Figure 3. South Pacific Islands cable latency graph and Pacific-IXP nodes 11
Figure 4.Table of ‘closest node’ and cable latencies from each proposed member to
the closest Pacific-IXP node 11
Figure 5. Core Pacific-IXP Ring, and likely connection points 12
Figure 6. A simple IXP can consist only of a small number of Ethernet switches 14

Pacific-IXP Operating Guidelines (August 2021) 6
Glossary of Terms
TERM DEFINITION
AMS Amsterdam
AP-IS Asia-Pacific Information Superhighway
APNIC Asia Pacific Network Information Centre
ARP Address Resolution Protocol
ASN Autonomous System Number
AUIX Internet Association of Australia
BGP Border Gateway Protocol
BLP Bilateral Peering
DNS Domain Name Server
ESCAP Economic and Social Commission for Asia and the Pacific
GPS Global Positioning System
ICN Information-Centric Networking
IGF Internet Governance Forum
IP Internet Protocol
IRR Internet Routing Registry
ISOC Internet Society
ISP Internet Service Provider
IX Internet Exchange
IXP Internet Exchange Point
LINX London Internet Exchange
MAC Media Across Control
MANRS Mutually Agreed Norms for Routing Security
MLP Multilateral Peering
MLPA Multilateral Peering Agreement
NTP Network Time Protocol
PITA Pacific Island Telecommunications Association
ROA Route Origin Authorization
RPKI Resource Public Key Infrastructure
RU Rack Unit
SFP Small form-factor pluggable
UN United Nations
USA United States of America

Pacific-IXP Operating Guidelines (August 2021) 7
1. Introduction
The Pacific IXP proposal is a development of United Nations ESCAP Partner Bodies
stemming from a series of subregional workshops aimed at progressing the UN ESCAP has worked with the
Internet Society to conduct
Asia-Pacific Information Superhighway (AP-IS) initiative, and requests from
subregional training workshops
Pacific island nations to examine the feasibility of a Internet Exchange Point and raising awareness of national
for the whole Pacific islands community. strategies for improving Internet
traffic management in Pacific
island countries.
In particular, under AP-IS Pillar 2 ‘Internet Traffic & Network
Management’, ESCAP and the Internet Society (ISOC) collaborated on a
series of studies that showed a model for such an IXP traffic exchange was
technically feasible, and examined several possible operating models.
Figure 1. AP-IS Initiative Objectives
UN ESCAP Asia-Pacific Information Superhighway initiative
The Pacific-IXP proposal arose from requests by member states for UN
ESCAP to facilitate investigations on the feasibility of establishing a Pacific-
islands wide Internet exchange point.
These high-level designs have been the subject of consultations with relevant
key stakeholders in Fiji, Samoa and New Zealand, including government
departments, regulators, service provider association groups such as PITA
(Pacific Island Telecommunications Association) and existing domestic IXP
managers. All consulted stakeholders expressed support for developing the
concept further.
1.1 Current status

Pacific-IXP Operating Guidelines (August 2021) 8
Within the southern Pacific island nations, the largest nations have
increasingly been connected to the world using subsea optical fibre cables,
providing significant benefits of reduced latency and increased throughout
compared to the satellite-based connectivity traditionally used.
Many smaller Pacific island nations still use satellite connections, which
form a radio- based link directly from the island’s satellite earth station to a
far-end earth station which is typically located in the United States. All
traffic flows through this far-end link, typically located outside the Asia-
Pacific region, and then must find its way back if it is destined for another
Pacific island recipient.
Even service providers with optical fibre cable available to them tend to use
Satellite dishes in PNG
the cable to establish upstream connections with foreign Internet backbone
Many Pacific island nations
providers, with the consequence that often traffic from one pacific island to rely on satellite for their
another pacific island must literally travel around the globe, introducing large international communications.
delays (latency) and needlessly occupying capacity on expensive long-
distance cable and satellite capacity.
In one extreme example, traffic from Singapore to Tonga followed a path
around the world from Singapore first to London, then Boston in the USA,
through five distinct cities traversing the USA to San Jose, then to Fiji, then
to Tonga, instead of the shorter, direct path.
An Internet traffic exchange located within the Asia-Pacific area, where all
service providers from all Pacific nations can interconnect, will help keep
inter-island traffic local, greatly reduce latency of inter-island traffic, and
free up expensive capacity on the international long-haul connections,
reducing costs and improving reliability.
Primary role of an IXP is to keep local traffic within local
infrastructure, reduce costs, reducing latency, improving
performance.
This, in turn, will encourage content providers to establish
local connections and develop in-region digital skills.
By extending these benefits beyond purely national exchange points to an
international exchange infrastructure, island nations and service providers
without the inherent scale required to set up a national exchange can
collectively contribute to and connect to this Pacific-IXP and gain the
benefits of a local interconnection and peering, and in the process bring the
various island nations and networks closer together.
1.2 Sources and Resources
These guidelines are the distillation of Internet Best Practices guidelines and
case studies published by:

Pacific-IXP Operating Guidelines (August 2021) 9
• Internet Governance Forum (IGF) Best Practices Fortum on IXPs
(2015)
• Internet Society./Google ‘IXP Toolkit’
• EURO-IX Best Practices and Best Operational Practices
• LINX (London Internet Exchange) Best Current Practices
• And technical standards from Internet Association of Australia
(AUIX), Amsterdam AMS-IX, and Ireland’s INEX.
2. The Pacific-IXP Proposal
The Pacific-IXP is an internet exchange proposal to address the limited
Pacific-IXP
means of interconnection for Internet networks amongst the South Pacific An Internet Exchange Point (IXP)
to benefit all nations of the South
island community, located within the Pacific Ocean between Australia and
Pacific area.
New Zealand to the south-west and Hawaii to the north and east. A single integrated Internet fabric
spanning multiple anchor ‘node
sites’, providing every Internet
provider in every Pacific nation a
low-latency connection point to
interconnect with all other
member networks, while
minimizing the number of ‘cable
hops’ required to connect.
Figure 2. North-Pacific and South-Pacific Island Nations and Subsea cables
Pacific Island nations form naturally into two distinct groupings for telecommunications cable purposes
Nations in the North Pacific group tend to be interconnected by subsea cables
converging on the island of Guam, which has traditionally (along with
Hawaii) been used as a regeneration point and hub location, and increasingly
as a point of interconnection for cables in this region. Several existing IXPs
operate in Guam, enabling Internet providers in the islands around Guam to
interconnect and exchange traffic.
Nations in the South Pacific group, by contrast, have traditionally been
poorly served by subsea telecommunications cables until recently. In many
cases trans-Pacific cables between Australia, New Zealand and Hawaii have

Pacific-IXP Operating Guidelines (August 2021) 10
been laid that bypass smaller island nations without landing, so they cannot
be used. International Internet service in most of these countries has
traditionally been achieved using satellite technology, which has struggled to
keep pace with increased demand for reliable, low-cost and high capacity
connections.
South Pacific island communications traditionally uses
satellite links, which is a high-latency solution that doesn’t
provide local interconnection.
In recent years, several subsea optical fibre cables have been built amongst
the southern Pacific islands, and also trans-Pacific cables increasingly link
the islands to global Internet hubs in Australia, New Zealand and the United
States. The Pacific-IXP proposal is to utilise these cables to enable every
Internet provider in every Pacific island nation a low- latency connection
point to interconnect with all other member networks, while minimising the
number of subsea ‘cable hops’ required to connect.
2.1 Topology
The Pacific-IXP is envisaged as a single distributed Internet traffic exchange,
with nodes located in three locations - Fiji, Samoa and New Zealand, as
shown below:

Pacific-IXP Operating Guidelines (August 2021) 11
Figure 3. South Pacific Islands cable latency graph and Pacific-IXP nodes
Map of South Pacific Island subsea telecommunications cables by latency (one-way speed-of-
light transit time in milliseconds)
Internet service providers in almost every Pacific nation can connect to one
Papua New Guinea Note
of these three node locations with a single cable-hop (the exception being Papua New Guinea is connected
to Australia in Sydney via the
Solomon Islands, which needs two short cable-hops via Vanuatu on ICN2
PIPE cable and the newer Coral
and ICN1 to connect in Fiji). Sea Cable System. All paths to
the other South Pacific islands
pass through Sydney, so PNG
The locations of the three node sites were selected by analysing the one-way Internet providers will achieve
better performance connecting to
speed-of- light latency (expressed in milliseconds) along all known and
a Sydney-based IXP than to
under-construction submarine cables amongst the nations in the region. Pacific-IXP.
These three node sites minimises the average latency to a node site from all
Pacific Island nations, on a weighted-average basis (weighted by Internet-
using population), and forms the mathematically optimum topology for a
Pacific islands IXP.
Each node site is also well-connected by multiple subsea cable systems,
providing enhanced availability when a subsea cable breaks or is taken down
for maintenance.
Pacific-IXP node sites were determined based on: Optimum
minimal average Latency for all Pacific members
Two or more cable paths for diversity and resilience
Low-cost backhaul from Cable Stations to IXP datacenters
The table below sets out the closest node and measured (or inferred) latency
from all South Pacific nations expected to benefit from connecting to Pacific-
IXP, to their nearest Pacific-IXP node.
Figure 4.Table of ‘closest node’ and cable latencies from each proposed member to the closest Pacific-IXP node
Average latency (one-way speed-of-light time expressed in milliseconds) across all nations (weighted by Internet-using
population) is just 13 milliseconds.

Pacific-IXP Operating Guidelines (August 2021) 12
2.2 Inter-Node Links
The subsea cable capacity linking the nodes together will carry the shared
traffic amongst all participants in the exchange, destined for other members
that are connected to a different node.
The subsea cable capacity forms a triangular “ring” which provided inherent
protection against a cable outage, whether caused by a fault, by accident
(anchor drag) or for scheduled cable maintenance. If any leg of the triangle
fails, traffic amongst all three nodes will re-route around the remaining two
links to maintain connectivity.
Capacity of the core links may start at 10 Gbps, which is usually the smallest
unit of capacity that can be procured on a modern subsea cable. This should
provide ample room for anticipated peering traffic across the IXP system.
Figure 5. Core Pacific-IXP Ring, and likely connection points
Capacity of each leg should be between 1 Gbps up to 10 Gbps.
1. Question for Internet Service Providers (confidentially collected and
aggregated) what is current level of actual peak IP Transit across all
upstream connections?
Initial estimates of IXP trunk capacity will use 5% of all IP Transit traffic
levels. Anticipated to exclude major content provider traffic.
2. Question for Internet Service Providers (confidentially collected and
aggregated)
a. Please provide an estimate for how much of your current global
Internet Transit traffic (in Mbps or Gbps peak) might be exchanged

Pacific-IXP Operating Guidelines (August 2021) 13
with other Pacific Island region networks and traverse the Pacific
IXP network (for initial capacity planning)?
b. Please provide an estimate for how much of your current global Internet
Transit traffic (in Mbps or Gbps peak) might be sourced from global
Content networks such as Facebook, Google, Amazon, Microsoft, etc.?
Characteristics of Node Locations
Each Pacific-IXP node should be located in a secure datacentre with the
following characteristics:
• Neutral location for all likely participants (including commercial
non-telcos)
• Secure Power, Cooling/Humidity control, Secure access
• No or little onerous restrictions or costs for potential members to
access, install equipment, and establish connectivity into the location
• Low cost terrestrial connections (“backhaul”) from the IXP building
to other domestic locations, including the Cable Landing Station
where international connections will terminate.
1. Questions for National IXP Operators – what restrictions or costs
are involved for a potential member accessing the location where
the National IXP is located? E.g. another ISP, a commercial
organization such as a bank, a government agency, an international
ISP not licensed in this country?
2.3 Suggested Physical Infrastructure at each node site
The physical infrastructure at each node site may only require one or two
equipment cabinets.
Each of the three physical nodes should have the following key principles:
No single point of failure:
• Duplicated Ethernet switches – a member ISP will connect their
router to two switches, providing redundancy in case of a switch or
cable failure.
IXP-in-a-rack
An IXP need not be a large
• A single Route Server - each of the three nodes will have a route- or complex project – in
small cases the entire EIXP
server, and each member will connect to all three Route Servers, infrastructure can be
installed in a single cabinet.
including the Route Servers at the other two nodes. The three Route
Servers (one at each site) will be synchronised replicas of each other,
so there is no need for multiple Route Server servers at each site.

Pacific-IXP Operating Guidelines (August 2021) 14
Space for each Member to install a small router (suggest 2 RU per Member
should be sufficient) and tidy structured cabling system to the Ethernet
switches.
Ethernet switches to accommodate both copper RJ45 Ethernet ports (up to 1
Gbps), and pluggable optical fibre ports (1 Gbps and 10 Gbps Ethernet
SFP/SFP+).
1. Questions for Service Providers – what speed and technology port
would you wish to use to connect to the IXP?
*100/1000 GigE? Copper RJ45, or optical fibre?
*10 GigE?
Each node will have a Route Collector function which every participant must
peer with, which will be used to generate a LookingGlass webserver function
for diagnostics and troubleshooting.
Customer/Member connections should be 100 Mbps, 1 GigE, 10 GigE ports.
Optional services that could be served through the IXP:
• GPS-backed NTP (Network Time Protocol) Server at each node
• DNS Root Server (requires a small Internet Transit connection for
the IXP)
Figure 6. A simple IXP can consist only of a small number of Ethernet switches
(courtesy INEX – the IXP for Ireland)
Organisation Structure
3. Organisation Structure It is important the IXP operating
body is an organisational entity
that can execute contracts, own
The Pacific IXP should be operated by an incorporated entity constructed as assets, and operate the
infrastructure under the laws and
a cooperative or association of the members of the exchange. In some
regulations of each country
jurisdictions this structure is known as a “Company limited by Guarantee”. hosting a IXP node. The IXP
operating body should persist
even as members and individuals
come and go.

Pacific-IXP Operating Guidelines (August 2021) 15
The IXP hardware, processes, procedures and intellectual property are the
property of the IXP association.
The IXP association holds the contracts for services, such as renting
datacentre space, buying and leasing of transmission capacity, engaging
employees and contractors.
The IXP association will be registered and run as a not-for-profit
cooperative. Financial governance will need to be strong, and there should be
an independent accountant (who is not also a board member) involved in
preparing accounts for approval by the members.
All organisations that connect to the IXP should become members of the IXP
association. Membership allows for voting rights on matters involving the
operations of the IXP and the IXP Association.
The IXP association will need to be formed and registered in a suitable
jurisdiction such that the body is recognised and able to operate in each of
the three countries hosting the initial nodes.
3.1 Governance
All members nominate and vote on electing a small Board of Directors with a
Chairperson. Initial Board to comprise of 5 persons – one from each of the
three node- hosting countries, and two from providers of other countries.
Board members act in a personal capacity, not as representatives or
advocates for a particular country or member.
Propose the Chair role should be rotated no less frequently than every 3
years.
The Chair and the Board report to the Members of the IXP Association.
3.2 Leadership and Management
One person to be elected or engaged as the leader/General Manager/Head
Engineer. This person will possess extensive knowledge of the design and
engineering norms of the Internet and IXPs in general, and will lead the
development of the IXP, the development of detailed workflows and Simplified Organisation Chart
An IXP leadership team should be
standards as well as direct any staff.
small to minimise costs, but should be
responsible to the general membership
for policy development and structure.
The General Manager will report to the Board.
There will be at least one Site Engineer for each of the three node sites
providing ‘hands and feet’– these will report to the Head Engineer. Site
Engineers may not be a full-time role, and might be a shared resource already
working on the national IXP infrastructure. Ideally there will be sufficient
budget to pay the Site Engineers a small sum for the time they spend working
on the node infrastructure.

Pacific-IXP Operating Guidelines (August 2021) 16
We don’t expect the Pacific IXP to require a large staff to run. One Head
Engineer initially full-time, and three part-time Site Engineers should be
sufficient.
3.3 Operational staffing
To an ISP, an IXP connection is not mission-critical. An IXP connection
does not replace an upstream Internet Transit connection – an ISP still needs
one or more Internet Transit connections with upstream network providers to
provide global connectivity. If an IXP connection is down, then all networks
should still have connectivity through their respective transit connections, but
with higher latency. If a member’s connection drops for some reason, the
Member should be able to wait until the following day for the Site Engineer
to get to the site and rectify the issue.
For this reason, 24x7 staffed coverage is likely not required, at least in early
days. 8 x 5 business hours of attendance by a local Site Engineer, or even a
part-time say, Tuesdays and Thursdays scheduled attendance may be
sufficient.
3.4 Ownership of Equipment and Services
Ownership of equipment and services should vest with the IXP Association.
Any equipment or services donated by a member or other organisation
should be formally handed over in a written agreement and relinquished to
the IXP Association as an asset under the Association’s sole control. This
avoids any suggestion the infrastructure won’t be operated in a neutral
manner, and removes risk of essential infrastructure being withdrawn by
another owner.
3.5 Policy Development Process
The Pacific-IXP should be governed by the members for the members and
the Internet community, with the leadership team guiding and advising but
not controlling the policy development process.
The IXP will have policies that govern membership criteria and joining
processes, peering and interconnection policies, through to what services and
systems the IXP should provide, and potentially to pricing of services.
Most IXPs have a formal Policy Development Process, whereby any member
can:
• Propose a new policy or amendment to an existing policy,
• Debate the change or new policy amongst the members
• If there is a rough consensus formed, to vote on the proposal
• If the vote shows the proposal is endorsed, then to formally
implement the proposal

Pacific-IXP Operating Guidelines (August 2021) 17
4. Peering & Interconnection Policies
The following suggested elements of a peering and interconnection policy
represent best-practice for open, not-for-profit association-based IXPs,
documented further by The Internet Society and Google in the IXP Toolkit
Membership
(www.ixptoolkit.org). To be discussed and agreed or modified by the IXP
Every member of an IXP benefits
members. when the participation is as wide
and as many different
Membership and peering connection to be open to any organisation that agrees to participants as possible.
abide by the membership rules (policy and technical), including:
• Has been allocated a public ASN (Autonomous System Number)
• Has portable IPv4 and IPv6 address space that can be advertised to the IXP
An open IXP should be available to service providers, content providers,
commercial organisations (e.g. banks), academic institutions, government
departments – any entity that can justify being multihomed and an allocation
of portable address space and an ASN from one of the Regional Internet
Registries.
All participants must peer with the Route Collector for diagnostic purposes
A Route Collector is like a Route Server, except it doesn’t advertise any
routes. A Route Collector collects all participants routes and drives a
LookingGlass server for the whole IXP for diagnostic purposes.
Multilateral Peering (MLP) is strongly encouraged - participants may peer with
the Route Servers and instantly gain access to all other networks participating in
Multilateral Peering, with a single group of BGP sessions.
Bilateral Peering (BLP) is permitted – participants may establish individual
private peering relationships directly with other participants.
Participating in Multilateral Peering is a great improvement with regard
to scalability. The number of necessary BGP sessions in a full-mesh of
bi-lateral peering relationships increases with the square of members, and
every new member joining requires other existing members to set up a
new dedicated peering agreement and relationship. In contrast, by
connecting to the Route Server, all participants automatically receive the
benefit of a new member joining without any changes to the existing
configuration being required.
Multilateral Peering with the IXP’s Route Servers will require execution
of a MLPA (Multilateral Peering Agreement) with the IXP Association.
Bilateral Peering will be governed by whatever form of agreement is
determined between the parties, the IXP is not involved in bilateral
peering negotiations.
Provision of Internet Transit across the peering fabric is forbidden, advertisements
of a ‘default route’ will be filtered out.
The IXP infrastructure is intended solely to facilitate traffic exchange

Pacific-IXP Operating Guidelines (August 2021) 18
between member networks, not for the entire global routing table.
Internet transit traffic across the international backbone trunks is likely to
overwhelm the backbone trunks, which will have limited capacity.
Transit providers who wish to offer Internet Transit services should do so
using a private interconnect link directly between provider and customer
routers.
Participation in the international Pacific-IXP is independent of participation in a
domestic IXP. A service provider is encouraged to connect to both infrastructures
The Pacific-IXP will operate under its own ASN, different from a
domestic IXP, and (where they are co-located) a Member will need to
establish dedicated BGP peering sessions with the Pacific IXP
infrastructure, using a dedicated physical port on its router to prevent
congestion or issues with one IXP affecting traffic exchanged in the
other IXP.
A participant in a node-hosting country with a domestic IXP is likely to
experience peering sessions with the same other local provider(s) across
both domestic and Pacific-IXP infrastructures. Participants should use
route filters and preferences to prefer such traffic to pass through the
domestic IXP.
Participants will agree to comply with MANRS requirements for IXPs.
Participants will register all owned and customer routes with IRR and implement Common Technical Criteria
Most IXPs have similar
RPKI ROA records
acceptable traffic policies, which
are also codified in requirements
MANRS – Mutually Agreed Norms for Routing Security – are an for MANRS compliance for the
IXP.
important initiative to help protect the Internet from malfunctioning
See AMS-IX for examples
through deliberate or accidental actions. (https://www.ams-
ix.net/ams/documentation/allow
ed-traffic).
The IXP fabric will filter route advertisements from participants based on
registered Route Registry data and validated RPKI objects.
Participants will correctly register their route announcement intentions in
public Internet Routing Registry (IRR) through APNIC
(https://www.apnic.net/manage-ip/apnic-services/routing-registry/), and will
establish correct RPKI ROA objects for each of its own and customer
route objects prior to connection.
Participants must comply with technical rules around traffic sent to the Peering
Switch:
• Ethernet frames with Ethertype 0x0800 (IPv4), 0x86dd (IPv6), 0x0806
(ARP) only
• Only one MAC address per individual port
• No Proxy ARP or ‘link-local’ protocols
• No broadcast (except ARP), no multicast frames (except IPv6 Neighbour
Discovery)
• Others to be determined

Pacific-IXP Operating Guidelines (August 2021) 19
These are common best-practice criteria for traffic that is and is not acceptable
for members to push into the exchange. Such traffic can severely disrupt the
operation of the whole exchange. Participants that can’t comply will risk
being forcibly disconnected.
The IXP will implement controls using BGP community strings so that participants can
influence how routes are advertised through the TXP, and who the routes are
advertised to or blocked to.
There are common best-practice formats for introducing BGP community
strings, so that a participant can, for example, ensure peering routes aren’t sent
to a downstream customer, or to a peer that they are already connected with on
another IXP (such as a domestic IXP).
5. Questions to be resolved
5.1 Organisational
Benefits of a Not-For-Profit
1. In which country (or countries) should the ‘IXP Association’ be entity
A not-for-profit entity may
registered as an entity?
make it easier to attract
A corporate structure of ‘Company Limited by Guarantee’ where all involvement of non-
commercial entities such as
participants can be Members of the company is supported in New Zealand,
educational and research
Australia, Fiji. In Samoa a structure of ‘Incorporated Society’ might also be networks, Internet
suitable. governance organisations,
government institutions.
2. Can this entity operate in each node-hosting country (execute
contracts, engage staff or contractors, comply with local An independent (independent
from any member) corporate
telecommunications laws operating the IXP equipment) without entity may instil confidence
the IXP will continually
requiring a local subsidiary to be formed? Or will a local subsidiary
maintain neutrality regarding
open participation and equal
entity be required?
rights of participation.
Formation of a local subsidiary will add costs, compliance and reporting
overheads, and administrative overheads dealing with local ownership
aspects, voting rights, ownership of assets, and other matters. Ideally, the
IXP Association should be able to operate in practice in each of the three
node-hosting countries without requiring a separate local subsidiary to be
formed.
Considerations unique to
international IXPs
5.2 Regulatory - telecommunications Ideally no licenses or other
regulatory costs should be
required by an international
3. In New Zealand, Fiji and Samoa, what telecommunications-specific network that doesn’t have any
other local legal presence or
licenses and permits are required to operate the IXP infrastructure?
local services in order to
Relevant considerations include: simply connect to an IXP to
exchange purely international
traffic – similar to the
a) The IXP will not be constructing or owning communications link
freedoms of passengers in the
infrastructure such as cables. If the IXP requires a communications international side of airports,
‘outside’ the customs checks,
link for its own purposes (such as equipment monitoring) it will
when transiting between
acquire it from a local provider in the same way as any other
countries without entering
through ‘customs’.

Pacific-IXP Operating Guidelines (August 2021) 20
business.
b) All local participants will be bringing their own communications
links to the IXP location to carry Internet traffic.
c) The IXP may be buying or leasing international communications
links directly from the subsea cables landing in each country, or
indirectly buying or leasing the links through a local
telecommunications provider.
d) The IXP will not be providing services to the public (depending on
how this is defined in each country’s telecommunications
regulations).
4. In New Zealand, Fiji and Samoa, what telecommunications-specific
licenses and permits are required by an Internet provider in a different
country to connect to the IXP infrastructure using a subsea cable into
that country?
For example, if an Internet provider in Vanuatu wished to connect to the IXP
infrastructure in Fiji in order to peer with providers in New Zealand, or an
Internet provider in the Cook Islands wished to connect to the IXP
infrastructure in Samoa, what licenses or permits would the provider need to
acquire in Fiji or Samoa respectively?
Relevant considerations may include:
a) The international provider would not be providing services in the
node-country.
b) Include any restrictions or licenses required to install equipment in
the IXP node location
5.3 Regulatory – national security
5. In New Zealand, Fiji and Samoa, are there national security obligations
or ‘critical-infrastructure’ requirements that the IXP will need to
comply with?
Examples include:
a) Lawful interception of communications data for the local law-
enforcement authorities
b) Retention of meta-data about communications, but not the content
5.4 Fairness – node-hosting vs long-line countries
6. How can costs and fees charged to service providers of New Zealand,
Fiji and Samoa be adjusted in a fair way to counteract their cost
advantage from avoiding requirement to acquire subsea cable capacity

Pacific-IXP Operating Guidelines (August 2021) 21
compared to providers in non-node-hosting countries which are
required to pay for the international cable capacity to connect?
In other jurisdiction examples the hosting organisation pays a ‘hosting
charge’ to even up the costs compared to other participants that have
transmission costs.
6. Next Steps
6.1 Constitution
A draft constitution for the IXP Association Entity will be required. This will
need to be somewhat customised to the jurisdiction in which the entity is
formed, so potential members should agree on the jurisdiction first.
Stakeholders to nominate no more than 3 representatives to assist in driving
this process.
Stakeholders to agree on how costs for the process will be met, prior to the
IXP organisation being formed.
Timeframes will need to be agreed to:
• Draft the constitution
• Present the draft constitution for review and approval
• Following approval, to register and form the operating entity
7. Service Providers, IXPs, Regulators - please nominate up to 3
representatives to be involved and work within the working-groups to
actively draft the constitution, and discuss the registration and
formation of the entity to own and operate the Pacific IXP.
a) Name 1, position, email address, telephone number
b) Name 2, position, email address, telephone number
c) Name 3, position, email address, telephone number
6.2 Multilateral Peering Agreement
Best Practice Forum on IXPs, IGF 2016, Internet Governance Forum
One of the legal contracts that will be required is the Multilateral Peering
Agreement that members will need to agree and sign with the IXP
Association before they can connect to the Route Servers and commence
setting up peering relationships.
There are many public examples that can be used as templates to start from.

Pacific-IXP Operating Guidelines (August 2021) 22
6.3 Business Plan
A plan for operating the Pacific-IXP, including budgets, responsibilities or
members and IXP staff I required to ensure all agree on a realistic timeline of
activities and costs.
Why does an IXP need a business plan?
Whether the IXP is for-profit, not-for-profit or subsidized and regardless of the chosen organization
form, business planning can contribute to the stability, growth, sustainability and long-term
development of the IXP.
Some of the large European exchanges have shown that with the right business plan and strategy, a
not-for-profit membership-based IXP can become a business employing 50+ people with a turnover
of $15m per annum or more.
After the preparation and set-up phase of the IXP project (bringing participants together, getting
support and initial funding, installing the technology and successfully launching the IXP) the
attention needs to shift to the long-term growth and sustainability of the IXP. It is important to
understand however that developing a business plan and mindset is not a synonym for
commercializing the IXP.
6.4 Infrastructure
• Register for an initial IPv4 and IPv6 address block allocation, and
ASN allocation, for the use of the IXP from APNIC.
• Obtain suitable Ethernet switches, (initially two per node site),
servers, cabling and other hardware (note – may be donated, or
funded by grants. Should not be loaned in, to avoid risk of having to
return it).
• Set up IXP management software and systems such as the freely
available IXP Manager system developed by INEX and in use across
173 IXPs world-wide (https://www.ixpmanager.org/).
• Connect ISPs!