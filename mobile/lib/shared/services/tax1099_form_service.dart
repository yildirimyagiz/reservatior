import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class Tax1099FormService {
  final DioClient _dioClient;
  Tax1099FormService(this._dioClient);

  Future<Tax1099Form> getTax1099FormById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.tax1099Forms}/$id');
    return Tax1099Form.fromJson(response.data['data']);
  }

  Future<List<Tax1099Form>> getTax1099Forms({
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
    final response = await _dioClient.get(ApiEndpoints.tax1099Forms, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Tax1099Form.fromJson(json)).toList();
  }

  Future<Tax1099Form> createTax1099Form(Tax1099Form item) async {
    final response = await _dioClient.post(ApiEndpoints.tax1099Forms, data: item.toJson());
    return Tax1099Form.fromJson(response.data['data']);
  }

  Future<Tax1099Form> updateTax1099Form(String id, Tax1099Form item) async {
    final response = await _dioClient.patch('${ApiEndpoints.tax1099Forms}/$id', data: item.toJson());
    return Tax1099Form.fromJson(response.data['data']);
  }

  Future<void> deleteTax1099Form(String id) async {
    await _dioClient.delete('${ApiEndpoints.tax1099Forms}/$id');
  }
}
