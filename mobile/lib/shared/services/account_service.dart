import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/service_exception.dart';

/// Service for Account operations
/// Provides CRUD operations with proper error handling and validation
class AccountService {
  final DioClient _dioClient;

  AccountService(this._dioClient);

  /// Get Account by ID
  /// Returns [Account] if found, throws [ServiceException] otherwise
  Future<Account> getAccountById(String id) async {
    if (id.isEmpty) {
      throw ServiceException.validation('Account ID cannot be empty', code: 'INVALID_ID');
    }

    try {
      final response = await _dioClient.get('/api/v1/accounts/$id');
      if (response.statusCode == 200) {
        return Account.fromJson(response.data['data']);
      } else {
        throw ServiceException.notFound('Account not found', code: response.statusCode.toString());
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all accounts with pagination and filtering
  /// Returns list of [Account] objects
  Future<List<Account>> getAccounts({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    if (page <= 0) {
      throw ServiceException.validation('Page must be greater than 0', code: 'INVALID_PAGE');
    }

    if (limit <= 0 || limit > 100) {
      throw ServiceException.validation('Limit must be between 1 and 100', code: 'INVALID_LIMIT');
    }

    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };

      final response = await _dioClient.get('/api/v1/accounts', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Account.fromJson(item)).toList();
      } else {
        throw ServiceException(
          message: 'Failed to fetch accounts',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new account
  /// Returns created [Account] object
  Future<Account> createAccount(Account account) async {
    // Validate account data
    _validateAccount(account);

    try {
      final response = await _dioClient.post(
        '/api/v1/accounts',
        data: account.toJson(),
      );
      return Account.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update Account
  Future<Account> updateAccount(String id, Account account) async {
    if (id.isEmpty) {
      throw ServiceException.validation('Account ID cannot be empty');
    }

    _validateAccount(account);

    try {
      final response = await _dioClient.put(
        '/api/v1/accounts/$id',
        data: account.toJson(),
      );
      return Account.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Delete Account
  Future<void> deleteAccount(String id) async {
    if (id.isEmpty) {
      throw ServiceException.validation('Account ID cannot be empty');
    }

    try {
      await _dioClient.delete('/api/v1/accounts/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Search accounts by query
  Future<List<Account>> searchAccounts({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    if (query.isEmpty) {
      throw ServiceException.validation('Search query cannot be empty');
    }

    try {
      final response = await _dioClient.get(
        '/api/v1/accounts/search',
        queryParameters: {
          'q': query,
          'page': page,
          'limit': limit,
        },
      );
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Account.fromJson(item)).toList();
      } else {
        throw ServiceException(
          message: 'Search failed',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get account statistics
  Future<Map<String, dynamic>> getAccountStats() async {
    try {
      final response = await _dioClient.get('/api/v1/accounts/stats');
      
      if (response.statusCode == 200) {
        return response.data['data'] as Map<String, dynamic>;
      } else {
        throw ServiceException(
          message: 'Failed to fetch stats',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get accounts by user ID
  Future<List<Account>> getAccountsByUserId(String userId) async {
    if (userId.isEmpty) {
      throw ServiceException.validation('User ID cannot be empty');
    }

    try {
      final response = await _dioClient.get(
        '/api/v1/accounts/user/$userId',
      );
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Account.fromJson(item)).toList();
      } else {
        throw ServiceException(
          message: 'Failed to fetch user accounts',
          code: response.statusCode.toString(),
          type: ServiceExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Activate account
  Future<Account> activateAccount(String id) async {
    if (id.isEmpty) {
      throw ServiceException.validation('Account ID cannot be empty');
    }

    try {
      final response = await _dioClient.patch('/api/v1/accounts/$id/activate');
      return Account.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Deactivate account
  Future<Account> deactivateAccount(String id) async {
    if (id.isEmpty) {
      throw ServiceException.validation('Account ID cannot be empty');
    }

    try {
      final response = await _dioClient.patch('/api/v1/accounts/$id/deactivate');
      return Account.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Refresh account token
  Future<Account> refreshToken(String id) async {
    if (id.isEmpty) {
      throw ServiceException.validation('Account ID cannot be empty');
    }

    try {
      final response = await _dioClient.post('/api/v1/accounts/$id/refresh-token');
      return Account.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Validate account data
  void _validateAccount(Account account) {
    if (account.userId == null || account.userId!.isEmpty) {
      throw ServiceException.validation('User ID is required');
    }

    if (account.type == null) {
      throw ServiceException.validation('Account type is required');
    }

    if (account.providerId == null || account.providerId!.isEmpty) {
      throw ServiceException.validation('Provider ID is required');
    }
  }

  /// Handle DioException and convert to ServiceException
  ServiceException _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServiceException.network(
          'Connection timeout',
          code: 'TIMEOUT',
          originalError: e,
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return ServiceException.notFound('Resource not found');
        } else if (statusCode == 401) {
          return ServiceException.unauthorized('Unauthorized');
        }
        return ServiceException(
          message: e.response?.data['message'] ?? 'Server error',
          code: statusCode.toString(),
          type: ServiceExceptionType.fetchError,
          originalError: e,
        );
      case DioExceptionType.cancel:
        return ServiceException(
          message: 'Request cancelled',
          code: 'CANCELLED',
          type: ServiceExceptionType.unknown,
          originalError: e,
        );
      default:
        return ServiceException.network(
          'Network error: ${e.message}',
          originalError: e,
        );
    }
  }
}
