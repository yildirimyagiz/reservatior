from abc import ABC, abstractmethod
from typing import List, Dict, Any

class SignatureProvider(ABC):
    """Abstract interface for electronic signature providers."""

    @abstractmethod
    async def create_request(self, request_data: Dict[str, Any]) -> str:
        """Creates a signature request in the provider and returns the provider_request_id."""
        pass

    @abstractmethod
    async def send_document(self, provider_request_id: str, document_data: bytes, metadata: Dict[str, Any]) -> str:
        """Uploads a document to the provider."""
        pass

    @abstractmethod
    async def sign(self, provider_request_id: str, signer_info: Dict[str, Any]) -> bool:
        """Triggers the signing process for a signer."""
        pass

    @abstractmethod
    async def check_status(self, provider_request_id: str) -> str:
        """Checks the overall status of the signature request."""
        pass

    @abstractmethod
    async def download_signed_document(self, provider_request_id: str, document_id: str) -> bytes:
        """Downloads the signed PDF document from the provider."""
        pass
