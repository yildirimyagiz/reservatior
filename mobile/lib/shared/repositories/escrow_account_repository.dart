import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for EscrowAccount operations
/// Provides CRUD operations with proper error handling and type safety
class EscrowAccountRepository {
  final DioClient _dioClient;

  EscrowAccountRepository(this._dioClient);

  /// Get EscrowAccount by ID
  /// Returns [EscrowAccount] if found, throws [RepositoryException] otherwise
  Future<EscrowAccount> getEscrowAccountById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/escrow_account/$id');
      if (response.statusCode == 200) {
        return EscrowAccount.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch escrow_account',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all escrow_accounts with pagination and filtering
  /// Returns list of [EscrowAccount] objects
  Future<List<EscrowAccount>> getescrow_accounts({
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
      
      final response = await _dioClient.get('/api/v1/escrow_account', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => EscrowAccount.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch escrow_accounts',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new EscrowAccount
  /// Returns created [EscrowAccount] object
  Future<EscrowAccount> createEscrowAccount(EscrowAccount escrowAccount) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/escrow_account',
        data: escrowAccount.toJson(),
      );
      return EscrowAccount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update EscrowAccount
  Future<EscrowAccount> updateEscrowAccount(String id, EscrowAccount escrowAccount) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/escrow_account/$id',
        data: escrowAccount.toJson(),
      );
      return EscrowAccount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete EscrowAccount
  Future<void> deleteEscrowAccount(String id) async {
    try {
      await _dioClient.delete('/api/v1/escrow_account/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
