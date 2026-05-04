---
title: Maturity pyramid and personas
linkTitle: 2.1 Maturity pyramid
weight: 2
---

The deck frames a **pyramid of maturity**: easy wizards at the bottom, advanced SignalFlow and cross-system analytics at the top. Different **personas** stop at different heights; and that is OK.

![Personas and maturity pyramid (slide deck)](../../images/slides/slide-05.png?width=90vw)

## Levels (summary)

| Tier | How you work | Examples |
|---|---|---|
| **Easy (wizard)** | APM / Synthetics / built paths | Fast coverage, sometimes noisy if mis-tuned |
| **Moderate (detector UI)** | Resource exhaustion, error rates, heartbeats, streaming `sum()` / `mean()`, simple equations (`A/B*100`) | More knobs than the wizard |
| **Advanced (SignalFlow in detectors)** | Boolean streams, `when()`, imports from the SignalFlow library | Full control; needs review and testing |
| **O11y + Splunk** | SignalFlow plus **SPL** for business logic spanning telemetry types | Cross-team aggregation, audits |

## Personas (from the deck)

- **All users**: wizards and out-of-the-box detectors.
- **Service / SLO owners**: thresholds tied to user-visible reliability.
- **SRE / senior developers**: deeper troubleshooting, multi-signal conditions.
- **Platform / data-oriented roles**: statistical detectors, library code, SPL crossover.

The point is not to rush everyone to the top; it is to **choose the right tier** for the risk and the team’s skill.

---

**Next:** [Detector wizard vs full detector UI](3-detector-wizard-vs-ui/)
