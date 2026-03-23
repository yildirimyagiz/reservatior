import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class DocumentService {
  final DioClient _dioClient;

  DocumentService(this._dioClient);

  // Get Document by ID
  Future<Document> getDocumentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/document/$id');
      return Document.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all documents
  Future<List<Document>> getDocuments({
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

      final response = await _dioClient.get('/api/v1/document', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Document.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Document
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
    return Exception('API Error: ${e.message}');
  }
}
