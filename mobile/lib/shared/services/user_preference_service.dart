import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class UserPreferenceService {
  final DioClient _dioClient;

  UserPreferenceService(this._dioClient);

  // Get UserPreference by ID
  Future<UserPreference> getUserPreferenceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/user_preference/$id');
      return UserPreference.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all user_preferences
  Future<List<UserPreference>> getUserPreferences({
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

      final response = await _dioClient.get('/api/v1/user_preference', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => UserPreference.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create UserPreference
  Future<UserPreference> createUserPreference(UserPreference userPreference) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/user_preference',
        data: userPreference.toJson(),
      );
      return UserPreference.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update UserPreference
  Future<UserPreference> updateUserPreference(String id, UserPreference userPreference) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/user_preference/$id',
        data: userPreference.toJson(),
      );
      return UserPreference.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete UserPreference
  Future<void> deleteUserPreference(String id) async {
    try {
      await _dioClient.delete('/api/v1/user_preference/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
