import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIImageAnalysisService {
  final DioClient _dioClient;

  AIImageAnalysisService(this._dioClient);

  // Get AIImageAnalysis by ID
  Future<AIImageAnalysis> getAIImageAnalysisById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_image_analysis/$id');
      return AIImageAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_image_analysiss
  Future<List<AIImageAnalysis>> getAIImageAnalysiss({
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

      final response = await _dioClient.get('/api/v1/ai_image_analysis', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIImageAnalysis.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIImageAnalysis
  Future<AIImageAnalysis> createAIImageAnalysis(AIImageAnalysis aIImageAnalysis) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_image_analysis',
        data: aIImageAnalysis.toJson(),
      );
      return AIImageAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIImageAnalysis
  Future<AIImageAnalysis> updateAIImageAnalysis(String id, AIImageAnalysis aIImageAnalysis) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_image_analysis/$id',
        data: aIImageAnalysis.toJson(),
      );
      return AIImageAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIImageAnalysis
  Future<void> deleteAIImageAnalysis(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_image_analysis/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
