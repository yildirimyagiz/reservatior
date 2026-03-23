import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ListingChannelService {
  final DioClient _dioClient;
  ListingChannelService(this._dioClient);

  // ── Get by ID ──
  Future<ListingChannel> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/listingChannel/$id');
      return ListingChannel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<ListingChannel>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/listingChannel', queryParameters: q);
      return (r.data['data'] as List).map((j) => ListingChannel.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<ListingChannel>> getWithFilters({
    ListingChannelType? channel,
    String? status,
    DateTime? lastSync,
  }) async {
    final filters = <String, dynamic>{};
    if (channel != null) filters['channel'] = channel.toString();
    if (status != null) filters['status'] = status;
    if (lastSync != null) filters['lastSync'] = lastSync.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<ListingChannel> create(ListingChannel listingChannel) async {

    try {
      final r = await _dioClient.post('/listingChannel', data: listingChannel.toJson());
      return ListingChannel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<ListingChannel> update(String id, ListingChannel listingChannel) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/listingChannel/$id', data: listingChannel.toJson());
      return ListingChannel.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/listingChannel/$id');
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