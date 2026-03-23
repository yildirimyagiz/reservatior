import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class RentalSyncJobService {
  final DioClient _dioClient;
  RentalSyncJobService(this._dioClient);

  // ── Get by ID ──
  Future<RentalSyncJob> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/rentalSyncJob/$id');
      return RentalSyncJob.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<RentalSyncJob>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/rentalSyncJob', queryParameters: q);
      return (r.data['data'] as List).map((j) => RentalSyncJob.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<RentalSyncJob>> getWithFilters({
    RentalPlatform? platform,
    SyncStatus? status,
    String? jobType,
    SyncDirection? direction,
    DateTime? startedAt,
  }) async {
    final filters = <String, dynamic>{};
    if (platform != null) filters['platform'] = platform.toString();
    if (status != null) filters['status'] = status.toString();
    if (jobType != null) filters['jobType'] = jobType;
    if (direction != null) filters['direction'] = direction.toString();
    if (startedAt != null) filters['startedAt'] = startedAt.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<RentalSyncJob> create(RentalSyncJob rentalSyncJob) async {

    try {
      final r = await _dioClient.post('/rentalSyncJob', data: rentalSyncJob.toJson());
      return RentalSyncJob.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<RentalSyncJob> update(String id, RentalSyncJob rentalSyncJob) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/rentalSyncJob/$id', data: rentalSyncJob.toJson());
      return RentalSyncJob.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/rentalSyncJob/$id');
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