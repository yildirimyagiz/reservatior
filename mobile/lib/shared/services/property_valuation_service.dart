import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PropertyValuationService {
  final DioClient _dioClient;

  PropertyValuationService(this._dioClient);

  // Get PropertyValuation by ID
  Future<PropertyValuation> getPropertyValuationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_valuation/$id');
      return PropertyValuation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all property_valuations
  Future<List<PropertyValuation>> getPropertyValuations({
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

      final response = await _dioClient.get('/api/v1/property_valuation', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PropertyValuation.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PropertyValuation
  Future<PropertyValuation> createPropertyValuation(PropertyValuation propertyValuation) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_valuation',
        data: propertyValuation.toJson(),
      );
      return PropertyValuation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyValuation
  Future<PropertyValuation> updatePropertyValuation(String id, PropertyValuation propertyValuation) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_valuation/$id',
        data: propertyValuation.toJson(),
      );
      return PropertyValuation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyValuation
  Future<void> deletePropertyValuation(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_valuation/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
