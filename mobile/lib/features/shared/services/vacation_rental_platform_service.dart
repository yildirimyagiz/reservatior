import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class VacationRentalPlatformService {
  final DioClient _dioClient;
  VacationRentalPlatformService(this._dioClient);

  // ── Get by ID ──
  Future<VacationRentalPlatform> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/vacationRentalPlatform/$id');
      return VacationRentalPlatform.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<VacationRentalPlatform>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/vacationRentalPlatform', queryParameters: q);
      return (r.data['data'] as List).map((j) => VacationRentalPlatform.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<VacationRentalPlatform>> getWithFilters({
    RentalPlatform? platform,
    String? externalUrl,
    RentalStatus? status,
    DateTime? lastSyncedAt,
    bool? syncEnabled,
  }) async {
    final filters = <String, dynamic>{};
    if (platform != null) filters['platform'] = platform.toString();
    if (externalUrl != null) filters['externalUrl'] = externalUrl;
    if (status != null) filters['status'] = status.toString();
    if (lastSyncedAt != null) filters['lastSyncedAt'] = lastSyncedAt.toIso8601String();
    if (syncEnabled != null) filters['syncEnabled'] = syncEnabled.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<VacationRentalPlatform> create(VacationRentalPlatform vacationRentalPlatform) async {

    try {
      final r = await _dioClient.post('/vacationRentalPlatform', data: vacationRentalPlatform.toJson());
      return VacationRentalPlatform.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<VacationRentalPlatform> update(String id, VacationRentalPlatform vacationRentalPlatform) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/vacationRentalPlatform/$id', data: vacationRentalPlatform.toJson());
      return VacationRentalPlatform.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/vacationRentalPlatform/$id');
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