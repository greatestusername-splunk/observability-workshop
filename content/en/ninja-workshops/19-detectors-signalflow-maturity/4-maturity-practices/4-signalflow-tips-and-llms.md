---
title: SignalFlow tips, LLMs, and common questions
linkTitle: 4.4 Tips, LLMs & FAQ
weight: 4
---

## Practical SignalFlow tips (from the deck)

![SignalFlow practical tips: Metric Finder, fill, charts, publish (slide deck)](../../images/slides/slide-22.png?width=90vw)

- **Metrics Finder**: discover metrics and **dimensions**; filter to service, environment, etc.
- **Missing data**: “no data” is not zero; use extrapolation policies or **`.fill(0)`** when you need zeros for math.
- **Chart before detector**: plot complex conditions; use **`const()`** for comparisons so history is visible.
- **`publish(enable=False)`**: hide intermediate streams while debugging to reduce clutter.
- **Build up**: verify each step’s output; when dimensions disappear, the bug is usually **earlier** in the chain (for example **`sum()`** without the right **`by`**).
- **Specialized detectors**: synthetics, historical anomaly, etc. often expose **substreams** you can chart; bookmark **method docs** and the **signalflow-library** repo.

![Deck: specialized detectors as charts, docs, GitHub, LLM caveat](../../images/slides/slide-23.png?width=90vw)

## LLMs and SignalFlow

![Signalflow and LLMs: document context and hallucination guardrails](../../images/slides/slide-24.png?width=90vw)

LLMs can accelerate learning **if** you constrain them:

- Provide **official** SignalFlow docs or collated references as context.
- In prompts, **forbid** Javascript, PromQL, Grafana-flavored syntax; ask for **SignalFlow only**.
- Supply **real metric names** you verified in Metrics Finder to reduce invented series.
- Cross-check function names against [SignalFlow methods](https://dev.splunk.com/observability/docs/signalflow/methods).

Hallucinations are common; treat generated programs as **first drafts** to run in Chart Builder, not production detectors.

## Common questions (FAQ)

![Deck: common troubleshooting questions](../../images/slides/slide-25.png?width=90vw)

| Symptom | What to check |
|---|---|
| **Dimensions vanish** after a transform | Every aggregation: keep dimensions you need later in at least one **`by=`** / grouping; later steps cannot recover what was dropped. |
| **Rollup changed and numbers look wrong** | Defaults are usually right; if you need latest vs mean vs max, use **`latest()`**, **`mean()`**, **`max()`**, etc. explicitly. |
| **Multi-stream detector loses dimensions on alert** | The stream you **`detect()`** on must carry the dimensions you need in notifications; if combining booleans, ensure the **final** stream still has the right identity dimensions. |

## Pipeline traps (student questions)

The six **pipeline-trap** topics (ordering, dimensions, comparisons, smoothing, nulls, cardinality) are expanded into **question + reveal** drills in Phase 2: **[Pipeline traps: six question sets](../../3-signalflow-for-conditions/7-pipeline-traps/)**. Run that page in the room; the FAQ table above stays the quick **symptom → check** reference.

---

**Next:** [Advanced examples](../5-advanced-examples/)
