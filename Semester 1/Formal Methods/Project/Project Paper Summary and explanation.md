# Selfish Mining in Public Blockchains: A Quantitative Analysis Using PEPA

## Summary

### Key Concepts:
1. **Blockchain and Proof-of-Work (PoW):**
   - Blockchain is a decentralized ledger.
   - PoW incentivizes miners to solve computational problems and secure the network.
   - Mining rewards are proportional to computational power.

2. **Selfish Mining Attack:**
   - A strategy where a mining pool privately withholds mined blocks, creating a private chain.
   - Honest miners waste resources on the public chain.
   - Selfish miners strategically reveal their private chain, invalidating the honest miners' work and earning disproportionate rewards.

3. **Impact on Blockchain:**
   - Reduces system efficiency and fairness.
   - Encourages rational miners to join selfish pools.

4. **PEPA (Performance Evaluation Process Algebra):**
   - A compositional modeling framework with stochastic foundations.
   - Useful for analyzing behaviors like selfish mining and deriving performance metrics.

---

## Analysis and Modeling with PEPA

### Modeling Network Behavior:
1. **Fair Miners Only:**
   - Each miner mines blocks and verifies blocks from other miners.
   - Transition states include mining and verification phases.
   - PEPA Syntax:
     ```pepa
     Miner = (mine, λ).Miner + (verify, μ).Miner
     Network = Miner ⬛{mine, verify} Miner
     ```
   - Interaction occurs during mining and verification activities.

2. **Selfish and Fair Miners:**
   - The selfish miner creates a private branch with actions `mS1` (first block) and `mS2` (second block).
   - Honest miners verify the selfish miner’s blocks if revealed.
   - PEPA Syntax:
     ```pepa
     SelfishMiner = (mS1, wλ).Cheat + (mH, μ).Verify
     FairMiner = (mH, λ).Mine + (verify, μ).Verify
     Network = SelfishMiner ⬛{mH, mS2, verify} FairMiner
     ```

3. **Lumped Model for Scalability:**
   - Aggregates fair miners into an environment component.
   - Ensures computational feasibility for large-scale networks.
   - Simplified PEPA Syntax:
     ```pepa
     Environment = (mine, Kλ).Verify + (mS2, >).Verify
     ```

---

## Performance Metrics
- **Throughput:** Measures mining efficiency and block production rates.
  ```math
  XS = (2 - p)XmS2 + pXmS1
  XF = (XmEF - (1 - p)XmS2 - pXmS1) / K
