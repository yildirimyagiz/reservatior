import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MlsListingEnhancementService {
  final DioClient _dioClient;
  MlsListingEnhancementService(this._dioClient);

  Future<MlsListingEnhancement> getMlsListingEnhancementById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mlsListingEnhancements}/$id');
    return MlsListingEnhancement.fromJson(response.data['data']);
  }

  Future<List<MlsListingEnhancement>> getMlsListingEnhancements({
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
    final response = await _dioClient.get(ApiEndpoints.mlsListingEnhancements, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MlsListingEnhancement.fromJson(json)).toList();
  }

  Future<MlsListingEnhancement> createMlsListingEnhancement(MlsListingEnhancement item) async {
    final response = await _dioClient.post(ApiEndpoints.mlsListingEnhancements, data: item.toJson());
    return MlsListingEnhancement.fromJson(response.data['data']);
  }

  Future<MlsListingEnhancement> updateMlsListingEnhancement(String id, MlsListingEnhancement item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mlsListingEnhancements}/$id', data: item.toJson());
    return MlsListingEnhancement.fromJson(response.data['data']);
  }

  Future<void> deleteMlsListingEnhancement(String id) async {
    await _dioClient.delete('${ApiEndpoints.mlsListingEnhancements}/$id');
  }
}
