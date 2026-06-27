import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ComplianceRecordService {
  final DioClient _dioClient;
  ComplianceRecordService(this._dioClient);

  Future<ComplianceRecord> getComplianceRecordById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.complianceRecords}/$id');
    return ComplianceRecord.fromJson(response.data['data']);
  }

  Future<List<ComplianceRecord>> getComplianceRecords({
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
    final response = await _dioClient.get(ApiEndpoints.complianceRecords, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ComplianceRecord.fromJson(json)).toList();
  }

  Future<ComplianceRecord> createComplianceRecord(ComplianceRecord item) async {
    final response = await _dioClient.post(ApiEndpoints.complianceRecords, data: item.toJson());
    return ComplianceRecord.fromJson(response.data['data']);
  }

  Future<ComplianceRecord> updateComplianceRecord(String id, ComplianceRecord item) async {
    final response = await _dioClient.patch('${ApiEndpoints.complianceRecords}/$id', data: item.toJson());
    return ComplianceRecord.fromJson(response.data['data']);
  }

  Future<void> deleteComplianceRecord(String id) async {
    await _dioClient.delete('${ApiEndpoints.complianceRecords}/$id');
  }
}
