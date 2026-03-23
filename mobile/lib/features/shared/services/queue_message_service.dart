import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class QueueMessageService {
  final DioClient _dioClient;
  QueueMessageService(this._dioClient);

  // ── Get by ID ──
  Future<QueueMessage> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/queueMessage/$id');
      return QueueMessage.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<QueueMessage>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/queueMessage', queryParameters: q);
      return (r.data['data'] as List).map((j) => QueueMessage.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<QueueMessage>> getWithFilters({
    String? queueName,
    String? exchangeName,
    String? routingKey,
    String? messageType,
    dynamic? payload,
  }) async {
    final filters = <String, dynamic>{};
    if (queueName != null) filters['queueName'] = queueName;
    if (exchangeName != null) filters['exchangeName'] = exchangeName;
    if (routingKey != null) filters['routingKey'] = routingKey;
    if (messageType != null) filters['messageType'] = messageType;
    if (payload != null) filters['payload'] = payload.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<QueueMessage> create(QueueMessage queueMessage) async {

    try {
      final r = await _dioClient.post('/queueMessage', data: queueMessage.toJson());
      return QueueMessage.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<QueueMessage> update(String id, QueueMessage queueMessage) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/queueMessage/$id', data: queueMessage.toJson());
      return QueueMessage.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/queueMessage/$id');
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