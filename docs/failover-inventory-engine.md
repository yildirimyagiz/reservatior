# Failover Inventory Engine

## Objective
Prevent booking loss when primary hotel inventory is unavailable.

---

## Core Problem

Traditional systems:
```
Hotel unavailable → booking lost
```

---

## Solution

```
Hotel unavailable → alternative inventory routing
```

---

## Inventory Sources

- Hotels (primary)
- Nearby hotels
- Serviced apartments
- Partner inventory (aggregators)
- Dynamic rental supply

---

## Decision Flow

```
IF hotel_available:
    BOOK hotel

ELSE:
    SEARCH alternative inventory
    RANK options by:
        - price
        - distance
        - trust score
        - conversion probability

    SELECT best option
    OFFER to user
```

---

## Impact

- reduces lost bookings
- increases conversion rate
- increases inventory utilization
- stabilizes revenue flow
