import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for LoyaltyAccount operations
/// Provides CRUD operations with proper error handling and type safety
class LoyaltyAccountRepository {
  final DioClient _dioClient;

  LoyaltyAccountRepository(this._dioClient);

  /// Get LoyaltyAccount by ID
  /// Returns [LoyaltyAccount] if found, throws [RepositoryException] otherwise
  Future<LoyaltyAccount> getLoyaltyAccountById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/loyalty_account/$id');
      if (response.statusCode == 200) {
        return LoyaltyAccount.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch loyalty_account',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all loyalty_accounts with pagination and filtering
  /// Returns list of [LoyaltyAccount] objects
  Future<List<LoyaltyAccount>> getloyalty_accounts({
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
      
      final response = await _dioClient.get('/api/v1/loyalty_account', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => LoyaltyAccount.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch loyalty_accounts',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new LoyaltyAccount
  /// Returns created [LoyaltyAccount] object
  Future<LoyaltyAccount> createLoyaltyAccount(LoyaltyAccount loyaltyAccount) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/loyalty_account',
        data: loyaltyAccount.toJson(),
      );
      return LoyaltyAccount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update LoyaltyAccount
  Future<LoyaltyAccount> updateLoyaltyAccount(String id, LoyaltyAccount loyaltyAccount) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/loyalty_account/$id',
        data: loyaltyAccount.toJson(),
      );
      return LoyaltyAccount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete LoyaltyAccount
  Future<void> deleteLoyaltyAccount(String id) async {
    try {
      await _dioClient.delete('/api/v1/loyalty_account/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
