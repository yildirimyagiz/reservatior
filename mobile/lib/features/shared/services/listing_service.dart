import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ListingService {
  final DioClient _dioClient;
  ListingService(this._dioClient);

  // ── Get by ID ──
  Future<Listing> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/listing/$id');
      return Listing.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Listing>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/listing', queryParameters: q);
      return (r.data['data'] as List).map((j) => Listing.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Listing>> getWithFilters({
    ListingType? type,
    ListingStatus? status,
    DateTime? willBeAvailableAt,
    EarningStrategy? strategy,
    String? title,
  }) async {
    final filters = <String, dynamic>{};
    if (type != null) filters['type'] = type.toString();
    if (status != null) filters['status'] = status.toString();
    if (willBeAvailableAt != null) filters['willBeAvailableAt'] = willBeAvailableAt.toIso8601String();
    if (strategy != null) filters['strategy'] = strategy.toString();
    if (title != null) filters['title'] = title;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Listing> create(Listing listing) async {
    if (listing.type == null || listing.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    if (listing.title == null || listing.title!.isEmpty) {
      throw ArgumentError('title is required');
    }
    try {
      final r = await _dioClient.post('/listing', data: listing.toJson());
      return Listing.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Listing> update(String id, Listing listing) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/listing/$id', data: listing.toJson());
      return Listing.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/listing/$id');
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