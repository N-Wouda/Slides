---
title: RHP User meeting
---

# RHP User meeting

<br>

Niels Wouda

06-01-2021

<br>

<small>Speaker notes can be accessed via the `s` key</small>

Note:

This window contains the speaker notes, per slide (some slides do not have notes).
Keep it open to read along!

---


# This meeting

- The [technical slides](https://nielswouda.com/slides/rhp_tech/) discuss the
database schema. Should we recap?

- Example queries

Note:

The technical session was two days ago, so I think I can skip this. If not, 
start from the technical slides.

---

# Example queries

(finally!)

----

## Structure

- First, we will go through some queries in SQL.
- Then we switch to Tableau.

Note:

SQL is important, and the way you will want to get data from the database
for further post-processing in Excel/Python/GIS/some other tool. This will get
us quite a bit of _raw_ data.

I suggested some tutorials. Has anyone taken a look at them?

Tableau is also very nice to know, mostly for simple investigations of the
source data. We will see that in a little bit.

----

>Terra sigillata of Augustan date (Rob)

TODO

----

>Villas with cisterns (Rob)

TODO

----

>Small sites with non-diagnostic pottery (Rob)

TODO

----

## Other tools

Note:

The above showed some SQL stuff. That's the basics, but not super interesting.
In general, we would want to do more with this raw data.

That's what the following slides are about. 

----

>A comparison between the distribution of local/imported amphoras from the IInd 
>to the IVth AD. (Cristina)

TODO check query

```sql
-- Selects the artefact ID and type information of all (diagnostic) amphora artefacts.
SELECT art.id_artefact, art_form.name, art_form.provenance, art_form.start_year, art_form.end_year
FROM rhp.artefacts AS art
JOIN rhp.artefact_forms AS art_form
    ON art_form.id_artefact_form = art.id_artefact_form
WHERE art_form.type = 'Amphora'
    AND art_form.start_year <= 300  -- must start before end year, and end
    AND art_form.end_year >= 100;   -- after start year.
```

TODO (and then Python?)

----

>Spatial distribution patterns, e.g. how does the number/density of some site or
>find type vary with geographic variables such as distance-to-market, distance-to-infrastructure, or land units. (Martijn)

TODO not do this? Or in Python?

----

>The distribution of TU/Site in which are recorded Internal Slipware and/or 
>Bucchero, Attic black glaze, fragments from Vth century BC. (Cristina)

TODO do this in Tableau?

----

>Whether and how the defined site types are reflected in their assemblages, e.g.
>does the evidence for a 'small farm' change depending on its source database,
>the find circumstances, or on its location. (Martijn)

Much easier with Tableau.

TODO

---

# Questions?

---

# That's all, folks!

- These slides are all online, so you can (re-)read them later.
 
- To facilitate re-use, there are a lot of (speaker) notes in the presentation.

- Anything unclear? Mail me at [nielswouda@gmail.com](mailto:nielswouda@gmail.com). 
