---
title: Creating syngas from carbon dioxide and hydrogen
theme: black
revealOptions:
    math:
        TeX:
            extensions:
                - mhchem.js
---

# Creating syngas from carbon dioxide and hydrogen

<br>

Niels Wouda

01-12-2021

---

## Motivation

- Natural gas emits lots of carbon dioxide when burned
- Few uses for that carbon dioxide today
- Syngas has 'simple' chemistry:
    - **Electrolysis**: water + electricity $\ce{->}$ hydrogen (+ oxygen)
    - **Methanation**: hydrogen + carbon dioxide + electricity $\ce{->}$ syngas (+ water)
- Carbon-neutral when carbon dioxide is captured, and clean electricity is used
  
> Can we combine hydrogen and carbon dioxide to make (cost-effective)
> carbon-neutral synthetic natural gas?

----

## Motivation

- Electrolysis, methanation and carbon capture are very expensive
- But, so were (offshore) wind and solar not a decade ago: [1]

<img width="75%" src="images/irena-wind-solar.svg" />
<!--- ![IRENA Wind and Solar PV data](images/irena-wind-solar.svg) --->

Similar trend for electrolysis in past five years [2]

----

## Motivation

- Syngas is more expensive than natural gas
  - But how much more expensive?
  - What drives costs? Electricity, transport, hydrogen production, something else?
- What carbon tax would make syngas production cost-competitive with fossil fuels?

---

## Solution approach

- If we can design a syngas production network at minimal cost, we:
  - have an estimate of the cost of syngas production;
  - know the relative costs of all parts of the network;
  - can determine a carbon tax that makes syngas production cost-competitive.
- This network design problem has many **policy implications**!

So, what I work on is this:
> How to construct a minimum-cost network for syngas production?

---

## Conclusion

Extensions:
- What about the $\ce{O2}$ 'waste' product?

---

## References

1. Adapted from Figure ES.3 of 
   IRENA (2021), _Renewable Power Generation Costs in 2020_, 
   International Renewable Energy Agency, Abu Dhabi.

2. Glenk, G., Reichelstein, S. 
   Economics of converting renewable power to hydrogen.
   _Nature Energy_ 4, 216–222 (2019). https://doi.org/10.1038/s41560-019-0326-1
