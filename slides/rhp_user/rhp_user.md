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

- Status update

- Queries

---

# Status update

----

## Scope

- Pilot project

- Mostly focussed on:
  - Locations
  - Ceramic finds

Note:

In particular, we have a lot about various locations (sites, subsites, and
units), and ceramic finds. Activities and non-ceramic finds are on the list
for later.

----

## Schema

<img width="85%" 
     src="images/schema.svg" 
     style="transform: rotate(90deg);  margin-top: -400px;" />

<!--- This is a huge hack but ensures reveal-md actually copies the svg file -->
<!--- ![Schema](images/schema.svg) --->

Note:

Same as with the technical presentation on 4/1/21.

----

## For later (with new funding)

Content:
- Coarse ware typology
- Methodology: sampling method, land use, sources (all part of activities)
- (various details of) non-ceramics
- Ceramics: fragment types, fabrics, decorations (?)

Tooling:
- Graphical interface

Note:

This somewhat complements the discussion about the database schema, since in 
part the schema will need to be updated to accommodate these. Here I want to
present a list of content that we have not (yet) standardised, and is as such
not in the RHPdb. 

---

# Example queries

(finally!)

----

## Set-up

- Does everyone have the tools installed?

- Has everyone had time to look at an SQL tutorial? 

- Database location and credentials

Note:

All this uses SQL, which is why I had you install some tools (DataGrip, and a 
GIS). Has everyone got that set-up?

SQL is important, and the way you will want to get data from the database
for further post-processing in Excel/Python/GIS/some other tool. This will get
us quite a bit of _raw_ data.

Credentials: in chat, temporary for this session. Will change once we host it
permanently on the RUG servers.

----

## Structure

- Query: sites, site types, and periods

- Spatial query: ceramic finds by ware/type

- If time permits: your questions/input

Note:

Most of your example questions can be answered using variations on the queries
we develop first. Hopefully there is time to explore some of that.

We are going to develop the queries by slowly adding complexity. I will show
the general structure of the query and some examples, but feel free to explore
on your own as well during this session!

----

# Sites

- Let's first get all sites from the database:

```sql
-- Select all columns ('*' is a wildcard for all columns) from records in the
-- rhp.locations table where the location type is 'site'.
SELECT rhp.locations.*
FROM rhp.locations
         JOIN rhp.location_types
              ON locations.id_location_type = location_types.id_location_type
-- Filter by location type. Other options are 'unit', or 'subsite'.
WHERE location_types.name = 'site';
``` 

(should return 6,687 records)

Note:

Trace the lines in the schema.

This is all fairly straightforward: get all locations where location type is 
site. You can also filter by project (`id_project`, join with the `projects` 
table), or try different location types. See the `location_types` and `projects`
table for options!

----

# Query by site interpretation

- Let's get every site that has a habitation role. This is a little more complicated:

```sql
-- Selects all site data (see previous slide) where the site has a habitation
-- function in some period(s).
SELECT rhp.locations.*
FROM rhp.locations
         JOIN rhp.location_types
              ON locations.id_location_type = location_types.id_location_type
         JOIN rhp.location_interpretations
              ON locations.id_location = location_interpretations.id_location
-- Filter by location type ('site') and site type (something 'Habitation'). 
WHERE location_types.name = 'site'
-- The bit below selects all interpretations (by their ID) that have an RHP 
-- 'Habitation' hyper class (parent). This is known as a 'recursive subquery'
-- in SQL jargon.
  AND location_interpretations.id_interpretation IN (
    WITH RECURSIVE tree AS (
        (
            SELECT interpretation_hierarchy.id_interpretation
            FROM rhp.interpretation_hierarchy
                     JOIN rhp.interpretations
                          ON interpretation_hierarchy.id_parent = interpretations.id_interpretation
            WHERE interpretations.name = 'Habitation'
              and interpretations.id_project = 1 -- RHP project ID
        )
        UNION ALL
        (
            SELECT ih.id_interpretation
            FROM rhp.interpretation_hierarchy ih
                     JOIN tree ON ih.id_parent = tree.id_interpretation
        )
    )
    SELECT *
    FROM tree
);
```

(should return 14,412 records)

Note:

Explain FROM/JOIN by tracing lines in the schema. Explain subquery by looking
at the `interpretation_hierarchy` table.

Something's wrong here. The count is bigger than the one in the previous slide.
Did we get more results all of a sudden? Are we making a mistake? 

Show duplication in query results!

*Yes*, we are: `locations` to `location_interpretations` is a one-to-many
relationship. The `JOIN` we do results in multiple records for each site, so
we need to filter then away with `DISTINCT`. That results in 3,279 sites, which
is more like we expected.

Also try `Urban settlement` here, and link back to original projects (i.e. 
query original data by `id_origin`).

----

# Query by time and certainty

- The following query gets all sites that were plausibly in use between
  200BC and 200AD:
  
```sql
-- This query selects all sites that are plausibly (probably + certain) in use
-- between 200BC and 200AD.
SELECT DISTINCT rhp.locations.*
FROM rhp.locations
         JOIN rhp.location_types
              ON locations.id_location_type = location_types.id_location_type
         JOIN rhp.location_interpretations
              ON locations.id_location = location_interpretations.id_location
         JOIN rhp.periods
              ON location_interpretations.id_period = periods.id_period
         JOIN rhp.certainties
              ON location_interpretations.id_period_certainty = certainties.id_certainty
WHERE location_types.name = 'site'
  AND certainties.name IN ('probable', 'certain')
  AND periods.start_year < 200  -- what does this construct do?
  AND periods.end_year > -200;
```

(should return 5,072 records)

**Extensions:**

- You can combine this with the query of the previous slide - what would that return?
- Here we filter on period certainty. What about interpretation certainty?

Note:

The `periods.start_year < 200` and `periods.end_year > -200` test for overlap in
the time period. (maybe draw?)

Extensions:

The first would get all inhabited sites between 200BC and 200AD.

The second requires another join, like so:

```sql
JOIN rhp.certainties AS int_cert
    ON location_interpretations.id_interpretation_certainty = int_cert.id_certainty
```

Note the use of an ALIAS (`AS int_cert`) - the same is needed for the period join.
This results in, for example, the following query:

```sql
SELECT DISTINCT rhp.locations.*
FROM rhp.locations
         JOIN rhp.location_types
              ON locations.id_location_type = location_types.id_location_type
         JOIN rhp.location_interpretations
              ON locations.id_location = location_interpretations.id_location
         JOIN rhp.periods
              ON location_interpretations.id_period = periods.id_period
         JOIN rhp.certainties AS per_cert
              ON location_interpretations.id_period_certainty = per_cert.id_certainty
         JOIN rhp.certainties AS int_cert
             ON location_interpretations.id_interpretation_certainty = int_cert.id_certainty
WHERE location_types.name = 'site'
  AND per_cert.name IN ('probable', 'certain')
  AND int_cert.name IN ('probable', 'certain')
  AND periods.start_year < 200
  AND periods.end_year > -200;
```

(returns 3,706 records)

----

# Artefacts (spatial)

- Let us first get all diagnostic artefacts on sites:

```sql
-- Selects all diagnostic artefacts found on sites.
SELECT rhp.artefacts.*
FROM rhp.artefacts
         JOIN rhp.artefact_locations
              ON artefacts.id_artefact = artefact_locations.id_artefact
         JOIN rhp.locations
              ON artefact_locations.id_location = locations.id_location
         JOIN rhp.location_types
              ON locations.id_location_type = location_types.id_location_type
WHERE location_types.name = 'site'
  AND artefacts.is_diagnostic = TRUE;
```

(returns 67,898 records)

Note:

**FROM HERE ON, OPEN QGIS AS WELL**

There is nothing spatial about this yet, but now we do have a link through the
`locations` table, so we can add that in quickly.

The table `artefact_locations` encodes a many (artefacts) to one (locations)
relationship. Since we come from the artefacts side in this query (we start
with artefacts), this does not need special treatment with e.g. `DISTINCT`. 

----

# Count finds per site

- Number of diagnostic artefacts per site, and site information:

```sql
-- Counts (sums) the number of diagnostic artefacts found per site. Also
-- retrieves location data (again via a wildcard).  
SELECT rhp.locations.*, SUM(rhp.artefacts.number) AS sherd_count
FROM rhp.artefacts
         JOIN rhp.artefact_locations
              ON artefacts.id_artefact = artefact_locations.id_artefact
         JOIN rhp.locations
              ON artefact_locations.id_location = locations.id_location
         JOIN rhp.location_types
              ON locations.id_location_type = location_types.id_location_type
WHERE location_types.name = 'site'
  AND artefacts.is_diagnostic = TRUE
GROUP BY locations.id_location;
```

(returns 2,749 records)

Note:

What's new here are `ALIAS` (maybe) and `GROUP BY`, and aggregations.

----

## Finds per site, of certain ware

- For general coarse wares, and more specific coarse ware types:

```sql
-- Counts (sums) the number of diagnostic coarse ware artefacts found per site.
SELECT rhp.locations.*, SUM(rhp.artefacts.number) AS sherd_count
FROM rhp.artefacts
         JOIN rhp.artefact_locations
              ON artefacts.id_artefact = artefact_locations.id_artefact
         JOIN rhp.locations
              ON artefact_locations.id_location = locations.id_location
         JOIN rhp.location_types
              ON locations.id_location_type = location_types.id_location_type
         JOIN rhp.wares
              ON artefacts.id_ware = wares.id_ware
WHERE location_types.name = 'site'
  AND artefacts.is_diagnostic = TRUE
  AND artefacts.id_ware in (
    WITH RECURSIVE tree AS (
        (
            SELECT wares.id_ware
            FROM rhp.wares
            WHERE wares.name = 'Coarse ware'
        )
        UNION ALL
        (
            SELECT wares.id_ware
            FROM rhp.wares
            JOIN tree ON tree.id_ware = wares.id_parent
        )
    )
    SELECT *
    FROM tree
)
GROUP BY locations.id_location;
```

(returns 2,493 records)

Note:

Show wares table and hierarchy. Also simplify query when only selecting one
ware (**'African red slip'**), not hierarchy.

I re-used the recursive subquery here since we already discussed it, but there
is a simpler way to write this (but it does involve some duplication)!

----

## Finds per site, with type

- This would get all sites where a `Hayes 23a` artefact has been found:

```sql
-- Counts (sums) the number of diagnostic coarse ware artefacts found per site.
SELECT rhp.locations.*, SUM(rhp.artefacts.number) AS sherd_count
FROM rhp.artefacts
         JOIN rhp.artefact_locations
              ON artefacts.id_artefact = artefact_locations.id_artefact
         JOIN rhp.artefact_types
              ON artefacts.id_artefact_type = artefact_types.id_artefact_type
         JOIN rhp.locations
              ON artefact_locations.id_location = locations.id_location
         JOIN rhp.location_types
              ON locations.id_location_type = location_types.id_location_type
WHERE location_types.name = 'site'
  AND artefacts.is_diagnostic = TRUE
  AND artefact_types.name = 'Hayes 23a'
GROUP BY locations.id_location;
```

(should return 29 records)

Note:

Also try `Hayes 23b`, and `Hayes 23%` (`LIKE`).

---

# Your input

(if time permits)

---

# Questions?

---

# That's all, folks!

- These slides are all online, so you can (re-)read them later.
 
- To facilitate re-use, there are a lot of (speaker) notes in the presentation.

- Anything unclear? Mail me at [nielswouda@gmail.com](mailto:nielswouda@gmail.com), 
  or contact me through the GitHub repository. 