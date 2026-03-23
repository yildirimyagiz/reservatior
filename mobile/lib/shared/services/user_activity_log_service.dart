import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class UserActivityLogService {
  final DioClient _dioClient;

  UserActivityLogService(this._dioClient);

  // Get UserActivityLog by ID
  Future<UserActivityLog> getUserActivityLogById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/user_activity_log/$id');
      return UserActivityLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all user_activity_logs
  Future<List<UserActivityLog>> getUserActivityLogs({
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

      final response = await _dioClient.get('/api/v1/user_activity_log', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => UserActivityLog.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create UserActivityLog
  Future<UserActivityLog> createUserActivityLog(UserActivityLog userActivityLog) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/user_activity_log',
        data: userActivityLog.toJson(),
      );
      return UserActivityLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update UserActivityLog
  Future<UserActivityLog> updateUserActivityLog(String id, UserActivityLog userActivityLog) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/user_activity_log/$id',
        data: userActivityLog.toJson(),
      );
      return UserActivityLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete UserActivityLog
  Future<void> deleteUserActivityLog(String id) async {
    try {
      await _dioClient.delete('/api/v1/user_activity_log/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
