import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class SocialImpactRecordService {
  final DioClient _dioClient;
  SocialImpactRecordService(this._dioClient);

  Future<SocialImpactRecord> getSocialImpactRecordById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.socialImpactRecords}/$id');
    return SocialImpactRecord.fromJson(response.data['data']);
  }

  Future<List<SocialImpactRecord>> getSocialImpactRecords({
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
    final response = await _dioClient.get(ApiEndpoints.socialImpactRecords, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => SocialImpactRecord.fromJson(json)).toList();
  }

  Future<SocialImpactRecord> createSocialImpactRecord(SocialImpactRecord item) async {
    final response = await _dioClient.post(ApiEndpoints.socialImpactRecords, data: item.toJson());
    return SocialImpactRecord.fromJson(response.data['data']);
  }

  Future<SocialImpactRecord> updateSocialImpactRecord(String id, SocialImpactRecord item) async {
    final response = await _dioClient.patch('${ApiEndpoints.socialImpactRecords}/$id', data: item.toJson());
    return SocialImpactRecord.fromJson(response.data['data']);
  }

  Future<void> deleteSocialImpactRecord(String id) async {
    await _dioClient.delete('${ApiEndpoints.socialImpactRecords}/$id');
  }
}
