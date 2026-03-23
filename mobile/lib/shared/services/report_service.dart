import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ReportService {
  final DioClient _dioClient;

  ReportService(this._dioClient);

  // Get Report by ID
  Future<Report> getReportById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/report/$id');
      return Report.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all reports
  Future<List<Report>> getReports({
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

      final response = await _dioClient.get('/api/v1/report', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Report.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Report
  Future<Report> createReport(Report report) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/report',
        data: report.toJson(),
      );
      return Report.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Report
  Future<Report> updateReport(String id, Report report) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/report/$id',
        data: report.toJson(),
      );
      return Report.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Report
  Future<void> deleteReport(String id) async {
    try {
      await _dioClient.delete('/api/v1/report/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
