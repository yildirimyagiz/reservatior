import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class WebhookDeliveryService {
  final DioClient _dioClient;
  WebhookDeliveryService(this._dioClient);

  // ── Get by ID ──
  Future<WebhookDelivery> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/webhookDelivery/$id');
      return WebhookDelivery.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<WebhookDelivery>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/webhookDelivery', queryParameters: q);
      return (r.data['data'] as List).map((j) => WebhookDelivery.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<WebhookDelivery>> getWithFilters({
    String? eventType,
    dynamic? payload,
    dynamic? response,
    int? statusCode,
    DateTime? deliveredAt,
  }) async {
    final filters = <String, dynamic>{};
    if (eventType != null) filters['eventType'] = eventType;
    if (payload != null) filters['payload'] = payload.toString();
    if (response != null) filters['response'] = response.toString();
    if (statusCode != null) filters['statusCode'] = statusCode.toString();
    if (deliveredAt != null) filters['deliveredAt'] = deliveredAt.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<WebhookDelivery> create(WebhookDelivery webhookDelivery) async {

    try {
      final r = await _dioClient.post('/webhookDelivery', data: webhookDelivery.toJson());
      return WebhookDelivery.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<WebhookDelivery> update(String id, WebhookDelivery webhookDelivery) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/webhookDelivery/$id', data: webhookDelivery.toJson());
      return WebhookDelivery.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/webhookDelivery/$id');
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