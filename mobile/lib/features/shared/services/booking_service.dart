import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class BookingService {
  final DioClient _dioClient;
  BookingService(this._dioClient);

  // ── Get by ID ──
  Future<Booking> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/booking/$id');
      return Booking.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Booking>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/booking', queryParameters: q);
      return (r.data['data'] as List).map((j) => Booking.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Booking>> getWithFilters({
    BookingStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    int? adults,
    int? children,
  }) async {
    final filters = <String, dynamic>{};
    if (status != null) filters['status'] = status.toString();
    if (startDate != null) filters['startDate'] = startDate.toIso8601String();
    if (endDate != null) filters['endDate'] = endDate.toIso8601String();
    if (adults != null) filters['adults'] = adults.toString();
    if (children != null) filters['children'] = children.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Booking> create(Booking booking) async {

    try {
      final r = await _dioClient.post('/booking', data: booking.toJson());
      return Booking.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Booking> update(String id, Booking booking) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/booking/$id', data: booking.toJson());
      return Booking.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/booking/$id');
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