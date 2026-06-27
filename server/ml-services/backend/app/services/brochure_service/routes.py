from fastapi import APIRouter, Depends, HTTPException
from .models import BrochureGenerationRequest
from .generator import BrochureGenerator
from app.core.deps import get_current_user
from app.core.database import db
from fastapi.responses import FileResponse
import os

router = APIRouter(prefix="/brochures", tags=["brochures"])
brochure_generator = BrochureGenerator()

@router.get("/list")
async def get_brochures(user=Depends(get_current_user)):
    """Get all brochures for the current user"""
    brochures = await db.brochurejob.find_many(
        where={
            "property": {
                "userId": user.id
            }
        },
        include={"property": True},
        order={"createdAt": "desc"}
    )
    return {"brochures": brochures, "total": len(brochures)}

@router.get("/templates")
async def get_brochure_templates(user=Depends(get_current_user)):
    """Get available brochure templates"""
    templates = [
        {"id": "navy_blue_gold", "name": "Navy Gold Curve", "description": "Premium dark navy design with gold accents.", "isPremium": True, "thumbnailUrl": "/templates/navy_blue_gold.jpg"},
        {"id": "modern_clean_grid", "name": "Modern Clean Grid", "description": "Minimalist white grid layout with large typography.", "isPremium": False, "thumbnailUrl": "/templates/modern_clean_grid.jpg"},
        {"id": "magazine_left", "name": "Magazine Sidebar", "description": "Editorial style with left sidebar and image stack.", "isPremium": True, "thumbnailUrl": "/templates/magazine_left.jpg"},
        {"id": "corporate_silver", "name": "Corporate Silver", "description": "Professional agency-focused design with curved headers.", "isPremium": True, "thumbnailUrl": "/templates/corporate_silver.jpg"},
        {"id": "just_listed_creative", "name": "Creative Collage", "description": "Artistic collage layout with handwritten accents.", "isPremium": False, "thumbnailUrl": "/templates/just_listed_creative.jpg"},
        {"id": "modern_open_house", "name": "Modern Open House", "description": "Large visual impact with clear open house details.", "isPremium": True, "thumbnailUrl": "/templates/modern_open_house.jpg"},
        {"id": "luxury_dark", "name": "Luxury Dark", "description": "Elegant dark theme for high-end properties.", "isPremium": True, "thumbnailUrl": "/templates/luxury_dark.jpg"},
        {"id": "modern", "name": "Standard Modern", "description": "Clean and contemporary design.", "isPremium": False, "thumbnailUrl": "/templates/modern.jpg"},
    ]
    return {"templates": templates}

@router.post("/generate", response_class=FileResponse)
async def generate_brochure(payload: BrochureGenerationRequest, user=Depends(get_current_user)):
    # ... (rest of logic) ...
    # (Existing logic up to notification)
    
    # (Logic continues below)
    # Subscription Check (Feature Gate) - BYPASSED FOR TESTING
    # sub = await db.subscription.find_first(
    #     where={"userId": user.id, "status": "ACTIVE"},
    #     order={"createdAt": "desc"}
    # )
    # plan = sub.plan if sub else "FREE"
    
    # if plan == "FREE":
    #     raise HTTPException(
    #         status_code=403, 
    #         detail="Brochure generation is available on Basic plans and above. Please upgrade."
    #     )

    prop = None
    property_data = {}
    photo_paths = []
    agent_photo = "storage/defaults/agent_placeholder.jpg"

    if payload.property_id:
        prop = await db.property.find_unique(where={"id": payload.property_id}, include={"photos": True})
        if not prop or prop.userId != user.id:
            raise HTTPException(403, "User does not own this property")
        
        property_data = prop.model_dump()
        
        # Fetch agent/user from property owner
        agent = await db.user.find_unique(where={"id": prop.userId})
        if agent and agent.profileImageUrl:
            agent_photo = agent.profileImageUrl

        if payload.custom_photos:
            photo_paths = payload.custom_photos
        else:
            photo_paths = [photo.filePath for photo in prop.photos]
    else:
        # Ad-hoc Generation
        if not payload.title or not payload.address:
             raise HTTPException(400, "Title and Address are required for ad-hoc brochures")
             
        property_data = {
            "id": "adhoc_" + str(user.id), # Fake ID for filename
            "title": payload.title,
            "address": payload.address,
            "description": payload.description or "",
            "price": payload.price or 0,
            "bedrooms": payload.bedrooms or 0,
            "bathrooms": payload.bathrooms or 0,
            "sqft": payload.sqft or 0,
            "sqft": payload.sqft or 0,
            "url": payload.listing_url or "https://comyfystaging.com",
            # Agent Data
            "agent_name": payload.agent_name,
            "agent_email": payload.agent_email,
            "agent_phone": payload.agent_phone,
            "agency_name": payload.agency_name,
            "agency_logo_url": payload.agency_logo_url
        }
        
        photo_paths = payload.custom_photos or []
        if not photo_paths:
            raise HTTPException(400, "Photos are required for ad-hoc brochures")
        
        if payload.agent_photo_url:
            agent_photo = payload.agent_photo_url
        else:
            # Try to get current user agent photo?
            agent = await db.user.find_unique(where={"id": user.id})
            if agent and agent.profileImageUrl:
                agent_photo = agent.profileImageUrl

    brochure_path = brochure_generator.generate(
        property_data=property_data,
        photos=photo_paths,
        template_id=payload.template,
        agent_photo_path=agent_photo
    )

    if not os.path.exists(brochure_path):
        raise HTTPException(500, "Failed to generate brochure")

    # Create DB record only if property exists
    if prop:
        from . import crud
        await crud.create_brochure(db, {
            "propertyId": prop.id,
            "title": f"Brochure for {prop.title}",
            "template": payload.template,
            "filePath": brochure_path,
            "status": "completed",
            "settings": {},
        })
    
    # Send Notification - DISABLED FOR TESTING
    # from notification_service.crud import create_notification
    # await create_notification(db, {
    #     "userId": user.id,
    #     "type": "BROCHURE_GENERATED",
    #     "title": "Brochure Ready",
    #     "message": f"Brochure for {property_data['title']} has been generated.",
    #     "actionUrl": "#", 
    #     "priority": "NORMAL"
    # })

    return FileResponse(brochure_path, media_type="application/pdf", filename=f"brochure_{property_data.get('id', 'generated')}.pdf")
