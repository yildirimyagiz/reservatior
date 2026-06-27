# Payment Optimization & Routing Engine

## Objective
Optimize total transaction cost, settlement speed, and risk exposure across multiple payment rails.

---

## Payment Rails Supported

- Card Payments (PSP: Param / Paratika / Sipay)
- Virtual Card (VCC legacy systems)
- Open Banking (A2A / VRP / PISP)
- Bank Hold (authorization-based escrow)

---

## Core Principle

Payment selection is not fixed.
It is dynamically selected per transaction based on:

- cost efficiency
- fraud risk
- settlement speed
- success probability

---

## Routing Logic

```
IF risk_score LOW AND country supports A2A:
    USE Open Banking (A2A / VRP)

ELSE IF card success probability HIGH:
    USE PSP card routing

ELSE:
    USE VCC fallback layer
```

---

## Cost Optimization Target

- VCC reduction
- FX fee reduction
- PSP fee reduction
- reconciliation cost reduction

---

## Expected System Impact

- Payment cost reduction: 1% – 4%
- Operational efficiency gain: 1% – 3%
- Fraud reduction impact: 1% – 5%

---

## Key Output

- Selected payment rail
- Expected cost saving %
- Risk score adjustment
- Settlement speed score
