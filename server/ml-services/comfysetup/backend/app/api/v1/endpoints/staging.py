from fastapi import APIRouter, HTTPException
from typing import Any
from app.ai.staging_pipeline import staging_pipeline, StagingInput, StagingOutput

router = APIRouter()

@router.post("/generate", response_model=StagingOutput)
async def create_staging(input_data: StagingInput) -> Any:
    """
    Generate a virtually staged image.
    """
    try:
        # Assuming input_data.image_url is a path or url we can use
        result_url = await staging_pipeline.stage_image(
            image_path=input_data.image_url,
            room_type=input_data.room_type,
            style=input_data.style
        )
        
        return StagingOutput(
            original_url=input_data.image_url,
            staged_url=result_url,
            status="success"
        )
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
