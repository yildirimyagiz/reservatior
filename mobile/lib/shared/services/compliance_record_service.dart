import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ComplianceRecordService {
  final DioClient _dioClient;

  ComplianceRecordService(this._dioClient);

  // Get ComplianceRecord by ID
  Future<ComplianceRecord> getComplianceRecordById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/compliance_record/$id');
      return ComplianceRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all compliance_records
  Future<List<ComplianceRecord>> getComplianceRecords({
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

      final response = await _dioClient.get('/api/v1/compliance_record', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ComplianceRecord.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ComplianceRecord
  Future<ComplianceRecord> createComplianceRecord(ComplianceRecord complianceRecord) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/compliance_record',
        data: complianceRecord.toJson(),
      );
      return ComplianceRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ComplianceRecord
  Future<ComplianceRecord> updateComplianceRecord(String id, ComplianceRecord complianceRecord) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/compliance_record/$id',
        data: complianceRecord.toJson(),
      );
      return ComplianceRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ComplianceRecord
  Future<void> deleteComplianceRecord(String id) async {
    try {
      await _dioClient.delete('/api/v1/compliance_record/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
