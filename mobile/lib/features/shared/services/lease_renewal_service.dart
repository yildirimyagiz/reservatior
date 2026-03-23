import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class LeaseRenewalService {
  final DioClient _dioClient;
  LeaseRenewalService(this._dioClient);

  // ── Get by ID ──
  Future<LeaseRenewal> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/leaseRenewal/$id');
      return LeaseRenewal.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<LeaseRenewal>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/leaseRenewal', queryParameters: q);
      return (r.data['data'] as List).map((j) => LeaseRenewal.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<LeaseRenewal>> getWithFilters({
    RenewalStatus? status,
    double? proposedRent,
    dynamic? proposedTerms,
    DateTime? renewalDate,
    DateTime? responseDeadline,
  }) async {
    final filters = <String, dynamic>{};
    if (status != null) filters['status'] = status.toString();
    if (proposedRent != null) filters['proposedRent'] = proposedRent.toString();
    if (proposedTerms != null) filters['proposedTerms'] = proposedTerms.toString();
    if (renewalDate != null) filters['renewalDate'] = renewalDate.toIso8601String();
    if (responseDeadline != null) filters['responseDeadline'] = responseDeadline.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<LeaseRenewal> create(LeaseRenewal leaseRenewal) async {

    try {
      final r = await _dioClient.post('/leaseRenewal', data: leaseRenewal.toJson());
      return LeaseRenewal.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<LeaseRenewal> update(String id, LeaseRenewal leaseRenewal) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/leaseRenewal/$id', data: leaseRenewal.toJson());
      return LeaseRenewal.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/leaseRenewal/$id');
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