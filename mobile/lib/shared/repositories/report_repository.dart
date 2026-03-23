import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Report operations
/// Provides CRUD operations with proper error handling and type safety
class ReportRepository {
  final DioClient _dioClient;

  ReportRepository(this._dioClient);

  /// Get Report by ID
  /// Returns [Report] if found, throws [RepositoryException] otherwise
  Future<Report> getReportById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/report/$id');
      if (response.statusCode == 200) {
        return Report.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch report',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all reports with pagination and filtering
  /// Returns list of [Report] objects
  Future<List<Report>> getreports({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/report', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Report.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch reports',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Report
  /// Returns created [Report] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
