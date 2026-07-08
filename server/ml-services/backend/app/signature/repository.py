from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from sqlalchemy.orm import selectinload
from app.signature.domain.models import SignatureRequest, SignatureDocument, Signer, SignatureAuditLog

class SignatureRepository:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def create_request(self, request: SignatureRequest) -> SignatureRequest:
        self.session.add(request)
        await self.session.commit()
        await self.session.refresh(request)
        return request

    async def get_request(self, request_id: int) -> Optional[SignatureRequest]:
        stmt = select(SignatureRequest).where(SignatureRequest.id == request_id).options(
            selectinload(SignatureRequest.documents),
            selectinload(SignatureRequest.signers),
            selectinload(SignatureRequest.audit_logs)
        )
        result = await self.session.execute(stmt)
        return result.scalar_one_or_none()

    async def update_request(self, request: SignatureRequest) -> SignatureRequest:
        await self.session.commit()
        await self.session.refresh(request)
        return request

    async def add_document(self, document: SignatureDocument) -> SignatureDocument:
        self.session.add(document)
        await self.session.commit()
        await self.session.refresh(document)
        return document

    async def add_signer(self, signer: Signer) -> Signer:
        self.session.add(signer)
        await self.session.commit()
        await self.session.refresh(signer)
        return signer

    async def add_audit_log(self, audit_log: SignatureAuditLog) -> SignatureAuditLog:
        self.session.add(audit_log)
        await self.session.commit()
        await self.session.refresh(audit_log)
        return audit_log

    async def get_audit_logs(self, request_id: int) -> List[SignatureAuditLog]:
        stmt = select(SignatureAuditLog).where(SignatureAuditLog.request_id == request_id).order_by(SignatureAuditLog.created_at.desc())
        result = await self.session.execute(stmt)
        return list(result.scalars().all())
