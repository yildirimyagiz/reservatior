import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PropertyViewingService {
  final DioClient _dioClient;

  PropertyViewingService(this._dioClient);

  // Get PropertyViewing by ID
  Future<PropertyViewing> getPropertyViewingById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_viewing/$id');
      return PropertyViewing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all property_viewings
  Future<List<PropertyViewing>> getPropertyViewings({
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

      final response = await _dioClient.get('/api/v1/property_viewing', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PropertyViewing.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PropertyViewing
  Future<PropertyViewing> createPropertyViewing(PropertyViewing propertyViewing) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_viewing',
        data: propertyViewing.toJson(),
      );
      return PropertyViewing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyViewing
  Future<PropertyViewing> updatePropertyViewing(String id, PropertyViewing propertyViewing) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_viewing/$id',
        data: propertyViewing.toJson(),
      );
      return PropertyViewing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyViewing
  Future<void> deletePropertyViewing(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_viewing/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
