import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class BrandAmbassadorService {
  final DioClient _dioClient;
  BrandAmbassadorService(this._dioClient);

  Future<BrandAmbassador> getBrandAmbassadorById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.brandAmbassadors}/$id');
    return BrandAmbassador.fromJson(response.data['data']);
  }

  Future<List<BrandAmbassador>> getBrandAmbassadors({
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
    final response = await _dioClient.get(ApiEndpoints.brandAmbassadors, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => BrandAmbassador.fromJson(json)).toList();
  }

  Future<BrandAmbassador> createBrandAmbassador(BrandAmbassador item) async {
    final response = await _dioClient.post(ApiEndpoints.brandAmbassadors, data: item.toJson());
    return BrandAmbassador.fromJson(response.data['data']);
  }

  Future<BrandAmbassador> updateBrandAmbassador(String id, BrandAmbassador item) async {
    final response = await _dioClient.patch('${ApiEndpoints.brandAmbassadors}/$id', data: item.toJson());
    return BrandAmbassador.fromJson(response.data['data']);
  }

  Future<void> deleteBrandAmbassador(String id) async {
    await _dioClient.delete('${ApiEndpoints.brandAmbassadors}/$id');
  }
}
