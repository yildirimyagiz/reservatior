import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AvailabilityService {
  final DioClient _dioClient;
  AvailabilityService(this._dioClient);

  // ── Get by ID ──
  Future<Availability> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/availability/$id');
      return Availability.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Availability>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/availability', queryParameters: q);
      return (r.data['data'] as List).map((j) => Availability.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Availability>> getWithFilters({
    DateTime? date,
    bool? isBlocked,
    bool? isBooked,
    int? totalUnits,
    int? availableUnits,
  }) async {
    final filters = <String, dynamic>{};
    if (date != null) filters['date'] = date.toIso8601String();
    if (isBlocked != null) filters['isBlocked'] = isBlocked.toString();
    if (isBooked != null) filters['isBooked'] = isBooked.toString();
    if (totalUnits != null) filters['totalUnits'] = totalUnits.toString();
    if (availableUnits != null) filters['availableUnits'] = availableUnits.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Availability> create(Availability availability) async {

    try {
      final r = await _dioClient.post('/availability', data: availability.toJson());
      return Availability.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Availability> update(String id, Availability availability) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/availability/$id', data: availability.toJson());
      return Availability.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/availability/$id');
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