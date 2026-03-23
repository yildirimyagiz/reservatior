import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AIChatHandoffService {
  final DioClient _dioClient;
  AIChatHandoffService(this._dioClient);

  // ── Get by ID ──
  Future<AIChatHandoff> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aIChatHandoff/$id');
      return AIChatHandoff.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AIChatHandoff>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aIChatHandoff', queryParameters: q);
      return (r.data['data'] as List).map((j) => AIChatHandoff.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AIChatHandoff>> getWithFilters({
    String? handoffReason,
    String? handoffTo,
    DateTime? handoffAt,
    DateTime? resolvedAt,
    String? resolvedBy,
  }) async {
    final filters = <String, dynamic>{};
    if (handoffReason != null) filters['handoffReason'] = handoffReason;
    if (handoffTo != null) filters['handoffTo'] = handoffTo;
    if (handoffAt != null) filters['handoffAt'] = handoffAt.toIso8601String();
    if (resolvedAt != null) filters['resolvedAt'] = resolvedAt.toIso8601String();
    if (resolvedBy != null) filters['resolvedBy'] = resolvedBy;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AIChatHandoff> create(AIChatHandoff aiChatHandoff) async {
    if (aiChatHandoff.sessionId == null || aiChatHandoff.sessionId!.isEmpty) {
      throw ArgumentError('sessionId is required');
    }
    if (aiChatHandoff.handoffTo == null || aiChatHandoff.handoffTo!.isEmpty) {
      throw ArgumentError('handoffTo is required');
    }
    try {
      final r = await _dioClient.post('/aIChatHandoff', data: aiChatHandoff.toJson());
      return AIChatHandoff.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AIChatHandoff> update(String id, AIChatHandoff aiChatHandoff) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aIChatHandoff/$id', data: aiChatHandoff.toJson());
      return AIChatHandoff.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aIChatHandoff/$id');
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