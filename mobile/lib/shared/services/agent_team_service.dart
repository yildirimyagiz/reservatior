import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AgentTeamService {
  final DioClient _dioClient;

  AgentTeamService(this._dioClient);

  // Get AgentTeam by ID
  Future<AgentTeam> getAgentTeamById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/agent_team/$id');
      return AgentTeam.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all agent_teams
  Future<List<AgentTeam>> getAgentTeams({
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

      final response = await _dioClient.get('/api/v1/agent_team', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AgentTeam.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AgentTeam
  Future<AgentTeam> createAgentTeam(AgentTeam agentTeam) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/agent_team',
        data: agentTeam.toJson(),
      );
      return AgentTeam.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AgentTeam
  Future<AgentTeam> updateAgentTeam(String id, AgentTeam agentTeam) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/agent_team/$id',
        data: agentTeam.toJson(),
      );
      return AgentTeam.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AgentTeam
  Future<void> deleteAgentTeam(String id) async {
    try {
      await _dioClient.delete('/api/v1/agent_team/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
