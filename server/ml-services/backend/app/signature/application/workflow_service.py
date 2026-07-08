from typing import Optional
from sqlalchemy.ext.asyncio import AsyncSession
from app.signature.domain.models import SignatureRequest, SignatureDocument, Signer, SignatureAuditLog
from app.signature.domain.enums import SignatureStatus
from app.signature.domain.exceptions import InvalidStatusTransition, DocumentImmutableError, RequestExpiredError
from app.signature.repository import SignatureRepository
from app.signature.application.signature_service import SignatureService
from app.signature.schemas import SignatureRequestCreate, SignerCreate, SignatureDocumentCreate

class WorkflowService:
    def __init__(self, session: AsyncSession):
        self.repo = SignatureRepository(session)
        self.signature_service = SignatureService()

    async def _log_audit(self, request_id: int, action: str, description: str, actor_id: Optional[str] = None):
        audit_log = SignatureAuditLog(
            request_id=request_id,
            action=action,
            description=description,
            actor_id=actor_id
        )
        await self.repo.add_audit_log(audit_log)

    async def create_request(self, data: SignatureRequestCreate, actor_id: Optional[str] = None) -> SignatureRequest:
        request = SignatureRequest(
            title=data.title,
            provider=data.provider,
            expires_at=data.expires_at,
            status=SignatureStatus.DRAFT
        )
        request = await self.repo.create_request(request)
        await self._log_audit(request.id, "CREATED", "Signature request created", actor_id)
        return request

    async def add_document(self, request_id: int, data: SignatureDocumentCreate, document_data: bytes, actor_id: Optional[str] = None) -> SignatureDocument:
        request = await self.repo.get_request(request_id)
        if request.status != SignatureStatus.DRAFT:
            raise DocumentImmutableError("Cannot add document: Request is no longer in DRAFT state.")

        actual_hash = self.signature_service.calculate_hash(document_data)
        if actual_hash != data.document_hash:
            raise ValueError("Document hash mismatch")

        document = SignatureDocument(
            request_id=request.id,
            file_name=data.file_name,
            original_pdf_url=data.original_pdf_url,
            document_hash=actual_hash
        )
        document = await self.repo.add_document(document)
        await self._log_audit(request.id, "DOCUMENT_ADDED", f"Added document {data.file_name}", actor_id)
        return document

    async def add_signer(self, request_id: int, data: SignerCreate, actor_id: Optional[str] = None) -> Signer:
        request = await self.repo.get_request(request_id)
        if request.status != SignatureStatus.DRAFT:
            raise DocumentImmutableError("Cannot add signer: Request is no longer in DRAFT state.")

        signer = Signer(
            request_id=request.id,
            user_id=data.user_id,
            name=data.name,
            email=data.email,
            phone=data.phone,
            role=data.role,
            signing_order=data.signing_order
        )
        signer = await self.repo.add_signer(signer)
        await self._log_audit(request.id, "SIGNER_ADDED", f"Added signer {data.email}", actor_id)
        return signer

    async def start_workflow(self, request_id: int, actor_id: Optional[str] = None) -> SignatureRequest:
        request = await self.repo.get_request(request_id)
        if request.status != SignatureStatus.DRAFT:
            raise InvalidStatusTransition("Can only start DRAFT requests.")
        if not request.documents:
            raise ValueError("Cannot start workflow without documents.")
        if not request.signers:
            raise ValueError("Cannot start workflow without signers.")

        provider = request.provider or "remote"
        
        provider_request_id = await self.signature_service.create_provider_request(provider, {"title": request.title})
        request.provider_request_id = provider_request_id
        
        for doc in request.documents:
            # In a real app we'd fetch the document bytes from S3/local storage here
            mock_doc_bytes = b"%PDF-1.4 Mock Document Content"
            await self.signature_service.send_provider_document(provider, provider_request_id, mock_doc_bytes, {"file_name": doc.file_name})

        for signer in request.signers:
            await self.signature_service.start_provider_signing(provider, provider_request_id, {"email": signer.email, "name": signer.name})

        request.status = SignatureStatus.PENDING_SIGNATURE
        await self.repo.update_request(request)
        await self._log_audit(request.id, "WORKFLOW_STARTED", f"Sent to provider {provider}", actor_id)
        return request

    async def cancel_workflow(self, request_id: int, actor_id: Optional[str] = None) -> SignatureRequest:
        request = await self.repo.get_request(request_id)
        if request.status in [SignatureStatus.SIGNED, SignatureStatus.CANCELLED, SignatureStatus.EXPIRED]:
            raise InvalidStatusTransition(f"Cannot cancel request in {request.status.value} state.")
        
        request.status = SignatureStatus.CANCELLED
        await self.repo.update_request(request)
        await self._log_audit(request.id, "CANCELLED", "Workflow cancelled manually", actor_id)
        return request
