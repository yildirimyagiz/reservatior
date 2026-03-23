import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AIChatbotSessionService {
  final DioClient _dioClient;
  AIChatbotSessionService(this._dioClient);

  // ── Get by ID ──
  Future<AIChatbotSession> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aIChatbotSession/$id');
      return AIChatbotSession.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AIChatbotSession>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aIChatbotSession', queryParameters: q);
      return (r.data['data'] as List).map((j) => AIChatbotSession.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AIChatbotSession>> getWithFilters({
    dynamic? conversationHistory,
    String? intent,
    double? confidence,
    String? status,
    String? transferredTo,
  }) async {
    final filters = <String, dynamic>{};
    if (conversationHistory != null) filters['conversationHistory'] = conversationHistory.toString();
    if (intent != null) filters['intent'] = intent;
    if (confidence != null) filters['confidence'] = confidence.toString();
    if (status != null) filters['status'] = status;
    if (transferredTo != null) filters['transferredTo'] = transferredTo;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AIChatbotSession> create(AIChatbotSession aiChatbotSession) async {
    if (aiChatbotSession.sessionId == null || aiChatbotSession.sessionId!.isEmpty) {
      throw ArgumentError('sessionId is required');
    }
    try {
      final r = await _dioClient.post('/aIChatbotSession', data: aiChatbotSession.toJson());
      return AIChatbotSession.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AIChatbotSession> update(String id, AIChatbotSession aiChatbotSession) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aIChatbotSession/$id', data: aiChatbotSession.toJson());
      return AIChatbotSession.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aIChatbotSession/$id');
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