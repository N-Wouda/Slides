---
title: OptiML's Euro/NeurIPS VRP challenge presentation
theme: black
---

# Solving a static and dynamic VRP with time windows

<br />

**OptiML**

Jasper van Doorn, Leon Lan, Luuk Pentinga, Niels Wouda

7 December 2022

---

# Static solver

----

## High-level overview

- Simplify given baseline
- Tweak local search

Note:

The first two are what I want to explain in more detail today.
Since we do not have a lot of time, I will not go into what we did for diversity management, or how we tuned the many parameters of our static solver.
That is also very interesting (and turned out to be really important, too!), so if you want to know more, we refer to both the codebase and the four-page summary paper on our methods.

----

## Simplify baseline

- First, we refactored the entire codebase, and added Python bindings.
- Then, we removed:
  - constructive heuristics
  - circle sectors
  - giant tour representation and split algorithm
  - dynamic growth of granular neighbourhoods and minimum population size

> Our ``Config`` object has 26 fields, compared to the baseline's 42.

Note:

Constructive heuristics could be removed because we wanted to get into the main genetic search loop as quickly as possible.
Our initial population is randomly generated.
We removed the circle sectors because we do intensification somewhat differently (more on that in the next slide).
The giant tour representation and the linear split algorithm were only needed for the ordered exchange crossover.
We remove that crossover, which meant we no longer needed to store the giant tour.
The dynamic growth parameters did not seem to help much because the sizes they control are already 'large enough'. 

Removing all this did not seem to hurt performance at all.
So we more or less made everything much simpler at zero cost to performance.

Having many fewer parameters was a big boon when it came to tuning.

----

## Tweak local search

<div style="display: flex;">

<div style="max-width: 50%; flex: 1;">

Baseline:

- Always at least two iterations. Later iterations tests against empty routes.
- Probabilistically apply intensification with RELOCATE* and SWAP*.
- Uses circle sector restriction for intensification.
- Hard-coded operators.

</div>

<div style="max-width: 50%; flex: 1;">

Ours:

- One iteration if no improvement. Empty routes very rarely result in improvement.
- Apply intensification only for new best individuals. 
- Since new best individuals are fairly rare, no circle sector restriction is needed.
- Modular operator set.
- Templated $(N, M)$ exchange with many small performance tweaks.
</div>

</div>

Note:

Our operators are stored as lists of function pointers.
We run through these and apply the operators.
So not running an operator is as easy as not providing it to the local search in the first place.

$(N, M)$ exchange covers six out of eight node-based operators.
So having one bit of code for all that means we can very effectively improve a lot of operators at the same time.

---

# Dynamic solver

----

TODO
