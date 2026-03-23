## Little's Law
$$\overline{N} = \overline{R} X$$

- The Average number of jobs in a system is equal to the average response time multiplied by the throughput of the system

$$ p= \frac{\mu}{\lambda + \mu} $$

- If you want to have high utilization you have to drop the jobs

- if you don't want to drop the jobs you must have low utilizations


# Processor Case Study:

- 1 Ghz
	- 10 W power consumption when Idle
	- 50 W power consumption when working
- 2 Ghz
	- 10 W when Idle
	- 125 W Working

M/M/1
 $\lambda$ : Arrival Rate
 $\mu$ : Service Rate
 
Slowest system:  $\lambda$<$\mu$
 $$\overline{R1}=\frac{1}{\mu - \lambda}$$
   $$\overline{R2}=\frac{1}{2\mu - \lambda}$$
  P =Idle x 10 + Busy x 50  (Fraction of times spent in..)
  
   Busy=$\frac{\lambda}{\mu}$     Idle=1-$\frac{\lambda}{\mu}$

$\mu$=10 j/s
## Low load 

**$\lambda$=2 j/s**

R1=0.125  R2 =0.055s
P1 =18W P2=21.5W

## Moderate Load
**$\lambda$=5 j/s**
R1=0.2 s
R2=0.067 s
P1=30 W
P2=38.8 W

## Heavy Load
**$\lambda$=9 j/s**
R1=1 s
R2=0.09 s
P1=46 W
P2=61.8 W



# Inspection Paradox

![[Pasted image 20260323093933.png]]
The residual Life: The time left for a job to finish

Conclusion: The Random Observer has a higher probability to see the longer job in service at its arrival Time
