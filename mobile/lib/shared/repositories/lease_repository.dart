import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Lease operations
/// Provides CRUD operations with proper error handling and type safety
class LeaseRepository {
  final DioClient _dioClient;

  LeaseRepository(this._dioClient);

  /// Get Lease by ID
  /// Returns [Lease] if found, throws [RepositoryException] otherwise
  Future<Lease> getLeaseById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/lease/$id');
      if (response.statusCode == 200) {
        return Lease.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch lease',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all leases with pagination and filtering
  /// Returns list of [Lease] objects
  Future<List<Lease>> getleases({
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
      
      final response = await _dioClient.get('/api/v1/lease', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Lease.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch leases',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Lease
  /// Returns created [Lease] object
  Future<Lease> createLease(Lease lease) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/lease',
        data: lease.toJson(),
      );
      return Lease.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Lease
  Future<Lease> updateLease(String id, Lease lease) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/lease/$id',
        data: lease.toJson(),
      );
      return Lease.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Lease
  Future<void> deleteLease(String id) async {
    try {
      await _dioClient.delete('/api/v1/lease/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
