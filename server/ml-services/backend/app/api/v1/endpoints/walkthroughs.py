from fastapi import APIRouter, HTTPException
from typing import Any
from app.schemas import WalkthroughInput, WalkthroughOutput
from app.services.walkthrough_service import walkthrough_service

router = APIRouter()

@router.post("/select-pipeline", response_model=WalkthroughOutput)
async def select_pipeline(input_data: WalkthroughInput) -> Any:
    """
    Select the optimal walkthrough pipeline based on inputs.
    """
    result = await walkthrough_service.select_pipeline(input_data)
    return result

@router.post("/generate")
async def generate_walkthrough(input_data: WalkthroughInput) -> Any:
    """
    Initiate the walkthrough generation job.
    """
    try:
        job = await walkthrough_service.create_job(input_data)
        return job
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.get("/status/{job_id}")
async def get_job_status(job_id: str) -> Any:
    """
    Get the status of a generation job.
    """
    job = await walkthrough_service.get_job(job_id)
    if not job:
        raise HTTPException(status_code=404, detail="Job not found")
    return job

@router.get("/cost-estimate")
async def get_cost_estimate() -> Any:
    """
    Return current cost configuration.
    """
    # This could be fetched from global config
    return {
        "costs": {
            "parallax_2_5d": 0.05,
            "instant_ngp_single": 0.25,
            "instant_ngp_full": 0.45,
            "gaussian_splatting": 1.50
        },
        "currency": "USD"
    }
