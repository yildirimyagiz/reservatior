import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class LeadSourceService {
  final DioClient _dioClient;
  LeadSourceService(this._dioClient);

  Future<LeadSource> getLeadSourceById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.leadSources}/$id');
    return LeadSource.fromJson(response.data['data']);
  }

  Future<List<LeadSource>> getLeadSources({
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
    final response = await _dioClient.get(ApiEndpoints.leadSources, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => LeadSource.fromJson(json)).toList();
  }

  Future<LeadSource> createLeadSource(LeadSource item) async {
    final response = await _dioClient.post(ApiEndpoints.leadSources, data: item.toJson());
    return LeadSource.fromJson(response.data['data']);
  }

  Future<LeadSource> updateLeadSource(String id, LeadSource item) async {
    final response = await _dioClient.patch('${ApiEndpoints.leadSources}/$id', data: item.toJson());
    return LeadSource.fromJson(response.data['data']);
  }

  Future<void> deleteLeadSource(String id) async {
    await _dioClient.delete('${ApiEndpoints.leadSources}/$id');
  }
}
