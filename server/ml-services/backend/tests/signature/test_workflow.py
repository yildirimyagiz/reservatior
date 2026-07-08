import pytest
from app.signature.domain.exceptions import DocumentImmutableError, InvalidStatusTransition
from app.signature.domain.enums import SignatureStatus, SignerRole
from app.signature.application.workflow_service import WorkflowService
from app.signature.schemas import SignatureRequestCreate, SignatureDocumentCreate, SignerCreate
from app.signature.application.signature_service import SignatureService

# Note: In a real test environment, WorkflowService would be initialized with an AsyncSession connected to a test DB.
# This test is a placeholder for the logic structure.
@pytest.mark.asyncio
async def test_workflow_validation(mocker):
    # Mocking the repository methods
    mock_repo = mocker.patch("app.signature.repository.SignatureRepository")
    workflow = WorkflowService(session=None)
    workflow.repo = mock_repo
    
    # Test document immutable error
    class MockRequest:
        id = 1
        status = SignatureStatus.PENDING_SIGNATURE
    
    mock_repo.get_request.return_value = MockRequest()
    
    with pytest.raises(DocumentImmutableError):
        await workflow.add_document(1, SignatureDocumentCreate(
            file_name="test.pdf",
            original_pdf_url="http://test",
            document_hash="hash"
        ), b"test")

    with pytest.raises(DocumentImmutableError):
        await workflow.add_signer(1, SignerCreate(
            name="Test",
            email="test@test.com",
            role=SignerRole.TENANT
        ))
