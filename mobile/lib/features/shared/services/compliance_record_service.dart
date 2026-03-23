import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ComplianceRecordService {
  final DioClient _dioClient;
  ComplianceRecordService(this._dioClient);

  // ── Get by ID ──
  Future<ComplianceRecord> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/complianceRecord/$id');
      return ComplianceRecord.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<ComplianceRecord>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/complianceRecord', queryParameters: q);
      return (r.data['data'] as List).map((j) => ComplianceRecord.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<ComplianceRecord>> getWithFilters({
    String? entityType,
    ComplianceType? type,
    ComplianceStatus? status,
    String? documentUrl,
    DateTime? expiryDate,
  }) async {
    final filters = <String, dynamic>{};
    if (entityType != null) filters['entityType'] = entityType;
    if (type != null) filters['type'] = type.toString();
    if (status != null) filters['status'] = status.toString();
    if (documentUrl != null) filters['documentUrl'] = documentUrl;
    if (expiryDate != null) filters['expiryDate'] = expiryDate.toIso8601String();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<ComplianceRecord> create(ComplianceRecord complianceRecord) async {
    if (complianceRecord.type == null || complianceRecord.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    try {
      final r = await _dioClient.post('/complianceRecord', data: complianceRecord.toJson());
      return ComplianceRecord.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<ComplianceRecord> update(String id, ComplianceRecord complianceRecord) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/complianceRecord/$id', data: complianceRecord.toJson());
      return ComplianceRecord.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/complianceRecord/$id');
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