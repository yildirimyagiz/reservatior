import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class DocumentService {
  final DioClient _dioClient;
  DocumentService(this._dioClient);

  Future<Document> getDocumentById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.documents}/$id');
    return Document.fromJson(response.data['data']);
  }

  Future<List<Document>> getDocuments({
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
    final response = await _dioClient.get(ApiEndpoints.documents, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Document.fromJson(json)).toList();
  }

  Future<Document> createDocument(Document item) async {
    final response = await _dioClient.post(ApiEndpoints.documents, data: item.toJson());
    return Document.fromJson(response.data['data']);
  }

  Future<Document> updateDocument(String id, Document item) async {
    final response = await _dioClient.patch('${ApiEndpoints.documents}/$id', data: item.toJson());
    return Document.fromJson(response.data['data']);
  }

  Future<void> deleteDocument(String id) async {
    await _dioClient.delete('${ApiEndpoints.documents}/$id');
  }
}
