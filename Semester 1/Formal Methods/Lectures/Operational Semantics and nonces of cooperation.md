### Understanding PEPA's Operational Semantics and Cooperation

---

#### **1. Plotkin-Style Structured Operational Rules**

- **Plotkin-Style Rules**:
  - These rules use a "small-step semantics" approach, breaking the system behavior into incremental steps.
  - Time isn't explicitly represented; it's assumed each activity requires some time.

- **Inference Rules**:
  - The operational rules are read as:
    - "If the transitions above the line hold, then the transition below the line can be inferred."

---

#### **2. Prefix, Constant, Choice, and Hiding Rules**

##### **Prefix Rule**:
For a prefix activity:
$$
(\alpha, r).P \xrightarrow{\alpha, r} P
$$
- The process can transition to **P** by performing action **\(\alpha\)** at rate **\(r\)**.

---

##### **Constant Rule**:
For a constant definition \( A \overset{\text{def}}{=} P \):
$$
P \xrightarrow{\alpha, r} P' \quad \Rightarrow \quad A \xrightarrow{\alpha, r} P'
$$
- The constant behaves as its definition.

---

##### **Choice Rule**:
For two components \(P\) and \(Q\) with a choice:
$$
P \xrightarrow{\alpha, r} P' \quad \Rightarrow \quad P + Q \xrightarrow{\alpha, r} P'
$$
$$
Q \xrightarrow{\alpha, r} Q' \quad \Rightarrow \quad P + Q \xrightarrow{\alpha, r} Q'
$$
- Either **P** or **Q** can proceed, depending on which can perform action **\(\alpha\)**.

---

##### **Hiding Rule**:
For a hiding operator:
1. If \(\alpha \notin L\):
$$
P \xrightarrow{\alpha, r} P' \quad \Rightarrow \quad P / L \xrightarrow{\alpha, r} P' / L
$$
2. If \(\alpha \in L\):
$$
P \xrightarrow{\alpha, r} P' \quad \Rightarrow \quad P / L \xrightarrow{\tau, r} P' / L
$$
   - Actions in **L** are hidden (converted to \(\tau\)).

---

#### **3. Cooperation Rules**

##### **Cooperation (Action \(\alpha \notin L\))**:
If action \(\alpha\) isn't in the cooperation set **L**, both components act independently:
$$
P \xrightarrow{\alpha, r} P' \quad \Rightarrow \quad P \bowtie_L Q \xrightarrow{\alpha, r} P' \bowtie_L Q
$$
$$
Q \xrightarrow{\alpha, r} Q' \quad \Rightarrow \quad P \bowtie_L Q \xrightarrow{\alpha, r} P \bowtie_L Q'
$$

---

##### **Cooperation (Action \(\alpha \in L\))**:
When \(\alpha \in L\), \(P\) and \(Q\) must synchronize:
$$
P \xrightarrow{\alpha, r_1} P' \quad Q \xrightarrow{\alpha, r_2} Q' \quad \Rightarrow \quad P \bowtie_L Q \xrightarrow{\alpha, r} P' \bowtie_L Q'
$$
Where:
$$
r = \min(r_\alpha(P), r_\alpha(Q))
$$
- The rate is the slower of the two apparent rates, as both components need to cooperate.

---

#### **4. Cooperation and Shared Activities**

- **Shared Action Rate**:
  - The apparent rate of a shared action \(\alpha\) is determined by the slower of the two apparent rates from **P** and **Q**.
  
- **Bounded Capacity**:
  - PEPA assumes components cannot be forced to operate faster by cooperation; hence, the cooperation rate is limited by the slower participant.

- **Example**:
  - **P** and **Q** cooperate with respective rates \(r_1\) and \(r_2\):
    $$
    \text{Probability of } \alpha = \frac{r_1}{r_\alpha(P)} \cdot \frac{r_2}{r_\alpha(Q)}
    $$

---

#### **5. Multi-Way Cooperation**

- PEPA supports multi-way cooperation, where three or more components synchronize on shared actions.
- Example:
$$
((\alpha, r).P \bowtie_\alpha (\alpha, s).Q) \bowtie_\alpha (\alpha, t).R
$$
  - All three components **P, Q, R** must synchronize on **\(\alpha\)**.

##### **Behavioral Variations**:
1. **Example 1**:
   - **P** and **Q** compete to synchronize with **R**, creating contention for **\(\alpha\)**.

2. **Example 2**:
   - **P** and **Q** synchronize first, while **R** performs **\(\alpha\)** independently.

---

#### **6. Labelled Multi-Transition System**

##### **Definition**:
A labelled transition system is a triple \((S, T, \{ t \to \mid t \in T \})\):
- **S**: Set of states.
- **T**: Set of transition labels.
- \(t \to \subseteq S \times S\): A transition relation for each \(t \in T\).

A labelled multi-transition system is similar but recognizes multiple instances of a relation between states.

##### **PEPA as a Labelled Multi-Transition System**:
PEPA can be seen as a labelled multi-transition system \((C, Act, \{ (\alpha, r) \to \})\):
- **C**: Set of all components.
- **Act**: Set of all activities.
- \((\alpha, r) \to \subseteq C \times C\): Multi-transition relation from PEPA's operational semantics.

---

#### **7. Derivatives of a PEPA Component**

##### **One-Step Derivative**:
If \(P \xrightarrow{\alpha, r} P'\), then \(P'\) is a one-step derivative of \(P\).

##### **General Derivative**:
If (P \xrightarrow{\alpha_1, r_1} \dots \xrightarrow{\alpha_n, r_n} P'\), then \(P'\) is a derivative of \(P\).

##### **Derivative Set**:
The derivative set \(ds(P)\) is the smallest set of components such that:
1. If (P \overset{\text{def}}{=} P_0\), then \(P_0 \in ds(P)\).
2. If $$(P_i \in ds(P))and \ (P_i \xrightarrow{a} P_j)$$, then $$(P_j \in ds(P)).$$

##### **Interpretation**:
- The derivative set of \(P\) represents all reachable states of the system modeled by \(P\).
- Derivatives form the states of the labelled multi-transition system.

---

#### **8. Derivation Graph**

##### **Definition**:
The derivation graph \(D(P)\) is a directed multigraph where:
- **Nodes**: Derivative set \(ds(P)\).
- **Arcs**: Multiset of transitions \(A \subset ds(P) \times ds(P) \times Act\).

##### **Construction**:
1. Each node in \(D(P)\) corresponds to a derivative in \(ds(P)\).
2. Arcs indicate transitions, labeled by \(\alpha\) and \(r\).
3. The initial component \(P_0\) is the graph's initial node.

---

#### **9. Complete Set of Action Types**

##### **Definition**:
The complete set of action types \(\tilde{A}(P)\) is the union of action types in the derivation graph:
$$
\tilde{A}(P) = \bigcup_{P_i \in ds(P)} A(P_i)
$$

##### **Significance**:
This set defines all possible actions that the modeled system can perform, offering a holistic view of the component's behavior.

---

This extended explanation integrates additional foundational concepts from the PEPA framework for further clarity.
