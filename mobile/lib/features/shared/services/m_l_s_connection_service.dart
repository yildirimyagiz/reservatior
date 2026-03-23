import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MLSConnectionService {
  final DioClient _dioClient;
  MLSConnectionService(this._dioClient);

  // ── Get by ID ──
  Future<MLSConnection> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/mLSConnection/$id');
      return MLSConnection.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MLSConnection>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/mLSConnection', queryParameters: q);
      return (r.data['data'] as List).map((j) => MLSConnection.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MLSConnection>> getWithFilters({
    MLSProviderKey? provider,
    String? name,
    String? baseUrl,
    bool? isEnabled,
    String? usernameCiphertext,
  }) async {
    final filters = <String, dynamic>{};
    if (provider != null) filters['provider'] = provider.toString();
    if (name != null) filters['name'] = name;
    if (baseUrl != null) filters['baseUrl'] = baseUrl;
    if (isEnabled != null) filters['isEnabled'] = isEnabled.toString();
    if (usernameCiphertext != null) filters['usernameCiphertext'] = usernameCiphertext;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MLSConnection> create(MLSConnection mLSConnection) async {
    if (mLSConnection.name == null || mLSConnection.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    try {
      final r = await _dioClient.post('/mLSConnection', data: mLSConnection.toJson());
      return MLSConnection.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MLSConnection> update(String id, MLSConnection mLSConnection) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/mLSConnection/$id', data: mLSConnection.toJson());
      return MLSConnection.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/mLSConnection/$id');
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