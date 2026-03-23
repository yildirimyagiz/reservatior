import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIModelDeploymentService {
  final DioClient _dioClient;

  AIModelDeploymentService(this._dioClient);

  // Get AIModelDeployment by ID
  Future<AIModelDeployment> getAIModelDeploymentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_model_deployment/$id');
      return AIModelDeployment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_model_deployments
  Future<List<AIModelDeployment>> getAIModelDeployments({
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

      final response = await _dioClient.get('/api/v1/ai_model_deployment', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIModelDeployment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIModelDeployment
  Future<AIModelDeployment> createAIModelDeployment(AIModelDeployment aIModelDeployment) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_model_deployment',
        data: aIModelDeployment.toJson(),
      );
      return AIModelDeployment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIModelDeployment
  Future<AIModelDeployment> updateAIModelDeployment(String id, AIModelDeployment aIModelDeployment) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_model_deployment/$id',
        data: aIModelDeployment.toJson(),
      );
      return AIModelDeployment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIModelDeployment
  Future<void> deleteAIModelDeployment(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_model_deployment/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
