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
- Tuning

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

----

## Tweak local search

TODO

----

## Tuning

TODO

---

# Dynamic solver

----

TODO
