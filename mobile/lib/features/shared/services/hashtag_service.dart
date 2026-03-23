import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class HashtagService {
  final DioClient _dioClient;
  HashtagService(this._dioClient);

  // ── Get by ID ──
  Future<Hashtag> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/hashtag/$id');
      return Hashtag.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Hashtag>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/hashtag', queryParameters: q);
      return (r.data['data'] as List).map((j) => Hashtag.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Hashtag>> getWithFilters({
    String? name,
    HashtagType? type,
    String? description,
    int? usageCount,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (type != null) filters['type'] = type.toString();
    if (description != null) filters['description'] = description;
    if (usageCount != null) filters['usageCount'] = usageCount.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Hashtag> create(Hashtag hashtag) async {
    if (hashtag.name == null || hashtag.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    if (hashtag.type == null || hashtag.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    try {
      final r = await _dioClient.post('/hashtag', data: hashtag.toJson());
      return Hashtag.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Hashtag> update(String id, Hashtag hashtag) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/hashtag/$id', data: hashtag.toJson());
      return Hashtag.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/hashtag/$id');
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