import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AIValuationModelService {
  final DioClient _dioClient;
  AIValuationModelService(this._dioClient);

  // ── Get by ID ──
  Future<AIValuationModel> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aIValuationModel/$id');
      return AIValuationModel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AIValuationModel>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aIValuationModel', queryParameters: q);
      return (r.data['data'] as List).map((j) => AIValuationModel.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AIValuationModel>> getWithFilters({
    String? modelName,
    String? modelVersion,
    double? accuracy,
    DateTime? lastTrainedAt,
    dynamic? features,
  }) async {
    final filters = <String, dynamic>{};
    if (modelName != null) filters['modelName'] = modelName;
    if (modelVersion != null) filters['modelVersion'] = modelVersion;
    if (accuracy != null) filters['accuracy'] = accuracy.toString();
    if (lastTrainedAt != null) filters['lastTrainedAt'] = lastTrainedAt.toIso8601String();
    if (features != null) filters['features'] = features.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AIValuationModel> create(AIValuationModel aiValuationModel) async {

    try {
      final r = await _dioClient.post('/aIValuationModel', data: aiValuationModel.toJson());
      return AIValuationModel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AIValuationModel> update(String id, AIValuationModel aiValuationModel) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aIValuationModel/$id', data: aiValuationModel.toJson());
      return AIValuationModel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aIValuationModel/$id');
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