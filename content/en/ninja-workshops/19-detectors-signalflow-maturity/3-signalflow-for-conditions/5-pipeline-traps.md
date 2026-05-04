---
title: Pipeline traps six question sets
linkTitle: 3.7 Pipeline traps
weight: 7
description: Short questions on ordering, dimensions, comparing streams, smoothing, nulls, cardinality, and how SignalFlow “looks wrong” when it is really misunderstood.
---

These drills match the **debugging angles** in [Tips & FAQ](../4-maturity-practices/4-signalflow-tips-and-llms/) (same six topics). Work them **on a whiteboard or out loud** before opening the reveal.

---

## 1: Pipeline order

Pipeline order matters! What happens when you sum before you mean? Or you mean before you sum?

Example:
```
# Sum over 1 hour, then mean over 1 hour, sum by environment
chart_a = data(
    'spans.duration.ns.p99',
    filter=filter('service.name', 'p*'),
).sum(over="1h").mean(over="1h").sum(by="sf_environment").publish('A_sum_mean_1h_by_env')

# Mean over 1 hour, then Sum over 1 hour, sum by environment
chart_b = data(
    'spans.duration.ns.p99',
    filter=filter('service.name', 'p*'),
).mean(over="1h").sum(over="1h").sum(by="sf_environment").publish('B_mean_sum_1h_by_env')

```

What do you notice about the values of these two metric streams when you compare various data points **sorted by value** when you click on a datapoint in the chart and view the Data table?

{{% expand title="Reveal" %}}
You should see that both Plot Names (`A_sum_mean_1h_by_env` and `B_sum_mean_1h_by_env`) can (but won't necessarily always) have different values. The order of your operations matter!

For another example try moving that `sum(by="sf_environment")` earlier in the order and see what happens

**Takeaway:** Make sure you are doing the math you think you are doing. This is especially important when using methods like `top()` or `max()` which may exclude whole time serieses or individual data points

![answer](../../images/pipeline-order-answer.png)

{{% /expand %}}

---

## 2: Aggregation drops dimensions

A final **`sum()`** with **no** dimension argument collapses **all** MTS into one; any **`service.name`**, **`host`**, or **`sf_environment`** on the raw metric is **lost** unless an earlier step kept it.

Example (APM-style span counts; adjust `filter` / metric to your org):

```
# Preserves one time series per service/enviroment after the minute rollup
chart_a = data(
    'spans.count',
    filter=filter('sf_service', 'p*'),
).sum(over='1m').sum(['sf_service', 'sf_environment']).publish('per_service')

# Collapses to a single plot: sf_service dimensions are gone after the first sum() by sf_environment
chart_b = data(
    'spans.count',
    filter=filter('sf_service', 'p*'),
).sum(over='1m').sum(["sf_environment"]).sum(["sf_service"]).publish('everything_mixed')
```

Open **both** plots on one chart. In the **Data table**, compare how many **Plot Name** rows you see and which **dimension** columns are still populated. What would you change if you need **one detector per `sf_service`**?

{{% expand title="Reveal" %}}
**`chart_a` (per_service)** keeps **`service.name`** on the stream so you can page **per service**.  
**`chart_b` (everything_mixed)** sums every matching MTS into **one** aggregate for environment; then tries to sum by **`sf_service`** and when trying to sum across service fails to have access to all of the service names. 

**Takeaway:** After **`sum()` / `mean()`**, say which dimensions **survived**. Bare **`sum()`** is almost always “everything together”; often not what you meant for alerts.

![answer](../../images/aggregation-drop.png)

{{% /expand %}}

---

## 3: Apples-to-oranges

You want a detector on **`A > B`**, but the two sides were built for different jobs. Same underlying signal; **incomparable** rollups.

Example:

```
# A: 5m mean of span rate, grouped by cluster (example dimension)
plot_a = data(
    'spans.count',
    filter=filter('sf_service', 'p*'),
).mean(over='5m').mean('sf_service')

# B: 1h sum, grouped by environment: different window AND different grouping key
plot_b = data(
    'spans.count',
    filter=filter('sf_service', 'p*'),
).sum(over='1h').sum('sf_environment')

# If someone naively writes (A > B) the comparison is rarely meaningful

A = (plot_b / plot_a).publish("ratio")
```

Plot **`A`** and **`B`** separately first. Do the **timestamps**, **windows**, and **entity keys** line up row-for-row in the Data table? What goes wrong if you **`and`** or **compare** these in one detector?

{{% expand title="Reveal" %}}
**`A`** and **`B`** have totally different groupings and because of those groupings do not have matching attributes to compare by. When trying (badly) to get our ratio with division we can not rationalize the timeseries or correlate across our available dimensions and get a signalflow computation error (screenshot)

![answer](../../images/grouping-failure.png)

**Takeaway:** Before **`>`** (or any other math/comparison/union/etc), assert **same dimension keys**, **same rollup window**, and **compatible units**. Otherwise fix the SignalFlow to have a dimension to correlate against

{{% /expand %}}

---

## 4: Sparse null vs zero

**Synthetics** emit **run duration** with dimensions like **`location_id`**. Here you compare **current** total duration per location to **the same metric shifted back one year** (`timeshift('52w')`). Any location or time bucket where **nothing ran a year ago** has **no** point on the **`previous`** series, not a **zero**. That is deliberate: the shift **forces** real **null gaps** you can see in the Data table.

Subtracting **`current - previous`** follows normal rules: if **`previous` is null**, the difference **emits no output** for that row (null propagates). **`.fill(0)`** on **`previous`** turns those gaps into **zeros**, so the subtraction **always** produces a number, often **`current`** (because **`current - 0`**), even when “a year ago” was **unknown**, not “zero duration.”

Example (adjust metric name / filters to your org’s synthetics):

```
current = data(
    'synthetics.run.duration.time.ms',
    filter=filter('location_id', '*', 'failed', 'true'),
).sum(by=['location_id'])

# Same signal, shifted 52 weeks: missing history becomes null, not 0
previous = data(
    'synthetics.run.duration.time.ms',
    filter=filter('location_id', '*', 'failed', 'true'),
).timeshift('52w').sum(by=['location_id'])

# Nulls propagate: no row where previous is missing
diff_nulls = (current - previous).publish('diff_nulls_propagate')

# Previous missing buckets become 0 before subtract; subtraction always has a value
diff_fill0 = (current - previous.fill(0)).publish('diff_prev_filled_zero')
```

Chart **both** plots. In the **Data table**, scan for timestamps (and **`location_id`** if present) where **`diff_nulls_propagate`** has **no value** but **`diff_prev_filled_zero`** shows a number. What did **`.fill(0)`** assume about “no run a year ago”? When is that assumption **unsafe** (for example **new** locations, **retired** checks, or bad ingest)? This can often happen if a given host hasn't reported consistently, a synthetic test from a specific location only runs occasionally, or any other situation where reporting intervals are sporadic.

{{% expand title="Reveal" %}}
Where **`previous`** is **null**, **`current - previous`** does not plot a point: **missing last year** stays **missing** in the diff. After **`previous.fill(0)`**, those slots behave like **`current - 0`**, so you get a **numeric** diff even when the honest answer was **“we don’t know last year.”** That can look like a huge swing or a false “all clear,” depending on scale.

**Takeaway:** Choose **`.fill(0)`** only when **no point = legitimately zero** for that math. For **comparisons over long gaps** (52w), **null** usually means **unknown history**; filling without saying so hides it.

![answer](../../images/null-zero-propagation.png)

{{% /expand %}}

---

**Next:** [Maturity practices](../4-maturity-practices/)
