import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class UserService {
  final DioClient _dioClient;
  UserService(this._dioClient);

  // ── Get by ID ──
  Future<User> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/user/$id');
      return User.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<User>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/user', queryParameters: q);
      return (r.data['data'] as List).map((j) => User.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<User>> getWithFilters({
    String? email,
    String? name,
    String? phone,
    String? locale,
    String? timezone,
  }) async {
    final filters = <String, dynamic>{};
    if (email != null) filters['email'] = email;
    if (name != null) filters['name'] = name;
    if (phone != null) filters['phone'] = phone;
    if (locale != null) filters['locale'] = locale;
    if (timezone != null) filters['timezone'] = timezone;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<User> create(User user) async {
    if (user.email == null || user.email!.isEmpty) {
      throw ArgumentError('email is required');
    }
    if (user.name == null || user.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    try {
      final r = await _dioClient.post('/user', data: user.toJson());
      return User.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<User> update(String id, User user) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/user/$id', data: user.toJson());
      return User.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/user/$id');
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