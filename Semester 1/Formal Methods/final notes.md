# Apparent Rates:
So to summarize:

- Apparent rate = sum of enabled rates.
    
- Choices add, restrictions block, cooperation synchronizes by taking the minimum.
    

That’s how PEPA keeps track of performance in a compositional way.


# Lumpability :

Lumpability is a technique to reduce the size of a CTMC by merging states that are behaviourally indistinguishable.  
A CTMC is **strongly lumpable** if states in the same block have identical outward transition behaviour.  
It is **exactly lumpable** if states in the same block also receive the same aggregate inflows, making them equiprobable.  
If both hold, the chain is **strictly lumpable**.  
This allows us to solve smaller CTMCs without losing correctness.


## Question
![[Pasted image 20250908030534.png]]
Strong equivalence in PEPA corresponds to lumpability in the underlying CTMC. Two strongly equivalent components can be mapped to the same reduced CTMC, ensuring identical steady-state behaviour. This allows us to aggregate symmetric states and simplify the model without altering performance indices. In performance evaluation, this means metrics such as utilisation, throughput, response time, and blocking probabilities are preserved under strong equivalence.