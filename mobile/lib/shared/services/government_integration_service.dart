import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class GovernmentIntegrationService {
  final DioClient _dioClient;

  GovernmentIntegrationService(this._dioClient);

  // Get GovernmentIntegration by ID
  Future<GovernmentIntegration> getGovernmentIntegrationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/government_integration/$id');
      return GovernmentIntegration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all government_integrations
  Future<List<GovernmentIntegration>> getGovernmentIntegrations({
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

      final response = await _dioClient.get('/api/v1/government_integration', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => GovernmentIntegration.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create GovernmentIntegration
  Future<GovernmentIntegration> createGovernmentIntegration(GovernmentIntegration governmentIntegration) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/government_integration',
        data: governmentIntegration.toJson(),
      );
      return GovernmentIntegration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update GovernmentIntegration
  Future<GovernmentIntegration> updateGovernmentIntegration(String id, GovernmentIntegration governmentIntegration) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/government_integration/$id',
        data: governmentIntegration.toJson(),
      );
      return GovernmentIntegration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete GovernmentIntegration
  Future<void> deleteGovernmentIntegration(String id) async {
    try {
      await _dioClient.delete('/api/v1/government_integration/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
