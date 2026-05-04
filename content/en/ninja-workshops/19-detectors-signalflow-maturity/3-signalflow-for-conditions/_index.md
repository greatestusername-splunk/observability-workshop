---
title: "Phase 2: SignalFlow for detector logic"
linkTitle: 3. SignalFlow conditions
weight: 3
archetype: chapter
time: 45 minutes
description: SignalFlow for detectors; challenges and reveals (booleans, when()), plus six pipeline-trap question sets (ordering, dimensions, comparisons, smoothing, nulls, cardinality).
---

{{% notice title="How this section teaches" style="primary" icon="lightbulb" %}}
The **deck works** because it poses a **real use case**, lets people **try** (whiteboard, pair work, or Chart Builder), then shows an **answer**. The pages below mirror that: **read the challenge → attempt it → open “Reveal”** when you are ready. Skipping straight to the code defeats the exercise.
{{% /notice %}}

**Phase 2** is where **monitoring logic** starts to look like **data engineering**: you are still producing a boolean “should we alert?” decision, but the input is often **many** time series, **windows**, and **functions**; not one static cut line.

SignalFlow is the **DSL** for metric time series in Splunk Observability: query data, apply functions and math, **Python-like** syntax, imports for statistics helpers, JSON import/export, and APIs (including **Terraform**). Detectors are a common place where that expressiveness matters.

SignalFlow is the same analytics substrate you may already know from [Chart Builder](../../7-dashboards-detectors/dashboards/1-08-signalflow/); in detectors, you use it when the condition is **easier to express as a program** than as a threshold on one plot.

{{% notice title="Detector editor URLs" style="info" %}}
Direct links (realm **`us1`** shown; substitute yours): new detector with SignalFlow: `https://app.us1.signalfx.com/#/detector/v2/new?SignalFlow` · edit with editor: `https://app.us1.signalfx.com/#/detector/v2/<Detector_ID>/edit?detectorSignalFlowEditor=1`
{{% /notice %}}

{{% notice title="Docs" style="info" %}}
Background: [Analyze incoming data using SignalFlow](https://docs.splunk.com/Observability/infrastructure/analytics/signalflow.html).
{{% /notice %}}

