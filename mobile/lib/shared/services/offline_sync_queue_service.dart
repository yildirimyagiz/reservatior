import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class OfflineSyncQueueService {
  final DioClient _dioClient;
  OfflineSyncQueueService(this._dioClient);

  Future<OfflineSyncQueue> getOfflineSyncQueueById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.offlineSyncQueues}/$id');
    return OfflineSyncQueue.fromJson(response.data['data']);
  }

  Future<List<OfflineSyncQueue>> getOfflineSyncQueues({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.offlineSyncQueues, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => OfflineSyncQueue.fromJson(json)).toList();
  }

  Future<OfflineSyncQueue> createOfflineSyncQueue(OfflineSyncQueue item) async {
    final response = await _dioClient.post(ApiEndpoints.offlineSyncQueues, data: item.toJson());
    return OfflineSyncQueue.fromJson(response.data['data']);
  }

  Future<OfflineSyncQueue> updateOfflineSyncQueue(String id, OfflineSyncQueue item) async {
    final response = await _dioClient.patch('${ApiEndpoints.offlineSyncQueues}/$id', data: item.toJson());
    return OfflineSyncQueue.fromJson(response.data['data']);
  }

  Future<void> deleteOfflineSyncQueue(String id) async {
    await _dioClient.delete('${ApiEndpoints.offlineSyncQueues}/$id');
  }
}
