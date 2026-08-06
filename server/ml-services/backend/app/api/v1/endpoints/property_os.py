from fastapi import APIRouter
from app.services.property_os_orchestrator import (
    property_os_orchestrator,
    MasterOrchestrationRequest,
    MasterOrchestrationResponse,
)

router = APIRouter()

@router.post("/process-listing", response_model=MasterOrchestrationResponse)
async def process_listing(req: MasterOrchestrationRequest):
    return await property_os_orchestrator.process_listing(req)
