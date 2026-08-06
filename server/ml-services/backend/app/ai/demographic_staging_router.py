"""
app/ai/demographic_staging_router.py
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Reservatior Demographic Staging Router
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Maps buyer-origin demographics to specialized virtual staging architectural styles,
ad network placement parameters, and targeted marketing profiles.

Demographic Markets:
  · East Asian (CN/KR/JP) → Minimalist / Contemporary / Zen Modern
  · Gulf/MENA (UAE/SA/QA) → Ultra Luxury / Neo-Classical Gold / Royal Mediterranean
  · Western/CIS (US/EU/RU) → Scandinavian / Industrial Loft / Mid-Century Modern
"""

from __future__ import annotations

import logging
from enum import Enum
from typing import Any, Dict, List, Optional
from pydantic import BaseModel, Field

from app.ai.staging_pipeline import StagingStyle, staging_pipeline, VirtualStagingResult

logger = logging.getLogger(__name__)


# ─── Demographic Target Enums ───────────────────────────────────────────────────

class BuyerDemographic(str, Enum):
    EAST_ASIAN = "east_asian"   # China, Korea, Japan
    GULF_MENA = "gulf_mena"     # UAE, Saudi Arabia, Qatar, Kuwait
    WESTERN_CIS = "western_cis" # US, UK, EU, Russia
    LOCAL_GENERAL = "local_general"


# ─── Mapping Models ─────────────────────────────────────────────────────────────

class DemographicProfile(BaseModel):
    demographic: BuyerDemographic
    primary_staging_style: StagingStyle
    secondary_staging_style: StagingStyle
    target_ad_networks: List[str]
    color_palette_hints: List[str]
    marketing_copy_tone: str


_DEMOGRAPHIC_MAP: Dict[BuyerDemographic, DemographicProfile] = {
    BuyerDemographic.EAST_ASIAN: DemographicProfile(
        demographic=BuyerDemographic.EAST_ASIAN,
        primary_staging_style=StagingStyle.MINIMALIST,
        secondary_staging_style=StagingStyle.CONTEMPORARY,
        target_ad_networks=["baidu", "naver", "weixin", "google"],
        color_palette_hints=["warm_beige", "bamboo_wood", "soft_white", "matte_black"],
        marketing_copy_tone="zen_serenity_efficiency",
    ),
    BuyerDemographic.GULF_MENA: DemographicProfile(
        demographic=BuyerDemographic.GULF_MENA,
        primary_staging_style=StagingStyle.LUXURY,
        secondary_staging_style=StagingStyle.MODERN,
        target_ad_networks=["snapchat", "instagram", "google_mena", "yandex_uae"],
        color_palette_hints=["gold_accents", "marble_white", "royal_blue", "emerald"],
        marketing_copy_tone="exclusive_prestige_opulence",
    ),
    BuyerDemographic.WESTERN_CIS: DemographicProfile(
        demographic=BuyerDemographic.WESTERN_CIS,
        primary_staging_style=StagingStyle.SCANDINAVIAN,
        secondary_staging_style=StagingStyle.MODERN,
        target_ad_networks=["google", "meta", "linkedin", "yandex"],
        color_palette_hints=["natural_oak", "muted_grey", "sage_green", "warm_terracotta"],
        marketing_copy_tone="cozy_functionality_lifestyle",
    ),
    BuyerDemographic.LOCAL_GENERAL: DemographicProfile(
        demographic=BuyerDemographic.LOCAL_GENERAL,
        primary_staging_style=StagingStyle.MODERN,
        secondary_staging_style=StagingStyle.CONTEMPORARY,
        target_ad_networks=["meta", "google"],
        color_palette_hints=["neutral_tones", "bright_whites"],
        marketing_copy_tone="balanced_family_comfort",
    ),
}


class DemographicStagingRequest(BaseModel):
    image_url: str
    room_type: str = "living room"
    demographic: BuyerDemographic = BuyerDemographic.LOCAL_GENERAL
    custom_prompt: Optional[str] = None
    override_style: Optional[StagingStyle] = None


class DemographicStagingResult(BaseModel):
    staged_image_url: str
    applied_demographic: BuyerDemographic
    applied_style: StagingStyle
    recommended_ad_networks: List[str]
    marketing_profile: DemographicProfile
    pipeline_telemetry: List[str]


# ─── Staging Router Engine ──────────────────────────────────────────────────────

class DemographicStagingRouter:
    """
    Wraps the core VirtualStagingPipeline with demographic intelligence
    to generate buyer-targeted virtual staging images.
    """

    def resolve_demographic_profile(self, demographic: BuyerDemographic) -> DemographicProfile:
        return _DEMOGRAPHIC_MAP.get(demographic, _DEMOGRAPHIC_MAP[BuyerDemographic.LOCAL_GENERAL])

    async def stage_for_demographic(
        self,
        request: DemographicStagingRequest
    ) -> DemographicStagingResult:
        """
        Executes virtual staging matched to the specified buyer demographic.
        """
        profile = self.resolve_demographic_profile(request.demographic)
        target_style = request.override_style or profile.primary_staging_style

        telemetry: List[str] = [
            f"🎯 Demographic target selected: {request.demographic.value.upper()}",
            f"🎨 Selected Staging Style: {target_style.value}",
            f"📢 Ad Network Target Hints: {', '.join(profile.target_ad_networks)}",
        ]

        # Call underlying staging pipeline
        staging_res: VirtualStagingResult = await staging_pipeline.stage_image(
            image_input=request.image_url,
            room_type=request.room_type,
            style=target_style,
            prompt=request.custom_prompt,
        )

        telemetry.append(f"⚡ Virtual Staging finished using backend: {staging_res.backend_used}")

        return DemographicStagingResult(
            staged_image_url=staging_res.staged_image_url or request.image_url,
            applied_demographic=request.demographic,
            applied_style=target_style,
            recommended_ad_networks=profile.target_ad_networks,
            marketing_profile=profile,
            pipeline_telemetry=telemetry,
        )


# Singleton Instance
demographic_staging_router = DemographicStagingRouter()
