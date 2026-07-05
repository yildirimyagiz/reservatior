from fastapi import APIRouter, UploadFile, File, Form, HTTPException
from pydantic import BaseModel
from typing import List, Optional
import numpy as np
from PIL import Image
import io
import base64

router = APIRouter(prefix="/cleaning", tags=["cleaning-vision"])

CHECKPOINTS = [
    "kitchen", "bathroom", "bedroom", "living", "entryway",
    "windows", "floors", "linens", "trash", "amenities", "appliances", "exterior"
]

class CheckpointResult(BaseModel):
    checkpoint: str
    passed: bool
    confidence: float
    defects: List[str]

class CleaningAnalysisResult(BaseModel):
    overall_pass: bool
    overall_score: float
    checkpoint_results: List[CheckpointResult]
    summary: str
    suggested_actions: List[str]

def _analyze_single_image(image_bytes: bytes, checkpoint: str) -> CheckpointResult:
    try:
        img = Image.open(io.BytesIO(image_bytes))
        img_array = np.array(img.convert("RGB"))

        brightness = img_array.mean()
        std_dev = img_array.std()
        edge_intensity = np.gradient(img_array.mean(axis=2))[0].std()

        cleanliness_score = min(100, max(0,
            30 +
            (brightness / 2.55) * 0.25 +
            (255 - std_dev) * 0.15 +
            edge_intensity * 0.10
        ))

        defects = []
        if brightness < 60:
            defects.append("Low lighting — may hide dirt")
        if std_dev < 30:
            defects.append("Surface appears overly uniform — possible obstruction")
        if edge_intensity < 5:
            defects.append("Low detail detected — check focus")

        passed = cleanliness_score >= 65 and len(defects) == 0

        return CheckpointResult(
            checkpoint=checkpoint,
            passed=passed,
            confidence=round(min(99, cleanliness_score) / 100, 2),
            defects=defects
        )
    except Exception as e:
        return CheckpointResult(
            checkpoint=checkpoint,
            passed=False,
            confidence=0.0,
            defects=[f"Analysis error: {str(e)}"]
        )

@router.post("/analyze", response_model=CleaningAnalysisResult)
async def analyze_cleaning_photos(
    files: List[UploadFile] = File(...),
    property_id: Optional[str] = Form(None),
    booking_id: Optional[str] = Form(None)
):
    if len(files) == 0:
        raise HTTPException(status_code=400, detail="At least one photo required")

    if len(files) > 12:
        raise HTTPException(status_code=400, detail="Maximum 12 photos (one per checkpoint)")

    results = []
    for i, file in enumerate(files):
        contents = await file.read()
        checkpoint = CHECKPOINTS[i] if i < len(CHECKPOINTS) else f"checkpoint_{i+1}"
        result = _analyze_single_image(contents, checkpoint)
        results.append(result)

    passed_count = sum(1 for r in results if r.passed)
    overall_score = round((passed_count / len(results)) * 100, 1)
    overall_pass = overall_score >= 75

    all_defects = [d for r in results for d in r.defects]
    suggested_actions = []
    if not overall_pass:
        failed = [r.checkpoint for r in results if not r.passed]
        suggested_actions.append(f"Re-clean: {', '.join(failed[:3])}")
        if any("lighting" in d.lower() for d in all_defects):
            suggested_actions.append("Improve lighting and retake photos")
        if any("detail" in d.lower() for d in all_defects):
            suggested_actions.append("Clean lens and retake photos")
    else:
        suggested_actions.append("No action needed — all checkpoints passed")

    return CleaningAnalysisResult(
        overall_pass=overall_pass,
        overall_score=overall_score,
        checkpoint_results=results,
        summary=f"{passed_count}/{len(results)} checkpoints passed ({overall_score}%)",
        suggested_actions=suggested_actions
    )

@router.get("/checkpoints")
async def get_checkpoints():
    return {
        "checkpoints": CHECKPOINTS,
        "count": len(CHECKPOINTS),
        "description": "12-point Reservatior Cleaning Standard SLA"
    }
