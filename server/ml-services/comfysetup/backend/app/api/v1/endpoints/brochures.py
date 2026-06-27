from fastapi import APIRouter, HTTPException
from typing import Any
from app.ai.brochure_pipeline import generate_brochure, BrochureInput, BrochureOutput

router = APIRouter()

@router.post("/generate", response_model=BrochureOutput)
def create_brochure(input_data: BrochureInput) -> Any:
    """
    Generate a property brochure PDF and web view.
    """
    try:
        result = generate_brochure(input_data)
        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
