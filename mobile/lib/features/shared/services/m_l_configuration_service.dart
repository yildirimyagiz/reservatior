import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MLConfigurationService {
  final DioClient _dioClient;
  MLConfigurationService(this._dioClient);

  // ── Get by ID ──
  Future<MLConfiguration> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/mLConfiguration/$id');
      return MLConfiguration.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MLConfiguration>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/mLConfiguration', queryParameters: q);
      return (r.data['data'] as List).map((j) => MLConfiguration.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MLConfiguration>> getWithFilters({
    bool? enableAutoTagging,
    double? qualityThreshold,
    bool? enableMLFeatures,
    int? maxTagsPerImage,
    String? analysisMode,
  }) async {
    final filters = <String, dynamic>{};
    if (enableAutoTagging != null) filters['enableAutoTagging'] = enableAutoTagging.toString();
    if (qualityThreshold != null) filters['qualityThreshold'] = qualityThreshold.toString();
    if (enableMLFeatures != null) filters['enableMLFeatures'] = enableMLFeatures.toString();
    if (maxTagsPerImage != null) filters['maxTagsPerImage'] = maxTagsPerImage.toString();
    if (analysisMode != null) filters['analysisMode'] = analysisMode;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MLConfiguration> create(MLConfiguration mLConfiguration) async {

    try {
      final r = await _dioClient.post('/mLConfiguration', data: mLConfiguration.toJson());
      return MLConfiguration.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MLConfiguration> update(String id, MLConfiguration mLConfiguration) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/mLConfiguration/$id', data: mLConfiguration.toJson());
      return MLConfiguration.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/mLConfiguration/$id');
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