import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AgentTeamMemberService {
  final DioClient _dioClient;

  AgentTeamMemberService(this._dioClient);

  // Get AgentTeamMember by ID
  Future<AgentTeamMember> getAgentTeamMemberById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/agent_team_member/$id');
      return AgentTeamMember.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all agent_team_members
  Future<List<AgentTeamMember>> getAgentTeamMembers({
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

      final response = await _dioClient.get('/api/v1/agent_team_member', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AgentTeamMember.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AgentTeamMember
  Future<AgentTeamMember> createAgentTeamMember(AgentTeamMember agentTeamMember) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/agent_team_member',
        data: agentTeamMember.toJson(),
      );
      return AgentTeamMember.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AgentTeamMember
  Future<AgentTeamMember> updateAgentTeamMember(String id, AgentTeamMember agentTeamMember) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/agent_team_member/$id',
        data: agentTeamMember.toJson(),
      );
      return AgentTeamMember.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AgentTeamMember
  Future<void> deleteAgentTeamMember(String id) async {
    try {
      await _dioClient.delete('/api/v1/agent_team_member/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
