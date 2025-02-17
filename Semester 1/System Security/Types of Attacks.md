# Types of Attacks, Security, and Access Control

## Types of Attacks

### Malware
- **Virus**: Infects files and requires user interaction to spread.
- **Worm**: Spreads automatically, exploiting network vulnerabilities.
- **Trojan Horse**: Disguises as legitimate software but performs malicious actions.
- **Ransomware**: Encrypts files and demands payment for decryption.
- **Spyware**: Gathers sensitive information without user knowledge.
- **Advanced Persistent Threat (APT)**: Long-term, stealthy attack targeting specific entities.

### Denial of Service (DoS)
- **SYN Flood**: Exploits the TCP handshake process to overwhelm a server.
- **UDP Flood**: Sends a high volume of UDP packets to consume bandwidth.
- **Application-Layer DoS**: Overloads application-specific resources (e.g., HTTP requests).

### Intrusion Detection
- **False Positive**: Legitimate activity flagged as malicious.
- **False Negative**: Malicious activity goes undetected.
- **Honeypot**: A decoy system to attract attackers and study their methods.

---

## Types of Security

### Physical Security
- Protects hardware, facilities, and personnel.
- Examples: Security cameras, biometric access control.

### Network Security
- Protects data and resources in a network.
- Examples: Firewalls, VPNs, Intrusion Detection Systems (IDS).

### Operating System Security
- Protects against vulnerabilities in the OS.
- Examples: Sandboxing, patch management, secure device drivers.

### Database Security
- Ensures data confidentiality, integrity, and availability in databases.
- Examples: SQL injection prevention, database encryption, auditing.

---

## Access Control Models

### Discretionary Access Control (DAC)
- Access controlled by resource owners.
- Flexible but prone to human error.

### Mandatory Access Control (MAC)
- Access controlled by a central authority.
- Enforces strict security levels (e.g., Top Secret).

### Role-Based Access Control (RBAC)
- Access based on predefined roles (e.g., Admin, User).
- Simplifies management in large systems.

### Attribute-Based Access Control (ABAC)
- Access based on attributes (e.g., location, device).
- Highly flexible for complex policies.

### Bell-LaPadula Model
- **No Read Up**: Prevents reading data at a higher classification level.
- **No Write Down**: Prevents writing data to a lower classification level.
