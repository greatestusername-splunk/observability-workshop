---
title: Workshop Overview
linkTitle: 1. Workshop Overview
weight: 1
archetype: chapter
time: 5 minutes
description: Goals, audience, and how this maturity story maps to Splunk Observability Cloud detectors and SignalFlow.
---

## What you'll learn

By the end of this workshop you will be able to:

- Place **static threshold detectors** in the right context (fast time-to-value, clear semantics)
- Explain when **SignalFlow** is the right tool for **detector conditions** (comparisons, rates, populations, windowed logic)
- Describe **maturity** practices that keep alerts **actionable** and reduce **alert fatigue**
- Cross-link hands-on steps to the existing [Dashboards and detectors](../../7-dashboards-detectors/) labs where UI screenshots live
- Work through **[pipeline trap](../3-signalflow-for-conditions/7-pipeline-traps/)** questions (ordering, dimensions, bad compares, stacked smoothing, null vs zero, cardinality)

## Who this is for

- Engineers and SREs who **own detectors** in Splunk Observability Cloud
- Anyone standardizing **alerting** after initial dashboard adoption
- Teams comparing **“threshold in the UI”** vs **analytics-style conditions**

## Prerequisites

| Requirement | Notes |
|---|---|
| Splunk Observability Cloud org | Trial or production |
| Familiarity with **charts** and **metrics** | Completing the [Dashboard](../../7-dashboards-detectors/dashboards/) module first is ideal |
| Optional | Completed [Using SignalFlow](../../7-dashboards-detectors/dashboards/1-08-signalflow/) in Chart Builder |

## Agenda (aligned to the deck)

![Workshop agenda as shown in the slide deck](../images/slides/slide-03.png?width=90vw)

| Theme | Topics |
|---|---|
| **Intro** | What SignalFlow is, why detectors, **maturity pyramid**, wizard → SignalFlow |
| **SignalFlow core** | Statistical views, **boolean** streams, **`when()`**, **[pipeline traps](../3-signalflow-for-conditions/7-pipeline-traps/)** |
| **Maturity** | Tips, **LLM** guardrails, FAQ, noise, ownership, muting |
| **Advanced examples** | Packet-loss style **populations**, **alerts/events** as metrics, **library** imports, **SPL + O11y** (dedicated section after maturity) |

## Source file

Speaker deck (same folder as the workshop chapter in git): [`Detectors-signalflow-Maturity-Story.pptx`](../Detectors-signalflow-Maturity-Story.pptx).

## How this relates to the slide deck

The **`.pptx`** is the narrative and timing guide; these pages add **permalink-friendly** detail and links to labs and docs. Update both when the story changes.
