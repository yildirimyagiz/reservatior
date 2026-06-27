from fastapi import APIRouter, HTTPException, Response
from typing import Any, Dict
from app.ai.brochure_pipeline import generate_brochure, BrochureInput, get_templates

router = APIRouter()

@router.get("/templates")
def fetch_templates() -> Dict[str, Any]:
    """ Fetch available templates """
    return {"templates": get_templates()}

@router.post("/generate")
def create_brochure(input_data: BrochureInput) -> Response:
    """
    Generate a property brochure PDF.
    """
    try:
        pdf_bytes = generate_brochure(input_data)
        return Response(content=pdf_bytes, media_type="application/pdf")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
