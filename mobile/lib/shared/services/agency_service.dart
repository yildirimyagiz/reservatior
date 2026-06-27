import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AgencyService {
  final DioClient _dioClient;
  AgencyService(this._dioClient);

  Future<Agency> getAgencyById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agencies}/$id');
    return Agency.fromJson(response.data['data']);
  }

  Future<List<Agency>> getAgencies({
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
    final response = await _dioClient.get(ApiEndpoints.agencies, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Agency.fromJson(json)).toList();
  }

  Future<Agency> createAgency(Agency item) async {
    final response = await _dioClient.post(ApiEndpoints.agencies, data: item.toJson());
    return Agency.fromJson(response.data['data']);
  }

  Future<Agency> updateAgency(String id, Agency item) async {
    final response = await _dioClient.patch('${ApiEndpoints.agencies}/$id', data: item.toJson());
    return Agency.fromJson(response.data['data']);
  }

  Future<void> deleteAgency(String id) async {
    await _dioClient.delete('${ApiEndpoints.agencies}/$id');
  }

  Future<List<Map<String, dynamic>>> getAgents(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agencies}/$id/agents');
    final data = response.data['data'] as List;
    return data.cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> getStats(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agencies}/$id/stats');
    return response.data['data'];
  }

  Future<List<Map<String, dynamic>>> getListings(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.agencies}/$id/listings');
    final data = response.data['data'] as List;
    return data.cast<Map<String, dynamic>>();
  }
}
