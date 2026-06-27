import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class LeaseRenewalService {
  final DioClient _dioClient;
  LeaseRenewalService(this._dioClient);

  Future<LeaseRenewal> getLeaseRenewalById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.leaseRenewals}/$id');
    return LeaseRenewal.fromJson(response.data['data']);
  }

  Future<List<LeaseRenewal>> getLeaseRenewals({
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
    final response = await _dioClient.get(ApiEndpoints.leaseRenewals, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => LeaseRenewal.fromJson(json)).toList();
  }

  Future<LeaseRenewal> createLeaseRenewal(LeaseRenewal item) async {
    final response = await _dioClient.post(ApiEndpoints.leaseRenewals, data: item.toJson());
    return LeaseRenewal.fromJson(response.data['data']);
  }

  Future<LeaseRenewal> updateLeaseRenewal(String id, LeaseRenewal item) async {
    final response = await _dioClient.patch('${ApiEndpoints.leaseRenewals}/$id', data: item.toJson());
    return LeaseRenewal.fromJson(response.data['data']);
  }

  Future<void> deleteLeaseRenewal(String id) async {
    await _dioClient.delete('${ApiEndpoints.leaseRenewals}/$id');
  }
}
