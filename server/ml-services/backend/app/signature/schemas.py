from pydantic import BaseModel, EmailStr, Field
from typing import List, Optional
from datetime import datetime
from app.signature.domain.enums import SignatureStatus, SignerRole

class SignerBase(BaseModel):
    user_id: Optional[str] = None
    name: str
    email: EmailStr
    phone: Optional[str] = None
    role: SignerRole
    signing_order: int = 1

class SignerCreate(SignerBase):
    pass

class SignerResponse(SignerBase):
    id: int
    request_id: int
    status: str
    signed_at: Optional[datetime] = None
    certificate_provider: Optional[str] = None
    provider_signer_id: Optional[str] = None

    class Config:
        from_attributes = True

class SignatureDocumentBase(BaseModel):
    file_name: str
    original_pdf_url: str
    document_hash: str

class SignatureDocumentCreate(SignatureDocumentBase):
    pass

class SignatureDocumentResponse(SignatureDocumentBase):
    id: int
    request_id: int
    signed_pdf_url: Optional[str] = None
    version: int
    created_at: datetime

    class Config:
        from_attributes = True

class SignatureRequestBase(BaseModel):
    title: str
    provider: Optional[str] = "arkimza"
    expires_at: Optional[datetime] = None

class SignatureRequestCreate(SignatureRequestBase):
    pass

class SignatureAuditLogResponse(BaseModel):
    id: int
    request_id: int
    action: str
    description: str
    actor_id: Optional[str] = None
    ip_address: Optional[str] = None
    created_at: datetime

    class Config:
        from_attributes = True

class SignatureRequestResponse(SignatureRequestBase):
    id: int
    status: SignatureStatus
    provider_request_id: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    documents: List[SignatureDocumentResponse] = []
    signers: List[SignerResponse] = []

    class Config:
        from_attributes = True
