import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class GiftCardService {
  final DioClient _dioClient;
  GiftCardService(this._dioClient);

  // ── Get by ID ──
  Future<GiftCard> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/giftCard/$id');
      return GiftCard.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<GiftCard>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/giftCard', queryParameters: q);
      return (r.data['data'] as List).map((j) => GiftCard.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<GiftCard>> getWithFilters({
    String? code,
    double? amount,
    double? balance,
    String? currency,
    DateTime? expiresAt,
  }) async {
    final filters = <String, dynamic>{};
    if (code != null) filters['code'] = code;
    if (amount != null) filters['amount'] = amount.toString();
    if (balance != null) filters['balance'] = balance.toString();
    if (currency != null) filters['currency'] = currency;
    if (expiresAt != null) filters['expiresAt'] = expiresAt.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<GiftCard> create(GiftCard giftCard) async {

    try {
      final r = await _dioClient.post('/giftCard', data: giftCard.toJson());
      return GiftCard.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<GiftCard> update(String id, GiftCard giftCard) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/giftCard/$id', data: giftCard.toJson());
      return GiftCard.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/giftCard/$id');
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