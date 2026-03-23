import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class OfflineSyncQueueService {
  final DioClient _dioClient;
  OfflineSyncQueueService(this._dioClient);

  // ── Get by ID ──
  Future<OfflineSyncQueue> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/offlineSyncQueue/$id');
      return OfflineSyncQueue.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<OfflineSyncQueue>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/offlineSyncQueue', queryParameters: q);
      return (r.data['data'] as List).map((j) => OfflineSyncQueue.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<OfflineSyncQueue>> getWithFilters({
    String? entityType,
    String? operation,
    dynamic? data,
    int? version,
    String? syncStatus,
  }) async {
    final filters = <String, dynamic>{};
    if (entityType != null) filters['entityType'] = entityType;
    if (operation != null) filters['operation'] = operation;
    if (data != null) filters['data'] = data.toString();
    if (version != null) filters['version'] = version.toString();
    if (syncStatus != null) filters['syncStatus'] = syncStatus;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<OfflineSyncQueue> create(OfflineSyncQueue offlineSyncQueue) async {

    try {
      final r = await _dioClient.post('/offlineSyncQueue', data: offlineSyncQueue.toJson());
      return OfflineSyncQueue.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<OfflineSyncQueue> update(String id, OfflineSyncQueue offlineSyncQueue) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/offlineSyncQueue/$id', data: offlineSyncQueue.toJson());
      return OfflineSyncQueue.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/offlineSyncQueue/$id');
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