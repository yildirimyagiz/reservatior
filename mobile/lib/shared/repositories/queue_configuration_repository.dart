import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for QueueConfiguration operations
/// Provides CRUD operations with proper error handling and type safety
class QueueConfigurationRepository {
  final DioClient _dioClient;

  QueueConfigurationRepository(this._dioClient);

  /// Get QueueConfiguration by ID
  /// Returns [QueueConfiguration] if found, throws [RepositoryException] otherwise
  Future<QueueConfiguration> getQueueConfigurationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/queue_configuration/$id');
      if (response.statusCode == 200) {
        return QueueConfiguration.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch queue_configuration',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all queue_configurations with pagination and filtering
  /// Returns list of [QueueConfiguration] objects
  Future<List<QueueConfiguration>> getqueue_configurations({
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
      
      final response = await _dioClient.get('/api/v1/queue_configuration', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => QueueConfiguration.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch queue_configurations',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new QueueConfiguration
  /// Returns created [QueueConfiguration] object
  Future<QueueConfiguration> createQueueConfiguration(QueueConfiguration queueConfiguration) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/queue_configuration',
        data: queueConfiguration.toJson(),
      );
      return QueueConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update QueueConfiguration
  Future<QueueConfiguration> updateQueueConfiguration(String id, QueueConfiguration queueConfiguration) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/queue_configuration/$id',
        data: queueConfiguration.toJson(),
      );
      return QueueConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete QueueConfiguration
  Future<void> deleteQueueConfiguration(String id) async {
    try {
      await _dioClient.delete('/api/v1/queue_configuration/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
