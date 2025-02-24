---
annotation-target: "![[CM0626-02-Program-analysis.pdf]]"
---
# Build the Graph
## BuilldCFG(F ):  
1. Mark every instruction which can start a basic block as a leader:  
	• the first instruction is a leader; any target of a branch is a leader;  
	• the instruction following a conditional branch is a leader.  
2. A basic block consists of the instructions from a leader up to, but not  
	including, the next leader.  
3. Add an edge A → B if A ends with a branch to B or can fall through to B.  
