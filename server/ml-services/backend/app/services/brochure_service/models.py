from pydantic import BaseModel
from typing import Optional

class BrochureGenerationRequest(BaseModel):
    property_id: Optional[str] = None
    template: str = "modern"
    custom_photos: Optional[list[str]] = None
    
    # Ad-hoc fields if property_id is missing
    title: Optional[str] = None
    address: Optional[str] = None
    description: Optional[str] = None
    price: Optional[float] = None
    bedrooms: Optional[int] = None
    bathrooms: Optional[float] = None
    sqft: Optional[float] = None
    agent_name: Optional[str] = None
    agent_photo_url: Optional[str] = None
    agent_phone: Optional[str] = None
    agent_email: Optional[str] = None
    agency_name: Optional[str] = None
    agency_logo_url: Optional[str] = None
    listing_url: Optional[str] = None

