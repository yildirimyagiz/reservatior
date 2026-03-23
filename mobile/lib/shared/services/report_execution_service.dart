import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ReportExecutionService {
  final DioClient _dioClient;

  ReportExecutionService(this._dioClient);

  // Get ReportExecution by ID
  Future<ReportExecution> getReportExecutionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/report_execution/$id');
      return ReportExecution.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all report_executions
  Future<List<ReportExecution>> getReportExecutions({
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

      final response = await _dioClient.get('/api/v1/report_execution', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ReportExecution.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ReportExecution
  Future<ReportExecution> createReportExecution(ReportExecution reportExecution) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/report_execution',
        data: reportExecution.toJson(),
      );
      return ReportExecution.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ReportExecution
  Future<ReportExecution> updateReportExecution(String id, ReportExecution reportExecution) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/report_execution/$id',
        data: reportExecution.toJson(),
      );
      return ReportExecution.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ReportExecution
  Future<void> deleteReportExecution(String id) async {
    try {
      await _dioClient.delete('/api/v1/report_execution/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
