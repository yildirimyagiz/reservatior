import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class TaxDepreciationService {
  final DioClient _dioClient;
  TaxDepreciationService(this._dioClient);

  Future<TaxDepreciation> getTaxDepreciationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.taxDepreciations}/$id');
    return TaxDepreciation.fromJson(response.data['data']);
  }

  Future<List<TaxDepreciation>> getTaxDepreciations({
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
    final response = await _dioClient.get(ApiEndpoints.taxDepreciations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => TaxDepreciation.fromJson(json)).toList();
  }

  Future<TaxDepreciation> createTaxDepreciation(TaxDepreciation item) async {
    final response = await _dioClient.post(ApiEndpoints.taxDepreciations, data: item.toJson());
    return TaxDepreciation.fromJson(response.data['data']);
  }

  Future<TaxDepreciation> updateTaxDepreciation(String id, TaxDepreciation item) async {
    final response = await _dioClient.patch('${ApiEndpoints.taxDepreciations}/$id', data: item.toJson());
    return TaxDepreciation.fromJson(response.data['data']);
  }

  Future<void> deleteTaxDepreciation(String id) async {
    await _dioClient.delete('${ApiEndpoints.taxDepreciations}/$id');
  }
}
