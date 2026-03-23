import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Commission operations
/// Provides CRUD operations with proper error handling and type safety
class CommissionRepository {
  final DioClient _dioClient;

  CommissionRepository(this._dioClient);

  /// Get Commission by ID
  /// Returns [Commission] if found, throws [RepositoryException] otherwise
  Future<Commission> getCommissionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/commission/$id');
      if (response.statusCode == 200) {
        return Commission.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch commission',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all commissions with pagination and filtering
  /// Returns list of [Commission] objects
  Future<List<Commission>> getcommissions({
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
      
      final response = await _dioClient.get('/api/v1/commission', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Commission.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch commissions',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Commission
  /// Returns created [Commission] object
  Future<Commission> createCommission(Commission commission) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/commission',
        data: commission.toJson(),
      );
      return Commission.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Commission
  Future<Commission> updateCommission(String id, Commission commission) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/commission/$id',
        data: commission.toJson(),
      );
      return Commission.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Commission
  Future<void> deleteCommission(String id) async {
    try {
      await _dioClient.delete('/api/v1/commission/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
