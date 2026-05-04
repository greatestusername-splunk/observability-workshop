---
title: When to use SignalFlow in detectors
linkTitle: 3.1 When to use SignalFlow
weight: 1
---

## Signalflow

![What SignalFlow is and why detectors use it (slide deck)](../../images/slides/slide-04.png?width=90vw)

Reach for **SignalFlow-backed conditions** when you need to express ideas like:

| Idea | Why a static cut fails |
|---|---|
| **over time** regression | You need two shifted series and a **difference** or **ratio** |
| **Population comparison** | Thousands of hosts; **percentile** or **count above threshold** across the fleet |
| **Rate of change** | “Spike” is about **derivative** or windowed **delta**, not absolute level |
| **Burn-style logic** | Error budget or **SLO-style** comparisons over sliding windows |
| **MANY MANY OTHER CASES** | This list is **NOT** exhaustive! |


## Relationship to charts

Detectors are just charts with a [`detect()` method](https://dev.splunk.com/observability/docs/signalflow/functions/detect_function)

![SignalFlow: arbitrary comparisons, thresholds, and when() (slide deck)](../../images/slides/slide-09.png?width=90vw)

A practical workflow:

1. **Prototype in Chart Builder**: prove the math visually (see [Using SignalFlow](../../7-dashboards-detectors/dashboards/1-08-signalflow/) in the Dashboard lab).
2. **Promote to alerting**: once the SignalFlow program is stable, attach the same logic to a **detector** so paging matches what you already trust on the dashboard.

{{% notice title="Team habit" style="primary" %}}
If the on-call engineer cannot explain the SignalFlow in **two sentences**, keep iterating in Chart Builder first. Maturity means **shared understanding**, not clever programs.
{{% /notice %}}

From here on, **[Boolean streams](4-boolean-streams/)** and **[when()](5-when-duration/)** use **challenge → reveal** pedagogy aligned to the slides; **try the use cases** before you expand the answers.

---

**Next:** [SignalFlow program patterns](2-program-structure/)
