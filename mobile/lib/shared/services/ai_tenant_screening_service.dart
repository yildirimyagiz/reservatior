import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AITenantScreeningService {
  final DioClient _dioClient;

  AITenantScreeningService(this._dioClient);

  // Get AITenantScreening by ID
  Future<AITenantScreening> getAITenantScreeningById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_tenant_screening/$id');
      return AITenantScreening.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_tenant_screenings
  Future<List<AITenantScreening>> getAITenantScreenings({
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

      final response = await _dioClient.get('/api/v1/ai_tenant_screening', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AITenantScreening.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AITenantScreening
  Future<AITenantScreening> createAITenantScreening(AITenantScreening aITenantScreening) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_tenant_screening',
        data: aITenantScreening.toJson(),
      );
      return AITenantScreening.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AITenantScreening
  Future<AITenantScreening> updateAITenantScreening(String id, AITenantScreening aITenantScreening) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_tenant_screening/$id',
        data: aITenantScreening.toJson(),
      );
      return AITenantScreening.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AITenantScreening
  Future<void> deleteAITenantScreening(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_tenant_screening/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
