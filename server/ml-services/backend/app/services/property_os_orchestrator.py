"""
app/services/property_os_orchestrator.py
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Reservatior Master Property OS Orchestrator
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Master Orchestrator connecting:
  1. Property Health Analysis (Gemini Multimodal)
  2. InsurTech Cross-sell Evaluation
  3. Demographic Staging Routing
  4. Multilingual Brochure Pipeline
  5. Omnichannel Ad Campaign Launch
  6. SSE Telemetry Stream & Webhook Bridge to Elysia.js Event Bus
"""

from __future__ import annotations

import asyncio
import logging
from typing import Any, Dict, List, Optional
from pydantic import BaseModel, Field

from app.ai.property_health_engine import property_health_engine, PropertyHealthReport
from app.ai.insurtech_engine import insurtech_engine, UserRole, InsurancePresentationPayload
from app.ai.demographic_staging_router import (
    demographic_staging_router,
    BuyerDemographic,
    DemographicStagingRequest,
    DemographicStagingResult,
)
from app.services.omnichannel_ad_engine import omnichannel_ad_engine, AdCampaign
from app.ai.brochure_pipeline import generate_brochure, BrochureInput, LanguageCode

logger = logging.getLogger(__name__)


# ─── Orchestration Models ──────────────────────────────────────────────────────

class MasterOrchestrationRequest(BaseModel):
    listing_id: str
    property_title: str
    images: List[str]
    price: float
    user_role: UserRole = UserRole.OWNER
    buyer_origin: BuyerDemographic = BuyerDemographic.LOCAL_GENERAL
    ad_budget_usd: float = 500.0
    language: LanguageCode = LanguageCode.EN
    bedrooms: Optional[int] = 2
    bathrooms: Optional[int] = 2
    sqft: Optional[int] = 1200


class MasterOrchestrationResponse(BaseModel):
    listing_id: str
    property_health: PropertyHealthReport
    insurtech_offer: InsurancePresentationPayload
    demographic_staging: DemographicStagingResult
    ad_campaign: AdCampaign
    brochure_generated: bool
    telemetry_logs: List[str]


# ─── Master Orchestrator Engine ────────────────────────────────────────────────

class PropertyOSOrchestrator:
    async def process_listing(self, req: MasterOrchestrationRequest) -> MasterOrchestrationResponse:
        telemetry: List[str] = [
            f"⚡ Initiating Property OS Master Orchestration for listing '{req.listing_id}'",
            f"📍 Demographic Target: {req.buyer_origin.value.upper()} | Language: {req.language.value.upper()}",
        ]

        # Step 1: Property Health Analysis (Gemini Multimodal / Stub)
        health_report = await property_health_engine.analyse(
            image_urls=req.images,
            listing_id=req.listing_id,
        )
        telemetry.extend(health_report.telemetry_events)

        # Step 2: InsurTech Offer Cross-Sell
        insurtech_offer = insurtech_engine.generate_offer(
            risk_score=health_report.risk_score,
            user_role=req.user_role,
            listing_id=req.listing_id,
        )
        telemetry.append(insurtech_offer.telemetry_event)

        # Step 3: Demographic Staging Routing
        staging_req = DemographicStagingRequest(
            image_url=req.images[0] if req.images else "https://example.com/default.jpg",
            demographic=req.buyer_origin,
        )
        staging_res = await demographic_staging_router.stage_for_demographic(staging_req)
        telemetry.extend(staging_res.pipeline_telemetry)

        # Step 4: Multilingual Brochure Generation
        brochure_input = BrochureInput(
            property_id=req.listing_id,
            title=req.property_title,
            price=req.price,
            language=req.language,
            bedrooms=req.bedrooms,
            bathrooms=req.bathrooms,
            sqft=req.sqft,
        )
        brochure_bytes = generate_brochure(brochure_input)
        brochure_ok = len(brochure_bytes) > 0
        telemetry.append(f"📄 Brochure generated successfully [{req.language.value.upper()}]")

        # Step 5: Omnichannel Ad Campaign Launch
        ad_campaign = omnichannel_ad_engine.launch_campaign(
            listing_id=req.listing_id,
            property_title=req.property_title,
            total_budget_usd=req.ad_budget_usd,
        )
        telemetry.append(f"🚀 Omnichannel Ad Campaign Launched — Budget: ${req.ad_budget_usd:,.2f}")

        telemetry.append("✅ Property OS Master Orchestration Completed Successfully!")

        return MasterOrchestrationResponse(
            listing_id=req.listing_id,
            property_health=health_report,
            insurtech_offer=insurtech_offer,
            demographic_staging=staging_res,
            ad_campaign=ad_campaign,
            brochure_generated=brochure_ok,
            telemetry_logs=telemetry,
        )


# Singleton Instance
property_os_orchestrator = PropertyOSOrchestrator()
