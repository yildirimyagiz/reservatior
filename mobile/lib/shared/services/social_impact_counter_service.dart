import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class SocialImpactCounterService {
  final DioClient _dioClient;
  SocialImpactCounterService(this._dioClient);

  Future<SocialImpactCounter> getSocialImpactCounterById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.socialImpactCounters}/$id');
    return SocialImpactCounter.fromJson(response.data['data']);
  }

  Future<List<SocialImpactCounter>> getSocialImpactCounters({
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
    final response = await _dioClient.get(ApiEndpoints.socialImpactCounters, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => SocialImpactCounter.fromJson(json)).toList();
  }

  Future<SocialImpactCounter> createSocialImpactCounter(SocialImpactCounter item) async {
    final response = await _dioClient.post(ApiEndpoints.socialImpactCounters, data: item.toJson());
    return SocialImpactCounter.fromJson(response.data['data']);
  }

  Future<SocialImpactCounter> updateSocialImpactCounter(String id, SocialImpactCounter item) async {
    final response = await _dioClient.patch('${ApiEndpoints.socialImpactCounters}/$id', data: item.toJson());
    return SocialImpactCounter.fromJson(response.data['data']);
  }

  Future<void> deleteSocialImpactCounter(String id) async {
    await _dioClient.delete('${ApiEndpoints.socialImpactCounters}/$id');
  }
}
