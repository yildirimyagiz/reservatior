import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class DocumentAnalysisService {
  final DioClient _dioClient;
  DocumentAnalysisService(this._dioClient);

  Future<DocumentAnalysis> getDocumentAnalysisById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.documentAnalyses}/$id');
    return DocumentAnalysis.fromJson(response.data['data']);
  }

  Future<List<DocumentAnalysis>> getDocumentAnalysises({
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
    final response = await _dioClient.get(ApiEndpoints.documentAnalyses, queryParameters: queryParams);
    
    print('📄 DocumentAnalysis Response: ${response.data}');
    
    // Handle different response formats
    List<dynamic> data;
    if (response.data['data'] != null) {
      data = response.data['data'] as List;
    } else if (response.data is List) {
      data = response.data as List;
    } else {
      print('❌ DocumentAnalysis: Unexpected response format: ${response.data}');
      return [];
    }
    
    print('📄 DocumentAnalysis Parsed ${data.length} items');
    return data.map((json) {
      print('📄 Parsing item: $json');
      return DocumentAnalysis.fromJson(json);
    }).toList();
  }

  Future<DocumentAnalysis> createDocumentAnalysis(DocumentAnalysis item) async {
    final response = await _dioClient.post(ApiEndpoints.documentAnalyses, data: item.toJson());
    return DocumentAnalysis.fromJson(response.data['data']);
  }

  Future<DocumentAnalysis> updateDocumentAnalysis(String id, DocumentAnalysis item) async {
    final response = await _dioClient.patch('${ApiEndpoints.documentAnalyses}/$id', data: item.toJson());
    return DocumentAnalysis.fromJson(response.data['data']);
  }

  Future<void> deleteDocumentAnalysis(String id) async {
    await _dioClient.delete('${ApiEndpoints.documentAnalyses}/$id');
  }

  Future<Map<String, dynamic>> getJobStatus(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.documentAnalyses}/$id/status');
    return response.data['data'];
  }

  Future<List<Map<String, dynamic>>> searchContent(String orgId, String query, {Map<String, dynamic>? filters}) async {
    final response = await _dioClient.get(
      '${ApiEndpoints.documentAnalyses}/search',
      queryParameters: {'orgId': orgId, 'q': query, ...?filters},
    );
    return (response.data['data'] as List).cast<Map<String, dynamic>>();
  }
}
