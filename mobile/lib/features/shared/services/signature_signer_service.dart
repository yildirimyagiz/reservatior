import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class SignatureSignerService {
  final DioClient _dioClient;
  SignatureSignerService(this._dioClient);

  // ── Get by ID ──
  Future<SignatureSigner> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/signatureSigner/$id');
      return SignatureSigner.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<SignatureSigner>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/signatureSigner', queryParameters: q);
      return (r.data['data'] as List).map((j) => SignatureSigner.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<SignatureSigner>> getWithFilters({
    MessageParticipantType? participantType,
    String? fullName,
    String? email,
    SignatureStatus? status,
    DateTime? signedAt,
  }) async {
    final filters = <String, dynamic>{};
    if (participantType != null) filters['participantType'] = participantType.toString();
    if (fullName != null) filters['fullName'] = fullName;
    if (email != null) filters['email'] = email;
    if (status != null) filters['status'] = status.toString();
    if (signedAt != null) filters['signedAt'] = signedAt.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<SignatureSigner> create(SignatureSigner signatureSigner) async {
    if (signatureSigner.email == null || signatureSigner.email!.isEmpty) {
      throw ArgumentError('email is required');
    }
    try {
      final r = await _dioClient.post('/signatureSigner', data: signatureSigner.toJson());
      return SignatureSigner.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<SignatureSigner> update(String id, SignatureSigner signatureSigner) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/signatureSigner/$id', data: signatureSigner.toJson());
      return SignatureSigner.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/signatureSigner/$id');
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