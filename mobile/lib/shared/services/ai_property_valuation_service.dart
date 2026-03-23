import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIPropertyValuationService {
  final DioClient _dioClient;

  AIPropertyValuationService(this._dioClient);

  // Get AIPropertyValuation by ID
  Future<AIPropertyValuation> getAIPropertyValuationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_property_valuation/$id');
      return AIPropertyValuation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_property_valuations
  Future<List<AIPropertyValuation>> getAIPropertyValuations({
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

      final response = await _dioClient.get('/api/v1/ai_property_valuation', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIPropertyValuation.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIPropertyValuation
  Future<AIPropertyValuation> createAIPropertyValuation(AIPropertyValuation aIPropertyValuation) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_property_valuation',
        data: aIPropertyValuation.toJson(),
      );
      return AIPropertyValuation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIPropertyValuation
  Future<AIPropertyValuation> updateAIPropertyValuation(String id, AIPropertyValuation aIPropertyValuation) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_property_valuation/$id',
        data: aIPropertyValuation.toJson(),
      );
      return AIPropertyValuation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIPropertyValuation
  Future<void> deleteAIPropertyValuation(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_property_valuation/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
