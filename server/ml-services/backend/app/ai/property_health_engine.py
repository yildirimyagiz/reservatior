"""
app/ai/property_health_engine.py
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Reservatior Property Health Engine  ·  Gemini 2.0 Flash Multimodal
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Capabilities:
  1. Structural defect detection (cracks, water stains, worn flooring, broken fixtures)
  2. Spatial attribute extraction (dimensions estimate, lighting, layout, view type)
  3. Risk score (0–100) for InsurTech cross-sell engine
  4. Immutable timestamped baseline for check-in / check-out escrow comparison
  5. Full stub fallback when GOOGLE_GEMINI_API_KEY is not configured

Output: PropertyHealthReport (Pydantic model) — serializable to JSON
        for both Elysia.js event bus and REST API consumers.
"""

from __future__ import annotations

import json
import logging
import os
import uuid
from datetime import datetime, timezone
from typing import Any, Dict, List, Optional
from enum import Enum

from pydantic import BaseModel, Field

logger = logging.getLogger(__name__)

# ─── API Key Guard ────────────────────────────────────────────────────────────
GEMINI_API_KEY: Optional[str] = os.getenv("GOOGLE_GEMINI_API_KEY")
GEMINI_MODEL: str = os.getenv("GEMINI_MODEL", "gemini-2.0-flash-exp")

_GEMINI_AVAILABLE = bool(GEMINI_API_KEY)

if not _GEMINI_AVAILABLE:
    logger.warning(
        "⚠️  GOOGLE_GEMINI_API_KEY not set. PropertyHealthEngine will run in STUB mode. "
        "Set the env var and restart to enable real Gemini multimodal analysis."
    )


# ─── Enums & Constants ────────────────────────────────────────────────────────

class DefectSeverity(str, Enum):
    NONE = "none"
    MINOR = "minor"
    MODERATE = "moderate"
    SEVERE = "severe"
    CRITICAL = "critical"


class LightingQuality(str, Enum):
    DARK = "dark"
    POOR = "poor"
    ADEQUATE = "adequate"
    GOOD = "good"
    EXCELLENT = "excellent"


class ViewType(str, Enum):
    NO_VIEW = "no_view"
    GARDEN = "garden"
    STREET = "street"
    CITY = "city"
    SEA = "sea"
    MOUNTAIN = "mountain"
    POOL = "pool"


# ─── Data Models ─────────────────────────────────────────────────────────────

class DefectItem(BaseModel):
    defect_type: str                        # e.g. "wall_crack", "water_stain"
    severity: DefectSeverity
    location_description: str              # e.g. "North wall, near ceiling"
    confidence: float = Field(ge=0.0, le=1.0)
    repair_priority: str                   # "urgent" | "soon" | "cosmetic"
    estimated_repair_cost_usd: Optional[float] = None


class SpatialAttributes(BaseModel):
    estimated_area_sqm: Optional[float] = None
    ceiling_height_estimate: Optional[str] = None  # "low" | "standard" | "high"
    lighting_quality: LightingQuality = LightingQuality.ADEQUATE
    natural_light: bool = True
    view_type: ViewType = ViewType.NO_VIEW
    layout_description: Optional[str] = None       # e.g. "open-plan 2+1"
    room_type_detected: Optional[str] = None


class PropertyHealthReport(BaseModel):
    report_id: str = Field(default_factory=lambda: f"phr_{uuid.uuid4().hex[:12]}")
    listing_id: Optional[str] = None
    property_id: Optional[str] = None
    analysis_mode: str = "gemini_multimodal"       # or "stub"
    created_at: str = Field(default_factory=lambda: datetime.now(timezone.utc).isoformat())

    # Images analysed
    images_analysed: int = 0
    image_urls: List[str] = []

    # Defect analysis
    defects: List[DefectItem] = []
    defect_count: int = 0
    highest_severity: DefectSeverity = DefectSeverity.NONE

    # Spatial attributes (aggregate across images)
    spatial_attributes: List[SpatialAttributes] = []

    # Risk scoring (0 = pristine, 100 = severely damaged)
    risk_score: float = Field(default=0.0, ge=0.0, le=100.0)
    risk_label: str = "low"              # "low" | "medium" | "high" | "critical"

    # Immutable baseline fingerprint for check-in/out comparison
    baseline_hash: Optional[str] = None

    # Human-readable summary
    overall_condition: str = "Good"
    summary: str = ""
    recommendations: List[str] = []

    # Telemetry micro-interaction log
    telemetry_events: List[str] = []


class ComparisonReport(BaseModel):
    comparison_id: str = Field(default_factory=lambda: f"cmp_{uuid.uuid4().hex[:12]}")
    checkin_report_id: str
    checkout_report_id: str
    compared_at: str = Field(default_factory=lambda: datetime.now(timezone.utc).isoformat())

    new_defects: List[DefectItem] = []
    resolved_defects: List[DefectItem] = []
    damage_delta_score: float = 0.0       # positive = more damage at checkout
    deposit_deduction_recommended: bool = False
    deposit_deduction_estimate_usd: Optional[float] = None
    summary: str = ""


# ─── Prompt Templates ────────────────────────────────────────────────────────

_HEALTH_ANALYSIS_PROMPT = """
You are a certified building inspector and real estate AI analyst for Reservatior Property OS.

Analyse the provided property image(s) and return a STRICT JSON response with the following structure:

{
  "defects": [
    {
      "defect_type": "wall_crack|water_stain|worn_flooring|broken_fixture|mold|paint_peeling|structural_damage|other",
      "severity": "none|minor|moderate|severe|critical",
      "location_description": "brief description of where in the image",
      "confidence": 0.0-1.0,
      "repair_priority": "urgent|soon|cosmetic",
      "estimated_repair_cost_usd": null or number
    }
  ],
  "spatial_attributes": {
    "estimated_area_sqm": null or number,
    "ceiling_height_estimate": "low|standard|high",
    "lighting_quality": "dark|poor|adequate|good|excellent",
    "natural_light": true|false,
    "view_type": "no_view|garden|street|city|sea|mountain|pool",
    "layout_description": "brief layout description",
    "room_type_detected": "living_room|bedroom|kitchen|bathroom|balcony|entrance|other"
  },
  "overall_condition": "Excellent|Good|Fair|Poor|Very Poor",
  "summary": "2-3 sentence professional assessment",
  "recommendations": ["action 1", "action 2"]
}

Be precise, professional, and conservative. Only report defects you can clearly see.
Return ONLY valid JSON, no additional text.
"""


# ─── Core Engine ─────────────────────────────────────────────────────────────

class PropertyHealthEngine:
    """
    Gemini-powered property health analyser.

    - Uses Gemini 2.0 Flash multimodal when API key is available
    - Falls back to a structured stub when API key is missing
    - Generates immutable baseline reports for escrow validation
    """

    def __init__(self) -> None:
        self._client = None
        self._reports: Dict[str, PropertyHealthReport] = {}  # in-memory store

    def _get_client(self):
        """Lazy-load Gemini client."""
        if self._client is None and _GEMINI_AVAILABLE:
            try:
                import google.generativeai as genai
                genai.configure(api_key=GEMINI_API_KEY)
                self._client = genai.GenerativeModel(GEMINI_MODEL)
                logger.info(f"✅ Gemini client initialised with model: {GEMINI_MODEL}")
            except ImportError:
                logger.error("google-generativeai package not installed. Run: pip install google-generativeai")
                self._client = None
        return self._client

    # ── Stub Response ─────────────────────────────────────────────────────────
    def _stub_analysis(self, image_urls: List[str]) -> Dict[str, Any]:
        """Return deterministic stub data when Gemini is unavailable."""
        logger.info("🔍 [STUB] Property health analysis (Gemini not configured)")
        return {
            "defects": [],
            "spatial_attributes": {
                "estimated_area_sqm": 75.0,
                "ceiling_height_estimate": "standard",
                "lighting_quality": "good",
                "natural_light": True,
                "view_type": "city",
                "layout_description": "Open-plan living area with separate bedroom",
                "room_type_detected": "living_room",
            },
            "overall_condition": "Good",
            "summary": (
                "[STUB MODE] Property appears to be in good condition. "
                "No significant defects detected. Set GOOGLE_GEMINI_API_KEY for real analysis."
            ),
            "recommendations": [
                "Enable Gemini API for real structural analysis",
                "Schedule professional inspection for comprehensive assessment",
            ],
        }

    # ── Gemini API Call ───────────────────────────────────────────────────────
    async def _call_gemini(self, image_urls: List[str]) -> Dict[str, Any]:
        """Call Gemini multimodal with image URLs and return parsed JSON."""
        import httpx
        import google.generativeai as genai

        client = self._get_client()
        if client is None:
            return self._stub_analysis(image_urls)

        # Download images as bytes
        image_parts = []
        async with httpx.AsyncClient(timeout=30.0) as http:
            for url in image_urls[:6]:  # max 6 images per call
                try:
                    resp = await http.get(url)
                    resp.raise_for_status()
                    content_type = resp.headers.get("content-type", "image/jpeg")
                    image_parts.append(
                        genai.types.Part.from_data(data=resp.content, mime_type=content_type)
                    )
                except Exception as e:
                    logger.warning(f"Failed to fetch image {url}: {e}")

        if not image_parts:
            logger.warning("No images could be fetched — returning stub")
            return self._stub_analysis(image_urls)

        try:
            response = client.generate_content(
                [_HEALTH_ANALYSIS_PROMPT, *image_parts],
                generation_config={"temperature": 0.1, "max_output_tokens": 2048},
            )
            raw = response.text.strip()
            # Strip markdown code fences if present
            if raw.startswith("```"):
                raw = raw.split("```")[1]
                if raw.startswith("json"):
                    raw = raw[4:]
            return json.loads(raw)
        except json.JSONDecodeError as e:
            logger.error(f"Gemini returned invalid JSON: {e}. Falling back to stub.")
            return self._stub_analysis(image_urls)
        except Exception as e:
            logger.error(f"Gemini API error: {e}. Falling back to stub.")
            return self._stub_analysis(image_urls)

    # ── Risk Scoring ──────────────────────────────────────────────────────────
    @staticmethod
    def _calculate_risk_score(defects: List[DefectItem]) -> float:
        """
        Compute 0–100 risk score from detected defects.
        Weights: critical=25, severe=15, moderate=8, minor=3, none=0
        """
        severity_weights = {
            DefectSeverity.CRITICAL: 25,
            DefectSeverity.SEVERE: 15,
            DefectSeverity.MODERATE: 8,
            DefectSeverity.MINOR: 3,
            DefectSeverity.NONE: 0,
        }
        raw = sum(severity_weights.get(d.severity, 0) * d.confidence for d in defects)
        return min(100.0, round(raw, 1))

    @staticmethod
    def _risk_label(score: float) -> str:
        if score < 10:
            return "low"
        if score < 30:
            return "medium"
        if score < 60:
            return "high"
        return "critical"

    @staticmethod
    def _baseline_hash(report: PropertyHealthReport) -> str:
        """SHA-256 fingerprint of the report for escrow immutability."""
        import hashlib
        payload = json.dumps({
            "report_id": report.report_id,
            "created_at": report.created_at,
            "defects": [d.model_dump() for d in report.defects],
            "risk_score": report.risk_score,
        }, sort_keys=True)
        return hashlib.sha256(payload.encode()).hexdigest()

    # ── Main Analysis ─────────────────────────────────────────────────────────
    async def analyse(
        self,
        image_urls: List[str],
        listing_id: Optional[str] = None,
        property_id: Optional[str] = None,
    ) -> PropertyHealthReport:
        """
        Analyse property images and return a PropertyHealthReport.
        Automatically selects Gemini or stub mode.
        """
        mode = "gemini_multimodal" if _GEMINI_AVAILABLE else "stub"
        events: List[str] = [f"🔍 Analysis started [{mode}] — {len(image_urls)} image(s)"]

        raw = await self._call_gemini(image_urls) if _GEMINI_AVAILABLE else self._stub_analysis(image_urls)

        # Parse defects
        defects: List[DefectItem] = []
        for d in raw.get("defects", []):
            try:
                defects.append(DefectItem(**d))
            except Exception as e:
                logger.warning(f"Skipping malformed defect entry: {e}")

        # Parse spatial attributes (single image returns one dict)
        spatial_raw = raw.get("spatial_attributes", {})
        spatial: List[SpatialAttributes] = []
        if isinstance(spatial_raw, dict) and spatial_raw:
            try:
                spatial.append(SpatialAttributes(**spatial_raw))
            except Exception as e:
                logger.warning(f"Could not parse spatial attributes: {e}")

        # Risk scoring
        risk_score = self._calculate_risk_score(defects)
        risk_label = self._risk_label(risk_score)

        # Highest severity
        severity_order = [
            DefectSeverity.NONE, DefectSeverity.MINOR,
            DefectSeverity.MODERATE, DefectSeverity.SEVERE, DefectSeverity.CRITICAL,
        ]
        highest = max(
            (d.severity for d in defects),
            key=lambda s: severity_order.index(s),
            default=DefectSeverity.NONE,
        )

        # Telemetry events
        if defects:
            events.append(f"⚠️  {len(defects)} defect(s) found — highest: {highest.value}")
        else:
            events.append("🔍 Room Condition Analyzed: 0 Defects Found")

        events.append(f"🛡️ Risk score computed: {risk_score}/100 ({risk_label})")

        report = PropertyHealthReport(
            listing_id=listing_id,
            property_id=property_id,
            analysis_mode=mode,
            images_analysed=len(image_urls),
            image_urls=image_urls,
            defects=defects,
            defect_count=len(defects),
            highest_severity=highest,
            spatial_attributes=spatial,
            risk_score=risk_score,
            risk_label=risk_label,
            overall_condition=raw.get("overall_condition", "Good"),
            summary=raw.get("summary", ""),
            recommendations=raw.get("recommendations", []),
            telemetry_events=events,
        )
        report.baseline_hash = self._baseline_hash(report)

        # Persist in memory (replace with DB in production)
        self._reports[report.report_id] = report
        logger.info(f"✅ Health report generated: {report.report_id} | risk={risk_score} | defects={len(defects)}")
        return report

    # ── Check-in / Check-out Comparison ──────────────────────────────────────
    async def compare(
        self,
        checkin_report_id: str,
        checkout_report_id: str,
    ) -> ComparisonReport:
        """
        Diff two PropertyHealthReports for escrow deposit validation.
        Returns new defects found at check-out vs check-in.
        """
        checkin = self._reports.get(checkin_report_id)
        checkout = self._reports.get(checkout_report_id)

        if not checkin or not checkout:
            raise ValueError(
                f"Reports not found. checkin={checkin_report_id!r} checkout={checkout_report_id!r}"
            )

        # New defects = present at checkout but not at checkin (by type + location)
        checkin_types = {(d.defect_type, d.location_description) for d in checkin.defects}
        checkout_types = {(d.defect_type, d.location_description) for d in checkout.defects}

        new_defect_keys = checkout_types - checkin_types
        resolved_defect_keys = checkin_types - checkout_types

        new_defects = [
            d for d in checkout.defects
            if (d.defect_type, d.location_description) in new_defect_keys
        ]
        resolved_defects = [
            d for d in checkin.defects
            if (d.defect_type, d.location_description) in resolved_defect_keys
        ]

        delta = round(checkout.risk_score - checkin.risk_score, 1)
        deposit_deduct = delta > 10  # deduction warranted if risk went up significantly

        # Rough deduction estimate: $100 per moderate, $500 per severe, $2000 per critical
        deduction_map = {
            DefectSeverity.MINOR: 50,
            DefectSeverity.MODERATE: 150,
            DefectSeverity.SEVERE: 600,
            DefectSeverity.CRITICAL: 2500,
        }
        total_deduction = sum(deduction_map.get(d.severity, 0) for d in new_defects)

        summary = (
            f"Check-out analysis found {len(new_defects)} new defect(s) vs check-in. "
            f"Risk delta: {delta:+.1f} points. "
            + (f"Recommended deposit deduction: ~${total_deduction:,.0f}." if deposit_deduct else "No deposit deduction warranted.")
        )

        return ComparisonReport(
            checkin_report_id=checkin_report_id,
            checkout_report_id=checkout_report_id,
            new_defects=new_defects,
            resolved_defects=resolved_defects,
            damage_delta_score=delta,
            deposit_deduction_recommended=deposit_deduct,
            deposit_deduction_estimate_usd=total_deduction if deposit_deduct else None,
            summary=summary,
        )

    def get_report(self, report_id: str) -> Optional[PropertyHealthReport]:
        return self._reports.get(report_id)


# ─── Global singleton ─────────────────────────────────────────────────────────
property_health_engine = PropertyHealthEngine()
