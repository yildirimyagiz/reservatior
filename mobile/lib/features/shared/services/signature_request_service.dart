import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class SignatureRequestService {
  final DioClient _dioClient;
  SignatureRequestService(this._dioClient);

  // ── Get by ID ──
  Future<SignatureRequest> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/signatureRequest/$id');
      return SignatureRequest.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<SignatureRequest>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/signatureRequest', queryParameters: q);
      return (r.data['data'] as List).map((j) => SignatureRequest.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<SignatureRequest>> getWithFilters({
    String? provider,
    SignatureStatus? status,
    String? signUrl,
    String? signedDocumentUrl,
    DateTime? expiresAt,
  }) async {
    final filters = <String, dynamic>{};
    if (provider != null) filters['provider'] = provider;
    if (status != null) filters['status'] = status.toString();
    if (signUrl != null) filters['signUrl'] = signUrl;
    if (signedDocumentUrl != null) filters['signedDocumentUrl'] = signedDocumentUrl;
    if (expiresAt != null) filters['expiresAt'] = expiresAt.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<SignatureRequest> create(SignatureRequest signatureRequest) async {

    try {
      final r = await _dioClient.post('/signatureRequest', data: signatureRequest.toJson());
      return SignatureRequest.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<SignatureRequest> update(String id, SignatureRequest signatureRequest) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/signatureRequest/$id', data: signatureRequest.toJson());
      return SignatureRequest.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/signatureRequest/$id');
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