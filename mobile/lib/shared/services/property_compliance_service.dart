import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PropertyComplianceService {
  final DioClient _dioClient;

  PropertyComplianceService(this._dioClient);

  // Get PropertyCompliance by ID
  Future<PropertyCompliance> getPropertyComplianceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_compliance/$id');
      return PropertyCompliance.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all property_compliances
  Future<List<PropertyCompliance>> getPropertyCompliances({
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

      final response = await _dioClient.get('/api/v1/property_compliance', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PropertyCompliance.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PropertyCompliance
  Future<PropertyCompliance> createPropertyCompliance(PropertyCompliance propertyCompliance) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_compliance',
        data: propertyCompliance.toJson(),
      );
      return PropertyCompliance.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyCompliance
  Future<PropertyCompliance> updatePropertyCompliance(String id, PropertyCompliance propertyCompliance) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_compliance/$id',
        data: propertyCompliance.toJson(),
      );
      return PropertyCompliance.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyCompliance
  Future<void> deletePropertyCompliance(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_compliance/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
