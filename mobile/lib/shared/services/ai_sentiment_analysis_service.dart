import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AISentimentAnalysisService {
  final DioClient _dioClient;

  AISentimentAnalysisService(this._dioClient);

  // Get AISentimentAnalysis by ID
  Future<AISentimentAnalysis> getAISentimentAnalysisById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_sentiment_analysis/$id');
      return AISentimentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_sentiment_analysiss
  Future<List<AISentimentAnalysis>> getAISentimentAnalysiss({
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

      final response = await _dioClient.get('/api/v1/ai_sentiment_analysis', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AISentimentAnalysis.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AISentimentAnalysis
  Future<AISentimentAnalysis> createAISentimentAnalysis(AISentimentAnalysis aISentimentAnalysis) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_sentiment_analysis',
        data: aISentimentAnalysis.toJson(),
      );
      return AISentimentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AISentimentAnalysis
  Future<AISentimentAnalysis> updateAISentimentAnalysis(String id, AISentimentAnalysis aISentimentAnalysis) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_sentiment_analysis/$id',
        data: aISentimentAnalysis.toJson(),
      );
      return AISentimentAnalysis.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AISentimentAnalysis
  Future<void> deleteAISentimentAnalysis(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_sentiment_analysis/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
