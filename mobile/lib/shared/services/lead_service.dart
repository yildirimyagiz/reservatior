import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class LeadService {
  final DioClient _dioClient;
  LeadService(this._dioClient);

  Future<Lead> getLeadById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.leads}/$id');
    return Lead.fromJson(response.data['data']);
  }

  Future<List<Lead>> getLeads({
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
    final response = await _dioClient.get(ApiEndpoints.leads, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Lead.fromJson(json)).toList();
  }

  Future<Lead> createLead(Lead item) async {
    final response = await _dioClient.post(ApiEndpoints.leads, data: item.toJson());
    return Lead.fromJson(response.data['data']);
  }

  Future<Lead> updateLead(String id, Lead item) async {
    final response = await _dioClient.patch('${ApiEndpoints.leads}/$id', data: item.toJson());
    return Lead.fromJson(response.data['data']);
  }

  Future<void> deleteLead(String id) async {
    await _dioClient.delete('${ApiEndpoints.leads}/$id');
  }
}
