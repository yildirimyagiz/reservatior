import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AuditLogService {
  final DioClient _dioClient;
  AuditLogService(this._dioClient);

  Future<AuditLog> getAuditLogById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.auditLogs}/$id');
    return AuditLog.fromJson(response.data['data']);
  }

  Future<List<AuditLog>> getAuditLogs({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.auditLogs, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AuditLog.fromJson(json)).toList();
  }

  Future<AuditLog> createAuditLog(AuditLog item) async {
    final response = await _dioClient.post(ApiEndpoints.auditLogs, data: item.toJson());
    return AuditLog.fromJson(response.data['data']);
  }

  Future<AuditLog> updateAuditLog(String id, AuditLog item) async {
    final response = await _dioClient.patch('${ApiEndpoints.auditLogs}/$id', data: item.toJson());
    return AuditLog.fromJson(response.data['data']);
  }

  Future<void> deleteAuditLog(String id) async {
    await _dioClient.delete('${ApiEndpoints.auditLogs}/$id');
  }
}
