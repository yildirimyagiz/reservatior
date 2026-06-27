import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AgentPerformanceService {
  final DioClient _dioClient;
  AgentPerformanceService(this._dioClient);

  Future<AgentPerformance> getAgentPerformanceById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agentPerformances}/$id');
    return AgentPerformance.fromJson(response.data['data']);
  }

  Future<List<AgentPerformance>> getAgentPerformances({
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
    final response = await _dioClient.get(ApiEndpoints.agentPerformances, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AgentPerformance.fromJson(json)).toList();
  }

  Future<AgentPerformance> createAgentPerformance(AgentPerformance item) async {
    final response = await _dioClient.post(ApiEndpoints.agentPerformances, data: item.toJson());
    return AgentPerformance.fromJson(response.data['data']);
  }

  Future<AgentPerformance> updateAgentPerformance(String id, AgentPerformance item) async {
    final response = await _dioClient.patch('${ApiEndpoints.agentPerformances}/$id', data: item.toJson());
    return AgentPerformance.fromJson(response.data['data']);
  }

  Future<void> deleteAgentPerformance(String id) async {
    await _dioClient.delete('${ApiEndpoints.agentPerformances}/$id');
  }
}
