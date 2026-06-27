import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class LeaseService {
  final DioClient _dioClient;
  LeaseService(this._dioClient);

  Future<Lease> getLeaseById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.leases}/$id');
    return Lease.fromJson(response.data['data']);
  }

  Future<List<Lease>> getLeases({
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
    final response = await _dioClient.get(ApiEndpoints.leases, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Lease.fromJson(json)).toList();
  }

  Future<Lease> createLease(Lease item) async {
    final response = await _dioClient.post(ApiEndpoints.leases, data: item.toJson());
    return Lease.fromJson(response.data['data']);
  }

  Future<Lease> updateLease(String id, Lease item) async {
    final response = await _dioClient.patch('${ApiEndpoints.leases}/$id', data: item.toJson());
    return Lease.fromJson(response.data['data']);
  }

  Future<void> deleteLease(String id) async {
    await _dioClient.delete('${ApiEndpoints.leases}/$id');
  }
}
