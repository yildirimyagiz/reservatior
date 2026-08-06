from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional

from app.services.creator_commerce import (
    creator_commerce_service,
    CreatorProfile,
    CreatorTour,
    SettlementRequest,
    SettlementResult,
)

router = APIRouter()

class RegisterCreatorRequest(BaseModel):
    name: str
    channel_handle: str

class AttachTourRequest(BaseModel):
    creator_id: str
    listing_id: str
    video_url: str

@router.post("/profile", response_model=CreatorProfile)
async def register_creator(req: RegisterCreatorRequest):
    return creator_commerce_service.register_creator(req.name, req.channel_handle)

@router.post("/tour", response_model=CreatorTour)
async def attach_tour(req: AttachTourRequest):
    try:
        return creator_commerce_service.attach_tour(req.creator_id, req.listing_id, req.video_url)
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))

@router.post("/settle", response_model=SettlementResult)
async def settle_escrow(req: SettlementRequest):
    return await creator_commerce_service.settle_escrow(req)
