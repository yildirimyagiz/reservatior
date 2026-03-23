import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class EscrowReleaseService {
  final DioClient _dioClient;
  EscrowReleaseService(this._dioClient);

  // ── Get by ID ──
  Future<EscrowRelease> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/escrowRelease/$id');
      return EscrowRelease.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<EscrowRelease>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/escrowRelease', queryParameters: q);
      return (r.data['data'] as List).map((j) => EscrowRelease.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<EscrowRelease>> getWithFilters({
    EscrowTriggerEvent? triggerEvent,
    double? releasePercent,
    double? amount,
    String? currency,
    EscrowReleaseStatus? status,
  }) async {
    final filters = <String, dynamic>{};
    if (triggerEvent != null) filters['triggerEvent'] = triggerEvent.toString();
    if (releasePercent != null) filters['releasePercent'] = releasePercent.toString();
    if (amount != null) filters['amount'] = amount.toString();
    if (currency != null) filters['currency'] = currency;
    if (status != null) filters['status'] = status.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<EscrowRelease> create(EscrowRelease escrowRelease) async {

    try {
      final r = await _dioClient.post('/escrowRelease', data: escrowRelease.toJson());
      return EscrowRelease.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<EscrowRelease> update(String id, EscrowRelease escrowRelease) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/escrowRelease/$id', data: escrowRelease.toJson());
      return EscrowRelease.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/escrowRelease/$id');
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