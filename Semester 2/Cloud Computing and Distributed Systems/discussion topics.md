Here are the discussion topics from the 17 Cloud Computing and Distributed Systems lectures you provided, along with their answers in Markdown format.

---

### Cloud Computing and Distributed Systems: Discussion Topics and Answers

#### **Chapter #1: Characterization of distributed systems**

- **Discussion Topic:** How might the clocks in two computers that are linked by a local network be synchronized without reference to an external time source? What factors limit the accuracy of the procedure you have described? How could the clocks in a large number of computers connected by the Internet be synchronized? Discuss the accuracy of that procedure.
    
    - **Synchronization without external time source (Local Network):** One computer can act as a time server. Periodically, client computers send a request to the server. The server records its local time (`t_server`) and sends it back to the client. The client, upon receiving the message, records its local time (`t_client_receive`). The client can then adjust its clock based on the server's time and an estimate of the message transmission delay. A common estimation is to assume the round-trip time (`t_round_trip`) is evenly split between request and reply, so the client adjusts its clock to `t_server + (t_round_trip / 2)`.
        
    - **Factors Limiting Accuracy (Local Network):** The primary limitation is the variability of message transmission time (latency). Even on a local network, factors like network load, processing delays in the operating system, and hardware interrupts can cause jitter (variability in delivery time), making the exact `t_round_trip` and its split unpredictable. This uncertainty introduces skew in the synchronized clocks.
        
    - **Synchronization in a Large Number of Computers (Internet):** For a large number of computers connected by the Internet, the Network Time Protocol (NTP) is used. NTP synchronizes clocks to Coordinated Universal Time (UTC). It uses a hierarchy of time servers (strata), with primary servers connected to highly accurate time sources (e.g., atomic clocks). Secondary servers synchronize with primary servers, and client computers synchronize with secondary servers. NTP accounts for network delays and offers reliable service with redundant servers and paths. It employs filtering algorithms to choose the best time estimates from multiple servers and samples.
        
    - **Accuracy (Internet):** NTP aims for high accuracy, often achieving millisecond-level precision over the Internet. However, accuracy is still limited by variable network delays and clock drift rates. Asymmetric transmission delays can also introduce errors. Higher strata (further from the primary time source) generally imply less accuracy.
        
- **Discussion Topic:** Compare and contrast cloud computing with more traditional client-server computing? What is novel about cloud computing as a concept?
    
    - **Comparison:**
        - **Resource Provisioning:** In traditional client-server, resources (servers, storage) are typically purchased and maintained by the organization. In cloud computing, resources are offered as a utility, rented on a pay-per-usage model.
            
        - **Scalability:** Traditional client-server systems often have fixed capacities, making scaling up or down challenging and costly. Cloud computing offers elastic scalability, allowing users to rent and release resources dynamically to match demand.
            
        - **Location of Resources:** In client-server, servers are typically on-premises or in a dedicated data center managed by the organization. Cloud computing relies on Internet-based applications and services hosted on large-scale, often geographically distributed, data centers.
            
        - **Management Overhead:** Client-server requires significant IT overhead for hardware, software, and infrastructure management. Cloud computing shifts much of this burden to the cloud provider, decreasing reliance on local devices and infrastructure management by the user.
            
        - **Focus:** Client-server focuses on direct interaction between clients and dedicated servers for specific services. Cloud computing views computing itself as a utility, providing abstract services (IaaS, PaaS, SaaS).
            
    - **Novelty of Cloud Computing:**
        - **Computing as a Utility:** The core novelty is treating computing resources (computational power, storage, software services) as a commodity that can be rented and consumed like electricity or water, on demand and with a pay-per-usage model.
            
        - **Elasticity:** The ability to rapidly provision and de-provision computing resources to instantly scale with fluctuating demand, without significant upfront investment or long-term commitments, is a key differentiator.
        - **Abstraction:** Cloud computing provides layers of abstraction (e.g., Virtual Machines in IaaS, platforms in PaaS, complete applications in SaaS) that hide the underlying physical infrastructure, simplifying development and deployment for users.
            
        - **Massive Scale & Efficiency:** Cloud providers operate at massive scales, achieving economies of scale and efficiency in resource utilization that individual organizations typically cannot.
- **Discussion Topic:** A server program written in one language (for example C++) provides the implementation of a BLOB object that is intended to be accessed by clients that may be written in a different language (for example Java). The client and server computers may have different hardware, but all of them are attached to an internet. Describe the problems due to each of the five aspects of heterogeneity that need to be solved to make it possible for a client object to invoke a method on the server object.
    
    - **Heterogeneity Problems:**
        1. **Network Heterogeneity:** The Internet connects various networks (LANs, WANs, wireless, etc.) with different protocols and data transmission mechanisms. A common protocol stack (like TCP/IP) is needed to mask these differences and allow communication.
            
        2. **Hardware Heterogeneity:** Different computer architectures (e.g., Intel, ARM) may use different byte orderings (endianness) or data representations for primitive types (integers, floating-point numbers). Data passed between client and server must be converted to a common external data representation format (e.g., CORBA CDR, XML, Protocol Buffers) during marshalling and unmarshalling to ensure correct interpretation.
            
        3. **Operating System Heterogeneity:** Different operating systems (e.g., Linux, Windows, macOS) may have varying system calls, file system structures, or process management. Middleware (e.g., CORBA, Java RMI) is needed to provide a unified programming abstraction over these OS differences, allowing processes to interact without being aware of the underlying OS.
            
        4. **Programming Language Heterogeneity:** C++ and Java have different object models, memory management (manual vs. garbage collection), and data structures. An Interface Definition Language (IDL) or similar mechanism (like Web Services Description Language for web services) is required to define the server's object interface in a language-neutral way, allowing clients in different languages to understand and invoke its methods.
            
        5. **Implementation Heterogeneity:** Different implementations of the same standard or protocol can have subtle variations or bugs. Strict adherence to common standards, robust testing, and verification for conformance are essential to ensure compatibility between different components.
            

#### **Chapter #2: System Models**

- **Discussion Topic:** The host computers used in peer-to-peer systems are often simply desktop computers in users' offices or homes. What are the implications of this for the availability and security of any shared data objects that they hold and to what extent can any weaknesses be overcome through the use of replication?
    
    - **Implications for Availability:**
        - **Unpredictable Uptime:** Desktop computers are frequently turned off, put to sleep, or disconnected from the network by users, leading to high churn and unpredictable availability of the data they host.
            
        - **Variable Network Connectivity:** Home internet connections often have lower bandwidth and higher latency compared to data center connections, and may experience frequent disconnections, impacting data access speed and reliability.
            
        - **Lack of Professional Management:** Users typically don't have the expertise or tools for 24/7 monitoring, maintenance, or disaster recovery, unlike professionally managed servers.
    - **Implications for Security:**
        - **Vulnerability to Attacks:** Home computers are generally less secured than dedicated servers, making them more susceptible to malware, viruses, and direct attacks, which can compromise data integrity and confidentiality.
            
        - **Lack of Physical Security:** Physical access to the machine by unauthorized individuals is a higher risk in a home environment.
        - **Trust Issues:** Data may be stored on machines belonging to unknown users, raising trust concerns about data privacy and malicious modification.
            
        - **Dynamic IP Addresses:** Many home users have dynamic IP addresses, complicating consistent addressing for shared resources.
            
    - **Overcoming Weaknesses through Replication:**
        - **Enhanced Availability:** By replicating data objects across multiple peer nodes, even if some nodes go offline (due to unpredictable uptime or disconnections), the data remains accessible from other live replicas. This transforms potential single points of failure into a fault-tolerant system.
            
        - **Improved Durability:** Replication makes data more durable against hardware failures on individual machines. If one disk crashes, other replicas still hold the data.
        - **Increased Read Scalability:** Clients can read from any available replica, distributing the load and potentially improving read performance.
        - **Mitigation of Security Risks (to an extent):**
            - **Data Integrity:** Cryptographic hashes and versioning can be used with replication to detect data tampering. If a replica is compromised, integrity checks can identify corrupted versions.
            - **Confidentiality:** Data can be encrypted _before_ replication, so that even if a replica is compromised, the data remains unintelligible without the decryption key.
            - **Censorship Resistance:** In highly decentralized P2P systems, replication across many diverse nodes can make it harder for a single entity to censor or remove data.
        - **Limitations of Replication for Security:** Replication alone does not solve all security problems. If the _original_ data is compromised before replication, or if the encryption keys are stolen, replication will simply spread the compromised data. Trust in the network's participants and robust security protocols (authentication, access control) are still crucial.


- **Discussion Topic:** Consider a hypothetical car hire company and sketch out a three-tier solution to the provision of their underlying distributed car hire service. Use this to illustrate the benefits and drawbacks of a three-tier solution considering issues such as performance, scalability, dealing with failure and also maintaining the software over time.
    
    - **Sketch of a Three-Tier Solution for a Car Hire Company:**
        
        - **Tier 1: Presentation Tier (Client Layer):** User interfaces for customers and internal staff. This would include:
            - Web browsers for customer bookings, viewing car availability, managing accounts.
            - Mobile apps for customers (e.g., unlocking cars, navigation).
            - Desktop applications or web interfaces for staff (e.g., fleet management, maintenance scheduling, customer support).
            - _Technologies:_ HTML/CSS/JavaScript, React/Angular/Vue, iOS/Android native development.
        - **Tier 2: Application Tier (Business Logic Layer):** Contains the core business logic and processes. This tier orchestrates operations between the presentation and data tiers.
            - **Booking Management:** Handles car reservations, availability checks, payment processing initiation.
            - **Fleet Management:** Manages car status (available, rented, in maintenance), location tracking.
            - **Customer Management:** User authentication, profile management.
            - **Reporting/Analytics:** Generates business reports.
            - _Technologies:_ Java (Spring Boot), Python (Django/Flask), Node.js (Express), often deployed on application servers or microservices.
        - **Tier 3: Data Tier (Data Storage Layer):** Stores all persistent data.
            - **Customer Database:** User profiles, booking history.
            - **Car Fleet Database:** Car details (make, model, location, status), maintenance records.
            - **Payment Gateway Integration:** Securely handles payment transactions.
            - _Technologies:_ Relational Databases (PostgreSQL, MySQL), NoSQL Databases (MongoDB, Cassandra), potentially distributed file systems for documents.
    - **Illustration of Benefits and Drawbacks:**
        
        - **Performance:**
            - **Benefits:** Separation of concerns allows each tier to be optimized independently. The application tier can cache frequently accessed data (e.g., car availability for popular models) to reduce load on the database. Dedicated application servers can process requests more efficiently than a monolithic client.
                
            - **Drawbacks:** Increased network latency due to more communication hops between tiers. Overhead from marshalling/unmarshalling data between tiers.
                
        - **Scalability:**
            - **Benefits:** Each tier can be scaled independently based on its specific load requirements. If booking demand surges, more application servers can be added without necessarily scaling the entire database. This allows for horizontal scaling.
                
            - **Drawbacks:** Identifying the correct scaling point (bottleneck) across tiers can be complex. Maintaining consistency across many scaled instances requires careful design.
        - **Dealing with Failure:**
            - **Benefits:** Isolation of failures. A failure in the presentation tier (e.g., a web server crash) does not necessarily bring down the entire business logic or data tier. Redundancy can be built into each tier (e.g., multiple application servers, database replication) to provide fault tolerance.
                
            - **Drawbacks:** Partial failures are more complex to manage, as one tier might fail while others continue to operate, leading to inconsistent system states from a user's perspective. A failure in a critical component (e.g., the primary database) can still halt the entire service.
                
        - **Maintaining Software Over Time:**
            - **Benefits:** Modularity promotes easier maintenance and updates. Changes in the UI (Presentation Tier) don't require changes to the business logic. Database schema updates can be managed within the Data Tier without impacting the Presentation Tier's code. This allows for independent development and deployment cycles for each tier.
                
            - **Drawbacks:** Increased complexity in deployment and monitoring across multiple tiers. Debugging issues that span multiple tiers can be more challenging, as it requires tracing requests across different services and network boundaries.
- **Discussion Topic:** Consider two communication services for use in asynchronous distributed systems. In service A, messages may be lost, duplicated or delayed and checksums apply only to headers. In service B, messages may be lost, delayed or delivered too fast for the recipient to handle them, but those that are delivered arrive order and with the correct contents. Describe the classes of failure exhibited by each service. Classify their failures according to their effect on the properties of validity and integrity. Can service B be described as a reliable?
    
    - **Classes of Failure for Service A:**
        - **Omission Failures:** Messages may be lost (crash of communication channel or buffer overflow).
            
        - **Arbitrary (Byzantine) Failures:** Messages may be duplicated (multiple copies delivered), or delayed. Since checksums apply only to headers, the _contents_ of the message can be corrupted without detection.
            
        - **Timing Failures:** Messages may be delayed, meaning they take longer than expected (though "expected" is ill-defined in an asynchronous system, the delay itself is a characteristic).
    - **Classes of Failure for Service B:**
        - **Omission Failures:** Messages may be lost.
        - **Timing Failures:** Messages may be delayed or delivered too fast for the recipient to handle them. The "too fast" implies a performance violation for the recipient, which is a timing failure.
            
        - **No Arbitrary Failures:** Messages arrive in order and with correct contents, indicating the absence of duplication and content corruption.
    - **Classification of Failures by Validity and Integrity:**
        - **Reliable Communication Properties:**
            - **Validity:** Assures that a message sent is eventually delivered.
                
            - **Integrity:** Assures that the message is delivered at most once and without corruption.
                
        - **Service A:**
            - **Validity:** _Violated_ (messages may be lost).
            - **Integrity:** _Violated_ (messages may be duplicated, contents may be corrupted due to checksums only on headers).
        - **Service B:**
            - **Validity:** _Violated_ (messages may be lost).
            - **Integrity:** _Satisfied_ (messages delivered in order, with correct contents, implying no duplication and no corruption).
    - **Can Service B be described as reliable?**
        - No, Service B **cannot** be described as reliable. Reliability, by definition, includes the property of **validity** (messages _will_ eventually be delivered). Since Service B explicitly states that messages _may be lost_, it violates the validity property, and therefore is not reliable. It does, however, offer good integrity for the messages that _are_ delivered.
            

#### **Chapter #3: Networking and Internetworking**

- **Discussion Topic:** What is the task of an Ethernet switch? What tables does it maintain?
    
    - **Task of an Ethernet Switch:** An Ethernet switch's primary task is to forward Ethernet frames (packets) between connected devices within a local area network (LAN). It operates at the data link layer (Layer 2) of the OSI model. Its goal is to efficiently direct traffic only to the specific port where the destination device is located, rather than broadcasting it to all ports like a hub. This reduces network congestion and improves overall network performance.
        
    - **Tables it Maintains:** An Ethernet switch maintains a **MAC address table** (also known as a Content Addressable Memory or CAM table). This table stores a mapping between the MAC addresses of devices connected to the network and the specific switch ports they are connected to.
        
        - **How it populates:** The switch learns MAC addresses by inspecting the source MAC address of incoming frames. When a frame arrives on a port, the switch records the source MAC address and associates it with that port.
        - **How it uses it:** When a frame arrives with a destination MAC address, the switch looks up that address in its MAC address table.
            - If the address is found and associated with a different port than the incoming port, the frame is forwarded only to that specific destination port.
            - If the address is found on the same port, the frame is discarded (already delivered).
            - If the address is _not_ found in the table (e.g., a new device or the entry has timed out), the frame is broadcast to all ports (except the incoming one) until the destination device replies, allowing the switch to learn its MAC address.
- **Discussion Topic:** Compare connectionless (UDP) and connection-oriented (TCP) communication for the implementation of each of the following application-level or presentation-level protocols:
    
    - i) virtual terminal access (for example, Telnet);
        
    - ii) file transfer (for example, FTP);
        
    - iii) user location (for example, rwho, finger);
        
    - iv) information Browse (for example, HTTP);
        
    - v) remote procedure call.
        
    - **General Comparison:**
        
        - **TCP (Connection-Oriented):** Reliable, ordered, flow-controlled, connection setup/teardown overhead, handles lost/duplicated messages. Higher overhead, but provides guarantees.
            
        - **UDP (Connectionless):** Unreliable, unordered, no flow control, low overhead, faster for small/bursty data. No guarantees, but minimal overhead.
            
    - **Application-Specific Comparisons:**
        
        - **i) Virtual Terminal Access (Telnet):**
            - **TCP:** **Preferred.** Telnet requires reliable, ordered delivery of individual characters (keystrokes and screen output). Loss or reordering of characters would make the terminal unusable. TCP provides this guarantee.
                
            - **UDP:** Not suitable. Loss of characters would lead to missing input/output, and reordering would scramble text, making interaction impossible.
        - **ii) File Transfer (FTP):**
            - **TCP:** **Preferred.** File transfer requires complete and accurate delivery of data. Any loss or corruption would result in an incomplete or unusable file. TCP's reliability, flow control, and checksumming ensure data integrity.
                
            - **UDP:** Not suitable. Would require the application layer to implement complex mechanisms for reliability, retransmission, and flow control, essentially re-inventing TCP.
        - **iii) User Location (rwho, finger):**
            - **UDP:** **Preferred.** These services typically involve sending a small query and expecting a small response. Occasional loss of a request or response is usually acceptable, as the user can simply retry. The low overhead of UDP makes it efficient for such frequent, small, potentially unreliable queries.
                
            - **TCP:** Overkill. The connection setup/teardown overhead would be significant for each small query, making it less efficient than UDP.
        - **iv) Information Browse (HTTP):**
            - **TCP:** **Preferred.** HTTP requires reliable and ordered transfer of web page content (HTML, images, scripts). Loss or reordering of parts of a web page would render it unusable or visually corrupted. TCP guarantees this necessary integrity.
                
            - **UDP:** Not suitable. Would lead to broken web pages, missing images, and unreliable user experience. While HTTP/3 is moving towards UDP (via QUIC), it builds significant reliability mechanisms _on top_ of UDP, addressing its inherent unreliability.
        - **v) Remote Procedure Call (RPC):**
            - **TCP:** **Often preferred for reliability.** RPC often requires "at-most-once" semantics, meaning the remote procedure is executed exactly once or not at all. TCP's reliable and ordered delivery helps achieve this, as the application layer doesn't need to worry about retransmission or duplicate filtering for messages.
                
            - **UDP:** Possible for "maybe" or "at-least-once" semantics. UDP can be used for RPC (e.g., Sun RPC's default was UDP) if the application layer explicitly implements its own reliability (retransmissions, timeouts, duplicate filtering). This can be more efficient for very small, frequent requests where the application can tolerate occasional loss or handle duplicates.
                
- **Discussion Topic:** Explain how it is possible for a sequence of packets transmitted through a wide area network to arrive at their destination in an order that differs from that in which they were sent. Why can't this happen in a local network?
    
    - **Out-of-Order Arrival in a WAN:**
        - **Multiple Paths (Routing):** In a Wide Area Network (WAN) like the Internet, routers constantly determine the best path for packets to reach their destination. There are often multiple possible routes between a source and a destination.
            
        - **Dynamic Routing Decisions:** Routing algorithms (e.g., distance vector, link-state) adapt to network conditions (congestion, link failures) and can change the "best" path dynamically.
            
        - **Independent Packet Forwarding:** Each packet is treated independently by routers. If subsequent packets in a sequence take different paths (due to dynamic routing changes or load balancing) or encounter varying delays on different links, they can arrive at the destination in a different order than they were sent. For example, a later packet on a faster, less congested path might arrive before an earlier packet on a slower, more congested path.
            
    - **Why it Can't Happen in a Local Network (typically):**
        - **Single Path:** Most Local Area Networks (LANs), especially traditional Ethernet networks, operate on a shared medium or a single logical path between two communicating devices. Frames typically traverse the same sequence of hubs or switches without dynamic rerouting.
            
        - **No Complex Routing:** Switches in a LAN typically learn MAC addresses and forward frames directly to the correct port without complex routing decisions for each packet. There isn't the concept of alternative paths for individual packets within a single Ethernet segment or switched LAN. All packets from a source to a destination usually follow the same determined path.
            
        - **Error Handling:** While frames can be lost in a LAN due to collisions or errors, retransmission would typically happen at the data link layer, maintaining the order.

#### **Chapter #4: Interprocess communication**

- **Discussion Topic:** Is it conceivably useful for a port to have several receivers?
    
    - **Answer:** Generally, no, it is **not** useful for a single port to have several _active_ receivers (processes bound to the same port on the same machine).
    - **Reasoning:**
        - **Ambiguity:** If multiple processes were trying to receive from the same port, it would be ambiguous which process should receive an incoming message. The operating system would have to arbitrarily decide, or duplicate the message, leading to unpredictable behavior or resource waste.
        - **Resource Management:** Ports are operating system resources that typically manage a queue of incoming messages for a single bound process. Allowing multiple processes to contend for this queue would complicate OS resource management and lead to contention.
        - **Common Use Cases:** Most standard protocols (like HTTP on port 80, SSH on port 22) expect a single server process to listen on a well-known port.
    - **Exceptions/Related Concepts (where multiple entities _might_ be involved):**
        - **Multicast:** While a single port typically has one receiver, _multicast addresses_ (Class D IP addresses) allow a single packet to be sent to a group of computers, where multiple processes on _different_ machines (or even multiple processes on the _same_ machine if the OS supports it for multicast sockets) can listen on the _same port number_ to receive copies of the same message. However, this is about a single sender sending to multiple receivers across the network, not multiple receivers competing for messages on a single port on one machine.
            
        - **Load Balancing/Clustering:** In high-availability scenarios, multiple _server instances_ might listen on the _same logical port_ (e.g., via a load balancer or a cluster manager) but these are usually on _different physical machines_ or distinct network interfaces, and the load balancer distributes incoming connections/messages to individual server processes. This is managed by an external component, not directly by multiple processes binding to the same port on a single OS instance.
        - **Port Reuse (SO_REUSEADDR):** Sockets can sometimes be configured with `SO_REUSEADDR` to allow multiple processes to bind to the same address and port. However, this is primarily for specific scenarios like quickly restarting a server after a crash (to avoid "address already in use" errors) or for IP multicast applications, not for general-purpose multiple unicast receivers on the same port. For unicast traffic, only one listener will typically receive the packet.
- **Discussion Topic:** Why can't binary data be represented directly in XML, for example, by representing it as Unicode byte values? XML elements can carry strings represented as base64. Discuss the disadvantages of using this method to represent binary data.
    
    - **Why not directly in XML (as Unicode byte values)?**
        - **XML's Character Data Nature:** XML is designed to be a text-based markup language. All information in XML is inherently represented as character data. This means that character parsers and text-processing tools expect valid Unicode characters.
            
        - **Invalid Characters:** Binary data can contain any byte value from 0 to 255. Many of these byte values do not correspond to valid printable Unicode characters (e.g., control characters, null bytes). If these "invalid" byte values were directly inserted into XML, a standard XML parser would encounter a fatal error because it would not be a "well-formed" XML document.
            
        - **Encoding Issues:** XML documents have a specified encoding (e.g., UTF-8, UTF-16). Directly embedding arbitrary binary bytes would violate this encoding, as the byte sequences might not form valid characters in the declared encoding.
            
        - **Meaningful Markup:** XML relies on `<` and `&` characters for markup and entity references. Binary data might accidentally contain these characters, leading to parsing errors or misinterpretation of the document structure.
            
    - **Disadvantages of using Base64 to represent binary data in XML:**
        - **Increased Data Size (Overhead):** Base64 encoding converts 3 bytes of binary data into 4 characters of ASCII text. This means a **33% overhead** in data size (the encoded data is approximately 1.33 times larger than the original binary data). This increases network transmission time, storage requirements, and parsing/processing time.
            
        - **Readability:** While Base64 makes binary data "printable text," it is not human-readable. A long string of Base64 characters is just as unintelligible to a human as raw binary, defeating one of XML's perceived benefits (human-readability).
            
        - **Processing Overhead:** Both encoding (at the sender) and decoding (at the receiver) of Base64 introduce computational overhead. This involves extra CPU cycles and memory operations for conversion, which can be significant for large binary objects.
        - **Limited Searchability:** Searching directly within the XML document for patterns or content within the binary data becomes impossible without first decoding the Base64 string.
        - **Potential for Malformed Data:** If the Base64 string itself is malformed or corrupted, the decoding process can fail, making the binary data unusable.

#### **Chapter #5: Remote invocation**

- **Discussion Topic:** Explain the design choices that are relevant to minimizing the amount of reply data held at a server. Compare the storage requirements when the RR and RRA protocols are used.
    
    - **Design Choices to Minimize Reply Data Held at a Server:**
        
        1. **Idempotent Operations:** If operations are idempotent (can be performed repeatedly without changing the outcome), the server doesn't need to store any history of replies. If a duplicate request arrives, it can simply re-execute the operation and send the result, knowing the state will remain consistent.
            
        2. **Stateless Design (where possible):** Designing services to be as stateless as possible reduces the need for the server to maintain session-specific data, including reply histories. Each request carries all necessary context.
        3. **Client-driven Acknowledgments:** In some protocols, the client is solely responsible for ensuring it received the reply. If the client doesn't get a reply, it re-sends the request. The server doesn't keep a history, relying on the client's retry mechanism. This might be used in "maybe" call semantics.
            
        4. **Short History/Cache Timeouts:** If a server must maintain a history of replies to detect duplicates and retransmit results, these history entries should have short timeouts. Once the timeout expires, the entry is discarded, freeing up server memory.
            
        5. **Limited History Size:** The server could enforce a maximum size for its reply history cache, discarding older entries to make room for newer ones when the limit is reached.
        6. **Application-Specific Optimization:** For specific applications, knowledge about the data or operation might allow for specialized ways to avoid storing replies (e.g., if replies are always small or can be easily regenerated).
    - **Comparison of Storage Requirements (RR vs. RRA Protocols):**
        
        - **RR (Request-Reply) Protocol:** In the RR protocol, the client sends a request, and the server sends a reply. The reply itself implicitly acts as an acknowledgment that the request was received and processed. To handle potential lost replies (where the server processed the request but the reply message was lost), the client might re-send the request. In this scenario, to avoid re-executing non-idempotent operations, the **server must store a history of replies** for some period of time. This allows it to detect duplicate requests and retransmit the stored reply instead of re-executing the operation.
            
            - **Storage Requirement:** **High.** The server needs to store the last reply for each client (or for each request that might be retransmitted) to detect duplicates and retransmit results. This can be a significant storage burden if there are many clients or frequent non-idempotent operations.
                
        - **RRA (Request-Reply-Acknowledge) Protocol:** In the RRA protocol, the client sends a request, the server sends a reply, and then the **client sends an explicit acknowledgment of the reply**. The server only discards its copy of the reply (or marks the request as fully acknowledged) once it receives this acknowledgment from the client.
            
            - **Storage Requirement:** **Lower (potentially zero after client ACK).** The server still needs to store the reply _until_ it receives the client's acknowledgment. However, once the acknowledgment is received, the server can safely discard the reply data, as it knows the client has successfully received it. This reduces the _duration_ for which data needs to be stored and can potentially free up server memory more quickly than RR, especially if network conditions are good and ACKs arrive promptly. In ideal scenarios, if the server receives the ACK immediately, its storage requirement for old replies becomes minimal.
                
- **Discussion Topic:** The Election interface provides two remote methods:
    
    - `vote`: with two parameters through which the client supplies the name of a candidate (a string) and the 'voter's number' (an integer used to ensure each user votes once only). The voter's numbers are allocated sparsely from the range of integers to make them hard to guess.
        
    - `result`: with two parameters through which the server supplies the client with the name of a candidate and the number of votes for that candidate.
        
    - The Election service must ensure that a vote is recorded whenever any user thinks they have cast a vote.
        
    - Discuss the effect of maybe call semantics on the Election service.
        
    - Would at-least-once call semantics be acceptable for the Election service or would you recommend at-most-once call semantics?
        
    - **Effect of Maybe Call Semantics on the Election Service:**
        
        - "Maybe" call semantics means the remote procedure is executed zero or one time; there are no fault-tolerance measures like retransmission. If a request message is lost, the procedure is not executed. If the result message is lost, the client times out but doesn't know if the procedure executed.
            
        - **Impact on Election Service:** With "maybe" semantics, if a client sends a `vote` request and the message is lost (or the reply is lost), the vote might never be recorded on the server, even though the "user thinks they have cast a vote". This directly violates the service requirement: "The Election service must ensure that a vote is recorded whenever any user thinks they have cast a vote." It would lead to silently dropped votes and an unreliable election outcome. This is **unacceptable** for an election service.
            
    - **Acceptability of At-Least-Once vs. At-Most-Once Call Semantics:**
        
        - **At-Least-Once Call Semantics:**
            - **Definition:** The remote procedure is executed one or more times, or an exception is raised. This is typically achieved by retransmitting lost request messages. The server does _not_ filter duplicate requests, so a retransmitted request might cause the procedure to execute multiple times.
                
            - **Acceptability for Election Service:** This would be **unacceptable**. If a `vote` request is retransmitted and the server processes it multiple times, a single user's vote (identified by the `voter's number`) could be recorded multiple times. This violates the principle of one vote per user, compromising the integrity of the election. Even though the `voter's number` is intended to ensure unique voting, a simple re-execution on the server might re-record the same valid `voter's number` again if not handled carefully at the application level.
                
        - **At-Most-Once Call Semantics:**
            - **Definition:** The remote procedure is executed exactly once or an exception is raised. This semantics includes retransmission of requests and duplicate filtering at the server (and retransmission of replies if the reply is lost).
                
            - **Acceptability for Election Service:** This would be **recommended** and is generally the most appropriate.
                - It ensures that if a user "thinks they have cast a vote" and the remote call is successful (no exception), that vote is recorded exactly once, satisfying the service requirement.
                    
                - Duplicate `vote` requests (due to client retransmission after a lost reply) would be filtered by the server, preventing multiple recordings of the same vote. This preserves the integrity of the "each user votes once only" rule.
                    
- **Discussion Topic:** A client makes remote procedure calls to a server. The client takes 5 milliseconds to compute the arguments for each request, and the server takes 10 milliseconds to process each request. The local OS processing time for each send or receive operation is 0.5 milliseconds, and the network time to transmit each request or reply message is 3 milliseconds. Marshalling or unmarshalling takes 0.5 milliseconds per message.
    
    - Calculate the time taken by the client to generate and return from two requests:
        
        - (i) if it is single-threaded,
        - (ii) if it has two threads that can make requests concurrently on a single processor.
    - You can ignore context-switching times and assume that the server is single-threaded.
        
    - **Assumptions per request:**
        
        - Client Argument Compute: 5 ms
        - Client Marshalling (request): 0.5 ms
        - Client OS Send: 0.5 ms
        - Network Transmission (request): 3 ms
        - Server Processing: 10 ms
        - Network Transmission (reply): 3 ms
        - Client OS Receive: 0.5 ms
        - Client Unmarshalling (reply): 0.5 ms
    - **Total time for one request (sequential):**
        
        - Client side (before network): 5 (compute) + 0.5 (marshal) + 0.5 (send) = 6 ms
        - Network round-trip: 3 (request) + 3 (reply) = 6 ms
        - Server processing: 10 ms
        - Client side (after network): 0.5 (receive) + 0.5 (unmarshal) = 1 ms
        - **Total `time_per_request` = 6 ms (client pre-network) + 3 ms (net req) + 10 ms (server) + 3 ms (net reply) + 1 ms (client post-network) = 23 ms**
    - **(i) Single-threaded Client (Two Requests Sequentially):**
        
        - A single-threaded client executes requests one after another, waiting for the full response of the first request before starting the second.
        - Time for 1st request = 23 ms
        - Time for 2nd request = 23 ms
        - **Total time = 23 ms + 23 ms = 46 ms**
    - **(ii) Two Threads, Concurrent Requests (on a Single Processor):**
        
        - With two threads on a _single processor_, true parallelism (simultaneous execution) isn't possible. The OS scheduler will interleave the execution of the threads. However, remote calls often involve waiting for network I/O. While one thread is blocked waiting for a network reply, the other thread can run.
        - Let's analyze the timeline. The server is single-threaded, so it can only process one request at a time.
        - **Request 1 (Thread 1):**
            - 0ms: T1 starts compute args (5ms)
            - 5ms: T1 finishes compute, starts marshal/send (1ms)
            - 6ms: T1 finishes marshal/send, request R1 enters network (3ms network travel)
            - **At this point, T1 is blocked waiting for network/server.**
        - **Request 2 (Thread 2):**
            - Since T1 is blocked from 6ms, T2 can start.
            - 6ms: T2 starts compute args (5ms)
            - 11ms: T2 finishes compute, starts marshal/send (1ms)
            - 12ms: T2 finishes marshal/send, request R2 enters network (3ms network travel)
        - **Server Side:**
            - R1 arrives at server at 6ms (client send) + 3ms (network) = 9ms.
            - Server processes R1 from 9ms to 19ms (10ms processing).
            - Server sends reply for R1 at 19ms.
            - R2 arrives at server at 12ms (client send) + 3ms (network) = 15ms.
            - Since the server is single-threaded, R2 must wait until R1 is finished. R2 starts processing at 19ms.
            - Server processes R2 from 19ms to 29ms (10ms processing).
            - Server sends reply for R2 at 29ms.
        - **Client Side (Replies):**
            - Reply for R1 arrives at client at 19ms (server send) + 3ms (network) = 22ms.
            - T1 unmarshals/receives R1 from 22ms to 23ms. **T1 finishes at 23ms.**
            - Reply for R2 arrives at client at 29ms (server send) + 3ms (network) = 32ms.
            - T2 unmarshals/receives R2 from 32ms to 33ms. **T2 finishes at 33ms.**
        - **Total time = 33 ms** (when the last thread finishes).
        - **Conclusion:** Concurrency improves throughput by overlapping client-side computation with network latency and server processing.

#### **Chapter #5: Remote invocation**

- **Discussion Topic:** A null RMI that takes no parameters, calls an empty procedure and returns no values delays the caller for 2.0 milliseconds. Explain what contributes to this time.
    - In the same RMI system, each 1K of user data adds an extra 1.5 milliseconds. A client wishes to fetch 32K of data from a file server. Should it use one 32K RMI or 32 1K RMIs
        
    - **Contributions to a Null RMI's 2.0 Milliseconds Delay:** A "null RMI" is a baseline measurement of the overhead involved in a remote invocation without any actual computation or significant data transfer. The 2.0 milliseconds primarily reflect fixed software overheads:
        
        1. **Marshalling/Unmarshalling Overhead:** Even for no parameters/return values, there's a small fixed cost for the RMI stub/skeleton to prepare and parse the message headers, including the method identifier.
            
        2. **Data Copying:** Data might be copied between user space and kernel space buffers on both the client and server machines, and within the kernel for network stack processing.
            
        3. **Packet Initialization & Header Setup:** The operating system's network stack needs to create and fill packet headers (TCP, IP, Ethernet, etc.) for both the request and reply messages.
            
        4. **Network Transmission Time:** The inherent latency of the network (even if very small for a LAN) contributes, as the message must travel from client to server and back.
            
        5. **Operating System Kernel Actions:** Transitions between user mode and kernel mode (for system calls like `send` and `receive`), context switching between processes/threads (if the server is multi-threaded or the client's thread yields), and OS internal processing.
            
        6. **Runtime Code:** RMI runtime overheads for managing remote references, dispatching, and thread management.
            
    - **Fetching 32K of Data: One 32K RMI vs. 32 1K RMIs:**
        
        - **Cost per RMI:** 2.0 ms (fixed null RMI overhead) + Data Size (K) * 1.5 ms/K
            
        - **Option 1: One 32K RMI:**
            
            - Time = 2.0 ms + (32 K * 1.5 ms/K)
            - Time = 2.0 ms + 48.0 ms
            - **Time = 50.0 ms**
        - **Option 2: Thirty-two 1K RMIs:**
            
            - Each 1K RMI takes: 2.0 ms + (1 K * 1.5 ms/K) = 3.5 ms
            - Total time = 32 RMIs * 3.5 ms/RMI
            - **Total time = 112.0 ms**
        - **Conclusion:** The client should use **one 32K RMI**.
            
        - **Reasoning:** Remote procedure calls have a significant fixed overhead per invocation, regardless of the amount of data transferred (up to a certain packet size threshold). By fetching the data in one larger RMI, you incur this fixed overhead only once. Sending multiple smaller RMIs incurs the fixed overhead (marshalling, OS calls, network round-trip for headers, context switches) 32 times, which quickly adds up and becomes much less efficient. The delay of an RPC increases linearly with data size, but the dominant factor for small data chunks is often the fixed overhead per call.
            

#### **Chapter #6: Indirect communication**

- **Discussion Topic:** Message passing is both time- and space-coupled - that is, messages are both directed towards a particular entity and require the receiver to be present at the time of the message send. Consider the case, though, where messages are directed towards a name rather than an address and this name is resolved using DNS. Does such a system exhibit the same level of indirection?
    
    - **Message Passing (Traditional):** In typical message passing (like sockets), communication is indeed both time-coupled (sender and receiver must often be concurrently active for direct exchange) and space-coupled (sender needs to know the specific address of the receiver).
        
    - **Messages Directed Towards a Name (resolved by DNS):** When messages are directed towards a name (e.g., `www.example.com`) that is resolved by DNS to an IP address, it introduces a layer of **space uncoupling**. The sender does not need to know the _current_ IP address of the receiver directly; it only needs the symbolic name. The DNS service provides the indirection, translating the logical name to a physical address (IP address) dynamically. This means the recipient's physical location (IP address) can change without the sender's code needing to be updated.
        
    - **Level of Indirection:** Yes, such a system exhibits a higher level of indirection than traditional message passing using hardcoded addresses. The DNS acts as an intermediary, abstracting the physical location.
    - **Time Coupling:** However, this system **still remains time-coupled**. While the sender doesn't need the precise address at compile time, it still needs the receiver to be _online and active_ at the time of communication. DNS resolution only provides a current address; it does not queue messages or allow the sender and receiver to operate with independent lifetimes. If the DNS resolves the name to an IP address, and the target machine at that IP is offline, the message will fail to be delivered. The sender is still dependent on the receiver's real-time presence.
        
- **Discussion Topic:** If a communication paradigm is asynchronous, is it also time-uncoupled? Explain your answer with examples as appropriate.
    
    - **Asynchronous Communication:** In asynchronous communication, the sender does not block (wait) for the receiver to receive or process the message. The sender sends the message and can immediately proceed with other tasks.
        
    - **Time Uncoupling:** Time uncoupling means that the sender and receiver can have independent lifetimes. The sender doesn't require the receiver to be active or even exist at the time of sending, and vice-versa. Messages are typically stored by an intermediary until the receiver is ready to process them.
        
    - **Is Asynchronous also Time-Uncoupled?** No, **not necessarily**. Asynchronous communication is a property of the _sender's behavior_ (non-blocking), while time uncoupling is a property of the _relationship between sender and receiver's lifetimes_.
    - **Examples:**
        - **Asynchronous but NOT Time-Uncoupled (Time-Coupled):**
            - **UDP Sockets:** A sender using UDP can send a datagram asynchronously (it doesn't block waiting for an ACK). However, if no process is listening on the destination port on the receiver's machine at that moment, the message is typically discarded by the operating system. The sender and receiver must be concurrently active (time-coupled) for the message to be successfully processed, even if the sender's operation itself is non-blocking.
                
            - **Asynchronous RPC with immediate failure:** If an asynchronous RPC call allows the client thread to continue immediately, but the underlying mechanism doesn't store the request for later delivery if the server is down, then it's asynchronous but still time-coupled.
        - **Asynchronous and Time-Uncoupled:**
            - **Message Queues:** When a producer sends a message to a message queue, it's typically an asynchronous operation (the producer doesn't block). The message queue system then stores the message persistently. A consumer can retrieve this message later, even if the producer has long since terminated. This demonstrates both asynchronous sending and time uncoupling, as the producer and consumer have independent lifetimes.
                
            - **Publish-Subscribe Systems (with persistent brokers):** A publisher sends an event asynchronously to a broker. If the broker is configured for persistence or if a subscriber comes online later, the subscriber can still receive the event. This allows the publisher and subscriber to operate independently in time.
                
- **Discussion Topic:** In the context of a group communication service, provide example message exchanges that illustrate the difference between causal and total ordering.
    
    - **Scenario:** Three processes P1, P2, P3 in a group.
        
    - **Messages:**
        
        - `M1`: Multicast by P1
        - `M2`: Multicast by P2
        - `M3`: Multicast by P1
        - `M4`: Multicast by P3
    - **Timeline (Physical Time):**
        
        - P1 sends `M1`
        - P2 receives `M1`
        - P2 sends `M2` (influenced by `M1`)
        - P1 sends `M3` (independent of `M1`, `M2`)
        - P3 sends `M4` (independent of `M1`, `M2`, `M3`)
    - **Happened-Before Relationship (`->`):**
        
        - `M1 -> M2` (P2 received `M1` before sending `M2`)
        - `M1` is concurrent with `M3` (`M1 || M3`)
        - `M1`, `M2`, `M3` are concurrent with `M4` (assuming no other communication)
    - **1. Causal Ordering:**
        
        - **Definition:** If `multicast(g, m) -> multicast(g, m')` (m happened before m'), then any correct process that delivers `m'` will deliver `m` before `m'`. Independent messages can be delivered in any order.
            
        - **Example Deliveries (consistent with Causal Ordering):**
            - **P1's delivery order:** `M1, M3, M2, M4` (P1 sent `M1` then `M3`; P1 learns about `M2` after it was sent, so `M2` can come after `M3`.)
            - **P2's delivery order:** `M1, M2, M3, M4` (P2 delivered `M1` before sending `M2`; `M3` comes after `M2` as they are concurrent; `M4` is independent.)
            - **P3's delivery order:** `M1, M3, M2, M4` or `M1, M2, M3, M4` (P3 receives `M1` first; then `M3` and `M2` are concurrent, so their relative order can vary, but `M2` must follow `M1`.)
        - **Key Point:** All processes will deliver `M1` before `M2`, because `M1` causally precedes `M2`. However, `M3` (which is concurrent with `M1` and `M2`) could be delivered before or after `M2` at different processes.
    - **2. Total Ordering:**
        
        - **Definition:** If a correct process delivers message `m` before it delivers `m'`, then any other correct process that delivers `m'` will deliver `m` before `m'`. This ensures a consistent global order for all messages, regardless of causal relationships.
            
        - **Example Deliveries (consistent with Total Ordering):**
            - Imagine the total order established is `M1, M3, M2, M4`.
            - **P1's delivery order:** `M1, M3, M2, M4`
            - **P2's delivery order:** `M1, M3, M2, M4`
            - **P3's delivery order:** `M1, M3, M2, M4`
            - (All processes deliver messages in the exact same sequence).
        - **Key Point:** All processes agree on _one specific order_ for all messages. This order might not always reflect the causal order from the sender's perspective (e.g., if P1 sent M3, then P2 sent M2 after receiving M1, in total order M3 might still be delivered before M2 if the total ordering mechanism assigns it an earlier slot). However, if it's `Causal-Total` ordering, it would satisfy both.

#### **Chapter #7: Operating system support**

- **Discussion Topic:** What thread operations are the most significant in cost? Which factors identified in the cost of a remote invocation also feature in message passing?
    
    - **Most Significant Thread Operations in Cost:**
        
        1. **Thread Creation and Destruction:** Allocating/deallocating stack space, setting up/tearing down thread control blocks, and registering/unregistering with the OS scheduler are relatively expensive. Thread pools can mitigate this by reusing threads.
            
        2. **Context Switching:** When the operating system switches control from one thread to another (e.g., due to a time slice expiring, or a thread blocking), it incurs overhead. This involves saving the state (registers, program counter) of the current thread and loading the state of the next thread. While cheaper than process context switching, it's still a significant overhead, especially with many threads or frequent switching.
            
        3. **Synchronization Primitives (e.g., locks, mutexes, semaphores):** Acquiring and releasing locks, especially when there's contention, can be costly. If a thread attempts to acquire a locked resource and is forced to block, it often involves a context switch to another runnable thread. Even uncontended lock operations have a small overhead.
        4. **Inter-thread Communication:** While threads share memory, explicit communication or data passing (e.g., via queues or shared data structures) requires careful synchronization to avoid race conditions, adding overhead.
    - **Factors in Remote Invocation Cost also Feature in Message Passing:** Remote invocation (like RPC/RMI) uses message passing primitives (like sockets) under the hood. Therefore, many cost factors overlap.
        
        1. **Marshalling/Unmarshalling:** The process of converting data structures into a byte stream for transmission (marshalling) and back again (unmarshalling). This is a common requirement whenever structured data needs to be sent across a boundary (process, machine).
	            
	        1. **Data Copying:** Copying message data between application buffers, kernel buffers, and network device buffers.
            
        3. **Operating System Kernel Overhead:** This includes the cost of system calls (`send`, `receive`) to interact with the network stack, and internal kernel processing related to managing network connections and buffers.
            
        4. **Network Transmission Time (Latency and Bandwidth):** The time taken for the message to physically travel across the network medium, including propagation delay and serialization delay (time to put bits on the wire). For larger messages, data transfer rate (bandwidth) becomes a factor.
            
        5. **Packet Initialization and Header Setup:** The overhead of creating and filling network protocol headers (e.g., TCP, IP, Ethernet) for each message or packet.
            
- **Discussion Topic:** Network transmission time accounts for 20% of a null RPC and 80% of an RPC that transmits 1024 user bytes (less than the size of a network packet). By what percentage will the times for these two operations improve if the network is upgraded from 10 megabits/second to 100 megabits/second?
    
    - **Definitions:**
        
        - `T_null`: Total time for a null RPC.
        - `T_1024`: Total time for an RPC with 1024 bytes.
        - `T_network_null`: Network transmission time for a null RPC.
        - `T_network_1024`: Network transmission time for a 1024-byte RPC.
        - `T_software_null`: Software overhead for a null RPC (non-network part).
        - `T_software_1024`: Software overhead for a 1024-byte RPC (non-network part).
        - `R_old` = 10 Mbps = 10×106 bits/second
        - `R_new` = 100 Mbps = 100×106 bits/second
    - **Calculate Existing Times and Software Overheads:**
        
        - **Null RPC:**
            - `T_network_null = 0.20 * T_null`
            - `T_software_null = 0.80 * T_null`
            - Network time primarily depends on latency for very small messages. Let's assume latency is constant for network upgrade.
                
        - **1024-byte RPC:**
            - `T_network_1024 = 0.80 * T_1024`
            - `T_software_1024 = 0.20 * T_1024`
            - 1024 bytes = 1024×8=8192 bits.
            - Network time for 1024 bytes = `(8192 bits / R_old)` + (fixed latency).
            - Since the problem states "less than the size of a network packet," this implies the 1024 bytes are sent in one go, but it's important to consider both fixed latency and transmission time.
            - The cost of an RPC grows with data size beyond a fixed overhead. This fixed overhead is primarily software and latency.
                
    - **Re-evaluating Network Time:** The problem implies the 20% and 80% figures _already account for the specific network speed_. Let's denote the components of time as: `T_total = T_fixed_overhead + T_transmission_time_over_network` where `T_fixed_overhead` includes marshalling, OS calls, dispatching, etc., and is largely independent of network speed _for a null call_ or _for a given data size where fixed overhead dominates_. `T_transmission_time_over_network` depends on data size and bandwidth.
        
        We have:
        
        1. `T_null = T_fixed_software_null + T_network_null` `T_network_null = 0.20 * T_null` `T_fixed_software_null = 0.80 * T_null` (This includes round-trip latency for null)
            
        2. `T_1024 = T_fixed_software_1024_plus_latency_for_1024 + T_transmission_of_1024_bits` `T_network_1024 = 0.80 * T_1024` (This 80% is the transmission time of 1024 bits _plus_ fixed network latency) `T_fixed_software_1024_plus_latency_for_1024 = 0.20 * T_1024` (This is the software overhead + part of network time that is fixed, i.e. latency for the 1024 byte RPC)
            
        
        Let's assume `T_network_null` is purely latency and `T_transmission_of_1024_bits` is purely bandwidth-dependent. Then `T_network_null` is fixed. `T_transmission_of_1024_bits_old` = (1024 bytes * 8 bits/byte) / 10 Mbps = 8192 bits / 10×106 bps = 0.0008192 seconds = 0.8192 ms.
        
        Since `T_network_1024 = 0.80 * T_1024`, and `T_network_1024` would include both latency and data transmission. This problem is tricky with exact values without knowing the absolute times.
        
        **Let's interpret as follows:** The percentage refers to the _proportion_ of time spent on network transmission, which _changes_ when the network speed increases. The question is asking for the _percentage improvement in total time_.
        
        **For a Null RPC:**
        
        - Network transmission time is 20% of total. This is primarily latency for a null message.
        - Latency is largely independent of bandwidth upgrades. It's determined by propagation delay, routing hops, OS delays, etc.
            
        - Therefore, if the latency component (20%) does not change, the **total time for the null RPC will not improve** due to a bandwidth upgrade alone. Improvement would come from reduced per-hop processing time or shorter paths.
        - **Improvement percentage = 0%**
        
        **For an RPC transmitting 1024 user bytes:**
        
        - Network transmission time is 80% of total. This 80% includes both latency and the time to transmit the 1024 bytes.
        - Let `T_total_old = X`. Then `T_network_1024_old = 0.80X`.
        - Let `T_non_network_1024 = 0.20X`. This `T_non_network_1024` portion is constant.
        - The actual data transmission time for 1024 bytes at 10 Mbps: `(1024 * 8) / (10 * 10^6)` seconds = `0.0008192` seconds = `0.8192 ms`.
        - If the network is upgraded to 100 Mbps, the data transmission time becomes: `(1024 * 8) / (100 * 10^6)` seconds = `0.00008192` seconds = `0.08192 ms`. This is 10 times faster.
        - Let `L` be the fixed network latency component (part of `T_network_1024`).
        - So, `T_network_1024_old = L + 0.8192 ms`.
        - And `T_network_1024_new = L + 0.08192 ms`.
        - Without knowing `L` or `X`, we can't get an absolute value.
        
        **However, the phrasing "Network transmission time accounts for 80% of an RPC" often implies that _that specific portion_ is affected.**
        
        - If `T_network_1024_old` (the 80% portion) reduces by a factor of 10, then it becomes `0.80X / 10 = 0.08X`.
        - The total new time `T_total_new = T_non_network_1024 + (T_network_1024_old / 10)`
        - `T_total_new = 0.20X + 0.08X = 0.28X`
        - **Improvement = (T_total_old - T_total_new) / T_total_old**
        - Improvement = `(X - 0.28X) / X = 0.72X / X = 0.72`
        - **Improvement percentage = 72%**
        
        **Final Answer:**
        
        - **Null RPC:** 0% improvement, as its delay is dominated by fixed overheads and latency, not bandwidth.
        - **1024-byte RPC:** Approximately 72% improvement. This is because the component of time directly related to network transmission (which accounts for 80% of the original time) is reduced by a factor of 10.
- **Discussion Topic:** A null RMI that takes no parameters, calls an empty procedure and returns no values delays the caller for 2.0 milliseconds. Explain what contributes to this time.
    
    - In the same RMI system, each 1K of user data adds an extra 1.5 milliseconds. A client wishes to fetch 32K of data from a file server. Should it use one 32K RMI or 32 1K RMIs
        
    - This question is a duplicate from Chapter 5. See answer above.

#### **Chapter #12: Distributed file systems**

- **Discussion Topic:** Why is there no open or close operation in the interface to the flat file service or the directory service. What are the differences between our directory service Lookup operation and the UNIX open?
    
    - **No Open or Close Operations in Flat File Service or Directory Service:**
        
        - **Statelessness:** The design of distributed file services (like Sun NFS, which this architecture models) often aims for **stateless servers**. An `open` operation would imply maintaining state on the server (e.g., file pointers, open modes, access permissions for the duration of the session). A `close` operation would then be needed to release this state. By eliminating `open` and `close`, each file operation (like `read` or `write`) becomes self-contained, including all necessary parameters (like `FileId`, offset, data). This makes servers simpler, more robust to crashes (no state to recover), and easier to scale.
            
        - **Idempotency:** Without open/close, operations like `read` and `write` can be designed to be idempotent (repeatable without side effects beyond the first execution). This simplifies recovery from network failures, as requests can be safely retransmitted if replies are lost.
            
    - **Differences between Directory Service Lookup and UNIX `open`:**
        
        - **Purpose:**
            - **Directory Service `Lookup`:** Its primary purpose is to **resolve a text name (pathname component) within a directory to a unique file identifier (UFID)**. It's essentially a name translation service.
                
            - **UNIX `open`:** Its purpose is to **open a file (or create a new one) and prepare it for I/O operations (read/write), returning a file descriptor**. It also checks access permissions at the time of opening.
                
        - **Return Value:**
            - **Directory Service `Lookup`:** Returns a `FileId` (a unique identifier for the file or directory found).
                
            - **UNIX `open`:** Returns a `filedes` (file descriptor), which is an integer representing an entry in the process's file table, pointing to the open file. Subsequent `read`/`write` calls use this descriptor.
                
        - **Statefulness:**
            - **Directory Service `Lookup`:** It is a **stateless** operation. It performs the lookup and immediately returns the `FileId` without maintaining any open file state on the server or client beyond the request.
                
            - **UNIX `open`:** It is a **stateful** operation. It establishes and maintains state (the open file context) for the duration the file is open. This state includes the read-write pointer position, access mode, and permissions, which are implicitly used by subsequent `read`/`write` calls.
                
        - **Role in File Access:**
            - **Directory Service `Lookup`:** It's part of the **pathname translation** process in a distributed file system. A client might perform multiple `Lookup` calls (one for each component of a path) to get the final `FileId` before performing a `Read` or `Write` operation using that `FileId`.
                
            - **UNIX `open`:** It's the **single entry point** for accessing a file. After `open`, subsequent `read`/`write` operations only need the `filedes` without re-specifying the file name or location.
                
- **Discussion Topic:** How many lookup calls are needed to resolve a 5-part pathname (for example, `/usr/users/jim/code/xyz.c`) for a file that is stored on an NFS server? What is the reason for performing the translation step-by-step?
    
    - **Number of Lookup Calls:** To resolve a 5-part pathname like `/usr/users/jim/code/xyz.c` for a file on an NFS server, **5 `Lookup` calls** are needed.
        
        1. `Lookup("/", "usr")` -> returns `FileId` for `/usr`
        2. `Lookup("FileId for /usr", "users")` -> returns `FileId` for `/usr/users`
        3. `Lookup("FileId for /usr/users", "jim")` -> returns `FileId` for `/usr/users/jim`
        4. `Lookup("FileId for /usr/users/jim", "code")` -> returns `FileId` for `/usr/users/jim/code`
        5. `Lookup("FileId for /usr/users/jim/code", "xyz.c")` -> returns `FileId` for `/usr/users/jim/code/xyz.c`
    - **Reason for Step-by-Step Translation (Iterative Parsing):** The translation is performed step-by-step (iterative parsing) due to the nature of distributed file systems and the mount service:
        
        1. **Distributed Nature of Directories:** Different parts of a hierarchical file system (directories) can reside on different NFS servers. For example, `/usr` might be on Server A, `/usr/users` on Server B, and `/usr/users/jim` on Server C. The client needs to know which server hosts the next component of the path.
            
        2. **Mount Points:** The NFS client uses a "mount service" to associate remote file system subtrees with local directories. These mount points can occur at any level of the directory hierarchy. A step-by-step lookup allows the client to identify when it traverses a mount point to a different server. Each `Lookup` call returns not just a `FileId` but also implicitly the server where the next part of the path needs to be resolved.
            
        3. **Encapsulation of Server Knowledge:** Each `Lookup` call is sent to the server responsible for the _current_ directory component. The server then resolves that single component relative to its local file system and returns the `FileId` and potentially a hint about the next server if it's a cross-server link. This prevents any single client or server from needing to know the entire global file system topology.
            
        4. **Client-Side Caching:** Performing lookups step-by-step allows for client-side caching of intermediate `FileId`s to improve efficiency. If `/usr/users` is frequently accessed, its `FileId` (and the server it resides on) can be cached, allowing subsequent path resolutions starting from `/usr/users` to skip initial `Lookup` calls.
            

#### **Chapter #13: Name services**

- **Discussion Topic:** How does caching help a name service's availability?
    
    - **Caching's Role in Name Service Availability:** Caching significantly enhances a name service's availability by reducing reliance on authoritative (primary) name servers and the network infrastructure connecting to them. Here's how:
        
        1. **Reduced Load on Authoritative Servers:** When a name server (or client resolver) caches a name-to-attribute binding, it can answer subsequent queries for that name directly from its cache. This reduces the number of queries sent to the authoritative servers, which might be geographically distant or under heavy load. If an authoritative server becomes unavailable, the cached entries can continue to serve requests.
            
        2. **Faster Resolution (Implicit Availability):** Although not directly "availability" in the sense of being online, faster resolution time (by avoiding network round-trips to remote servers) means the service _appears_ more available and responsive to users.
            
        3. **Resilience to Network Partitions/Failures:** If a network segment or a remote authoritative name server becomes unreachable due to a failure (e.g., a router crash, ISP outage), cached entries can still be served locally. This allows clients to continue resolving names even when parts of the larger naming infrastructure are down.
            
        4. **Tolerance to Temporary Server Unavailability:** If an authoritative server experiences a temporary outage or overload, cached data can bridge the gap, maintaining service continuity until the primary server recovers.
        5. **Offline Operations (Limited):** In some very limited scenarios, if a client has extensively cached name resolutions, it might be able to function for a period even if completely disconnected from the network, providing a very basic level of "offline availability."
    - **Trade-off: Consistency:** The main trade-off with caching is potential staleness. Cached data might become outdated if the original binding changes before the cache entry's Time-To-Live (TTL) expires. Name services manage this with TTL values, which specify how long a cached entry is considered valid.
        
- **Discussion Topic:** Why do DNS root servers hold entries for two-level names such as `yahoo.com` and `purdue.edu`, rather than one-level names such as `edu` and `com`?
    
    - **Answer:** DNS root servers do **not** directly hold entries for two-level names like `yahoo.com` or `purdue.edu`. Instead, they hold entries for **one-level top-level domains (TLDs)** such as `.com`, `.edu`, `.org`, `.net`, and country code TLDs like `.uk`, `.de`, etc..
        
    - **What Root Servers _Actually_ Hold:** The root servers (e.g., `a.root-servers.net`) primarily hold:
        1. **Delegations for TLDs:** They know which name servers are authoritative for each TLD (e.g., they know the name servers for `.com`, `.edu`, `.org`, `.uk`).
        2. **IP addresses of TLD Name Servers:** For example, the root servers would have entries like `com. IN NS a.gtld-servers.net.` and the corresponding IP address of `a.gtld-servers.net`..
            
    - **Why this Design (Delegation and Hierarchy):**
        - **Scalability:** If root servers held every two-level domain (e.g., `yahoo.com`), the root zone file would be enormous and constantly changing, making it impossible to manage and keep synchronized globally. The hierarchical design delegates authority, distributing the management burden across many different organizations and servers.
            
        - **Decentralization:** This distributed authority prevents any single entity from controlling the entire domain name space. Different organizations (registries) are responsible for managing their respective TLDs.
        - **Performance:** By directing queries down the hierarchy, the root servers (which are critical infrastructure) can remain small and fast, primarily serving as pointers to the next level of authoritative servers. Client resolvers can quickly find the appropriate TLD name server and then proceed iteratively or recursively down the hierarchy.
            
        - **Autonomy:** This structure allows organizations to manage their own subdomains independently without needing direct interaction with the root server administrators for every change.
- **Discussion Topic:** Why might a DNS client choose recursive navigation rather than iterative navigation? What is the relevance of the recursive navigation option to concurrency within a name server?
    
    - **Why a DNS Client Might Choose Recursive Navigation:**
        
        - **Simplicity for the Client (Resolver):** Recursive navigation places the burden of resolving the full name onto the contacted name server. The client (resolver) simply sends one query and expects a single, complete answer or an error. It doesn't need to handle intermediate referrals or re-query other servers. This simplifies the client's logic.
            
        - **Common Practice for End-User Devices:** Most end-user devices (computers, smartphones) are configured to use recursive resolvers provided by their ISP or organization. This is because they are generally "stub resolvers" designed for simplicity, not for complex multi-step lookups.
        - **Caching Efficiency:** When a recursive resolver performs a full lookup, it caches all intermediate results (e.g., the name servers for the TLDs and second-level domains). This makes future queries involving those domains faster for all clients using that recursive resolver.
            
    - **Relevance of Recursive Navigation to Concurrency within a Name Server:**
        
        - **Increased Workload:** A name server configured for recursive navigation takes on the full responsibility of resolving a query by contacting all necessary upstream servers (root, TLD, etc.). This means a single incoming query from a client can trigger multiple outgoing queries from the recursive name server to other DNS servers.
            
        - **Need for Concurrency:** To handle multiple concurrent recursive client queries efficiently, a name server _must_ employ concurrency. While waiting for a reply from an upstream server (which involves network latency), the name server cannot block. Instead, it must be able to:
            - **Handle Multiple Client Requests Simultaneously:** Use multiple threads or asynchronous I/O to manage many concurrent requests from different clients.
                
            - **Manage Multiple Pending Upstream Queries:** For each recursive query, it needs to track state (which upstream server it queried, what it's waiting for, timeouts) for many ongoing upstream lookups.
            - **Overlap I/O and Processing:** While one query is waiting for a network response, the server can use its CPU to process other incoming client requests or other replies from different upstream servers.
                
        - **Impact on Server Design:** This necessitates a multi-threaded or event-driven (asynchronous I/O) server architecture to prevent a single slow upstream lookup from blocking all other client queries, ensuring the name server remains responsive and performant under load