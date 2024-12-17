# UNOX @ UNIVE: Software Architectures

## Company Overview
- **Mission**: UNOX creates state-of-the-art ovens, services, and experiences focused on inventive simplification and perfection.
- **Global Presence**:
  - 42 branches worldwide.
  - 1,300 employees (40% outside Italy).
  - Average age: 33.

---

## Key Achievements
- **Technology Milestones**:
  - 1993: AIR.Maxi technology.
  - 2015: MIND.Maps intelligent combi ovens.
  - 2023: Interactive cooking era.
- **Sustainability Goals**:
  - Renewable energy for all operations by 2030.
  - Maximize use of recyclable materials and packaging.
  - Leader in Energy Star-certified professional ovens.

---

## Products and Services
- **Ovens**:
  - BAKERTOP MIND.Maps, CHEFTOP-X, SPEED-X, EVEREO®, BAKERLUX SHOP.Pro.
- **Services**:
  - Data-driven cooking, remote assistance, training, and maintenance.
- **Software Features**:
  - IoT-enabled ovens with cross-platform synchronization.
  - Apps for analytics, cooking programs, and user support.

---

## IoT Architecture Evolution
1. **2015**: Initial release.
   - Single VPS with Postgres, MongoDB, and Tomcat.
   - Connectivity via Ethernet, Wi-Fi, or 3G kits.
   - Challenges: Limited user engagement, outsourced dependencies.

2. **2018-2024**: Cloud-first scaling.
   - Fully serverless architecture with AWS.
   - Native mobile app integration, paid plans for enterprises.
   - Scaling strategies:
     - Stateless servers, managed DBs (AWS RDS, MongoDB Atlas).
     - High availability via CloudFront, ELB, and Route53.
     - Observability tools like AWS CloudWatch and Sentry.io.

3. **2025+**: Future challenges.
   - Data lake for analytics (Spark-compatible).
   - Improved MongoDB scalability (move to Mongo Atlas).
   - Enhanced AWS infrastructure security.

---

## Key Practices in Scaling
- **Compute**:
  - Docker-based clusters and serverless solutions.
  - Stateless web servers, non-sticky sessions.
- **Connections**:
  - Managed proxies (HAProxy, CloudFront).
- **Storage**:
  - Read replicas, multi-master DBs.
- **Observability**:
  - Centralized monitoring for KPIs, bottlenecks, and error tracking.

---

## Internship & Thesis Opportunities (2025)
- **Mobile App Development**:
  - Tools: React Native, Node.js, AWS.
  - Collaboration with UI/UX and Marketing teams.
- **Custom Rendering Engine**:
  - Optimized GUI rendering using Rust and ARM assembler.
  - Portability to GPUs.
- **Automated Testing**:
  - End-to-end testing for digital ovens.
  - Collaboration with R&D for hardware-software integration.

---

## Contact
- Email: [recruitment@unox.com](mailto:recruitment@unox.com)
- Subject: Digital Experience Internship
