import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIPredictionService {
  final DioClient _dioClient;

  AIPredictionService(this._dioClient);

  // Get AIPrediction by ID
  Future<AIPrediction> getAIPredictionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_prediction/$id');
      return AIPrediction.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_predictions
  Future<List<AIPrediction>> getAIPredictions({
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

      final response = await _dioClient.get('/api/v1/ai_prediction', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIPrediction.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIPrediction
  Future<AIPrediction> createAIPrediction(AIPrediction aIPrediction) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_prediction',
        data: aIPrediction.toJson(),
      );
      return AIPrediction.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIPrediction
  Future<AIPrediction> updateAIPrediction(String id, AIPrediction aIPrediction) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_prediction/$id',
        data: aIPrediction.toJson(),
      );
      return AIPrediction.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIPrediction
  Future<void> deleteAIPrediction(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_prediction/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
