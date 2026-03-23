import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class DealService {
  final DioClient _dioClient;
  DealService(this._dioClient);

  // ── Get by ID ──
  Future<Deal> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/deal/$id');
      return Deal.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Deal>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/deal', queryParameters: q);
      return (r.data['data'] as List).map((j) => Deal.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Deal>> getWithFilters({
    DealStatusUSA? dealStatus,
    String? dealType,
    double? offerPrice,
    double? listPrice,
    double? salePrice,
  }) async {
    final filters = <String, dynamic>{};
    if (dealStatus != null) filters['dealStatus'] = dealStatus.toString();
    if (dealType != null) filters['dealType'] = dealType;
    if (offerPrice != null) filters['offerPrice'] = offerPrice.toString();
    if (listPrice != null) filters['listPrice'] = listPrice.toString();
    if (salePrice != null) filters['salePrice'] = salePrice.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Deal> create(Deal deal) async {

    try {
      final r = await _dioClient.post('/deal', data: deal.toJson());
      return Deal.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Deal> update(String id, Deal deal) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/deal/$id', data: deal.toJson());
      return Deal.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/deal/$id');
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