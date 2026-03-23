import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AgentTeam operations
/// Provides CRUD operations with proper error handling and type safety
class AgentTeamRepository {
  final DioClient _dioClient;

  AgentTeamRepository(this._dioClient);

  /// Get AgentTeam by ID
  /// Returns [AgentTeam] if found, throws [RepositoryException] otherwise
  Future<AgentTeam> getAgentTeamById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/agent_team/$id');
      if (response.statusCode == 200) {
        return AgentTeam.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch agent_team',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all agent_teams with pagination and filtering
  /// Returns list of [AgentTeam] objects
  Future<List<AgentTeam>> getagent_teams({
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
      
      final response = await _dioClient.get('/api/v1/agent_team', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AgentTeam.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch agent_teams',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AgentTeam
  /// Returns created [AgentTeam] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
