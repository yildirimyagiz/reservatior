import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Agent operations
/// Provides CRUD operations with proper error handling and type safety
class AgentRepository {
  final DioClient _dioClient;

  AgentRepository(this._dioClient);

  /// Get Agent by ID
  /// Returns [Agent] if found, throws [RepositoryException] otherwise
  Future<Agent> getAgentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/agent/$id');
      if (response.statusCode == 200) {
        return Agent.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch agent',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all agents with pagination and filtering
  /// Returns list of [Agent] objects
  Future<List<Agent>> getagents({
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
      
      final response = await _dioClient.get('/api/v1/agent', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Agent.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch agents',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Agent
  /// Returns created [Agent] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
