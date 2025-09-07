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

