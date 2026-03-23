import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Account operations
/// Provides CRUD operations with proper error handling and type safety
class AccountRepository {
  final DioClient _dioClient;

  AccountRepository(this._dioClient);

  /// Get Account by ID
  /// Returns [Account] if found, throws [RepositoryException] otherwise
  Future<Account> getAccountById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/accounts/$id');
      if (response.statusCode == 200) {
        return Account.fromJson(response.data['data']);
      } else {
        throw RepositoryException.notFound(
          'Account not found',
          code: response.statusCode.toString(),
        );
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
        throw RepositoryException.fetchError(
          'Failed to fetch accounts',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Account
  /// Returns created [Account] object
  Future<Account> createAccount(Account account) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/accounts',
        data: account.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return Account.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to create account',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.createError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Update Account
  Future<Account> updateAccount(String id, Account account) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/accounts/$id',
        data: account.toJson(),
      );
      if (response.statusCode == 200) {
        return Account.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to update account',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.updateError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Partial update Account
  Future<Account> patchAccount(String id, Map<String, dynamic> updates) async {
    try {
      final response = await _dioClient.patch(
        '/api/v1/accounts/$id',
        data: updates,
      );
      if (response.statusCode == 200) {
        return Account.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to update account',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.updateError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Delete Account
  Future<void> deleteAccount(String id) async {
    try {
      final response = await _dioClient.delete('/api/v1/accounts/$id');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw RepositoryException(
          message: 'Failed to delete account',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.deleteError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Search accounts
  Future<List<Account>> searchAccounts({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
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
        throw RepositoryException.fetchError(
          'Search failed',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get accounts by user ID
  Future<List<Account>> getAccountsByUserId(String userId) async {
    try {
      final response = await _dioClient.get('/api/v1/accounts/user/$userId');
      
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Account.fromJson(item)).toList();
      } else {
        throw RepositoryException.fetchError(
          'Failed to fetch user accounts',
          code: response.statusCode.toString(),
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
        throw RepositoryException.fetchError(
          'Failed to fetch stats',
          code: response.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Handle DioException and convert to RepositoryException
  RepositoryException _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return RepositoryException.network(
          'Connection timeout',
          code: 'TIMEOUT',
          originalError: e,
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return RepositoryException.notFound('Resource not found');
        }
        return RepositoryException(
          message: e.response?.data['message'] ?? 'Server error',
          code: statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
          originalError: e,
        );
      default:
        return RepositoryException.network(
          'Network error: ${e.message}',
          originalError: e,
        );
    }
  }
}
