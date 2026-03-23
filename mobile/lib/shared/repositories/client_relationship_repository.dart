import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ClientRelationship operations
/// Provides CRUD operations with proper error handling and type safety
class ClientRelationshipRepository {
  final DioClient _dioClient;

  ClientRelationshipRepository(this._dioClient);

  /// Get ClientRelationship by ID
  /// Returns [ClientRelationship] if found, throws [RepositoryException] otherwise
  Future<ClientRelationship> getClientRelationshipById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/client_relationship/$id');
      if (response.statusCode == 200) {
        return ClientRelationship.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch client_relationship',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all client_relationships with pagination and filtering
  /// Returns list of [ClientRelationship] objects
  Future<List<ClientRelationship>> getclient_relationships({
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
      
      final response = await _dioClient.get('/api/v1/client_relationship', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ClientRelationship.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch client_relationships',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ClientRelationship
  /// Returns created [ClientRelationship] object
  Future<ClientRelationship> createClientRelationship(ClientRelationship clientRelationship) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/client_relationship',
        data: clientRelationship.toJson(),
      );
      return ClientRelationship.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ClientRelationship
  Future<ClientRelationship> updateClientRelationship(String id, ClientRelationship clientRelationship) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/client_relationship/$id',
        data: clientRelationship.toJson(),
      );
      return ClientRelationship.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ClientRelationship
  Future<void> deleteClientRelationship(String id) async {
    try {
      await _dioClient.delete('/api/v1/client_relationship/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
