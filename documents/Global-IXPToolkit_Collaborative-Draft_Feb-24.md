Collaborative
Draft
The Internet Exchange Point
Toolkit & Best Practices Guide
How to Maximize the Effectiveness of
Independent Network Interconnection
in Developing Regions and Emerging Markets
February 2014

Author final: February 2014
Funding of the Internet Society’s IXP Toolkit Grant and Best Practices Project is provided by Google.
This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
Layout and design by Speckler Creative, LLC

Table of Contents
Executive Summary ................................................2 6.4. The Caribbean
Puerto Rico ...............................................61
Acknowledgements .................................................5
6.5. The Pacific
Introduction ..............................................................6 New Zealand .............................................62
Small Islands .............................................62
1. The Role of Internet Exchange Points .............8
1.1. Patterns of IXP Distribution, 6.6. Western Europe
Membership, and Geographic Scope........11 United Kingdom.........................................63
Netherlands ...............................................65
2. How IXPs Are Managed: Institutional
France .......................................................65
and Operational Models ..................................14
Ireland .......................................................66
3. Getting Started ...............................................17 6.7. Middle East
3.1. Summary of Best Practices in IXP United Arab Emirates ................................67
Development .............................................20
6.8. Eastern Europe
Albania ......................................................67
4. The Economics of IXPs ...................................22
Bulgaria .....................................................67
5. Benchmarking IXPs: A Methodology Czech Republic .........................................67
for Assessing Performance ............................34 Hungary.....................................................68
Kosovo ......................................................68
6. Case Studies and IXP Facts by Country .......48
Serbia ........................................................68
6.1. Africa
Ukraine ......................................................68
Kenya ........................................................50
Nigeria .......................................................53 6.9. North America
South Africa ...............................................54 Canada......................................................69
Tanzania ....................................................56
Annex 1. References and Resources .................70
Rwanda .....................................................56
Zambia ......................................................56 Annex 2. Sample IXP Policy Document:
Uganda......................................................57 Kenya .....................................................73
Reunion & Mayotte....................................57
Annex 3. Technical and Equipment
Egypt .........................................................57
Recommendations ...............................76
6.2. Asia
Annex 4. Glossary ................................................78
Hong Kong ................................................58
Indonesia...................................................58
Notes ......................................................................86
Mongolia....................................................58
6.3. Latin America
Brazil .........................................................59
Mexico .......................................................60
Bolivia........................................................60
Argentina ...................................................60
www.internetsociety.org 1

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Executive Summary T HE BENEFITS OF MAXIMISING LOCAL TRAFFIC
via independent Internet exchange points (IXPs) is
well-recognised as essential for facilitating a robust
domestic Information and Communication Technology
(ICT) sector. From a public policy perspective, ensuring
the presence of local IXPs has become an increasingly
important priority in order to make sure that online services
are equally accessible to all local users, as well as to enhance
competitive opportunities, and generally improve the quality
and affordability of Internet services.
So far IXPs have only emerged in about half the countries in
the world, and these vary greatly in scale and effectiveness.
To help accelerate the development of new and existing IXPs
this Toolkit has been created to describe best practices for
setting up and supporting the growth and enhancement of
these crucial Internet facilities.
Ideally, IXPs are needed in every region in which different
networks need to exchange local traffic. Deployment of IXPs
are, however, sensitive to a variety of local constraints, and
initiating and ensuring their efficient operation is not as simple
as it would appear, especially in emerging markets (where
IXPs are rare). Nevertheless IXPs are not a universal solution
to a country’s Internet and Internet access challenges. IXPs
can and often do complement and improve the functioning
of a local Internet ecosystem, but they cannot gloss over
problems such as lack of competitively priced international
or local capacity, nontransparent regulation, or poor energy
supplies.
Research into the experiences of IXPs around the world was
compiled for this report and the variety of case studies and
data about IXPs presented in Section 6 amply demonstrate
that: IP interconnection is still relatively new and there are a
wide variety of fees, institutional models, business models,
2 www.internetsociety.org

EXECUTIVE SUMMARY
In addition, aggregating outbound traffic and avoiding
tromboning is likely to be more critical in smaller secondary
city markets where local ISPs typically face higher transit
IXPS ARE IDEALLY NEEDED IN EVERY /’CITY
costs and longer routes to the desired content.
WHERE DIFFERENT NETWORKS NEED TO
At the same time, the scale, reliability, and geographic scope
EXCHANGE LOCAL TRAFFIC. THEY ARE,
of existing IXPs is growing. Many IXPs now offer multiple
HOWEVER, SENSITIVE TO A VARIETY OF LOCAL
sites, remote peering, and ‘partnership programmes,’ often
CONSTRAINTS, AND INITIATING AND ENSURING called service-provider or reseller plans. Such programmes
THEIR EFFICIENT OPERATION IS NOT AS leverage the benefits of the remote peering model and low
cost national or regional backhaul, minimising technical
SIMPLE AS IT WOULD APPEAR,.
support needs for the IXP and taking advantage of link
aggregation.
Regional extension of networks is also being encouraged
policy rules, and technical strategies adopted by IXPs across
in countries where the IXP may operate its own links to a
the world. Some of the choices made may have constrained
neighbouring city or country. In France, members of France-IX
growth in interconnection; in other cases, alternative IXPs
may freely use up to 100Mbps of connectivity between Paris
have emerged to fulfil needs unmet by the existing IXPs.
and Lyon, Toulouse, Luxembourg, and Italy, after which they
As a perusal of the case studies will show, IXPs vary need to purchase their own links.
immensely in scale (from a few 100Kbps of traffic to many
Global expansion of IXP presence is also a noteworthy recent
Tbps), in pricing and in institutional models — from free
trend. For example, Dutch IXP AMS-IX now operates an IXP
to use, to nonprofit cost-recovery, to for-profit. There are
in Curacao and Hong Kong, and is collaborating with KIXP
few geographic trends that can be deduced aside from the
to manage the Mombasa exchange in Kenya, while DE-CIX
commercial/noncommercial divide between the US and the
operates the UAE-IX, the Dubai exchange and DE-CIX New
rest of the world; but even this is now blurring with three
York. While increasing economies of scale and attracting new
European IXPs recently launching neutral membership-based
members are some of the motivations for this, demand for
services in the United States.
the skills and expertise developed at leading exchanges is
Nevertheless, in broad terms, three main models for operating another.
an IXP have emerged:
1. the for-profit carrier neutral data centre as typified
MANY IXPS HOST REGULAR SOCIAL,
in the United States;
TECHNICAL, OR INDUSTRY EVENTS TO HELP
2. the neutral nonprofit member-owned organisation
BUILD THE LOCAL COMMUNITY OF PEOPLE
operating on a cost recovery basis, with infrastructure
INVOLVED IN PEERING.
often hosted at a commercial data centre; and
3. the sponsored IXP, supported either by a ccTLD
manager, a regulator, an NREN, or a large network Another feature of many IXPs is the presence of domain-
operator. name server mirrors for a variety of gTLDs and ccTLDs.
However, surprisingly few IXPs offer a wider variety of shared
In the last two years, there has been a notable surge in the
services such as time servers, CERT, and software mirrors.
number of IXPs in secondary cities, particularly in Argentina,
Brazil and Indonesia, but also in secondary cities around the It is also noteworthy that policies that promote multilateral
world, including Arusha, Adelaide, Buffalo, Cork, Durban, peering are present among a significant number of IXPs on
Edinburgh, Grenoble, Leeds, Lyon, Manchester, Manitoba, either mandatory terms or incentivised through discounts
Mombasa, Port Harcourt, Saint Etienne, Toulouse, Turin, on the port fee for the invited party. The majority of IXPs,
Winnipeg, and Zurich. however, also offer bilateral peering and VLAN services and of
late, a few are beginning to offer VoIP or GRX type services.
This trend reflects increasing local content consumption,
decentralisation of content redistribution, and overall growth Many IXPs also host regular social, technical, or industry
in bandwidth demand built on the steady extension of high events to help build the local community of people involved
bandwidth cable and wireless networks. While most of this in peering and add another membership benefit. Twinning
growth has so far been in more developed economies, the programmes (programmes in which experienced IXPs partner
same trends are becoming evident in emerging economies. with developing IXPs) to support emerging IXPs have also
www.internetsociety.org 3

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
been adopted by some of the larger exchanges such as those minority of IXPs have 100Gbps services and below 1Gbps,
in London, Amsterdam, and Stockholm. Some IXPs also have ports may not be available or may even be free. (See page
created positions for policy staff in order to inform and educate 27, figure 4.6, for the annualised port cost for 1 and 10Gbps
local and global policymakers. ports at a variety of IXPs in different locations around the
world.) There is greater variability and inconsistency in
A significant number of IXPs are still operated without charge;
charges for 10Gbps ports.
however, the majority of IXPs have pricing for participation
ranging from simple joining free to charges almost equalling The case studies and data samples provided in this report
the cost of transit. We have seen that there is great variability draw on information from a variety of sources, including the
in fees, especially for smaller emerging country IXPs, many IXP websites, national ICT market profiles, and personal
of which may have donated space and equipment, and so are interviews for this study with IXP managers. In the course
able to minimise fees to attract members before moving on to of gathering this data, researchers found little consistency
achieving a cost recovery position. in the presentation of basic information on IXP websites.
Few IXP websites in emerging markets provide the three
main data points: pricing, membership policies, and peers
A SIGNIFICANT NUMBER OF IXPS ARE STILL lists. Traffic statistics are also missing from many sites while
some may show disaggregated data with the traffic history
OPERATED WITHOUT CHARGE; HOWEVER,
of each network connected to the exchange. In other cases,
THE MAJORITY OF IXPS HAVE PRICING FOR
information may be buried in a hard to find web link or may
PARTICIPATION RANGING FROM SIMPLE
not be current. Overall, only a small minority of IXPs operate
JOINING FREE TO CHARGES ALMOST websites that fulfil the basic requirements of a prospective
EQUALLING THE COST OF TRANSIT. peer for up-to-date, easily accessible information.
Further case study information and additional materials can be
found on the IXP Toolkit portal at http://www.IXPToolkit.org.
The most important variable in IXP pricing is port speed. This
* Note about releasing this “Collaboration Draft” of the Toolkit
may need to be balanced against membership fees (if any) or
and Portal. We plan to enhance and amplify many areas of
setup fees (if any) as well as the backhaul costs of getting to
the Toolkit in April, when we release v.1.0 of the Toolkit. Thus,
the IXP and the availability of link aggregation and discounts
the release of the IXP Toolkit & Best Practices Guide, now,
for second ports to allow smoothing the costs as network
as a “Collaboration Draft.” More input from the community is
needs grow (for example, a network needing 1.2Gbps could
essential. The Toolkit Portal (www.ixptoolkit.org) is meant
cost the same as 2X1Gbps ports or 1x10Gbps port without
to be a more detailed resource, and we also are asking for
link aggregation).
continuous feedback and information from the community.
In analysing the current costs for use of IXP services, 1Gbps Feedback about the Toolkit and Portal can be sent to
and 10 Gbps ports are the most commonly available. A feedback@ixptoolkit.org.
4 www.internetsociety.org

ACKNOWLEDGEMENTS
Acknowledgements T HIS DOCUMENT WAS DEVELOPED BY A
long list of individuals and from consultations
with many experts. We will cite proper
acknowledgments upon release of v.1.0 in late April.
For now, we offer a preliminary “thank you” to everyone
we have spoken with, worked with, and may come back
to for more data.
www.internetsociety.org 5

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Introduction An Internet Exchange Point (IXP) is simply a physical location
where different IP networks meet to exchange traffic with
each other with copper or fibre cables interconnecting their
equipment, usually via one or more Ethernet switches. They
keep local traffic local.
The benefits of access to these local traffic exchange facilities
are many, and are described in detail further below. IXPs are
now well recognised as a vital part of the Internet ecosystem,1
essential for facilitating a robust domestic ICT sector. From
a public policy perspective, ensuring the presence of local
IXPs has become an increasingly important priority in order
to make sure that online services are equally accessible to all
local users, as well as to enhance competitive opportunities,
and generally improve the quality and affordability of Internet
services.
IXPS ARE ONLY PRESENT IN ABOUT HALF
OF THE WORLD’S COUNTRIES, AND EVEN
WHERE THEY ARE PRESENT, MANY ARE NOT
FUNCTIONING TO THEIR FULL POTENTIAL.
Nevertheless IXPs are only present in about half of the world’s
countries,2 and even where they are present, many are not
functioning to their full potential. Most cities could benefit
from the presence of an IXP, but even large, highly industrial
1 See for example, the OECD’s recent report on Internet Traffic Exchange:
http://www.oecd-ilibrary.org/science-and-technology/internet-traffic-
exchange_5k918gpt130q-en
2 https://prefix.pch.net/applications/ixpdir/summary/
6 www.internetsociety.org

INTRODUCTION
countries such as Canada only have a handful of IXPs. It
turns out that IXPs are actually quite sensitive to a variety of
local constraints. Initiating them and ensuring their efficient IXPS ARE NOT A UNIVERSAL SOLUTION TO
operation is not as simple as it would appear based on their
INTERNET CHALLENGES IN A COUNTRY.
evident benefits, especially in emerging markets (where IXPs
THEY CAN COMPLEMENT AND IMPROVE THE
are rare).
FUNCTIONING OF OTHER PARTS OF THE
However IXPs are not a universal solution to Internet
INTERNET ECOSYSTEM SUCH BY PROVIDING
challenges in a country. They can complement and improve
the functioning of other parts of the Internet ecosystem A MORE COMPETITIVE ENVIRONMENT FOR
such as by providing a more competitive environment for PURCHASING CAPACITY, AND OFFLOADING
purchasing capacity and offloading traffic from congested
TRAFFIC FROM CONGESTED INTERNATIONAL
international links, but they cannot address problems such
LINKS, BUT THEY CANNOT ADDRESS
as lack of competitively priced international or local capacity,
PROBLEMS SUCH AS LACK OF COMPETITIVELY
non-transparent regulation, or poor energy supplies. For
further details on such issues, see the Internet Society report PRICED INTERNATIONAL OR LOCAL CAPACITY,
entitled Lifting Barriers to Internet Development in Africa.3 To NONTRANSPARENT REGULATION, OR POOR
help accelerate the development of IXPs this Toolkit has been
ENERGY SUPPLIES.
created to describe best practices for setting up an IXP and
supporting the growth and enhancement of existing IXPs.
To improve understanding of IXP dynamics, the Toolkit aims to this respect the Internet Society hopes that others will join in
address the following key themes and issues: the process of improving the Toolkit and that the document
will generate debate about how IXPs can best reach the next
• How IXPs make countries and regions more
‘level’ in order to fully benefit from the impact of maximal
economically and technically autonomous, including the
interconnection.
role IXPs play in improving regional interconnection,
fostering development of local content and culture and The Toolkit makes extensive use of case studies and IXP data
improving information security. that provide an illustrative survey of different types of IXPs
from around the world. These case studies and basic data
• The role of IXPs as ‘nerve centres’ of the networks that
are presented at the end of the document. Development of
comprise the Internet that help accelerate the spread of
the Toolkit has taken place in consultation with IXP experts,
Internet services, and improve access to critical Internet
network operators, and other relevant practitioners who
resources.
were provided with early drafts for review and comment.
• Learning from well-established IXPs in both developed
The intention is that this will be a living, iteratively refined
and developing countries with a view to localising,
document and that reader comments will be used to refine it.
and replicating the most effective strategies for IXP
The benchmarking methodology developed and outlined in
development in other, often smaller and less developed
detail in the document is to be tested with twelve selected IXP
countries and cities.
initiatives. Wider testing will take place if other IXPs choose
• Identification and explanation of the policy and regulatory
to participate in the online self-assessment opportunity. We
environment needed to ensure the viability and efficient
welcome comments and feedback on the IXP Toolkit, the
functioning of IXPs. This includes analysis of the role
methodology found in this Toolkit, and the IXP Toolkit Portal
played by the main stakeholders – the Internet industry,
(www.ixptoolkit.org). Send your feedback and comments to
government, civil society and the public.
feedback@ixptoolkit.org.
A key part of the Toolkit is a methodology that is intended
The Toolkit is aimed at all parties interested in IXPs (ICT
to assist in guiding strategy for establishing new IXPs and
market regulators, network operators, IXP managers, and
benchmarking the progress of existing IXPs. A key aspect is
content providers) and is designed for those who may not
to identify constraints that IXPs commonly face in growing. In
have deep technical knowledge of the intricacies of Internet
traffic exchange.
3 http://www.internetsociety.org/doc/lifting-barriers-internet-development-
africa-suggestions-improving-connectivity Examples of specific products and services mentioned in this
document do not imply endorsement by the Internet Society
or the authors of the Toolkit.
www.internetsociety.org 7

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
1. The Role of Internet T HE INTERNET IS NOT A SINGLE ENTITY, BUT
is made up of tens of thousands of independent
Exchange Points
networks1 that communicate with each other using a
common protocol (TCP/IP). As such, the key task of a network
operator is to ensure that its users are cost-effectively,
rapidly, and securely interconnected with any other point on
the Internet – be it a website on their own network or a user
connected to another network in the same city, or in a distant
part of the world.
In the quest for the shortest (fastest) and lowest cost routes
between two local points on the Internet, the most effective
strategy for networks that exchange traffic is to set up direct
physical links between each other. When many networks
are in the same location, however, establishing direct links
would be an expensive process, both in terms of capital and
human resource costs for maintaining separate links to each
network. This constraint has led to the emergence of shared
hubs, usually called Internet Exchange Points,2 through which
local networks are able to connect with each other simply by
establishing a single physical link to the exchange point (figure
1.1, following page).
To illustrate this further, we can use the following example.
As shown in figure 1.2 (following page), three local networks
connected to the Internet are able to pass traffic between
each other via the ‘upstream’ Internet.
But if two of the networks are close to each other in the same
city or country, it is usually better to use a separate connection
1 ASN data indicate that there were over 44,000 active autonomous networks
in mid-2013. See http://www.potaroo.net/tools/asn32/. Networks generally use
ASNs to communicate with each other, and are critical to certain Internet
protocols. ASNs are assigned by regional Internet registries (RIRs).
2 While there is no formally agreed naming convention, the most commonly
used terms are IXP, IX, or exchange point, often shortened to exchange. IXPs
are also called INXs, Network Access Points (NAPs), Peering Exchanges,
PIC, PIT, and PTT.
8 www.internetsociety.org

THE ROLE OF INTERNET EXCHANGE POINTS
for local traffic between the two networks rather than pay for
transit and international links, as shown below for ISP A and B
in figure 1.3.
However, when there are at least three3 local networks that
exchange traffic with each other, it is more efficient to set up
a hub (the IXP) to which each network can connect. Figure
1.4 shows how three ISPs would use a local IXP to route their
local traffic. An IXP can thus be viewed as the centre of a
group of local networks that makes it possible for local traffic
to traverse through a single connection from each network to
the hub.
Figure 1.1. Internet Exchange Point Model 1
(Source: http://mobileapps.gov.kn/?q=node/14)
IN THE QUEST FOR THE SHORTEST (FASTEST)
AND LOWEST COST ROUTES BETWEEN TWO
LOCAL POINTS ON THE INTERNET, THE MOST
EFFECTIVE STRATEGY FOR NETWORKS THAT
EXCHANGE TRAFFIC IS TO SET UP DIRECT
PHYSICAL LINKS BETWEEN EACH OTHER.
This connection to the hub speeds up local traffic by
Figure 1.2. Internet Exchange Point Model 2 (Source: Mike Jensen,
minimising the number of network hops needed to reach
2013)
other local networks, avoiding costly multiple direct links
being set up between each network. Connections between
local networks become much more responsive because of
the reduced latency (often up to 10 times) in the traffic which
has to make fewer hops to get to its destination, dramatically
improving the end-user experience when interacting with local
networks. This is similar to the development of airport hubs
where many different airlines are served. At these locations,
airlines exchange passengers between flights in much the
same way that networks exchange traffic across the IXP.
In this respect, the primary roles of an IXP are to improve
Figure 1.3. Internet Exchange Point Model 3 (Source: Mike Jensen,
network performance by keeping local Internet traffic local and
2013)
to reduce the costs associated with traffic exchange between
networks. This creates a ‘virtuous circle,’ resulting in several
important benefits and spinoffs from the IXP:
1. More bandwidth becomes available for local use because
of the lower overall costs of local capacity.
2. Expensive (and often congested) international capacity
is freed up when the local traffic is offloaded from the link,
3 The precise number of local networks needed before an IXP makes sense
depends greatly on the relative size of the individual networks, the overall size
of the market, the local infrastructure available, and thus the amount of local
traffic generated by each network. But if there are five networks present, an
IXP can almost always be justified. In small island economies, just two access
Figure 1.4. Internet Exchange Point Model 4 (Source: Mike Jensen,
provider networks may be sufficient in order to reduce long-haul traffic costs
2013)
and to promote traffic exchange with local content networks.
www.internetsociety.org 9

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
improving international access for local users (and vice- 7. International and regional transit capacity unit costs
versa for foreign networks connecting into the country). are also minimised because of the more competitive
market that is created when multiple off-shore operators
3. Networks can make substantial cost savings by
are present at the IXP. Evidence has shown that more
eliminating the need to put all traffic through more
expensive long-distance links to the rest of the world.
Networks can pass on these cost savings to their users
and/or use the savings to reinvest in improving and NETWORKS MAKE SUBSTANTIAL COST
growing their networks.
SAVINGS BY ELIMINATING THE NEED TO PUT
4. National economies benefit by reducing the export of ALL TRAFFIC THROUGH MORE EXPENSIVE
capital offshore because local networks pay less to
LONG-DISTANCE LINKS TO THE REST OF
international providers for traffic. From an economic
THE WORLD.
development perspective, this means more capital is
available to be invested locally to develop the domestic
economy.
choices in transit suppliers available locally results in a
5. Increasing the critical mass of the local Internet sector
more competitive transit market. An additional advantage
present at the IXP means that international and national
in the IXP environment is that it substantially reduces
providers are encouraged to build their own links to the
transactional costs in switching suppliers. Although there
IXP due to the larger market resulting from aggregation
may be constraints on switching suppliers contained in
of traffic at the IXP from different networks; this local
service contracts, if a network operator decides to switch
aggregation also further reduces off-shore capital flows.
transit providers at an IXP, this can be accomplished in
a matter of minutes and without physical intervention,
simply by changing a setting on the router. Without the
IXP, such a switch would involve having a new physical
circuit installed, thereby incurring significant waiting time
and additional financial charges. This market fluidity that
is made available through the use of an IXP encourages
greater price competition among transit providers, further
driving down costs for provision of Internet access.
8. Development of new local content and services that
benefit from higher-speed low-cost connections become
more attractive to establish. Download speeds for
websites improve dramatically, when they are connected
to the IXP rather than hosted internationally creating
Figure 1.5. Internet Exchange Point Model 4 (Source: Mike Jensen,
2013) greater confidence in the ability of local networks to
deliver content; this improvement can result in new or
existing businesses expanding from the increased value
As a result, IXPs can also become a location for local in delivering local content. There are also benefits gained
networks to source their international capacity, thus from the increased economies of scale and the larger
eliminating the need for multiple physical links between markets created by the broader user-base available
local and international suppliers (figure 1.5). In this via the IXP. In addition, more advanced local services
respect, IXPs help to encourage the development of local that require low-latency connections, such as VPNs,
telecom infrastructure such as national and international multimedia streaming and VoIP, become more viable.
fibre cables. Mobile operators that run local traffic through IXPs see
speeds increase almost immediately after an IXP has
6. When multiple international carriers are present at the
been set-up. When links between local networks rely on
exchange, the Internet also becomes much more reliable
satellite connections (as is the case in some developing
for local users because the connecting local networks
countries, especially outside the major cities), many
can spread their international capacity needs across
of these services cannot be provided with acceptable
more than one link or quickly switch providers if one goes
quality. As a result, a local terrestrial interconnection point
down.
is critical to ensuring their availability to users.
10 www.internetsociety.org

THE ROLE OF INTERNET EXCHANGE POINTS
9. With sufficient levels of participation at the IXP, a variety
of shared services also become viable to host at the IXP.
These include:
• Caches/mirrors of bandwidth-intensive international
content, such as YouTube (via its own Google Global
Cache) and other sources through third-party content
delivery networks such as Akamai. Such caching
acts to reduce international bandwidth requirements
and costs.4 Software caches and other types of static
content can also be hosted at the exchange to further
reduce the loads on long-distance links.
• DNS servers (root name servers and ccTLD name
servers) also increase the responsiveness of
the network to local users and improve resilience in
the case of international connectivity interruptions.
• A variety of shared administrative and technical
facilities for network operators, such as time servers,
routing and traffic measurement facilities, and public
1.1. Patterns of IXP Distribution,
key infrastructure (PKI).
Membership, and Geographic Scope
• The staff from different networks that interact through
the IXP often share experiences formally and
informally online and during meetings hosted by IXP
participants. Technical human-resource development NCE A NATIONAL EXCHANGE POINT HAS BEEN
O
potential in this respect has been notable at many established, additional exchanges might then be
IXPs around the world. set up to serve smaller geographic areas where it
is cost effective to keep traffic within the local area. Another
• The circle of technical experts across regions grows
reason to establish exchanges to serve smaller areas may
and “human networks of trust” are established among
be to deal with deficiencies in national infrastructure, such
experts, establishing a virtuous circle of experts who
as high cost, lack of network reliability, or dependency on
train and reinforce each other. These human networks
satellite-based links. This can be particularly relevant in
should not be underestimated as they provide the
developing countries where national backbone infrastructure
basis for collaborative interaction, in which experts
is poorly developed, congested, or costly — a common
are able to troubleshoot, find communities, and solve
situation when cities are still connected via satellite links or
problems within their circle. Face-to-face introductions
when monopoly pricing is in force. As a result of such factors,
are critical in the IXP community. Many of the first
IXPs are often useful in secondary cities as well.
Internet connections in developing economies were
established through these human technical networks, According to Packet Clearing House,1 in mid-2013 about 45
and experts continue to give back to the community. countries had more than one IXP and nine countries had 10 or
more IXPs — in order of rank: United States, Brazil, France,
Japan, Russia, Australia, Germany, the United Kingdom, and
Argentina. As can be seen from most of the countries on this
list, these are generally the larger or more densely populated
countries with mature Internet infrastructure markets, although
there are some notable absences in the list, such as Canada,
China, India, and Mexico.
4 For example, Google estimates that up to a 70% reduction in bandwidth 1 https://prefix.pch.net/applications/ixpdir/summary/
requirements for accessing Google services can be achieved by implementing
the Google Global Cache. locally. This further reduces off-shore capital flows
and improves the end-user experience when accessing this content (through
lower latencies).
www.internetsociety.org 11

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
|           |          |        |                |     | Number of    |
| --------- | -------- | ------ | -------------- | --- | ------------ |
|   Region  | Country  | City   | Exchange Name  |     | Participants |
  Europe  Netherlands  Amsterdam  Amsterdam Internet Exchange  472
  Europe  Netherlands   Amsterdam  Amsterdam Internet Exchange  472
  Europe  United Kingdom   London  London Internet Exchange  407
|   Europe  | Russia   | Moscow  | Moscow Internet Exchange  |     | 344 |
| --------- | -------- | ------- | ------------------------- | --- | --- |
  Europe  Germany   Frankfurt  Deutscher Commercial Internet Exchange  325
  Europe  Netherlands   Amsterdam  Netherlands Internet Exchange  294
  North America  United States   Los Angeles  One Wilshire Any2 Exchange  216
|   Europe  | Poland   | Warsaw  | Polish Internet Exchange  |     | 204 |
| --------- | -------- | ------- | ------------------------- | --- | --- |
  Latin America  Brazil   São Paulo  Ponto de Troca de Tráfego Metro  167
  Europe  United Kingdom   London  XchangePoint London IPP  166
  North America  United States   Seattle  Seattle Internet Exchange  151
  Africa  South Africa   Cape Town  Cape Town Internet Exchange  150
  Europe  Germany   Frankfurt  KleyReX Internet Exchange  138
  North America  United States  New York  New York International Internet Exchange  137
|   Europe        | France        | Paris   | Paris NAP                |          | 133 |
| --------------- | ------------- | ------- | ------------------------ | -------- | --- |
|   Europe        | Switzerland   | Zurich  |                          | SwissIX  | 132 |
|   Asia-Pacific  | Japan         | Tokyo   | Japan Internet Exchange  |          | 125 |
  North America  Canada   Toronto  Toronto Internet Exchange  116
  Europe  United Kingdom   London  London Network Access Point  114
|   Europe        | France     | Paris   |                           | Free-IX  | 106 |
| --------------- | ---------- | ------- | ------------------------- | -------- | --- |
|   Asia-Pacific  | Australia  | Sydney  | PIPE Networks Sydney      |          | 105 |
|   Europe        | Austria    | Vienna  | Vienna Internet Exchange  |          | 105 |
  Asia-Pacific  China  Hong Kong  Hong Kong Internet Exchange  104
|   Europe  | Italy  | Milan  | Milan Internet Exchange  |     | 102 |
| --------- | ------ | ------ | ------------------------ | --- | --- |
Table 1.1. IXPs with more than 100 Members (Source: ADD)
As shown in the figures 1.6 and 1.7 (following page), more  The number of participants at an IXP varies greatly, but the
than 350 IXPs are now operational worldwide.2 In general,  11–30 member IXP is the most common size (figure 6.8,
at least one well-functioning IXP is likely to be needed in  following page).
each country; however, only 99 countries have established
Table 1.1 lists the 23 IXPs with more than 100 participant
operational IXPs so far. As would be expected, developing
networks. They are mainly located in Western Europe and
countries have generally lagged behind the rest of the world
North America although a few of these also exist in some
in establishing IXPs, and Africa is the region with the fewest
cities of other regions, namely CapeTown, Hong Kong,
(only 21 of the 53 nations have them as of the end of 2013). Moscow, Sao Paulo, Sydney, Tokyo, and Warsaw. If the
membership of the three London IXPs is combined, London
2  https://prefix.pch.net
and the UK constitute the location with highest absolute levels
of IXP participation.
| 12  |     |     |     | www.internetsociety.org |     |
| --- | --- | --- | --- | ----------------------- | --- |

THE ROLE OF INTERNET EXCHANGE POINTS
ONLY 99 COUNTRIES HAVE ESTABLISHED
OPERATIONAL IXPS SO FAR. AS WOULD BE
EXPECTED, DEVELOPING COUNTRIES HAVE
GENERALLY LAGGED BEHIND THE REST OF
THE WORLD IN ESTABLISHING IXPS, AND
AFRICA IS THE REGION WITH THE FEWEST.
Figure 1.6. Map of IXPs around the World (Source: Telegeography)
Figure 1.7. Regional Distribution of IXPs (Source: PCH)
Figure 1.8. IXPs by Number of Members (Source: PCH)
www.internetsociety.org 13

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
2. How IXPs Are Managed: A VARIETY OF INSTITUTIONAL AND OPERATIONAL
models have been adopted to manage IXPs; these
Institutional and
fall roughly into five categories:
Operational Models
1. Not-for-profit independent organisation
2. Industry association of ISPs
3. Operator-neutral commercial/for-profit company
4. University1 or government agency
5. Informal association of networks
Except for the United States, where the for-profit commercial
model largely prevails, the most common of these models
today are IXPs operated either by a nonprofit independent
organisation or an industry association of ISPs. The former
is particularly common in Europe where many IXPs are
typically mutual, not-for-profit organisations whose members
collectively ‘own’ the facility. Operating costs are shared
among members who usually pay a one-off joining fee and
a monthly, quarterly or annual port fee. The fee may be
determined by the capacity of their connections to the IXP or
less commonly, by the volume of traffic that is passed across
the exchange.
Commercial IXPs are more prevalent in the United States and
are operated by specialized peering exchanges or data centre
companies such as CIX, Any2, and Equinix. These types of
specialist companies are almost always provider-neutral and
do not compete with networks in providing services to end
users.
1 The role played by National Research and Education Networks (NRENs) and
universities has been extremely important for IXP, local technical capacity,
and university network development. We plan to provide more information
about the role of universities and NRENs in the next iteration of the Toolkit.
See www.nsrc.net as an example of assistance to the development of NRENs
and IXPs, as well as excellent background information about the development
of the Internet in some countries.
14 www.internetsociety.org

HOW IXPS ARE MANAGED: INSTITUTIONAL AND OPERATONAL MODELS
A small number of IXPs may also be “free to use,” with no port
fees for participants, simply relying on donations of premises,
equipment and staff from large sponsors. The largest such
MULTILATERAL PEERING IS AN EFFICIENT
example is SIX in Seattle, Washington. This practice is also
AND COST-EFFECTIVE METHOD OF REACHING
common in the initial stages of IXP formation where founding
MULTIPLE PEERS AS NO TRAFFIC CHARGES
members are trying to gain critical mass, such as the Calgary
IXP (YYCIX), which has just been formed and is offering free APPLY AND ROUTE-SERVERS MAKE IT EASY
services to operators for the first year. TO CONNECT WITH NETWORKS THAT HAVE
Carrier/incumbent IXPs are often called “phony IXPs” where AN OPEN PEERING POLICY BECAUSE IT
the dominant Internet or telecom operator provides local IS NOT NECESSARY TO MAKE INDIVIDUAL
exchange points in one or two major cities. In these cases, the
AGREEMENTS WITH EACH MEMBER OF THE IXP.
IXP is more a marketing term used by the commercial transit
provider as it is really no more than a router offering peering
as a means of marketing local and/or international transit
own router and traffic is exchanged via an Ethernet switch.
services. These types of IXPs are unlikely to scale as few
The Layer 3 model may be less costly and simpler to establish
other major carriers are likely to be interested (or encouraged)
initially, but it is less scalable and limits the autonomy of its
to participate. These “phony” IXPs can be fairly easily
members who have less control over with whom they can peer
identified because they charge for traffic volume exchanged
and who are dependent on a third party to configure all routes
or levy a price per port that approaches international transit
correctly and keep routes up-to-date. The latter requires
costs.
greater technical skills from the IXP staff. The Slovenian
University run IXPs are often tied to NRENs and run by
IXP (SIX) is hosted at the Slovenian Advanced Research
a team of technical experts. These IXPs are an excellent
and Education Network (ARNES) and is an example of a
incubator for technical assistance and for knowledge sharing.
Layer 2 IXP. Members connect their remote routers via fibre.
VIX in Vienna and MOZ-IX in Mozambique are examples of
The latter is cost-effective for both SIX and its members.
University run IXPs.
Colocation requirements are much less demanding, as there
is no need for remote hands, and out-of-band access. This
Operational and Routing Policies
model, however, demands a secure Layer-2 infrastructure.
Operating policies are relatively uniform across most IXPs in
Remote equipment should not put the IXP in jeopardy, and
terms of the type of traffic that is allowed, although there may
all ports should be configured with appropriate port security
be some variations that reflect local conditions. In order to
mechanisms.
connect to an IXP, networks may be required to be recognised
Requirements for traffic-routing agreements between IXP
legal entities and must be licensed to operate (if a license is
members varies depending on the IXP’s institutional model
required).
and other local policies. A few IXPs require mandatory
Increasingly, any entity that needs to exchange traffic with
multilateral peering, in which anyone who connects with the
other IXP members is allowed to join. This option allows the
IXP must peer with everyone else who is connected. Perth IX
operators of private networks that provide public services
is one of the few examples of this model that usually creates
(such as hosting providers, government departments or
a disincentive for large access providers to interconnect
banks) to take advantage of the benefits of being present at
because these usually wish to only peer with other large
an IXP. In some cases, allowing large end-user-networks to
operators
peer at the IXP can be a sensitive issue for corporate Internet-
access providers present at the IXP who may feel that the Multilateral Versus Bilateral Peering
IXP is competing with their services. However, the value of an
Multilateral peering is an efficient and cost-effective method
Internet Exchange is proportional to the number of members,
of reaching multiple peers as no traffic charges apply and
so the more ‘non-licenced’ networks that join, the greater the
route-servers make it easy to connect with networks that
benefits to all in terms of performance, resiliency and cost of
have an open Peering Policy because it is not necessary to
international capacity required by individual members.
make individual agreements with each member of the IXP.
There have been two common models for IXP operation. The Since multilateral peering allows networks to interconnect with
older, now deprecated model is that the IXP exchanges all many others through a single port, it is often considered to
traffic between participating networks inside a single router. offer less capacity than bilateral peering. However, the benefit
This is usually called a Layer 3 IXP. The most common current of multilateral peering is that it can provide access to a
model is the Layer 2 IXP in which each network provides its considerable number of other networks.
www.internetsociety.org 15

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Many smaller networks, or those networks that are new it was ultimately constraining growth. Instead, JINX
to peering, find multilateral peering at exchange points an elected to charge an annual “hosting fee” to the network
attractive way to meet and interconnect with other networks. that hosts the exchange to balance the advantage.
Larger networks may also utilise multilateral peering to
• Passing traffic to the IXP destined for networks that are
aggregate traffic with a number of smaller peers or to conduct
not members of the IXP is usually not acceptable unless
temporary low-cost trial peering. Other networks may also transit is allowed and specific agreements with the IXP
enter private peering arrangements with each other where a and the members providing transit are made.
separate physical link (outside the IXP) is established directly
• Monitoring or capturing the content of any other
between the two networks.
member’s data traffic which passes through the IXP is
limited to data required for traffic analysis and control;
members usually agree to keep this data confidential.
MANY SMALLER NETWORKS, OR THOSE
• Mandatory provision of routing information and looking-
NETWORKS THAT ARE NEW TO PEERING, glass sites.
FIND MULTILATERAL PEERING AT EXCHANGE
• Routing and switch-port information can either be made
POINTS AN ATTRACTIVE WAY TO MEET AND public or restricted to members.
INTERCONNECT WITH OTHER NETWORKS.
• Security response provisions for infrastructure failures,
routing equipment failures, and software configuration
mistakes.
Some IXPs require each network to enter into bilateral peering
• IXPs do not normally compete with their members. They
arrangements with each of the other network members
normally do not provide transit facilities, for example,
(discrete Border Gateway Protocol (BGP) sessions across
although in the case of interlinked IXPs, they may do this
the exchange fabric). Other IXPs may also limit the use of
at low speeds. See the France-IX case study on page 65
the facility for transit traffic. Most IXPs, however, provide the
(6. Case Studies and IXP Facts by Country).
option of either multilateral or bilateral peering or a mixture of
The pros and cons of the different IXP business and
the two and do not restrict the nature of the transit or peering
operating models are discussed further starting on page
arrangements made between members.
34 (5. Benchmarking IXPs: A Methodology for Assessing
Flexible peering policies, which permit the coexistence of
Performance).
multilateral and bilateral peering arrangements, allow peers
at an IXP to enter into separate bilateral peering or transit
agreements. It is also usually acceptable for IXP members
to restrict (filter) traffic originating from or destined for any MULTILATERAL PEERING ALSO ALLOWS
member’s network in accordance with the member’s policies. SMALL- AND MEDIUM-SIZED NETWORKS IN
Multilateral peering also allows small- and medium-sized
MANY EMERGING MARKETS TO OPERATE
networks in many emerging markets to operate on a level-
ON A LEVEL-PLAYING FIELD RATHER THAN
playing field rather than be ‘allowed-in’ because of the size of
BE ‘ALLOWED-IN’ BECAUSE OF THE SIZE OF
their network. See the case study on BIX Hungary on page 68
(6. Case Studies and IXP Facts by Country). THEIR NETWORK.
Other important policies and strategies that IXPs and their
member networks normally adopt include:
• Payment for the cost of and management of the link
between the network and the IXP, including a redundant
link if required, is usually the responsibility of the
member. However, some IXPs have adopted policies to
level these costs so that each member pays the same
amount to access the IXP. This flat rate helps to ensure
that commercial operators that happen to be located
closer or are co-located in the same building as the IXP
do not have an unfair advantage. JINX in Johannesburg
had this policy in effect for some time, but found that
16 www.internetsociety.org

GETTING STARTED
3. Getting Started T his section provides a ‘how to’ operational guide
to setting up an IXP, drawing on the case study
examples and providing a checklist/summary table
of requirements. This section will be amplified via additional
outreach and feedback on the report. A simple checklist is
provided at the end of this section.
First Steps
The first step in considering the establishment of an IXP
is determining the need. This determination is based on a
provisional assessment of the number of providers (most
likely at least three) that are willing to support and use the IXP,
the amount of traffic that would be exchanged, and the likely
cost of setting up and connecting to the IXP. A meeting of local
network operators and technical advisers should be sufficient
to establish this. It is worth noting here that setting up an IXP
is “80% human and 20% technical” — without an environment
of cooperation between ISPs, an Internet exchange will not
be successful.
Building community support and expertise
If the outcome of the assessment proves positive, the next
step is to build support for the project among all stakeholders
and identify potential policy problems or market barriers to the
establishment of an IXP. Such problems and barriers usually
arise from either the potential members themselves or as a
result of inappropriate government policies.
The establishment of a local IXP is often seen as a threat by
competing commercial providers who may not be aware of the
full advantages of collaboration and local traffic exchange. It
may be important to engage local policy/regulatory officials to
obtain their support or understanding of the benefit of the IXP.
The latter was a successful tactic in Lesotho.
There can be other factors as well: lack of trust, a fear
of making business less costly for (or even subsidizing)
www.internetsociety.org 17

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
competitors, and concerns that interconnection means Regulatory Issues
stealing of customers. Experts have suggested an anonymous In most markets, IXPs are not regulated by any government
survey as one way to manage this process. These issues will policy. Most activity within an exchange is considered private
need some time to be managed, supported by awareness and is free from government regulatory oversight. In many
raising on the role of IXPs, before all the relevant parties developing countries, however, government policies restrain
may be in full support of the IXP. This stage can take months the establishment of an IXP in both direct and indirect ways.
or even years in some cases. The average start-to-finish of
Because IXPs only exist where there are ISPs that need
community-building is a 2–3 year process.
to exchange traffic, in many countries the presence of a
There may also be outstanding issues regarding participation monopoly service provider is probably the major reason
in the IXP when there is a dominant commercial Internet for the lack of an IXP. Alternatively, the lack of an IXP may
service provider in the market. Dominant providers may be indicate the existence of a single player with monopoly
resistant to participation or they may participate, but severely power over certain infrastructure or rights of way, such as
international gateways. If low levels of competition exist,
under-provision the link to the IXP. This under-provisioning is
networks may have little choice but to exchange domestic
known as the “Thin Pipe Stratagem.” In such a strategy, the
traffic via the dominant player rather than directly between
customers of competing ISPs encounter slow connections
themselves.
to dominant provider’s customers and understandably, the
customers of the competing ISP fault their provider for the In the immediate term, there may be little that can be done
poor connection. This creates a strong incentive for users to by potential IXP members to address problems related to
switch to the dominant service provider. If unsolvable by other monopoly market power. However continued lobbying of
means, this problem may be cause for regulatory intervention, government policy makers and regulators can ultimately
such as through infrastructure sharing or Significant Market help to open markets and relax restrictions on new market
Power (SMP) determinations. Opening the market to greater entrants. Without this type of activity, the dominant operator(s)
competition may be the most-effective long-term approach. will have little incentive to lower prices or improve services,
and to have a fair chance of entering the market, new
operators need fair access to the existing networks.
CONTINUED LOBBYING OF GOVERNMENT
Aside from working to improve the enabling policy
POLICY MAKERS AND REGULATORS CAN
environment generally, the regulatory body can also play a
ULTIMATELY HELP TO OPEN MARKETS AND more active role in assisting the establishment of IXPs. For
RELAX RESTRICTIONS ON NEW MARKET example, in Lesotho and Serbia, approval for the IXPs was
necessary through regulatory determinations to ‘allow’ them,
ENTRANTS.
while in Uganda the regulator assists in hosting the exchange.
Even where the market is open to more competition,
Some network operators may also be concerned that IXPs
incumbent telecom operators may still resist establishment or
could be overly complicated compared to their needs. This
participation in an IXP. Unfortunately, the incumbent operator’s
is especially the case for small network operators with only
views often carry great weight with regulatory authorities for a
one connection to the rest of the Internet who may not have
variety of reasons (such as close personal relationships, state
the technical expertise to implement multipath routing. This
shareholding in incumbent telecom operators or even outright
view may be amplified by contact with large developed-
corruption). The market position of the incumbent operator
country IXPs that may have much more sophisticated
also influences many developing-country policymakers whose
switches and powerful routers. Equipment marketing agents
governments are often dependent on revenues from state
can also contribute by proposing equipment that may not be
shareholding in the operator. As a result, policymakers may
appropriate for the needs of a small IXP.
be reluctant to sanction activities that are thought to limit the
To address these issues, further awareness raising and
incumbent’s profits, taking advantage of statutory or other
training activities may be necessary. At a minimum, potential
licensing requirements that might arguably be applied to IXPs.
members will need a staff member familiar with BGP used for
More often, the regulatory authority is, at least initially,
routing between networks, and each network will need to have
unfamiliar with the technical and economic aspects of Internet
a publicly registered ASN for their traffic exchange, obtained
facilities and ISP traffic exchange. IXP founders need to
from the relevant Regional or National Internet Registry (RIR/
address this and ensure that policymakers, regulators and
NIR). In view of the switch from IPv4 to IPv6 that is currently
incumbent operators are aware that reducing the cost of
taking place, familiarity with IPv6 configuration and IPv6
Internet connectivity for domestic consumers will generate
capable equipment is also desireable.
18 www.internetsociety.org

GETTING STARTED
greater investment, more users, and greater international • Proximity to the networks of the potential members. This
leased line revenues. may also depend on whether the IXP is to be centralised
in one room, located in a campus of adjacent buildings
In view of these factors, some governments have made it
or more widely dispersed across a broader area, such as
mandatory for networks to use a common peering point (e.g.,
by using fibre channel switched fabric.
Chile, see www.nap.cl). While this may superficially seem to
be a good policy, it may actually hinder growth by removing • Availability of electric power, including backup supply
the incentives for a commercial network operator to compet- or generator.
itively expand its connections beyond a single exchange.
• Availability of air-conditioning.
Other government policies that may need examination for their
• Availability, capacity, and reliability of telecommunication
dampening effect on strategies for the establishment of an IXP
links to the site.
include any limitations on self-provisioning of links between
network members and the IXP. Such policies may also include • Access to fibre facilities.
limitations on use of radio frequencies, on use of space on
• Ability to build antenna towers or dig trenches for fibre –
telephone poles, or on rights to dig up streets and lay cables
access to rights-of-way.
(i.e., use of rights-of-way, way-leaves, and easements).
• Ease of access. Independent 24/7/365 access for IXP
Defining the IXP’s operational and management structure member staff is highly desirable.
Once the IXP’s founding members have addressed the issues
• Quality of security. CCTV, 24-hour monitoring, fire and
above, it will be necessary to decide on the appropriate
break-in detection is highly desirable.
management structure and policies as described earlier. This
is most likely to be based on a form of independent nonprofit • Availability of ancillary equipment and services, e.g.,
company, but local conditions will likely determine the precise equipment cabinets and telephones, and so forth.
structure. After deciding on the most appropriate institutional
structure for the IXP, the required technical expertise will Business Plan Development and Financing
need to be identified and a technical committee established Once the design of the IXP and the site(s) have been
to design the IXP, assess costs, and find the most appropriate identified, a more detailed business plan can be developed
location to host it. An anonymous survey may be useful to which covers set-up and maintenance costs, proposed
help determine where to “host.” Some members may not want revenues, and cost recovery projections.
to discuss this in a group setting, and an anonymous survey
To help establish IXPs where they do not exist in developing
provides a way to do this.
countries, financial support may be available from appropriate
development agencies or donors. The World Bank and the
IXP Site Selection
Latin American Development Bank already have track records
Deciding on a location likely will include an assessment of
in this area. Since the financial assistance needed for the
existing facilities that could be used, and then comparing the
start-up costs of an IXP are relatively modest compared to the
potential location options to the cost and effort involved in
potential long-term economic benefits, a strong case usually
setting up a new independent facility. In many countries, costs
can be made for development assistance. As the majority of
associated with leasing space, financial resources, and hiring
IXPs are nonprofit facilities, financial aid can assist the growth
staff can be high. Hosting the IXP in an existing datacentre or
of the market without distorting its natural development.
carrier facility can substantially reduce start-up and operating
expenses. Existing facilities that might be considered include As the majority of the expenditure needed is on the initial
the premises of telecom operators, the facilities of university training of staff to establish and maintain the facility, donor
networks (particularly suitable as neutral locations), carrier- objectives in local capacity building can easily be met. A
neutral datacentres or facilities that support city emergency more severe problem with development financing from
services. donors is excess funding, which can result in ‘gold plating’ the
exchange — using high-end equipment with more capacity
The most important features of potential sites that would need
than needed and costly energy needs, making the IXP less
to be examined are:
sustainable in the long run. Estimates range for start-up
• The location to host the IXP. All involved parties must from US$100.00 for an Ethernet switch and a free host site
agree; without such agreement any of the other points to $15,000.00–$30,000.00 with donated equipment, power
below are moot. (If potential IXP members are at an costs, hosting, and other fees. Once the IXP is off the ground
impasse, an independent expert may be brought in to and exchanging traffic, then it can be steadily enhanced with
visit sites and provide an opinion. additional services and facilities, and via staff training.
www.internetsociety.org 19

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
7. Eliminating content-provider, foreign network (no local
operations except exchanging traffic at the IXP), and IXP
licenses where these are in place or being considered.
8. Mandating the sharing of essential facilities,
telecommunication infrastructure, civil works and access
to alternative infrastructure provided by transport and
energy operators, especially for land-locked countries.
9. Addressing issues that limit the ability of infrastructure
developers and Internet service providers to cross
borders, particularly the need for harmonisation of
regulations between neighbouring countries and the
lack of clarity from governments about permissions for
use of cross-border ROWs and areas designated as
“no-man’s land.”
10. Promoting awareness of the need for all local carriers,
ISPs and content providers to connect to IXPs so that
the development of local content is encouraged and the
aggregation of traffic is enabled, thus allowing developing
3.1. Summary of Best Practices
regions to become locations to which the international
in IXP Development providers wish to connect rather than continuing to be the
‘client’ regions where providers must pay all of the costs
of connecting to global backbones.
HIS SECTION SUMMARIZES BEST PRACTICES 11. Recognising the important role of the public sector in
T
from the point of view of the primary stakeholder financing infrastructure development in remote and less
groups: the IXP itself, national policy makers and population-dense areas that may not be initially profitable
regulators, ISPs, CDNs, and end users. for private operators. Related to this consideration is the
need for financing of redundant infrastructure in these
The following national ICT policy-level support policies
areas to improve the reliability of service provision.
increase competition in order to drive down prices and
improve the level of investment in local, national and regional 12. Increasing the support for information sharing and
infrastructure: multistakeholder consultation to understand and address
concerns of all affected parties in policy development
1. Mandating local loop unbundling and related facilities
and to build relationships and trust between the various
leasing.
players.
2. Mandating provision of access to dark fibre and related
13. Increasing the level of support for relationship building,
connection conditions, notably pricing.
technical training, and skills development to ensure that
3. Imposing limitations on the market power of incumbent network operators can more effectively use existing IXPs
operators (often termed “Significant Market Power”). and quickly implement IXPs in the countries where these
are not yet present.
4. Allowing self-provisioning of infrastructure by licensed
network operators. 14. Promoting awareness at the top levels of leadership
within government, in regional governmental agencies,
5. Reducing the cost and conditions of operator and
and in the international development assistance
spectrum licenses (such licenses often increase barriers
community, of the importance of IXP-related issues and of
to entry and, ultimately, costs to the end user).
implementing policy changes necessary to promote IXP
6. Eliminating special revenue-raising taxes (these increase
and Internet ecosystem development. National regulators
end-user costs and therefore reduce demand, e.g., sales
also need special focus and specific awareness raising
taxes on communications and import taxes/custom duties
events to help build internal awareness about the
on communication equipment).
importance of IXP development. These events could be
attached to existing fora such as the regional regulatory
association meetings.
20 www.internetsociety.org

GETTING STARTED
For network and IXP operators, among the most important
best practices include:
1. Holding forums, meetings, mentoring sessions and
training workshops to build human capacity and especially
to develop social networking and personal relationships
between the staff of different network operators in order to
build communities of trust. Such activities are particularly
needed to bring in additional network operators who have
not participated in information-sharing events and to
promote the recruitment of volunteers and “champions”
for the IXP.
2. Ensuring there is a staff position designated as ‘peering
coordinator’ (within network operators) to ensure that
network traffic is properly analysed for identifying peering
needs and opportunities, evaluating potential peering
locations, developing appropriate peering policies and
negotiating the best peering terms.
3. Aggregating as much traffic as possible at IXPs to build
critical mass, leverage economies of scale, and attract
SEE PAGE 76 (ANNEX 3) FOR A
content providers.
GENERIC LIST OF IXP TECHNICAL AND
4. Adopting simple IXP policies and fees that maximise
EQUIPMENT RECOMMENDATIONS.
potential membership. For example, IXPs that have
IXPS THAT HAVE BEEN IN OPERATION
mandatory multilateral peering policies are less likely to
be successful due to the limited interest of international FOR SOME TIME MAY CHOOSE TO SEE
transit and content providers in participating in these EURO-IX’S IXP WISHLIST AT HTTPS://
exchanges.
WWW.EURO-IX.NET/IXP-WISHLIST.
5. Taking advantage of the benefits of using IXPs for
voice interconnection between networks as the overall
communications environment moves toward IP-based
networks for both voice and data.
6. Promoting special peering relationships and transit traffic
agreements with academic networks in order to help
encourage human capacity development.
7. Adopting the use of tools such as PeeringDB and sFlow
to help identify peering opportunities, potential peers, and
peering locations.
www.internetsociety.org 21

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
4. The Economics of IXPs
HE GENERAL BENEFITS OF THE PRESENCE OF
T
IXPs have been described earlier in the Toolkit,
however the economic incentive for network operators
is often the most tangible benefit, and thus usually the initial
motivation to join an IXP, or to assist in their establishment
where there are none. Documenting the cost savings that can
be achieved by exchanging local IP traffic within the country
is often vital for making the argument to network operator
decision-makers to make the investments needed to join or
help set up the IXP.
Joining an IXP will be attractive if the cost of exchanging traffic
locally is cheaper than purchasing international bandwidth
(IP transit) from an upstream provider for routing the traffic
overseas. Given that international bandwidth can comprise
a significant portion of operating expenses for ISPs in
developing nations,1 an IXP can significantly reduce costs,
resulting in lower Internet access subscription charges for
users, provision of more bandwidth and making the costs
saved available for increased network build-out.
The financial attractiveness of an IXP is influenced by several
factors such as market structure and the volume of local
traffic. Due to market structure, a significant amount of traffic
may stay within an ISP’s network (i.e., “on-net” traffic). In this
case, typical of environments where only a few ISPs dominate
the market, there may be little incentive to participate in an
IXP. Another situation would be where most Internet traffic
is destined to users or websites overseas. An IXP would
be unlikely to ameliorate the necessity for international IP
1 Historically developing nations have had to pay for the full cost of the circuit
to overseas PoPs and addressing this has long been part of the Internet
governance agenda.
22 www.internetsociety.org

THE ECONOMICS OF IXPS
transit, at least in the short run. It could be argued that these
situations are characteristic of domestic market weaknesses,
Help us improve this report!
and untreated, are likely to impact the long-run sustainability
Future iterations of this report will contain examples from a range
of national Internet ecosystems. A healthy and competitive of emerging markets where IXPs are either just starting out or
Internet market is critical for affordability and innovation. have been operating for only a few years. Obtaining data to
The Internet market will never be deep rooted until there is conduct analyses is not easy due to a lack of basic published
significant local content available. The establishment of an data. Keeping track of basic traffic measurements or deploying
IXP can therefore be a trigger to financial viability for smaller open source software like INEX’s4 IXP Manager software
or new ISPs, resulting in greater market competition and is a simple way for an IXP to generate data.
stimulation of local content development.
Whether an IXP makes financial sense for ISPs can be
analyzed by comparing the cost of IP transit to the cost of
domestic peering.2 An example based on actual 2010 values
for the German Internet Exchange (DE-CIX) illustrates this
calculation.3 It is based on the assumption that all traffic is
destined for local termination although in reality this is rarely
the case. The cost of peering is calculated based on three
distances to DE-CIX: local, nearby and far. The cost of IP
transit has been estimated at US$3.50 per Mbps based
on interviews with several ISPs. Peering costs include the
variable transport charges to the IXP depending on location
as well as the common costs for a 10G port in the IXP,
Figure 4.1. Peering Cost Elements (Source: “The Business Case for
collocation fees and router amortization (figure 4.1).
Peering,” DrPeering International. Accessed 26 November 2013.
http://drpeering.net/core/ch5-Business-Case-for-Peering.html)
Table 4.1 shows the level of traffic required for the IXP to be
a cheaper alternative than IP transit (“break-even point”) for
Far Near Local
the various scenarios based on the IP transit cost of US$3.50
per Mbps. The break-even point is dependent on the volume
Transport into IX $6,000 $4,000 $2,000
of traffic and the ratio of local vs. international traffic. Given
Colocation Fees $1,000 $1,000 $1,000
the higher transport costs for ISPs that are further away, they
also require a higher level of traffic to break-even. Peering Fees $2,000 $2,000 $2,000
Note that some national fibre backbones and submarine links Equipment Costs $2,000 $2,000 $2,000
have relatively distance-independent pricing, which can affect
Total Cost of Peering $11,000 $9,000 $7,000
this part of the calculation. In addition, the local peering/IXP
IP Transit Price
fees may be much lower in a developing-country context (for
(US$/Mbps) $3.50 $3.50 $3.50
example, in Ecuador, the cost is about US$1/Mbps/month).
Table 4.1 also shows the minimum cost of using the IXP on Peering Break-even
the assumption that 70% of the 10G port will be utilized. Point (Mbps) $3,143 $2,571 $2,000
The key factor influencing the decision to peer in this example Minimum Cost for Traffic
Exchange (US$/Mbps)
is the volume of traffic. As the volume increases, the per-unit
(assuming 70% utilization
cost of peering decreases. If the ISP has sufficient traffic, then
of 10G port) $1.57 $1.29 $1.00
peering will be a less expensive option than IP transit. Figure
4.2 (following page) illustrates this, showing the different Table 4.1. Break-even Points for Hypothetical Peering Example per
Month in US$. Assumes all traffice is destined for local termination.
break-even points depending on the distance from the IXP.
(Source: Adapted from “The Business Case for Peering.” DrPeering
International. Accessed 26 November 2013. http://drpeering.net/core/
ch5-Business-Case-for-Peering.html)
2 A simple spread-sheet or web application could easily be created to allow
IXPs or prospective IXP founders to make the calculations of savings based
on local conditions — all that would be needed is the cost of domestic and
international capacity, number of links, and volume of traffic. Revenue angles 4 INEX is the Internet Neutral exchange located in Dublin, Ireland, www.inex.net.
that IXPs should consider will be included in the next iteration of this report. INEX developed and collaborates with IXPs around the world to improve its
3 “The Business Case for Peering,” DrPeering International. Accessed free software, IXP Manager, which enables IXPs to keep track of data, manage
26 November 2013. http://drpeering.net/core/ch5-Business-Case-for- IXP members, and provide more services to members. See the presentation
Peering.html. Also see http://www.ripe.net/ripe/meetings/regional-meetings/ by Nick Hilliard, INEX CTO, at http://www.internetsociety.org/events/serbian-
dubrovnik-2011/presentations/IXP%20Workshop%20Part%20I%20-%20 open-exchange-%E2%80%93-ixp-workshop.
Daniele%20Arena.pdf.
www.internetsociety.org 23

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Ecuador (2013)
Savings: US$7.2 million
NAP.EC currently exchanges about 6Gbps during peak
traffic. International transit costs in Ecuador hover around
US$100 per Mbps per month. By contrast, local traffic can
be exchanged at NAP.EC for as little as US$1 per Mbps per
month. Assuming that in the absence of NAP.EC operators
would exchange local traffic through international transit
routes (i.e., assuming no bilateral peering agreements), the
additional wholesale costs for local ISPs would be US$7.2
million per year.
Kenya (2012)
Savings: US$1.4 million
Figure 4.2. Peering Versus Transit Break-Even Point (Source: Adapted
ISPs credited all of their local traffic exchange to the impact
from “The Business Case for Peering,” DrPeering International.
of KIXP – stating that without the KIXP all of their traffic
Accessed 26 November 2013. http://drpeering.net/core/ch5-Business-
Case-for-Peering.html) would trombone. This means that without the IXP, the entire
current 1Gbit/s peak traffic exchanged through the IXP would
be carried over international transit connections. In terms of
A quick rule of thumb for determining the break-even traffic the cost of those circuits, there are a wide variety of values
point is dividing the monthly cost of connecting to the IXP by ranging from US$90–250 per Mbit/s of traffic per month for
IP transit costs (per month per Mbps). In many developing wholesale service. The differences in values reflect a number
regions, the cost of IP transit remains high so the amount of of variables, including traffic volume, use of self-owned
traffic required to make an IXP financially attractive is normally capacity, and routing; one source suggested an average
low. The key price breaker is the connectivity cost to get the value of US$120 per Mbit/s for international transit. Using
ISP’s traffic to and from the IXP. These domestic transport that relatively conservative value, the wholesale savings of
costs can often exceed the pure peering costs (port and exchanging 1Gbit/s at KIXP instead of using international
colocation charges), particularly as the distance to the IXP transit to trombone the traffic is US$1,440,000 per year.
increases.
Nigeria (2012)
In the following list, the economy-wide impact of the Savings: US$1.1 million
savings from domestic peering has been quantified for ISPs today are typically paying in the range of US$250–400
four developing countries. Note that the savings reflect per Mbit/s of traffic/month for international transit (the differ-
the estimated cost of IP transit if current IXP traffic had to be ences in values for wholesale services reflect a number of
routed overseas. (Kende and Jurpy 2012, Galperin 2013) differences between buyers such as traffic volume, route, and
use of self-owned capacity). Using an average cost of US$300
Argentina (2013)
per Mbit/s for international connectivity, the wholesale savings
Savings: US$12.3 million
of exchanging 300Mbit/s at IXPN instead of using international
The wholesale cost savings associated with local traffic
transit to trombone the traffic is US$1,080,000 per year.
exchange at the new IXPs can be estimated as follows.
Before the establishment of IXPs in other cities, NAP Buenos In addition to the quantifiable financial benefit, IXPs increase
Aires was exchanging around 2Gbps during peak traffic. competition in the market by providing another option for
Today traffic peaks are as high as 12Gbps. Assuming this exchanging traffic. This should put downward pressure on IP
additional 10Gbps of traffic was previously exchanged transit prices. Another distinguishing feature of IXPs compared
between local operators over transit agreements, and to IP transit, is that the former are much more transparent by
assuming a very conservative transit cost estimate of US$100 generally publishing their connectivity pricing and traffic levels.
per Mbps per month, the new IXPs are generating wholesale
Given that the financial benefits of an IXP include saving
savings of US$12.3 million per year. Even discounting
expenditure and providing a competitive alternative to IP
transport costs to the IXP (which as explained below
transit, it may seem surprising that there are still more
aggregate traffic from large geographical areas), IXP fees and
than 100 countries without one. Reasons include a lack of
related equipment costs, the savings are very significant, and
cooperation among domestic ISPs, policy and regulatory
tend to be higher for operators in less developed markets.
issues, as well as market structure. In the latter case, some
ISPs dominate the market, accounting for a significant portion
of domestic IP traffic that they may exchange within their own
24 www.internetsociety.org

THE ECONOMICS OF IXPS
Figure 4.3. IP Transit Prices in US$, Mbps/Month, 2011. Based on a full-port STM-1/OC-3 (155 Mbps). (Source: OECD)
network (i.e., “on-net”). Larger ISPs often have their own IP Community-based IXP development as noted has been
backbone arrangements, generally through participation in a an extremely successful IXP model. Bringing stakeholders
global telecommunication group. together is no easy matter in some countries and regions, but
the importance of community-building to create a sustainable
Such ISPs do not see a financial gain from open peering at
environment can not be underestimated. It may take years
an IXP since they would likely be receiving much more traffic
to build both trust among competitors and a sustaining
than they send. Take the case of Mexico, which at the end
environment, but this process is integral. From Ecuador to
of 2013, was the largest country (and only OECD member)
Malawi this process has led to the development of an IXP, and
without an IXP. It has significantly higher IP transit costs than
created a strong community of practice around the IXP and in
other OECD countries, all of which do have IXPs (figure 4.3).
the technical community.8
One reason cited for Mexico’s lack of an IXP is resistance
by the incumbent telecommunication operator that already
IXP Finances
generates significant on-net traffic and wants domestic ISPs
Although IXPs share the basic function of exchanging traffic
to use its IP transit services.5
among members, they vary widely in business models,
Despite the competitive impact on IP pricing and potential for operations, scope, and size. A key difference is market
lowering Internet access prices for consumers, it is somewhat orientation in terms of private versus cooperative ownership
surprising that many countries are not more supportive of and the setting of prices for price maximization versus cost
IXPs. This is even more puzzling considering international recovery.
consensus encouraging IXPs.6 Governments can foster an
Another difference is that IXPs vary tremendously in size,
enabling environment for IXPs through various steps, such
a function of the level of Internet market maturity as well as
as supporting community-based IXP development; nurturing
geography and population (figure 4.4, following page). These
consensus-building among industry stakeholders; promoting
factors influence the range of services provided, operational
local content; lowering or eliminating taxes for computer
performance, and pricing that impact IXP finances.
hardware and software; stimulating competition in national
and international IP transit markets and other pro-Internet Regardless of the institutional set-up, even nonprofit-oriented
policies. A light handed regulatory approach is favored so as IXPs need to recoup costs to achieve sustainability. Therefore
not to affect incentives to expand the market.7 revenues need to be sufficient to cover expenses plus an
allowance for reinvestment. In deciding how to price services,
IXPs need to ensure that they are a competitive alternative
to IP transit, bearing in mind the transport costs ISPs incur
5 Toward Efficiencies in Canadian Internet Traffic Exchange, Bill Woodcock and
Benjamin Edelman. p. 10. OECD. OECD Review of Telecommunication Policy
and Regulation in Mexico, 2012. http://www.oecd.org/sti/broadband/50550219.
pdf. 8 In our next iteration, we plan to highlight the key roles individuals have played
6 For example, the 2013 International Telecommunication Union’s (ITU’s) World in starting IXPs. In some countries, the volunteer efforts of one or two people
Telecommunication and Information and Communication Technology Policy and/or the support of technical experts from the network operator group com-
Forum adopted “Opinion 1 on Promoting Internet Exchange Points (IXPs) as munity and national research and education community have catalyzed the
a long-term solution to advance connectivity.” See https://itunews.itu.int/En/ development of the IXP and IXP community of practice.
4140-Promoting-Internet-exchange-points-to-advance-connectivity.note.aspx.
7 ITU. “Internet Exchange Points (IXPs).” WTPF Backgrounder Series, May 2013.
www.internetsociety.org 25

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
• In addition to port charges, the Malaysian Internet
Exchange (MyIX) also charges for the volume of traffic.12
• The Internet Service Providers’ Association (ISPA) of
South Africa exchanges (CINX, DINX, and JINX) have
different port charges for members and nonmembers.
In addition, members must be of the Large category to
lease 1Gbps or 10Gbps ports and at least in the Medium
category to lease a 100 Mbps port. The categories are
determined by fees paid. Nonmembers are not allowed
to lease 10Mbps ports (table 4.2).13
There are several port capacities on offer at IXPs around
Figure 4.4. Peak Traffic and Members of Selected IXPs, 2013. the world. Smaller IXPs offer capacities as low as 10Mbps
Logarithmic left scale (Source: Adapted from IXP websites) whereas some of the larger IXPs are starting to provide
100Gbps ports. Knowing what port sizes to offer requires
the IXP to monitor usage, particularly when members are
to connect to the exchange. Otherwise, peering at the IXP
leasing multiple ports due to the lack of higher capacity ports.
will not be financially attractive for ISPs.9 For this reason it is
This must be balanced against the requirements of members
crucial for IXP sustainability that there is a competitive market
that could be disadvantaged if small port capacities are not
in national capacity to reach the exchange.
available. One way of matching capacity to ISPs needs is to
IXPs earn income through a variety of fixed and variable
allow members to resell extra capacity. Also of note here is
charges. Fixed charges can include membership fees; port
that some IXPs offer port aggregation and/or fractional port
charges (also known as usage charges) are variable. Some
charges to smooth the upgrade costs from one speed to
also earn revenues from charging for colocation, operating a
the next.
CERT, or providing other services.
Some ccTLD registrars support IXPs through the significant
source of revenue derived from domain name registrations.
IT IS CRUCIAL FOR IXP SUSTAINABILITY
For example the National Internet Exchange of India earned
THAT THERE IS A COMPETITIVE MARKET
two thirds of its revenue from registrations for the .IN TLD in
IN NATIONAL CAPACITY TO REACH THE
its fiscal year ending March 2010 (NIXI 2010).
EXCHANGE.
Many IXPs recoup a significant portion of their costs via
usage charges (by specifically charging for a port of a specific
capacity at the exchange) and via membership fees. While
The lease price logically increases with the size of the port
we are not suggesting that this is a common practice among
but on a per bit basis, the larger ports are significantly less
IXPs, following are additional policies specific to port charges
expensive. For example a 100Gbps port on the Amsterdam
on which we were able to find data:
Internet Exchange costs 10 times more than a 1Gbps port,
• In India, in addition to port charges, there are also traffic
e.g., the monthly per Gbps charge of a 100Gbps port is
payments with the National Internet Exchange of India
US$64, compared to US$643 for the 1Gbps port (figure 4.5,
(NIXI) settling the amounts between ISPs based on net
following page). Therefore scale is critical since marginal
traffic flows. Content providers (i.e., having outgoing
costs come down significantly with each increase in port size.
traffic more than five times incoming traffic) are charged
There is a large variation in port charges among IXPs. A
proportionally more.10
review of 1Gbps port charges shows that the least expensive
• At the Hong Kong Internet Exchange (HKIX) there are
offer differs from the most expensive by a factor of over four
no port charges and instead participants provide their
(figure 4.6, following page), not taking into account IXPs that
own equipment.11
do not charge for ports, but earn income in other ways. The
9 In Kenya, the revenues outweighed the cost savings 4:1. Connecting 12 See “MyIX Subscription Form” at http://myix.my/services/
to the exchange was more cost effective compared to the cost of joining 13 http://ispa.org.za/inx/inx-policy/
and connecting to the exchange.
10 http://nixi.in/en/routing-and-tarrif-policy
11 http://www.hkiz.net/hkix/policies.htm
26 www.internetsociety.org

THE ECONOMICS OF IXPS
variation is even greater among 10Gbps port offers where
the price magnitude between the least and most expensive
is eight. Port charges can vary due to the price of equipment
in the national market, the quality of the equipment, taxes
and labor costs. There may be ‘off-list’ prices negotiated
with larger networks to encourage them to join. Optional
membership fees also influence port charges (e.g., in the case
of South Africa, nonmembers of the IXP pay significantly more
than members).
The volume of an IXP’s traffic does not seem to have
significant influence on the price. The Amsterdam exchange
has by far the highest traffic among the IXPs studied yet port Figure 4.5. Monthly Port Charges in US$ on the Amsterdam Internet
pricing falls into the middle range. The average price for a Exchange. Converted to US$ using 2012 annual average exchange
rate. (Source: Adapted from AMS-IX information)
1Gbps port was US$6,921 per year and US$18,763 for a
10Gbps port among the IXPs studied.
An IXP must pay careful attention to operating expenses to
reduce costs for members and ensure that it remains a viable
alternative to IP transit. Personnel, energy and premises form
a significant proportion of operating expenses for IXPs. Many
IXPs may be able to obtain premises at low cost or free, such
as via a university, government office (the regulator), or a data
centre that sees value in an IXP for attracting other tenants.
Some of these costs can be mitigated through the cooperative
nature of many IXPs. For example members could defray
some personnel costs by carrying out some activities and
there may be scope for bringing in interns willing to work for
less or free in exchange for the experience. Similarly some
IXPs can lower their building rental by locating in data centres
that see their presence as an attraction for other customers.
A further example of how member-led IXPs can help reduce
costs is through cross-connect pricing. These are the charges
to provide fibre-based connectivity between peering equipment
in the exchange. The cost of cross connects are significantly
lower in Europe where the model of cooperative IXPs is
prevalent compared to North America (figure 4.7, following
page), where for-profit companies typically provide exchange
services, and in some markets there are “veritable monopolies.”14
Some IXPs have noted that the difference in cross-connect
pricing is a function of the competition in the colocation market in
a specific city.
Depreciation is also a significant expense item. Given the
technological nature of IXPs, it is critical to ensure that
sufficient funds are set aside for reinvestment in hardware,
software and services. Estimates of the capital expenditure
14 Higginbotham, Stacey. “With Help from Netflix, a Internet Exchange That Can
Change the American Bandwidth Landscape,” Gigaom, 3 December 2013.
http://gigaom.com/2013/12/03/with-help-from-netflix-a-internet-exchange-that-
can-change-the-american-bandwidth-landscape/.
Figure 4.6. Annualized Port Charges in US$, 2013. *=Nonmembers
(Source: Adapted from IXP information)
www.internetsociety.org 27

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Figure 4.7. Average Fibre Cross-Connect Price in US$ by Metro Area, Figure 4.8. IXPs and the Virtuous Circle (Source: Author)
H1 2013 (Source: Telegeography, http://www.telegeography.com/press/
press-releases/2013/09/24/u-s-europe-colocation-pricing-models-vary-
significantly/index.html)
for launching an IXP vary, particularly as organizations like use, coupled with faster access to local websites, attracts
Cisco, the Internet Society, the Network Startup Resource content providers. They benefit from better response times to
Center (NSRC), and PCH can provide donated equipment their services, which generates additional income. Growing
at startup and as an IXP “levels-up.” One source estimates traffic at the IXP spurs investment in national backbone
the investment for starting an IXP at between US$40,000– infrastructure in order to connect other parts of the country
100,000, an amount that could be recouped fairly quickly to traffic exchange services. These factors, coupled with
provided there is sufficient traffic (Woodcock and Edelman important human capacity gains as technical skills become
2012). enhanced, contribute to the sustainability and expertise of
the IXP, allowing it to offer additional services and assume an
Few IXPs publish traditional annual reports containing
important public policy role for the industry.
income statements, balance sheets and other financial and
operational information15—in carrying out the research for
Internet Use
this report only three could be found (AMS-IX, Czech IXP,
The speed and latency requirements for various cloud-based
and NIXI (the last being somewhat dated (2010)). Given
Internet services can be classified into basic, intermediate and
that few IXPs formally disclose financial and operational
advanced (table 4.3, following page). In order to use the most
data, it is difficult to analyse revenues, cost recovery, and
advanced services, a latency of less than 100 milliseconds
investment strategies for the overall industry. Tracking and
(Ms) is required. This requirement provides an important
making operational and financial metrics publicly available
impetus for the creation of IXPs. By keeping local traffic local,
would benefit the global IXP community by providing data for
they dramatically reduce latency.
comparable industry benchmarking.
High latency impacts the Internet user experience. Telecom
IXPs and the National Internet Ecosystem
equipment manufacturer Nokia estimates that latency is
As IXPs expand, they trigger a virtuous circle for national more important than access speeds for applications such as
Internet ecosystems (figure 4.8). By keeping domestic IP VoIP, music downloading and gaming (NSN 2009). Users
traffic local, IXPs enhance performance. This in turn makes are becoming more sensitive to latency and will stop using
content, services and applications more attractive to use,
applications that take too long to load. On the other hand,
growing the Internet market. In addition, prices are lowered
when applications load quickly, they are more attractive and
since costly IP transit is avoided, saving money for consumers
drive demand and increase penetration.
and increasing Internet penetration. The growth in Internet
Routing IP packets overseas via long-haul traffic routes
implicitly doubles latency since a round-trip is required. With
15 This refers to neutral multilateral peering IXPs. There are private companies an IXP, traffic does not have to travel abroad and then return.
that provide IXP like services but more commonly provide hosting type
As a result users can enjoy applications that they would
services for participants to interconnect.
not have been able to use before because latency was too
high. This should help to drive higher Internet take-up. The
reduction in latency from the establishment of an IXP has been
28 www.internetsociety.org

THE ECONOMICS OF IXPS
BASIC INTERMEDIATE ADVANCED
Download: 750 kbps Download: 751–2,500 kbps Download: >2,500 kbps
Upload: 250 kbps Upload: 252–1,000 kbps Upload: >1,500 kbps
Latency: 160 ms Latency: 159–100 ms Latency: <100 ms
Single Player Gaming ERP/CRM 3D Video Streaming
HD Video Streaming
Text Communications (Email, IM) HD Video Streaming
Multiplayer Gaming
Stream Basic Video/Music Stream Super HD Video
Online Shopping
Web Conferencing Connected Education/Medicine
Social Networking
Web Brownsing (Multimedia/Interactivity) Group Video Calling
VoIP (Internet Telephony) Video Conferencing Virtual Office
Table 4.3. Levels of Cloud Sophistication and Related Quality of Service Requirements. Note that concurrent and multiples instances of
applications will require faster a network. (Source: Adapted from http/:www.cisco.com:en:US:netsol:ns1208:networking_solutions_sub_sub_
solution.html)
documented in a number of studies. For example, the creation Content
of the Kenyan Internet Exchange Point (KIXP) reduced The improved latency provided by the IXP coupled with the
latency from 200–600Ms to 2–20 (Kende and Hurpy 2012). growth in Internet use and neutral peering attracts other
players to join. They include domestic companies, government,
In addition, since IP transit is avoided for domestic traffic, the
the educational sector, the banking sector, international
cost of supplying Internet access is reduced. As a result ISPs
content providers and Content Data Networks (CDNs).
can offer cheaper Internet access packages to consumers.
Some ISPs charge lower prices or offer higher or no caps As we noted earlier in this report, lower latency helps to foster
on user Internet charges for domestic traffic.16 The lower the development of domestic content and services. National
prices help to stimulate demand for the Internet and increase websites that had previously been hosted abroad will find it
penetration. more attractive to connect to the IXP if most of their customers
are local. In Colombia, although adequate international
bandwidth to the United States results in latency of about
45ms, for local traffic it is only 3Ms, providing a strong
HIGH LATENCY IMPACTS THE INTERNET
justification for hosting content in the country (Galperin 2013).
USER EXPERIENCE. TELECOM EQUIPMENT
Not only will access to domestic sites improve, but local
MANUFACTURER NOKIA ESTIMATES THAT companies also can save on overseas hosting and transit
LATENCY IS MORE IMPORTANT THAN ACCESS charges. Thru Vision, a Malaysian web development company
is hosted in the same datacenter with the Malaysia Internet
SPEEDS FOR APPLICATIONS SUCH AS VOIP,
Exchange (MyIX) and notes the benefit to local websites of
MUSIC DOWNLOADING AND GAMING (NSN 2009).
the extra redundancy of having multiple ISPs in the same
facility.17 In Malawi, local banks have begun discussions with
the IXP as the IXP can provide a more stable and reliable
Growing local traffic also increases revenue for ISPs. In environment.
Kenya, ISPs offering mobile data services saw their traffic
Hosting a country’s top level domain (ccTLD) and generic
increase by at least 100Mbit/s due to the presence of the IXP.
top level domain (gTLD) root servers at the IXP enhances
This triggered an estimated US$6 million increase in revenue,
quality through faster domain name resolution and increases
as the ISPs charge by the MB for data (Kende and Hurpy
resiliency for websites using those domains. The root server
2012).
for Kenya’s ccTLD (.ke) is connected to the Kenyan Internet
16 In South Africa, Telkom does not have a data cap for its ADSL packages when 17 http://www.thruvision.com.my/resources/benefits-web-hosting-hosted-
accessing servers hosted in the country. http://residential.telkom.co.za/broad- malaysia-internet-exchange.html
band-internet/broadband_services/adsl/cost_dsl_cost.html
www.internetsociety.org 29

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
The improved quality of service and growing Internet market
is appealing to international content and service providers.
Revenues from the service offerings of large Internet
companies such as Amazon, Google and Microsoft are
particularly sensitive to response times (NSN 2009), giving
them an incentive to take advantage of reduced latency.
Google’s Global Cache (GGC) program places servers in IXPs
to improve performance and typically can handle between
70–90% of its traffic.19 Experiences from Latin America
demonstrate the impact from GGC. In Ecuador, the installation
of GGC at the IXP increased the importance of peering
for other networks. Latency for local content is reported at
about 20Ms, compared to 150Ms for content located abroad
(Galperin 2013). In Argentina, Google is estimated to account
for over half the country’s Internet traffic. Since GGC was
installed at the Cabase Buenos Aires NAP in October 2011,
latency to YouTube and other Google properties is estimated
to have dropped by a factor of ten (Galperin 2013). Similarly
traffic has exploded in Kenya and Nigeria following the
introduction of Google caches at KIXP and IXPN. After the
installation in 2011, Google traffic soared making up around
half the IXP traffic in both countries (figure 4.9).
Similar to content providers, CDNs also benefit from the
open peering and improved performance available at the IXP.
Akamai, one of the world’s largest providers of web-based
third party content joined France-IX to reach a large number
of ISPs through a single connection and to avail itself of better
Figure 4.9. Traffic Impact of Google Caches in Kenya (KIXP) and
optimization. Since joining in 2010, Akamai has quadrupled its
Nigeria (IXPN) (Source: Mwangi, 2012)
port capacity to 40Gbps,20 the largest on the exchange along
with Numericable, a fibre optic Internet access and streaming
video provider. Other companies with large port capacities
Exchange Point (KIXP), helping it to become the most widely on France-IX include multinational cloud services companies
used TLD in the country (Weller 2012). There are other such as Amazon, Facebook, and Google.21 In Malaysia,
synergies between the ccTLD and IXP. Some IXPs also are Amazon, Facebook and Microsoft joined the country’s Internet
responsible for the ccTLD, and income from registrations exchange (MyIX) in 2013 to reduce latency for users and
can help sustain operations as is the case in Armenia. lower international connectivity costs.22 The growing number
ccTLD registrars also recognize the importance of improving of “eyeballs” (an Internet marketing term referring to people
the performance of local sites since many will be using the who look at web pages) in Malaysia, fueled by exploding
country’s domain name. The Canadian Internet Registration smart device use, are a big attraction for web content firms.
Authority (CIRA), responsible for the .ca Internet domain,
IXPs play a critical role in enabling online public services.
promotes the development of more IXPs throughout the nation Given that most e-government users are resident in the
via Town Hall meetings and bottom-up Internet community led country, it is logical to locally host servers and exchange data
support: “This is about improving security, speed and network for citizens. Security is heightened since the traffic stays within
resilience, while maximizing the amount of traffic that stays the country and subject to national privacy laws (Woodcock
within Canada for the benefit of all Canadians.”18 and Edelman 2012) and availability is enhanced with immunity
18 Canadian Internet Registration Authority (CIRA). “CIRA to Act as a Catalyst 19 https://peering.google.com/about/ggc.html
for a Faster, Better Performing Internet.” News Release, 28 June 2012. 20 https://www.franceix.net/media/cms_page_media/823/Case-study_Akamai_
http://www.cira.ca/news/news-releases/ixp/ member-of-France-IX(september-2012).pdf
21 https://www.franceix.net/fr/members-resellers/members/
22 “MyIX Peers with Three Global Internet Brands.” Press Release. 7 February
2013.
30 www.internetsociety.org

THE ECONOMICS OF IXPS
to disruptions on international circuits. The Kenya Revenue A number of countries, particularly of large geographic size,
Authority (KRA), responsible for collecting the nation’s taxes, have created additional IXP points of presence, referred
has benefitted by connecting to KIXP. Income tax forms and to by some as virtual IXPs. For example, NIXI, the Internet
trade documents can be filed online with significant increases Exchange of India has seven locations, PTT of Brazil has
in data traffic as deadlines approach (Mwangi 2012). Savings 24 locations, while the Moscow Internet Exchange (MSK-IX) is
to the private sector from having access to KRA online interconnected to eleven sites in the capital as well as
services has been estimated at US$45 million.23 eight other Russian cities (figure 4.10).
In countries where there is only one physical IXP, ISPs located
Infrastructure
in other areas would need to obtain a backhaul link in order
The growth of the IXP reduces traffic exchange costs,
to connect. The high cost or lack of high-speed national
lowers latency, enhances redundancy, and attracts domestic
backbone connectivity has been a deterrent to connecting
and global content providers. This increases the appeal
ISPs to the IXP. In some cases the cost of domestic
of connecting other parts of the country to the exchange.
connectivity is higher than international IP transit (particularly
Building out domestic networks increases a country’s
when charged on a distance rather than traffic basis). For
infrastructure assets, reduces access costs for users and example, it is cheaper to send traffic via submarine cable from
shrinks digital gaps within the nation. Capetown to Johannesburg versus sending traffic completely
overland via terrestrial fibre. This also is an issue where
There are different strategies for connecting regional ISPs
there are multiple IXP nodes since they will not reach every
to IXPs. One is for the IXP to increase its geographic reach
population center.
by establishing additional nodes in other locations. A second
strategy is to build out domestic backbone connectivity so that
different parts of the country can reach the IXP. In practice,
both approaches are often followed since it may not be
THE GROWTH OF THE IXP REDUCES TRAFFIC
feasible to put an IXP node in every location.
EXCHANGE COSTS, LOWERS LATENCY, ENHANCES
REDUNDANCY, AND ATTRACTS DOMESTIC AND GLOBAL
CONTENT PROVIDERS. THIS INCREASES THE APPEAL
OF CONNECTING OTHER PARTS OF THE COUNTRY
TO THE EXCHANGE.
Given the benefits of connecting to the IXP, countries are
encouraging the deployment of national telecommunications
infrastructure through a variety of strategies. In some cases,
governments are promoting domestic backbone connectivity
using a variety of policies. This includes developing national
fibre networks through public private partnerships. The
latter is an option where the costs of construction are too
high and the private sector is not convinced of the return on
investment. Another strategy for encouraging fibre deployment
is through regulatory tools such as price controls on operators
with significant market power in the domestic wholesale
bandwidth market or encouraging infrastructure sharing
among operators. One of the simplest solutions is simply to
Figure 4.10. Moscow Internet Exchange Nodes (Source: Moscow allow a competitive wholesale bandwidth market. This will
Internet Exchange, http://www.msk-ix.ru/eng/where.html)
attract domestic and foreign investors as well as utilities such
as power companies and railroads with their own fibre optic
23 http://www.itu.int/ITU-D/finance/work-cost-tariffs/events/tariff-seminars/Egypt- networks.
13/documents/Session10_Ibrahim.pdf
Kenya has pursued a number of these strategies. The
government has funded the National Optic Fibre Backbone
Infrastructure (NOFBI) network extending thousands of
www.internetsociety.org 31

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
An additional infrastructure trend is the globalization of IXPs
as they expand their services outside their home countries.
THE GROWTH IN DOMESTIC IP TRAFFIC
The Amsterdam Internet Exchange (AMS-IX) is at the forefront
CAN ATTRACT INTERNATIONAL BANDWIDTH of this trend, billing itself as the most international IX in the
PROVIDERS, AND CAN BE PARTICULARLY world with over three quarters of its connected networks
coming from outside the Netherlands.24 AMS-IX helped
IMPORTANT FOR LANDLOCKED COUNTRIES.
established the Caribbean Internet Exchange (CAR-IX) in
ONE OPTION FOR A LANDLOCKED COUNTRY IS
Curacao in 2008, and assimilated into the AMS-IX global
FOR INTERNATIONAL IP-TRANSIT PROVIDERS
network in 2013. AMS-IX has created a POP in Hong Kong,
TO ESTABLISH A POP OPERATING AS A the first such platform allowing remote peering from Asia
VIRTUAL LANDING STATION. into Amsterdam. AMS-IX is also partnering with the Kenya
Internet Exchange Point (KIXP) and undersea cable provider
SEACOM to establish a regional exchange for East Africa that
will also support virtual peering to Amsterdam (AMS-IX 2013).
kilometers throughout the country. In addition, the backbone
The Dutch exchange recently announced plans to set up
fibre market is liberalized with several providers including the
several exchanges in the United States as part of the Open-IX
country’s power utility. In fact the latter, Kenya Power and
initiative. This aims to introduce neutral multilateral peering in
Lighting Company, has emerged as the largest wholesale
order to reduce costs for major content providers such as the
fibre operator in the country. These developments have
video streaming company Netflix.25
lowered the cost of domestic IP transmission, facilitating ISPs
connecting to KIXP. Fibre networks are built to the borders of
several neighbouring countries which has reinforced KIXP’s
THE LONDON INTERNET EXCHANGE
attractiveness as an East African hub; a second IXP has
(LINX) HAS A STRONG OUTREACH
been established in Mombasa, site of the undersea cable
landing stations. This has attracted international operators to PROGRAM REPRESENTING ITS MEMBERS
the exchange. In 2011, over half of the Autonomous Systems ON IMPORTANT PUBLIC POLICY ISSUES.
Numbers (ASNs) routed through KIXP originated from more
IT NOTES: “BY DOING SO, WE ARE NOT
than a dozen foreign countries (Mwangi 2012).
ONLY WORKING TOWARDS THE GOOD
In Argentina, ISPs outside large cities have high domestic
OF OUR MEMBERS, BUT THE INTERNET
transport costs exacerbated by limited competition. ISPs
AS A WHOLE.”
and citizens in these areas pay higher wholesale and retail
costs than those in main urban centers, impacting the growth
of the Internet market. The Argentine Internet Chamber
Expanded IXP Services
(CABASE) an association of ISPs that operates the IXP NAP
Buenos Aires spearheaded an initiative to connect these As IXPs grow, they often evolve from a basic switching and
regions. Connecting regions in Argentina allowed them to routing service to become centers of Internet expertise in the
exchange local traffic and interconnect through NAP Buenos country. This know-how allows them to begin to provide other
Aires, forming a virtual IXP with national reach. The first services, supplementing the critical Internet infrastructure
node was established in 2011 and to date, nine regional that has been put in place. Examples include IPv6, network
IXPs are operational, connecting over 80 network operators security (e.g., CERT), mobile peering, and root servers.
through a central routing hub in Buenos Aires. By aggregating In addition, IXPs can play a catalytic role promoting and
outbound traffic at the IXP, small network operators were nurturing the country’s Internet industry assisted through
able to negotiate better contract terms with upstream transit cooperative partnerships with other IXPs, regional Internet
providers. Prices in the national transit market have declined registries and international organizations.
to about US$40 per Mbps per month (Galperin 2013).
The strong technical bond between the IXP and its members
The growth in domestic IP traffic can attract international can be leveraged into industry promotion to the benefit of the
bandwidth providers, and can be particularly important for
landlocked countries. One option for a landlocked country 24 https://www.ams-ix.net/connect-to-ams-ix/benefits-of-connecting/
25 Amsterdam Internet Exchange. “Netflix Signs On To New York Open Internet
is for international IP-transit providers to establish a POP
Exchange.” News, 2 December 2013. https://www.ams-ix.net/newsitems/124.
operating as a virtual landing station. Such is the case in
East Africa where SEACOM, an undersea fibre optic cable
company, has established POPs in Rwanda and Uganda.
32 www.internetsociety.org

THE ECONOMICS OF IXPS
Sector Impact Reason
Overall economy Increase in GDP Investment in network infrastructure. A number of studies have
demonstrated the impact on economic growth from investment in
telecommunications.27
Overall economy Increase in GDP Increase in broadband access. There is growing research citing the
relationship between broadband penetration and economic growth.
ISPs Lower costs Exchanging traffic domestically is generally cheaper than IP transit.
ISPs Increased revenue Triggers additional domestic traffic increasing revenues (Kende and
Hurpy 2012)
Consumers Lower costs Reduction in Internet access fees and/or increase in speeds due to
lower ISP costs.
Content providers Increased revenue Lower latency increases revenue (Nokia 2009). According to a Latin
American study faster broadband speeds from IXPs would have a
GDP impact of US$915 million (Telecom Advisory Services 2013).
Government Lower costs Greater efficiency through online public services (e.g., KRA)
Local computer equipment Increased sales Growing domestic Internet market triggered by IXP will generate
and software suppliers higher sales of computer hardware and software.
Table 4.4. Economic Benefits of IXPs
national Internet ecosystem. This is particularly important in
countries that lack strong Internet associations. Given the
importance of the Internet in any society, it is critical to have
a group lobbying for sustainable and progressive policies.
The London Internet Exchange (LINX) has a strong outreach
program representing its members on important public policy
issues. It notes: “By doing so, we are not only working towards
the good of our members, but the Internet as a whole.”26
IXP Economic Impacts
The direct financial benefits for ISPs of an IXP have been
demonstrated above. In addition, IXPs offer benefits
beyond the measurable financial advantages. Although
these spill-over impacts are often not precisely calculable,
the improvement in quality and reduction in cost generate
significant gains for ISPs, consumers, content providers,
governments and others. National technical human capacity
is also raised with IXPs helping to make the Internet more
sustainable (table 4.4).
26 https://www.linx.net/about/index.html
27 http://mddb.apec.org/Documents/2010/EC/SEM1/10_ec_sem1_002.pdf
www.internetsociety.org 33

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
5. Benchmarking IXPs: T HIS SECTION DESCRIBES A SET OF BASIC
benchmarking measures that have been designed
A Methodology for
to assess the potential of an IXP to improve
Assessing Performance performance and to help identify bottlenecks to delivering
maximal interconnection. It is set up as a template for a
spreadsheet or online form that can be filled in by IXP
stakeholders. In addition, part of the template can be used to
describe the conditions in a location where no IXPs currently
exist in order to identify the bottlenecks and potential viability
of a new exchange.
The template is based on data derived from case studies,
best practices, and findings from field studies/training. It
categorises IXPs into three types — Basic, Intermediary and
Advanced — based on the type of services provided, and
analyses these according to the following benchmarks:
• Participation levels of local networks and CDNs
• Geographic scope
• Scalability and sustainability
The benchmarking methodology will be tested in the field with
selected IXPs and after testing, will be further refined. The
methodology also can be used to create a self-assessment
tool to enable field and self assessments and to compare and
contrast that data.
The template is shown on the following pages without
description and commentary about the variables so that
the overall structure of the benchmarking process can be
more easily understood. Notes on the relevant sections are
reproduced following the template (table 5.1).
IXP Basic Details
1. Full name
2. Abbreviation
34 www.internetsociety.org

BENCHMARKING IXPS
3. Website/URL 4. Peak traffic (Gbps)
4. ASN 5. Number of national fibre networks present at IXP
5. Host organisation name 6. Percent of national fibre networks present at IXP
6. Region (seven options: Africa, Asia-Pacific and South- 7. Percent of international fibre links at IXP
Asia, Europe, Middle East, North America, Latin America (interregional and intercontinental)
and the Caribbean, CIS)
8. Number of physically separate locations
7. Country or territory
9. Size of premises (sq. m)
8. City
10. Number of rooms
9. Date information collected
11. Average power consumption (kW)
Location Setting
IXP Policies and Neutrality: Governance
1. Country population (2012)
and Business Model, Peering, Fees
2. Country level of development (GNI/Capita – World Bank 1. Operating model (options: Commercial, Nonprofit,
Atlas method definition 2012) Volunteer, Public Sector, NREN-hosted)
3. Number of neighbouring countries or island states 2. Host organisation type (options: ISP, ISP/Telco
Association, Independent nonprofit, government,
4. Number of neighbouring countries with cross-border
regulator, neutral for-profit company, informal project)
telecom links to IXP country
3. Relationship with other IXPs (options: parent/subsidiary,
5. Number of international fibre links landing in country
partnership, twin)
(interregional)
4. Neutrality of premises location (options: Independent
6. Number of submarine fibre links landing in country
site, ISP/Telco site, NREN, Government
(intercontinental)
5. Membership categories
7. Number of national fibre backbones in country
6. Member-type exclusions (e.g., only licensed ISPs, etc.)
8. Cost of intercontinental/submarine fibre capacity – STM-1
($/Mbps/month) 7. Peering policy (options: only multilateral, only bilateral,
both)
9. Cost of cross border capacity – STM-1 ($/Mbps/month)
8. Private peering policies
10. Cost of national backbone capacity – STM-1 ($/Mbps/
month) 9. Competition with member services
11. Number of national fixed and mobile operators in country 10. Only certain member types allowed to peer
12. Presence of a National Education and Research Network 11. Board of directors — yes/no
(NREN)
12. Constitution
13. Number of ISPs operating in the country
13. Public accounts
14. Number of ASNs assigned to the country
14. One-time joining/setup fees (US$)
15. Number of Internet users in country
15. Annual membership fee (US$)
16. IXP city population
16. Annualised 10Mbps port fee (US$)
17. IXP city rank
17. Annualised 100Mbps port fee (US$)
18. Other IXPs in same city
18. Annualised 1Gbps port fee (US$)
IXP Size and Physical Connectivity 19. Annualised backup 1Gbps port fee
1. Number of members
20. Annualised backup 10Gbps port fee
2. Number of ASNs visible at IXP
21. Other fees (US$)
3. Number of IP prefixes announced at IXP
www.internetsociety.org 35

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
IXP Services and Facilities 7. Link aggregation
Basic IXP 8. Remote peering
1. Peering Policy Document
9. Multicast
2. Number of 10Mbps ports
10. Real-time, broadcast, and multicast traffic statistics
3. Number of 100Mbs ports
11. 24/7 telephonic technical support desk
4. Route Server(s)
12. 24/7 authorised member access control
5. IPv4
13. High-end SLA
6. IPv6
14. Text message alert system for members
7. Member traffic statistics
15. Human resources — number of FTE staff
8. Human Resources — number of volunteers, number
16. Staffing description
of employees
17. Cable distribution system/management, false floor, etc.
9. Staffing description
18. Fire protection
10. Email and telephonic point of contact
19. Additional cooling/air conditioning
11. Remote hands (part time)
20. Quarantine VLAN
12. Equipment backups/duplication
21. Port security features
13. Manual Access security
22. Private peering via VLAN
14. Power backup
23. Configuration backups
15. Cooling/air conditioning
24. Governance document and agreement
16. Basic SLA available
25. Site duplication at other locations
17. ccTLD host/mirror
Advanced IXP
1. 10Gbps Ports
18. Administrative LAN
2. Fractional 10Gbps Ethernet ports
19. Website
3. 100Gbps ports
20. Aggregated traffic statistics on website
4. MPLS/VPLS
21. Individual member statistics available to members
5. Jumbo frames
22. IPv6 statistics
6. Out-of-band management network
23. Historical Data statistics (5–10 years)
7. Number of of DNS root servers
24. Route Server statistics
8. Spam filtering
25. Member application form on website
9. VoIP Federation
26. Membership details on website (names of members,
10. Automated site access security
URLs)
11. Automated provisioning and billing
27. Entry in global peering databases (PeeringDB, etc.)
12. Human Resources – number of FTE staff
Intermediary IXP
1. 1Gbps Ethernet ports 13. Staffing description
2. Fractional 1Gbps Ethernet ports 14. Partner/Reseller programme
3. Looking glass server 15. IPX/GRX peering and statistics
4. NTP server 16. Blackholing
5. DNS server mirror(s) 17. Other statistics
6. Route-views server 18. Additional power backup and customer supply
36 www.internetsociety.org

BENCHMARKING IXPS
Benchmarking Analysis 3. “Continentality” (number of ASNs from same continent x
number of countries those ASNs are from)
Participation levels of local networks and CDNs
1. Largest telecom operator exchanging all local traffic 4. Subregionality – (neighboring country ASNs x number
at IXP of neighboring countries)
2. Percent of fixed and mobile operators present at
Scalability and sustainability
exchange 1. Peak traffic/Capacity of switch (percent)
3. National Participation Density (member ASNs visible / 2. Total traffic on links / total capacity of links
ASNs allocated to country) x 100 (percent)
3. Number of ports in use/number of ports available
4. Nontraditional local member participation (number
4. Percent of rack space available
of local content providers, nonprovider or noneyeball
networks/ total members) *100 (percent) 5. Percent of floor space occupied
5. Number of external CDNs present (e.g., GGC, Akamai) 6. Scarce resource policy
Geographic scope of IXP 7. Rack space utilisation policy
1. International scope (number of out-of-country ASNs
8. Cabling policy
present/total ASNs present) (percent)
2. Internationality (number of foreign ASNs x number
of countries those ASNs are from)
Variableues Discussion Points, Comments, and Issues
IXP BASIC DETAILS
Full Name
Abbreviation
Website/URL
ASN It is not obligatory for an IXP to have an ASN, but many do so to
provide access to shared services provided by the IXP, and to facilitate
BGP.
Host Organisation Name
Region (six options: Africa, Asia-Pacific &
South-Asia, Europe, Middle East, North America,
Latin America& the Caribbean)
Country or Territory “Territory” is used to designate locations such as Reunion (part of
France), or Western Sahara (disputed)
City
Date Information Collected
Location Setting
Country Population (2012)
Country-level of Development Low income, US$1,035 or less; lower middle income, US$1,036–
(GNI/Capita–World Bank Atlas method $4,085; upper middle income, US$4,086—$12,615; and high income,
definition 2012) US$12,616 or more. Project focus on all except high income
Number of neighbouring countries or neighbouring To measure the extent of subregional connectivity
island states
Table 5.1. Benchmark Table
www.internetsociety.org 37

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Variableues Discussion Points, Comments, and Issues
Number of neighbouring countries with A filter on the above
cross-border telecom links to IXP country
Number of international fibre links landing Source: AM or Telegeography (not including submarine cables which
in country (interregional) are included below).
Number of submarine fibre links landing (I.e., not local coastal festoon systems) Potential data source: AM or
in-country (intercontinental) Telegeography.
IXPs can attract international membership when they are situated
where competitively priced international fibre-optic links are available.
Networks from other countries may be generating sufficient traffic
with members of the foreign IXP to warrant the cost of a direct
international link versus paying another network for transit. For
example, LINX, an IXP in the UK, has members from more than
50 countries.
Number of national fibre backbones in country Source: AM or Telegeography.
Cost of intercontinental/submarine fibre capacity – In a number of developing countries, local capacity may cost more
STM-1 ($/Mbps/month) than international or intercontinental capacity. For example in Nigeria,
the cost to send traffic between Abuja and Lagos is greater than
between Lagos and London. Similarly in South Africa, the cost to
send traffic between Johannesburg and Cape Town is greater than
between Cape Town and London. This disparity between cost and
distance is usually caused by immaturity and lack of competition
in the local market when multiple international submarine cables
land in each country, providing competitive prices for international
connectivity. This disparity severely hampers the viability of local
IXPs by making exchange of traffic locally more expensive than
sending it via an exchange in another country.
Cost of cross border capacity – STM-1
($/Mbps/month)
Cost of national backbone capacity – STM-1
($/Mbps/month)
Number of national fixed and mobile operators Source: AM or Telegeography
in country
Presence of a National Education and Research
Network (NREN)
Number of ISPs operating in the country For level of participation measures
Number of ASNs Assigned to Country Source: NRO
For level of participation measures: http://www.nro.net/wp-content/
uploads/apnic-uploads/delegated-extended
Number of Internet Users in country Source: ITU
IXP City population Source: World Almanac
IXP City Rank To identify secondary city IXPs
Other IXPs in same city Although IXPs usually do not compete with each other, when traffic
volume grows in larger urban areas, there may be market-driven
reasons for competition between IXPs. Competition also helps
Table 5.1. Benchmark Table (continued)
38 www.internetsociety.org

BENCHMARKING IXPS
Variableues Discussion Points, Comments, and Issues
keep IXPs ‘honest,’ efficient, and meeting member needs, but too
many competing IXPs could mean that none reach critical mass and
none are successful or sustainable. Striking the balance between
the advantages of competition and disadvantages of duplication of
resources may not be a simple matter and due to local conditions,
there may be different groupings of networks supporting different
IXPs. Particularly common are commercial IXPs competing with
each other in the US and Canada or commercial IXPs competing
with nonprofit IXPs, including National Research and Education
Networks NRENs. In some cases, there may be a different function
assigned to the IXP – national vs. local/citywide exchange. Examples
of IXPs in the same city include: Latin America/Caribbean: Panama
(Intered, NAP Panamerico, and Senacyt). Peru: (NAP Peru, NAP
Lima). Europe: Bulgaria (BIX.BG and B-IX), Ukraine (Giganet, UA-IX
and DTEL-IX), Germany (ECIX, DE-CIX, KleyRex). UK (Edge-
IX, IXManchester and MCIX, Lynx, Lonap, RBIEX). Italy (MIX-IT,
MiNAP). France: (France-IX, SFINX). Sweden: (SOLIX, Netnod,
STHIX), Asia: Japan (BBIX, Equinix, MEX-CEC), Hong Kong
(Equinix, HKIX), Singapore (SOX, SGIX. Africa: South Africa (JINX/
CINX, NapAfrica)
IXP SIZE AND PHYSICAL CONNECTIVITY
Number of Members IXP size indicator
Number of ASNs Visible at IXP IXP size indicator
Number of IP prefixes announced at IXP Eyeball networks size indicator
Peak traffic (Gbps) IXP Size indicator
Number of national fibre networks present at IXP May be limited by deficiencies in local fibre links – see physically
separate locations – below
Percent of national fibre networks present at IXP Calculated from data above
Percent of international fibre links at IXP
(interregional and intercontinental) Calculated from data above
Number of physically separate locations Some IXPs operate from more than 1 location, mainly because
multiple locations makes reaching more members possible. Multiple
locations may also increase reliability. In some cases, more than one
location is needed because of deficiencies in the local physical fibre
infrastructure, so multiple sites are necessary to ensure maximum
connectivity. Other IXPs have adopted a multisite model in order to
build trust between competing operators by housing the IXP in the
premises of the different operators (e.g., Cote d’Ivoire where one site
is MTN and the other is Orange).
Size of premises (sq. m)
Number of rooms
Average power consumption (kW)
Table 5.1. Benchmark Table (continued)
www.internetsociety.org 39

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Variableues Discussion Points, Comments, and Issues
IXP POLICIES AND NEUTRALITY – GOVERNANCE & BUSINESS MODEL, PEERING, FEES
Operating Model Local and historical conditions often influence this. IXPs are usually
(options: Commercial, Nonprofit, Volunteer, formed by an initial group of network operators who decide on the
Public Sector, NREN-hosted) model that best fits the local environment. The key questions that
usually need to be addressed when deciding the most appropriate
institutional and business model are:
1. Will the IXP have permanent staff or be operated by volunteers
(at least in the short term)?
2. Will the IXP be a nonprofit or for-profit organisation?
3. Will the IXP be entirely cooperatively owned by its members or
will it have external ownership?
4. Where will the IXP be located/hosted?
5. What cost-recovery method will be used?
Host Organisation Type Will depend on local environment, historical conditions. To include
(options: ISP, ISP/Telco Association, Independent non-ISPs (i.e., content and applications provider networks), an
nonprofit, government, regulator, neutral for-profit independent nonprofit model is usually the most desirable.
company, informal project)
Relationship with other IXPs IXPs in neighbouring countries may develop partnerships and links to
(options: parent/subsidiary, partnership, twin) allow their members to exchange routes between the two countries.
For example, Balkan-IX in Bulgaria has this type of partnership with
RONIX in Romania. Many smaller developing country IXPs have
developed a special relationship with a larger, often developed-
country IXP to obtain assistance in skills transfer and in general
information sharing, often called “twinning.” In other cases, there is
a more formal business relationship between IXPs, such as AMS-
IX’s operations in Curacao (CAR-IX) and Hong Kong (AMS-IX Hong
Kong) or DEC-IX’s partnership with UAE-IX. Some commercial
IXPs have global operations, notably Equinix, which has about 32
exchanges in 15 countries, and Terremark, which is present in 20
countries and 41 locations.
Neutrality of premises location Normally a site for an IXP is most attractive to all members if it
(options: Independent site, ISP/Telco site, is a neutral site not controlled by one of the local participants. In
NREN, Government developing country situations, however, hosting by an ISP or
incumbent operator may be the only option if there is no other
suitable location. Due to the NREN’s noncommercial interest in the
market, and history of involvement of the emergence of the local
Internet sector, hosting at an NREN NOC is relatively common. In a
few countries the national regulator has offered facilities to help get
the IXP started.
Membership categories Commercial/noncommercial (maybe freely provided to NREN).
In some cases, especially where the IXP is operated by an ISP-
membership association, there may be different (higher) fees
charged to non-members (such as JINX, CINX, and DINX in South
Africa. In other cases, a membership in the association may be
required in order to have access to the IXP.
Table 5.1. Benchmark Table (continued)
40 www.internetsociety.org

BENCHMARKING IXPS
Variableues Discussion Points, Comments, and Issues
Member type exclusions While most IXPs have no restrictions on member types because this
(e.g., only licensed ISPs, etc.) maximises the potential participation, those in less mature markets
may restrict membership to licensed Internet access providers.
Peering Policy Most IXPs allow their members to choose between multilateral or
(options: only multilateral, only bilateral, both) bilateral peering. However, a few exchanges oblige members to
peer with all the members of the exchange. Perth IXP in Australia
is an example of this, resulting in a membership-base that is largely
composed of smaller and non-ISPs, The two largest providers,
Telstra and Optus have not joined the exchange as they are not
interested in peering with all members of the exchange.
Private Peering Policies Normally, all traffic is exchanged on the Ethernet switch fabric via
route server or via a VLAN. It may also be possible to establish
private peering links directly between the routers of different
members housed at the exchange. These arrangements can
result in upsetting the business model for the exchange (e.g., the
two networks pay the lowest port fees to connect to the IXP and
exchange much higher volumes of traffic directly). To address this
situation while allowing room for flexibility, this practice might be
allowed as long as the highest port fee is purchased. For example,
at JINX South Africa, this is permitted as long as both networks
are renting 10Gbps ports. In addition, JINX permits direct traffic
exchange when it is not technically possible through the switch; for
example, for voice traffic which requires SS7 signalling. Generally,
any restrictive policies the IXP may impose on traffic exchange of
members may limit the attractiveness of the exchange, especially to
larger operators who do not want to have their peering policies and
practices dictated by an IXP.
Competition with member services E.g., Transit, Colo facilities
Only certain member types allowed to peer E.g., just licensed ISPs
Board of Directors Often not appointed at IXP initiation – “get it going first” philosophy.
Constitution If non-commercial, often not present at IXP initiation – “get it going
first” philosophy.
Public accounts If accounts are made public.
One time Joining/Setup Fees (US$) IXPs usually charge a mix of setup, membership fees and port fees,
‘Free’ IXPs usually have large sponsors, e.g., Seattle IX. Some may
waive fees initially to encourage membership, e.g., Calgary IX. Some
do not charge membership fees, or setup fees but instead just port
fees, e.g., AMS-IX.
Annual Membership Fee (US$)
Annualised 10Mbps Port Fee (US$) Port fees may be waived for ports that are used for hosted services
(such as DNS servers). To improve cash flow, discounts for annual
payments may be made; for example, CAR-IX gives a 3% discount
for annual upfront payment. Some large IXPs do not provide services
less than 1GE except via resellers (e.g., AMS-IX). Some IXPs may
discount list price port fees to attract key customers, such as the
dominant operator, others may provide ports on a ‘try-then-buy’ basis.
Table 5.1. Benchmark Table (continued)
www.internetsociety.org 41

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Variableues Discussion Points, Comments, and Issues
Annualised 100Mbps Port Fee (US$)
Annualised 1Gbps Port Fee (US$)
Annualised backup 1Gbps Port Fee Some IXPs provide a backup port service at a discounted rate
(e.g., SFINX, France).
Annualised backup 10Gbps Port Fee
Other fees (US$) In some cases, if a particular ISP hosts the exchange, it is not
required to pay connectivity charges to access the exchange and
in return, may be expected to pay a ‘hosting fee’ (see, for example,
JINX, South Africa. Other fees may be for use of remote hands, etc.).
IXP SERVICES AND FACILITIES: A HIERARCHICAL CATEGORISATION INTO BASIC, INTERMEDIARY, AND
ADVANCED SERVICES. (services listed at lower levels are assumed present at the higher level.)
Basic IXP
Peering Policy Document
Number 10Mbps ports
Number 100Mbs ports
Route Server(s)
IPv4
IPv6 With IPv4 address space scarcity, networks are increasingly
switching to IPv6, which needs to be supported by the IXPs’
switching and server equipment. In 2011, Packet Clearing House
reported that of the 351 IXPs assessed, only 26% had IPv6 subnets.
Member traffic statistics
Human Resources The human resources available to the IXP are an important
(number of volunteers, number of employees, etc.) determinant of the exchange’s potential success. Staffing may be
voluntary initially, but as the IXP grows, full-time employees will likely
be required or at least part-time staff will be needed to augment
full-time technical support to ensure reliability. Total staffing can be
measured in terms of the number of “full-time equivalents” (FTE).
Staffing description E.g., one half-time tech support, one part-time accounts
administrator.
Email and telephonic point of contact
Remote hands (part time) Plug or unplug cables, power cycle equipment, replace equipment,
etc., as instructed.
Equipment backups/duplication I.e., The minimal equipment required is likely to be at least two route
servers and two switches/routers.
Manual access security Only authorised personnel or visitors should be allowed into the IXP
facility. This will require a locked door or locked rack if inside another
facility, with a manual access authorisation procedure. In the case of
a small IXP this will probably be just during normal office hours.
Power backup
Table 5.1. Benchmark Table (continued)
42 www.internetsociety.org

BENCHMARKING IXPS
Variableues Discussion Points, Comments, and Issues
Cooling/Air conditioning Equipment at an IXP generates significant amounts of heat. A
normal rule of thumb is for every BTU of power output, a BTU of air
conditioning will be required. The latter may vary according to the
premises and the local climate. If the IXP is hosted in an existing
server room or data centre with its own cooling facilities, the direct
cost of cooling can usually be avoided.
Basic SLA available
ccTLD host/mirror At a minimum, this could be a copy of the local ccTLD. Many other
DNS servers can also be hosted. See Intermediary IXP.
Administrative LAN
Website
Aggregated Traffic Statistics on website
Individual member statistics available to members
IPv6 Statistics
Historical Data statistics (5-10 years)
Route Server statistics
Member application form on website
Membership details on website
(names of members, URLs)
Entry in global peering databases (PeeringDB, etc.)
Intermediary IXP (Assumes all of the Basic services are also provided)
1Gbps Ethernet ports
Fractional 1Gbps Ethernet ports 200Mbps
Looking glass server A looking-glass server hosted at an IXP provides routing information
for ISPs that wish to establish peering sessions at the exchange.
NTP server
DNS server mirror(s) In the event of interruption in international connectivity, and also
to help reduce international traffic and latencies on name-server
lookups, IXPs are often a good location to host copies of the DNS
root servers. In addition the IXP can provide a space for other
international service providers who offer DNS services, including,
Autonomica, Community DNS, Internet Systems Consortium, Packet
Clearing House and UltraDNS. For example, JINX in South Africa
hosts an anycast instance of the I-Root server together with about
20 ccTLDs and gTLDs as well as an instance of the F-Root, and
instances of the .BIZ, .ORG, .INFO, .COOP and .AERO gTLDs. In
addition instances of more than 40 ccTLDs are hosted.
Table 5.1. Benchmark Table (continued)
www.internetsociety.org 43

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
aVariableues Discussion Points, Comments, and Issues
Route-views server Managing complex routing requirements with multiple local and
upstream networks is not a trivial task. A route-views server can
help considerably to trouble shoot suboptimal traffic routing, both for
members and for the IXP manager looking to improve the value of
the IXP to its participants. The ability to check the routing tables in
order to determine if more specifics are available than advertised is
a particularly useful feature. See http://www.routeviews.org.
Link aggregation Link aggregation allows IXP participants to smooth their upgrade
path for capacity on the exchange, so that, for example, instead of
having to upgrade from a 1Gbps port to a 10Gbps port, two or three
1Gbps ports may be aggregated together.
Remote peering This allows IXP members to connect to an IXP without installing
any equipment at the exchange by making use of an existing link
provided by the IXP that connects to the remote network’s location.
Multicast
Real-time traffic, broadcast traffic, SFlow is the real-time traffic statistics protocol that is normally used
and multicast traffic statistics by IXPs and large networks. It needs to be supported by the switches
used by the IXP. Some intermediary level IXPs can’t yet provide real-
time statistics (e.g., JINX) as its switches cannot support it.
24/7 telephonic technical support desk
24/7 authorised member access control
High-end SLA Needs switches with probes on each port
Text message alert system for members
Human resources — number of FTE staff At least one; can be up to five for a large intermediary IXP
Staffing description E.g., two half-time staff: one tech support, one member outreach
Cable distribution system/management,
false floor, etc.
Fire protection
Additional cooling/air conditioning As an IXP grows provision will need to be made for additional cooling
to compensate for the extra equipment present. Unless the IXP is
hosted inside a data centre and can make use of its cooling facilities,
it is likely that a specialised Direct Expansion Computer Room Air
Cooling unit (DX CRAC) will be required.
Quarantine VLAN
Port security features To minimise accidental (or even intentional) interference with other
participants at the exchange, a port security feature can be used to
automatically close down the port when a problem is detected, such
as traffic that is not accepted on the network. Normally only IPv4,
IPv6 and ARP packets are allowed to pass through the IXP switch.
Private peering via VLAN Some IXPs provide VLAN service for private peering; for example,
DTEL-IX in Kiev provides two such services: private peering between
members in public VLAN or private peering between members in an
isolated VLAN. Also called a “virtual IP connection.”
Table 5.1. Benchmark Table (continued)
44 www.internetsociety.org

BENCHMARKING IXPS
Variableues Discussion Points, Comments, and Issues
Configuration backups
Governance document and agreement
Site duplication at other locations
Advanced IXP (Assumes that all of the Basic and Intermediate services are also provided)
10Gbps Ports
Fractional 10 Gbps Ethernet ports 2.5Gbps
100Gbps ports
MPLS/VPLS
Jumbo frames
Out-of-band management network System console access provided even in the event of primary
network subsystem failure. This allows access to network equipment
in times of failure, ensures management data integrity in case of
failure, ensures quality of service to customers, minimises downtime,
minimises repair time, and eases diagnostics and debugging.
Number of DNS root servers
Spam filtering
VoIP federation
Automated site access security This should comprise a smartcard-based automatic door opening
procedure with CCTV to ensure only authorised personnel gain
access.
Automated provisioning and billing
Human resources — number of FTE staff
Staffing description E.g., three full-time staff: one tech support, one member outreach,
one marketing.
Partner/reseller programme Reseller is able to broker services of the IXP through their own or
a separate port, e.g., DE-CIX. This arrangement can provide more
efficient use of capacity, e.g., “one stop shop” for customers, etc.
IPX/GRX peering & statistics These services are mainly for networks offering traditional voice
services that require higher-level QOS. IPX service communities are
described in GSMA’s IR.34 and are normally provided by offering
separate Inter-IPX VLANs, such as GRX, IPX Packet Voice.
Blackholing Some IXPs, such as DE-CIX, provide blackholing services to assist
networks with Distributed Denial of Service (DDoS) attacks. Networks
can announce their prefixes with a unique Blackhole Next-hop IP
address (BN). When a DDoS attack is detected, the network issues
a routing update with the IXP-provided BN address as a next-hop so
that DDoS traffic is dropped at the IXP.
Other statistics E.g., frame size, Ethernet packet type, etc.
Additional power backup and customer supply To improve reliability, two redundant power feeds from the electrical
substation, plus diesel generators in hot stand-by configuration may
be required. For customers, both AC and DC current may be desired.
Table 5.1. Benchmark Table (continued)
www.internetsociety.org 45

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Variableues Discussion Points, Comments, and Issues
BENCHMARKING ANALYSIS
Participation Levels of Local Networks and CDNs
Largest telecom operator exchanging all local In developing country environments, the dominant fixed or mobile
traffic at IXP operators often don’t fully participate at the IXP. It may be present in
name, but not exchanging traffic with all local peers. Even if they are
required to interconnect with the exchange, they may participate but
severely under-provision the link to the IXP. This constrains the IXP’s
effectiveness and ability to grow by attracting members. In these
situations, some have suggested that the regulator should require
the operator to interconnect fully at the exchange. The mechanism
for this requirement could be as part of the dominant operator’s
license or as an ad hoc ruling. This is the case in Chile where all
licensed Internet providers are required to connect to NAP Chile.
Percentage of fixed and mobile operators present
at exchange
National participation density (member ASNs
visible/ASNs allocated to country) x 100 (percent)
Nontraditional local member participation A function of membership restrictions. Includes NRENs, Govt.
(number of local content providers, nonprovider or networks, ccTLDs, Anycast network, Community DNS (brings
noneyeball networks/total members) *100 (percent) many TLDs).
Number of external CDNs present Can be hosted off-site as long as traffic passes through IXP.
(GGC, Akamai, Netflix, etc.)
Geographic scope of IXP
International scope (number of out-of-country All IXPs can be seen on a continuum from local (city) to regional.
ASNs present/total ASNs present) (percent) The degree of regionality or geographic scope of an IXP can be
measured by the number of external (nonlocal) networks that are
visible and/or reachable via the IXP. It is possible to develop a
ranking of IXPs along a scale of geographic scope by counting the
number of ‘foreign’ ASN’s present since the visibility of these ASNs
means they are either there through transit (via a regional carrier)
or peering (if directly connected). For a value that more accurately
reflects the geographic scope of the IXP, multiply that figure by the
number of foreign countries the ASN’s represent at the exchange.
E.g., if there are 10 foreign networks/ ASNs at the IXP but from only
two countries (=20), the exchange would be less regional than an
IXP with eight networks from three countries (=24). This is clearly not
a perfect measure and some assumptions could be made as follows:
If 20% of the neighbouring countries ASN’s are visible/reachable via
the local IXP, the IXP is potentially a regional one.
If, in addition to the 20%, another 10% are from regions outside
of the Regional Economic Block and/or the continent, such a
configuration that would make the IXP a defacto regional IXP.
This would mean that if 30% of the prefixes and ASNs visible and
reachable via the IXP are nonlocal, the IXP could be defined as a
regional IXP.
Table 5.1. Benchmark Table (continued)
46 www.internetsociety.org

BENCHMARKING IXPS
Variableues Discussion Points, Comments, and Issues
The 30% is an arbitrary value at this point, but the assumption could
be tested empirically by sampling a number of IXPs and looking
at the normal distribution of foreign vs. local visibility of ASNs and
prefixes. It may also be necessary to examine if the connections to
the IXP are either through transit or direct peering.
Internationality (number of foreign ASNs x number
of countries those ASNs are from)
Continentality (number of ASNs from same continent
* number of countries those ASNs are from)
Subregionality – (neighbouring country ASNs x
number of neighbouring countries)
SCALABILITY & SUSTAINABILITY: GROWTH AND SUSTAINABILITY ARE KEY SUCCESS ELEMENTS
Peak traffic/capacity of switch (percent)
Total traffic on links/total capacity of links
Number of ports in use/number of ports available
Percent of rack space available
Percent of floor space occupied
Scarce resource policy Ideally, an IXP will have sufficient ports and other resources to
meet all of the needs of its users, but in practice, usually due to
unexpected growth, there may be a limitation in providing sufficient
resources over the short term. To make more efficient use of
available resources and to smooth the growth path, the IXP should
allocate scarce resources primarily on the basis of demonstrated
use. IXP users may request an allocation above that required for
demonstrated use; in such cases, the IXP should retain the right to
reclaim under-utilised resources if they are needed for another user
with demonstrated use. The policy will also likely need a dispute
resolution procedure to resolve disputes in the allocation of a scarce
resource,e.g., JINX in South Africa puts the matter to all active users
of exchange who are ISPA members with one vote per user.
Rack space utilisation policy To maximise the efficient use of physical space available at the
exchange, some IXPs located in limited premises may wish to
impose rack space usage policies. E.g., JINX in South Africa
requires the following limits, over and above which, additional
charges apply: 10Gbps – 8U max, 1Gbps – 6U, 100Mbps – 4U,
10Mbps – 2U. In addition, the IXP may impose a requirement that all
equipment be rack mounted, and may reserve the right to disconnect
equipment that is not rack mounted (exceptions may be made on a
case-by-case basis). Even in IXPs with large premises, these rules
can be imposed to ensure that the IXP retains its primary function as
Internet exchange and not as an equipment hosting facility.
Cabling policy To ensure consistency and reliability, some IXPs require that all
cabling used to interconnect the customer routers with the switch be
provided by the exchange. See JINX in South Africa.
Table 5.1. Benchmark Table (continued)
www.internetsociety.org 47

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
6. Case Studies and T he selection of case studies presented here begins
with the three largest exchanges in Africa — in Kenya,
IXP Facts by Country
Nigeria and South Africa — before relating other
developing country experiences as well as some developed
country examples. These case studies provide an indication
of how IXPs in emerging regions may develop. The country
case studies have also been selected to show the range of
national market and policy environments within which IXPs
may be required to operate, the types of institutional models
and interconnection policies adopted by IXPs, and how IXPs
evolve over time.
As the case studies amply demonstrate, IP interconnection
is still a relatively new arrangement and there are a wide
variety of fee structures, institutional models, policy rules,
and technical strategies adopted by IXPs across the world.
Some of the choices made may have constrained growth
in interconnection. In other cases, alternative IXPs have
emerged to fulfil needs unmet by the existing IXPs.
A perusal of the case studies will show few geographic
trends that can be deduced aside from the commercial/non-
commercial divide between the US and the rest of the world;
even this is now blurring with three European IXPs recently
launching neutral membership-based services in the US.
More important, in the last two years, there has been a
notable surge in the number of IXPs in secondary cities,
particularly in Argentina, Brazil, and Indonesia, but also
in cities such as Arusha, Adelaide, Buffalo, Cork, Durban,
Edinburgh, Grenoble, Leeds, Lyon, Manchester, Manitoba,
Mombasa, Port Harcourt, Saint Etienne, Toulouse, Turin,
Winnipeg, and Zurich.
This trend reflects increasing local content consumption,
decentralisation of content redistribution, and overall growth
in bandwidth demand built on the steady extension of high
48 www.internetsociety.org

CASE STUDIES
bandwidth cable and wireless networks. While most of this ports may not be available or may even be free. The chart
growth has so far been in more developed economies, the below shows the annualised port cost for 1 and 10Gbps ports
same trends are becoming evident in emerging economies. at a variety of IXPs in different locations around the world.
In addition, aggregating outbound traffic and avoiding The chart’s ranking according to 1Gbps port costs highlights
tromboning are likely to be more critical in smaller secondary the greater variability and inconsistency in charges for 10Gbps
city markets where local ISPs typically face higher transit ports.
costs and longer routes to desired content.
The case studies and data samples provided here draw
At the same time, the scale, reliability and geographic on information from a variety of sources, including the
scope of existing IXPs is extending with many IXPs today IXP websites, national ICT market profiles, and personal
offering multiple sites, remote peering, and partnership interviews for this study with some IXP managers. Some
programmes, often called service provider or reseller plans. case studies are presented in more detail than others due to
Such programmes leverage the benefits of the remote peering variably available relevant data. In addition, some of the case
model and low-cost national or regional backhaul, minimising studies presented later in the sequence contain redacted
technical support needs for the IXP and taking advantage of repetitive information that may already appear in the earlier
link aggregation. case studies presented. Statistics, such as daily peak traffic
rates and numbers of members, are drawn from the data as
Regional extension of networks is also being encouraged
stated in November 2013 on a given IXP’s website.
in countries where the IXP may operate its own links to a
neighbouring city or country. In France, members of France-
IX may use up to 100Mbps from Paris to Lyon, Toulouse,
Luxembourg and Italy, after which they need to purchase their THIS TREND REFLECTS INCREASING LOCAL
own links. CONTENT CONSUMPTION, DECENTRALISATION
Another feature of many IXPs is the presence of domain name OF CONTENT REDISTRIBUTION, AND OVERALL
server mirrors for a variety of gTLDs and ccTLDs. However, GROWTH IN BANDWIDTH DEMAND BUILT ON
surprisingly few IXPs offer a wider variety of shared services
THE STEADY EXTENSION OF HIGH BANDWIDTH
such as time servers, CERT, software mirrors, etc. It is also
CABLE AND WIRELESS NETWORKS. WHILE
noteworthy that policies that promote multilateral peering are
MOST OF THIS GROWTH HAS SO FAR BEEN
present among a significant number of IXPs, either mandatory
or incentivised in some other way (such as a discount on the IN MORE DEVELOPED ECONOMIES, THE
port fee for the invited party). The majority of IXPs, however, SAME TRENDS ARE BECOMING EVIDENT IN
also offer bilateral peering and VLAN services and of late, a
EMERGING ECONOMIES.
few IXPs are beginning to offer VoIP or GRX-type services.
Many IXPs host regular social, technical or industry events to
help build the local community of people involved in peering.
In the course of gathering this data, researchers found little
Twinning programmes to support emerging IXPs have also
consistency in the presentation of basic information on IXP
been adopted by some of the larger exchanges such as those
websites. Few IXP websites in emerging markets provide
in London, Amsterdam, and Stockholm.
the three primary categories of pricing, membership policies,
A significant number of IXPs are still operated without charge; and list of peers. Traffic statistics are also not provided many
however, the majority of IXPs have pricing arrangements for sites due to the fact that some IXPs are not yet keeping
participation, ranging from a simple joining fee to fees that traffic statistics. Some IXP websites may show disaggregated
almost equal the cost of transit. The most important variable data with the traffic history of each network connected to
in IXP pricing is port speed, but this may need to be balanced the exchange. In other cases, information may be buried
against membership fees (if any) or setup fees (if any) and in a hard-to-find link or may not be current. Overall, only a
against the backhaul costs of getting to the IXP. as well as small minority of IXPs operate websites that fulfil the basic
availability of link aggregation and discounts for second ports requirements of a prospective peer for up-to-date, easily
to allow smoothing the costs as network needs grow. (For accessible information.
example, a network needing 1.2Gbps could cost the same as
Additional case study information and additional materials can
2X1Gbps ports or 1x10Gbps port without link aggregation).
be found on the IXP Toolkit portal: http://www.IXPToolkit.org
In analysing the current costs for use of IXP services, 1Gbps
and 10Gbps ports are the most commonly available. A
minority of IXPs have 100Gbps services and below 1Gbps,
www.internetsociety.org 49

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
6.1. AFRICA
Kenya required to shut down every computer network in the country
since the technical architecture and components of those
As a result of attending the
networks and KIXP were equivalent. The Kenyan Internet
Networking Workshop for
providers also argued that KIXP was a closed-user group
Developing Countries hosted
and therefore legal under the Kenyan Telecommunications
by the Internet Society (ISOC)
Act. It was also pointed out that the local exchange of
in California in 1999, one of
domestic Internet traffic does not contravene Telkom Kenya’s
Kenya’s Internet engineers
international monopoly, as all international traffic would
obtained knowledge about how
continue to flow over its international links.
to design, set up, and maintain
an IXP. Upon returning to Kenya, he shared this information Telkom Kenya’s opposition to KIXP was fierce, fed by the
with other network operators who were keen to begin work fear of losing a significant portion of its international leased
on establishing a local IXP. After about a year of preparatory line revenues. In the course of its arguments, Telkom Kenya
work, including the design and implementation of the technical misrepresented the situation. Because the matter was made
operation, funding model, and legal framework, the first IXP public and had received a significant amount of attention and
was launched in Nairobi in November 2000 as KIXP. coverage in the local and international media, a face-saving
solution was necessary.
The Telecommunication Service Providers Association
of Kenya (TESPOK), a professional, nonprofit The approach eventually adopted was the establishment of a
organisation representing the interests of ISPs and other company called KIXP Limited that applied for an IXP licence
telecommunication service providers in Kenya, operates KIXP. that CCK duly granted. This made Kenya the first, and only,
KIXP does not have a separate governance structure and country in the world to adopt an IXP licence requirement.
policies are established through committees of TESPOK.
After nearly a year of intensive efforts, including public
Licensing issues pressure, threats of litigation, and private diplomacy, TESPOK
Almost immediately following the launch of KIXP in 2000, finally received the approval of CCK in the form of a license,
the incumbent telecom operator, Telkom Kenya, filed a granted in November 2001. KIXP became operational again in
complaint with the national telecommunications regulator, mid-February 2002, having interconnected five Kenyan ISPs.
the Communications Commission of Kenya (CCK). They
Membership criteria
argued, at that time, that KIXP violated Telkom Kenya’s
During 2004, TESPOK members adopted policies governing
exclusive monopoly on the carriage of international traffic.
membership and use of KIXP that limited membership in
Within two weeks, the CCK concluded that the KIXP required
and connection to the IXP to licensed ISPs. This condition
a telecommunications operators licence, found that KIXP was
prompted a policy review that lifted all restrictions on member-
an illegal telecommunications facility, and ordered that it be
ship and lowered joining fees by 600%. Membership now
shut down.
costs KSH20000 (about US$330) per month. There are about
In response to the CCK’s closure order, a case was presented 30 members peering at KIXP, including more than a dozen
to the Communications Appeals Tribunal with a strong ISPs, one government network (Kenya Revenue Authority),
technical argument showing that KIXP was merely a standard, one education network operator, one ccTLD operator, three
off-the-shelf Ethernet hub. If KIXP were shut down on the Internet backbone gateway operators, one value-added
basis of the Commission’s finding, then the CCK would be telecommunication services provider, and two GSM operators.
NOTE TO OUR READERS: WE TRY TO STAY CURRENT WITH IXP DEVELOPMENTS AROUND THE WORLD. SOME
OF OUR DATA, HOWEVER, MAY BE OUT OF DATE. HELP US IMPROVE THE CASE STUDIES FOUND HERE AND ON
THE IXP TOOLKIT WEBSITE (WWW.IXPTOOLKIT.ORG) BY SENDING YOUR FEEDBACK TO FEEDBACK@IXPTOOLKIT.ORG
50 www.internetsociety.org

CASE STUDIES
The IXP location Kingdom’s Department for International Development (DFID).
In order to ensure the acceptability of the IXP concept in Other set-up expenses were covered by funds from TESPOK.
Kenya, it was essential to emphasize the neutrality of the Since the space where KIXP was located was not free, it was
facility and obtain consent from prospective members on necessary to find a way of covering the operating costs, such
its location. One of the biggest issues in establishing KIXP as rent, electricity and insurance costs. A monthly subscription
related to deciding where it would be hosted. A number of fee for all members connecting to KIXP was introduced to
options were evaluated, including the following: cover such baseline operating expenses.
1. Telkom Kenya was ostensibly the most suitable option Technical model
since it was the incumbent public national telecoms A number of different technical models were evaluated for the
operator. Some of the reasons cited in favour of Telkom Kenya IXP with agreement reached that KIXP would be based
Kenya included the fact that all Internet providers already on the same model as the Hong Kong Internet Exchange —
had existing links to its data network. Additionally, due to a Layer 2 Route Reflector IXP. As a result, the KIXP facility
Telekom Kenya’s central location in Nairobi, it would be consists of two high-speed Ethernet switches and each KIXP
much easier for the members to gain physical access to member has the option of connecting their routing equipment
the IXP regardless of their location. However, this option to both switches. Under this arrangement, should one switch
proved to be unworkable because, as described above, fail, the other would take over automatically. The core is
Telkom Kenya saw the IXP as a threat to its business and supplemented by two ‘route reflectors’ that are specially
declined the ISPs’ request to host KIXP. configured routers that bounce routing logic to all members
at the KIXP until all the routers have the same view of the
2. The University of Nairobi was considered as an
network. This design aspect allows for quick and easy IXP
alternative host for KIXP mainly due to its dynamic
agreed policy implementation at the exchange point, KIXP is
computer studies faculty and its central location. The
capable of supporting up to 48 networks and capacity can be
main concern about using the university as the location
extended to support up to 200 networks. The current power
of the IXP was the frequency of student riots and related
consumption for KIXP is 15KVA.
security concerns. Since KIXP was expected to serve
a mission-critical purpose, this concern eliminated the Second location: Mombasa
university as a viable option. In August 2010, KIXP launched the country’s second IXP in
Mombasa, located over 500kms from the country’s first IXP
3. Two ISPs with offices conveniently based in the Nairobi
in Nairobi. Mombasa is the landing point for all undersea fibre
CBD offered to host the IXP. The challenges with this
cables to Kenya and other landlocked countries in East Africa,
option were a) which of the two ISPs to choose and b) the
making it an attractive location for international carriers to
fact that most of the other ISPs expressed a high level
interconnect with the region. Operators perceived the choice
of dissatisfaction with the possibility that a competing
to host the Mombasa IXP with Seacom as a neutral point.
ISP would manage the IXP without seeking to give
With KIXP in Nairobi and the IXP in Mombasa, Kenya is
themselves undue advantage.
expected to increasingly become a hub for traffic in the region.
After an evaluation all of the various existing options without
Outgrowing the original facility
finding one that satisfied all the potential members, the idea
With an annual growth rate of over 100%, the KIXP facility
of leasing space in a provider-neutral, conveniently located
has outgrown its original location. As a result, a tender was
building was posed. This option allayed most of the fears
published in 2013 to identify a new larger and more suitable
and concerns expressed and as a result, 1500 square feet of
location that would also have a more reliable power supply.
space was leased on the top floor of a strategically located
The bid was won by the East Africa Data Centre, located
office building in the Nairobi city centre.
at Sameer Park, and KIXP is expected to shift to the new
Minimising costs location in early 2014.
The main operational consideration related to KIXP was cost.
The tender document required of the bidders:
As with any other type of data networking or communications
infrastructure, costs fell into two broad categories: set-up 1. Experience in operating data centres and offering
and operating. Set-up costs included the cost of purchasing data facility services.
equipment for the core of the IXP as well as furnishing the
2. Ability for the site to provide:
room where the IXP was to be located with backup power,
air-conditioning, equipment cabinets, and the relevant security • 24-hour, on-site access for all members using KIXP
fixtures. The initial equipment was funded both by a donation
• Fully redundant air conditioning system
from Cisco Systems as well as a small grant from the United
• Fully redundant UPS and power reticulation systems
www.internetsociety.org 51

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
• Backup generators services and the arrival of international content companies,
such as Google, that now host their services locally. All
• Fire protection systems
Google traffic (searches, mail, maps, applications and
• Service availability levels and maximum time documents) goes through KIXP. Popular Google content, such
to repair each system unit in case of failure. as YouTube videos are served from a Google cache shared
between members of KIXP.
• Security and privacy of data
Due to the limited capacity on the incumbent telecom
• Measures to address hardware and software
operator’s leased lines, most Internet service providers have
failures
moved to terrestrial fibre to connect to the KIXP which means
• Regulatory compliance
that they have links of multiple megabits per second into the
• Unrestricted access for licensed providers to install exchange.
connectivity infrastructure to the facility
Shared services
• Sufficient space for four racks, growing to eight KIXP has implemented local instances of the Internet’s F and
J root servers in addition to local .com and .net resolution
over a two-year period with a negotiable payment
services. As a result, locally originated lookup requests for
option for a further two years.
these services no longer need to transit international links for
• Adequate space allocation for infrastructure
a response, improving the responsiveness of website lookups
service provisioning not considered under the
and reducing the load on international links.
contracted footprint required for KIXP.
In 2005, the Kenya Network Information Centre (KENIC),
• Facility services to KIXP and its members
in line with its mandate to promote access to the Internet in
at a subsidized cost that may cover either the
Kenya, set up a GPS-enabled NTP Server at KIXP to provide
cost of power or rack space or both.
date and time integrity for computers. Most service providers
• Logging procedures for persons accessing KIXP had implemented time synchronisation on their systems
and access logs (ideally on line) utilising network time servers located in foreign countries.
However, these services were not extended to their clients
• Additional facilities such as remote online camera
due to the unreliable connectivity and prohibitive costs
monitoring and remote console capabilities
associated with international links. Some of the organisations
• Procedures for installation and removal of equipment now using the local NTP services include government bodies,
ISP’s, banks, companies and some educational institutions
• Availability of parking
that are able to save on organisational expenses resulting
3. Engineers and/or technicians who have qualifications from operational failures and data losses due to time
and experience in network administration with inconsistencies.
two or more of them qualified with the license of
KIXP also offers value-added services such as enabling
telecommunications engineering certificate and or
members to exchange network security data and registering
telecommunications installation certificate.
them in the global peering database.
Routing policy, connectivity, and traffic
KIXP publishes detailed information on Internet usage
KIXP previously operated a Mandatory Multilateral Peering
patterns. Overall, traffic now hits 1Gbps during peak time.
Agreement (MLPA) under the terms of which each member
The data reveals that traffic flows are highest during weekday
must allow peering with every other member. However, this
business hours, highlighting the opportunity for ISPs in
requirement was changed in 2009; the agreement no longer
Kenya to maximize off-peak use by developing products and
imposes any restrictions on the peering relationships between
encouraging content attractive to home Internet users.
participating networks.
KIXP is a member of the European IXP association, EURO-IX.
Until KIXP became operational, all Internet traffic in Kenya
was exchanged internationally. From 2000-2002 roughly 30% KIXP summarises its benefits as follows:
of upstream traffic was to a domestic destination. During the • Access to the .KE Domain Name System and Servers
first two weeks of KIXP’s operation, measurements indicated
• Access to the Kenya Revenue Authority System
that latency was reduced from an average of 1200–2000
milliseconds (via satellite) to 60–80 milliseconds (via KIXP). • Access to the three global Domain Name System Root
Servers
Local traffic has also improved due to the rise in local content
that was due, in part, to digitisation of some government • Access to an Authentic Network time Source Server
52 www.internetsociety.org

CASE STUDIES
• Connectivity on Fibre Optic Connection to be managed by an independent entity to be set up by
ISPAN. However, in November that year, the President of
• Access to a Route Views Server
Nigeria, Olusegun Obasanjo, directed the national regulator,
• Access to 34 Service provider networks in Kenya the Nigerian Communications Commission (NCC), to ensure
that a national IXP be established as soon as possible. With
• Access to 110 Networks (Autonomous System Numbers)
a budget of N35 million (about US$300,000.00), the Interim
from around the world
Board of the Nigerian IXP (IXPN) was inaugurated in March
See also the Internet Society study: Assessment of the impact
2007, but the IXP did not actually become operational until
of Internet Exchange Points (IXPs) – empirical study of Kenya
2010 when it began providing services from Marina, Lagos,
and Nigeria. http://www.internetsociety.org/ixpimpact
with 15 initial members.
http://www.kixp.or.ke
Since start up, the membership has grown to 38 and the
IXP has established two other operating sites in Lagos in
Nigeria
partnership with two different colocation operators, connected
The idea of establishing an IXP by fibre switch fabric across the locations. Four of the biggest
was first discussed at a meeting mobile operators – South Africa’s MTN, United Arab Emirates’
of Internet Service Providers (UAE) Etisalat, India’s Airtel, and the second national operator,
of Nigeria (ISPAN) in 2001, but Globacom, have all connected to the exchange along with
the level of trust between ISPs other major fibre carriers such as MainOne, Phase3 and
was low. Consequently, the Layer 3 (figure 6.1).
group attending the meeting
At the time of inauguration, the IXP planned for eight future
decided that it would be
sublocations: at Victoria Island, Ikeja, Ibadan, Port Harcourt,
imperative to hold a workshop aimed at raising awareness
Abuja, Enugu, Kano, and Maiduguri. As indicated above,
among the ISPs on issues of cooperation and specifically on
facilities in Lagos, Marina, Victoria Island and Ikeja were
the benefits of IXPs.
established initially, followed by Abuja in mid-2011 (with a
In March of that year, IXP activity first began outside the grant from the National Information Technology Development
capital in the city of Ibadan when the first IXP (Ib-IX) in Nigeria Agency (NITDA)) and Port Harcourt in mid-2012. The
went live with two members connected to a 10/100Mbit/s remaining three locations are still in the planning phase.
Ethernet switch and a route server. The maximum-recorded
The exchange operates at Layer 2 and each location has
traffic between the two ISPs was about 100Kbit/s. In
two Foundry switches connecting separate peering LANs
June, Maxwell Kadiri spearheaded an IXP workshop with
to ensure reliability (figure 6.2). The primary peering LAN is
the support of ISPAN and the French embassy in Lagos.
interconnected on a 1Gbps circuit (fibre) while the secondary
However, no further developments took place for two years.
peering LAN is interconnected on a 450 megabit wireless
In early 2005, the ISP Association of Nigeria (ISPAN) began backhaul. Two of the three operating locations have route
discussions on setting up an exchange in Lagos that was servers in place. All the NIX switches provide 10/100BaseTX
Figure 6.1. IXPN Network (Source: http://www.ixp.net.ng) Figure 6.2. IXPN Network Details (Source: http://www.ixp.net.ng)
www.internetsociety.org 53

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
switched Ethernet and 1000BaseSX Gigabit Ethernet over South Africa
multimode fibre connections.
South Africa’s largest city
Shared services include a CommunityDNS server and an hosts the Johannesburg
F-root name server. Internet Exchange (JINX),
operated by the Internet
A board composed of the CEO and six directors oversees
Service Providers’
IXPN. A technical committee assists the staff and advises
Association (ISPA), a
the Board on technical matters relating to IXPN operations.
nonprofit Internet industry
IXPN joined Euro-IX, the European Internet Exchange body. In addition to operating IXPs, ISPA is actively involved
Association in December 2011. in driving liberalisation and competition in the Internet access
market and facilitating dialogue between the different
Routing Policies and Traffic
independent ISPs, the South African Government’s Depart-
IXPN operates a Mandatory MLPA (Multilateral Peering
ment of Communications, the national regulator (ICASA),
Agreement) that requires every member to peer with the
telecommunication operators, and other service providers.
IXP’s route servers. IXPN also offers a separate, private
interconnect service for members wishing to have bilateral In November 2013, ISPA had 167 members of which about
connections. 50 are members of JINX, comprising a wide range of large,
medium, and small Internet service and access providers. ISPA
membership is not a requirement for participating in JINX, but
A BOARD COMPOSED OF THE CEO AND SIX
nonmembers pay higher port charges. There are currently
DIRECTORS OVERSEES NIXP. A TECHNICAL about 12 participants at JINX that are not members of ISPA.
COMMITTEE ASSISTS THE STAFF AND ADVISES
Currently, peak traffic at JINX is about 8Gbps. JINX
THE BOARD ON TECHNICAL MATTERS has exceeded capacity in the Rosebank facility and its
RELATING TO NIXP OPERATIONS. infrastructure has been extended to the neighbouring
Parklands building, approximately 100m away. Both facilities
are connected by fibre (up to 40GB capacity) for a single
Traffic has increased by about 4,000% since the IXP’s virtual JINX environment.
inception and live traffic statistics are available on the IXPN
An exchange is also operated by ISPA in Cape Town (CINX).
website. The statistics indicate that members are exchanging
CINX has about 30 members and 3Gbps peak traffic.
traffic at about 2 Gigabits per second during peak times. IXPN
also publishes the disaggregated live traffic statistics of each Teraco Data Environments, a vendor-neutral data centre,
of its members. recently won the bid to host the Durban Internet Exchange
(DINX). It also runs NapAfrica (following page) with IXPs in
Multiple-location fee structure
Capetown, Durban, and Johannesburg.
Considering that there are two peering LANs for IXPN in
Lagos, each additional port is charged at the same rate as Shared services
the first unless a member intends to take a second port on Aside from a Looking Glass server, a number of DNS services
the second peering LAN or if they have a single port on the are hosted at JINX. ISPA also provides space to UniForumSA,
primary peering LAN. A member’s second 100M is free of port the operator of the CO.ZA second-level domain, and several
charge, but a member’s second 1G port has a 25% discount international service providers who offer DNS services, such as
on port charge. These discounts are offered to encourage Autonomica, Community DNS, Internet Systems Consortium,
members to take ports on both the IXPN peering LANs. In Packet Clearing House, and UltraDNS. These include:
common with many other IXPs, IXPN has a port congestion
• An anycast instance of the I-Root server together
strategy where, if the average measured traffic on a member’s
with ~20 ccTLDs and gTLDs (operated by Netnod/
port exceeds 80% of its capacity, a Congestion Charge equal
Autonomica)
to the Basic Port Charge for that type of port is payable in
addition to the other port fees. • An anycast instance of the F-Root server
(operated by ISC)
For additional information on IXPN, see the ISOC study:
Assessment of the impact of Internet Exchange Points (IXPs) • Instances of the .BIZ and .CAT gTLDs
– empirical study of Kenya and Nigeria. (operated by PCH)
http://www.internetsociety.org/ixpimpact
• Instances of the .ORG, .INFO, .COOP, and .AERO
http://www.ixp.net.ng/ gTLDs (operated by UltraDNS)
54 www.internetsociety.org

CASE STUDIES
• Instances of about 40 ccTLDs negotiate interconnection agreements with the other JINX
(operated by PCH and UltraDNS) users. Each JINX user must provide ISPA with a clear policy
for interconnection with other JINX users and must notify
Graphs of the traffic across the JINX switch fabric are
ISPA of any changes to this policy. Members not publishing a
available at: http://stats.jinx.net.za. Information on the
specific interconnection policy of their own agree to exchange
consolidated traffic at JINX is publicly available while detailed
traffic with all other participants on a no-charge basis. JINX
traffic graphs for each individual switch port is available to
members may also offer transit services to other members.
ISPA members.
Content-server hosting is not available at the exchange.
Membership, fee structure and interconnection policies
ISPA’s policy is not to compete with its own members that
There are five categories of ISPA membership: Large,
provide hosting services. While it may seem appealing to host
Medium, Small, Affiliate, and Honorary. Large, Medium and
a server at a central location, ISPA points out that there is a
Small are all voting membership categories, while affiliate
negligible difference in performance if the server is hosted on
and honorary are special non-voting categories. In order to
the network of an ISPA member with a high-speed connection
qualify as a large, medium or small member, a South African
to JINX.
Electronic Communications Service (ECS) or Electronic
Communications Network Service (ECNS) licence must be An example of a South African ISP’s interconnection
held and/or the member must be in the business of providing policy statement, provided by the Internet access provider
Internet access services. These are defined as follows: Storm, states that the ISP will exchange traffic with all other
participants on a no-charge basis, provided that they:
• Internet access providers, including Virtual Internet
Access Providers (IAPs), are those where a member 1. Are in the business of providing Internet access
of the public contacts the company and obtains a price to more than one organisation or group of companies
for Internet access, including Internet access bundled with common shareholding;
with VoIP.
2. Act in good faith and in a cooperative manner
• Server hosting companies where a member of the public on issues relating to the interconnection;
can obtain a price for the hosting of a physical server
3. Respect Storm’s acceptable-use policy and the
(not a website)
generally accepted Internet etiquette;
• Internet infrastructure providers that provide equipment
4. Utilise the interconnection in such a manner so as
and on-going services critical to the operation of the
to reduce the costs of exchanging traffic between the
Internet in South Africa
parties and improve connectivity between the parties;
Applicants are free to determine their own membership
5. Take all reasonable measures to ensure that they
category. The category of ISPA membership determines
do not compromise the integrity or stability of Storm’s
what level of access each member gains to ISPA’s Internet
network; and,
exchanges.
6. Comply with the technical requirements required
There is a minimum membership requirement for access to
to facilitate the interconnection, including ensuring
some ports. For access to 10 Gbps and 1 Gbps ports, ISPs
that sufficient bandwidth is always available on
must be ‘Large’ ISPA members. For access to 100 Mbps
interconnection links.
ports, ISPs must be either Medium or Large ISPA members.
Small, Medium, and Large ISPA members can all use 10 http://www.ispa.org.za/jinx
Mbps ports.
NAPAfrica
All interconnection at JINX must take place via the JINX NAPAfrica is a more recent entrant into the South African IXP
switch fabric. This means that there may be no peer-to- sector, hosted by the commercial Teraco data-centre facilities
peer interconnection within the JINX cage and that all traffic and operating since 2010 in the Johannesburg and Cape
exchanged must be via the switch. The policy does not apply Town areas as neutral, Layer 2 facilities providing IPv4 and
to an ISP paying the 10 Gbps port charge; this gives the ISP IPv6. The service is provided free with no membership or port
the right to interconnect privately. A JINX user can pay the fees. NAPAfrica promotes multilateral peering arrangements
10 Gbps port charge to gain this benefit, but will use a lower- in which one agreement provides access to all peers without
speed port on the switch. restriction and ability to provide up to 10 Mbps of fibre last-
mile capacity to both JINX and CINX.
ISPA does not require JINX users to interconnect with all
other JINX users. Each organisation is free to establish http://www.napafrica.com
its own policy for interconnection. Each user of JINX must
www.internetsociety.org 55

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Tanzania (RITA) with support from SIDA (the Swedish International
Development and cooperation Agency) in collaboration with
The Tanzania Internet
the Swedish Royal Technical Institute (KTH). Four technicians
eXchange (TIX) is a project of
participated who were drawn from the two main educational
the country’s ISP association,
institutions (which were also commercial ISPs) — the National
the Tanzania Internet Service
University of Rwanda (NUR) and the Kigali Institute of Science
Provider Association (TISPA).
and Technology (KIST).
TISPA was registered as a
nonprofit organisation in 2002 Finding the appropriate facilities for the IXP was an initial
with the primary purpose issue in setting up RINEX. Obtaining independent premises
of establishing a formal entity to support the creation and supplied with electricity, a backup power generator, security,
management of a local IXP. By September 2003, the facilities telephones, office space, and an air conditioner proved
were ready and the national regulator, the Tanzanian Commu- impossible. The academic entities in Rwanda lack appropriate
nications Commission (TCC), issued a letter instructing all physical facilities and the private ISPs had limited physical
ISPs to connect to TIX. The first successful BGP session capacity. So it was decided to host the IXP at the premises
between two of the ISPs took place the following month. of the incumbent telecom operator, Rwandatel, which already
had existing connections to most of the Internet providers.
A Layer 2-based IXP model was agreed by the stakeholders.
THE HEART OF THE EXCHANGE IS A HP PROCURVE
Each network operator provides a circuit from its backbone
8000M ETHERNET SWITCH WITH 64 10/100MBIT PORTS,
and a router that connects to the IXP switch. The equipment
DONATED BY THE NETWORK START-UP RESOURCE
located in the IXP premises consists of the IXP core switch,
CENTER (NSRC). member routers, and communications equipment. Currently,
there are 5 members of the exchange and they are all
required by government to exchange routes to their customers
TIX is situated in a small room on the top floor of an office directly with each other over the exchange.
block in Dar es Salaam. To cope with the unreliable power
A major problem in maintaining RINEX was the absence
supply in the city, TIX has one 3kVA online UPS with 15
of an industry association that could take responsibility for
external batteries. To reduce the ambient temperature in the
management of the IXP. As a result, the Rwanda Information
city’s tropical climate, two window-unit air conditioners are
Technology Authority (RITA) manages the exchange until its
deployed. All electronic equipment is housed in two full-height
members are able to establish an appropriate management
cabinets. The central IXP equipment is in one cabinet and the
structure and nonprofit institution to host it. In the interim,
routers of participating ISPs and peers are in the second.
a simple administrative model has been adopted where all
The heart of the exchange is a HP Procurve 8000m Ethernet members have equal decision-making power, independent of
switch with 64 10/100Mbit ports, donated by the Network size. The management structure consists of two entities: the
Start-up Resource Center (NSRC) (www.nsrc.org). TIX has RINEX Council and the Executive Committee. The RINEX
two route server routers: a Cisco 2514 and a Cisco 1760. Council is a formal managerial unit that is responsible for
An instance of the K-Root DNS server is also hosted at TIX. making decisions regarding RINEX. The Council is composed
of one representative from each connected organisation or
http://tix.or.tz
member and a president. Presidency of the RINEX Council is
continued on a rotational basis among all the members.
Rwanda
Beginning in 2002, Internet http://www.rinex.org.rw
providers in Rwanda discussed
the need for an IXP. By mid- Zambia
2003, the tipping point was Based in Zambia’s capital,
reached with the presence of Lusaka, the Zambia
two independent ISPs in the Internet Exchange (ZIXP)
country and technicians from is a volunteer-driven,
the various Internet providers nonprofit membership
trained in the techniques of setting up and maintaining exchange operating with
a peering point. After a year’s preparation, the Rwanda donated equipment.
Internet Exchange (RINEX) was launched in mid-2004 by The ISP Association of
the Government’s Rwanda Information Technology Authority
56 www.internetsociety.org

CASE STUDIES
Zambia (ISPAZ) hosts ZIXP. A national broadband provider, Reunion & Mayotte
AfriConnect (owned by mobile operator Vodacom) provides
The island of Reunion is a
space at its premises for the switching gear at no cost to the
French Protectorate. The
ZIXP community.
IXP, REUNIX, is hosted at
ZIXP currently has 13 members (all ISPs) with traffic mostly the RENATER academic and
delivered over 100Mb Ethernet and with peak traffic running research network facility at the
at about 280Mbps. Université de Saint Denis de
La Réunion. With 10 members
To support capacity building, ZIXP has twinned with UK
and free peering, REUNIX
exchange LINX (see below). Among ZIXP’s objectives for
provides multicast and DNS services for .fr and .re. RENATER
2013 were a redesign of its architecture, the opening up
operates similar facilities in Mayotte (Mayotix) and in French
of membership to non-ISPs, and the hosting of .zm name
Guyana (Guyanix).
servers. ZIXP intends to provide transit at the exchange
for its infrastructure, and intends to join the African IXP
Egypt
association, Af-IX.
In 2002, Egypt became the
http://www.ispa.org.zm
first country in the Arab region
See an in-depth interview with ZIXP on the IXP Toolkit Portal: to create an IXP, CAIX, on the
www.ixptoolkit.org/casestudies back of a dynamic ISP market
and Egypt’s position as the
hub location for a large number
Uganda
of international submarine
In 2001, the Uganda Internet
cable landings. Egypt was also
Exchange Point (UIXP) was set
among the first countries in Africa to host root and top-level
up with three initial participants
domain name servers at the IXP. Fostered by the Ministry
in Kampala in a small room
of Communications and Information Technology (MCIT), 60
in the parking garage of an
local ASNs with 232 international links were hosted at CAIX
office block provided by the
by 2010. CAIX continues to be operated by the National
national regulator, the Uganda
Telecommunication Regulatory Authority (NTRA) and hosted
Communications Commission.
by Telecom Egypt in its Ramses central office. In addition,
Since then, UIXP has grown to eight members with about
GPX Global Systems, a private-sector data centre operator
150Mbps of peak traffic.
with a presence in Mumbai, provides IXP services known
Migration from a Layer 3 to a Layer 2 architecture took place as MEIX.
in 2012 with support from an ISOC community grant. The
At CAIX, there are four ISPs (TEDATA, Vodafone, Linkdotnet,
project was started in January 2012 with the installation of
Etisalat) connected via a gigabit interface and three ISPs
a power backup system, and involved replacing the 800va
(Noor, MenaNet, YALLA) connected via Fast Ethernet. Peak
inverter + 100ah battery, which had served for over 10 years,
traffic currently runs at about 1.1Gbps. In addition, CAIX hosts
with a new 3kva inverter and two 100ah batteries. As a result
PCH’s Anycast servers that have copies of about 30 ccTLDs.
of this upgrade, UIXP has been able to continue operations
for months without any power outage despite frequent power There are no fees for connecting to CAIX; however, content
cuts, thus paving the way for installation of more equipment. providers and service providers wishing to host their servers
where CAIX is located pay hosting fees to Telecom Egypt.
WIth a donation from OSI, hardware for the route server was
Interconnection policy requires that all traffic exchanged must
installed and commissioned in 2012 with both IPv4 and IPv6
be via the CAIX switch fabric, that all members must peer with
peering enabled. Orange Uganda, which offered bandwidth
CAIX router, and that all members must advertise all local IP
and technical configuration to the UIXP, had launched IPv6
routes they have in their routing tables to the CAIX router.
services during the week previous to the UIXP installation and
A scarce resource policy is also in place where the CAIX
was subsequently the first to peer with the new route server
administration team has the right to reclaim under-utilized
on IPv6.
resources if they are needed for another CAIX member that
http://www.uixp.co.ug can demonstrate a need for those resources.
http://www.caix.net.eg
http://www.gpxglobal.net
www.internetsociety.org 57

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
6.2. ASIA
Hong Kong
The first free IXP in Asia
was the Hong Kong Internet
Exchange (HKIX), started in
1995 and administered by the
Chinese University of Hong
Kong (CUHK). In 2004, the
HKIX2 back-up mirror site
was created. HKIX continues
to be one of the primary locations for Asian peering with a
peak traffic volume of about 265Gbps and 196 participants
(112 licensed network providers and 84 service operators).
Figure 6.3. Biznet Networks (Source: http://www.biznetnetworks.com/
There are also a number of other IXPs in Hong Kong, En/?menu=globalipnetwork)
including commercial data centre operators, iAdvantage
and Equinix.
Once a port has reached 80% utilization, customers are
At HKIX, there is currently no plan to impose any charges required to upgrade or order a new connection to the peering
for membership or connection. However, HKIX reserves switch. As would be expected from a telco-hosted exchange,
the right to do so in the future should such charges become multilateral peering agreements are expected. In addition,
necessary. As with some other IXP’s, HKIX’s policy is that domestic networks must interconnect at a minimum of two
each participant must have its own global Internet connectivity physically diverse peering points. International networks may
through other Internet access provider(s) that are independent interconnect at a single peering point.
of HKIX facilities. In this respect, the connection to HKIX is not
Other IXPs in Jakarta include the semicommercial NAP Info
to be used as the primary connection to the global Internet.
IIX, operated by a carrier, and OpenIX.
The only shared services provided by HKIX are instances
of four root servers. http://www.biznetnetworks.com
http://www.openixp.net
http://www.hkix.net
http://www.nap.net.id
Indonesia
Mongolia
Biznet Indonesia
The case of Mongolia
eXchange (BIX) is
demonstrates that
one of about five
ISP cooperation with
IXPs in Jakarta. BIX
tacit support from
is managed by Biznet
governmental authorities
Networks, one of
can lead to the rapid and
the larger telecom operators in Indonesia that owns inner-
successful establishment
city and intercity fibre optic networks in several major cities
of an IXP in a developing
in Indonesia, providing voice and Internet services for both
country. In January 2001, a group of leading Mongolian
business and residential users (figure 6.3.)
network operators met in Ulaanbaatar to explore the creation
BIX is directly connected with Biznet’s Metro and FTTH fibre of a national IXP. At the time, all Mongolian ISPs were
networks that provide connections between commercial interconnected via providers in the United States or Hong
offices, homes and data centres. It also provides NTP Kong. As a consequence, satellite latencies amounted to a
synchronisation and is available in two POPs in the city. minimum of 650 milliseconds (over half a second) for each
58 www.internetsociety.org

CASE STUDIES
packet of data in each direction. Costs were needlessly high
and not surprisingly, very few Mongolian Internet business
services were hosted within Mongolia. THE CASE OF MONGOLIA DEMONSTRATES
By 2001, this situation had created sufficient incentive for THAT ISP COOPERATION WITH TACIT SUPPORT
Mongolia’s three leading Internet providers to agree to FROM GOVERNMENTAL AUTHORITIES CAN
develop an independent exchange. Within 3 months of
LEAD TO THE RAPID AND SUCCESSFUL
initiating the project, the three ISP members launched MIX
ESTABLISHMENT OF AN IXP IN A DEVELOPING
in April 2001. By March 2002, the MIX had six ISP members
with steadily increasing traffic between them. Local latency COUNTRY.
was initially reduced to less than 10 milliseconds per
transaction (compared with a minimum of 1300 milliseconds
in the pre-MIX days).
6.3. LATIN AMERICA
Brazil The number of IXPs grew from four to 19 between 2006 and
2010 and the total today stands at 24 different locations,1
Brazil has a large number
covering 16 of Brazil’s 26 states, with aggregate peak traffic
of IXPs, the result of strong
of about 250Gbps. Charges are not normally levied on
government policy support
participants at these exchanges.
combined with an effective
multi-stakeholder agency In the larger urban areas, most of the PTTs operate as
responsible for the stewardship geographically distributed IXPs within a particular metro area
of the Internet in Brazil, the with multiple interconnection locations. The largest of these
Comitê Gestor da Internet and the first IXP of the project was established in São Paulo;
no Brasil (CGI.br). CGI has access to funding from the it is now the largest IXP in the region both in terms of peers
registration of .br domains and has legal status as the agency and traffic exchanged. The exchange clocks about 175Gbps
responsible for promoting the development of the Internet in of peak traffic and with over 300 networks exchanging data,
Brazil with representation from government, the private sector it is the seventh largest worldwide in terms of participants.
and civil society. Domain name root server instances are hosted at about 15
of the IXP locations around the country.
Until 2003, only three cities had an operational IXP. Almost
20 cities in Brazil have more than a million people, so there
Brazil PTT IXP nodes throughout the country
was much tromboning of local traffic, negatively affecting both There also are independent exchanges operating outside the
costs and quality of service outside a few urban areas. PTT model, most notably Terremark (owned by Verizon) that
operates NAP Brasil under agreement with Fapesp, a public
In 2004, CGI launched an initiative to create more IXPs,
research foundation. In addition, a variety of commercial data
known as Ponto de Troca de Tráfego (PTTs), in cities across
centres exist where networks peer bilaterally.
the country. These were established in partnership with a
variety of network operators (from universities to large ISPs CGI lists 16 potential planned sites2 for IXPs and 47
and telecom providers). CGI is responsible for network additional sites are under consideration. The ptt.br website
administration while NIC.br provides the equipment and
management. This strategy has helped to reduce setup 1 http://ptt.br/localidades/atuais
and transport costs for smaller players while still providing 2 http://ptt.br/localidades/register
a neutral platform for traffic exchange with larger network
operators.
www.internetsociety.org 59

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
In November 2013, Telmex, the Mexican incumbent and
dominant provider, claimed that it is not necessary to establish
an IXP. To support its view, Telmex pointed out that local
content only makes up 0.6 percent of the Internet traffic in
Mexico, saying that so little traffic does not justify setting up
a local Internet exchange. Aside from the benefits that an
IXP can contribute to the creation of a better environment for
local content generation, companies such as Kio Networks,
which intends to install an IXP in its Santa Fe data centre in
Mexico City, have responded by pointing out that the presence
of such infrastructure would provide Mexico with greater
sovereignty over data generated by local Internet users.
The six-membered Consortium for Internet Traffic Exchange
is expected to develop and operate the IXP. Mexico’s commu-
PTT.br Locations Currently in Operation
nications regulatory body, COFETEL, is supportive of the IXP.
(www.ptt.br) actively solicits proposals for new IXP locations
Bolivia
with a detailed online application form.3 One of the criteria
Bolivian state-owned telecom
used to determine the need for establishing a new IXP is
operator, Empresa Nacional
that at least three Autonomous Systems (AS) in the location
de Telecomunicaciones
are interested in participating in an Internet exchange. In
(Entel), and five privately
determining the size of the area covered by an IXP, CGI
owned operators are planning
normally uses a radius of approximately 80km for fibre optics
to set up the country’s first
and 200km for radio links.
two IXPs. Bolivia’s telecoms
http://www.cgi.br regulator, La Autoridad de
Telecomunicaciones y Transportes (ATT), is supporting the
Mexico project. The five private firms are expected to jointly launch
one IXP while Entel will build its own separate IXP. Both
Despite its size and
projects are expected to cost approximately US$30,000.
level of economic
development, Mexico
is the only OECD
Argentina5
member country A group of small and medium-
without any domestic Internet exchange capacity. Mexico has size network operators, called
had a restrictive telecommunications and Internet service CABASE, founded the first
market until very recently and as a result, has not seen the IXP in Argentina (the first in
emergence of an IXP. The lack of domestic traffic exchange South America) in 1998, NAP
has had a dramatically visible effect on Mexican transit pricing Buenos Aires, which now has
relative to other economies of similar size and development. 46 members. Drawing on this
experience, CABASE began
However, following substantial changes in legislation
to establish IXPs in small and medium-size markets across
introduced in 2013 that open the telecom sector to new
Argentina in 2011 (table 6.1).
entrants, the market is now in a process of major change.4
This change is underscored by recent public discussions The model for these IXPs is unusual in that they both allow
regarding establishment of an IXP in the country — discussions network operators to exchange local traffic and interconnect
that aptly demonstrate the entrenched positions typical of to NAP Buenos Aires, thus forming a virtual IXP with national
reach. The first IXP was established in the city of Neuquén
many incumbent or dominant fixed or mobile operators.
3 http://ptt.br/localidades/register 5 This section on Argentina is based on Connectivity in Latin America and the
4 COFETEL, the Mexican regulator, has opened access to competitive long-haul Caribbean: The Role of Internet Exchange Points, Hernán Galperin, Ph.D.
circuits and licensed a second national carrier. Universidad de San Andrés/CONICET (Argentina). hgalperin@udesa.edu.ar
60 www.internetsociety.org

CASE STUDIES
| 	 	                | 	             | Pop.		      | 	        | Peak	traffic	  |
| ------------------ | ------------- | ----------- | -------- | -------------- |
|   City             | State         | (in 000s)   | # peers  | (Mbps)         |
| NAP Cordoba        | Cordoba       | 1,390       | 9        | 100            |
| NAP Bahia Blanca   | Buenos Aires  | 301         | 12       | 180            |
| NAP de la Costa    | Buenos Aires  | 70          | 5        | 90             |
| NAP La Plata       | Buenos Aires  | 731         | 8        | 120            |
| NAP Mar del Plata  | Buenos Aires  | 765         | 4        | 270            |
| NAP Mendoza        | Mendoza       | 916         | 9        | 130            |
| NAP Neuquén        | Neuquén       | 233         | 13       | 750            |
| NAP Rosario        | Santa Fe      | 1,251       | 16       | 180            |
| NAP Santa Fe       | Santa Fe      | 500         | 8        | 55             |
Table 6.1. Snapshot of the CABASE Regional IXP Initiative April 2013 (Source: CABASE and INDEC)
with support from the local government. To date, nine IXPs  The exponential rise in traffic from the establishment of new
operate in five provinces, connecting over 80 network operators  IXPs has enabled the Buenos Aires hub to attract peering from
through the central routing hub in NAP Buenos Aires. The total   new operators and content providers such as Google, which
switched traffic across the networks is about 8.4Gbps, which   joined NAP Buenos Aires as a special member in late 2011.
currently represents over half of the ASNs allocated to Argentina.
6.4. THE CARIBBEAN
HE ISLAND NATIONS OF THE CARIBBEAN HAVE  assistance from Packet Clearing House (PCH),6 a U.S.-based
T
suffered historically from high communication costs  research nonprofit working to improve interconnection, and
and market dominance by a small number of regional  with support from the Caribbean Telecommunications Union,
operators. The lack of competitive markets has resulted in  a regional ICT policy development agency.
relatively few ISPs and IXPs emerging in the region with IXPs
existing, at present, only in the British Virgin Islands, Haiti,
THROUGH A REGIONAL OUTREACH
Grenada, St Maarten, Curacao and Dominica. Exchanges
INITIATIVE, BRANDED THE CARIBBEAN ICT
located on St Maarten (OCIX) and Curacao are the largest in
the region with peak traffic of about 430Mbps and 3.8Gbps,  ROADSHOW, THE CTU AND PCH HAVE BEEN
respectively. RAISING AWARENESS OF THE PURPOSE
However, several other Caribbean countries, including  OF IXPS AND THEIR POTENTIAL BENEFITS
Barbados, St. Lucia, Jamaica, and St Kitts and Nevis, are
TO DEVELOPMENT IN THE REGION. AS A
in the process of establishing local IXPs with technical
RESULT, TWO IXPS EMERGED IN 2011,
BVI-IX IN THE BRITISH VIRGIN ISLANDS
6   Much of this section is based on PCH's Bevil Wooding article at http://www.
AND THE GRENADA INTERNET EXCHANGE
circleid.com/posts/20110524_building_caribbean_internet_infrastructureone_
ixp_at_a_time/
POINT (GREX).
www.internetsociety.org 61

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Through a regional outreach initiative, branded the Caribbean Puerto Rico
ICT Roadshow, the CTU and PCH have been raising
In 2011, Google partnered
awareness of the purpose of IXPs and their potential benefits with the Puerto Rico
to development in the region. As a result, two IXPs emerged Bridge Initiative (PRBI)
in 2011, BVI-IX in the British Virgin Islands and the Grenada to improve broadband
Internet Exchange Point (GREX). These IXPs were “turned- speeds and costs in
up” following a watershed agreement to exchange local traffic Puerto Rico. One of the
from the region’s largest ISPs, which had traditionally been significant challenges
reticent about exchanging local traffic. The governments and facing Puerto Rico is that most Internet traffic is routed to
national regulatory agencies played roles in supporting the the US mainland. By deploying Google Global Cache at the
IXP implementations, while CTU and PCH aided the process PR-NAP in Puerto Rico and peering with PRBI in Miami, it
with technical and policy recommendations and interventions was possible to reduce the amount of Internet traffic traversing
to help bring the service providers into agreement. the key links.
The Dominica National Internet Exchange Point (DANIX) was https://cw.ams-ix.net
launched in early 2013. Working groups to help set up IXPs www.bvi-ix.net
have been established in St. Kitts and Nevis, Trinidad & Tobago, www.ocix.net
St Lucia, Suriname, and Barbados. Root domain name server http://ixgd.wordpress.com
copies have also been set up in St Maarten, Grenada, and Haiti. http://www.prbridgeinitiative.org
6.5. THE PACIFIC
New Zealand over the past year and claims that the SDN architecture
approach for the exchanges is the first of its type in the
In New Zealand,
world. According to the company, the main benefits of SDN
CityLink Limited, a
IXPs are that they are more secure, stable and predictable.
telecommunications
North American SDN switch vendor, NoviFlow, will supply the
company that was
OpenFlow 1.3 compliant switches for CityLink. The cost of the
formed as an initiative
SDN rollout is said to be similar to current 10Gbps networking
of the Wellington City
equipment.
Council in 1995, operates five neutral Internet-exchanges
nationwide. CityLink started with a fibre-optic network in the
city’s central business district (CBD) in 1996 that runs along Small Islands
the overhead network used for the city trolley buses. Now part The Pacific Islands face even more severe problems than
of the TeamTalk group, CityLink operates a network of fibre the Caribbean Islands, with very high communication costs
optic cabling around the CBDs of Wellington and Auckland and small markets scattered over vast distances. In some
and has a network of Wi-Fi hotspots around Wellington. respects, this increases the value of an exchange where
The exchanges are operated under the ExchangeNET there is more than one upstream network provider. This is
brand and are present in Auckland, Hamilton, Palmerston the case in Fiji where Telecom Fiji and FINTEL networks
North, Wellington and Christchurch. Auckland is the largest are now directly connected locally following the successful
exchange with 83 members. establishment of an IXP earlier this year.
CityLink announced this year that it would adopt a software- In Vanuatu, after four years of negotiation with the
defined networking solution in the five peering points. It has stakeholders, the technical infrastructure to start the country’s
been testing equipment from SDN-enabled switch vendors first IXP was set up in two weeks.
62 www.internetsociety.org

CASE STUDIES
6.6. WESTERN EUROPE
United Kingdom 1. Telehouse North
The UK has increased the 2. Telehouse East
spread of neutral exchange
3. Telehouse West
points in the country with
the two IXPs in London now 4. TelecityGroup, 6&7 Harbour Exchange Square
being joined by ones located
5. TelecityGroup, 8&9 Harbour Exchange Square
in Manchester, Leeds, and
6. TelecityGroup, Bonnington House, Millharbour
Edinburgh. In the 2000s, there
were at least four well-known 7. TelecityGroup, Sovereign House, Marsh Wall
IXPs in London along with several smaller ones. However,
8. TelecityGroup, Powergate
it appears that the city cannot sustain so many neutral IXPs
as LINX and LONAP are the only two that remain. There are 9. Equinix, London-4
a number of commercial interconnection services available
10. Interxion, London City
in London and other major centres from network providers
LINX does not own any of these sites, but is a tenant in
such as Edge-IX.
an existing co-location facility or carrier hotel. At least two
The London Internet Exchange (LINX) switches (one from each vendor) are installed in each
LINX is one of the world’s largest and longest-established LINX London location. The locations are interconnected by
Internet exchanges. LINX currently has about 400 members multiple 10-gigabit Ethernet circuits (across dark fibre) to form
in over 50 countries. While most of the members are from two physically separate backbone rings (one with Juniper
Europe, many are based outside this region, particularly from equipment, the other with Extreme).
North America but also from Africa, the Middle East, Asia, and
Most LINX members connect to both switching platforms
Oceania. LINX facilities have over 890 connected member
that reduce the impact of any downtime on a single network
ports with about 450 member-facing 10GigE ports and over
element. For extra redundancy, some members choose to
1.2Tb/sec of peak traffic.
connect at multiple locations. LINX also provides a ‘Linx from
LINX is a mutually-owned membership association for Internet Anywhere’ remote peering service that is provided by Layer
operators that also represents the interests of its members on 2 carriers to enable peering at LINX from around the globe.
related public policy matters. Initially, LINX membership was About 50 LINX members currently use this method to connect,
restricted to operators of Internet access networks (traditional hosting no equipment in London but instead, taking an
ISPs). In 2000, this restriction was relaxed and now a wide Ethernet port from one of its partners. Normally, the member
variety of networks peer at LINX exchanges, including pays the carrier for the transport service and LINX for its
large content providers such as the Google, Yahoo, and the standard fees although some carriers may bundle LINX fees
BBC. The diversity of service providers peering at LINX is as well. This is part of LINX’s ConneXions service that allows
third parties to resell LINX 10GE or 100GE ports.
increasing and includes gaming and gambling specialists,
media streaming providers, DDoS mitigation specialists, Physical protection of the dark fibre network is achieved by
software-as-a-service providers, and advertising networks. using diverse paths where available. Management of the
redundancy of the network uses rapid-failover protection
Infrastructure
mechanisms (EAPS or MRP) so that in the event of a network
LINX operates a number of separate switching infrastructures,
interruption, the redundant links are activated within tenths of
including two in London and one in Manchester, and provides
a second.
technical support for one in Scotland. The LINX London
network consists of two separate high-performance Ethernet Geographic expansion
switching platforms installed across ten locations: The Manchester site, known as IXManchester, was launched
www.internetsociety.org 63

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
in June 2012 and is run on Brocade switches located in Rooms (MMR) to the operator of the interconnect service and
Telecity Williams House. Members can also connect to IX agree to an initial term of five years. Services will include the
Manchester from Telecity Kilburn. Members of IX Manchester provision of a public Internet exchange, private VLAN and
are full members of LINX, paying the same membership fee private wavelengths plus point-to-point dark fibre.
and having the same voting rights. The LAN in Manchester is
LINX also has a twinning programme to support IXPs
completely separate to the two London LANs and is open to
in emerging markets and has twinned with the Zambian
all LINX members. This location was the first in an on-going
exchange, ZIXP.
regional peering programme that includes plans for other
major UK locations. LONAP
LONAP is a neutral, not-for-profit IXP that has been based
in London since 1997. LONAP currently has 134 members,
TO ADDRESS THE SCARCITY OF PUBLIC
making it the second largest IXP in the United Kingdom
PEERING OPTIONS IN THE US AS COMPARED with traffic currently peaking at about 44Gbps. LONAP
TO EUROPE, LINX HAS ALSO BEEN INVOLVED membership is usually the first step in peering for smaller
ISP’s and hosting companies prior to joining LINX.
IN SETTING UP EUROPEAN-STYLE, NONPROFIT
INTERCONNECTION FACILITIES IN THE US As a membership organisation, the exchange is owned by the
networks that participate in it. As a condition of membership,
KNOWN AS OPEN IX.
the rules of the exchange require a member to connect
and peer at the exchange, but membership is open to any
The most recent of these is IX Scotland, hosted at the Pulsant organisation worldwide that wishes to peer. Membership of the
SouthGyle data centre in Edinburgh and launched in October organisation is UK GBP2000 per year; this fee provides for
2013. There have been at least two efforts to set up an IXP two 1Gbit/s connections to the exchange at no further charge.
in Edinburgh in the past 15 years, both of which failed. In 10Gbit/s Ethernet ports are charged at UK GBP2500 per year.
2004, LINX supported one of these — UIXP — with a loan
LONAP uses a network of interconnected Extreme X series
of hardware and general assistance, but UIXP was unable
switches linked to each other through diverse 10 Gbps fibre
to continue operations because the data centre hosting the
rings that connect five sites in the London Docklands and City
IXP, Scolocate, withdrew support. IX Scotland has a steering
areas; Telehouse Docklands North & East, Telecity Sovereign
group that is responsible for managing the community; LINX
House, Telecity Harbour Exchange, and InterXion London City.
provides the technical support. To access IX Scotland, it is
In addition to these sites, remote peering is possible via
necessary to be a LINX Member.
LONAP, using a third-party, Layer 2 network with dark fibre or
To address the scarcity of public peering options in the US as
wavelengths. Members based in multiple points of presence
compared to Europe, LINX has also been involved in setting
(PoPs) can connect to LONAP in more than one location
up European-style, nonprofit interconnection facilities in the
in order to increase their service resiliency. Members are
US known as Open IX. Traditionally, private peering has been
permitted to pass traffic between their own ports and can
the dominant model in North America, but there is a demand
request private VLANs between their own ports or to other
from network operators for mutually-owned public peering in
members for purposes such as for DSL aggregation. LONAP
the United States. The biggest IXPs in the world are all based
has on-site spares of the critical equipment that powers
in Europe with only one North American exchange being in
the network; these spares assist in responding quickly to
the world’s top 10 (Terremark’s NAP of the Americas located
any problems that may arise. An off-network, ‘out-of-band’
in Miami), a situation that contrasts with the fact that there
connection is present at LONAP sites so that problems can
is more traffic in the US than anywhere else. The aim of the
be addressed remotely without waiting for staff to be on site.
Open IX project is to work with major data centres to allow
IX Leeds
third-party interconnect platforms in their premises.
After two years of preparatory work to establish an exchange
The first Open-IX exchange was launched in October 2013
in the Yorkshire area, IXLeeds was set up in 2010. It is
in the Northern Virginia area with a choice of three different
an independent, not-for-profit IXP based in Leeds with 18
physical data centre locations. Called LINX NoVA, the
members and about 2Gbps of peak traffic.
exchange is built with Juniper MX series routers and will be
http://www.linx.net
available in Ashburn, Reston, and Manassas. The sites will
http://www.lonap.net
be connected by diverse dark fibre lit by LINX.
http://www.edge-ix.net
The Open-IX proposal states that in order to participate,
http://www.ixleeds.net
each data centre must agree to open up their Meet-Me-
64 www.internetsociety.org

CASE STUDIES
Netherlands Statistics provided include:
AMS-IX • Colocation traffic
To meet the needs of its
• Real Time Stats
many and diverse members,
AMS-IX has one of the most • sFlow Stats
sophisticated networks found in
- Frame size distribution
an IXP as well as a particularly
detailed set of policies, - IPv6 Traffic
procedures and traffic metrics.
- Ether Type
To fill the gap between 1, 10, and 100Gbit/sec port offerings,
- Multicast
AMS-IX offers link aggregation for 1Gigabit and 10Gigabit
Ethernet ports. This technique allows for the bundling of - Broadcast
two or more Gigabit Ethernet links into one virtual channel,
• Historical Traffic Data
negating the need for additional routers.
• Route Server Stats
Service-level quality is regularly measured by a trusted
third-party and AMS-IX provides a carrier-grade SLA with • GRX Statistics
service credits up to 100% of the monthly fees upon under-
https://www.ams-ix.net
performance. AMS-IX provides members with statistics on
key performance indicators: delay, delay variation (jitter) and
France
frame loss. To measure these indicators, AMS-IX uses Delay
SFINX
Measurement Messages provided by the ITU-T Y.1731
SFINX, the first IXP in France,
Ethernet OAM standard. Every switch in the network has
was established in 1995 and
a measurement probe attached to it that exchanges these
hosted by the French academic
measurement messages over the platform in a separate
and research network,
VLAN.
RENATER (Réseau National
AMS-IX technical policies include:
de Télécommunications pour la
• 100base and 10base Ethernet interfaces attached to Technologie, l’Enseignement et la Recherche). The exchange
AMS-IX ports must be explicitly configured with speed, has two POPs in Paris interconnected by two 10 gigabit
duplex or other configuration settings; i.e., they should Ethernet links. With 90 members, peak traffic runs at about
not be auto-sensing. 28Gbps.
• Because the AMS-IX infrastructure is based on the SFINX provides VLAN services and also hosts an NTP server
Ethernet II (or “DIX Ethernet”), standard LLC/SNAP as well as domain name mirrors for three root servers and four
encapsulation (802.2) is not permitted. AFNIC DNS servers. RENATER’s CERT service is supported
by SFINX.
• Frames forwarded to an individual AMS-IX port shall
all have the same source MAC address. FRANCE-IX
France-IX is the largest IXP in France with 223 members
• Use of proxy ARP on the router’s interface to the
and about 220Gbps of peak traffic. France-IX’s infrastructure
exchange is not allowed.
consists of seven PoPs in Paris and one PoP in Marseille,
• Frames forwarded to AMS-IX ports cannot be addressed
using Brocade and Force 10 equipment.
to a multicast or broadcast MAC destination address
France-IX also operates its own links to a number of
except as broadcast ARP packets and multicast ICMPv6
neighbouring IXPs (SFINX, LyonIX, LU-CIX (Luxembourg),
Neighbour Discovery packets.
Top-IX (Italy), TouIX (Toulouse), etc.). France-IX members
• No traffic for link-local protocols on AMS-IX ports except
may use these links for connections of up to 100Mbps after
for ARP and IPv6 ND
which they need to purchase their own links.
• All new ports activated are first placed in their own
LyonIX, GrenoblIX, SaintetIX and ADN-IX
separate Quarantine VLAN, together with a monitor
These four exchanges, in Lyon, Grenoble, Saint Etienne,
port, in order to first ensure proper functioning and
and Valence are managed by the nonprofit group Rezopole.
configuration of the link.
LyonIX was the first and is the largest of the four, established
in 2001 by a group of Internet pioneers who subsequently
www.internetsociety.org 65

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
formed the Rezopole group to promote connectivity in the INEX’s website that shows the peering links of each member.
Rhone-Alps region. https://www.inex.ie/ixp/peering-matrix
LyonIX has two POPs providing service to 80 members. Established by four ISPs in 1996, INEX was volunteer-run
Aside from peering services, it also provides to its members until 2004 when it employed a general manager. That year
dark fibre and wavelengths between its POPs as well as the Irish Government’s Industrial Development Agency (IDA)
hosting services, DNS resources for a number of TLDs, NTP provided a loan facility to the exchange for capital expansion
synchronisation, RPKI facilities, ftp servers, and open-source and marketing. The investment also provided the means to
software mirrors. LyonIX also provides a link to the Italian expand the exchange to a second site and employ a second
IXP network, Top-IX. staff person to do marketing and membership development.
The second site went live in March 2005 with two resiliently-
Services are also provided to the general public, including
configured Cisco 6500s connected with a dark fibre ring.
video conferencing, data storage (up to 1Gb), FTP for up to
10 files, a Google Maps API, an RDV meeting scheduler, and An Associate Membership category was announced in 2005
group document editing. The LyonIX website is notable in to address the needs of organisations that do not have IP
displaying a map showing the location of each of its members traffic to peer at the exchange but want to join the community
and POPs. that INEX represents – Internet-related services, including
fibre wholesalers, colocation and hosting facilities, related
SaintetIX was set up in 2009, while GrenoblIX and ADN-IX
technology suppliers, and public service organisations.
were established in 2012. GrenoblIX has two POPs and
Associate members benefit from being part of this community
currently has three members while the other two exchanges
by receiving free access to INEX member meetings,
each have two members.
invitations to key industry events arranged by the association,
In Strasbourg, the IXP is called EuroGix. It is intended to be
and access to various INEX mailing lists.
a cross-border IXP for the upper Rhine basin and currently
Further technical developments in late 2005 led to the
has five members.
implementation of multicast at the exchange in order to
Fr-IX is operated as a cooperative called Opdop and has 18
provide an opportunity for the broadcast community to use the
members. Its mission is to support the development of local
Internet as a delivery platform.
Internet providers. Fr-IX has a presence in Paris (six sites),
Currently in testing phase, INEX is hosting a trial VoIP
Rennes, Le Mans, and Marseille. Fr-IX provides route-server
exchange-LAN to enable VoIP operators to exchange IP traffic
access but does not offer private peering or VLAN services.
over a network protected from the rest of the Internet.
https://www.sfinx.fr
INEX has also developed an IXP management software suite
https://www.franceix.net
called IXP Manager; it is a web application with associated
http://www.rezopole.net
scripts and utilities that allow IXPs to manage customers,
http://www.lyonix.net
http://www.grenoblix.net provision new connections and services, and monitor
http://www.saintetix.net traffic usage. It also has a customer portal that allows IXP
http://www.eurogix.eu members to view their IXP traffic statistics, and peer-to-peer
http://www.fr-ix.fr traffic. The portal also contains many other tools such as My
Peering Manager and the Route Server Prefix Analysis Tool.
Auto-provisioning features include configurations for route
Ireland
collectors, route servers, AS112 services, and reverse DNS.
Dublin’s IXP is called the
INEX is keen to encourage other IXPs to use its open-source
Internet Neutral Exchange
software and is willing to assist with installations in order to
(INEX). A similar IXP operates
build better documentation.
as the Cork Neutral Internet
eXchange (CNIX) in the city of INEX’s routing policy includes provisions that require each
Cork. Both are industry-owned member to register in advance in the RIPE routing registry or
associations. another public routing registry with all routes to be announced
through any peerings at INEX. In addition, if a member
INEX currently has 77
advertises any routes to another member, it must also
members with 53Gbps of peak traffic spread across three
advertise these routes to the INEX route collector and each
POPs. Its members use a variety of different equipment
member must maintain a peering relationship with at least
vendors, including Cisco, Brocade, and FastIron. There is a
four other members or 10% of other members, depending on
notable, and possibly unique, peering matrix published on
which is the greater number.
66 www.internetsociety.org

CASE STUDIES
6.7. MIDDLE EAST
United Arab Emirates considered an “off-shore” location where customers can land
A joint project between the their own international capacity via one of the local operators.
UAE’s Telecommunication Customers can set up interconnection and peering activities
Regulatory Authority (TRA) and within the Transit Zone to non-UAE based entities without
the Frankfurt IXP, DE-CIX has the need for a UAE Telecom Licence. Content hosted in or
resulted in the establishment passing through the Transit Zone is not subject to any content
of the country’s first neutral filtering requirements.
exchange, UAE-IX, in Dubai in October 2012. A year later,
The exchange is run as an independent company that is
UEA-IX had gained 20 participating members that collectively
wholly owned by DE-CIX, one of the largest exchanges
service about 55% of the users in the Middle East.
in the world. UAE-IX operates on a redundant switching
One reason for this growth is the so-called UAE-IX Transit platform located in two data centres in the International Media
Zone, created with the support of the TRA. The Transit Zone is Production Zone (IMPZ) in Dubai: Datamena and Equinix.
6.8. EASTERN EUROPE
Albania BG) was only established in mid-2009. It now has eight sites
and 56 members exchanging 97Gbps of peak traffic, using
The Balkans Internet eXchange
Juniper and Cisco equipment. BIX.BG is notable for its simple
(BIX) in Tirana is being develop-
service-pricing model: no nonrecurring costs or setup costs,
ed by US-based UNIFI to serve
only monthly port costs for 1G and 10G ports and discounted
as Albania’s first fibre-connected
prices for additional ports.
data centre. UNIFI is implement-
ing a regional fibre network, for
http://www.bix.bg
now from Tirana to Bari in Italy,
to provide connectivity from
Czech Republic
Albania to the major telecoms hubs in Western Europe.
Prague’s NIX.CZ was amongst
Subsequent phases will connect to Greece, Kosovo,
the first neutral exchanges
Macedonia, and Montenegro.
in the world. Established in
1996 and initially operated by
Bulgaria
volunteers, it now has eight
Bulgaria has one of the staff, 111 users and 260Gbps
highest levels of broad- of peak traffic. A membership
band connectivity in association, NIX.CZ operates five PoPs across Prague and
the world. Surprisingly, hosts regular social and technical events for members.
the Bulgarian IX (BIX.
http://nix.cz
www.internetsociety.org 67

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Hungary of communication on the Internet, keeping the local traffic
‘local’ within national borders, without leaving the national
Like NIX.CZ the Budapest
boundaries as it has previously been prior to the function
Internet Exchange (BIX) was
of KOSIX. This reduces the risk component when sending
also founded in 1996 by 12
sensitive data across national borders and through many
domestic ISPs, including the
exchange points.”
largest Hungarian telecom
operators. Managed by the the
http://www.kosix.net
Council of Hungarian Internet
Providers (IsZT), BIX now has
Serbia
51 members and 172Gbps of peak traffic with five PoPs in
The Serbian Open Exchange
the city. At the main PoP, Force10 Terascale E1200i switches
(SOX) was established in 2010
are used with capacity between sites managed by CWDM
with four networks. It now has
multiplexers (80Gbps LAGs).
23 members from Serbia and
five other countries of the SEE
BIX’S GOVERNING CHARTER ONLY ALLOWS region, and can access the
six POPs in the capital city of
LICENSED INTERNET ACCESS PROVIDERS
Belgrade. SOX was provided
TO CONNECT TO BIX. OF PARTICULAR NOTE
with the necessary communications facilities authorisation by
IS THAT FREE PEERING WITH ALL OTHER
the national regulator.
MEMBERS IS ENCOURAGED WITH A 50%
Other features of SOX include:
REDUCED MONTHLY FEE.
• Recent introduction of SDH DXC equipment that
provides SDH cross-connect services for telephone
BIX’s governing charter only allows licensed Internet access company (“telco”) operators.
providers to connect to BIX. Of particular note is that free
• Fully automated performance monitoring system.
peering with all other members is encouraged with a 50%
reduced monthly fee. If a BIX member is invited by another • An Anycast copy of the L-Root server.
BIX member to exchange domestic bilateral traffic mutually
http://sox.rs
free of charge, then the invited BIX member must accept this
invitation and is only required to pay the 50% discounted fee.
Ukraine
http://bix.hu DTEL-IX in Kiev was founded
in 2009 as an independent
Kosovo commercial IXP and is located
KOSIX started at Data Center with POPs in
operating in mid- two other locations. Starting
2011 as a functional with a few local connections,
unit within the it now connects more than 70
Telecommunications networks, not only from Ukraine
Regulatory Authority but also from Russia and Europe, which exchange about
(TRA) and is housed 275Gbps of traffic at peak times.
at the University of Pristina’s Electrical and Computer
In common with most other IXPs, DTEL-IX offers both public
Engineering Faculty. The project to develop the exchange
peering with route-server and private peering between
was supported by the United States Agency for International
members in a public VLAN. Private peering between members
Development (USAID), the Norwegian Government’s Ministry
on an isolated VLAN and colocation services are also
of Foreign Affairs and Norwegian embassy, and Cisco
available. So far only 1Gpbs and 10Gpbs ports are available,
Systems.
but 100Gpbs ports are expected to become available soon.
KOSIX currently has four members exchanging about 60Mbps
http://dtel-ix.net
of peak traffic. Of note is that the KOSIX website is keen to
promote the data sovereignty benefits of the exchange: “[T]
he advantages offered by KOSIX are many, one of the most
important being the advancement of security and privacy
68 www.internetsociety.org

CASE STUDIES
6.9. NORTH AMERICA
Canada
Surprisingly for such
a large and industrially THE RECENT ATTENTION BEING PAID TO
advanced economy,
FOREIGN SURVEILLANCE HAS ENCOURAGED,
Canada only had two
IN SOME WAYS, THE EFFORTS OF ISPS TO
IXPs as of 2012, a large
KEEP CANADIAN TRAFFIC LOCAL.
one in Toronto (TorIX),
and a smaller one in
Ottawa. This situation is
Internet Registration Authority (CIRA) has also been helping
attributed to the restrictive telecom and ISP market in Canada
these new Canadian IXPs emerge. However, CIRA does not
that is dominated by three large companies and to the long
manage them, but primarily provides non-material support to
border with the US which has a more competitive market. As
help local ISPs begin planning to set up IXPs in their cities.
a result, most traffic between Canadian cities transits through
the US. The recent attention being paid to foreign surveillance has
encouraged, in some ways, the efforts of ISPs to keep
During 2013, however, the major cities in the states of Alberta,
Quebec, Saskatchewan, and British Columbia either had IXPs Canadian traffic local. Currently, up to 40% of the country’s
operational or in planning. In a manner similar to the model of domestic Internet traffic travels via the US. On the other hand,
Brazil, where the ccTLD registry is able to use its considerable suspicions have been voiced over the potential to abuse IXPs
financial base to provide support for IXPs, the Canadian as handy one-stop-shops for surveillance.
www.internetsociety.org 69

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Annex 1. Amsterdam Internet Exchange (AMS-IX), Annual Report 2012,
2013.
References
Chatzis, Nikolaos, Georgios Smaragdakis, and Anja
and Resources
Feldmann. “On the importance of Internet eXchange Points
for today’s Internet ecosystem.” arXiv:1307.5264 [cs]
(July 19, 2013). http://arxiv.org/abs/1307.5264.
Galperin, Hernán. Connectivity in Latin America and the
Caribbean: The Role of Internet Exchange Points, 2013.
http://www.internetsociety.org/doc/connectivity-latin-america-
and-caribbean-role-internet-exchange-points
Higginbotham, Stacey. “With help from Netflix, an Internet
exchange that can change the American bandwidth
landscape.” Gigaom, December 3, 2013.
http://gigaom.com/2013/12/03/with-help-from-netflix-a-
internet-exchange-that-can-change-the-american-bandwidth-
landscape/.
Jensen, Mike. Promoting the Use of Internet Exchange
Points: A Guide to Policy, Management, and Technical Issues.
Internet Society, May 2009.
http://www.internetsociety.org/promoting-use-internet-
exchange-points-guide-policy-management-and-technical-
issues.
Kende, Michael, and Charles Hurpy. Assessment of the
Impact of Internet Exchange Points (IXPs) – empirical study
of Kenya and Nigeria. Internet Society, 2012.
http://www.internetsociety.org/ixpimpact.
Mejia, Fabian. NAP.EC e IPv6, June 6, 2012.
Mwangi, Michuki. “The African Peering & Interconnection
Scene: Developing the Critical Mass.” presented at the
European Peering Forum (EPF) 7, Malta, September 17,
2012. http://www.netnod.se/sites/default/files/Netnod-The-
African-Peering-Scene-2012.pdf.
70 www.internetsociety.org

REFERENCES AND ADDITIONAL RESOURCES
National Internet Exchange of India (NIXI). 7th Annual Report IXP Directory Providers
2009-2010, 2010.
Packet Clearing House IXP Directory. Lists 614 IXPs,
Nokia Siemens Networks (NSN). Latency: The impact of with 405 active.
latency on application performance. White Paper, 2009. https://prefix.pch.net/applications/ixpdir
Telecom Advisory Services, LLC. 2013. Building a Regional Euro-IX IXP: Lists 331 known IXPs
Infrastructure for the Future of Internet in Latin America. https://www.euro-ix.net/resources-list-of-ixps
“The Business Case for Peering.” DrPeering International. BGP4.AS Lists 169 Global Internet Exchange Points
Accessed November 26, 2013. and BGP Peering Points
http://drpeering.net/core/ch5-Business-Case-for-Peering.html. http://www.bgp4.as/internet-exchanges
Weller, D., and B. Woodcock. Internet Traffic Exchange: Wikipedia List of Internet exchange points: Lists 300+
Market Developments and Policy Challenges. OECD Digital http://en.wikipedia.org/wiki/List_of_Internet_exchange_points
Economy Papers. OECD, 2013.
List of Latin American IXPs
Weller, Dennis. “Blurring Boundaries: Global and Regional http://www.lacnic.net/en/web/lacnic/ixps
IP Interconnection.” GSR 2012 Discussion Paper, 2012.
OAfrica: African IXPs
http://www.itu.int/ITU-D/treg/Events/Seminars/GSR/GSR12/
http://www.oafrica.com/business/updated-list-of-african-ixps/
documents/GSR12_Weller_IPinterconnection_4.pdf.
Online Resources, Network Operator and
Woodcock, Bill, and Benjamin Edelman. Toward Efficiencies
Organisations Supporting IXPs
in Canadian Internet Traffic Exchange, September 12, 2012.
http://www.cira.ca/assets/Uploads/Toward-Efficiencies-in- The Asia Pacific Operators Forum (APOPS)
Canadian-Internet-Traffic-Exchange2.pdf. http://www.apops.net
APRICOT (Asia Pacific Regional Internet Conference
Additional Resources
on Operational Technology)
ISOC IXP Information Page with resources in English,
http://www.apricot.net
French, and Spanish
The European Internet Services Providers Association
http://www.isoc.org/educpillar/resources/ixp.shtml
(EuroISPA)
Software http://www.euroispa.org
IXP Manager: https://www.inex.ie/ixp/index/about ‎ The Latin American and Caribbean Region Network Operators
Group (LACNOG) mailing list
UnganaIxbase: http://ungana.sourceforge.net/
https://mail.lacnic.net/mailman/listinfo/lacnog
Regional IXP Associations
The Middle East Network Operators Group (MENOG)
Regional associations of IXPs have now been established http://www.menog.net
in all the major regions except North America. These
The Network Startup Resource Centre (NSRC)
associations generally aim to share information about
http://www.nsrc.org
technical, operational, and business issues and to promote
peering. Euro-IX is the most robust association and it The North American Network Operators’ Group (NANOG)
welcomes members from other regions. Euro-IX is also http://www.nanog.net/
supporting the formation of a global federation of IXPs.
The South Asian Network Operators Group (SANOG)
Asia-Pacific Internet Exchange (APIX) http://www.sanog.org/
http://apix.asia
PeeringDB: A database established by the peering community
The African Internet Exchange Point Association (AF-IX) for networks to provide peering-related data: peering policies,
http://www.af-ix.net traffic levels, contact information, etc.
https://www.peeringdb.com
European Internet Exchange Association (Euro-IX)
https://www.euro-ix.net
Latin American IXP Association (LAC-IX)
http://lac-ix.org
www.internetsociety.org 71

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Key Research Papers
Anatomy of a large European IXP (ACM 2012):
http://www.eecs.qmul.ac.uk/~steve/papers/ixp-sgcm.pdf
Internet Traffic Exchange: Market Developments and Policy
Challenges (OECD 2012) http://www.oecd-ilibrary.org/science-
and-technology/internet-traffic-exchange_5k918gpt130q-en
The relationship between local content, Internet development,
and access prices. (ISOC/OECD/UNESCO 2012) http://www.
internetsociety.org/localcontent
Huston, G, Interconnection, Peering and Settlements, Internet
Society, http://www.isoc.org/inet99/proceedings/1e/1e_1.htm
Internet Traffic Exchange in Less Developed Internet Markets
and the Role of Internet Exchange Points (IXPs), 2008, report
from the IGF Rio - Best Practices Session, The Internet
Society, http://www.isoc.org/educpillar/resources/igf-ixp-
report-2007.shtml
McLaughlin, A, May 2004, Internet Exchange Points: Their
Importance to Development of the Internet and Strategies
for their Deployment – The African Example, Global Internet
Policy Initiative, http://www.gigiproject.org/practices/ixp.pdf
McLaughlin, A & Zuckerman, E, Introduction to Internet
Architecture and Institutions,
Berkman Center for Internet and Society, http://cyber.law.
harvard.edu/digitaldemocracy/internetarchitecture.html#Notes
Walubengo, J, Msiska, K, & Kasonde Kasolo, T, Internet
eXchange Points (IXPs) and Continental Backbone for Africa:
Means to an End?
Internet Governance Research Project, Diplo Foundation,
http://www.diplomacy.edu/
72 www.internetsociety.org

SAMPLE IXP POLICY DOCUMENT
Annex 2. Operations
1. Board members shall attempt to govern the IX in
Sample IXP Policy
accordance with technical and policy best practices
Document: Kenya generally accepted within the global community of IX
operators as represented by AfIX-TF, APOPS, Euro-IX,
and similar associations.
2. From time to time, the Management of KIXP may
recommend certain charges to the Technical and
Operational policies of the IX to the Members. Such
recommendations may only be implemented with the
approval of a majority vote by the Members.
3. General KIXP technical and operational policies shall be
made publicly available on the KIXP website. (MOU)
4. The KIXP shall impose no restriction upon the types of
organization or individual who may become members and
connect to the exchange.
5. The KIXP shall impose no restrictions upon the internal
technical, business, or operational policies of its
members.
6. The KIXP shall make no policy and establish no
restrictions upon the bilateral or multilateral relationships
or transactions that the members may form between each
other, so long as the KIXP cooperation is not involved.
7. Members must provide 24x7 operational contact details
for the use of KIXP staff and other Members. The
personnel available by this means must understand the
requirements of this Memorandum of Understanding.
8. Members shall be required to sign a copy of the KIXP
policies document, indicating that they understand and
agree to abide by its policies, before any resources shall
be allocated to them.
www.internetsociety.org 73

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
9. The primary means of communication with other 23. Members may not advertise routes with a next-hop other
Members will be via email. than that of their own routers without the prior written
permission of the advertised party, the advertise.
10. Members shall subscribe to a KIXP email list, operated by
the KIXP board. 24. Members may not forward traffic across KIXP unless
either the traffic follows a route advertised in a peering
11. Members must provide an email address in which
session at KIXP or where prior written permission of the
requests for peering should be sent.
Member to whom the traffic is forwarded has been given.
12. Members have a duty of confidentiality to the other KIXP
25. Members must, on all interfaces connected to the KIXP,
Members in KIXP affairs.
disable; Proxy ARP, ICMP redirects, CDP, IRDP, Directed
13. Members must not refer their customers, or any agent of broadcasts, IEEE802 Spanning Tree, Interior routing
their customers, directly to KIXP members’ support staff. protocol broadcasts, and all other MAC Layer broadcasts
All queries must be directed through the KIXP technical except ARP.
staff.
26. Members must, on all interfaces connected to KIXP,
14. Members must ensure that all contact information held by disable any duplex, speed, or other link parameter auto-
KIXP in connection with their membership is correct and sensing. Full Duplex or Half Duplex Only Fixed.
up to date.
27. Members shall not announce (“leak”) prefixes including
15. Members shall be required to provide and maintain some or all of the KIXP peering LAN to other networks
current technical contact information, which shall be without explicit permission of KIXP.
publicly posted on the KIXP website. This information
28. Members must set net masks on all interfaces connected
shall include at a minimum an internationally dialable
to KIXP to include the entire KIXP peering LAN.
voice phone number, a NOC email role account, the
IP address assigned to the member at the exchange, 29. Any equipment and/or cabling installed by a Member
and the member’s Autonomous System Number if they at KIXP must be clearly labelled as belonging to the
have one. Member.
16. Members may only connect equipment that is owned 30. Members will not touch equipment and/or cabling owned
and operated by that Member to KIXP. Members may not by other Members and installed at KIXP or in the room
connect equipment to KIXP on behalf of third parties. containing the KIXP without the explicit permission of the
Member who owns the equipment.
17. Members must only use IP addresses on the interface(s)
of their router(s) connected to the KIXP allocated to them 31. Any members who for purposes of enhancing the
by the KIXP. services of the KIXP will wish to bring their equipment
into the KIXP will be required to seek permission from the
18. Members may only present a single MAC address to any
management.
individual KIXP port that is allocated to them.
32. Members who bring their equipment to the KIXP will be
19. It is preferred that each member have their own
responsible for their equipment and will be expected to
Autonomous System Number, members without which an
show proof of insurance of the equipment.
ASN allocation will be assigned from a private ASN space
by the KIXP Staff. 33. Members will not install ‘sniffers’ to monitor traffic passing
through KIXP, except through their own ports. KIXP may
20. Any member who has previously been connected to the
monitor any port but will keep any information gathered
KIXP using private ASN and then later acquires their own
confidential, except where required by law or where a
full ASN must notify the KIXP Staff as soon as possible
violation of this Memorandum of Understanding has been
in order to incorporate this development into the BGP
determined by the KIXP Management.
peering at KIXP.
34. Members will not circulate correspondence on confidential
21. Peering between Members’ routers across KIXP will be
KIXP mailing lists to non-members.
via BGP.
35. Members must ensure that their usage of KIXP is not
22. Members shall not generate unnecessary route flap,
detrimental to the usage of the KIXP by other Members.
or advertise unnecessarily specific routes in peering
sessions with other Members across KIXP. 36. Members may not directly connect customers who are not
KIXP members via circuits to their router housed in any
KIXP rack.
74 www.internetsociety.org

SAMPLE IXP POLICY DOCUMENT
37. Members should not routinely use the KIXP for carrying
traffic between their own routers.
38. Members will be required to install routers that support
the full BGP-4 standard.
39. The technical committee will set up certain monitoring
features on the server at the KIXP.
40. Members must not carry out any illegal activities through
KIXP.
41. Members connecting to the KIXP will be registered as
TESPOK members of a special category with a joining fee
of Ksh 30,000/- and monthly subscription as per level of
traffic as agreed upon by members.
Disconnection and Reconnection
1. Members who fail to abide by the terms of the KIXP policy
will be brought before the technical committee who will
effect the disconnected following review of their actions.
2. Members who fail to pay up their monthly subscription for
a period of 3 months or more will be given a fifteen day
notice within which they clear any outstanding dues, after
which they will be disconnected immediately without any
further notice.
3. Any notice on disconnection with regard to outstanding
monthly subscription will be communicated by the
Administrator and copied to the Management.
4. Members who will have been disconnected will be locked
out of peering for a period not exceeding 1 month and will
be require to get approval from the management before
they can re-connect to the KIXP.
www.internetsociety.org 75

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Annex 3. Rack Space
We recommend at least four 42U cabinet racks fitted with
Technical and
trays, door locks, and mesh doors for cooling, and measuring
Equipment 800 x 900. Recommended rack allocations are as follows:
Recommendations • One 42U for carrier(s) transmission equipment
• One 42U for the peering fabric switch and servers
• One 42U for value-added services
• One 42U for Peering member routers
Structured Cabling
The structured cabling is necessary to ensure quality of
service and presentation of the facility.
Power Backup and Distribution
We recommend the supply and installation of a three phase
inline 10KVA UPS with extended battery pack. A 10KVA power
inverter with batteries to last at least 12–24 hours would
be needed in location with prolonged power problems and
without a generator. In addition a power distribution board
installed for the facility and rack distribution units installed for
each rack for proper power management.
Server Room Cooling
The formula for calculating cooling is: Total Heat Load = Room
Area BTU + Windows BTU + Equipment BTU + Lighting BTU
Room Area BTU = length (m) x width (m) x 337 = 15m2 x 337
= 5,055BTU
Windows BTU = length (m) x width (m) x 870 = 9m2 x 870 =
7,830 BTU
Equipment BTU = total wattage x 3.5 = 10,000w x 3.5 =
35,000 BTU
76 www.internetsociety.org

TECHNICAL AND EQUIPMENT RECOMMENDATIONS
Lighting BTU = total wattage x 4.25 = 100w x 4.25 = 425 BTU Security and Access Control
Based on the above formulae, the estimated total heat load The security and access control is important in order to
for the room operating at full capacity is: 5055 + 7830 + 35000 safeguard the equipment hosted at the facility.
+ 425 = 48,310 BTU.
Network Monitoring
We therefore recommend at least two 36,000 BTU split
To enhance service delivery there will be a need for
system air conditioning units for the MOZIX. During the initial
monitoring of the network devices. In addition to the
period one air conditioning unit will support the facility and one
computing resources, it’s also necessary to acquire a SMS
will serve as backup.
notification unit that can alert technical staff of outages via
SMS messages.
Switch and Route Server
We recommend the acquisition of 2 x 48 10/100/1000Gbps
with at least 2– 4 Gigabit (SFP) interfaces to cater for current
requirements, future growth and redundancy. The switch
THE IXP BEST PRACTICES REQUIRE THAT
should support Sflow features.
AN IXP OPERATOR PROVIDE ADDITIONAL
A server-based route-server that supports BGP with IPv4 and
INFORMATION SUCH AS A MEMBER’S MAILING
IPV6 is recommended. Therefore two servers for the route-
servers as per the server specifications below will be useful LIST, A WEBSITE WITH CONTACT INFORMATION
for the lab. FOR THE IXP AND THE MEMBERS AVAILABLE,
AN EMAIL ADDRESS, AND AT LEAST SOME
Server Hardware Recommendations
STATISTICAL INFORMATION ON THE TRAFFIC
The IXP best practices require that an IXP operator provide
EXCHANGED AT THE IXP. SOME IXPS ALSO
additional information such as a member’s mailing list, a
website with contact information for the IXP and the members KEEP AN ARCHIVE OF THEIR HISTORICAL
available, an email address, and at least some statistical TRAFFIC GROWTH TO TRACK GROWTH.
information on the traffic exchanged at the IXP. Some IXPs
OTHERS PROVIDE A TICKETING SYSTEM FOR
also keep an archive of their historical traffic growth to track
LODGING QUERIES AND HAVE GONE FURTHER
growth. Others provide a ticketing system for lodging queries
and have gone further with advanced network monitoring WITH ADVANCED NETWORK MONITORING
tools. All the efforts are aimed at ensuring that an IXP is able TOOLS.
to provide efficient and reliable services for their members.
Computing resources are required in order to host and offer
these additional services. Therefore at least five 2U rack
mount servers with the following specifications;
• Intel Quad Core Processor
• At least 8GB of RAM
• At least 4 x 450GB 3.5 SAS with 10,000 rpm Hard Disk
• Built-in Raid controller (minimum Raid 1)
• DVD ROM/Writer
• Dual (2) 1Gb Ethernet controllers
• Redundant power supply
• Rack mount kit
The usage is as follows:
• Two servers for route-servers (redundancy)
• One server for IXP email, helpdesk and website
• One server for network monitoring services
• One server for backup, flow analysis, R&D, etc
www.internetsociety.org 77

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Annex 4. Glossary T HIS SECTION PROVIDES DETAILS ON THE MAIN
terms and concepts that relate to the deployment
of IXPs.
24x7
A service that has permanent availability – ‘always on’
(i.e., 24 hours a day, every day of the week); such as for a
technical support service at an IXP or network operator.
Acceptable Use Policy (AUP)
A policy adopted up by a network operator describing the rules
for using the service – most often limiting the volume of data
that may be transferred over certain time period or defining
types of network abuse, such as accessing undesirable
types of websites, downloading pirated media, or using the
network for sending unsolicited bulk email (spam). Some IXPs
provide services, such as anti-spam measures, to support the
enforcement of their member’s AUPs.
African Internet Exchange Point Operators’ Association
(AF-IX)
A community of practice set up in 2013 to “provide a
collaborative environment for Internet Exchange Point
Operators in the African region to be able to share knowledge,
experiences, and to provide support for each other.”
http://af-ix.net
Africa Network Information Centre (AFRINIC)
One of the five regional Internet registries (RIRs) that provides
IPv4 and IPv6 address allocation services for the African.
AFRINIC, like most of the other RIRs, it has an active IXP
support programme.
American Registry for Internet Numbers (ARIN)
One of the five regional Internet registries (RIRs) that provides
IPv4 and IPv6 address allocation services. The ARIN service
region includes Canada, many Caribbean and North Atlantic
islands, and the United States.
78 www.internetsociety.org

GLOSSARY
Anycast Border Gateway Protocol (BGP)
Anycast is a networking strategy where the same IP address An IETF routing protocol defining the way in which
prefix is advertised from multiple locations. Users of an Autonomous Systems exchange information to determine
anycast service (such as DNS) will always connect to the the path to use in order to send data. Participants at an IXP
closest server available. normally must be able to configure and maintain routers that
run BGP. See IETF.
Asia-Pacific Internet Exchange Point Association (AP-IX)
Serves as a forum for Internet Exchange Points to exchange Broadband
experiences. APIX members meet twice a year at the APNIC A high-speed (multimegabit) data connection, normally
Conference and Members meeting. http://apix.asia provided to the end-user. The International Telecommunication
Union (ITU) currently defines broadband as greater than
Asia Pacific Network Information Centre (APNIC)
256Kbps. In practice, however, a broadband connection is
One of the five regional Internet registries (RIRs) that provides
usually expected to be at least 1Mbps. In many countries,
IPv4 and IPv6 address allocation services; APNIC serves the
10Mbps is now a commonly seen domestic broadband
Asia-Pacific region except for China, India, Japan, Korea, and
connection (on the download link), 50+Mbps is also becoming
Taiwan, Vietnam, which each have their own National Internet
increasingly available, and some residential service providers
Registry (NIR) to handle address allocation and assignment.
are even providing 1Gbps broadband connections, where
Autonomous System Number (ASN) fibre to the premises is available.
An identifying number allocated to an Autonomous System on
Byte
the Internet. ASNs are a basic requirement to run a network
Eight bits of data, sometimes called a “word” or an “octet.”
with more than one link to the Internet and are almost always
While data streams are usually measured in bits, file sizes
required when joining an IXP. ASNs are used in conjunction
and units of data storage are normally measured in Bytes;
with the Border Gateway Protocol (BGP) to determine the
e.g., a one terabyte hard drive.
path along which to route traffic. RIRs assign ASNs.
Cache
Backbone
A copy of a set of data that is stored closer to the end user
The main route of a network used as the path for transporting
than the original source of the data in order to improve
traffic. Also used to refer to long-distance fibre optic links,
performance, reduce bandwidth requirements, or limit real-
such as in ‘national backbone.’
time access to the original content. Caches are filled when
Bandwidth a piece of content is downloaded the first time, and usually
A measure of the capacity of a communications channel to refreshed at regular intervals or when a later version of the
transfer a certain amount of data in a specific time, usually content becomes available. Web browsers often include a
defined in bits per second (bps), as in Kbps, Mbps, Gbps. cache and so do IXPs. See Content Distribution Networks.
Bilateral Peering Category 5 Cable (Cat5)
This is peering negotiated between any two providers, through A specification of twisted-pair copper cable able to provide
an IXP switch or privately. See Peer/peering. a performance of up to 100Mhz that is suitable for up to
1000Mbps (1Gbps). It has been superseded by the CAT5e
Bit
(enhanced) specification.
Binary digit, i.e., 0 or 1; it is the basic unit used in computing
and data transmission. Eight bits usually define a single Cloud Service
character that is called a Byte. See Byte. A service provided via the Internet that gives its users access
to applications and data-storage facilities that are hosted
Bits per Second (Bps)
remotely on a ‘cloud’ service provider’s network consisting
The number of bits passing a given point every second. This
of distributed storage and application servers, which may be
is the transmission rate for digital information, i.e., a measure
spread around the world. Cloud services provide a business
of how fast data can be sent or received. Often expressed
model that allows entrepreneurs the ability to more easily
as Mbps, for Megabits per second for broadband links. See
scale up and offer service(s) without provisioning their own
Bandwidth.
infrastructure. Typical examples of cloud-based applications
Blackholing
are DropBox, Gmail, and Hotmail. Increasing use of cloud
A configuration technique used to deal with DDoS attacks
services means end-users are ever more dependent on fast
or routing configuration errors on other networks in which
and reliable Internet connectivity, adding to the incentive for
packets to or from selected destinations are ‘blackholed’ or
networks to peer at an IXP.
dropped.
www.internetsociety.org 79

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Co-location (colo) those built by a specific telecom operator, but those that have
The renting of space for housing computer equipment, usually multiple carriers terminating links into the data centre). Some
in buildings specially designed to support a high density of commercial data centres operate as IXPs and may provide
computers and network connections, often called data centres good value for purchasing transit capacity, but are often less
but also called telehouses or carrier hotels. Co-location is not cost-effective for peering. See Co-location.
normally an IXP service as it usually competes with exchange
Dense Wave Division Multiplexing (DWDM)
participants, however many IXPs are hosted at colo/data
A technology that enables multiple data streams to be
centres.
transmitted simultaneously on a single optical fibre by using
Connection Redundancy different optical wavelengths (colour) for each data stream.
Two or more connections, ideally via physically different paths Up to 160 (and theoretically more) wavelengths can now be
to different networks, linked to the Internet. Redundancy transmitted on a single optical fibre. Availability of DWDM fibre
ensures continued availability of the Internet in the event of a is helping to meet exploding bandwidth requirements.
service interruption on one of the connections. IXPs can help
Domain Name
to improve a network’s reliability by making it easy to access
A sequence of characters (a name) for use by Internet
more than one connection to the rest of the Internet. This may
applications; e.g., someone wishing to access Le Monde
also require two physically independent connections to the
newspaper via a web browser would type www.lemonde.fr.
IXP unless the network is also using a direct connection to a
The registered domain name is lemonde.fr.
peer or transit provider.
Domain Name System (DNS)
Content
A distributed database that allows names to be associated
The data that travels over a network, which can also be
with IP addresses. A query of a DNS server will match a
termed “traffic,” but from the user’s perspective, it is the
domain name to the IP address required by the computer in
material that the user is accessing and interacting with over
order to route the traffic to its destination; e.g.,www.lemonde.
the network. Because IXPs help to reduce local bandwidth
fr will match to the IP number 62.116.143.15 — the IP address
costs and improve network performance, they help to
of the web server hosting Le Monde’s online service.
encourage hosting of content, including local content. See
Content Distribution Network. Downstream
A network’s paid traffic, in contrast to upstream traffic for
Content Distribution Network (CDN)
which a network must usually pay transit fees, and peered
A network whose primary aim is to deliver content to
traffic which is usually settlement free. See Peers/Peering.
end users and that is often hosted at an IXP to improve
performance by bringing the content closer to the end user.
Ethernet
These can be content redistribution networks that act as The communications protocol used within a switch to route
intermediaries, such as Akamai, or content generators data packets inside the local network. It is normally only used
themselves, such as Google and Netflix.
within a local network because the packets are broadcast to
every device attached to the switch. This is computationally
Country Code (cc)
A two-letter code uniquely identifying a country; used in top- inexpensive, but makes this protocol less suitable for long-
level national domains, such as .ca (Canada) and .fr (France). distance, usually more expensive, lower-capacity links.
Standardised by ISO3166-1. See ccTLD. Ethernet switches are normally used to interconnect the
routers of participants at an IXP. Maximum Ethernet speeds
Country code Top Level Domain (ccTLD)
have steadily increased and some IXPs are now able to
The last part of a domain name using a country code allocated
support 100Gbps Ethernet connections. GE is a common
to a specific nation. This normally signifies the country in
notation for one-gigabit Ethernet links, 10GE for 10Gbps links.
which the domain is registered and usually, but not always,
indicates where the holder of the domain name is based. Eyeball Networks
Some ccTLDs have also been used for denoting certain types Networks that focus on provision of Internet access to the
of content services or websites, such as .tv (Tuvalu). The end user. These networks provide the demand for content
database of sub-domains registered under a specific ccTLD networks that operate applications or services desired by
are termed name servers and are often hosted at IXPs to end users.
improve performance and reliability for end users.
European Internet Exchange Association (Euro-IX)
Data Centre An Association of European exchange points and other
Data centres primarily focus on hosting content although members formed to exchange ideas and information on IXP
they often host IXPs, especially carrier-neutral ones (i.e., not and related issues. Most IXPs in Europe have joined Euro-IX
80 www.internetsociety.org

GLOSSARY
to share information about best practices. The association is Interface
not restricted to European members and welcomes members The hardware and software that connects a computer or
from other regions. It is also assisting the formation of a global communications devices to each other or to the end user.
federation of IXP associations.
International Gateway
Fibre Optic Cable; also Optical Fibre Cable A telecommunications link that crosses a national bounder. It
The use of specially manufactured glass fibre for the trans- is usually a service that aggregates international traffic from
mission of data. The signal is transmitted along the fibre using many networks and end users. It is also a construct used by
pulses of light from a laser or a light-emitting diode (LED). some developing country governments to restrict access to
Current modulation technology allows fibre cables thousands international capacity to particular license holders, often the
of kilometres long to carry many terabits of data per second incumbent state operator, and to mobile network operators.
(see DWDM above). Optical fibre patch cables are used in In some cases this is a single entry point through which
IXPs to connect with high speed ports, such as 10 or 100Gbps. Internet traffic must pass, creating a de facto IXP, but without
the benefits of building a community. This arrangement often
Gbps
constrains local growth of the Internet through inefficient
Gigabits per second.
routing or by imposing non-cost-based pricing for local
generic Top Level Domain (gTLD) traffic exchange. The resulting construct can also often be a
A top-level domain of the Internet that does not carry a significant barrier to creating an IXP for the other ISPs in the
ccTLD identifier. In contrast to ccTLDs (see above), gTLDs country.
are normally used to register names that are not associated
International Telecommunication Union (ITU)
with a particular country. However, due to the history of the
The UN agency responsible for the development of
emergence of the Internet, most US-based organisations
infrastructure, orbital slot and coordinated spectrum
have, in practice, also used gTLDs in place of the .us ccTLD.
allocation, and development of technical standards used in
Currently, seven gTLDs are commonly used: .com, .org, .net,
telecommunication networks, particularly traditional voice
.edu, .gov, .mil, .int. Another six have more recently come
networks. The ITU has also recently become more involved
into use: .aero, .biz, .coop, .info, .museum, and .name. The
in Internet public policy and other related matters.
management of TLDs is the responsibility of ICANN. ICANN is
now in the process of greatly expanding the number of gTLDs Internet
in use. IXPs often host copies of gTLD and ccTLD databases Interconnected networks that use the TCP/IP protocol (see
to improve local performance in name lookups. TCP/IP) to communicate with each other. Emerging from
military and academic research in the 1960s, the Internet
Gigabit (Gb)
is continuing to double in size every year. Currently, the
One billion bits.
Internet is made up of about 44,000 independent networks
Gigabit Ethernet (GE) that connect about 2.5bn end-users to each other and to
Ethernet that supports data transfer rates of 1 Gbps. See millions of content and application providers. The Internet is
Ethernet. Most IXPs now support 1Gbps and 10Gbps ports. also now emerging as the platform for machine-to-machine
communications, known as the ‘Internet of things,’ which
Global Routing Table; also Global BGP Table
will result in the Internet growing even faster and becoming
A database of the different paths in the public Internet over
even larger.
which traffic can be routed. In mid-2013, there were about
480,000 IPv4 and 14,000 IPv6 routes visible on the Internet. Internet Corporation for Assigned Names and Numbers
This information is used by routers that run the BGP protocol (ICANN)
to decide on the most efficient path over which to direct traffic. The highest level coordinating body for the technical
In practice, with the common use of route filters and rapid resources of the Internet, responsible for global policy and
changes in Internet routing, no router has the complete view management of Internet domain names and IP numbers.
of all routes available. Large IXPs, which usually have routes
Internet Engineering Task Force (IETF)
seen by multiple large networks are among the best places to
The body responsible for developing standards for the
assess global Internet routing.
technical operation of the Internet. The IETF is an open
Information and Communication Technologies (ICT) community of network designers, operators, vendors, and
The most common means of referring collectively to both researchers concerned with the technical aspects of the
computing and communications technologies, which include operation and evolution of the Internet. It is open to any
the Internet. interested individual.
www.internetsociety.org 81

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Internet Exchange Point (IXP) be connected to the Internet because it is inherently limited
A physical location that allows many Internet-based networks to 4,294,967,296 addresses. Consequently, a new, larger
to exchange traffic with each other at a common meeting standard of IP Address was developed – IPv6, which can
point, thus eliminating the need to build separate bilateral provide 3.4 X 1038 addresses in the form of eight groups of
links with each local network. Most IXPs are non-commercial four hexadecimal digits separated by colons (e.g., 2001:0cb
organisations funded by membership and other fees paid 7:64g2:0342:1000:8a2e:0370:7334). However, methods of
by the participating networks. Commercial exchanges are abbreviation of this full notation can be used. IPv6 has enough
also common, particularly in North America where IXPs are addresses to connect every device for the foreseeable future.
often called Network Access Points (NAPs). INX and IX are
IP Packet
also common abbreviations. In Latin America, additional
A discreet unit of data that contains the source and destination
abbreviations are NAP, PIC, PIT, and PTT.
of a transmission for routing purposes, along with other
Internet Protocol (IP) management information, as well as the user’s data. Because
The basic packet communications protocol used on Internet each packet contains the source and destination, each packet
networks. See IP Packet. can be treated independently by the networks it travels
through to reach its destination. Different packets may take
Internet Service Provider (ISP)
different routes before being reassembled as the data stream
A company or organisation that provides individuals,
on the recipient device.
organisations, and enterprises with access to the Internet.
Aside from connecting users, ISPs often provide other Kilobits per Second (Kbps)
services such as email and hosting of websites for their A data transfer rate of one thousand bits per second.
customers. ISPs are also known as ‘eyeball networks’ that
Latency
essentially aggregate bandwidth in bulk and resell it to
Typically measured in milliseconds (ms), latency is a measure
consumers and businesses in smaller chunks. This is in
of the delay in the round trip time (RTT) required for a packet
contrast to content networks that focus on providing content
of data to reach and return from its destination.
and applications for end-users. These two types of networks
most often meet at IXPs. Latin America and Caribbean Internet Exchange Point
Association (LAC-IX)
Internet Service Providers Association (ISPA)
The association’s objectives are to increase Internet traffic in
An association of ISPs often run on a membership basis in
the region, represent the member IXPs worldwide, support
a defined geographic region, usually in a country or a capitol
governments on policies, provide statistics and advice related
city of a country. Many IXPs are operated by national ISP
to Internet Exchange Traffic, simplify cooperation between
associations.
the IXPs, and promote and support the establishment of new
Internet Society (ISOC) IXPs. http://lac-ix.org
A cause-based organization that works with governments,
Latin America and Caribbean Network Information Centre
industries, businesses, policymakers, regulators and others
(LACNIC)
to ensure the technologies and policies that helped develop
One of the five regional Internet registries (RIRs) around the
and evolve today’s Internet will continue into the future. Its
globe that provide IPv4 and IPv6 address allocation services
programmes support and advocate for an Internet that is
(for the Latin American and Caribbean region except for
open and accessible to everyone, everywhere, and ensures
Brazil, Chile and Mexico, which each have a National Internet
that it will continue to be a tool for creativity, innovation, and
Registry (NIR) to handle address allocation). LACNIC has
economic growth. Working with its members and Chapters
recently helped to launch an association of IXPs in the region
around the world, the Internet Society enables the continued
called LAC-IX.
evolution and growth of the Internet for everyone.
http://www.internetsociety.org Leased Line
A telecommunications circuit leased between two or more
IP Address
locations from a telecom provider. Networks will normally need
A unique numeric identifier for a device connected the
to lease a line or deploy their own infrastructure to connect
Internet. Until recently, this was usually expressed as four
with the IXP.
sets of numbers in the range 0–255 separated by dots (e.g.,
196.6.208.1), which is known as an IPv4 IP address. Due to Link Aggregation Control Protocol (LACP)
the unexpected growth of the Internet from the time it was Link aggregation is used by some IXPs to provide higher-
first developed, this addressing model cannot provide enough capacity links to members.
addresses to uniquely identify every device that needs to
82 www.internetsociety.org

GLOSSARY
Local Area Network (LAN) organisation’s primary activity. Noncommercial IXPs may be
A local network of devices interconnected physically through registered as NGOs or as nonprofit companies.
one or more Ethernet switches or wireless links. An IXP is
Optical Fibre Cable (OFC)
essentially a set of participant routers connected to a LAN.
See Fibre Optic Cable.
An IXP may have additional LANs for administrative purposes
or for providing other shared services. Packet
A discreet unit of data traffic. Packet switched networks are
Looking Glass Server
the basis of Internet in contrast to the older circuit switched
A server hosted on a network or IXP that makes it easy to
networks that were developed in the previous century for
identify the routes available at that location.
voice networks.
Megabits per Second (Mbps)
Peer/Peering
A data transfer rate of Mega (million) bits per second.
Peers are networks that agree to exchange routes (and
Metropolitan Area Network (MAN) therefore traffic) with each other, normally on a settlement
A network spread over a metropolitan area. This may refer free basis. The distinction between settlement-free peering
to a physical fibre or microwave network, such as may be and ‘transit,’ where one network pays another to exchange
operated by a telecom provider to carry voice and data traffic traffic (usually to reach most of the other remote networks on
within a large city, or it may refer to an IP network linking the Internet), is blurred by options where some routes may be
different locations in one city, including an IXP with several settlement free while other routes carry a fee (‘paid peering’)
locations in the same city. or where there is some other form of compensation between
the two networks. In all these cases, specific business
Multihoming
arrangements between two networks are called ‘bilateral
An IP network with two or more physical links to other
peering’ or ‘private peering.’ Bilateral peering can either take
networks in order to provide resilience and/or diversity. An
place at an IXP or through direct physical interconnection
AS number and appropriate routers are required to operate
between the two networks. The latter is normally called
multihoming networks connected to the Internet. Knowledge
‘private peering.’ The other common form of peering at an IXP
of multi-homing router configuration is a basic prerequisite for
is called ‘multilateral peering.’ See Multilateral Peering.
joining an IXP.
Petabit
Multilateral Peering
One thousand Terabits.
A type of peering policy available at many IXPs where
members agree to exchange traffic with every other member Plain Old Telephone Service (POTS)
present at the exchange, usually through a route-server. This A traditional fixed-line copper cable phone service. See PSTN
contrasts with bilateral peering or ‘private peering’ where two and PTO.
networks agree to exchange traffic with each other in a private
Point of Presence (PoP)
arrangement. A choice of multilateral and bilateral peering is
A physical infrastructure location where a network or end user
usually available at most IXPs.
can access the services of a provider.
Network Access Point (NAP)
Private Peering
Another name for an IXP. NAP was the name given to the first
See Peer/Peering.
exchange points established in the United States when parts
of NSFNet, the first TCP/IP-based network, were spun off from Protocol
its academic roots into commercial operations. NAP is also At a technical level in the ICT world, a protocol is usually a
more commonly used in Latin America. set of rules that determine the way in which two networked
devices communicate with each other; e.g., routers exchange
National Regulator Authority (NRA)
routing information using the border gateway protocol (BGP)
See Regulator.
just as all devices connected to the Internet must exchange
Network traffic using the Internet Protocol (IP).
Two or more interconnected computers or data
Public Switched Telephone Network (PSTN)
communications devices. “IP network” or just “network” is now
The traditional circuit switched voice telephone system;
the commonly used term for a distinct group of interconnected
however, may also refer to mobile networks.
devices linked to the Internet and operated by a specific entity.
Nongovernmental Organisation (NGO)
A nonprofit organisation whose shareholders or other
governing body do not financially benefit from the
www.internetsociety.org 83

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Public Telecom Operator (PTO) hosted by the regulator or facilitated by regulatory proceedings
Usually the circuit switched fixed line telecom operator allowing the IXP to exist. The regulator can play an important
although technically, as communication technologies role in helping to ensure that dominant operators participate
converge toward the Internet, the distinction between fixed- fully in the IXP and in ensuring that there is a competitive
line operators, cellular operators and ISPs is becoming market for national and international Internet capacity.
increasingly blurred. PTOs usually have a different business
Remote Hands
culture to the new Internet network operators and are often
A facility provided by IXPs and data centres where participants
the dominant network operator, a status that may limit their
can make use of a local on-site engineer to perform physical
interest in peering locally as opposed to selling transit.
activity at the exchange, such as rebooting a router, installing
Public-Private Partnership (PPP) patch cables, etc.
A partnership between the private sector and government
Réseaux IP Européens Network Coordination Centre
in a common project. In some cases, IXPs are established
(RIPE NCC)
as a partnership between privately operated commercial
One of the five regional Internet registries (RIRs) around the
networks and government bodies. Not to be confused with
globe that provide IPv4 and IPv6 address allocation services
the Point-to-Point Protocol as used in computer networking or
(for Europe and the Middle East).
with Purchasing Power Parity (a mechanism to compare the
relative values of currencies). Request For Comment (RFC)
The IETF procedure used for the development of Internet
Quality of Service (QOS)
standards. For example, RFC 5963 describes how IPv6 may
A measure of the level of service provided by a network.
be deployed at IXPs.
There are many different QOS measures. Common examples
include up-time (e.g., five 9’s – operational for 99.999% of the Root Name Server
time), packet loss, round-trip time, etc. QOS may be defined Root name servers are used to determine the location of other
in a business relationship called a Service Level Agreement DNS servers. DNS servers are the authoritative source of
(SLA). QOS rules can also be applied to different types of information about top-level domains (e.g., .com, .org, .int, and,
traffic passing through a router; for example, voice traffic .arpa). There are currently 13 root servers around the world
might be given a higher priority than email. IXPs may provide with the domain names ‘a.root-servers.net,’ ‘b.root-servers.
certain QOS and SLA commitments to their members. net,’ up to ‘m.root-servers.net.’ Copies of these root server
databases are often hosted at IXPs or other well-connected
Regional Internet Registry (RIR)
locations in order to increase the resiliency of the Internet
One of the regional organisations that are allocated blocks of
locally in the event of international connectivity interruptions.
IP addresses and ASNs by ICANN/IANA for onward allocation
Copies of these root servers are often called ‘instances’ or
to individual local networks (except for 10 countries in Asia
‘mirrors.’ For a map of these entities, see http://root-servers.
and Latin America which operate their own national registries).
org/map/.
Currently, there are five RIRs – one for each major geographic
region: ARIN, APNIC, AFRINIC, LACNIC and RIPE NCC. Route
The path through one or more networks that is taken by IP
Regulator
packets. Due to the dynamic nature of routing on the Internet,
A government entity with legally mandated responsibility
packets from the same data stream may travel to their
for executing national ICT policy by establishing a set of
destination by different routes.
regulations that govern the sector. Ideally the regulator is
semiautonomous with an income derived from license fees Router
that provides substantial independence, although the state A device that receives IP packets and decides where to send
usually appoints the executive body. Ideally the regulator them based on which device is ‘closest’ or ‘least expensive’
helps ensure that there is a level playing field in telecom on the way to the packets’ final destination. Routers usually
and Internet markets. In this respect, it often has a major make these decisions based on a set of preconfigured rules
responsibility to curb the impact of market dominance of the combined with dynamic routing information exchanged with
incumbent operator, especially in developing countries. (In other routers on the Internet, usually based on the BGP
some economic regions with a high level of integration, such routing protocol. Routers with only one physical connection to
as the EU and ECOWAS (West Africa), a significant level of another network are usually configured with a ‘default route’
policy and regulatory development takes place at the regional that is the upstream connection to the rest of the Internet.
level that the member states are obliged to adopt.) Normally, a network participating in an IXP will have a router
The regulator does not normally have a direct role in IXP at the IXP premises that will be connected to the other
development although in some countries the IXP may be participants’ routers via an Ethernet switch.
84 www.internetsociety.org

GLOSSARY
Routing Policy VoIP
The routing rules that a network applies when carrying traffic Voice over Internet Protocol. There are many Internet-based
from other networks. VoIP services, such as Skype and Google Talk. Traditional
circuit switched voice networks are also increasingly migrating
Spam
to the Internet. The ‘best effort’ model of Internet service
Unsolicited email, usually used in questionable marketing
provision requires that specialised traffic management
practices. Some IXPs provide an anti-spam service.
techniques may need to be applied to deliver the same
TCP/IP level of QOS that is expected by customers of traditional
Transmission Control Protocol/Internet Protocol – the key voice networks. In addition, gateways between IP and circuit
protocols for transmitting packet-based data on which the switched voice networks may require specialised signalling
Internet is built. to support features such as caller ID. Some IXPs are now
implementing these techniques so that voice networks can
Terrabit
continue to migrate smoothly to an all-IP environment.
One thousand gigabits.
Wide Area Network (WAN)
Tiered ISP Model
A network normally spanning a larger physical area than
Internet Service Providers have traditionally been classified
a LAN, in particular denoting the use of different physical
by size into 3 tiers: Tier 1 ISPs are the largest (usually global
transmission media. The most common use of WAN
ISPs that peer directly with each other), Tier 3 ISPs are the
terminology is in the WAN port(s) on a router which collects
smallest local ISPs, and Tier 2 ISPs fall somewhere in the
traffic from the LAN and passes upstream traffic to the WAN
middle. These distinctions are blurring as the ISP sector
links, usually to the rest of the Internet, and vice versa.
evolves, but normally it is assumed that ISPs from lower tiers
usually have to purchase transit from higher tier ISPs.
Top Level Domain (TLD)
See gTLD and ccTLD. http://en.wikipedia.org/wiki/Top-level_
domain; http://archive.icann.org/en/tlds/; http://www.icann.org/
en/resources/cctlds.
Transit
The capacity or routes purchased from a larger network,
usually to reach remote networks on the Internet. See Peer/
peering.
u
A unit of measurement mainly used to describe the height of
rack-mounted computer equipment (especially servers and
routers) and the racks into which they are fitted. One “u” is
1.75 inches or 4.445 centimetres. IXPs may have policies
on the amount of rack space that can be occupied by each
participant at the exchange.
Unshielded Twisted Pair (UTP)
A type of data cable containing four pairs of conductors,
each pair being twisted together. UTP is used extensively in
connecting local Ethernet network devices together.
Upstream Traffic
Traffic that a network must usually purchase as transit in order
to make connections with other networks. This is in contrast
to downstream traffic, which is usually the revenue generator
for a commercial access provider (‘eyeball’) network, or for a
lower-level wholesale capacity provider. See Peer/Peering.
www.internetsociety.org 85

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
Notes
86 www.internetsociety.org

NOTES
www.internetsociety.org 87

THE INTERNET EXCHANGE POINT TOOLKIT & BEST PRACTICES GUIDE
88 www.internetsociety.org

Galerie Jean-Malbuisson 15 1775 Wiehle Avenue, Suite 201
CH–1204 Geneva, Switzerland Reston, Virginia 20190, U.S.A.
Tel +41 22 807 1444 • Fax +41 22 807 1445 Tel +1 703 439 2120 • Fax +1 703 326 9881
bp-internetxchngpoint-201202-en