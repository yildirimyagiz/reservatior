import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class EventAttendeeService {
  final DioClient _dioClient;
  EventAttendeeService(this._dioClient);

  // ── Get by ID ──
  Future<EventAttendee> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/eventAttendee/$id');
      return EventAttendee.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<EventAttendee>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/eventAttendee', queryParameters: q);
      return (r.data['data'] as List).map((j) => EventAttendee.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<EventAttendee>> getWithFilters({
    String? rsvpStatus,
    String? notes,
  }) async {
    final filters = <String, dynamic>{};
    if (rsvpStatus != null) filters['rsvpStatus'] = rsvpStatus;
    if (notes != null) filters['notes'] = notes;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<EventAttendee> create(EventAttendee eventAttendee) async {

    try {
      final r = await _dioClient.post('/eventAttendee', data: eventAttendee.toJson());
      return EventAttendee.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<EventAttendee> update(String id, EventAttendee eventAttendee) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/eventAttendee/$id', data: eventAttendee.toJson());
      return EventAttendee.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/eventAttendee/$id');
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