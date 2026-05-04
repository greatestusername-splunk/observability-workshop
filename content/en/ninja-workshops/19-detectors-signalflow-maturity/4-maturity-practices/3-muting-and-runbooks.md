---
title: Muting discipline and runbooks
linkTitle: 4.3 Muting and runbooks
weight: 3
---

## Muting is a controlled outage

**Muting rules** exist so maintenance does not spam pages; but **indefinite** muting without a ticket is how incidents hide.

Hands-on steps for muting and resuming are in the Dashboard workshop:

- [Working with Muting Rules](../../7-dashboards-detectors/detectors/muting/)

### Maturity checklist

- **Time-bounded** muting when possible (maintenance window) vs **indefinite** (only with explicit approval)
- **Reason** field filled so the next engineer knows **why**
- **Resume** verified after work completes

## Runbooks pair with detectors

A runbook does not need to be long. Minimum viable:

1. **Validate**: “How do I confirm this alert is real?”
2. **Mitigate**: “What is the first safe change?”
3. **Escalate**: “When do I pull in platform / vendor?”

{{% notice title="Link from alert messages" style="info" %}}
Use alert message templates to include **deep links** to the right dashboard or incident workflow; reduce context switching at 3 a.m.
{{% /notice %}}

---

**Next:** [SignalFlow tips, LLMs, and FAQ](4-signalflow-tips-and-llms/)
