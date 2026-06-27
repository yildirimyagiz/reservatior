import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MlConfigurationService {
  final DioClient _dioClient;
  MlConfigurationService(this._dioClient);

  Future<MlConfiguration> getMlConfigurationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mlConfigurations}/$id');
    return MlConfiguration.fromJson(response.data['data']);
  }

  Future<List<MlConfiguration>> getMlConfigurations({
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
    final response = await _dioClient.get(ApiEndpoints.mlConfigurations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MlConfiguration.fromJson(json)).toList();
  }

  Future<MlConfiguration> createMlConfiguration(MlConfiguration item) async {
    final response = await _dioClient.post(ApiEndpoints.mlConfigurations, data: item.toJson());
    return MlConfiguration.fromJson(response.data['data']);
  }

  Future<MlConfiguration> updateMlConfiguration(String id, MlConfiguration item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mlConfigurations}/$id', data: item.toJson());
    return MlConfiguration.fromJson(response.data['data']);
  }

  Future<void> deleteMlConfiguration(String id) async {
    await _dioClient.delete('${ApiEndpoints.mlConfigurations}/$id');
  }
}
