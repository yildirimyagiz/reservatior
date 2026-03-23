import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for OfflineSyncQueue operations
/// Provides CRUD operations with proper error handling and type safety
class OfflineSyncQueueRepository {
  final DioClient _dioClient;

  OfflineSyncQueueRepository(this._dioClient);

  /// Get OfflineSyncQueue by ID
  /// Returns [OfflineSyncQueue] if found, throws [RepositoryException] otherwise
  Future<OfflineSyncQueue> getOfflineSyncQueueById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/offline_sync_queue/$id');
      if (response.statusCode == 200) {
        return OfflineSyncQueue.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch offline_sync_queue',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all offline_sync_queues with pagination and filtering
  /// Returns list of [OfflineSyncQueue] objects
  Future<List<OfflineSyncQueue>> getoffline_sync_queues({
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
      
      final response = await _dioClient.get('/api/v1/offline_sync_queue', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => OfflineSyncQueue.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch offline_sync_queues',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new OfflineSyncQueue
  /// Returns created [OfflineSyncQueue] object
  Future<OfflineSyncQueue> createOfflineSyncQueue(OfflineSyncQueue offlineSyncQueue) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/offline_sync_queue',
        data: offlineSyncQueue.toJson(),
      );
      return OfflineSyncQueue.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update OfflineSyncQueue
  Future<OfflineSyncQueue> updateOfflineSyncQueue(String id, OfflineSyncQueue offlineSyncQueue) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/offline_sync_queue/$id',
        data: offlineSyncQueue.toJson(),
      );
      return OfflineSyncQueue.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete OfflineSyncQueue
  Future<void> deleteOfflineSyncQueue(String id) async {
    try {
      await _dioClient.delete('/api/v1/offline_sync_queue/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
