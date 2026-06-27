import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PropertyDocumentService {
  final DioClient _dioClient;
  PropertyDocumentService(this._dioClient);

  Future<PropertyDocument> getPropertyDocumentById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.propertyDocuments}/$id');
    return PropertyDocument.fromJson(response.data['data']);
  }

  Future<List<PropertyDocument>> getPropertyDocuments({
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
    final response = await _dioClient.get(ApiEndpoints.propertyDocuments, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyDocument.fromJson(json)).toList();
  }

  Future<PropertyDocument> createPropertyDocument(PropertyDocument item) async {
    final response = await _dioClient.post(ApiEndpoints.propertyDocuments, data: item.toJson());
    return PropertyDocument.fromJson(response.data['data']);
  }

  Future<PropertyDocument> updatePropertyDocument(String id, PropertyDocument item) async {
    final response = await _dioClient.patch('${ApiEndpoints.propertyDocuments}/$id', data: item.toJson());
    return PropertyDocument.fromJson(response.data['data']);
  }

  Future<void> deletePropertyDocument(String id) async {
    await _dioClient.delete('${ApiEndpoints.propertyDocuments}/$id');
  }
}
