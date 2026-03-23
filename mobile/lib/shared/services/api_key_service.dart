import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ApiKeyService {
  final DioClient _dioClient;

  ApiKeyService(this._dioClient);

  // Get ApiKey by ID
  Future<ApiKey> getApiKeyById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/api_key/$id');
      return ApiKey.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all api_keys
  Future<List<ApiKey>> getApiKeys({
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

      final response = await _dioClient.get('/api/v1/api_key', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ApiKey.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ApiKey
  Future<ApiKey> createApiKey(ApiKey apiKey) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/api_key',
        data: apiKey.toJson(),
      );
      return ApiKey.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ApiKey
  Future<ApiKey> updateApiKey(String id, ApiKey apiKey) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/api_key/$id',
        data: apiKey.toJson(),
      );
      return ApiKey.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ApiKey
  Future<void> deleteApiKey(String id) async {
    try {
      await _dioClient.delete('/api/v1/api_key/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
