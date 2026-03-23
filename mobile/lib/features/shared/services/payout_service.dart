import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class PayoutService {
  final DioClient _dioClient;
  PayoutService(this._dioClient);

  // ── Get by ID ──
  Future<Payout> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/payout/$id');
      return Payout.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Payout>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/payout', queryParameters: q);
      return (r.data['data'] as List).map((j) => Payout.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Payout>> getWithFilters({
    PayoutStatusUSA? payoutStatus,
    CommissionTypeUS? payoutType,
    double? amount,
    double? grossAmount,
    double? netAmount,
  }) async {
    final filters = <String, dynamic>{};
    if (payoutStatus != null) filters['payoutStatus'] = payoutStatus.toString();
    if (payoutType != null) filters['payoutType'] = payoutType.toString();
    if (amount != null) filters['amount'] = amount.toString();
    if (grossAmount != null) filters['grossAmount'] = grossAmount.toString();
    if (netAmount != null) filters['netAmount'] = netAmount.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Payout> create(Payout payout) async {

    try {
      final r = await _dioClient.post('/payout', data: payout.toJson());
      return Payout.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Payout> update(String id, Payout payout) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/payout/$id', data: payout.toJson());
      return Payout.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/payout/$id');
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