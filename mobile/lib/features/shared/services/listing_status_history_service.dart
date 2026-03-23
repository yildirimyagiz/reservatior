import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ListingStatusHistoryService {
  final DioClient _dioClient;
  ListingStatusHistoryService(this._dioClient);

  // ── Get by ID ──
  Future<ListingStatusHistory> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/listingStatusHistory/$id');
      return ListingStatusHistory.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<ListingStatusHistory>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/listingStatusHistory', queryParameters: q);
      return (r.data['data'] as List).map((j) => ListingStatusHistory.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<ListingStatusHistory>> getWithFilters({
    ListingStatus? status,
    DateTime? fromDate,
    DateTime? toDate,
    String? reason,
  }) async {
    final filters = <String, dynamic>{};
    if (status != null) filters['status'] = status.toString();
    if (fromDate != null) filters['fromDate'] = fromDate.toIso8601String();
    if (toDate != null) filters['toDate'] = toDate.toIso8601String();
    if (reason != null) filters['reason'] = reason;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<ListingStatusHistory> create(ListingStatusHistory listingStatusHistory) async {

    try {
      final r = await _dioClient.post('/listingStatusHistory', data: listingStatusHistory.toJson());
      return ListingStatusHistory.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<ListingStatusHistory> update(String id, ListingStatusHistory listingStatusHistory) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/listingStatusHistory/$id', data: listingStatusHistory.toJson());
      return ListingStatusHistory.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/listingStatusHistory/$id');
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