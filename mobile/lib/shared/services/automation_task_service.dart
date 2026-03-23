import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AutomationTaskService {
  final DioClient _dioClient;

  AutomationTaskService(this._dioClient);

  // Get AutomationTask by ID
  Future<AutomationTask> getAutomationTaskById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/automation_task/$id');
      return AutomationTask.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all automation_tasks
  Future<List<AutomationTask>> getAutomationTasks({
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

      final response = await _dioClient.get('/api/v1/automation_task', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AutomationTask.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AutomationTask
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
    return Exception('API Error: ${e.message}');
  }
}
