"""CRUD operations for Brochure service."""
from prisma import Prisma
from prisma.models import Brochure
from typing import Optional, List

async def create_brochure(db: Prisma, data: dict) -> Brochure:
    """Create a new brochure record."""
    return await db.brochure.create(data=data)

async def get_brochure(db: Prisma, brochure_id: str) -> Optional[Brochure]:
    """Get brochure by ID."""
    return await db.brochure.find_unique(where={"id": brochure_id})

async def list_brochures_for_property(db: Prisma, property_id: str) -> List[Brochure]:
    """List brochures for a property."""
    return await db.brochure.find_many(where={"propertyId": property_id})
