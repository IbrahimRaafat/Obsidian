# Lecture 4: Distributed Architectures

## Key Updates
- **Project**:
  - Final task: implement one monolithic and one distributed architecture.
  - Deliverables:
    - GitHub repository with code history.
    - Architecture description and deployment setup (e.g., Docker Compose or Kubernetes).
  - **Deadline**: January 13th (before the written exam).

- **Schedule**:
  - Nov. 14: Lab. 3
  - Nov. 16: Google DevFest
  - Nov. 28: Invited lecture by Unox ([Link](https://www.unox.com/us_us/)).
  - Dec. 5: Invited lecture by Gianluca Caiazza ([Zamperla Project](https://www.zamperla.com/)).

---

## Distributed Architecture Overview

### Evolution from Monolithic to Distributed
- **Monolithic**:
  - Single block of code (e.g., Ball of Mud, Layered, Pipeline, Microkernel).
  - Conceptually runs on one machine; physically can be replicated.
- **Distributed**:
  - Multiple networked machines.
  - Architectures like Service-Based, Event-Driven, and Microservices.

---

### Communication in Distributed Systems
- **APIs**:
  - Interface for software components to communicate (e.g., REST APIs).
  - Exchange formats: JSON, XML, etc.
- **REST**:
  - Stateless protocol; all information is transferred in messages.
  - Pros: Decoupling and independence.
  - Cons: High network bandwidth requirements.

---

## Architectural Styles in Distributed Systems

### 1. Service-Based Architecture
- **Definition**:
  - Splits back-end logic into independent services.
  - Services share a common database.
- **Variations**:
  - Service-based UI or database.
  - Use of API layers for coordination.
- **Characteristics**:
  - Deployability: ⋆⋆⋆⋆
  - Reliability: ⋆⋆⋆⋆
  - Scalability: ⋆⋆⋆
  - Modularity: ⋆⋆⋆⋆

---

### 2. Event-Driven Architecture
- **Definition**:
  - Asynchronous communication via events/messages.
  - Components: Producer, Broker, Consumer.
- **Topologies**:
  - **Broker**:
    - Messages flow between producers and consumers.
  - **Mediator**:
    - Central mediator coordinates event processing.
- **Characteristics**:
  - Elasticity: ⋆⋆⋆
  - Scalability: ⋆⋆⋆⋆⋆
  - Fault Tolerance: ⋆⋆⋆⋆⋆

---

### 3. Microservices Architecture
- **Definition**:
  - Highly decoupled, small services handling single purposes.
  - Services have independent databases.
- **Characteristics**:
  - Scalability: ⋆⋆⋆⋆⋆
  - Modularity: ⋆⋆⋆⋆⋆
  - Deployability: ⋆⋆⋆⋆
- **Key Features**:
  - Granularity: Domain-driven design and bounded contexts.
  - Data isolation.
  - Supports both synchronous (e.g., REST) and asynchronous communication.

---

## Communication in Distributed Systems

### Synchronous vs Asynchronous
- **Synchronous**:
  - Immediate response (e.g., REST APIs).
  - Simpler but prone to bottlenecks.
- **Asynchronous**:
  - Events/messages processed independently.
  - Enhances scalability and fault tolerance.

### Patterns
1. **Choreography**:
   - Decentralized, event-driven interactions.
2. **Orchestration**:
   - Centralized coordinator manages service interactions.

---

## Summary of Architectural Styles

| Style               | Deployability | Scalability | Reliability | Modularity | Simplicity | Testability | Overall Cost |
|---------------------|---------------|-------------|-------------|------------|------------|-------------|--------------|
| Service-Based       | ⋆⋆⋆⋆         | ⋆⋆⋆         | ⋆⋆⋆⋆       | ⋆⋆⋆⋆      | ⋆⋆⋆        | ⋆⋆⋆⋆        | ⋆⋆⋆⋆         |
| Event-Driven        | ⋆⋆⋆          | ⋆⋆⋆⋆⋆      | ⋆⋆⋆        | ⋆⋆⋆⋆      | ⋆          | ⋆⋆          | ⋆⋆⋆          |
| Microservices       | ⋆⋆⋆⋆         | ⋆⋆⋆⋆⋆      | ⋆⋆⋆⋆       | ⋆⋆⋆⋆⋆     | ⋆          | ⋆⋆⋆⋆        | ⋆            |

---

## References
- *Fundamentals of Software Architecture*:
  - Service-Based Architecture: Chapter 13.
  - Event-Driven Architecture: Chapter 14.
  - Microservices: Chapter 17.
