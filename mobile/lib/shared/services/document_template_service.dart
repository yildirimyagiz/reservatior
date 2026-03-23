import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class DocumentTemplateService {
  final DioClient _dioClient;

  DocumentTemplateService(this._dioClient);

  // Get DocumentTemplate by ID
  Future<DocumentTemplate> getDocumentTemplateById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/document_template/$id');
      return DocumentTemplate.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all document_templates
  Future<List<DocumentTemplate>> getDocumentTemplates({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/document_template', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => DocumentTemplate.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create DocumentTemplate
  Future<DocumentTemplate> createDocumentTemplate(DocumentTemplate documentTemplate) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/document_template',
        data: documentTemplate.toJson(),
      );
      return DocumentTemplate.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update DocumentTemplate
  Future<DocumentTemplate> updateDocumentTemplate(String id, DocumentTemplate documentTemplate) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/document_template/$id',
        data: documentTemplate.toJson(),
      );
      return DocumentTemplate.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete DocumentTemplate
  Future<void> deleteDocumentTemplate(String id) async {
    try {
      await _dioClient.delete('/api/v1/document_template/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
