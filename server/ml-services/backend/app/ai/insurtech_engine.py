"""
app/ai/insurtech_engine.py
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Reservatior InsurTech Cross-Sell Engine
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Converts a property risk score (0–100) from the PropertyHealthEngine into
contextual, tiered insurance product offers.

Two user roles:
  · OWNER  → Property Damage + Natural Disaster coverage
  · TENANT → Deposit Protection + Tenant Liability insurance

Output is a structured InsurancePresentationPayload ready for:
  - REST API response to the frontend
  - Elysia.js event bus (JSON serializable)
  - WhatsApp / in-app notification copy
"""

from __future__ import annotations

import logging
from enum import Enum
from typing import Any, Dict, List, Optional

from pydantic import BaseModel, Field

logger = logging.getLogger(__name__)


# ─── Enums ────────────────────────────────────────────────────────────────────

class UserRole(str, Enum):
    OWNER = "owner"
    TENANT = "tenant"


class InsuranceTier(str, Enum):
    BASIC = "basic"
    STANDARD = "standard"
    PREMIUM = "premium"


class RiskBand(str, Enum):
    LOW = "low"           # 0-9
    MEDIUM = "medium"     # 10-29
    HIGH = "high"         # 30-59
    CRITICAL = "critical" # 60-100


# ─── Product Catalogue ────────────────────────────────────────────────────────

_OWNER_PRODUCTS: Dict[str, Dict[str, Any]] = {
    InsuranceTier.BASIC: {
        "name": "Property Shield Basic",
        "tagline": "Essential protection for your investment",
        "monthly_usd": 12.00,
        "annual_usd": 129.00,
        "coverages": [
            "Fire & smoke damage up to $150,000",
            "Theft & vandalism up to $50,000",
            "Basic liability coverage $100,000",
        ],
        "exclusions": ["Flood", "Earthquake", "Tenant damage"],
        "deductible_usd": 1000,
    },
    InsuranceTier.STANDARD: {
        "name": "Property Shield Standard",
        "tagline": "Comprehensive coverage for peace of mind",
        "monthly_usd": 34.00,
        "annual_usd": 369.00,
        "coverages": [
            "Fire, smoke & water damage up to $500,000",
            "Theft, vandalism & burglary up to $150,000",
            "Extended liability $500,000",
            "Loss of rental income (3 months)",
            "Structural damage coverage",
        ],
        "exclusions": ["Earthquake (add-on available)"],
        "deductible_usd": 500,
    },
    InsuranceTier.PREMIUM: {
        "name": "Property Shield Premium",
        "tagline": "Ultimate protection — nothing is left uncovered",
        "monthly_usd": 89.00,
        "annual_usd": 959.00,
        "coverages": [
            "All-risk coverage up to $2,000,000",
            "Natural disaster incl. earthquake & flood",
            "Tenant damage & malicious damage",
            "Loss of rental income (12 months)",
            "Legal expenses up to $25,000",
            "24/7 emergency response team",
            "Dedicated property manager contact",
        ],
        "exclusions": [],
        "deductible_usd": 250,
    },
}

_TENANT_PRODUCTS: Dict[str, Dict[str, Any]] = {
    InsuranceTier.BASIC: {
        "name": "Tenant Guard Basic",
        "tagline": "Protect your deposit, protect your home",
        "monthly_usd": 8.00,
        "annual_usd": 85.00,
        "coverages": [
            "Deposit protection up to 2 months rent",
            "Accidental damage to fixtures $5,000",
            "Personal liability $50,000",
        ],
        "exclusions": ["Intentional damage", "Pet damage"],
        "deductible_usd": 250,
    },
    InsuranceTier.STANDARD: {
        "name": "Tenant Guard Standard",
        "tagline": "Full deposit & personal protection",
        "monthly_usd": 22.00,
        "annual_usd": 237.00,
        "coverages": [
            "Deposit protection up to 4 months rent",
            "Accidental damage to property $20,000",
            "Personal liability $200,000",
            "Personal belongings up to $15,000",
            "Alternative accommodation (14 days)",
        ],
        "exclusions": ["Intentional damage"],
        "deductible_usd": 100,
    },
    InsuranceTier.PREMIUM: {
        "name": "Tenant Guard Premium",
        "tagline": "Zero stress — we cover everything",
        "monthly_usd": 45.00,
        "annual_usd": 485.00,
        "coverages": [
            "Full deposit guarantee (no deductions possible)",
            "All accidental damage — no limit",
            "Personal liability $500,000",
            "High-value personal belongings up to $50,000",
            "Alternative accommodation (30 days)",
            "Legal expenses & dispute resolution",
            "Relocation assistance",
        ],
        "exclusions": [],
        "deductible_usd": 0,
    },
}


# ─── Output Models ────────────────────────────────────────────────────────────

class InsuranceProductOffer(BaseModel):
    tier: InsuranceTier
    name: str
    tagline: str
    monthly_usd: float
    annual_usd: float
    annual_savings_usd: float           # (monthly*12) - annual_usd
    coverages: List[str]
    exclusions: List[str]
    deductible_usd: float
    recommended: bool = False            # True for the tier we auto-select
    cta_text: str = "Get Covered Now"
    cta_url: Optional[str] = None


class InsurancePresentationPayload(BaseModel):
    """
    Full insurance offer payload for a given property + user role.
    Delivered to the frontend / event bus.
    """
    offer_id: str
    property_id: Optional[str] = None
    listing_id: Optional[str] = None
    user_role: UserRole
    risk_band: RiskBand
    risk_score: float

    # The recommended tier (auto-selected based on risk)
    recommended_tier: InsuranceTier
    recommended_reason: str

    # All three tiers shown for upsell
    offers: List[InsuranceProductOffer]

    # Telemetry
    telemetry_event: str = ""


# ─── Risk → Tier Mapping ─────────────────────────────────────────────────────

def _risk_to_band(risk_score: float) -> RiskBand:
    if risk_score < 10:
        return RiskBand.LOW
    if risk_score < 30:
        return RiskBand.MEDIUM
    if risk_score < 60:
        return RiskBand.HIGH
    return RiskBand.CRITICAL


def _recommended_tier(risk_band: RiskBand, role: UserRole) -> tuple[InsuranceTier, str]:
    """Returns (recommended_tier, reason_text)."""
    if risk_band == RiskBand.LOW:
        return (
            InsuranceTier.BASIC,
            "Your property is in excellent condition. Basic coverage provides solid protection at minimum cost.",
        )
    if risk_band == RiskBand.MEDIUM:
        return (
            InsuranceTier.STANDARD,
            "Some wear detected. Standard coverage protects against the most common claim scenarios.",
        )
    if risk_band in (RiskBand.HIGH, RiskBand.CRITICAL):
        return (
            InsuranceTier.PREMIUM,
            "Structural risk indicators detected. Premium coverage is strongly recommended to protect your asset.",
        )
    return InsuranceTier.BASIC, "Default recommendation."


# ─── Engine ───────────────────────────────────────────────────────────────────

class InsurTechEngine:
    """
    Maps PropertyHealthReport risk scores to contextual insurance offers.
    No external API calls — pure business logic.
    """

    def generate_offer(
        self,
        risk_score: float,
        user_role: UserRole,
        property_id: Optional[str] = None,
        listing_id: Optional[str] = None,
        base_cta_url: str = "https://reservatior.com/insurance",
    ) -> InsurancePresentationPayload:
        """
        Generate a full three-tier insurance presentation for a given risk score and user role.
        """
        import uuid

        risk_band = _risk_to_band(risk_score)
        rec_tier, rec_reason = _recommended_tier(risk_band, user_role)

        catalogue = _OWNER_PRODUCTS if user_role == UserRole.OWNER else _TENANT_PRODUCTS

        offers: List[InsuranceProductOffer] = []
        for tier in [InsuranceTier.BASIC, InsuranceTier.STANDARD, InsuranceTier.PREMIUM]:
            product = catalogue[tier]
            annual_savings = round((product["monthly_usd"] * 12) - product["annual_usd"], 2)
            offers.append(
                InsuranceProductOffer(
                    tier=tier,
                    name=product["name"],
                    tagline=product["tagline"],
                    monthly_usd=product["monthly_usd"],
                    annual_usd=product["annual_usd"],
                    annual_savings_usd=annual_savings,
                    coverages=product["coverages"],
                    exclusions=product["exclusions"],
                    deductible_usd=product["deductible_usd"],
                    recommended=(tier == rec_tier),
                    cta_text="Get Covered Now" if tier == rec_tier else "View Plan",
                    cta_url=f"{base_cta_url}/{user_role.value}/{tier.value}?listing={listing_id or ''}",
                )
            )

        role_label = "owner" if user_role == UserRole.OWNER else "tenant"
        telemetry = (
            f"🛡️ Property Insurance Offer Attached — {risk_band.value.upper()} risk | "
            f"Recommended: {rec_tier.value.capitalize()} plan for {role_label}"
        )

        logger.info(
            f"InsurTech offer generated | role={user_role.value} | "
            f"risk={risk_score} ({risk_band.value}) | rec={rec_tier.value}"
        )

        return InsurancePresentationPayload(
            offer_id=f"ins_{uuid.uuid4().hex[:10]}",
            property_id=property_id,
            listing_id=listing_id,
            user_role=user_role,
            risk_band=risk_band,
            risk_score=risk_score,
            recommended_tier=rec_tier,
            recommended_reason=rec_reason,
            offers=offers,
            telemetry_event=telemetry,
        )


# ─── Global singleton ─────────────────────────────────────────────────────────
insurtech_engine = InsurTechEngine()
