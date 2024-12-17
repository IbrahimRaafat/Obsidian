# Formal Methods for System Verification: Labelled Multi-Transition Systems

## Example 1: Multiple Server Queue
- **Description:**
  - Queue with \( c \) servers, buffer capacity \( N > c \), arrival rate \( \lambda \), and service rate \( \mu \).
- **PEPA Model:**
  - \( Q_0 \def (accept, \lambda).Q_1 \)
  - \( Q_i \def (accept, \lambda).Q_{i+1} + (serve, i\mu).Q_{i-1} \) for \( 1 \leq i < c \).
  - \( Q_j \def (accept, \lambda).Q_{j+1} + (serve, c\mu).Q_{j-1} \) for \( c \leq j < N \).
  - \( Q_N \def (loss, \lambda).Q_N + (serve, c\mu).Q_{N-1} \).
- **Transition Diagram:**
  - Nodes \( Q_0, Q_1, \ldots, Q_N \) with transitions for \( accept, serve, \) and \( loss \).

---

## Example 2: Single Server Queue
- **Description:**
  - Queue with buffer capacity \( N \), arrival rate \( \lambda \), and service rate \( \mu \).
- **PEPA Model:**
  - **Server:** \( Server \def (serve, \mu).Server \).
  - **Buffer:** 
    - \( Buffer_0 \def (accept, \lambda).Buffer_1 \).
    - \( Buffer_i \def (accept, \lambda).Buffer_{i+1} + (serve, \top).Buffer_{i-1} \) for \( 1 \leq i < N \).
    - \( Buffer_N \def (serve, \top).Buffer_{N-1} \).
  - **Queue:** \( Queue_0 \def Buffer_0 \|_{\{serve\}} Server \).
- **Transition Diagram:**
  - Represents buffer states and server activities.

---

## Example 3: Simple Resource Usage
- **Description:**
  - Process requires a resource and completes a task after resource usage.
- **PEPA Model:**
  - \( Process \def (use, r_1).Process' \), \( Process' \def (task, r_2).Process \).
  - \( Resource \def (use, r_3).Resource' \), \( Resource' \def (update, r_4).Resource \).
  - \( System \def Process \|_{\{use\}} Resource \).
- **Transition Diagram:**
  - States linked via \( use, task, \) and \( update \).

---

## Exercise 1: Web Server
- **Description:**
  - Browser cooperates with server to handle requests:
    - Remote server access: \( p \).
    - Local cache access: \( 1 - p \).
- **PEPA Model:**
  - \( Server \def (get, \top).(download, \mu).(rel, \top).Server \).
  - \( Browser \def (display, p\lambda).(get, g).(download, \top).(rel, r).Browser \)
    \( + (display, (1-p)\lambda).(cache, m).Browser \).
  - \( WEB \def Browser \|_L Server \) with \( L = \{get, download, rel\} \).
- **Derivation Graphs:**
  - Server, browser, and combined WEB transitions defined by activities.

---

## Exercise 2: Two Browsers
- **Modification:**
  - Browser interactions with the local cache hidden (\( Browser' = Browser/\{cache\} \)).
  - \( WEB' \def (Browser' || Browser') \|_L Server \).
- **Activity Multiset:**
  - Combines activities for both browsers and server.
- **Apparent Rate:**
  - \( r_{display}(WEB') = 2\lambda \).

---

## Exercise 3: Derivative Check
- **Task:** Verify if \( WEB'' \) is a derivative of \( WEB \).
- **Result:** \( WEB'' \notin ds(WEB) \) since \( Browser \) lacks cooperation constructors.

---

## Exercise 4: Producer-Consumer System
- **PEPA Model:**
  - \( Producer \def (put, \lambda).Producer \).
  - \( Consumer \def (get, \mu).Consumer \).
  - \( Buffer \def (put, \top).(get, \top).Buffer \).
  - \( System \def Producer \|_{\{put\}} (Buffer \|_{\{get\}} Consumer || Buffer \|_{\{get\}} Consumer) \).
- **Key Properties:**
  - Current action types: \( A(System) = \{put\} \).
  - Multiset: \( Act(System) = \{(put, \lambda/2), (put, \lambda/2)\} \).

---

## Exercise 5: Parallel Processes
- **PEPA Model:**
  - \( P_1 \def (start, r_1).P_2 \), \( P_2 \def (run, r_2).P_3 \), \( P_3 \def (stop, r_3).P_1 \).
- **Derivative Set:**
  - Includes all combinations of \( P_1, P_2, \) and \( P_3 \) in parallel.
- **Apparent Rates:**
  - \( r_{run}(P_2 || P_2) = 2r_2 \), \( r_{run}(P_2 \|_{\{run\}} P_2) = r_2 \).

**Reference:** Formal Methods for System Verification, Sabina Rossi
