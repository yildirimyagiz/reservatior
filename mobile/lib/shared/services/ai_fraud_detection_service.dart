import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIFraudDetectionService {
  final DioClient _dioClient;

  AIFraudDetectionService(this._dioClient);

  // Get AIFraudDetection by ID
  Future<AIFraudDetection> getAIFraudDetectionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_fraud_detection/$id');
      return AIFraudDetection.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_fraud_detections
  Future<List<AIFraudDetection>> getAIFraudDetections({
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

      final response = await _dioClient.get('/api/v1/ai_fraud_detection', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIFraudDetection.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIFraudDetection
  Future<AIFraudDetection> createAIFraudDetection(AIFraudDetection aIFraudDetection) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_fraud_detection',
        data: aIFraudDetection.toJson(),
      );
      return AIFraudDetection.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIFraudDetection
  Future<AIFraudDetection> updateAIFraudDetection(String id, AIFraudDetection aIFraudDetection) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_fraud_detection/$id',
        data: aIFraudDetection.toJson(),
      );
      return AIFraudDetection.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIFraudDetection
  Future<void> deleteAIFraudDetection(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_fraud_detection/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
