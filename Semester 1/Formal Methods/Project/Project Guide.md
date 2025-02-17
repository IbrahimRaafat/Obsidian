	# Guide: Modeling Selfish Mining Using PEPA and Eclipse

## Step 1: Install PEPA Eclipse Plug-in
1. **Download Eclipse IDE:**
   - Visit the [Eclipse Download Page](https://www.eclipse.org/downloads/).
   - Choose the appropriate version for your system and install it.

2. **Install PEPA Plug-in:**
   - Open Eclipse and go to `Help > Eclipse Marketplace`.
   - Search for "PEPA Plug-in" and install it.
   - Restart Eclipse after installation.

---

## Step 2: Define the Model
1. **Create a New PEPA Project:**
   - Open Eclipse and select `File > New > PEPA Project`.
   - Name your project and create it.

2. **Write the PEPA Syntax:**
   - Define the components (e.g., fair miners, selfish miners).
   - Specify activities and interactions between components.
   - Example:
     ```pepa
     SelfishMiner = (mineSelf, wλ).Cheat + (verify, μ).Verify
     Cheat = (reveal, wλ).SelfishMiner
     FairMiner = (mineFair, λ).Mine + (verify, μ).Verify
     Network = SelfishMiner ⬛{mineFair, reveal, verify} FairMiner
     ```

---

## Step 3: Generate State Space
1. **Build the Model:**
   - Click `Run > Generate State Space` in the PEPA perspective.
   - The derivation graph will be created.

2. **Verify Lumpability:**
   - Use the lumping feature to reduce the state space if needed.
   - Aggregate states based on equivalence relations.

---

## Step 4: Analyze Metrics
1. **Steady-State Probabilities:**
   - Use the steady-state analysis tool in PEPA to compute probabilities for each state.
   
2. **Performance Metrics:**
   - Calculate throughput, revenue, or other metrics using steady-state results.
   - Example formulas:
     ```math
     XS = (2 - p)XmS2 + pXmS1
     XF = (XmEF - (1 - p)XmS2 - pXmS1) / K
     R = XS / (XS + XEF)
     ```

---

## Step 5: Visualize Results
1. **Export Derivation Graph:**
   - Use the graph export feature to save the derivation graph or Markov chain.

2. **Evaluate Results:**
   - Analyze the graphs and numerical results to understand system behavior and attack feasibility.

---

## Additional Tips:
- Use comments in your PEPA code for clarity.
- Start with simple models and gradually increase complexity.
- Validate the model against known results or simulations.

