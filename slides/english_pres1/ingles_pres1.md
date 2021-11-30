---
title: Syngas - an opportunity to reduce carbon emissions
theme: black
---

# Syngas - an opportunity to reduce carbon emissions

<br>

Niels A. Wouda

01-12-2021

Note:

Syngas is synthetic gas, as opposed to natural gas

Most of my research deals with the _how_, not the _why_. 
In particular, the _how_ is 'how to design a syngas production network'.
But that is all very mathsy, so I will not go into those details today.
Instead I am going to focus on the _why_, that is, why we want to do all that complicated math.

Thus I am going to present a motivation for what I am doing, instead of talk about what I am actually doing.
First, I want to start with a few basic facts about current energy systems.
Then, I go into detail about future energy systems, and why syngas might be a very good idea on the way there.

---

## Motivation

<img width="100%" src="images/cbs-energy-production.svg" alt="CBS (2021) data on Dutch energy production." />
<!--- ![CBS (2021) data on Dutch energy production](images/cbs-energy-production.svg) --->

- In NL, about 45% of total energy production is based on natural gas [3]
- Syngas has 'simple' chemistry:
    - **Electrolysis**: water + electricity $\longrightarrow$ hydrogen (+ oxygen)
    - **Methanation**: hydrogen + carbon dioxide + electricity $\longrightarrow$ syngas (+ water)
- When syngas is burned, carbon dioxide can be captured to make new syngas
- Syngas is **carbon-neutral** when renewable electricity is also used

----

## Motivation

- Methanation and carbon capture are very expensive
- But so were (offshore) wind and solar just a decade ago: [1]

<img width="75%" src="images/irena-wind-solar.svg" alt="IRENA (2020) data on LCoE (USD/kWh) of solar and wind." />
<!--- ![IRENA Wind and Solar PV data](images/irena-wind-solar.svg) --->

<div style="font-size: .75em;">
    (Electrolysis cost has gone down by ~40% in the past five years [2])
</div>

Note:

Solar is great in homes, but not nearly as reliable as (offshore) wind.
First offshore wind park in Europe was built in 1995 (very small, in the Baltic).
First Dutch one in 2007.
First subsidy-free Dutch offshore wind park tendered in 2017 (HKZ, Vattenfall), to be commissioned by 2023.

Cost-competitive renewable electricity generation is a solved problem.

A lot less is known about methanation and carbon capture, I am afraid.
Those technologies are still quite new, and I could not really find reviews on their costs.
Undoubtedly those will also show up in the coming few years.
Based on the other figures, I am fairly confident they will also show cost reductions.

----

## Motivation

- Syngas today is more expensive than natural gas
  - But how much more expensive?
  - What drives costs?
- What carbon tax would make syngas production cost-competitive?

---

## Solution approach

- If we can design a syngas production network at minimal cost, we:
  - have an estimate of the cost of syngas production;
  - know the relative costs of all parts of the network;
  - can determine a carbon tax that makes syngas production cost-competitive.
- This network design problem has many **policy implications**!

So, what I work on is this:
> How to construct a minimum-cost network for syngas production using captured carbon dioxide and renewable electricity?

---

## Conclusion

- Syngas is great in theory, but expensive in practice
- I want to find out what drives the cost of syngas production
- What is needed to make syngas cost-competitive?

---

## References

1. Adapted from Figure ES.3 of 
   IRENA (2021), 
   _Renewable Power Generation Costs in 2020_, 
   International Renewable Energy Agency.
   https://irena.org/publications/2021/Jun/Renewable-Power-Costs-in-2020

2. G. Glenk and S. Reichelstein (2019), 
   Economics of converting renewable power to hydrogen,
   _Nature Energy_ 4, 216–222. https://doi.org/10.1038/s41560-019-0326-1

3. CBS (2021), _Energiebalans; aanbod, omzetting en verbruik_, 
   https://www.cbs.nl/nl-nl/cijfers/detail/83140NED.
