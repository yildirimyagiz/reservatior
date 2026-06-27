from enum import Enum
from typing import Optional, Dict, Any, List
from pydantic import BaseModel
from datetime import datetime
from decimal import Decimal

class GenerationType(str, Enum):
    IMAGE = "IMAGE"
    VIDEO = "VIDEO"
    PANORAMA_360 = "PANORAMA_360"

class GenerationBase(BaseModel):
    userId: str
    type: GenerationType = GenerationType.IMAGE
    prompt: str
    roomType: Optional[str] = None
    style: Optional[str] = None
    originalImageUrl: Optional[str] = None
    maskImageUrl: Optional[str] = None
    propertyId: Optional[str] = None
    imageUrl: Optional[str] = None
    videoUrl: Optional[str] = None
    cost: int
    settings: Optional[Dict[str, Any]] = None

class GenerationCreate(GenerationBase):
    pass

class Generation(GenerationBase):
    id: str
    createdAt: datetime
    
    class Config:
        from_attributes = True

class BrochureBase(BaseModel):
    userId: str
    title: str
    propertyAddress: Optional[str] = None
    content: Optional[Dict[str, Any]] = None
    pdfUrl: Optional[str] = None

class Brochure(BrochureBase):
    id: str
    createdAt: datetime
    updatedAt: datetime
    
    class Config:
        from_attributes = True
