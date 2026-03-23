import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class NotificationService {
  final DioClient _dioClient;
  NotificationService(this._dioClient);

  // ── Get by ID ──
  Future<Notification> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/notification/$id');
      return Notification.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Notification>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/notification', queryParameters: q);
      return (r.data['data'] as List).map((j) => Notification.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Notification>> getWithFilters({
    String? title,
    String? body,
    dynamic? data,
    NotificationStatus? status,
    DateTime? sentAt,
  }) async {
    final filters = <String, dynamic>{};
    if (title != null) filters['title'] = title;
    if (body != null) filters['body'] = body;
    if (data != null) filters['data'] = data.toString();
    if (status != null) filters['status'] = status.toString();
    if (sentAt != null) filters['sentAt'] = sentAt.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Notification> create(Notification notification) async {
    if (notification.title == null || notification.title!.isEmpty) {
      throw ArgumentError('title is required');
    }
    try {
      final r = await _dioClient.post('/notification', data: notification.toJson());
      return Notification.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Notification> update(String id, Notification notification) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/notification/$id', data: notification.toJson());
      return Notification.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/notification/$id');
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