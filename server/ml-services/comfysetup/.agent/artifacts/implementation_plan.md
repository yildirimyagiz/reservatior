# Cost-Aware Walkthrough Pipeline Implementation Plan

## Goal

Implement a rigid, deterministic, and cost-aware pipeline selector for 3D walkthrough generation, adhering to strict user-defined rules. This system manages trade-offs between 2.5D Parallax, InstantNGP, and Gaussian Splatting.

## User Review Required

> [!IMPORTANT]
> **Strict Logic Applied**: The pipeline logic is implemented EXACTLY as specified.
>
> - **Free/Trial Limitation**: Users with <= 4 photos get "2.5D Parallax" regardless of plan.
> - **Premium Gating**: Gaussian Splatting is strictly reserved for Premium users OR Luxury flag.
> - **Default Quality**: High resolution is enforced for all outputs.

## Proposed Changes

### Backend Configuration

#### [MODIFY] [config.py](file:///Users/yldyagz/.gemini/antigravity/scratch/comyfystaging/backend/app/core/config.py)

- **Update**: Add `AI_COSTS` dictionary with specific pricing for each pipeline tier.

### AI Logic

#### [NEW] [walkthrough_pipeline.py](file:///Users/yldyagz/.gemini/antigravity/scratch/comyfystaging/backend/app/ai/walkthrough_pipeline.py)

- **Implement**: `select_walkthrough_pipeline(photo_count, room_types, user_plan, luxury_flag)`
  - Encapsulates the IF/ELSE logic provided in prompt.
  - Returns the requested JSON structure.

### API Layer

#### [NEW] [walkthroughs.py](file:///Users/yldyagz/.gemini/antigravity/scratch/comyfystaging/backend/app/api/v1/endpoints/walkthroughs.py)

- **Endpoint**: `POST /select-pipeline`
  - Stateless endpoint for UI to estimate cost/quality.
- **Endpoint**: `POST /generate`
  - Initiates the job (mocked execution for now, simulating the pipeline start).

#### [MODIFY] [api.py](file:///Users/yldyagz/.gemini/antigravity/scratch/comyfystaging/backend/app/api/v1/api.py)

- **Update**: Register `walkthroughs` router.

## Verification Plan

### Automated Logic Verification

- I will create a temporary test script `verify_logic.py` to run the `select_walkthrough_pipeline` function against a matrix of inputs (User Plan x Photo Count x Luxury Flag) to adhere to the rules.

### Manual Verification

- **Test Command**: `curl -X POST http://localhost:8000/api/v1/walkthroughs/select-pipeline -H "Content-Type: application/json" -d '{"photo_count": 12, "user_plan": "pro"}'`
- **Expected**: JSON response matching the logic for `InstantNGP (full apartment walkthrough)`.
