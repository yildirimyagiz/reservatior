from fastapi import APIRouter
from app.services.brochure_service.routes import router as brochures_router
from app.signature.api.routes import router as signature_router
from app.api.v1.endpoints import (
    jobs,
    webhooks,
    walkthroughs,
    staging,
    amazon,
    real_estate_ai,
    cleaning_vision,
    contracts,
    e_bills,
    property_health,
    ad_engine,
    creator,
    property_os,
)

api_router = APIRouter()
api_router.include_router(jobs.router, prefix="/jobs", tags=["jobs"])
api_router.include_router(webhooks.router, prefix="/webhooks", tags=["webhooks"])
api_router.include_router(walkthroughs.router, prefix="/walkthroughs", tags=["walkthroughs"])
api_router.include_router(staging.router, prefix="/staging", tags=["staging"])
api_router.include_router(amazon.router, prefix="/amazon", tags=["amazon"])
api_router.include_router(real_estate_ai.router, prefix="/real-estate", tags=["real-estate-ai"])
api_router.include_router(cleaning_vision.router, prefix="/cleaning", tags=["cleaning-vision"])
api_router.include_router(contracts.router, prefix="/contracts", tags=["contracts"])
api_router.include_router(e_bills.router, prefix="/e-bills", tags=["e-bills"])

# Property OS & Growth AI Engines
api_router.include_router(property_health.router, prefix="/property-health", tags=["property-health"])
api_router.include_router(ad_engine.router, prefix="/ads", tags=["ad-engine"])
api_router.include_router(creator.router, prefix="/creator", tags=["creator-commerce"])
api_router.include_router(property_os.router, prefix="/os", tags=["property-os"])

api_router.include_router(signature_router)
api_router.include_router(brochures_router)
