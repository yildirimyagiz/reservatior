import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MLSExternalListingService {
  final DioClient _dioClient;
  MLSExternalListingService(this._dioClient);

  // ── Get by ID ──
  Future<MLSExternalListing> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/mLSExternalListing/$id');
      return MLSExternalListing.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MLSExternalListing>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/mLSExternalListing', queryParameters: q);
      return (r.data['data'] as List).map((j) => MLSExternalListing.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MLSExternalListing>> getWithFilters({
    String? externalUrl,
    dynamic? raw,
    String? status,
    DateTime? lastSeenAt,
  }) async {
    final filters = <String, dynamic>{};
    if (externalUrl != null) filters['externalUrl'] = externalUrl;
    if (raw != null) filters['raw'] = raw.toString();
    if (status != null) filters['status'] = status;
    if (lastSeenAt != null) filters['lastSeenAt'] = lastSeenAt.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MLSExternalListing> create(MLSExternalListing mLSExternalListing) async {

    try {
      final r = await _dioClient.post('/mLSExternalListing', data: mLSExternalListing.toJson());
      return MLSExternalListing.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MLSExternalListing> update(String id, MLSExternalListing mLSExternalListing) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/mLSExternalListing/$id', data: mLSExternalListing.toJson());
      return MLSExternalListing.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/mLSExternalListing/$id');
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