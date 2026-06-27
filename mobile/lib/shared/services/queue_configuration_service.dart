import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class QueueConfigurationService {
  final DioClient _dioClient;
  QueueConfigurationService(this._dioClient);

  Future<QueueConfiguration> getQueueConfigurationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.queueConfigurations}/$id');
    return QueueConfiguration.fromJson(response.data['data']);
  }

  Future<List<QueueConfiguration>> getQueueConfigurations({
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
    final response = await _dioClient.get(ApiEndpoints.queueConfigurations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => QueueConfiguration.fromJson(json)).toList();
  }

  Future<QueueConfiguration> createQueueConfiguration(QueueConfiguration item) async {
    final response = await _dioClient.post(ApiEndpoints.queueConfigurations, data: item.toJson());
    return QueueConfiguration.fromJson(response.data['data']);
  }

  Future<QueueConfiguration> updateQueueConfiguration(String id, QueueConfiguration item) async {
    final response = await _dioClient.patch('${ApiEndpoints.queueConfigurations}/$id', data: item.toJson());
    return QueueConfiguration.fromJson(response.data['data']);
  }

  Future<void> deleteQueueConfiguration(String id) async {
    await _dioClient.delete('${ApiEndpoints.queueConfigurations}/$id');
  }
}
