import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AgentPerformanceService {
  final DioClient _dioClient;

  AgentPerformanceService(this._dioClient);

  // Get AgentPerformance by ID
  Future<AgentPerformance> getAgentPerformanceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/agent_performance/$id');
      return AgentPerformance.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all agent_performances
  Future<List<AgentPerformance>> getAgentPerformances({
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

      final response = await _dioClient.get('/api/v1/agent_performance', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AgentPerformance.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AgentPerformance
  Future<AgentPerformance> createAgentPerformance(AgentPerformance agentPerformance) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/agent_performance',
        data: agentPerformance.toJson(),
      );
      return AgentPerformance.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AgentPerformance
  Future<AgentPerformance> updateAgentPerformance(String id, AgentPerformance agentPerformance) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/agent_performance/$id',
        data: agentPerformance.toJson(),
      );
      return AgentPerformance.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AgentPerformance
  Future<void> deleteAgentPerformance(String id) async {
    try {
      await _dioClient.delete('/api/v1/agent_performance/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
