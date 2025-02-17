# Formal Methods for System Verification: System Descriptions in PEPA

## Example 1: Multiple Server Queue
- **Description:**
  - Queue with \( c \) servers, buffer capacity \( N > c \), arrival rate \( \lambda \), and service rate \( \mu \).
  - When queue is full, customers are lost at rate \( \lambda \).
  - Serve activity rate:
    - \( i\mu \) if \( i < c \).
    - \( c\mu \) if \( c \leq i \leq N \).
- **PEPA Model:**
  - \( Q_0 \def (accept, \lambda).Q_1 \)
  - \( Q_i \def (accept, \lambda).Q_{i+1} + (serve, i\mu).Q_{i-1} \) for \( 1 \leq i < c \).
  - \( Q_j \def (accept, \lambda).Q_{j+1} + (serve, c\mu).Q_{j-1} \) for \( c \leq j < N \).
  - \( Q_N \def (loss, \lambda).Q_N + (serve, c\mu).Q_{N-1} \).

---

## Example 2: Single Server Queue
- **Description:**
  - Single server queue with capacity \( N \), arrival rate \( \lambda \), and service rate \( \mu \).
  - Arrivals are suspended when the queue is full.
- **PEPA Model:**
  - **Server:** \( Server \def (serve, \mu).Server \).
  - **Buffer:**
    - \( Buffer_0 \def (accept, \lambda).Buffer_1 \).
    - \( Buffer_i \def (accept, \lambda).Buffer_{i+1} + (serve, >).Buffer_{i-1} \) for \( 1 \leq i < N \).
    - \( Buffer_N \def (serve, >).Buffer_{N-1} \).
  - **Queue:** \( Queue_0 \def Buffer_0 \mathbin{\|_{\{serve\}}} Server \).

---

## Example 3: Resource Usage (Two Components)
- **Description:**
  - Task involves two stages: using a resource and independent processing.
  - Resource undergoes a reset after each use.
- **PEPA Model:**
  - \( Process \def (use, r_1).(task, r_2).Process \).
  - \( Resource \def (use, r_3).(update, r_4).Resource \).
  - \( System \def Process \mathbin{\|_{\{use\}}} Resource \).

---

## Example 4: Resource Usage (Single Component)
- **Description:**
  - Single-component model combining tasks and updates.
- **PEPA Model:**
  - \( System' \def (use, r_{13}).((task, r_2).(update, r_4).System' + (update, r_4).(task, r_2).System') \),
    where \( r_{13} = \min(r_1, r_3) \).

---

## Example 5: Resource Usage (Multiple Components)
- **Description:**
  - Extends the system to include multiple independent processes competing for the resource.
- **PEPA Model:**
  - \( System'' \def (Process || Process) \mathbin{\|_{\{use\}}} Resource \).

---

## Example 6: PC LAN with Token Ring
- **Description:**
  - LAN with four PCs in a token ring communication system.
  - Token visits nodes sequentially, enabling transmission of at most one packet per visit.
  - Packet generation rate \( \lambda \), transmission rate \( \mu \), token passing rate \( \omega \).
- **PEPA Model:**
  - **PCs:**
    - \( PC_{i0} \def (arrive, \lambda).PC_{i1} + (walkon_{i+1}, \omega).PC_{i0} + (walk_{i+1}, \omega).PC_{i0} \).
    - \( PC_{i1} \def (transmit_i, \mu).PC_{i0} + (walk_{i+1}, \omega).PC_{i1} \).
  - **Token:**
    - \( Token_i \def (walkon_{i+1}, \omega).Token_{i+1} + (transmit_i, \mu).(walk_{i+1}, \omega).Token_{i+1} \).
  - **LAN:**
    - \( LAN \def (PC_{10} || PC_{20} || PC_{30} || PC_{40}) \mathbin{\|_L} Token_1 \),
      where \( L = \{walk, walkon, transmit\} \).

**Reference:** Formal Methods for System Verification, Sabina Rossi
