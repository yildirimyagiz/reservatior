import pytest
from app.signature.application.signature_service import SignatureService
from app.signature.infrastructure.providers.ark_provider import ArkImzaProvider
from app.signature.infrastructure.providers.remote_provider import RemoteSigningProvider

@pytest.mark.asyncio
async def test_ark_imza_provider():
    provider = ArkImzaProvider()
    request_id = await provider.create_request({"title": "Test Doc"})
    assert request_id.startswith("ark_")
    
    doc_id = await provider.send_document(request_id, b"doc content", {})
    assert doc_id.startswith("doc_")
    
    assert await provider.sign(request_id, {"email": "test@test.com"}) is True
    assert await provider.check_status(request_id) == "SIGNED"

@pytest.mark.asyncio
async def test_signature_service_hashing():
    service = SignatureService()
    hash_val = service.calculate_hash(b"test document")
    assert hash_val == "a3b092289c09c316eb251e7bb521b2046835aebc6cf5e386da6cb1701e40ebfb"
