from datetime import datetime
from typing import List, Optional
from sqlalchemy import String, Integer, DateTime, ForeignKey, Text, Enum as SQLAlchemyEnum
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from sqlalchemy.sql import func
from app.signature.domain.enums import SignatureStatus, SignerRole

class Base(DeclarativeBase):
    pass

class SignatureRequest(Base):
    __tablename__ = "signature_requests"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    title: Mapped[str] = mapped_column(String(255))
    status: Mapped[SignatureStatus] = mapped_column(SQLAlchemyEnum(SignatureStatus), default=SignatureStatus.DRAFT)
    provider: Mapped[Optional[str]] = mapped_column(String(50))
    provider_request_id: Mapped[Optional[str]] = mapped_column(String(255))
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())
    expires_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True))

    documents: Mapped[List["SignatureDocument"]] = relationship(back_populates="request", cascade="all, delete-orphan")
    signers: Mapped[List["Signer"]] = relationship(back_populates="request", cascade="all, delete-orphan")
    audit_logs: Mapped[List["SignatureAuditLog"]] = relationship(back_populates="request", cascade="all, delete-orphan")

class SignatureDocument(Base):
    __tablename__ = "signature_documents"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    request_id: Mapped[int] = mapped_column(ForeignKey("signature_requests.id"))
    file_name: Mapped[str] = mapped_column(String(255))
    original_pdf_url: Mapped[str] = mapped_column(Text)
    signed_pdf_url: Mapped[Optional[str]] = mapped_column(Text)
    document_hash: Mapped[str] = mapped_column(String(64)) # SHA256 hash
    version: Mapped[int] = mapped_column(Integer, default=1)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    request: Mapped["SignatureRequest"] = relationship(back_populates="documents")

class Signer(Base):
    __tablename__ = "signers"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    request_id: Mapped[int] = mapped_column(ForeignKey("signature_requests.id"))
    user_id: Mapped[Optional[str]] = mapped_column(String(255))
    name: Mapped[str] = mapped_column(String(255))
    email: Mapped[str] = mapped_column(String(255))
    phone: Mapped[Optional[str]] = mapped_column(String(50))
    role: Mapped[SignerRole] = mapped_column(SQLAlchemyEnum(SignerRole))
    signing_order: Mapped[int] = mapped_column(Integer, default=1)
    status: Mapped[str] = mapped_column(String(50), default="PENDING")
    signed_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True))
    certificate_provider: Mapped[Optional[str]] = mapped_column(String(100))
    provider_signer_id: Mapped[Optional[str]] = mapped_column(String(255))

    request: Mapped["SignatureRequest"] = relationship(back_populates="signers")

class SignatureAuditLog(Base):
    __tablename__ = "signature_audit_logs"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    request_id: Mapped[int] = mapped_column(ForeignKey("signature_requests.id"))
    action: Mapped[str] = mapped_column(String(100))
    description: Mapped[str] = mapped_column(Text)
    actor_id: Mapped[Optional[str]] = mapped_column(String(255))
    ip_address: Mapped[Optional[str]] = mapped_column(String(45))
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    request: Mapped["SignatureRequest"] = relationship(back_populates="audit_logs")
