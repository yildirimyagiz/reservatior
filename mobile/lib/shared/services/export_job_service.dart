import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ExportJobService {
  final DioClient _dioClient;

  ExportJobService(this._dioClient);

  // Get ExportJob by ID
  Future<ExportJob> getExportJobById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/export_job/$id');
      return ExportJob.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all export_jobs
  Future<List<ExportJob>> getExportJobs({
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

      final response = await _dioClient.get('/api/v1/export_job', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ExportJob.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ExportJob
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
    return Exception('API Error: ${e.message}');
  }
}
