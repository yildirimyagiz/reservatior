import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class UserService {
  final DioClient _dioClient;
  UserService(this._dioClient);

  Future<User> getUserById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.users}/$id');
    return User.fromJson(response.data['data']);
  }

  Future<List<User>> getUsers({
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
    final response = await _dioClient.get(ApiEndpoints.users, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => User.fromJson(json)).toList();
  }

  Future<User> createUser(User item) async {
    final response = await _dioClient.post(ApiEndpoints.users, data: item.toJson());
    return User.fromJson(response.data['data']);
  }

  Future<User> updateUser(String id, User item) async {
    final response = await _dioClient.patch('${ApiEndpoints.users}/$id', data: item.toJson());
    return User.fromJson(response.data['data']);
  }

  Future<void> deleteUser(String id) async {
    await _dioClient.delete('${ApiEndpoints.users}/$id');
  }
}
