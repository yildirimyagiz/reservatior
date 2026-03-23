import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class CommunicationTemplateService {
  final DioClient _dioClient;
  CommunicationTemplateService(this._dioClient);

  // ── Get by ID ──
  Future<CommunicationTemplate> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/communicationTemplate/$id');
      return CommunicationTemplate.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<CommunicationTemplate>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/communicationTemplate', queryParameters: q);
      return (r.data['data'] as List).map((j) => CommunicationTemplate.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<CommunicationTemplate>> getWithFilters({
    String? name,
    String? type,
    String? templateType,
    String? subject,
    String? htmlContent,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (type != null) filters['type'] = type;
    if (templateType != null) filters['templateType'] = templateType;
    if (subject != null) filters['subject'] = subject;
    if (htmlContent != null) filters['htmlContent'] = htmlContent;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<CommunicationTemplate> create(CommunicationTemplate communicationTemplate) async {
    if (communicationTemplate.name == null || communicationTemplate.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    if (communicationTemplate.type == null || communicationTemplate.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    if (communicationTemplate.subject == null || communicationTemplate.subject!.isEmpty) {
      throw ArgumentError('subject is required');
    }
    try {
      final r = await _dioClient.post('/communicationTemplate', data: communicationTemplate.toJson());
      return CommunicationTemplate.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<CommunicationTemplate> update(String id, CommunicationTemplate communicationTemplate) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/communicationTemplate/$id', data: communicationTemplate.toJson());
      return CommunicationTemplate.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/communicationTemplate/$id');
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