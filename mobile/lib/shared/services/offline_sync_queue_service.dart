import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class OfflineSyncQueueService {
  final DioClient _dioClient;

  OfflineSyncQueueService(this._dioClient);

  // Get OfflineSyncQueue by ID
  Future<OfflineSyncQueue> getOfflineSyncQueueById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/offline_sync_queue/$id');
      return OfflineSyncQueue.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all offline_sync_queues
  Future<List<OfflineSyncQueue>> getOfflineSyncQueues({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/offline_sync_queue', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => OfflineSyncQueue.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create OfflineSyncQueue
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
    return Exception('API Error: ${e.message}');
  }
}
