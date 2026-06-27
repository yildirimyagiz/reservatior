import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AgentService {
  final DioClient _dioClient;
  AgentService(this._dioClient);

  Future<Agent> getAgentById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agents}/$id');
    return Agent.fromJson(response.data['data']);
  }

  Future<List<Agent>> getAgents({
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
    final response = await _dioClient.get(ApiEndpoints.agents, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Agent.fromJson(json)).toList();
  }

  Future<Agent> createAgent(Agent item) async {
    final response = await _dioClient.post(ApiEndpoints.agents, data: item.toJson());
    return Agent.fromJson(response.data['data']);
  }

  Future<Agent> updateAgent(String id, Agent item) async {
    final response = await _dioClient.patch('${ApiEndpoints.agents}/$id', data: item.toJson());
    return Agent.fromJson(response.data['data']);
  }

  Future<void> deleteAgent(String id) async {
    await _dioClient.delete('${ApiEndpoints.agents}/$id');
  }

  Future<Map<String, dynamic>> getPerformance(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agents}/$id/performance');
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<List<AgentAssignment>> getAssignments(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agents}/$id/assignments');
    final data = response.data['data'] as List;
    return data.map((json) => AgentAssignment.fromJson(json)).toList();
  }
}
