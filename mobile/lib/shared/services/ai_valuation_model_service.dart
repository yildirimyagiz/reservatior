import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIValuationModelService {
  final DioClient _dioClient;

  AIValuationModelService(this._dioClient);

  // Get AIValuationModel by ID
  Future<AIValuationModel> getAIValuationModelById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_valuation_model/$id');
      return AIValuationModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_valuation_models
  Future<List<AIValuationModel>> getAIValuationModels({
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

      final response = await _dioClient.get('/api/v1/ai_valuation_model', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIValuationModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIValuationModel
  Future<AIValuationModel> createAIValuationModel(AIValuationModel aIValuationModel) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_valuation_model',
        data: aIValuationModel.toJson(),
      );
      return AIValuationModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIValuationModel
  Future<AIValuationModel> updateAIValuationModel(String id, AIValuationModel aIValuationModel) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_valuation_model/$id',
        data: aIValuationModel.toJson(),
      );
      return AIValuationModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIValuationModel
  Future<void> deleteAIValuationModel(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_valuation_model/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
