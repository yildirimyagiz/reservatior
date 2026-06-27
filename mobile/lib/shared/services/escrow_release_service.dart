import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class EscrowReleaseService {
  final DioClient _dioClient;
  EscrowReleaseService(this._dioClient);

  Future<EscrowRelease> getEscrowReleaseById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.escrowReleases}/$id');
    return EscrowRelease.fromJson(response.data['data']);
  }

  Future<List<EscrowRelease>> getEscrowReleases({
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
    final response = await _dioClient.get(ApiEndpoints.escrowReleases, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => EscrowRelease.fromJson(json)).toList();
  }

  Future<EscrowRelease> createEscrowRelease(EscrowRelease item) async {
    final response = await _dioClient.post(ApiEndpoints.escrowReleases, data: item.toJson());
    return EscrowRelease.fromJson(response.data['data']);
  }

  Future<EscrowRelease> updateEscrowRelease(String id, EscrowRelease item) async {
    final response = await _dioClient.patch('${ApiEndpoints.escrowReleases}/$id', data: item.toJson());
    return EscrowRelease.fromJson(response.data['data']);
  }

  Future<void> deleteEscrowRelease(String id) async {
    await _dioClient.delete('${ApiEndpoints.escrowReleases}/$id');
  }
}
