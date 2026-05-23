# Testing Steps — Load Balancing Project

> Repo: `C:\Users\Ibrahim\Desktop\load-balancing-heavy-tail`
> All commands run from that directory unless stated otherwise.

---

## Prerequisites

```powershell
pip install -r requirements.txt
```

> Requires: Flask, numpy, matplotlib, requests, psutil

---

## Step 1 — Start the 3 servers

Open **Terminal A** and keep it running the whole time:

```powershell
python main.py
```

You should see:
```
Server started on Port: 5001 | Pinned to Core: 0
Server started on Port: 5002 | Pinned to Core: 1
Server started on Port: 5003 | Pinned to Core: 2
Infrastructure is ready.
```

**Sanity check** (optional, Terminal B):
```powershell
Invoke-WebRequest http://127.0.0.1:5001/health -UseBasicParsing
```
Should return `{"status": "ok"}`.

---

## Step 2 — Quick smoke test (optional, ~2 min)

Verify the stack works end-to-end before running full sweeps:

```powershell
python -m src.dispatcher --policy random --lam 1.5 --n 100 --size-dist bounded_pareto
```

**Expected output:**
- `mean response` should be in the order of seconds (not ms) — confirms the CPU bug fix is in effect
- `p99` should be several times larger than `p50` — confirms the heavy tail is real
- Per-server counts roughly 33/33/33

CSV written to `data\random_lam1.5_alpha1.3.csv`.

---

## Sweep 1, 3, 4 — Main experiment suite (run once, ~1–2 hours)

**Servers must already be running (Step 1). Keep alpha=1.3 in config.py.**

Open Terminal B:

```powershell
powershell -ExecutionPolicy Bypass -File .\run_experiments.ps1
```

**What this runs:**

| Sweep | What varies | Fixed | λ values | N |
|-------|-------------|-------|----------|---|
| 1 — Load | λ | α=1.3, bounded_pareto | 2, 5, 8, 12, 15, 18, 22 | 500–2000 |
| 3 — Size dist | distribution shape | lam=10, α=1.3 | 10 | 1000 |
| 4 — Saturation | λ (very high) | α=1.3, bounded_pareto | 25, 30 | 2000 |

**Skip logic:** if a CSV already exists for a run, it is skipped automatically. Safe to re-run.

**Output:**
- CSVs → `data\`
- Plots → `notebooks\figures\` (auto-generated at the end)

---

## Sweep 2 — Alpha (heavy-tail) sweep (automated, ~1–2 hours)

This sweep **manages servers itself** — do NOT start servers manually first. Stop Terminal A before running this.

```powershell
# Stop servers first (Ctrl+C in Terminal A), then:
powershell -ExecutionPolicy Bypass -File .\run_alpha_sweep.ps1
```

**What it does:**
1. For each alpha value, it edits `config.py`, starts servers, runs all 5 policies, stops servers
2. Restores `config.py` to `ALPHA = 1.3` when done

**Alpha values tested:**

| α | Tail character | N |
|---|----------------|---|
| 1.1 | Extremely heavy — lots of stragglers | 500 |
| 1.3 | Project default | 1000 |
| 1.5 | Moderately heavy | 1000 |
| 2.0 | Light tail | 1000 |
| 3.0 | Near-exponential | 1000 |

**Output:** CSVs tagged `_alphasweep.csv` in `data\`, plots in `notebooks\figures\`

---

## Sweep 5 — Bottleneck / saturation sweep (optional, can be slow)

Find the exact λ where each policy saturates. Theoretical system capacity ≈ 147 req/s.

**Servers must be running (restart Terminal A after alpha sweep):**

```powershell
python main.py   # Terminal A

# Terminal B:
powershell -ExecutionPolicy Bypass -File .\run_bottleneck_sweep.ps1
```

**Lambda values and estimated utilization:**

| λ | ρ (utilization) | Notes |
|---|-----------------|-------|
| 40 | 0.27 | Low-moderate |
| 60 | 0.41 | Moderate |
| 75 | 0.51 | Half capacity |
| 100 | 0.68 | High load — queues grow |
| 120 | 0.82 | Random/round_robin start struggling |
| 135 | 0.92 | Near saturation |
| 147 | ~1.0 | Theoretical saturation point |

N=2000 throughout. Can take 30–60s per run at high λ.

---

## Generate plots manually (if auto-plotting fails)

```powershell
python notebooks\plot_results.py --data data --out notebooks\figures
```

Or use the dedicated script (finer control):

```powershell
powershell -ExecutionPolicy Bypass -File .\generate_plots.ps1
```

**Plots produced:**
- `percentiles.png` — mean/p50/p90/p99 per policy (log Y)
- `ccdf.png` — CCDF on log-log (the tail story — straight line = power law)
- `per_request.png` — response time scatter colored by server
- `load_split.png` — request count per server per policy

---

## JSQ with server-side queries (optional extension)

Exercises the `/queue` endpoint — the "limited observability" path from the project spec:

```powershell
python -m src.dispatcher --policy jsq --lam 1.5 --n 100 --use-server-query
```

Compare output with plain JSQ (without `--use-server-query`) to see if actual server-side queue state improves decisions.

---

## Troubleshooting

**Response times < 1ms:**
The CPU bug fix didn't take. Check `src/server.py` `process_request()` — `return acc` must be at function-body indentation, not inside the `for` loop.

**"Server on port 5001 did not become ready":**
Port conflict. Kill stale Python processes:
```powershell
Get-Process python | Stop-Process -Force
```
Then restart `main.py`.

**Alpha sweep left config.py modified:**
```powershell
# Check current value:
Select-String "^ALPHA" config.py

# Restore manually if needed:
(Get-Content config.py) -replace 'ALPHA = .*', 'ALPHA = 1.3' | Set-Content config.py
```

**CSV exists but you want to re-run:**
Delete the specific file and re-run the script — it will regenerate only missing CSVs.

---

## What your partner already ran (Esma)

- Smoke tests: all 5 policies at λ=1.5, α=1.3, n=100
- Results + Word doc uploaded to Google Drive
- Scripts pushed to `master` branch (merged into local on 2026-05-23)

→ See [[Study Plan - Load Balancing Project]] for theoretical background on what the results mean.
