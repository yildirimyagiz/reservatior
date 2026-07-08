import uuid
import logging
from typing import Dict, Any
from app.signature.infrastructure.providers.base import SignatureProvider

logger = logging.getLogger(__name__)

class ArkImzaProvider(SignatureProvider):
    """Mock implementation for Arkİmza provider."""

    async def create_request(self, request_data: Dict[str, Any]) -> str:
        provider_id = f"ark_{uuid.uuid4()}"
        logger.info(f"ArkImza: Created request {provider_id} with data {request_data}")
        return provider_id

    async def send_document(self, provider_request_id: str, document_data: bytes, metadata: Dict[str, Any]) -> str:
        doc_id = f"doc_{uuid.uuid4()}"
        logger.info(f"ArkImza: Uploaded document {doc_id} for request {provider_request_id}")
        return doc_id

    async def sign(self, provider_request_id: str, signer_info: Dict[str, Any]) -> bool:
        logger.info(f"ArkImza: Triggered signing for request {provider_request_id} for signer {signer_info.get('email')}")
        return True

    async def check_status(self, provider_request_id: str) -> str:
        logger.info(f"ArkImza: Checking status for {provider_request_id}")
        return "SIGNED"

    async def download_signed_document(self, provider_request_id: str, document_id: str) -> bytes:
        logger.info(f"ArkImza: Downloading signed document {document_id} for {provider_request_id}")
        return b"%PDF-1.4 Mock Signed Document ArkImza"
