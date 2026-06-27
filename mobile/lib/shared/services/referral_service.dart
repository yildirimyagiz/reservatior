import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ReferralService {
  final DioClient _dioClient;
  ReferralService(this._dioClient);

  Future<Referral> getReferralById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.referrals}/$id');
    return Referral.fromJson(response.data['data']);
  }

  Future<List<Referral>> getReferrals({
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
    final response = await _dioClient.get(ApiEndpoints.referrals, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Referral.fromJson(json)).toList();
  }

  Future<Referral> createReferral(Referral item) async {
    final response = await _dioClient.post(ApiEndpoints.referrals, data: item.toJson());
    return Referral.fromJson(response.data['data']);
  }

  Future<Referral> updateReferral(String id, Referral item) async {
    final response = await _dioClient.patch('${ApiEndpoints.referrals}/$id', data: item.toJson());
    return Referral.fromJson(response.data['data']);
  }

  Future<void> deleteReferral(String id) async {
    await _dioClient.delete('${ApiEndpoints.referrals}/$id');
  }
}
