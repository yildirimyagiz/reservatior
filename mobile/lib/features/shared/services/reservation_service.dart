import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ReservationService {
  final DioClient _dioClient;
  ReservationService(this._dioClient);

  // ── Get by ID ──
  Future<Reservation> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/reservation/$id');
      return Reservation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Reservation>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/reservation', queryParameters: q);
      return (r.data['data'] as List).map((j) => Reservation.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Reservation>> getWithFilters({
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? guestCount,
    String? specialRequests,
    double? nightlyRate,
  }) async {
    final filters = <String, dynamic>{};
    if (checkInDate != null) filters['checkInDate'] = checkInDate.toIso8601String();
    if (checkOutDate != null) filters['checkOutDate'] = checkOutDate.toIso8601String();
    if (guestCount != null) filters['guestCount'] = guestCount.toString();
    if (specialRequests != null) filters['specialRequests'] = specialRequests;
    if (nightlyRate != null) filters['nightlyRate'] = nightlyRate.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Reservation> create(Reservation reservation) async {

    try {
      final r = await _dioClient.post('/reservation', data: reservation.toJson());
      return Reservation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Reservation> update(String id, Reservation reservation) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/reservation/$id', data: reservation.toJson());
      return Reservation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/reservation/$id');
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