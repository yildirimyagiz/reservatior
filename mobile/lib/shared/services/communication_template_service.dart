import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class CommunicationTemplateService {
  final DioClient _dioClient;
  CommunicationTemplateService(this._dioClient);

  Future<CommunicationTemplate> getCommunicationTemplateById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.communicationTemplates}/$id');
    return CommunicationTemplate.fromJson(response.data['data']);
  }

  Future<List<CommunicationTemplate>> getCommunicationTemplates({
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
    final response = await _dioClient.get(ApiEndpoints.communicationTemplates, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => CommunicationTemplate.fromJson(json)).toList();
  }

  Future<CommunicationTemplate> createCommunicationTemplate(CommunicationTemplate item) async {
    final response = await _dioClient.post(ApiEndpoints.communicationTemplates, data: item.toJson());
    return CommunicationTemplate.fromJson(response.data['data']);
  }

  Future<CommunicationTemplate> updateCommunicationTemplate(String id, CommunicationTemplate item) async {
    final response = await _dioClient.patch('${ApiEndpoints.communicationTemplates}/$id', data: item.toJson());
    return CommunicationTemplate.fromJson(response.data['data']);
  }

  Future<void> deleteCommunicationTemplate(String id) async {
    await _dioClient.delete('${ApiEndpoints.communicationTemplates}/$id');
  }
}
