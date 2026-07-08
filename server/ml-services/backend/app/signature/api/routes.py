from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List, Optional
from app.signature.infrastructure.database import get_db
from app.signature.schemas import (
    SignatureRequestCreate,
    SignatureRequestResponse,
    SignatureDocumentCreate,
    SignatureDocumentResponse,
    SignerCreate,
    SignerResponse,
    SignatureAuditLogResponse
)
from app.signature.application.workflow_service import WorkflowService
from app.signature.repository import SignatureRepository

router = APIRouter(prefix="/signatures", tags=["Signatures"])

async def get_workflow_service(session: AsyncSession = Depends(get_db)) -> WorkflowService:
    return WorkflowService(session)

async def get_repository(session: AsyncSession = Depends(get_db)) -> SignatureRepository:
    return SignatureRepository(session)

@router.post("/request", response_model=SignatureRequestResponse, status_code=status.HTTP_201_CREATED)
async def create_request(
    data: SignatureRequestCreate,
    workflow: WorkflowService = Depends(get_workflow_service)
):
    try:
        return await workflow.create_request(data)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.post("/{request_id}/documents", response_model=SignatureDocumentResponse)
async def upload_document(
    request_id: int,
    data: SignatureDocumentCreate,
    workflow: WorkflowService = Depends(get_workflow_service)
):
    try:
        # Mocking bytes parsing, normally we'd accept an UploadFile
        mock_bytes = b"Mock document content"
        return await workflow.add_document(request_id, data, mock_bytes)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.post("/{request_id}/signers", response_model=SignerResponse)
async def add_signer(
    request_id: int,
    data: SignerCreate,
    workflow: WorkflowService = Depends(get_workflow_service)
):
    try:
        return await workflow.add_signer(request_id, data)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.post("/{request_id}/send", response_model=SignatureRequestResponse)
async def start_workflow(
    request_id: int,
    workflow: WorkflowService = Depends(get_workflow_service)
):
    try:
        return await workflow.start_workflow(request_id)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/{request_id}", response_model=SignatureRequestResponse)
async def get_status(
    request_id: int,
    repo: SignatureRepository = Depends(get_repository)
):
    request = await repo.get_request(request_id)
    if not request:
        raise HTTPException(status_code=404, detail="Request not found")
    return request

@router.post("/{request_id}/cancel", response_model=SignatureRequestResponse)
async def cancel_workflow(
    request_id: int,
    workflow: WorkflowService = Depends(get_workflow_service)
):
    try:
        return await workflow.cancel_workflow(request_id)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/{request_id}/audit", response_model=List[SignatureAuditLogResponse])
async def get_audit_history(
    request_id: int,
    repo: SignatureRepository = Depends(get_repository)
):
    return await repo.get_audit_logs(request_id)

@router.post("/webhook/{provider}")
async def webhook_callback(provider: str, payload: dict):
    # Process callbacks securely here
    return {"status": "received", "provider": provider}
