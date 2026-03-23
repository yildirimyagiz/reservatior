import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AmbassadorContractService {
  final DioClient _dioClient;
  AmbassadorContractService(this._dioClient);

  // ── Get by ID ──
  Future<AmbassadorContract> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/ambassadorContract/$id');
      return AmbassadorContract.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AmbassadorContract>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/ambassadorContract', queryParameters: q);
      return (r.data['data'] as List).map((j) => AmbassadorContract.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AmbassadorContract>> getWithFilters({
    int? version,
    double? equityPercent,
    double? upfrontFee,
    String? currency,
    DateTime? startDate,
  }) async {
    final filters = <String, dynamic>{};
    if (version != null) filters['version'] = version.toString();
    if (equityPercent != null) filters['equityPercent'] = equityPercent.toString();
    if (upfrontFee != null) filters['upfrontFee'] = upfrontFee.toString();
    if (currency != null) filters['currency'] = currency;
    if (startDate != null) filters['startDate'] = startDate.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AmbassadorContract> create(AmbassadorContract ambassadorContract) async {

    try {
      final r = await _dioClient.post('/ambassadorContract', data: ambassadorContract.toJson());
      return AmbassadorContract.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AmbassadorContract> update(String id, AmbassadorContract ambassadorContract) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/ambassadorContract/$id', data: ambassadorContract.toJson());
      return AmbassadorContract.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/ambassadorContract/$id');
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