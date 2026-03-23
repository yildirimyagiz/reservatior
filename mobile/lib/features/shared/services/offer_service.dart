import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class OfferService {
  final DioClient _dioClient;
  OfferService(this._dioClient);

  // ── Get by ID ──
  Future<Offer> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/offer/$id');
      return Offer.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Offer>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/offer', queryParameters: q);
      return (r.data['data'] as List).map((j) => Offer.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Offer>> getWithFilters({
    OfferType? offerType,
    OfferStatus? status,
    double? basePrice,
    double? discountRate,
    double? finalPrice,
  }) async {
    final filters = <String, dynamic>{};
    if (offerType != null) filters['offerType'] = offerType.toString();
    if (status != null) filters['status'] = status.toString();
    if (basePrice != null) filters['basePrice'] = basePrice.toString();
    if (discountRate != null) filters['discountRate'] = discountRate.toString();
    if (finalPrice != null) filters['finalPrice'] = finalPrice.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Offer> create(Offer offer) async {

    try {
      final r = await _dioClient.post('/offer', data: offer.toJson());
      return Offer.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Offer> update(String id, Offer offer) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/offer/$id', data: offer.toJson());
      return Offer.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/offer/$id');
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