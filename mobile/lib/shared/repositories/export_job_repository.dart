import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ExportJob operations
/// Provides CRUD operations with proper error handling and type safety
class ExportJobRepository {
  final DioClient _dioClient;

  ExportJobRepository(this._dioClient);

  /// Get ExportJob by ID
  /// Returns [ExportJob] if found, throws [RepositoryException] otherwise
  Future<ExportJob> getExportJobById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/export_job/$id');
      if (response.statusCode == 200) {
        return ExportJob.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch export_job',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all export_jobs with pagination and filtering
  /// Returns list of [ExportJob] objects
  Future<List<ExportJob>> getexport_jobs({
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
      
      final response = await _dioClient.get('/api/v1/export_job', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ExportJob.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch export_jobs',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ExportJob
  /// Returns created [ExportJob] object
  Future<ExportJob> createExportJob(ExportJob exportJob) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/export_job',
        data: exportJob.toJson(),
      );
      return ExportJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ExportJob
  Future<ExportJob> updateExportJob(String id, ExportJob exportJob) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/export_job/$id',
        data: exportJob.toJson(),
      );
      return ExportJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ExportJob
  Future<void> deleteExportJob(String id) async {
    try {
      await _dioClient.delete('/api/v1/export_job/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
