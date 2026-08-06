from fastapi import APIRouter, HTTPException
from typing import List, Optional, Dict
from pydantic import BaseModel

from app.services.omnichannel_ad_engine import (
    omnichannel_ad_engine,
    AdCampaign,
    AdNetwork,
    ConversionEvent,
)

router = APIRouter()

class LaunchCampaignRequest(BaseModel):
    listing_id: str
    property_title: str
    total_budget_usd: float
    target_networks: Optional[List[AdNetwork]] = None

@router.post("/campaign/launch", response_model=AdCampaign)
async def launch_campaign(req: LaunchCampaignRequest):
    return omnichannel_ad_engine.launch_campaign(
        listing_id=req.listing_id,
        property_title=req.property_title,
        total_budget_usd=req.total_budget_usd,
        target_networks=req.target_networks,
    )

@router.post("/arbitrage/tick/{campaign_id}", response_model=AdCampaign)
async def trigger_arbitrage_tick(campaign_id: str):
    try:
        return omnichannel_ad_engine.execute_arbitrage_tick(campaign_id)
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))

@router.post("/conversion/push")
async def push_conversion_event(event: ConversionEvent):
    return await omnichannel_ad_engine.push_conversion_event(event)

@router.get("/rebate/calculate")
async def calculate_rebate(monthly_spend_usd: float):
    rebate = omnichannel_ad_engine.calculate_volume_rebate(monthly_spend_usd)
    return {"monthly_spend_usd": monthly_spend_usd, "rebate_amount_usd": rebate}
