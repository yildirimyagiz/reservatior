from fastapi import APIRouter, Query
from typing import Optional
from app.services.amazon_service import amazon_service
from app.schemas.common import ShopifyProductsResponse

router = APIRouter()

@router.get("/search", response_model=ShopifyProductsResponse)
async def search_amazon_products(
    category: str = Query('furniture', description='Product category'),
    q: Optional[str] = Query(None, description='Search query'),
    limit: int = Query(20, description='Number of results')
):
    """
    Search for products on Amazon.
    """
    return await amazon_service.search_products(category, q or '', limit)
