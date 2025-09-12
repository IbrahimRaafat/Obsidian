First exercise:
Given the 0x1 level of crackme assembly code,find the password explaining the steps you have performed.

Second exercise:
Open question in which you explain the MPC(Multi Party Communication) and the "millionaire's" problem example.

### Third exercise(open question):
Discuss about the I-voting system,in particular the steps and the keys used to voting and their security aspects.
#### Answer: 
### Steps in the Estonian I-Voting System

1. **Voter prepares the vote**
    
    - The voter selects a candidate on their device.
        
    - The vote is **encrypted with the Election Authority’s public key**.  
        → ensures only election servers can decrypt it.
        
2. **Digital signing by the voter**
    
    - The encrypted ballot is **signed with the voter’s private key** from their national eID card or Mobile-ID.  
        → ensures authenticity: proves the ballot came from a legitimate voter and wasn’t altered in transit.
        
3. **Sending the vote**
    
    - The signed, encrypted vote is sent to the **Vote Forwarding Server (VFS)**.
        
4. **Authentication**
    
    - The voter is authenticated by verifying their signature using their **eID public key**.  
        → ensures eligibility (only valid voters can vote).
        
5. **Vote storage and cleansing**
    
    - Ballots are moved to the **Vote Storage Server**.
        
    - Identity information is stripped so the ballot becomes anonymous.
        
6. **Transfer to counting system**
    
    - Ballots are stored on physical media (e.g., DVD).
        
    - These are delivered to an **air-gapped (offline) Vote Counting App server** for decryption and tallying.
        
7. **Results and audit**
    
    - Votes are decrypted and counted.
        
    - Results are published and auditing is performed to ensure transparency.
        

---

### Keys Used

- **Election Authority’s Public Key**
    
    - Used to encrypt the ballot.
        
    - Only the authority’s **private key** (kept offline) can decrypt.
        
    - Security aspect: protects vote secrecy during transmission and storage.
        
- **Voter’s Private Key (eID / Mobile-ID)**
    
    - Used to sign the encrypted ballot.
        
    - The corresponding **public key** verifies the signature.
        
    - Security aspect: ensures the vote really came from that voter (non-repudiation, authenticity).
        

---

### Security Aspects

- **Anonymity**: Identities are removed before counting; even though the vote is signed, the link to the voter is stripped off after authentication.
    
- **Integrity**: Signatures ensure votes cannot be altered without detection.
    
- **Eligibility**: Only authenticated voters can submit ballots.
    
- **Un-reusability**: If a voter votes multiple times online, only the last electronic ballot counts; if they vote physically, the paper ballot overrides the electronic one.
    
- **Fairness**: Votes are only decrypted and counted after the election closes, preventing partial results from leaking.
    
- **Auditability**: Logs, DVD transfer, and independent audits help verify correctness.
    

---

In short:

- **Encryption with election public key → confidentiality.**
    
- **Signature with voter private key → authenticity and integrity.**
    
- **Stripping identities before counting → anonymity.**
Fourth exercise:
Give the "mod_exp" code and its control flow graph transform it four times and for each one use a different obfuscation technique.

Fifth exercise:
Quiz-like with eight multiple-choice questions in which only one is correct and then you also explain why (you can do a very brief and short explaination)
For example,some of these questions contains a false statement and then you can say why the others are true;

The first one was about the physical security attacks in which one is false:

The five definitions,except the third one are written in the same way as presented in the corresponding slides;

1)Phishing 
2)Smishing
3)Dumpster diving (is the wrong one since it was written that the attacker search through the computer's recycle bin)
4)Tailgating
5)Spear phishing

Another question was about GDPR and in this case you need to choose what is not compliant in the GDPR which was the right to not be tracked by GPS.

Also there was a question on AI act in which you have to choose what situation is denoted as very risky for involving the AI, which was on law interpretation and law enforcement.

A question asking which one of these techniques provides code authorship, that is watermarking

Another question involved ROP, containing a false statement which was ROP is not turing-complete.

Which of the following obfuscations is NOT an anti-disassembly technique?
 
A. Dead Code insertion 
B. Opaque predicates 
C. Branch Functions Encoding 
D. Irregular Code insertion 
E. Self-modifying code

the correct one is the E.

A question about malwares finding the wrong statement.

The last one was which provides code integrity,i think,which was remote attestation