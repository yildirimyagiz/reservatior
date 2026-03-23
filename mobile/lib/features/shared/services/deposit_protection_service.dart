import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class DepositProtectionService {
  final DioClient _dioClient;
  DepositProtectionService(this._dioClient);

  // ── Get by ID ──
  Future<DepositProtection> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/depositProtection/$id');
      return DepositProtection.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<DepositProtection>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/depositProtection', queryParameters: q);
      return (r.data['data'] as List).map((j) => DepositProtection.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<DepositProtection>> getWithFilters({
    String? provider,
    String? scheme,
    String? reference,
    double? amount,
    String? currency,
  }) async {
    final filters = <String, dynamic>{};
    if (provider != null) filters['provider'] = provider;
    if (scheme != null) filters['scheme'] = scheme;
    if (reference != null) filters['reference'] = reference;
    if (amount != null) filters['amount'] = amount.toString();
    if (currency != null) filters['currency'] = currency;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<DepositProtection> create(DepositProtection depositProtection) async {

    try {
      final r = await _dioClient.post('/depositProtection', data: depositProtection.toJson());
      return DepositProtection.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<DepositProtection> update(String id, DepositProtection depositProtection) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/depositProtection/$id', data: depositProtection.toJson());
      return DepositProtection.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/depositProtection/$id');
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