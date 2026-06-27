import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AgentTeamMemberService {
  final DioClient _dioClient;
  AgentTeamMemberService(this._dioClient);

  Future<AgentTeamMember> getAgentTeamMemberById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agentTeamMembers}/$id');
    return AgentTeamMember.fromJson(response.data['data']);
  }

  Future<List<AgentTeamMember>> getAgentTeamMembers({
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
    final response = await _dioClient.get(ApiEndpoints.agentTeamMembers, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AgentTeamMember.fromJson(json)).toList();
  }

  Future<AgentTeamMember> createAgentTeamMember(AgentTeamMember item) async {
    final response = await _dioClient.post(ApiEndpoints.agentTeamMembers, data: item.toJson());
    return AgentTeamMember.fromJson(response.data['data']);
  }

  Future<AgentTeamMember> updateAgentTeamMember(String id, AgentTeamMember item) async {
    final response = await _dioClient.patch('${ApiEndpoints.agentTeamMembers}/$id', data: item.toJson());
    return AgentTeamMember.fromJson(response.data['data']);
  }

  Future<void> deleteAgentTeamMember(String id) async {
    await _dioClient.delete('${ApiEndpoints.agentTeamMembers}/$id');
  }
}
