# Flashcards for Exam Preparation (Advanced)

## Introduction to Computer Security

- **Q**: What does the CIA Triad stand for in security, and how do the three components interact in real-world scenarios?  
  **A**: Confidentiality, Integrity, Availability. For example, a secure database must encrypt data (confidentiality), maintain data accuracy (integrity), and remain accessible to users (availability).

- **Q**: Compare and contrast authentication and authorization with examples.  
  **A**: Authentication verifies identity (e.g., password login), while authorization determines access rights (e.g., access granted to files based on roles).

- **Q**: Explain why psychological acceptability is important in security design. How can poor usability lead to vulnerabilities?  
  **A**: Users may disable or bypass security measures if they are difficult to use, such as using simple passwords due to overly strict password policies.

---

## User Authentication

- **Q**: Compare "something known" and "something possessed" authentication mechanisms. Which is more secure in practice?  
  **A**: "Something known" (e.g., passwords) can be guessed or stolen, while "something possessed" (e.g., tokens) adds physical security but can be lost.

- **Q**: How does salting work, and why does it prevent precomputation attacks like rainbow tables?  
  **A**: Salting adds a unique random value to each password before hashing, making precomputed hash matches infeasible.

- **Q**: Explain how biometrics can be used for authentication. What are the challenges of implementing biometric systems?  
  **A**: Biometrics use inherent traits like fingerprints or retina scans. Challenges include accuracy, privacy concerns, and spoofing resistance.

- **Q**: Compare the security of password-based systems with token-based authentication.  
  **A**: Passwords are vulnerable to brute force and phishing, while tokens provide stronger security but require device management and synchronization.

- **Q**: Discuss the RSA SecurID breach of 2011. What lessons were learned about token-based authentication?  
  **A**: The breach exposed "seed" values stored insecurely, highlighting the importance of securing back-end data and multi-layered security.

---

## Access Control

- **Q**: Compare DAC and MAC in terms of flexibility and security.  
  **A**: DAC is more flexible but prone to misconfigurations, while MAC enforces strict security policies at the cost of flexibility.

- **Q**: What is the difference between Role-Based Access Control (RBAC) and Attribute-Based Access Control (ABAC)? Provide examples.  
  **A**: RBAC assigns access based on roles (e.g., admin), while ABAC uses attributes (e.g., time, location) for finer control.

- **Q**: How does the Bell-LaPadula Model enforce confidentiality? What are its limitations?  
  **A**: By enforcing "No Read Up" and "No Write Down." Limitations include lack of focus on integrity and dynamic policy adjustments.

- **Q**: Design a scenario where ABAC would be necessary instead of RBAC.  
  **A**: ABAC is needed in a hospital system where access depends on roles, location (e.g., on-premises), and time (e.g., during shifts).

---

## Malware

- **Q**: Compare and contrast viruses, worms, and trojans in terms of propagation and impact.  
  **A**: Viruses require user action to spread, worms spread autonomously, and trojans disguise themselves as legitimate programs.

- **Q**: Explain the lifecycle of a virus and provide an example of each phase in action.  
  **A**: Dormant (inactive), Propagation (spreading), Triggering (activation), Execution (payload, e.g., file deletion).

- **Q**: Discuss the evolution of ransomware and how modern defenses mitigate these threats.  
  **A**: Early ransomware used simple encryption; modern ransomware uses advanced encryption and exfiltration. Defenses include backups and endpoint security.

- **Q**: What makes Advanced Persistent Threats (APTs) challenging to detect and prevent?  
  **A**: APTs are stealthy, target-specific, and use multiple attack vectors over a long time.

- **Q**: Design a hypothetical scenario illustrating the impact of a malware attack on a critical infrastructure system.  
  **A**: A worm disables SCADA systems in a power grid, causing widespread outages and cascading failures in transportation and healthcare.

---

## Denial of Service (DoS)

- **Q**: Explain how a SYN flood attack works and why it is effective.  
  **A**: A SYN flood sends incomplete connection requests, overwhelming server resources and preventing legitimate access.

- **Q**: Compare DoS and DDoS attacks. How do their mitigation strategies differ?  
  **A**: DDoS involves multiple attackers, requiring distributed defenses like CDN and traffic scrubbing, while DoS can often be mitigated with firewalls.

- **Q**: Discuss the potential legal and ethical implications of DoS mitigation techniques, such as IP blacklisting.  
  **A**: IP blacklisting may block legitimate users, raising ethical concerns about access rights and potential overreach.

---

## Database Security

- **Q**: Why is it critical to use prepared statements in database queries? Compare them to unparameterized queries.  
  **A**: Prepared statements prevent SQL injection by safely handling user inputs, unlike unparameterized queries which directly execute user input.

- **Q**: How does database auditing contribute to overall security?  
  **A**: Auditing tracks changes and access, helping detect unauthorized actions and ensuring compliance with regulations.

- **Q**: What are the differences between encryption at rest and encryption in transit for database security?  
  **A**: Encryption at rest protects stored data; encryption in transit secures data during transmission.

---

## Operating System Security

- **Q**: Explain the role of sandboxing in operating system security. Provide an example of its application.  
  **A**: Sandboxing isolates processes to prevent unauthorized access, e.g., running web browsers in a secure container.

- **Q**: Compare ACLs and capability-based security in operating systems.  
  **A**: ACLs define permissions per resource, while capabilities define access per user or process.

- **Q**: Why are buffer overflows considered a critical security vulnerability? How can modern operating systems prevent them?  
  **A**: They allow arbitrary code execution. Prevention includes stack canaries, ASLR, and bounds checking.

---

## Intrusion Detection

- **Q**: Compare anomaly-based and signature-based intrusion detection systems. What are the advantages and disadvantages of each?  
  **A**: Anomaly-based detects unknown attacks but has high false positives. Signature-based is precise but misses new attack patterns.

- **Q**: What role does machine learning play in modern intrusion detection systems?  
  **A**: Machine learning helps detect complex, evolving attack patterns by analyzing large datasets.

- **Q**: Discuss the concept of a honeypot and its role in intrusion detection.  
  **A**: A honeypot is a decoy system designed to attract attackers and gather intelligence on their methods.

---

This set should provide more challenging content to help deepen your understanding. Let me know if you’d like to expand on any section or add additional questions! 
