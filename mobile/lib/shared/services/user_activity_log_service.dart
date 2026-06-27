import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class UserActivityLogService {
  final DioClient _dioClient;
  UserActivityLogService(this._dioClient);

  Future<UserActivityLog> getUserActivityLogById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.userActivityLogs}/$id');
    return UserActivityLog.fromJson(response.data['data']);
  }

  Future<List<UserActivityLog>> getUserActivityLogs({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.userActivityLogs, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => UserActivityLog.fromJson(json)).toList();
  }

  Future<UserActivityLog> createUserActivityLog(UserActivityLog item) async {
    final response = await _dioClient.post(ApiEndpoints.userActivityLogs, data: item.toJson());
    return UserActivityLog.fromJson(response.data['data']);
  }

  Future<UserActivityLog> updateUserActivityLog(String id, UserActivityLog item) async {
    final response = await _dioClient.patch('${ApiEndpoints.userActivityLogs}/$id', data: item.toJson());
    return UserActivityLog.fromJson(response.data['data']);
  }

  Future<void> deleteUserActivityLog(String id) async {
    await _dioClient.delete('${ApiEndpoints.userActivityLogs}/$id');
  }
}
