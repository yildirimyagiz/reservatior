import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for SystemMetrics operations
/// Provides CRUD operations with proper error handling and type safety
class SystemMetricsRepository {
  final DioClient _dioClient;

  SystemMetricsRepository(this._dioClient);

  /// Get SystemMetrics by ID
  /// Returns [SystemMetrics] if found, throws [RepositoryException] otherwise
  Future<SystemMetrics> getSystemMetricsById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/system_metrics/$id');
      if (response.statusCode == 200) {
        return SystemMetrics.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch system_metrics',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all system_metricses with pagination and filtering
  /// Returns list of [SystemMetrics] objects
  Future<List<SystemMetrics>> getsystem_metricses({
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
      
      final response = await _dioClient.get('/api/v1/system_metrics', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => SystemMetrics.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch system_metricses',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new SystemMetrics
  /// Returns created [SystemMetrics] object
  Future<SystemMetrics> createSystemMetrics(SystemMetrics systemMetrics) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/system_metrics',
        data: systemMetrics.toJson(),
      );
      return SystemMetrics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update SystemMetrics
  Future<SystemMetrics> updateSystemMetrics(String id, SystemMetrics systemMetrics) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/system_metrics/$id',
        data: systemMetrics.toJson(),
      );
      return SystemMetrics.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete SystemMetrics
  Future<void> deleteSystemMetrics(String id) async {
    try {
      await _dioClient.delete('/api/v1/system_metrics/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
