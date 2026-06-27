
from fastapi import APIRouter
from app.services.brochure_service.routes import router as brochures_router
from app.api.v1.endpoints import jobs, webhooks, walkthroughs, staging, amazon, real_estate_ai

api_router = APIRouter()
api_router.include_router(jobs.router, prefix="/jobs", tags=["jobs"])
api_router.include_router(webhooks.router, prefix="/webhooks", tags=["webhooks"])
api_router.include_router(walkthroughs.router, prefix="/walkthroughs", tags=["walkthroughs"])
api_router.include_router(staging.router, prefix="/staging", tags=["staging"])
api_router.include_router(amazon.router, prefix="/amazon", tags=["amazon"])
api_router.include_router(real_estate_ai.router, prefix="/real-estate", tags=["real-estate-ai"])
api_router.include_router(brochures_router)
