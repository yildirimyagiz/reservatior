import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for DocumentTemplate operations
/// Provides CRUD operations with proper error handling and type safety
class DocumentTemplateRepository {
  final DioClient _dioClient;

  DocumentTemplateRepository(this._dioClient);

  /// Get DocumentTemplate by ID
  /// Returns [DocumentTemplate] if found, throws [RepositoryException] otherwise
  Future<DocumentTemplate> getDocumentTemplateById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/document_template/$id');
      if (response.statusCode == 200) {
        return DocumentTemplate.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch document_template',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all document_templates with pagination and filtering
  /// Returns list of [DocumentTemplate] objects
  Future<List<DocumentTemplate>> getdocument_templates({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/document_template', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => DocumentTemplate.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch document_templates',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new DocumentTemplate
  /// Returns created [DocumentTemplate] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
