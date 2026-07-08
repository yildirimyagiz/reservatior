class SignatureEngineException(Exception):
    """Base exception for Signature Engine module."""
    pass

class InvalidStatusTransition(SignatureEngineException):
    """Raised when an invalid status transition is attempted."""
    pass

class SignatureProviderError(SignatureEngineException):
    """Raised when the external signature provider fails."""
    pass

class DocumentImmutableError(SignatureEngineException):
    """Raised when an attempt is made to modify a document after signing has started."""
    pass

class RequestExpiredError(SignatureEngineException):
    """Raised when trying to sign an expired request."""
    pass
