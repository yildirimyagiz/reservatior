# Escrow-Based Settlement System

## Objective
Ensure secure fund holding, conditional release, and risk-controlled settlement without platform custody risk.

---

## Fund Flow

```
User → Payment Hold (Bank / PSP) → Event-Based Release → Split Settlement
```

---

## Release Conditions

```
IF booking_status == COMPLETED AND no_dispute == TRUE:
    RELEASE funds

IF dispute == TRUE:
    HOLD funds until resolution
```

---

## 72-Hour Risk Window

After check-in:

- monitor guest experience signals
- track issue reports
- validate stay completion

---

## Settlement Split

At release:

- Supplier payout
- Platform fee
- Distribution partner share
- Payment rail cost adjustment

---

## Benefits

- reduces fraud exposure
- reduces chargeback risk
- improves trust
- accelerates liquidity cycle
