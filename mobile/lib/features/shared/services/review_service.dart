import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ReviewService {
  final DioClient _dioClient;
  ReviewService(this._dioClient);

  // ── Get by ID ──
  Future<Review> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/review/$id');
      return Review.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Review>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/review', queryParameters: q);
      return (r.data['data'] as List).map((j) => Review.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Review>> getWithFilters({
    String? targetType,
    int? rating,
    String? title,
    String? comment,
    bool? isVerified,
  }) async {
    final filters = <String, dynamic>{};
    if (targetType != null) filters['targetType'] = targetType;
    if (rating != null) filters['rating'] = rating.toString();
    if (title != null) filters['title'] = title;
    if (comment != null) filters['comment'] = comment;
    if (isVerified != null) filters['isVerified'] = isVerified.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Review> create(Review review) async {
    if (review.title == null || review.title!.isEmpty) {
      throw ArgumentError('title is required');
    }
    try {
      final r = await _dioClient.post('/review', data: review.toJson());
      return Review.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Review> update(String id, Review review) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/review/$id', data: review.toJson());
      return Review.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/review/$id');
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