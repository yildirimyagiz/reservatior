import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ReferenceSource operations
/// Provides CRUD operations with proper error handling and type safety
class ReferenceSourceRepository {
  final DioClient _dioClient;

  ReferenceSourceRepository(this._dioClient);

  /// Get ReferenceSource by ID
  /// Returns [ReferenceSource] if found, throws [RepositoryException] otherwise
  Future<ReferenceSource> getReferenceSourceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/reference_source/$id');
      if (response.statusCode == 200) {
        return ReferenceSource.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch reference_source',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all reference_sources with pagination and filtering
  /// Returns list of [ReferenceSource] objects
  Future<List<ReferenceSource>> getreference_sources({
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
      
      final response = await _dioClient.get('/api/v1/reference_source', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ReferenceSource.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch reference_sources',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ReferenceSource
  /// Returns created [ReferenceSource] object
  Future<ReferenceSource> createReferenceSource(ReferenceSource referenceSource) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/reference_source',
        data: referenceSource.toJson(),
      );
      return ReferenceSource.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ReferenceSource
  Future<ReferenceSource> updateReferenceSource(String id, ReferenceSource referenceSource) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/reference_source/$id',
        data: referenceSource.toJson(),
      );
      return ReferenceSource.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ReferenceSource
  Future<void> deleteReferenceSource(String id) async {
    try {
      await _dioClient.delete('/api/v1/reference_source/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
