import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PropertyPromotionService {
  final DioClient _dioClient;

  PropertyPromotionService(this._dioClient);

  // Get PropertyPromotion by ID
  Future<PropertyPromotion> getPropertyPromotionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_promotion/$id');
      return PropertyPromotion.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all property_promotions
  Future<List<PropertyPromotion>> getPropertyPromotions({
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

      final response = await _dioClient.get('/api/v1/property_promotion', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PropertyPromotion.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PropertyPromotion
  Future<PropertyPromotion> createPropertyPromotion(PropertyPromotion propertyPromotion) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_promotion',
        data: propertyPromotion.toJson(),
      );
      return PropertyPromotion.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyPromotion
  Future<PropertyPromotion> updatePropertyPromotion(String id, PropertyPromotion propertyPromotion) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_promotion/$id',
        data: propertyPromotion.toJson(),
      );
      return PropertyPromotion.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyPromotion
  Future<void> deletePropertyPromotion(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_promotion/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
