## Key Updates
- **Schedule**:
  - Regular in-person lectures on Thursdays at 2 PM (Aula B).
  - Special sessions:
    - Nov. 14: Lab. 3
    - Nov. 19: Tuesday, 8:45 AM (Aula C)
    - Nov. 28: Invited lecture by Unox ([Link](https://www.unox.com/us_us/)).
    - Dec. 5: Invited lecture by Gianluca Caiazza ([Zamperla Project](https://www.zamperla.com/)).

- **Task 2**:
  - Submit a PDF defining the relevant architecture characteristics for your system.
  - Quantify the required levels for each characteristic.

---

## Monolithic Architectures Overview

### Key Concepts
- **Monolithic Architecture**:
  - Single deployment unit for all code.
  - Can include internal modular structures (e.g., libraries, artifacts).
  - Runs on a single machine, suitable for simple, self-contained systems.

- **Ball of Mud Architecture**:
  - No modularity, all components interdependent.
  - Easy to develop but hard to maintain, scale, or test.
  - Lacks architecture and is often used for quick-and-dirty tasks.

---

### Transition to Modular Monoliths
- Evolution towards encapsulation:
  - Object-Oriented Programming (OOP) introduced encapsulation and information hiding.
  - Technologies like Java modules (since 2017) further support modularity.

- **Modern Monoliths**:
  - Combine internal modules with clear boundaries.
  - Tools like Maven manage module artifacts.

---

## Architectural Patterns in Monoliths

### 1. Layered (n-Tier) Architecture
- **Definition**:
  - Application split into horizontal layers (e.g., front-end, back-end, database).
  - Supports modularity and team specialization.
- **Characteristics**:
  - Closed layers: Only communicate with the immediate lower layer.
  - Open layers: Allow communication between non-adjacent layers.
- **Common Use**:
  - Suitable for small to medium-sized applications.

---

### 2. Pipeline Architecture
- **Definition**:
  - Data flows through self-contained, stateless filters.
  - Filters perform specific tasks and pass the output downstream.
- **Types of Filters**:
  - Producers, transformers, testers, consumers.
- **Use Case**:
  - Common in data processing and scripting (e.g., bash scripts).

---

### 3. Microkernel Architecture
- **Definition**:
  - Core system with plugins that extend functionality.
  - Plugins are modular and communicate through a standardized API.
- **Key Features**:
  - Core system handles essential functionality.
  - Plugins add isolated, domain-specific features.
- **Examples**:
  - Eclipse IDE, product-based applications.

---

## Advantages and Challenges of Monoliths
- **Advantages**:
  - Simpler deployment and testing.
  - Easier to maintain for small teams and systems.
- **Challenges**:
  - Limited scalability and elasticity.
  - Increased complexity in large applications.

---

## Architecture Characteristics Ratings
### Ball of Mud Architecture
| Characteristic    | Rating |
|-------------------|--------|
| Deployability     | ⋆⋆     |
| Performance       | ⋆⋆⋆⋆⋆  |
| Modularity        | ⋆      |
| Simplicity        | ⋆      |
| Testability       | ⋆⋆     |
| Overall Cost      | ⋆⋆⋆⋆⋆  |

### Layered Architecture
| Characteristic    | Rating |
|-------------------|--------|
| Deployability     | ⋆      |
| Performance       | ⋆⋆     |
| Simplicity        | ⋆⋆⋆⋆⋆  |
| Testability       | ⋆⋆     |

### Microkernel Architecture
| Characteristic    | Rating |
|-------------------|--------|
| Deployability     | ⋆⋆⋆    |
| Modularity        | ⋆⋆⋆    |
| Simplicity        | ⋆⋆⋆⋆   |
| Testability       | ⋆⋆⋆    |

---

## References
- *Fundamentals of Software Architecture*:
  - Ball of Mud: Chapter 9.
  - N-Tier Architecture: Chapter 10.
  - Pipeline Architecture: Chapter 11.
  - Plugin Architecture: Chapter 12.
