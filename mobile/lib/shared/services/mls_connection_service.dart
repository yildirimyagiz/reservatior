import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MlsConnectionService {
  final DioClient _dioClient;
  MlsConnectionService(this._dioClient);

  Future<MlsConnection> getMlsConnectionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mlsConnections}/$id');
    return MlsConnection.fromJson(response.data['data']);
  }

  Future<List<MlsConnection>> getMlsConnections({
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
    final response = await _dioClient.get(ApiEndpoints.mlsConnections, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MlsConnection.fromJson(json)).toList();
  }

  Future<MlsConnection> createMlsConnection(MlsConnection item) async {
    final response = await _dioClient.post(ApiEndpoints.mlsConnections, data: item.toJson());
    return MlsConnection.fromJson(response.data['data']);
  }

  Future<MlsConnection> updateMlsConnection(String id, MlsConnection item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mlsConnections}/$id', data: item.toJson());
    return MlsConnection.fromJson(response.data['data']);
  }

  Future<void> deleteMlsConnection(String id) async {
    await _dioClient.delete('${ApiEndpoints.mlsConnections}/$id');
  }
}
