import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ApiTokenService {
  final DioClient _dioClient;

  ApiTokenService(this._dioClient);

  // Get ApiToken by ID
  Future<ApiToken> getApiTokenById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/api_token/$id');
      return ApiToken.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all api_tokens
  Future<List<ApiToken>> getApiTokens({
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

      final response = await _dioClient.get('/api/v1/api_token', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ApiToken.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ApiToken
  Future<ApiToken> createApiToken(ApiToken apiToken) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/api_token',
        data: apiToken.toJson(),
      );
      return ApiToken.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ApiToken
  Future<ApiToken> updateApiToken(String id, ApiToken apiToken) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/api_token/$id',
        data: apiToken.toJson(),
      );
      return ApiToken.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ApiToken
  Future<void> deleteApiToken(String id) async {
    try {
      await _dioClient.delete('/api/v1/api_token/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
