class AppError(Exception):
    """Base exception for application errors."""
    def __init__(self, message: str, status_code: int = 500):
        self.message = message
        self.status_code = status_code
        super().__init__(message)

class MediaProcessingError(AppError):
    """Raised when media processing fails."""
    def __init__(self, message: str):
        super().__init__(message, status_code=500)

class AIModelError(AppError):
    """Raised when AI model inference fails."""
    def __init__(self, message: str):
        super().__init__(message, status_code=503)

class ConfigurationError(AppError):
    """Raised when configuration is invalid."""
    def __init__(self, message: str):
        super().__init__(message, status_code=500)

class FeatureNotAvailableError(AppError):
    """Raised when a feature is requested but not available/enabled."""
    def __init__(self, message: str):
        super().__init__(message, status_code=501)
