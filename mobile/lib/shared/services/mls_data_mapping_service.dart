import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MlsDataMappingService {
  final DioClient _dioClient;
  MlsDataMappingService(this._dioClient);

  Future<MlsDataMapping> getMlsDataMappingById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mlsDataMappings}/$id');
    return MlsDataMapping.fromJson(response.data['data']);
  }

  Future<List<MlsDataMapping>> getMlsDataMappings({
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
    final response = await _dioClient.get(ApiEndpoints.mlsDataMappings, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MlsDataMapping.fromJson(json)).toList();
  }

  Future<MlsDataMapping> createMlsDataMapping(MlsDataMapping item) async {
    final response = await _dioClient.post(ApiEndpoints.mlsDataMappings, data: item.toJson());
    return MlsDataMapping.fromJson(response.data['data']);
  }

  Future<MlsDataMapping> updateMlsDataMapping(String id, MlsDataMapping item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mlsDataMappings}/$id', data: item.toJson());
    return MlsDataMapping.fromJson(response.data['data']);
  }

  Future<void> deleteMlsDataMapping(String id) async {
    await _dioClient.delete('${ApiEndpoints.mlsDataMappings}/$id');
  }
}
