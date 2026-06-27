import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class DocumentTemplateService {
  final DioClient _dioClient;
  DocumentTemplateService(this._dioClient);

  Future<DocumentTemplate> getDocumentTemplateById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.documentTemplates}/$id');
    return DocumentTemplate.fromJson(response.data['data']);
  }

  Future<List<DocumentTemplate>> getDocumentTemplates({
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
    final response = await _dioClient.get(ApiEndpoints.documentTemplates, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => DocumentTemplate.fromJson(json)).toList();
  }

  Future<DocumentTemplate> createDocumentTemplate(DocumentTemplate item) async {
    final response = await _dioClient.post(ApiEndpoints.documentTemplates, data: item.toJson());
    return DocumentTemplate.fromJson(response.data['data']);
  }

  Future<DocumentTemplate> updateDocumentTemplate(String id, DocumentTemplate item) async {
    final response = await _dioClient.patch('${ApiEndpoints.documentTemplates}/$id', data: item.toJson());
    return DocumentTemplate.fromJson(response.data['data']);
  }

  Future<void> deleteDocumentTemplate(String id) async {
    await _dioClient.delete('${ApiEndpoints.documentTemplates}/$id');
  }
}
