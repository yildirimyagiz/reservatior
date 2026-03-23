import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AgentService {
  final DioClient _dioClient;

  AgentService(this._dioClient);

  // Get Agent by ID
  Future<Agent> getAgentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/agent/$id');
      return Agent.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all agents
  Future<List<Agent>> getAgents({
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

      final response = await _dioClient.get('/api/v1/agent', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Agent.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Agent
  Future<Agent> createAgent(Agent agent) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/agent',
        data: agent.toJson(),
      );
      return Agent.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Agent
  Future<Agent> updateAgent(String id, Agent agent) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/agent/$id',
        data: agent.toJson(),
      );
      return Agent.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Agent
  Future<void> deleteAgent(String id) async {
    try {
      await _dioClient.delete('/api/v1/agent/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
