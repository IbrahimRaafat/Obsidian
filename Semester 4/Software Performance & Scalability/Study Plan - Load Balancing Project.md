# Study Plan — Load Balancing with Heavy-Tailed Tasks

> Project: Software Performance & Scalability — Ca' Foscari (Prof. Andrea Marin)
> Partner: Esma | Repo: `load-balancing-heavy-tail`

---

## Priority Order

| # | Topic | Where to study | Why it matters |
|---|-------|----------------|----------------|
| 1 | Heavy-tailed distributions, Pareto, CCDF | Notes PDF + Slides_SPS.pdf | Core of the whole project |
| 2 | M/G/1 queue, Pollaczek–Khinchine formula, Little's Law | Queueing_network.pdf + Slides_SPS-2.pdf | Explains why mean response time explodes near saturation |
| 3 | Load balancing policies (JSQ, LWL, SITA) | Slides_SPS-4.pdf or Slides_SPS-5.pdf | Directly maps to the 5 policies we implemented |
| 4 | What we built and why | `CHANGES.md` in the repo | Oral interview will ask about design decisions |
| 5 | What experiments are done / remaining | `RUNBOOK.md` in the repo | So you can run and interpret results |

---

## Block 1 — Heavy-Tailed Distributions

Study from `Notes_on_the_course_of_Software_Performance_and_Scalability.pdf` and `Slides_SPS.pdf`.

**What to understand:**
- What a Pareto distribution is: `P(X > x) = (x_min / x)^alpha` for `x >= x_min`
- What **alpha** controls — lower alpha = heavier tail = more stragglers
	- `alpha = 1.1` → very heavy, extreme outliers common
	- `alpha = 1.3` → project default
	- `alpha = 2.0` → mild tail
	- `alpha = 3.0` → near-exponential, almost no stragglers
- Why Pareto has **infinite variance** when `alpha ≤ 2` — this is the mathematical reason everything breaks
- How to read a **CCDF on log-log axes**: a straight line = power-law tail; slope = tail index

**Key oral question it answers:**
> "Why do heavy-tailed tasks make load balancing difficult?"
> → Because variance is infinite, a single straggler can dominate a server's queue for an unpredictably long time. You can't know at dispatch time how bad a job will be.

---

## Block 2 — Queueing Theory

Study from `Queueing_network.pdf` and `Slides_SPS-2.pdf`.

**What to understand:**
- **M/G/1 queue model**: Poisson arrivals (our load generator), General service time (heavy-tailed), 1 server (our per-server FIFO thread)
- **Pollaczek–Khinchine (P-K) mean formula**: mean response time grows with the *second moment* `E[S^2]` of service time — which is infinite for Pareto with `alpha ≤ 2`. This is the exact theorem that explains why SITA and LWL beat random.
- **Little's Law**: `L = λW` — queue length is proportional to response time. A backed-up server under heavy load compounds the straggler problem.
- **Utilization ρ = λ/μ**: what happens as `ρ → 1` (saturation). Our bottleneck sweep (λ = 40–147) drives toward this.
- **The saturation knee**: the "knee" in the mean response time vs. λ curve is the headline experimental result — each policy hits its knee at a different λ.

**Key oral question it answers:**
> "How do stragglers affect system performance?"
> → One large job blocks a FIFO queue (head-of-line blocking), causing all subsequent small jobs at that server to wait. As ρ increases toward 1, this effect is amplified because the queue rarely drains between arrivals.

---

## Block 3 — Load Balancing Policies

Study from `Slides_SPS-4.pdf` or `Slides_SPS-5.pdf` (whichever covers dispatching).

**Policy summary to memorize:**

| Policy | Information used | Strength | Weakness |
|--------|-----------------|----------|----------|
| **Random** | None | Simple baseline | Sends large jobs anywhere |
| **Round-Robin** | None | Balanced count | Same as random for heavy tails |
| **JSQ** | Queue length (count) | Avoids overloaded servers | Blind to job size — short queue may have one huge job |
| **LWL** | Queue length + pending work sum | Better than JSQ for heavy tails | Still online; can't predict future |
| **SITA** | Job size `x` | Isolates stragglers to their own server | Requires knowing `x` at dispatch time |

**The key insight for the oral:**
SITA wins on p99/max because it routes large jobs to a dedicated server — small jobs can never be blocked by a straggler. This is called *straggler isolation*. LWL wins on mean response time because it minimizes total work in the system dynamically.

**Why our dispatcher knows `x`:** The load generator draws `x` from a bounded-Pareto distribution and sends it with each request. This is the "size-aware dispatching" setup described in section 2 of the project spec.

---

## Block 4 — Code We Built (for the oral)

Read `CHANGES.md` and `src/dispatcher.py` in the repo.

**Critical things to be able to explain:**
- The bug fix in `server.py`: the `return` was inside the `for` loop, so no CPU work was done. Fixing it moved response times from milliseconds to seconds.
- Why each server has a **single background worker thread** (FIFO queue semantics, matches M/G/1 model)
- Why `response_time = completion_time - arrival_time` (not dispatch time) — this is the true user-perceived latency
- Why the load generator uses **Poisson arrivals** (open-loop, arrival rate independent of server state — matches M/G/1 assumption)
- The `/queue` endpoint: allows JSQ to query actual server-side pending count (the "limited observability" optional extension)

---

## Block 5 — Experiments (what was run, what remains)

**Already done by Esma (on Google Drive):**
- Smoke tests of all 5 policies at λ=1.5, α=1.3, n=100

**Now in the repo (partner pushed scripts):**
- `run_experiments.ps1` — Sweeps 1, 3, 4, 5 (load sweep, size dist sweep, saturation stress)
- `run_alpha_sweep.ps1` — Sweep 2: α ∈ {1.1, 1.3, 1.5, 2.0, 3.0}, manages server restarts automatically
- `run_bottleneck_sweep.ps1` — λ = 40–147 to find exact saturation knee

**What the sweeps answer:**
- Sweep 1 (load): low vs high λ — main scalability story
- Sweep 2 (alpha): how tail heaviness changes policy rankings
- Sweep 3 (size dist): bounded_pareto vs uniform vs exponential vs fixed
- Sweep 4/5 (saturation): where each policy breaks down

→ See [[Testing Steps - Load Balancing Project]] for how to run them.

---

## Three Oral Questions to Prepare

1. **Why do heavy-tailed tasks make load balancing difficult?**
   P-K formula + infinite variance of Pareto with `alpha ≤ 2`. Even a small probability of extreme outliers dominates the tail.

2. **Which strategy performs best and why?**
   SITA for tail metrics (p99, max) — straggler isolation. LWL for mean response time — minimizes total pending work. Random/round-robin are worst under heavy load.

3. **How do stragglers affect system performance?**
   Head-of-line blocking: one large job in a FIFO queue blocks all subsequent small jobs at that server. JSQ and random cannot see this coming. As ρ → 1, this effect cascades.
