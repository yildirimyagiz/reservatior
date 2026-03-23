import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ExportFile operations
/// Provides CRUD operations with proper error handling and type safety
class ExportFileRepository {
  final DioClient _dioClient;

  ExportFileRepository(this._dioClient);

  /// Get ExportFile by ID
  /// Returns [ExportFile] if found, throws [RepositoryException] otherwise
  Future<ExportFile> getExportFileById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/export_file/$id');
      if (response.statusCode == 200) {
        return ExportFile.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch export_file',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all export_files with pagination and filtering
  /// Returns list of [ExportFile] objects
  Future<List<ExportFile>> getexport_files({
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
      
      final response = await _dioClient.get('/api/v1/export_file', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ExportFile.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch export_files',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ExportFile
  /// Returns created [ExportFile] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
