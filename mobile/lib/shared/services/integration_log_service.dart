import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class IntegrationLogService {
  final DioClient _dioClient;
  IntegrationLogService(this._dioClient);

  Future<IntegrationLog> getIntegrationLogById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.integrationLogs}/$id');
    return IntegrationLog.fromJson(response.data['data']);
  }

  Future<List<IntegrationLog>> getIntegrationLogs({
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
    final response = await _dioClient.get(ApiEndpoints.integrationLogs, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => IntegrationLog.fromJson(json)).toList();
  }

  Future<IntegrationLog> createIntegrationLog(IntegrationLog item) async {
    final response = await _dioClient.post(ApiEndpoints.integrationLogs, data: item.toJson());
    return IntegrationLog.fromJson(response.data['data']);
  }

  Future<IntegrationLog> updateIntegrationLog(String id, IntegrationLog item) async {
    final response = await _dioClient.patch('${ApiEndpoints.integrationLogs}/$id', data: item.toJson());
    return IntegrationLog.fromJson(response.data['data']);
  }

  Future<void> deleteIntegrationLog(String id) async {
    await _dioClient.delete('${ApiEndpoints.integrationLogs}/$id');
  }
}
