import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MLModelService {
  final DioClient _dioClient;
  MLModelService(this._dioClient);

  // ── Get by ID ──
  Future<MLModel> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/mLModel/$id');
      return MLModel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MLModel>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/mLModel', queryParameters: q);
      return (r.data['data'] as List).map((j) => MLModel.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MLModel>> getWithFilters({
    String? modelName,
    String? modelType,
    String? version,
    double? accuracy,
    dynamic? trainingData,
  }) async {
    final filters = <String, dynamic>{};
    if (modelName != null) filters['modelName'] = modelName;
    if (modelType != null) filters['modelType'] = modelType;
    if (version != null) filters['version'] = version;
    if (accuracy != null) filters['accuracy'] = accuracy.toString();
    if (trainingData != null) filters['trainingData'] = trainingData.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MLModel> create(MLModel mLModel) async {

    try {
      final r = await _dioClient.post('/mLModel', data: mLModel.toJson());
      return MLModel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MLModel> update(String id, MLModel mLModel) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/mLModel/$id', data: mLModel.toJson());
      return MLModel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/mLModel/$id');
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