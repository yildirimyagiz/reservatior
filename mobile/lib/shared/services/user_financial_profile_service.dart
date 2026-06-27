import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class UserFinancialProfileService {
  final DioClient _dioClient;
  UserFinancialProfileService(this._dioClient);

  Future<UserFinancialProfile> getUserFinancialProfileById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.userFinancialProfiles}/$id');
    return UserFinancialProfile.fromJson(response.data['data']);
  }

  Future<List<UserFinancialProfile>> getUserFinancialProfiles({
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
    final response = await _dioClient.get(ApiEndpoints.userFinancialProfiles, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => UserFinancialProfile.fromJson(json)).toList();
  }

  Future<UserFinancialProfile> createUserFinancialProfile(UserFinancialProfile item) async {
    final response = await _dioClient.post(ApiEndpoints.userFinancialProfiles, data: item.toJson());
    return UserFinancialProfile.fromJson(response.data['data']);
  }

  Future<UserFinancialProfile> updateUserFinancialProfile(String id, UserFinancialProfile item) async {
    final response = await _dioClient.patch('${ApiEndpoints.userFinancialProfiles}/$id', data: item.toJson());
    return UserFinancialProfile.fromJson(response.data['data']);
  }

  Future<void> deleteUserFinancialProfile(String id) async {
    await _dioClient.delete('${ApiEndpoints.userFinancialProfiles}/$id');
  }
}
