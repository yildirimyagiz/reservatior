import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class KeyManagementService {
  final DioClient _dioClient;

  KeyManagementService(this._dioClient);

  // Get KeyManagement by ID
  Future<KeyManagement> getKeyManagementById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/key_management/$id');
      return KeyManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all key_managements
  Future<List<KeyManagement>> getKeyManagements({
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

      final response = await _dioClient.get('/api/v1/key_management', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => KeyManagement.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create KeyManagement
  Future<KeyManagement> createKeyManagement(KeyManagement keyManagement) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/key_management',
        data: keyManagement.toJson(),
      );
      return KeyManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update KeyManagement
  Future<KeyManagement> updateKeyManagement(String id, KeyManagement keyManagement) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/key_management/$id',
        data: keyManagement.toJson(),
      );
      return KeyManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete KeyManagement
  Future<void> deleteKeyManagement(String id) async {
    try {
      await _dioClient.delete('/api/v1/key_management/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
