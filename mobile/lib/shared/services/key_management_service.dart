import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class KeyManagementService {
  final DioClient _dioClient;
  KeyManagementService(this._dioClient);

  Future<KeyManagement> getKeyManagementById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.keyManagements}/$id');
    return KeyManagement.fromJson(response.data['data']);
  }

  Future<List<KeyManagement>> getKeyManagements({
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
    final response = await _dioClient.get(ApiEndpoints.keyManagements, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => KeyManagement.fromJson(json)).toList();
  }

  Future<KeyManagement> createKeyManagement(KeyManagement item) async {
    final response = await _dioClient.post(ApiEndpoints.keyManagements, data: item.toJson());
    return KeyManagement.fromJson(response.data['data']);
  }

  Future<KeyManagement> updateKeyManagement(String id, KeyManagement item) async {
    final response = await _dioClient.patch('${ApiEndpoints.keyManagements}/$id', data: item.toJson());
    return KeyManagement.fromJson(response.data['data']);
  }

  Future<void> deleteKeyManagement(String id) async {
    await _dioClient.delete('${ApiEndpoints.keyManagements}/$id');
  }
}
