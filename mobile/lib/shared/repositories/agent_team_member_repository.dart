import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AgentTeamMember operations
/// Provides CRUD operations with proper error handling and type safety
class AgentTeamMemberRepository {
  final DioClient _dioClient;

  AgentTeamMemberRepository(this._dioClient);

  /// Get AgentTeamMember by ID
  /// Returns [AgentTeamMember] if found, throws [RepositoryException] otherwise
  Future<AgentTeamMember> getAgentTeamMemberById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/agent_team_member/$id');
      if (response.statusCode == 200) {
        return AgentTeamMember.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch agent_team_member',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all agent_team_members with pagination and filtering
  /// Returns list of [AgentTeamMember] objects
  Future<List<AgentTeamMember>> getagent_team_members({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/agent_team_member', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AgentTeamMember.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch agent_team_members',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AgentTeamMember
  /// Returns created [AgentTeamMember] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
