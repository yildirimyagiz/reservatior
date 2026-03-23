import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIPriceOptimizationService {
  final DioClient _dioClient;

  AIPriceOptimizationService(this._dioClient);

  // Get AIPriceOptimization by ID
  Future<AIPriceOptimization> getAIPriceOptimizationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_price_optimization/$id');
      return AIPriceOptimization.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_price_optimizations
  Future<List<AIPriceOptimization>> getAIPriceOptimizations({
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

      final response = await _dioClient.get('/api/v1/ai_price_optimization', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIPriceOptimization.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIPriceOptimization
  Future<AIPriceOptimization> createAIPriceOptimization(AIPriceOptimization aIPriceOptimization) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_price_optimization',
        data: aIPriceOptimization.toJson(),
      );
      return AIPriceOptimization.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIPriceOptimization
  Future<AIPriceOptimization> updateAIPriceOptimization(String id, AIPriceOptimization aIPriceOptimization) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_price_optimization/$id',
        data: aIPriceOptimization.toJson(),
      );
      return AIPriceOptimization.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIPriceOptimization
  Future<void> deleteAIPriceOptimization(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_price_optimization/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
