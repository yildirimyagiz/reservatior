import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIMarketAnalysisService {
  final DioClient _dioClient;

  AIMarketAnalysisService(this._dioClient);

  // Get AIMarketAnalysis by ID
  Future<AIMarketAnalysis> getAIMarketAnalysisById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_market_analysis/$id');
      return AIMarketAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_market_analysiss
  Future<List<AIMarketAnalysis>> getAIMarketAnalysiss({
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

      final response = await _dioClient.get('/api/v1/ai_market_analysis', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIMarketAnalysis.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIMarketAnalysis
  Future<AIMarketAnalysis> createAIMarketAnalysis(AIMarketAnalysis aIMarketAnalysis) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_market_analysis',
        data: aIMarketAnalysis.toJson(),
      );
      return AIMarketAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIMarketAnalysis
  Future<AIMarketAnalysis> updateAIMarketAnalysis(String id, AIMarketAnalysis aIMarketAnalysis) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_market_analysis/$id',
        data: aIMarketAnalysis.toJson(),
      );
      return AIMarketAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIMarketAnalysis
  Future<void> deleteAIMarketAnalysis(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_market_analysis/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
