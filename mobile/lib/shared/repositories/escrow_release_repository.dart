import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for EscrowRelease operations
/// Provides CRUD operations with proper error handling and type safety
class EscrowReleaseRepository {
  final DioClient _dioClient;

  EscrowReleaseRepository(this._dioClient);

  /// Get EscrowRelease by ID
  /// Returns [EscrowRelease] if found, throws [RepositoryException] otherwise
  Future<EscrowRelease> getEscrowReleaseById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/escrow_release/$id');
      if (response.statusCode == 200) {
        return EscrowRelease.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch escrow_release',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all escrow_releases with pagination and filtering
  /// Returns list of [EscrowRelease] objects
  Future<List<EscrowRelease>> getescrow_releases({
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
      
      final response = await _dioClient.get('/api/v1/escrow_release', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => EscrowRelease.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch escrow_releases',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new EscrowRelease
  /// Returns created [EscrowRelease] object
  Future<EscrowRelease> createEscrowRelease(EscrowRelease escrowRelease) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/escrow_release',
        data: escrowRelease.toJson(),
      );
      return EscrowRelease.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update EscrowRelease
  Future<EscrowRelease> updateEscrowRelease(String id, EscrowRelease escrowRelease) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/escrow_release/$id',
        data: escrowRelease.toJson(),
      );
      return EscrowRelease.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete EscrowRelease
  Future<void> deleteEscrowRelease(String id) async {
    try {
      await _dioClient.delete('/api/v1/escrow_release/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
