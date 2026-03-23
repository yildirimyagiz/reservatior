import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for DocumentAnalysis operations
/// Provides CRUD operations with proper error handling and type safety
class DocumentAnalysisRepository {
  final DioClient _dioClient;

  DocumentAnalysisRepository(this._dioClient);

  /// Get DocumentAnalysis by ID
  /// Returns [DocumentAnalysis] if found, throws [RepositoryException] otherwise
  Future<DocumentAnalysis> getDocumentAnalysisById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/document_analysis/$id');
      if (response.statusCode == 200) {
        return DocumentAnalysis.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch document_analysis',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all document_analysises with pagination and filtering
  /// Returns list of [DocumentAnalysis] objects
  Future<List<DocumentAnalysis>> getdocument_analysises({
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
      
      final response = await _dioClient.get('/api/v1/document_analysis', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => DocumentAnalysis.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch document_analysises',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new DocumentAnalysis
  /// Returns created [DocumentAnalysis] object
  Future<DocumentAnalysis> createDocumentAnalysis(DocumentAnalysis documentAnalysis) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/document_analysis',
        data: documentAnalysis.toJson(),
      );
      return DocumentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update DocumentAnalysis
  Future<DocumentAnalysis> updateDocumentAnalysis(String id, DocumentAnalysis documentAnalysis) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/document_analysis/$id',
        data: documentAnalysis.toJson(),
      );
      return DocumentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete DocumentAnalysis
  Future<void> deleteDocumentAnalysis(String id) async {
    try {
      await _dioClient.delete('/api/v1/document_analysis/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
