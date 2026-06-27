# Cost-Aware Walkthrough Pipeline - System Architecture

## 1. Overview

The Walkthrough Pipeline is a deterministic, rule-based system designed to optimize GPU costs while guaranteeing high-resolution output. It dynamically selects between 2.5D Parallax, InstantNGP, and Gaussian Splatting based on strictly defined business rules.

## 2. Decision Logic (Implemented)

| Condition                   | Pipeline                        | Cost (Est) |
| --------------------------- | ------------------------------- | ---------- |
| Photos ≤ 4                  | **2.5D Parallax** (Single Room) | ~$0.05     |
| Photos ≤ 8 + (Free/Basic)   | **2.5D Parallax**               | ~$0.05     |
| Photos ≤ 8 + (Pro/Prem)     | **InstantNGP** (Single Zone)    | ~$0.25     |
| Photos ≤ 15 + (High Tier)   | **InstantNGP** (Full Apt)       | ~$0.45     |
| Photos > 15 + (Premium/Lux) | **Gaussian Splatting**          | ~$1.50     |
| Photos > 15 + (Other)       | **InstantNGP** (Full Apt)       | ~$0.45     |

**Key Constraints Enforced:**

- ✅ **Resolution**: Always Minimum 1536x1536 input / 1080p output.
- ✅ **Gating**: Gaussian Splatting strictly limited to Premium Plan or Luxury Flag.
- ✅ **Preference**: Always chooses the lowest-cost viable option.

## 3. Backend Implementation

### Core Components

- **Selector**: `backend/app/ai/walkthrough_pipeline.py`
  - Contains the `select_walkthrough_pipeline` function with the exact If/Else logic blocks.
- **Configuration**: `backend/app/core/config.py`
  - Added `AI_COSTS` dictionary to track unit economics.

### API Layer

- **Endpoints**: `backend/app/api/v1/endpoints/walkthroughs.py`
  - `POST /select-pipeline`: Stateless estimator.
  - `POST /generate`: Job initiator.
- **Router**: Registered in `backend/app/api/v1/api.py`.

## 4. Staging & Brochure Status

> **Warning**: The user requested a check on Staging and Brochure backends.

- **Staging Backend**: ❌ **MISSING**. No files found matching `*staging*` in backend.
- **Brochure Backend**: ❌ **MISSING**. No files found matching `*brochure*` in backend.

_Recommendation_: These services need to be implemented following a similar "Controller-Service-Pipeline" pattern as the Walkthrough system.
