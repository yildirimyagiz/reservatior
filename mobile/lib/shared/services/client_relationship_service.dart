import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ClientRelationshipService {
  final DioClient _dioClient;
  ClientRelationshipService(this._dioClient);

  Future<ClientRelationship> getClientRelationshipById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.clientRelationships}/$id');
    return ClientRelationship.fromJson(response.data['data']);
  }

  Future<List<ClientRelationship>> getClientRelationships({
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
    final response = await _dioClient.get(ApiEndpoints.clientRelationships, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ClientRelationship.fromJson(json)).toList();
  }

  Future<ClientRelationship> createClientRelationship(ClientRelationship item) async {
    final response = await _dioClient.post(ApiEndpoints.clientRelationships, data: item.toJson());
    return ClientRelationship.fromJson(response.data['data']);
  }

  Future<ClientRelationship> updateClientRelationship(String id, ClientRelationship item) async {
    final response = await _dioClient.patch('${ApiEndpoints.clientRelationships}/$id', data: item.toJson());
    return ClientRelationship.fromJson(response.data['data']);
  }

  Future<void> deleteClientRelationship(String id) async {
    await _dioClient.delete('${ApiEndpoints.clientRelationships}/$id');
  }
}
