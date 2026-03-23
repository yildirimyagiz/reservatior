import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class DocumentAnalysisService {
  final DioClient _dioClient;

  DocumentAnalysisService(this._dioClient);

  // Get DocumentAnalysis by ID
  Future<DocumentAnalysis> getDocumentAnalysisById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/document_analysis/$id');
      return DocumentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all document_analysiss
  Future<List<DocumentAnalysis>> getDocumentAnalysiss({
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

      final response = await _dioClient.get('/api/v1/document_analysis', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => DocumentAnalysis.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create DocumentAnalysis
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
    return Exception('API Error: ${e.message}');
  }
}
