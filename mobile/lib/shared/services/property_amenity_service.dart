import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PropertyAmenityService {
  final DioClient _dioClient;

  PropertyAmenityService(this._dioClient);

  // Get PropertyAmenity by ID
  Future<PropertyAmenity> getPropertyAmenityById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_amenity/$id');
      return PropertyAmenity.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all property_amenitys
  Future<List<PropertyAmenity>> getPropertyAmenitys({
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

      final response = await _dioClient.get('/api/v1/property_amenity', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PropertyAmenity.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PropertyAmenity
  Future<PropertyAmenity> createPropertyAmenity(PropertyAmenity propertyAmenity) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_amenity',
        data: propertyAmenity.toJson(),
      );
      return PropertyAmenity.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyAmenity
  Future<PropertyAmenity> updatePropertyAmenity(String id, PropertyAmenity propertyAmenity) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_amenity/$id',
        data: propertyAmenity.toJson(),
      );
      return PropertyAmenity.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyAmenity
  Future<void> deletePropertyAmenity(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_amenity/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
