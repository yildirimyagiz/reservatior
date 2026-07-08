import uuid
import logging
from typing import Dict, Any
from app.signature.infrastructure.providers.base import SignatureProvider

logger = logging.getLogger(__name__)

class RemoteSigningProvider(SignatureProvider):
    """Mock implementation for a Remote Signing (e.g. eIDAS) provider."""

    async def create_request(self, request_data: Dict[str, Any]) -> str:
        provider_id = f"remote_{uuid.uuid4()}"
        logger.info(f"RemoteSigning: Created request {provider_id}")
        return provider_id

    async def send_document(self, provider_request_id: str, document_data: bytes, metadata: Dict[str, Any]) -> str:
        doc_id = f"rdoc_{uuid.uuid4()}"
        logger.info(f"RemoteSigning: Uploaded document {doc_id} for {provider_request_id}")
        return doc_id

    async def sign(self, provider_request_id: str, signer_info: Dict[str, Any]) -> bool:
        logger.info(f"RemoteSigning: Sent signing SMS/Email to {signer_info.get('email')}")
        return True

    async def check_status(self, provider_request_id: str) -> str:
        logger.info(f"RemoteSigning: Checking status for {provider_request_id}")
        return "SIGNED"

    async def download_signed_document(self, provider_request_id: str, document_id: str) -> bytes:
        logger.info(f"RemoteSigning: Downloading signed document {document_id}")
        return b"%PDF-1.4 Mock Signed Document RemoteSigning"
