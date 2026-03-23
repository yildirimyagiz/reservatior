import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ReferenceSourceService {
  final DioClient _dioClient;
  ReferenceSourceService(this._dioClient);

  // ── Get by ID ──
  Future<ReferenceSource> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/referenceSource/$id');
      return ReferenceSource.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<ReferenceSource>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/referenceSource', queryParameters: q);
      return (r.data['data'] as List).map((j) => ReferenceSource.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<ReferenceSource>> getWithFilters({
    String? name,
    String? logo,
    String? apiKey,
    String? apiSecret,
    String? baseUrl,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (logo != null) filters['logo'] = logo;
    if (apiKey != null) filters['apiKey'] = apiKey;
    if (apiSecret != null) filters['apiSecret'] = apiSecret;
    if (baseUrl != null) filters['baseUrl'] = baseUrl;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<ReferenceSource> create(ReferenceSource referenceSource) async {
    if (referenceSource.name == null || referenceSource.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    try {
      final r = await _dioClient.post('/referenceSource', data: referenceSource.toJson());
      return ReferenceSource.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<ReferenceSource> update(String id, ReferenceSource referenceSource) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/referenceSource/$id', data: referenceSource.toJson());
      return ReferenceSource.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/referenceSource/$id');
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