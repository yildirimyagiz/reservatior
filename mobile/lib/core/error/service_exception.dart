/// Service layer exception types
enum ServiceExceptionType {
  validation,
  notFound,
  unauthorized,
  forbidden,
  conflict,
  fetchError,
  createError,
  updateError,
  deleteError,
  network,
  timeout,
  unknown,
}

/// Exception thrown by service layer
class ServiceException implements Exception {
  final String message;
  final String? code;
  final ServiceExceptionType type;
  final dynamic originalError;
  final StackTrace? stackTrace;

  ServiceException({
    required this.message,
    this.code,
    required this.type,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'ServiceException: $message (Type: $type, Code: $code)';
  }

  /// Factory for validation errors
  factory ServiceException.validation(String message, {String? code}) {
    return ServiceException(
      message: message,
      code: code ?? 'VALIDATION_ERROR',
      type: ServiceExceptionType.validation,
    );
  }

  /// Factory for not found errors
  factory ServiceException.notFound(String message, {String? code}) {
    return ServiceException(
      message: message,
      code: code ?? 'NOT_FOUND',
      type: ServiceExceptionType.notFound,
    );
  }

  /// Factory for unauthorized errors
  factory ServiceException.unauthorized(String message, {String? code}) {
    return ServiceException(
      message: message,
      code: code ?? 'UNAUTHORIZED',
      type: ServiceExceptionType.unauthorized,
    );
  }

  /// Factory for network errors
  factory ServiceException.network(String message, {String? code, dynamic originalError}) {
    return ServiceException(
      message: message,
      code: code ?? 'NETWORK_ERROR',
      type: ServiceExceptionType.network,
      originalError: originalError,
    );
  }
}
