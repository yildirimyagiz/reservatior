import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIInvestmentAnalysisService {
  final DioClient _dioClient;

  AIInvestmentAnalysisService(this._dioClient);

  // Get AIInvestmentAnalysis by ID
  Future<AIInvestmentAnalysis> getAIInvestmentAnalysisById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_investment_analysis/$id');
      return AIInvestmentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_investment_analysiss
  Future<List<AIInvestmentAnalysis>> getAIInvestmentAnalysiss({
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

      final response = await _dioClient.get('/api/v1/ai_investment_analysis', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIInvestmentAnalysis.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIInvestmentAnalysis
  Future<AIInvestmentAnalysis> createAIInvestmentAnalysis(AIInvestmentAnalysis aIInvestmentAnalysis) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_investment_analysis',
        data: aIInvestmentAnalysis.toJson(),
      );
      return AIInvestmentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIInvestmentAnalysis
  Future<AIInvestmentAnalysis> updateAIInvestmentAnalysis(String id, AIInvestmentAnalysis aIInvestmentAnalysis) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_investment_analysis/$id',
        data: aIInvestmentAnalysis.toJson(),
      );
      return AIInvestmentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIInvestmentAnalysis
  Future<void> deleteAIInvestmentAnalysis(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_investment_analysis/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
