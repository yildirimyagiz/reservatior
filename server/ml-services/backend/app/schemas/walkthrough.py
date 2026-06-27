from enum import Enum
from typing import List, Optional, Dict, Any
from pydantic import BaseModel, Field
from datetime import datetime
from decimal import Decimal

# Import Enums (or redefine if they need to match Prisma strictly)
# Prisma: enum WalkthroughStatus { QUEUED PROCESSING COMPLETED FAILED }
class WalkthroughStatus(str, Enum):
    QUEUED = "QUEUED"
    PROCESSING = "PROCESSING"
    COMPLETED = "COMPLETED"
    FAILED = "FAILED"

# Prisma: enum WalkthroughPipeline { PARALLAX_2_5D INSTANT_NGP_SINGLE INSTANT_NGP_FULL GAUSSIAN_SPLATTING }
class WalkthroughPipeline(str, Enum):
    PARALLAX_2_5D = "PARALLAX_2_5D"
    INSTANT_NGP_SINGLE = "INSTANT_NGP_SINGLE"
    INSTANT_NGP_FULL = "INSTANT_NGP_FULL"
    GAUSSIAN_SPLATTING = "GAUSSIAN_SPLATTING"

class UserPlan(str, Enum):
    FREE = "free"
    BASIC = "basic"
    PRO = "pro"
    PREMIUM = "premium"

# Input Schema (for API)
class WalkthroughInput(BaseModel):
    photo_count: int
    room_types: List[str]
    target_resolution: str = "1080p"
    user_plan: UserPlan = UserPlan.FREE
    luxury_flag: bool = False
    listing_id: Optional[str] = None
    user_id: Optional[str] = None

# Output Schema (for API response)
class WalkthroughOutput(BaseModel):
    selected_pipeline: str
    models_used: List[str]
    expected_video_quality: str
    estimated_gpu_cost_usd: str
    recommended_use_case: str
    notes: str
    processing_params: Dict[str, Any] = {}
    estimated_duration_seconds: float = 0.0
    requires_premium: bool = False

# DB Model Schema (Mirroring Prisma)
class WalkthroughBase(BaseModel):
    userId: str
    propertyId: Optional[str] = None
    status: WalkthroughStatus = WalkthroughStatus.QUEUED
    photoCount: int
    roomTypes: List[str]
    luxury: bool = False
    pipeline: WalkthroughPipeline
    videoUrl: Optional[str] = None
    cost: Optional[Decimal] = None
    metadata: Optional[Dict[str, Any]] = None

class WalkthroughCreate(WalkthroughBase):
    pass

class Walkthrough(WalkthroughBase):
    id: str
    createdAt: datetime
    updatedAt: datetime

    class Config:
        from_attributes = True
