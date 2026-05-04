---
title: Detector wizard vs detector UI
linkTitle: 2.2 Wizard vs detector UI
weight: 2
---

## Wizard (fast path)

The **Detector Wizard** is for quickly creating common detector types (APM, Synthetics, and similar **guided** flows) **without** custom metrics, extra dimensions, or hand-written equations.

Use it when the built-in templates match your signal and you want **time-to-value**.

![Detector Wizard: APM threshold and preview (slide deck)](../../images/slides/slide-06.png?width=90vw)

## Full detector builder (more configuration)

The **Detector UI** supports broader scenarios: **resource exhaustion**, **error rates**, **heartbeats**, **streaming functions** (`sum()`, `mean()`, …), **equations** (for example `A/B*100`), and **charting custom metrics**.

This path is **deeper configuration** than the wizard; closer to what you will later express in raw SignalFlow.

![Detector UI: streaming functions and equations (slide deck)](../../images/slides/slide-07.png?width=90vw)

## SignalFlow editor (advanced)

To author or edit **detector SignalFlow** directly, open the detector editor with the **SignalFlow** experience enabled. The deck uses URLs of this shape (replace **`us1`** with your **realm** if different):

- New detector: `https://app.us1.signalfx.com/#/detector/v2/new?SignalFlow`
- Edit existing: `https://app.us1.signalfx.com/#/detector/v2/<Detector_ID>/edit?detectorSignalFlowEditor=1`

![Detector SignalFlow editor URLs (slide deck)](../../images/slides/slide-08.png?width=90vw)

{{% notice title="Realm" style="info" %}}
Swap `us1` for your org’s realm (for example `us0`, `eu0`) and substitute a real detector ID when editing.
{{% /notice %}}

---

**Next:** [SignalFlow conditions](../3-signalflow-for-conditions/)
