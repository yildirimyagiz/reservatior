import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AuditLogService {
  final DioClient _dioClient;

  AuditLogService(this._dioClient);

  // Get AuditLog by ID
  Future<AuditLog> getAuditLogById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/audit_log/$id');
      return AuditLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all audit_logs
  Future<List<AuditLog>> getAuditLogs({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/audit_log', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AuditLog.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AuditLog
  Future<AuditLog> createAuditLog(AuditLog auditLog) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/audit_log',
        data: auditLog.toJson(),
      );
      return AuditLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AuditLog
  Future<AuditLog> updateAuditLog(String id, AuditLog auditLog) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/audit_log/$id',
        data: auditLog.toJson(),
      );
      return AuditLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AuditLog
  Future<void> deleteAuditLog(String id) async {
    try {
      await _dioClient.delete('/api/v1/audit_log/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
