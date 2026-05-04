---
title: when() and sustained conditions
linkTitle: 3.5 when() duration
weight: 5
---

You already built a **boolean** that can flicker sample-to-sample. **`when()`** answers: “Was this condition **true enough of the time** in a **window**?” That question is the slide deck’s bridge from **boolean logic** to **operator-trustworthy** paging.

---

## Challenge 2: Sustained badness, not a single blip

**Scenario (from the deck):** For Kubernetes containers, you want to detect when:

- There has been **more than zero** restarts (aligned to how you measure restarts per container), **and**
- **CPU usage is above 70%**,

**and** that **combined** situation is true for **at least 80%** of the reporting intervals across the **last 10 minutes**.

So: one bad sample is **not** enough; **most** of the window should be bad.

![Deck exercise: sustained combined condition over 10m at 80% (slide deck)](../../images/slides/slide-14.png?width=90vw)

### Before you open any reveal

1. Start from the **same combined boolean** idea as Challenge 1 (restarts ∧ CPU>70); reuse your own metric names or the pattern from the previous reveal.
2. Introduce **`when(...)`** ([when() Docs](https://dev.splunk.com/observability/docs/signalflow/methods)) so the condition must hold **across** a **`10m`** window with **`at_least=0.8`** (80%).
3. **`publish`** a stream you could alert on (for example a label like **`sus`** in the deck; pick a serious name in production).

Work in **Chart Builder** first and watch the output over history.

## Reference: `when()` parameters

For `when()` reference use this as a cheat sheet:

`when(predicate [, lasting=duration][, at_least=percentage])`

| Piece | Role |
|---|---|
| **`predicate`** | Usually your **boolean** stream (or equivalent). |
| **`lasting`** | Window to evaluate (for example **`"10m"`**). |
| **`at_least`** | Fraction of that window the condition must hold (**`0.8`** = 80%). |

---

{{% notice title="Facilitation" style="primary" %}}
This is the **hardest** exercise in the block; budget **10+ minutes**. Encourage people to **draw** the boolean vs the `when()` output on a timeline.
{{% /notice %}}

{{% expand title="Hints" %}}
- API shape to research: **`when(predicate is True, lasting, at_least)`**: confirm exact argument names in the [SignalFlow reference](https://dev.splunk.com/observability/docs/signalflow/methods) for your version.
- You are turning a **boolean stream** into a **value stream** that encodes sustained violation; **threshold that** in the detector if needed.
{{% /expand %}}

{{% expand title="Reveal: sample solution + what when() is doing" %}}

![Deck reference: when() with combined boolean and publish](../../images/when-signalflow-challenge.png?width=90vw)

```python
first_condition = data("k8s.container.restarts").sum(over="1m").sum("k8s.container.name") > 0
second_condition = data("container_cpu_utilization").mean(over="5m").mean("k8s.container.name") > 70

combined_condition = first_condition and second_condition
s = when(combined_condition is True, "10m", 0.8)
s.publish("sus")


```

**Reading this:**

- **`first_condition` / `second_condition`**: booleans per evaluation step.
- **`combined_condition`**: boolean stream; both must be true.
- **`when(combined_condition is True, "10m", 0.8)`**: over each **10m** window, the predicate must be true for **80%** of sub-intervals (per product semantics; verify in docs).
- **`publish("sus")`**: chart this before paging; rename for real incidents.

Compare to **Challenge 1:** same signals, but **`when()`** adds **duration discipline** so on-call trusts the alert.

{{% /expand %}}

---

**Next:** [Pipeline traps (six question sets)](7-pipeline-traps/)
