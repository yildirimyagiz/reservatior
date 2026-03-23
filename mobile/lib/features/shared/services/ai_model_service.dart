import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AIModelService {
  final DioClient _dioClient;
  AIModelService(this._dioClient);

  // ── Get by ID ──
  Future<AIModel> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aIModel/$id');
      return AIModel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AIModel>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aIModel', queryParameters: q);
      return (r.data['data'] as List).map((j) => AIModel.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AIModel>> getWithFilters({
    String? modelName,
    String? modelVersion,
    String? modelType,
    String? provider,
    String? endpointUrl,
  }) async {
    final filters = <String, dynamic>{};
    if (modelName != null) filters['modelName'] = modelName;
    if (modelVersion != null) filters['modelVersion'] = modelVersion;
    if (modelType != null) filters['modelType'] = modelType;
    if (provider != null) filters['provider'] = provider;
    if (endpointUrl != null) filters['endpointUrl'] = endpointUrl;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AIModel> create(AIModel aiModel) async {

    try {
      final r = await _dioClient.post('/aIModel', data: aiModel.toJson());
      return AIModel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AIModel> update(String id, AIModel aiModel) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aIModel/$id', data: aiModel.toJson());
      return AIModel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aIModel/$id');
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