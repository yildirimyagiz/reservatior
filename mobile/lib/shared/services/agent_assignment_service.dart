import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AgentAssignmentService {
  final DioClient _dioClient;
  AgentAssignmentService(this._dioClient);

  Future<AgentAssignment> getAgentAssignmentById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agentAssignments}/$id');
    return AgentAssignment.fromJson(response.data['data']);
  }

  Future<List<AgentAssignment>> getAgentAssignments({
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
    final response = await _dioClient.get(ApiEndpoints.agentAssignments, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AgentAssignment.fromJson(json)).toList();
  }

  Future<AgentAssignment> createAgentAssignment(AgentAssignment item) async {
    final response = await _dioClient.post(ApiEndpoints.agentAssignments, data: item.toJson());
    return AgentAssignment.fromJson(response.data['data']);
  }

  Future<AgentAssignment> updateAgentAssignment(String id, AgentAssignment item) async {
    final response = await _dioClient.patch('${ApiEndpoints.agentAssignments}/$id', data: item.toJson());
    return AgentAssignment.fromJson(response.data['data']);
  }

  Future<void> deleteAgentAssignment(String id) async {
    await _dioClient.delete('${ApiEndpoints.agentAssignments}/$id');
  }
}
