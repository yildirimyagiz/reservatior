import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class PropertyViewingService {
  final DioClient _dioClient;
  PropertyViewingService(this._dioClient);

  // ── Get by ID ──
  Future<PropertyViewing> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/propertyViewing/$id');
      return PropertyViewing.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<PropertyViewing>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/propertyViewing', queryParameters: q);
      return (r.data['data'] as List).map((j) => PropertyViewing.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<PropertyViewing>> getWithFilters({
    String? viewingType,
    DateTime? scheduledDate,
    int? duration,
    String? attendeeName,
    String? attendeeEmail,
  }) async {
    final filters = <String, dynamic>{};
    if (viewingType != null) filters['viewingType'] = viewingType;
    if (scheduledDate != null) filters['scheduledDate'] = scheduledDate.toIso8601String();
    if (duration != null) filters['duration'] = duration.toString();
    if (attendeeName != null) filters['attendeeName'] = attendeeName;
    if (attendeeEmail != null) filters['attendeeEmail'] = attendeeEmail;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<PropertyViewing> create(PropertyViewing propertyViewing) async {

    try {
      final r = await _dioClient.post('/propertyViewing', data: propertyViewing.toJson());
      return PropertyViewing.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<PropertyViewing> update(String id, PropertyViewing propertyViewing) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/propertyViewing/$id', data: propertyViewing.toJson());
      return PropertyViewing.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/propertyViewing/$id');
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