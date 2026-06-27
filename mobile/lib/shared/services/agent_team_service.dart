import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AgentTeamService {
  final DioClient _dioClient;
  AgentTeamService(this._dioClient);

  Future<AgentTeam> getAgentTeamById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agentTeams}/$id');
    return AgentTeam.fromJson(response.data['data']);
  }

  Future<List<AgentTeam>> getAgentTeams({
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
    final response = await _dioClient.get(ApiEndpoints.agentTeams, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AgentTeam.fromJson(json)).toList();
  }

  Future<AgentTeam> createAgentTeam(AgentTeam item) async {
    final response = await _dioClient.post(ApiEndpoints.agentTeams, data: item.toJson());
    return AgentTeam.fromJson(response.data['data']);
  }

  Future<AgentTeam> updateAgentTeam(String id, AgentTeam item) async {
    final response = await _dioClient.patch('${ApiEndpoints.agentTeams}/$id', data: item.toJson());
    return AgentTeam.fromJson(response.data['data']);
  }

  Future<void> deleteAgentTeam(String id) async {
    await _dioClient.delete('${ApiEndpoints.agentTeams}/$id');
  }

  Future<List<Map<String, dynamic>>> getMembers(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agentTeams}/$id/members');
    final data = response.data['data'] as List;
    return data.cast<Map<String, dynamic>>();
  }
}
