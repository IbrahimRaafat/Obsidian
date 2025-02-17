# Solutions for Security Exam Questions

---

## **Exam 1: January 14, 2021**

### **Exercise 1: Operating System Security**

1. **What is an attack from below in the context of operating system security?**  
   **Answer**: An attack from below occurs when a compromised lower layer, such as firmware or hardware, undermines the security of the operating system by bypassing OS-level protections.

2. **What aspects are typically considered when planning operating system security?**  
   **Answer**:  
   - Access control for files and processes.  
   - Authentication and logging for user activity.  
   - Regular updates and patches to mitigate vulnerabilities.  
   - Least privilege principle to restrict unnecessary permissions.

3. **Discuss the importance of the least privilege principle in operating system security. Provide examples.**  
   **Answer**:  
   The least privilege principle ensures that users and processes operate with only the permissions required for their tasks.  
   Example: A web server running as a non-root user cannot modify system files if compromised.

4. **Why are device drivers problematic concerning security?**  
   **Answer**: Device drivers often run with high privileges, making them a prime target for attackers. A compromised driver can lead to privilege escalation and system compromise.

---

### **Exercise 2: Network Security**

1. **How does an ARP spoofing attack enable packet interception on a switched LAN?**  
   **Answer**: ARP spoofing involves sending fake ARP replies to associate the attacker’s MAC address with the victim’s IP address, allowing the attacker to intercept packets.

2. **What is a security protocol? What properties does it provide?**  
   **Answer**: A security protocol ensures secure communication by providing confidentiality, integrity, and authentication. It uses cryptographic techniques like encryption and hashing.

3. **Illustrate an example of a security protocol.**  
   **Answer**: TLS ensures secure communication by encrypting traffic and authenticating the server with a digital certificate. It protects against eavesdropping and tampering.

4. **What is a VPN and how does it secure communication?**  
   **Answer**: A VPN creates an encrypted tunnel between the client and server, ensuring data confidentiality and integrity even when applications do not use cryptography.

---

### **Exercise 3: C Program Vulnerability**

1. **Why is this program unsafe? What vulnerability is present?**  
   **Answer**: It uses `gets(buffer)`, which does not limit input size, leading to a buffer overflow vulnerability.

2. **Describe an attack that would jump to an arbitrary address in memory.**  
   **Answer**: An attacker overflows the buffer, overwriting the return address with the desired memory address to execute arbitrary code.

3. **Explain what stack canary is and how it prevents the attack.**  
   **Answer**: A stack canary places a random value before the return address. If the canary is modified during an overflow, the program detects the corruption and aborts.

4. **Suggest a fix for the program.**  
   **Answer**: Replace `gets(buffer)` with `fgets(buffer, sizeof(buffer), stdin)` to prevent overflow by limiting input size.

---

## **Exam 2: January 28, 2021**

### **Exercise 1: C Program Vulnerability**

1. **Why is this program unsafe? What vulnerability is present?**  
   **Answer**: The program uses `gets(buffer)` without limiting input size, leading to a buffer overflow vulnerability.

2. **Describe an attack to display the content of `sec.txt`.**  
   **Answer**: An attacker overflows the `buffer` variable to overwrite the adjacent `name` variable with `"sec.txt"`. This causes the program to display the contents of `sec.txt`.

3. **Explain what stack canary is and why it does not prevent this attack.**  
   **Answer**: A stack canary detects buffer overflow targeting the return address. However, it does not protect adjacent variables like `name` from being overwritten.

4. **Suggest a fix for the program.**  
   **Answer**: Use `fgets(buffer, sizeof(buffer), stdin)` to limit input size and prevent buffer overflow.

---

### **Exercise 2: Denial of Service (DoS)**

1. **What is a DoS attack? What resources does it target?**  
   **Answer**: A DoS attack overwhelms resources such as network bandwidth, CPU, or memory to deny service to legitimate users.

2. **What security property is compromised by DoS? Provide examples.**  
   **Answer**: Availability. Example: An e-commerce website is unable to process orders during a DDoS attack.

3. **Illustrate a flooding attack and the role of source address spoofing.**  
   **Answer**: In a SYN flood attack, an attacker sends numerous connection requests with fake source IPs. This overwhelms the server and prevents legitimate connections.

4. **List defenses against DoS attacks.**  
   **Answer**:  
   - Rate limiting to limit traffic per IP.  
   - Firewalls to filter malicious requests.  
   - Load balancers and CDNs to distribute traffic.

---

### **Exercise 3: Access Control**

1. **Briefly describe DAC, MAC, RBAC, and ABAC policies.**  
   **Answer**:  
   - **DAC**: Resource owners control access permissions.  
   - **MAC**: Access is controlled by centralized policies and security labels.  
   - **RBAC**: Access is based on predefined roles.  
   - **ABAC**: Access decisions are made based on user attributes (e.g., location, time).

2. **Why do MAC policies mitigate malware infections?**  
   **Answer**: MAC enforces strict access controls that malware cannot override, limiting its ability to compromise sensitive data.

3. **Illustrate the Bell-LaPadula (BLP) policy.**  
   **Answer**: BLP enforces confidentiality by ensuring:  
   - **No Read Up**: Users cannot access data at higher security levels.  
   - **No Write Down**: Users cannot write data to lower security levels.

4. **Provide a definition of BLP using ABAC.**  
   **Answer**:  
   - `can_read(s, o)` if `subject.security_level ≤ object.security_level`.  
   - `can_write(s, o)` if `subject.security_level ≥ object.security_level`.

---

## **Exam 3: June 30, 2021**

### **Exercise 1: Access Control**

1. **What is the purpose of Access Control?**  
   **Answer**: Ensures that only authorized users or processes can access specific resources.

2. **Describe DAC, MAC, RBAC, and ABAC policies.**  
   **Answer**:  
   - **DAC**: Resource owners define access.  
   - **MAC**: Centralized policies enforce strict controls.  
   - **RBAC**: Access is role-based.  
   - **ABAC**: Access decisions depend on user attributes.

3. **Why do MAC policies mitigate vulnerabilities?**  
   **Answer**: MAC restricts access based on predefined policies, limiting the damage from compromised processes.

4. **What access control policy is most appropriate for an application regulating user type, resource type, and time?**  
   **Answer**: ABAC, as it provides fine-grained access control based on multiple attributes.

---

### **Exercise 2: C Program Vulnerability**

1. **Why is this program unsafe?**  
   **Answer**: It uses `gets(buffer)` without input size validation, causing a buffer overflow vulnerability.

2. **Describe an attack to jump to `0x0000000012345678`.**  
   **Answer**: Overflow the buffer to overwrite the return address with `0x0000000012345678`, redirecting execution.

3. **Discuss security mechanisms to prevent the attack.**  
   **Answer**:  
   - Stack canaries to detect buffer overflow.  
   - Address Space Layout Randomization (ASLR) to randomize memory addresses.  
   - Non-executable stack to block code execution.

4. **Provide a fix for the program.**  
   **Answer**: Replace `gets(buffer)` with `fgets(buffer, sizeof(buffer), stdin)`.

---

This document contains all solutions for the three exams in Markdown format. Copy it into your Obsidian vault for study and revision!
