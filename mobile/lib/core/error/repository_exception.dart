/// Repository layer exception types
enum RepositoryExceptionType {
  notFound,
  fetchError,
  createError,
  updateError,
  deleteError,
  network,
  timeout,
  unknown,
}

/// Exception thrown by repository layer
class RepositoryException implements Exception {
  final String message;
  final String? code;
  final RepositoryExceptionType type;
  final dynamic originalError;
  final StackTrace? stackTrace;

  RepositoryException({
    required this.message,
    this.code,
    required this.type,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'RepositoryException: $message (type: $type, code: $code)';
  }

  /// Factory for not found errors
  factory RepositoryException.notFound(String message, {String? code}) {
    return RepositoryException(
      message: message,
      code: code ?? 'NOT_FOUND',
      type: RepositoryExceptionType.notFound,
    );
  }

  /// Factory for fetch errors
  factory RepositoryException.fetchError(String message, {String? code}) {
    return RepositoryException(
      message: message,
      code: code ?? 'FETCH_ERROR',
      type: RepositoryExceptionType.fetchError,
    );
  }

  /// Factory for network errors
  factory RepositoryException.network(String message, {String? code, dynamic originalError}) {
    return RepositoryException(
      message: message,
      code: code ?? 'NETWORK_ERROR',
      type: RepositoryExceptionType.network,
      originalError: originalError,
    );
  }
}
