import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class SessionService {
  final DioClient _dioClient;

  SessionService(this._dioClient);

  // Get Session by ID
  Future<Session> getSessionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/session/$id');
      return Session.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all sessions
  Future<List<Session>> getSessions({
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

      final response = await _dioClient.get('/api/v1/session', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Session.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Session
  Future<Session> createSession(Session session) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/session',
        data: session.toJson(),
      );
      return Session.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Session
  Future<Session> updateSession(String id, Session session) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/session/$id',
        data: session.toJson(),
      );
      return Session.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Session
  Future<void> deleteSession(String id) async {
    try {
      await _dioClient.delete('/api/v1/session/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
