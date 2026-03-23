import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AgentAssignmentService {
  final DioClient _dioClient;

  AgentAssignmentService(this._dioClient);

  // Get AgentAssignment by ID
  Future<AgentAssignment> getAgentAssignmentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/agent_assignment/$id');
      return AgentAssignment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all agent_assignments
  Future<List<AgentAssignment>> getAgentAssignments({
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

      final response = await _dioClient.get('/api/v1/agent_assignment', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AgentAssignment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AgentAssignment
  Future<AgentAssignment> createAgentAssignment(AgentAssignment agentAssignment) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/agent_assignment',
        data: agentAssignment.toJson(),
      );
      return AgentAssignment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AgentAssignment
  Future<AgentAssignment> updateAgentAssignment(String id, AgentAssignment agentAssignment) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/agent_assignment/$id',
        data: agentAssignment.toJson(),
      );
      return AgentAssignment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AgentAssignment
  Future<void> deleteAgentAssignment(String id) async {
    try {
      await _dioClient.delete('/api/v1/agent_assignment/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
