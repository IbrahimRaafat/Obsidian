## Problem & Motivation

- Most requests complete quickly, but a small fraction — rare stragglers — take orders of magnitude longer
- Request sizes follow heavy-tailed Pareto distributions, which can have **infinite variance**
- Oblivious policies like Round Robin can be completely blindsided by a single straggler
- Size-aware policies like SITA and LWL promise improvements, but only if workload assumptions actually hold
- **Goal**: evaluate five dispatching policies — Random, Round Robin, JSQ, LWL, SITA — under Pareto-distributed workloads across three identical servers

## Dispatching Policies

- Three categories of policies:
  - **Oblivious** (Random, Round Robin): route without looking at server state
    - Simple and low-overhead, but blind to stragglers
    - A single slow request can silently queue dozens of others behind it
  - **Queue-aware** (JSQ, LWL): react to current load
    - JSQ → server with fewest pending requests
    - LWL → server with least total pending work
    - LWL turned out to be the most robust policy overall
  - **Size-aware** (SITA): partitions request sizes into three bands using fixed quantile thresholds (~1.31, 2.09), one band per server
    - Great for separating stragglers
    - Fragile if the workload distribution shifts

## Results: Load Sweep

- λ varied from 2 to 22 req/s at α = 1.3
- At low load (λ ≤ 5), all policies perform similarly — queues rarely form
- Random collapses first:
  - p99 = 18.4s at λ = 8, despite a mean of only 759ms
  - Shows how a good average can hide a terrible tail
- At λ = 22: Random p99 = 39.8s vs LWL p99 = 196ms — a **200× gap**
- LWL and JSQ remain stable throughout, consistently lowest p99
- Round Robin and SITA degrade noticeably at moderate-to-high load, despite handling the same number of requests

## Results: Alpha Sweep — SITA Collapse

- SITA's thresholds (~1.31, 2.09) are computed once and never updated
- As α increases, Server 3 keeps receiving all large-x requests regardless
- At α = 2.0:
  - SITA mean = 39.5s, p99 = 207s
  - Server 3 accumulated 223s of service time — 5× more than Servers 1 and 2 combined
- All other policies stayed below 1s mean at the same load
- Conclusion: fixed thresholds make SITA brittle to any shift in workload distribution

## Results: Saturation — Early Stress

- Sweep 4: λ = 25 and 30, ρ ≈ 0.17–0.20 — still well below saturation
- Policies already start to diverge:
  - SITA p99 = 519ms vs LWL/JSQ below 300ms
  - Random's tail visibly thickens in the CCDF plot
- Queue-aware policies remain stable; oblivious ones already struggling
- An early preview of the much larger divergence that explodes at higher load (next: Esma)

## Discussion

- Heavy-tailed service times break classical queueing assumptions — with α ≤ 2, variance is infinite
- A "good" mean can hide a catastrophic tail
  - Random at λ = 8: mean = 759ms but p99 = 18.4s
- The dispatcher never sees the true service time — only x — so every policy routes on an estimate, not a guarantee
- A single straggler can block a server for minutes
- Oblivious/rigid policies (Random, Round Robin, SITA) keep feeding work to a blocked server
- Queue-aware and workload-aware policies route around it instead

## Thank You

- Thank you for listening — happy to take any questions