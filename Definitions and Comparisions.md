# Important Definitions and Comparisons

## Key Definitions

- **Confidentiality**: Ensuring that sensitive information is not accessed by unauthorized users.
- **Integrity**: Guaranteeing the accuracy and consistency of data over its lifecycle.
- **Availability**: Ensuring systems and data are accessible to authorized users when needed.
- **Authentication**: Verifying the identity of a user or entity (e.g., username and password).
- **Authorization**: Determining what actions or resources an authenticated user is allowed to access (e.g., file permissions).
- ==**Non-Repudiation**: Ensuring that a sender cannot deny sending a message or performing an action (e.g., digital signatures).==
- **Access Control**: Mechanisms to regulate access to systems and resources based on policies and roles.
- **Malware**: Malicious software designed to disrupt, damage, or gain unauthorized access to systems.
- **Denial of Service (DoS)**: An attack that overwhelms a system to render it inaccessible to legitimate users.
- ==**Intrusion Detection System (IDS)**: Monitors network or system activity to detect malicious activities or policy violations.==
- **Cryptography**: The practice of securing communication and data through encryption, hashing, and digital signatures.

## Security Design Principles

- **Least Privilege**: Users and systems should have the minimum access necessary to perform tasks.
- **Fail-Safe Defaults**: Access should be denied by default unless explicitly permitted.
- **Complete Mediation**: Every access request should be checked against access control mechanisms.
- **Open Design**: Security mechanisms should not rely on secrecy of the design but on secrecy of the keys.
- **Separation of Privilege**: Critical actions should require multiple independent conditions to be met (e.g., multi-factor authentication).
- **Defense in Depth**: Layered security measures to mitigate risks even if one layer fails.
- **Psychological Acceptability**: Security mechanisms should be easy to use and not interfere with user workflows.

---

## Comparisons

### Authentication vs Authorization
- **Authentication**: Verifies identity (e.g., logging in with a username and password).  
  **Example**: "Prove you are Alice."
- **Authorization**: Determines access permissions (e.g., allowing read or write access).  
  **Example**: "Alice can access folder X."

---

### Confidentiality vs Integrity vs Availability (CIA Triad)
- **Confidentiality**: Ensures data is private (e.g., encryption).  
  **Example**: Secure messages with AES encryption.
- **Integrity**: Ensures data accuracy and trustworthiness (e.g., hashing).  
  **Example**: Hashing a message with SHA-256.
- **Availability**: Ensures systems are operational when needed (e.g., redundancy).  
  **Example**: Using a load balancer for uptime.

---

### Symmetric vs Asymmetric Cryptography
- **Symmetric Cryptography**: Uses one key for encryption and decryption.  
  **Example**: AES.
- **Asymmetric Cryptography**: Uses a public key for encryption and a private key for decryption.  
  **Example**: RSA.

---

### Malware Types Comparison
| **Type**       | **Propagation**       | **Impact**                           |
|-----------------|-----------------------|--------------------------------------|
| **Virus**      | Requires user action  | Infects files or systems            |
| **Worm**       | Autonomous            | Exploits network vulnerabilities     |
| **Trojan**     | Disguised as software | Executes malicious tasks             |
| **Ransomware** | Direct installation   | Encrypts files and demands payment   |

---

### DAC vs MAC vs RBAC vs ABAC
| **Access Control Model** | **Description**                                                                | **Example**                 |
|---------------------------|--------------------------------------------------------------------------------|-----------------------------|
| **DAC**                  | Resource owners decide access (flexible but less secure).                      | File sharing in Windows.    |
| **MAC**                  | Centralized policy controls access (strict but inflexible).                    | Military clearance levels.  |
| **RBAC**                 | Access based on predefined roles.                                              | Admin, User, Guest roles.   |
| **ABAC**                 | Access based on attributes like time, location, and device (complex but robust).| Hospital shift access.      |

---

### DoS vs DDoS
- **DoS (Denial of Service)**: A single-source attack that overwhelms a system.  
  **Example**: SYN flood attack.
- **DDoS (Distributed Denial of Service)**: A coordinated attack from multiple sources.  
  **Example**: Botnet attack targeting a website.

---

### IDS Types: Host-Based vs Network-Based
| **Type**        | **Description**                                      | **Advantages**             | **Disadvantages**         |
|------------------|------------------------------------------------------|-----------------------------|----------------------------|
| **Host-Based**   | Monitors activity on individual systems.             | Precise; detects local threats. | Limited to specific hosts. |
| **Network-Based**| Monitors traffic across a network.                   | Covers multiple devices.     | Prone to encrypted threats.|

---

### Bell-LaPadula vs Biba Models
| **Model**            | **Focus**                | **Key Rules**                             |
|-----------------------|--------------------------|-------------------------------------------|
| **Bell-LaPadula**     | Confidentiality          | No Read Up, No Write Down.                |
| **Biba**              | Integrity               | No Write Up, No Read Down.                |

---

### Anomaly-Based IDS vs Signature-Based IDS
- **Anomaly-Based IDS**: Detects deviations from normal behavior.  
  **Advantages**: Detects unknown threats.  
  **Disadvantages**: High false positives.
- **Signature-Based IDS**: Matches patterns of known attacks.  
  **Advantages**: Low false positives.  
  **Disadvantages**: Cannot detect novel threats.

---

### SQL Injection Prevention Techniques
- **Parameterized Queries**: Avoids executing malicious input as code.  
  **Example**: Use prepared statements instead of raw SQL.
- **Input Validation**: Filters user input to remove dangerous characters.  
  **Example**: Reject input with unexpected characters like `;`.

---

This document now includes all major definitions and comparisons to strengthen your understanding. Let me know if you need further enrichment! 
