# AI Orchestration Layer (Gemini Market Intelligence)

## Objective
Use LLM (Gemini) as a real-time market interpretation and scenario generation layer for accommodation pricing and inventory decisions.

---

## Core Principle

LLM is NOT an execution engine.

LLM is a:

- market reader
- scenario generator
- ranking assistant
- decision support layer

Execution is handled by system engine.

---

## AI ROLE SEPARATION

### LLM Layer (Gemini)
- analyzes inventory context
- compares prices
- evaluates alternatives
- generates fallback options
- produces ranked suggestions

### System Layer (OS Core)
- booking execution
- payment handling
- escrow logic
- inventory locking
- state machine control

---

## DATA INPUT FLOW

```
USER REQUEST
    ↓
REAL-TIME INVENTORY FETCH
    ↓
- hotels
- serviced apartments
- OTA / wholesaler feeds
    ↓
CONTEXT BUILDER
- location
- dates
- budget
- demand pressure
    ↓
LLM ANALYSIS LAYER (Gemini)
```

---

## GEMINI OUTPUT STRUCTURE

LLM must return structured decision suggestions:

```json
{
  "best_hotel_option": [],
  "fallback_hotels": [],
  "serviced_apartments": [],
  "price_analysis": {
    "cheap_option": "",
    "best_value": "",
    "premium_option": ""
  },
  "risk_notes": [],
  "recommendation_order": []
}
```

---

## DECISION PIPELINE

1. Fetch inventory in real-time
2. Build user context
3. Send structured prompt to Gemini
4. Receive ranked market interpretation
5. Run scoring engine
6. Execute booking or failover

---

## OUTPUT DECISION RULES

SYSTEM decides final action:

```
IF hotel_available AND score_high:
    BOOK HOTEL

ELSE IF hotel_unavailable:
    USE FALLBACK INVENTORY

ELSE:
    OFFER MULTIPLE OPTIONS
```

---

## KEY LIMITATION

Gemini does NOT:

- execute bookings
- manage payments
- hold inventory state

---

## KEY ROLE

Gemini provides:

- ranking intelligence
- substitution suggestions
- price comparison reasoning
- demand-sensitive interpretation
