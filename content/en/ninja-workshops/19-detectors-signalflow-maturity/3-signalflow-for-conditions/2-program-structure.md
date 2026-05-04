---
title: SignalFlow program patterns
linkTitle: 3.2 Program patterns
weight: 2
---

## Anatomy of a small program

Most SignalFlow snippets you will ship in detectors follow the same skeleton:

1. **`data(...)`**: select metric time series with **filters**
2. **Transform**: `percentile`, `sum`, `timeshift`, `publish`, etc.
3. **Combine**: arithmetic or boolean logic on series
4. **Publish**: one or more outputs; for alerting, you typically care about **one decision stream**

The **alert rule** consumes the published stream that encodes “badness” (or feeds **`when()`** first).

---

## Mini challenge: week-over-week latency delta

![Latency Mini-Exercise start](../../images/latency-mini-challenge.png?width=90vw)

**Setup:** You already chart **`spans.duration.ns.p99`** for each service (`sf_service`) in each environment (`sf_environment`). You want time series **C** to represent **What % more or less laggy this week is than the same window last week**; classic **seasonality-aware** monitoring. 

### Before you open the reveal

Answer **without** looking at code:

1. Stream **A**: current P99 latency grouped by `sf_service` and `sf_environment` 
2. Stream **B**: same stream as **A**, but **time-shifted** one week (**`timeshift('1w')`**).
3. What should **C** look like to show percentage(%) difference between current and 1 week ago?

Sketch the three streams on a whiteboard, scratch pad, or in a chart, then open the reveal.

{{% expand title="Reveal: reference SignalFlow (Dashboard lab pattern)" %}}


```python
A = data('spans.duration.ns.p99').mean(by=['sf_service', 'sf_environment']).publish(label='A', enable=False)
B = A.timeshift('1w').publish(label='B', enable=False)
C = ((A-B)/B*100).mean(over='1h').publish(label='Pct Change vs 1w ago')
```

**C** is the **week-over-week difference** in P99 latency. Alerting on **C** (or **C** sustained via **`when()`**) is often more meaningful than a fixed ms threshold for duration.
d

**Note:** You may want to add a filter to your chart (or time serieses) for a given environment (E.G. `sf_environment:signal-flow-workshop`) to more easily see what you are charting.

**SAVE THIS CHART** to a new dashboard or your user dashboard.

{{% /expand %}}

---

## Generalize to your services

Pick one chart you already trust. Write down **before** coding:

- What is **A** (current reality)?
- What is **B** (baseline: shift, aggregate, or peer group)?
- What is **C** (the **comparison** you would page on)?

Then implement **C** in Chart Builder, then consider a detector.

---

**Next:** [From chart to detector](3-from-chart-to-detector/)
