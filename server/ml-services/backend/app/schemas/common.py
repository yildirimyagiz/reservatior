from __future__ import annotations
from enum import Enum
from pydantic import BaseModel
from typing import List, Optional

class RoomType(str, Enum):
    LIVING_ROOM = "living-room"
    BEDROOM = "bedroom"
    DINING_ROOM = "dining-room"
    KITCHEN = "kitchen"
    OFFICE = "office"
    BATHROOM = "bathroom"
    OUTDOOR = "outdoor"
    KIDS_ROOM = "kids-room"
    HOME_GYM = "home-gym"
    ADD_ROOM = "add-room"

class DesignStyle(str, Enum):
    MODERN_MINIMALIST = "modern-minimalist"
    SCANDINAVIAN = "scandinavian"
    INDUSTRIAL = "industrial"
    MID_CENTURY_MODERN = "mid-century-modern"
    BOHEMIAN = "bohemian"
    CONTEMPORARY = "contemporary"
    TRADITIONAL = "traditional"
    COASTAL = "coastal"
    FARMHOUSE = "farmhouse"
    LUXURY = "luxury"
    CYBERPUNK = "cyberpunk"
    JAPANESE = "japanese"
    BIOPHILIC = "biophilic"
    ART_DECO = "art-deco"

# Shopify/Amazon related schemas
class ShopifyPrice(BaseModel):
    amount: str
    currencyCode: str

class ShopifyImage(BaseModel):
    url: str
    altText: Optional[str] = None
    width: Optional[int] = None
    height: Optional[int] = None

class ShopifyVariant(BaseModel):
    id: str
    title: str
    availableForSale: bool
    price: ShopifyPrice
    image: Optional[ShopifyImage] = None

class ShopifyProduct(BaseModel):
    id: str
    title: str
    handle: str
    description: str
    productType: str
    vendor: str
    tags: List[str]
    price: ShopifyPrice
    maxPrice: Optional[ShopifyPrice] = None
    image: Optional[ShopifyImage] = None
    images: List[ShopifyImage] = []
    variants: List[ShopifyVariant] = []

class ShopifyPageInfo(BaseModel):
    hasNextPage: bool
    endCursor: Optional[str] = None

class ShopifyProductsResponse(BaseModel):
    products: List[ShopifyProduct]
    pageInfo: ShopifyPageInfo
