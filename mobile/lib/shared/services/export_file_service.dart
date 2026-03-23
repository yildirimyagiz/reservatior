import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ExportFileService {
  final DioClient _dioClient;

  ExportFileService(this._dioClient);

  // Get ExportFile by ID
  Future<ExportFile> getExportFileById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/export_file/$id');
      return ExportFile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all export_files
  Future<List<ExportFile>> getExportFiles({
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

      final response = await _dioClient.get('/api/v1/export_file', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ExportFile.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ExportFile
  Future<ExportFile> createExportFile(ExportFile exportFile) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/export_file',
        data: exportFile.toJson(),
      );
      return ExportFile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ExportFile
  Future<ExportFile> updateExportFile(String id, ExportFile exportFile) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/export_file/$id',
        data: exportFile.toJson(),
      );
      return ExportFile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ExportFile
  Future<void> deleteExportFile(String id) async {
    try {
      await _dioClient.delete('/api/v1/export_file/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
