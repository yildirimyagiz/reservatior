import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class UserActivityLogService {
  final DioClient _dioClient;
  UserActivityLogService(this._dioClient);

  // ── Get by ID ──
  Future<UserActivityLog> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/userActivityLog/$id');
      return UserActivityLog.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<UserActivityLog>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/userActivityLog', queryParameters: q);
      return (r.data['data'] as List).map((j) => UserActivityLog.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<UserActivityLog>> getWithFilters({
    String? action,
    String? entityType,
    dynamic? metadata,
    String? ipAddress,
    String? userAgent,
  }) async {
    final filters = <String, dynamic>{};
    if (action != null) filters['action'] = action;
    if (entityType != null) filters['entityType'] = entityType;
    if (metadata != null) filters['metadata'] = metadata.toString();
    if (ipAddress != null) filters['ipAddress'] = ipAddress;
    if (userAgent != null) filters['userAgent'] = userAgent;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<UserActivityLog> create(UserActivityLog userActivityLog) async {

    try {
      final r = await _dioClient.post('/userActivityLog', data: userActivityLog.toJson());
      return UserActivityLog.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<UserActivityLog> update(String id, UserActivityLog userActivityLog) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/userActivityLog/$id', data: userActivityLog.toJson());
      return UserActivityLog.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/userActivityLog/$id');
    } on DioException catch (e) { throw _err(e); }
  }

  Exception _err(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout. Check your internet connection.');
      case DioExceptionType.badResponse:
        final msg = e.response?.data?['message'] ?? 'Server error';
        return Exception('Server error: $msg');
      case DioExceptionType.connectionError:
        return Exception('Network error. Check your internet connection.');
      default:
        return Exception('Request failed: ${e.message}');
    }
  }
}