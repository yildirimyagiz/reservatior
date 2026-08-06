"""
app/services/creator_commerce.py
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Reservatior Creator Commerce Loop & Escrow Financial Publisher
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Capabilities:
  1. Creator profile management & video tour tracking
  2. Pay-As-You-Earn Lead & Tour Routing
  3. Closed-Loop Escrow Settlement Publisher
     (Emits Webhook event to Elysia.js endpoint upon closing)
"""

from __future__ import annotations

import logging
import os
import httpx
from datetime import datetime, timezone
from typing import Any, Dict, List, Optional
from pydantic import BaseModel, Field

logger = logging.getLogger(__name__)

ELYSIA_API_URL = os.getenv("ELYSIA_API_URL", "http://localhost:3000")


# ─── Models ─────────────────────────────────────────────────────────────────────

class CreatorProfile(BaseModel):
    creator_id: str = Field(default_factory=lambda: f"cr_{datetime.now().timestamp():.0f}")
    name: str
    channel_handle: str
    commission_share_pct: float = 15.0  # 15% affiliate revenue share
    total_sales_closed_usd: float = 0.0


class CreatorTour(BaseModel):
    tour_id: str = Field(default_factory=lambda: f"tour_{datetime.now().timestamp():.0f}")
    creator_id: str
    listing_id: str
    video_url: str
    views_count: int = 0
    leads_generated: int = 0


class SettlementRequest(BaseModel):
    listing_id: str
    creator_id: str
    sale_price_usd: float
    platform_fee_pct: float = 3.0
    ad_spend_to_recoup_usd: float = 0.0


class SettlementResult(BaseModel):
    settlement_id: str = Field(default_factory=lambda: f"stl_{datetime.now().timestamp():.0f}")
    listing_id: str
    creator_id: str
    gross_amount_usd: float
    platform_fee_usd: float
    ad_spend_recouped_usd: float
    creator_payout_usd: float
    event_published: bool
    timestamp: str = Field(default_factory=lambda: datetime.now(timezone.utc).isoformat())


# ─── Creator Commerce Service ─────────────────────────────────────────────────

class CreatorCommerceService:
    def __init__(self):
        self._creators: Dict[str, CreatorProfile] = {}
        self._tours: Dict[str, CreatorTour] = {}

    def register_creator(self, name: str, channel_handle: str) -> CreatorProfile:
        creator = CreatorProfile(name=name, channel_handle=channel_handle)
        self._creators[creator.creator_id] = creator
        return creator

    def attach_tour(self, creator_id: str, listing_id: str, video_url: str) -> CreatorTour:
        if creator_id not in self._creators:
            raise ValueError(f"Creator {creator_id} not found.")
        tour = CreatorTour(creator_id=creator_id, listing_id=listing_id, video_url=video_url)
        self._tours[tour.tour_id] = tour
        return tour

    async def settle_escrow(self, req: SettlementRequest) -> SettlementResult:
        """
        Calculates escrow payouts and emits a webhook event to Elysia.js endpoint.
        """
        creator = self._creators.get(req.creator_id)
        commission_pct = creator.commission_share_pct if creator else 10.0

        platform_fee = req.sale_price_usd * (req.platform_fee_pct / 100.0)
        creator_payout = req.sale_price_usd * (commission_pct / 100.0)

        result = SettlementResult(
            listing_id=req.listing_id,
            creator_id=req.creator_id,
            gross_amount_usd=req.sale_price_usd,
            platform_fee_usd=platform_fee,
            ad_spend_recouped_usd=req.ad_spend_to_recoup_usd,
            creator_payout_usd=creator_payout,
            event_published=False,
        )

        # Webhook Event Payload for Elysia.js Event Bus
        event_payload = {
            "event_type": "listing.settlement.requested",
            "data": result.model_dump(),
        }

        # Event Publisher Protocol to Elysia.js
        try:
            async with httpx.AsyncClient(timeout=5.0) as client:
                resp = await client.post(f"{ELYSIA_API_URL}/api/v1/escrow/settle", json=event_payload)
                if resp.status_code == 200:
                    result.event_published = True
                    logger.info(f"💳 Published settlement event to Elysia.js for listing {req.listing_id}")
        except Exception as e:
            logger.warning(f"⚠️ Event Publisher fallback: Could not connect to Elysia.js ({e})")

        return result


# Singleton Instance
creator_commerce_service = CreatorCommerceService()
