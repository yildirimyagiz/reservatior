import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class SessionService {
  final DioClient _dioClient;
  SessionService(this._dioClient);

  Future<Session> getSessionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.sessions}/$id');
    return Session.fromJson(response.data['data']);
  }

  Future<List<Session>> getSessions({
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
    final response = await _dioClient.get(ApiEndpoints.sessions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Session.fromJson(json)).toList();
  }

  Future<Session> createSession(Session item) async {
    final response = await _dioClient.post(ApiEndpoints.sessions, data: item.toJson());
    return Session.fromJson(response.data['data']);
  }

  Future<Session> updateSession(String id, Session item) async {
    final response = await _dioClient.patch('${ApiEndpoints.sessions}/$id', data: item.toJson());
    return Session.fromJson(response.data['data']);
  }

  Future<void> deleteSession(String id) async {
    await _dioClient.delete('${ApiEndpoints.sessions}/$id');
  }
}
