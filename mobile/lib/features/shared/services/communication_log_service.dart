import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class CommunicationLogService {
  final DioClient _dioClient;
  CommunicationLogService(this._dioClient);

  // ── Get by ID ──
  Future<CommunicationLog> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/communicationLog/$id');
      return CommunicationLog.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<CommunicationLog>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/communicationLog', queryParameters: q);
      return (r.data['data'] as List).map((j) => CommunicationLog.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<CommunicationLog>> getWithFilters({
    CommunicationType? type,
    String? content,
    String? entityType,
    dynamic? metadata,
    bool? isRead,
  }) async {
    final filters = <String, dynamic>{};
    if (type != null) filters['type'] = type.toString();
    if (content != null) filters['content'] = content;
    if (entityType != null) filters['entityType'] = entityType;
    if (metadata != null) filters['metadata'] = metadata.toString();
    if (isRead != null) filters['isRead'] = isRead.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<CommunicationLog> create(CommunicationLog communicationLog) async {
    if (communicationLog.type == null || communicationLog.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    try {
      final r = await _dioClient.post('/communicationLog', data: communicationLog.toJson());
      return CommunicationLog.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<CommunicationLog> update(String id, CommunicationLog communicationLog) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/communicationLog/$id', data: communicationLog.toJson());
      return CommunicationLog.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/communicationLog/$id');
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