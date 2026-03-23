import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PropertyDisclosureService {
  final DioClient _dioClient;

  PropertyDisclosureService(this._dioClient);

  // Get PropertyDisclosure by ID
  Future<PropertyDisclosure> getPropertyDisclosureById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_disclosure/$id');
      return PropertyDisclosure.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all property_disclosures
  Future<List<PropertyDisclosure>> getPropertyDisclosures({
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

      final response = await _dioClient.get('/api/v1/property_disclosure', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PropertyDisclosure.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PropertyDisclosure
  Future<PropertyDisclosure> createPropertyDisclosure(PropertyDisclosure propertyDisclosure) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_disclosure',
        data: propertyDisclosure.toJson(),
      );
      return PropertyDisclosure.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyDisclosure
  Future<PropertyDisclosure> updatePropertyDisclosure(String id, PropertyDisclosure propertyDisclosure) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_disclosure/$id',
        data: propertyDisclosure.toJson(),
      );
      return PropertyDisclosure.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyDisclosure
  Future<void> deletePropertyDisclosure(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_disclosure/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
