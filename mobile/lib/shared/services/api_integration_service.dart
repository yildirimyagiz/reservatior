import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ApiIntegrationService {
  final DioClient _dioClient;

  ApiIntegrationService(this._dioClient);

  // Get ApiIntegration by ID
  Future<ApiIntegration> getApiIntegrationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/api_integration/$id');
      return ApiIntegration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all api_integrations
  Future<List<ApiIntegration>> getApiIntegrations({
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

      final response = await _dioClient.get('/api/v1/api_integration', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ApiIntegration.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ApiIntegration
  Future<ApiIntegration> createApiIntegration(ApiIntegration apiIntegration) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/api_integration',
        data: apiIntegration.toJson(),
      );
      return ApiIntegration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ApiIntegration
  Future<ApiIntegration> updateApiIntegration(String id, ApiIntegration apiIntegration) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/api_integration/$id',
        data: apiIntegration.toJson(),
      );
      return ApiIntegration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ApiIntegration
  Future<void> deleteApiIntegration(String id) async {
    try {
      await _dioClient.delete('/api/v1/api_integration/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
