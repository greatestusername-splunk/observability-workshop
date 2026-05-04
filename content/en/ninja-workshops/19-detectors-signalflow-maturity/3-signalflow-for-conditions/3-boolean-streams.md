---
title: Boolean streams
linkTitle: 3.4 Boolean streams
weight: 4
---

## Concept (read this first)

In SignalFlow, a **boolean stream** is a time series whose values are **true** or **false** (or equivalent) over time. You combine them with **`and`**, **`or`**, and **`not`**; the same logic you would write for **multiple** independent checks.

That lets you **decompose** a scary alert into **small** questions (“are we restarting?” **and** “is CPU hot?”) and **compose** the answers.

![Boolean streams: composing conditions with AND/OR/NOT (slide deck)](../../images/slides/slide-11.png?width=90vw)

---

## Challenge 1: Restarts **and** high CPU

**Scenario (from the deck):** You need a **single** published stream that is **true** when the system is in a **bad combined state**:

1. **Container restarts** are happening (non-zero restart activity over a window that matches how your metric is reported).
2. **CPU utilization** is **above 70%** (use a rolling **`mean`** or the rollup that matches your chart).

You will use **Metrics Finder** (or your catalog) to pick **real** metric names and dimensions in **your** org; the slide uses names like `k8s.container.restarts` and `container_cpu_utilization` as **examples only**.

![Deck exercise: compose restarts ∧ CPU into one published stream](../../images/slides/slide-12.png?width=90vw)

```
critical_condition = (data("k8s.some.metric").sum(over="5m").sum("k8s.container.name") > 0) and (data("some.other.metric").mean(over="5m").mean("k8s.container.name") > 80)

critical_condition.publish("Critical Condition")
```

### Before you open any reveal

Do this in **pairs** or solo, on paper or in **Chart Builder**:

1. Copy the **two** `data(...)` lines above; one for restarts (more than `10`), one for CPU (greater than `80`%); use metric finder to find a k8s restarts metric and a container cpu utilization metric. Filter to the **same** entities you care about (for example per k8s container name).
2. Turn each into a **comparison** that yields a **boolean** (for example `... > 10`, `... > 80`).
3. Combine them with **`and`**.
4. **`publish`** a single stream you would attach to a detector rule (name it clearly).

Debug with **`publish(..., enable=True)`** on intermediates so you can **see** each side before you `and` them.

**NOTE:** Choose `Column` visualization to more easily see boolean "events" that are either true (value on the chart) or false (no value/zero value).

{{% notice title="In the workshop room" style="primary" %}}
**5–10 minutes** of struggle here is the lesson. If you jump to the reveal, you only copy text; you do not build the mental model for **rollups** and **dimensions**.
{{% /notice %}}

{{% expand title="Hints (still not the full answer)" %}}
- Restart signals are often aggregated with **`sum(over=...)`** or similar; CPU is often **`mean(over=...)`**.
- If **`and`** returns something empty or nonsense, your two sides probably **do not share the same grouping**; align **`sum(...)` / `mean(...)`** and **`by=`** dimensions so both refer to the **same** thing (for example the same `k8s.container.name` and/or `k8s.cluster.name`).
{{% /expand %}}

{{% expand title="Reveal: one possible solution" %}}

This matches the **spirit** of the slide answer; **rename metrics** to what Metrics Finder shows for you.

```python
first_condition = data("k8s.container.restarts").sum(over="1m").sum("k8s.container.name") >= 1
second_condition = data("container_cpu_utilization").mean(over="5m").mean("k8s.container.name") > 80


combined_condition = first_condition and second_condition
combined_condition.publish("combined_condition")
```

**Why it works:** `critical_condition` is itself a **boolean stream**. A detector can threshold it, or you can feed it into **`when()`** on the next page for **duration** logic.

{{% /expand %}}

---

**Next:** [when() and sustained conditions](5-when-duration/)
