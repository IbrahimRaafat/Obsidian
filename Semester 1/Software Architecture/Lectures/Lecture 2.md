# Lecture 2: Introduction to Software Architecture

## Key Updates
- **Schedule**:
  - In-person lectures: Thursdays at 2 PM (Aula B).
  - Special dates:
    - Nov. 14: Lab. 3
    - Nov. 19: Tuesday, 8:45 AM (Aula C)
    - Nov. 28: Invited lecture by Unox ([Link](https://www.unox.com/us_us/)).
    - Dec. 5: Invited lecture by Gianluca Caiazza ([Zamperla Project](https://www.zamperla.com/)).
- **Project Topic**: Hospital management (e.g., emergencies, patient records, doctor schedules).

## Software Architecture Overview
- **Skills Required**:
  - Technical depth and breadth.
  - System knowledge.
  - Soft skills: teamwork, problem-solving, leadership.

- **Career Path**:
  - Progression: Developer → Software Architect → CTO.
  - Architects need broader knowledge and decision-making abilities beyond coding.

- **Non-Functional Requirements (NFRs)**:
  - Referred to as *Architecture Characteristics* in the textbook.
  - Examples: Scalability, reliability, performance, elasticity, modularity.

## Architectural Characteristics
- **Criteria**:
  1. Specifies a non-domain design consideration.
  2. Influences structural aspects.
  3. Critical to application success.

- **Examples**:
  - **Operational**: Elasticity, performance, scalability, reliability.
  - **Structural**: Deployability, fault tolerance, simplicity, testability.
  - **Cross-cutting**: Modularity, evolutionary, overall cost.

- **Measurement**:
  - Use DevOps for iterative evaluation.
  - Define measurable targets and revise as needed.

## Modularity Metrics
- **Cohesion**:
  - Measures relatedness of module components.
  - High cohesion improves maintainability.

- **Coupling**:
  - Afferent: Incoming dependencies.
  - Efferent: Outgoing dependencies.
  - Abstractness vs. Instability: Balance abstraction and stability.

- **Connascence**:
  - Measures interdependence; lower connascence improves flexibility.

- **Cyclomatic Complexity**:
  - Measures code complexity via control flow graphs.

## SMART Objectives
- **Definition**: Specific, Measurable, Assignable, Realistic, Time-related.
- **Application**:
  - Set concrete architecture goals.
  - Regularly refine through feedback.

## First Project Task
- **Focus**: Develop an IT system for hospital management.
- **Requirements**:
  - Both functional (e.g., patient records) and non-functional (e.g., scalability).
- **Deliverable**: A working system.

## Stakeholder Communication
- **Explicit vs. Implicit Requirements**:
  - Ensure all critical requirements (e.g., security, availability) are defined.
  - Prioritize based on stakeholder needs and cost considerations.

## References
- *Fundamentals of Software Architecture* by Mark Richards & Neal Ford:
  - Technical depth/breadth: Chapter 2.
  - Architecture characteristics: Chapter 4.
  - Measuring characteristics: Chapters 3, 6.
  - Requirements mapping: Chapter 5.
