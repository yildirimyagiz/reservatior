import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ApiIntegrationService {
  final DioClient _dioClient;
  ApiIntegrationService(this._dioClient);

  // ── Get by ID ──
  Future<ApiIntegration> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aPIIntegration/$id');
      return ApiIntegration.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<ApiIntegration>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aPIIntegration', queryParameters: q);
      return (r.data['data'] as List).map((j) => ApiIntegration.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<ApiIntegration>> getWithFilters({
    String? providerName,
    String? integrationType,
    String? apiKeyCiphertext,
    String? apiSecretCiphertext,
    String? accessTokenCiphertext,
  }) async {
    final filters = <String, dynamic>{};
    if (providerName != null) filters['providerName'] = providerName;
    if (integrationType != null) filters['integrationType'] = integrationType;
    if (apiKeyCiphertext != null) filters['apiKeyCiphertext'] = apiKeyCiphertext;
    if (apiSecretCiphertext != null) filters['apiSecretCiphertext'] = apiSecretCiphertext;
    if (accessTokenCiphertext != null) filters['accessTokenCiphertext'] = accessTokenCiphertext;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<ApiIntegration> create(ApiIntegration aPIIntegration) async {

    try {
      final r = await _dioClient.post('/aPIIntegration', data: aPIIntegration.toJson());
      return ApiIntegration.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<ApiIntegration> update(String id, ApiIntegration aPIIntegration) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aPIIntegration/$id', data: aPIIntegration.toJson());
      return ApiIntegration.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aPIIntegration/$id');
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