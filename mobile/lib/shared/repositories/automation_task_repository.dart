import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AutomationTask operations
/// Provides CRUD operations with proper error handling and type safety
class AutomationTaskRepository {
  final DioClient _dioClient;

  AutomationTaskRepository(this._dioClient);

  /// Get AutomationTask by ID
  /// Returns [AutomationTask] if found, throws [RepositoryException] otherwise
  Future<AutomationTask> getAutomationTaskById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/automation_task/$id');
      if (response.statusCode == 200) {
        return AutomationTask.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch automation_task',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all automation_tasks with pagination and filtering
  /// Returns list of [AutomationTask] objects
  Future<List<AutomationTask>> getautomation_tasks({
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
      
      final response = await _dioClient.get('/api/v1/automation_task', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AutomationTask.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch automation_tasks',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AutomationTask
  /// Returns created [AutomationTask] object
  Future<AutomationTask> createAutomationTask(AutomationTask automationTask) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/automation_task',
        data: automationTask.toJson(),
      );
      return AutomationTask.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AutomationTask
  Future<AutomationTask> updateAutomationTask(String id, AutomationTask automationTask) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/automation_task/$id',
        data: automationTask.toJson(),
      );
      return AutomationTask.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AutomationTask
  Future<void> deleteAutomationTask(String id) async {
    try {
      await _dioClient.delete('/api/v1/automation_task/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
