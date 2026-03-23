import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIModelService {
  final DioClient _dioClient;

  AIModelService(this._dioClient);

  // Get AIModel by ID
  Future<AIModel> getAIModelById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_model/$id');
      return AIModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_models
  Future<List<AIModel>> getAIModels({
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

      final response = await _dioClient.get('/api/v1/ai_model', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIModel
  Future<AIModel> createAIModel(AIModel aIModel) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_model',
        data: aIModel.toJson(),
      );
      return AIModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIModel
  Future<AIModel> updateAIModel(String id, AIModel aIModel) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_model/$id',
        data: aIModel.toJson(),
      );
      return AIModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIModel
  Future<void> deleteAIModel(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_model/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
