import hashlib
from typing import Dict, Any, Type
from app.signature.domain.exceptions import SignatureProviderError
from app.signature.infrastructure.providers.base import SignatureProvider
from app.signature.infrastructure.providers.ark_provider import ArkImzaProvider
from app.signature.infrastructure.providers.remote_provider import RemoteSigningProvider

class SignatureService:
    def __init__(self):
        self._providers: Dict[str, Type[SignatureProvider]] = {
            "arkimza": ArkImzaProvider,
            "remote": RemoteSigningProvider
        }

    def _get_provider(self, provider_name: str) -> SignatureProvider:
        provider_class = self._providers.get(provider_name.lower())
        if not provider_class:
            raise SignatureProviderError(f"Provider {provider_name} is not supported.")
        return provider_class()

    @staticmethod
    def calculate_hash(document_data: bytes) -> str:
        """Calculate SHA-256 hash of a document."""
        sha256 = hashlib.sha256()
        sha256.update(document_data)
        return sha256.hexdigest()

    async def create_provider_request(self, provider_name: str, request_data: Dict[str, Any]) -> str:
        provider = self._get_provider(provider_name)
        try:
            return await provider.create_request(request_data)
        except Exception as e:
            raise SignatureProviderError(f"Failed to create request with {provider_name}: {str(e)}")

    async def send_provider_document(self, provider_name: str, provider_request_id: str, document_data: bytes, metadata: Dict[str, Any]) -> str:
        provider = self._get_provider(provider_name)
        try:
            return await provider.send_document(provider_request_id, document_data, metadata)
        except Exception as e:
            raise SignatureProviderError(f"Failed to send document to {provider_name}: {str(e)}")

    async def start_provider_signing(self, provider_name: str, provider_request_id: str, signer_info: Dict[str, Any]) -> bool:
        provider = self._get_provider(provider_name)
        try:
            return await provider.sign(provider_request_id, signer_info)
        except Exception as e:
            raise SignatureProviderError(f"Failed to start signing with {provider_name}: {str(e)}")

    async def check_provider_status(self, provider_name: str, provider_request_id: str) -> str:
        provider = self._get_provider(provider_name)
        try:
            return await provider.check_status(provider_request_id)
        except Exception as e:
            raise SignatureProviderError(f"Failed to check status with {provider_name}: {str(e)}")
