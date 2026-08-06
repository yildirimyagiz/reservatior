from fastapi import APIRouter, HTTPException, Query
from typing import List, Optional
from pydantic import BaseModel

from app.ai.property_health_engine import (
    property_health_engine,
    PropertyHealthReport,
    ComparisonReport,
)
from app.ai.insurtech_engine import (
    insurtech_engine,
    UserRole,
    InsurancePresentationPayload,
)

router = APIRouter()

class HealthAnalyzeRequest(BaseModel):
    image_urls: List[str]
    listing_id: Optional[str] = None
    property_id: Optional[str] = None

class InsurTechOfferRequest(BaseModel):
    risk_score: float
    user_role: UserRole = UserRole.OWNER
    property_id: Optional[str] = None
    listing_id: Optional[str] = None

@router.post("/analyze", response_model=PropertyHealthReport)
async def analyze_property_health(req: HealthAnalyzeRequest):
    return await property_health_engine.analyse(
        image_urls=req.image_urls,
        listing_id=req.listing_id,
        property_id=req.property_id,
    )

@router.get("/report/{report_id}", response_model=PropertyHealthReport)
async def get_health_report(report_id: str):
    report = property_health_engine.get_report(report_id)
    if not report:
        raise HTTPException(status_code=404, detail="Health report not found.")
    return report

@router.post("/compare", response_model=ComparisonReport)
async def compare_reports(checkin_id: str, checkout_id: str):
    try:
        return await property_health_engine.compare(checkin_id, checkout_id)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.post("/insurtech/offer", response_model=InsurancePresentationPayload)
async def get_insurtech_offer(req: InsurTechOfferRequest):
    return insurtech_engine.generate_offer(
        risk_score=req.risk_score,
        user_role=req.user_role,
        property_id=req.property_id,
        listing_id=req.listing_id,
    )
