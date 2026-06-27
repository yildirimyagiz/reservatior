# Event Driven Booking System

## Objective
Replace static booking flow with real-time event-driven orchestration.

---

## Event Bus

All system actions pass through event stream:

- booking.created
- inventory.checked
- payment.authorized
- booking.confirmed
- failover.triggered
- payment.captured

---

## Booking State Machine

```
INITIATED
→ SEARCHING
→ AVAILABILITY_CHECKED
→ RESERVED
→ PAYMENT_PENDING
→ CONFIRMED
→ CHECKED_IN
→ COMPLETED
```

---

## Failover Path

```
IF availability == false:

INITIATED
→ FAILOVER_TRIGGERED
→ ALTERNATIVE_SEARCH
→ REBOOKING
→ CONFIRMED
```

---

## Benefits

- real-time decisioning
- scalable architecture
- independent services
- resilience against failure
