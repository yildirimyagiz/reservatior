from datetime import datetime
from typing import Optional, List, Dict, Any
from pydantic import BaseModel
from decimal import Decimal

class AssetBase(BaseModel):
    userId: str
    propertyId: Optional[str] = None
    url: str
    filename: Optional[str] = None
    mimeType: Optional[str] = None
    size: Optional[int] = None

class AssetCreate(AssetBase):
    pass

class Asset(AssetBase):
    id: str
    createdAt: datetime
    
    class Config:
        from_attributes = True

class PropertyBase(BaseModel):
    userId: str
    title: Optional[str] = None
    address: Optional[str] = None
    description: Optional[str] = None
    price: Optional[Decimal] = None
    bedrooms: Optional[int] = None
    bathrooms: Optional[int] = None
    sqft: Optional[int] = None

class PropertyCreate(PropertyBase):
    pass

class Property(PropertyBase):
    id: str
    createdAt: datetime
    updatedAt: datetime
    
    class Config:
        from_attributes = True
