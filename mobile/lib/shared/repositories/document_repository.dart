import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Document operations
/// Provides CRUD operations with proper error handling and type safety
class DocumentRepository {
  final DioClient _dioClient;

  DocumentRepository(this._dioClient);

  /// Get Document by ID
  /// Returns [Document] if found, throws [RepositoryException] otherwise
  Future<Document> getDocumentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/document/$id');
      if (response.statusCode == 200) {
        return Document.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch document',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all documents with pagination and filtering
  /// Returns list of [Document] objects
  Future<List<Document>> getdocuments({
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
      
      final response = await _dioClient.get('/api/v1/document', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Document.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch documents',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Document
  /// Returns created [Document] object
  Future<Document> createDocument(Document document) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/document',
        data: document.toJson(),
      );
      return Document.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Document
  Future<Document> updateDocument(String id, Document document) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/document/$id',
        data: document.toJson(),
      );
      return Document.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Document
  Future<void> deleteDocument(String id) async {
    try {
      await _dioClient.delete('/api/v1/document/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
