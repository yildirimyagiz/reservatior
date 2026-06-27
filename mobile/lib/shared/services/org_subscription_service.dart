import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class OrgSubscriptionService {
  final DioClient _dioClient;
  OrgSubscriptionService(this._dioClient);

  Future<OrgSubscription> getOrgSubscriptionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.orgSubscriptions}/$id');
    return OrgSubscription.fromJson(response.data['data']);
  }

  Future<List<OrgSubscription>> getOrgSubscriptions({
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
    final response = await _dioClient.get(ApiEndpoints.orgSubscriptions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => OrgSubscription.fromJson(json)).toList();
  }

  Future<OrgSubscription> createOrgSubscription(OrgSubscription item) async {
    final response = await _dioClient.post(ApiEndpoints.orgSubscriptions, data: item.toJson());
    return OrgSubscription.fromJson(response.data['data']);
  }

  Future<OrgSubscription> updateOrgSubscription(String id, OrgSubscription item) async {
    final response = await _dioClient.patch('${ApiEndpoints.orgSubscriptions}/$id', data: item.toJson());
    return OrgSubscription.fromJson(response.data['data']);
  }

  Future<void> deleteOrgSubscription(String id) async {
    await _dioClient.delete('${ApiEndpoints.orgSubscriptions}/$id');
  }
}
