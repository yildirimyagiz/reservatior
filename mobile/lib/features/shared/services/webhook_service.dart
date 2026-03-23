import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class WebhookService {
  final DioClient _dioClient;
  WebhookService(this._dioClient);

  // ── Get by ID ──
  Future<Webhook> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/webhook/$id');
      return Webhook.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Webhook>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/webhook', queryParameters: q);
      return (r.data['data'] as List).map((j) => Webhook.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Webhook>> getWithFilters({
    String? name,
    String? description,
    String? url,
    String? secret,
    dynamic? headers,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (description != null) filters['description'] = description;
    if (url != null) filters['url'] = url;
    if (secret != null) filters['secret'] = secret;
    if (headers != null) filters['headers'] = headers.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Webhook> create(Webhook webhook) async {
    if (webhook.name == null || webhook.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    try {
      final r = await _dioClient.post('/webhook', data: webhook.toJson());
      return Webhook.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Webhook> update(String id, Webhook webhook) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/webhook/$id', data: webhook.toJson());
      return Webhook.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/webhook/$id');
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