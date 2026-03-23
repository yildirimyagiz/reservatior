import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PropertyOfferService {
  final DioClient _dioClient;

  PropertyOfferService(this._dioClient);

  // Get PropertyOffer by ID
  Future<PropertyOffer> getPropertyOfferById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_offer/$id');
      return PropertyOffer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all property_offers
  Future<List<PropertyOffer>> getPropertyOffers({
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

      final response = await _dioClient.get('/api/v1/property_offer', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PropertyOffer.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PropertyOffer
  Future<PropertyOffer> createPropertyOffer(PropertyOffer propertyOffer) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_offer',
        data: propertyOffer.toJson(),
      );
      return PropertyOffer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyOffer
  Future<PropertyOffer> updatePropertyOffer(String id, PropertyOffer propertyOffer) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_offer/$id',
        data: propertyOffer.toJson(),
      );
      return PropertyOffer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyOffer
  Future<void> deletePropertyOffer(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_offer/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
