import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ReferenceSourceService {
  final DioClient _dioClient;
  ReferenceSourceService(this._dioClient);

  Future<ReferenceSource> getReferenceSourceById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.referenceSources}/$id');
    return ReferenceSource.fromJson(response.data['data']);
  }

  Future<List<ReferenceSource>> getReferenceSources({
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
    final response = await _dioClient.get(ApiEndpoints.referenceSources, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ReferenceSource.fromJson(json)).toList();
  }

  Future<ReferenceSource> createReferenceSource(ReferenceSource item) async {
    final response = await _dioClient.post(ApiEndpoints.referenceSources, data: item.toJson());
    return ReferenceSource.fromJson(response.data['data']);
  }

  Future<ReferenceSource> updateReferenceSource(String id, ReferenceSource item) async {
    final response = await _dioClient.patch('${ApiEndpoints.referenceSources}/$id', data: item.toJson());
    return ReferenceSource.fromJson(response.data['data']);
  }

  Future<void> deleteReferenceSource(String id) async {
    await _dioClient.delete('${ApiEndpoints.referenceSources}/$id');
  }
}
