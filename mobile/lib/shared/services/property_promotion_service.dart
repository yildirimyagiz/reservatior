import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PropertyPromotionService {
  final DioClient _dioClient;
  PropertyPromotionService(this._dioClient);

  Future<PropertyPromotion> getPropertyPromotionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.propertyPromotions}/$id');
    return PropertyPromotion.fromJson(response.data['data']);
  }

  Future<List<PropertyPromotion>> getPropertyPromotions({
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
    final response = await _dioClient.get(ApiEndpoints.propertyPromotions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyPromotion.fromJson(json)).toList();
  }

  Future<PropertyPromotion> createPropertyPromotion(PropertyPromotion item) async {
    final response = await _dioClient.post(ApiEndpoints.propertyPromotions, data: item.toJson());
    return PropertyPromotion.fromJson(response.data['data']);
  }

  Future<PropertyPromotion> updatePropertyPromotion(String id, PropertyPromotion item) async {
    final response = await _dioClient.patch('${ApiEndpoints.propertyPromotions}/$id', data: item.toJson());
    return PropertyPromotion.fromJson(response.data['data']);
  }

  Future<void> deletePropertyPromotion(String id) async {
    await _dioClient.delete('${ApiEndpoints.propertyPromotions}/$id');
  }
}
