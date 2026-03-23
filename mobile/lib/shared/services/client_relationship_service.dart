import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ClientRelationshipService {
  final DioClient _dioClient;

  ClientRelationshipService(this._dioClient);

  // Get ClientRelationship by ID
  Future<ClientRelationship> getClientRelationshipById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/client_relationship/$id');
      return ClientRelationship.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all client_relationships
  Future<List<ClientRelationship>> getClientRelationships({
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

      final response = await _dioClient.get('/api/v1/client_relationship', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ClientRelationship.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ClientRelationship
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
    return Exception('API Error: ${e.message}');
  }
}
