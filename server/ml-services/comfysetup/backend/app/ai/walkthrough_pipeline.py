"""
app/ai/walkthrough_pipeline.py
Cost-Aware Combine Walkthrough Pipeline

This module implements the intelligent pipeline selection logic for
generating property walkthroughs using the optimal combination of:
- 2.5D Parallax (single room, low photo count)
- InstantNGP (lightweight 3D reconstruction)
- Nerfstudio Gaussian Splatting (premium luxury only)

The selection prioritizes:
1. Cost efficiency
2. Perceived quality
3. Business viability
"""

from typing import List, Dict, Optional, Literal
from enum import Enum
import logging

logger = logging.getLogger(__name__)


from app.schemas import (
    WalkthroughInput,
    WalkthroughOutput,
    WalkthroughPipeline,
    UserPlan,
    WalkthroughStatus
)

class VideoQuality(str, Enum):
    """Video quality tiers"""
    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"
    PREMIUM = "premium"


class WalkthroughPipelineSelector:
    """
    Intelligent walkthrough pipeline selector
    
    Implements cost-aware decision logic to choose the optimal
    rendering pipeline based on:
    - Photo count
    - User plan
    - Luxury flag
    - Room types
    """
    
    # GPU cost per pipeline (USD per run)
    GPU_COSTS = {
        WalkthroughPipeline.PARALLAX_2_5D: 0.05,
        WalkthroughPipeline.INSTANT_NGP_SINGLE: 0.25,
        WalkthroughPipeline.INSTANT_NGP_FULL: 0.45,
        WalkthroughPipeline.GAUSSIAN_SPLATTING: 1.50,
    }
    
    # Base duration per photo (seconds)
    DURATION_PER_PHOTO = {
        WalkthroughPipeline.PARALLAX_2_5D: 4.0,
        WalkthroughPipeline.INSTANT_NGP_SINGLE: 3.5,
        WalkthroughPipeline.INSTANT_NGP_FULL: 3.0,
        WalkthroughPipeline.GAUSSIAN_SPLATTING: 3.5,
    }
    
    # Quality mapping
    QUALITY_MAP = {
        WalkthroughPipeline.PARALLAX_2_5D: VideoQuality.MEDIUM,
        WalkthroughPipeline.INSTANT_NGP_SINGLE: VideoQuality.HIGH,
        WalkthroughPipeline.INSTANT_NGP_FULL: VideoQuality.HIGH,
        WalkthroughPipeline.GAUSSIAN_SPLATTING: VideoQuality.PREMIUM,
    }
    
    # Use case descriptions
    USE_CASES = {
        WalkthroughPipeline.PARALLAX_2_5D: "Single room showcase, quick preview, trial content",
        WalkthroughPipeline.INSTANT_NGP_SINGLE: "Small apartment, studio, single zone tour",
        WalkthroughPipeline.INSTANT_NGP_FULL: "Apartment/condo virtual tour for online listings",
        WalkthroughPipeline.GAUSSIAN_SPLATTING: "Luxury property showcase, premium marketing",
    }
    
    def __init__(self):
        """Initialize the pipeline selector"""
        self.detectron2_enabled = True
        self.ngp_enabled = True
        self.gaussian_enabled = True
    
    def select_pipeline(self, input_data: WalkthroughInput) -> WalkthroughOutput:
        """
        Select the optimal walkthrough pipeline based on input parameters.
        
        Decision Rules (MANDATORY):
        1. Never use Gaussian Splatting for free or basic plans
        2. Prefer the cheapest pipeline that provides acceptable quality
        3. High resolution is MANDATORY - never downgrade
        4. Gaussian Splatting ONLY when:
           - user_plan == premium AND photo_count >= 15
           - OR luxury_flag == true
        5. InstantNGP is the DEFAULT paid walkthrough engine
        6. 2.5D Parallax for:
           - single-room videos
           - <= 4 photos
           - trial or free tiers
        
        Args:
            input_data: WalkthroughInput with all required parameters
            
        Returns:
            WalkthroughOutput with selected pipeline and metadata
        """
        photo_count = input_data.photo_count
        user_plan = input_data.user_plan
        luxury_flag = input_data.luxury_flag
        room_types = input_data.room_types
        
        logger.info(
            f"Selecting pipeline: photos={photo_count}, plan={user_plan.value}, "
            f"luxury={luxury_flag}, rooms={len(room_types)}"
        )
        
        # Apply decision logic
        pipeline = self._apply_decision_rules(
            photo_count=photo_count,
            user_plan=user_plan,
            luxury_flag=luxury_flag
        )
        
        # Calculate cost
        base_cost = self.GPU_COSTS[pipeline]
        photo_multiplier = max(1, photo_count / 10)  # Scale cost with photos
        estimated_cost = base_cost * photo_multiplier
        
        # Calculate duration
        base_duration = self.DURATION_PER_PHOTO[pipeline] * photo_count
        transition_time = (photo_count - 1) * 0.5 if photo_count > 1 else 0
        total_duration = base_duration + transition_time
        
        # Get quality
        quality = self.QUALITY_MAP[pipeline]
        
        # Determine models used
        models_used = self._get_models_used(pipeline)
        
        # Generate notes
        notes = self._generate_notes(
            pipeline=pipeline,
            photo_count=photo_count,
            user_plan=user_plan,
            luxury_flag=luxury_flag
        )
        
        # Build processing params
        processing_params = self._build_processing_params(
            pipeline=pipeline,
            photo_count=photo_count,
            room_types=room_types
        )
        
        output = WalkthroughOutput(
            selected_pipeline=pipeline.value,
            models_used=models_used,
            expected_video_quality=quality.value,
            estimated_gpu_cost_usd=f"{estimated_cost:.2f}",
            recommended_use_case=self.USE_CASES[pipeline],
            notes=notes,
            processing_params=processing_params,
            estimated_duration_seconds=total_duration,
            requires_premium=(pipeline == WalkthroughPipeline.GAUSSIAN_SPLATTING)
        )
        
        logger.info(f"Selected pipeline: {pipeline.value}, cost: ${estimated_cost:.2f}")
        
        return output
    
    def _apply_decision_rules(
        self,
        photo_count: int,
        user_plan: UserPlan,
        luxury_flag: bool
    ) -> WalkthroughPipeline:
        """
        Apply the mandatory decision rules.
        
        Pipeline Selection Logic (EXACT):
        
        IF photo_count <= 4:
            pipeline = "2.5D Parallax (single room)"
        ELSE IF photo_count <= 8:
            pipeline = "InstantNGP (single zone walkthrough)"
        ELSE IF photo_count <= 15:
            pipeline = "InstantNGP (full apartment walkthrough)"
        ELSE IF user_plan == "premium" OR luxury_flag == true:
            pipeline = "Nerfstudio Gaussian Splatting"
        ELSE:
            pipeline = "InstantNGP (full apartment walkthrough)"
        """
        # Rule 1: Low photo count -> 2.5D Parallax
        if photo_count <= 4:
            return WalkthroughPipeline.PARALLAX_2_5D
        
        # Rule 2: Medium photo count -> InstantNGP single zone
        if photo_count <= 8:
            # Free/Basic users get Parallax instead (cost savings)
            if user_plan in [UserPlan.FREE, UserPlan.BASIC]:
                return WalkthroughPipeline.PARALLAX_2_5D
            return WalkthroughPipeline.INSTANT_NGP_SINGLE
        
        # Rule 3: Higher photo count -> InstantNGP full
        if photo_count <= 15:
            # Free users still get Parallax
            if user_plan == UserPlan.FREE:
                return WalkthroughPipeline.PARALLAX_2_5D
            # Basic users get single zone
            if user_plan == UserPlan.BASIC:
                return WalkthroughPipeline.INSTANT_NGP_SINGLE
            return WalkthroughPipeline.INSTANT_NGP_FULL
        
        # Rule 4: Many photos - check for Gaussian eligibility
        if user_plan == UserPlan.PREMIUM or luxury_flag:
            return WalkthroughPipeline.GAUSSIAN_SPLATTING
        
        # Rule 5: Default fallback - InstantNGP full
        if user_plan == UserPlan.FREE:
            return WalkthroughPipeline.PARALLAX_2_5D
        
        return WalkthroughPipeline.INSTANT_NGP_FULL
    
    def _get_models_used(self, pipeline: WalkthroughPipeline) -> List[str]:
        """Get list of AI models used by the pipeline"""
        base_models = ["Detectron2"]  # Always used for scene analysis
        
        if pipeline == WalkthroughPipeline.PARALLAX_2_5D:
            return base_models + ["Depth Estimation", "2.5D Parallax Engine"]
        
        if pipeline in [
            WalkthroughPipeline.INSTANT_NGP_SINGLE,
            WalkthroughPipeline.INSTANT_NGP_FULL
        ]:
            return base_models + ["InstantNGP", "Neural Radiance Field"]
        
        if pipeline == WalkthroughPipeline.GAUSSIAN_SPLATTING:
            return base_models + ["Nerfstudio", "3D Gaussian Splatting", "Neural Point Cloud"]
        
        return base_models
    
    def _generate_notes(
        self,
        pipeline: WalkthroughPipeline,
        photo_count: int,
        user_plan: UserPlan,
        luxury_flag: bool
    ) -> str:
        """Generate contextual notes for the selection"""
        notes = []
        
        # Photo count note
        notes.append(f"{photo_count} photos detected.")
        
        # Pipeline explanation
        if pipeline == WalkthroughPipeline.PARALLAX_2_5D:
            notes.append("Using 2.5D depth-based parallax for smooth motion effect.")
            if photo_count > 4 and user_plan in [UserPlan.FREE, UserPlan.BASIC]:
                notes.append("Upgrade to PRO for InstantNGP 3D reconstruction.")
        
        elif pipeline == WalkthroughPipeline.INSTANT_NGP_SINGLE:
            notes.append("Using InstantNGP for single-zone 3D walkthrough.")
            if photo_count > 8:
                notes.append("Consider adding more photos for full apartment coverage.")
        
        elif pipeline == WalkthroughPipeline.INSTANT_NGP_FULL:
            notes.append("Using InstantNGP for room-to-room continuity.")
            if user_plan == UserPlan.PRO and not luxury_flag:
                notes.append("Premium Gaussian Splatting available for luxury upgrade.")
        
        elif pipeline == WalkthroughPipeline.GAUSSIAN_SPLATTING:
            notes.append("Using Nerfstudio Gaussian Splatting for premium quality.")
            notes.append("High-fidelity 3D with advanced camera path rendering.")
        
        # Luxury flag
        if luxury_flag:
            notes.append("Luxury property flag enabled - maximum quality mode.")
        
        return " ".join(notes)
    
    def _build_processing_params(
        self,
        pipeline: WalkthroughPipeline,
        photo_count: int,
        room_types: List[str]
    ) -> Dict:
        """Build pipeline-specific processing parameters"""
        params = {
            "pipeline_type": pipeline.value,
            "photo_count": photo_count,
            "room_count": len(set(room_types)),
            "resolution": "1920x1080",  # Always high-res
            "fps": 30,
            "codec": "h264",
        }
        
        if pipeline == WalkthroughPipeline.PARALLAX_2_5D:
            params.update({
                "depth_model": "MiDaS",
                "parallax_intensity": 0.03,
                "motion_blur": True,
                "crossfade_duration": 0.5,
            })
        
        elif pipeline in [
            WalkthroughPipeline.INSTANT_NGP_SINGLE,
            WalkthroughPipeline.INSTANT_NGP_FULL
        ]:
            params.update({
                "ngp_resolution": 512,
                "ngp_steps": 10000 if pipeline == WalkthroughPipeline.INSTANT_NGP_FULL else 5000,
                "camera_path": "smooth_spline",
                "interpolation_frames": 60,
            })
        
        elif pipeline == WalkthroughPipeline.GAUSSIAN_SPLATTING:
            params.update({
                "gs_iterations": 30000,
                "point_cloud_density": "high",
                "camera_path": "cinematic",
                "render_quality": "ultra",
                "antialiasing": "msaa_8x",
            })
        
        return params
    
    def estimate_cost(self, input_data: WalkthroughInput) -> float:
        """Quick cost estimation without full pipeline selection"""
        output = self.select_pipeline(input_data)
        return float(output.estimated_gpu_cost_usd)
    
    def validate_input(self, input_data: WalkthroughInput) -> List[str]:
        """Validate input parameters and return any errors"""
        errors = []
        
        if input_data.photo_count < 1:
            errors.append("At least 1 photo is required")
        
        if input_data.photo_count > 100:
            errors.append("Maximum 100 photos allowed per walkthrough")
        
        if not input_data.room_types:
            errors.append("At least one room type must be specified")
        
        valid_resolutions = ["720p", "1080p", "4k"]
        if input_data.target_resolution not in valid_resolutions:
            errors.append(f"Invalid resolution. Valid: {valid_resolutions}")
        
        return errors


# Global singleton instance
walkthrough_selector = WalkthroughPipelineSelector()


def select_walkthrough_pipeline(
    photo_count: int,
    room_types: List[str],
    user_plan: str = "free",
    luxury_flag: bool = False,
    listing_id: Optional[str] = None,
    user_id: Optional[str] = None
) -> Dict:
    """
    Convenience function to select walkthrough pipeline.
    
    Args:
        photo_count: Number of property photos
        room_types: List of room types (living_room, bedroom, etc.)
        user_plan: User subscription plan (free, basic, pro, premium)
        luxury_flag: Whether this is a luxury property
        listing_id: Optional listing ID
        user_id: Optional user ID
        
    Returns:
        Dictionary with pipeline selection decision
    """
    # Map string plan to enum
    plan_map = {
        "free": UserPlan.FREE,
        "basic": UserPlan.BASIC,
        "pro": UserPlan.PRO,
        "premium": UserPlan.PREMIUM,
        # Legacy plan names
        "FREE": UserPlan.FREE,
        "TRIAL": UserPlan.BASIC,
        "PAID": UserPlan.PRO,
        "PRO": UserPlan.PRO,
        "ULTIMATE": UserPlan.PREMIUM,
        "ENTERPRISE": UserPlan.PREMIUM,
    }
    
    user_plan_enum = plan_map.get(user_plan, UserPlan.FREE)
    
    input_data = WalkthroughInput(
        photo_count=photo_count,
        room_types=room_types,
        user_plan=user_plan_enum,
        luxury_flag=luxury_flag,
        listing_id=listing_id,
        user_id=user_id
    )
    
    output = walkthrough_selector.select_pipeline(input_data)
    return output.model_dump()
