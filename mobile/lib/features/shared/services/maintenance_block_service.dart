import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MaintenanceBlockService {
  final DioClient _dioClient;
  MaintenanceBlockService(this._dioClient);

  // ── Get by ID ──
  Future<MaintenanceBlock> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/maintenanceBlock/$id');
      return MaintenanceBlock.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MaintenanceBlock>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/maintenanceBlock', queryParameters: q);
      return (r.data['data'] as List).map((j) => MaintenanceBlock.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MaintenanceBlock>> getWithFilters({
    MaintenanceBlockType? type,
    DateTime? startDate,
    DateTime? endDate,
    String? reason,
  }) async {
    final filters = <String, dynamic>{};
    if (type != null) filters['type'] = type.toString();
    if (startDate != null) filters['startDate'] = startDate.toIso8601String();
    if (endDate != null) filters['endDate'] = endDate.toIso8601String();
    if (reason != null) filters['reason'] = reason;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MaintenanceBlock> create(MaintenanceBlock maintenanceBlock) async {
    if (maintenanceBlock.type == null || maintenanceBlock.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    try {
      final r = await _dioClient.post('/maintenanceBlock', data: maintenanceBlock.toJson());
      return MaintenanceBlock.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MaintenanceBlock> update(String id, MaintenanceBlock maintenanceBlock) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/maintenanceBlock/$id', data: maintenanceBlock.toJson());
      return MaintenanceBlock.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/maintenanceBlock/$id');
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