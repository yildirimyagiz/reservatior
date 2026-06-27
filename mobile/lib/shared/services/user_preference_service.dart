import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class UserPreferenceService {
  final DioClient _dioClient;
  UserPreferenceService(this._dioClient);

  Future<UserPreference> getUserPreferenceById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.userPreferences}/$id');
    return UserPreference.fromJson(response.data['data']);
  }

  Future<List<UserPreference>> getUserPreferences({
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
    final response = await _dioClient.get(ApiEndpoints.userPreferences, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => UserPreference.fromJson(json)).toList();
  }

  Future<UserPreference> createUserPreference(UserPreference item) async {
    final response = await _dioClient.post(ApiEndpoints.userPreferences, data: item.toJson());
    return UserPreference.fromJson(response.data['data']);
  }

  Future<UserPreference> updateUserPreference(String id, UserPreference item) async {
    final response = await _dioClient.patch('${ApiEndpoints.userPreferences}/$id', data: item.toJson());
    return UserPreference.fromJson(response.data['data']);
  }

  Future<void> deleteUserPreference(String id) async {
    await _dioClient.delete('${ApiEndpoints.userPreferences}/$id');
  }
}
