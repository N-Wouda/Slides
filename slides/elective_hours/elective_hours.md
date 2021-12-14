---
title: Personalising elective hours in secondary education
theme: black
---

# Personalising elective hours in secondary education

<br>

Niels A. Wouda

15-12-2021

----

<!-- .slide: data-transition="none" -->

## An example

Elective hours:

|   | Monday  | Tuesday | Wednesday |
|---|---------|---------|-----------|
| 1 | (fixed) | ?       | (fixed)   |
| 2 | (fixed) | (fixed) | (fixed)   |
| 3 | (fixed) | (fixed) | ?         |
| 4 | ?       | ?       | (fixed)   |

----

<!-- .slide: data-transition="none" -->

## An example

We schedule:

|   | Monday      | Tuesday       | Wednesday         |
|---|-------------|---------------|-------------------|
| 1 | (fixed)     | Math/Dutch    | (fixed)           |
| 2 | (fixed)     | (fixed)       | (fixed)           |
| 3 | (fixed)     | (fixed)       | Math/French/Dutch |
| 4 | Math/French | German/French | (fixed)           |

----

<!-- .slide: data-transition="none" -->

## An example

Learner chooses:

|   | Monday        | Tuesday         | Wednesday           |
|---|---------------|-----------------|---------------------|
| 1 | (fixed)       | Math~/Dutch~    | (fixed)             |
| 2 | (fixed)       | (fixed)         | (fixed)             |
| 3 | (fixed)       | (fixed)         | Math~/French/Dutch~ |
| 4 | Math~/French~ | ~German/~French | (fixed)             |


---

# The problem

- _Scheduling_: which electives to offer?
- _Personalising_: what electives do learners really need?
  - How can we know?

---

# The approach

- Multiple weeks
- Each week:
  - Optimise schedule given estimator of learner needs
  - Update estimator based on learner choices

Note:

Due to time limitations, I will not discuss the scheduling problem today.
It can be solved, using mostly straightforward math.
I would rather discuss learning/updating learner needs!

----

## Notation

Per course $c$ (e.g., Math, French, etc.):
  - $v_{c}(x)$: value of $x \ge 0$ elective hours of course $c$
  - Assume $v_{c}(x) \ge v_{c}(x + 1)$ for $x \ge 0$

----

## Update estimator

Recall:

|   | Monday        | Tuesday         | Wednesday           |
|---|---------------|-----------------|---------------------|
| 1 | (fixed)       | Math~/Dutch~    | (fixed)             |
| 2 | (fixed)       | (fixed)         | (fixed)             |
| 3 | (fixed)       | (fixed)         | Math~/French/Dutch~ |
| 4 | Math~/French~ | ~German/~French | (fixed)             |

Maybe:

- $v_{\text{Math}}(1) \ge v_{\text{French}}(1)$
- $v_{\text{Math}}(2) \ge v_{\text{Dutch}}(1)$
- $v_{\text{French}}(1) \ge v_{\text{German}}(1)$
- $v_{\text{Math}}(3) \ge v_{\text{French}}(2)$ and $v_{\text{Math}}(3) \ge v_{\text{Dutch}}(1)$

----

## Update estimator

- Goal: find $v_c(x)$ consistent with observations
- Changing learner needs/values over time?
- Can we observe $v_c(x)$ for many courses/hours?
  - Exploit/explore trade-off

---

# Conclusion

- Personalising elective hours in secondary education:
  - Scheduling given estimator about learner needs 
  - Updating estimator based on learner choices
