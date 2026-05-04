---
title: Noise, severity, and ownership
linkTitle: 4.2 Noise and ownership
weight: 2
---

## Alert fatigue is a product defect

If responders **mute without fixing**, that is a signal that the **detector** is mis-specified; not that humans are lazy.

### Reduce noise without hiding failure

- **Tighten the condition**: duration, hysteresis, or SignalFlow that compares to baseline (Phase 2)
- **Raise severity only when response changes**: “Critical” should mean **wake someone up now**
- **Route by service**: notifications go to the team that can **act**, not the largest distribution list

### Ownership artifacts

For each detector, document:

| Field | Example |
|---|---|
| **Service** | `checkout-api` |
| **Owner** | `@checkout-oncall` |
| **Business impact** | “Blocks guest checkout” |
| **First step** | Link to dashboard or runbook |

Splunk Observability Cloud integrates with many **notification** channels; maturity is choosing **fewer, better** destinations and keeping them **current**.

---

**Next:** [Muting discipline and runbooks](3-muting-and-runbooks/)
