import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for EscrowDispute operations
/// Provides CRUD operations with proper error handling and type safety
class EscrowDisputeRepository {
  final DioClient _dioClient;

  EscrowDisputeRepository(this._dioClient);

  /// Get EscrowDispute by ID
  /// Returns [EscrowDispute] if found, throws [RepositoryException] otherwise
  Future<EscrowDispute> getEscrowDisputeById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/escrow_dispute/$id');
      if (response.statusCode == 200) {
        return EscrowDispute.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch escrow_dispute',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all escrow_disputes with pagination and filtering
  /// Returns list of [EscrowDispute] objects
  Future<List<EscrowDispute>> getescrow_disputes({
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
      
      final response = await _dioClient.get('/api/v1/escrow_dispute', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => EscrowDispute.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch escrow_disputes',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new EscrowDispute
  /// Returns created [EscrowDispute] object
  Future<EscrowDispute> createEscrowDispute(EscrowDispute escrowDispute) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/escrow_dispute',
        data: escrowDispute.toJson(),
      );
      return EscrowDispute.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update EscrowDispute
  Future<EscrowDispute> updateEscrowDispute(String id, EscrowDispute escrowDispute) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/escrow_dispute/$id',
        data: escrowDispute.toJson(),
      );
      return EscrowDispute.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete EscrowDispute
  Future<void> deleteEscrowDispute(String id) async {
    try {
      await _dioClient.delete('/api/v1/escrow_dispute/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
