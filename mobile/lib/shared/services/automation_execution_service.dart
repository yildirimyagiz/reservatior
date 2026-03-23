import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AutomationExecutionService {
  final DioClient _dioClient;

  AutomationExecutionService(this._dioClient);

  // Get AutomationExecution by ID
  Future<AutomationExecution> getAutomationExecutionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/automation_execution/$id');
      return AutomationExecution.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all automation_executions
  Future<List<AutomationExecution>> getAutomationExecutions({
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

      final response = await _dioClient.get('/api/v1/automation_execution', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AutomationExecution.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AutomationExecution
  Future<AutomationExecution> createAutomationExecution(AutomationExecution automationExecution) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/automation_execution',
        data: automationExecution.toJson(),
      );
      return AutomationExecution.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AutomationExecution
  Future<AutomationExecution> updateAutomationExecution(String id, AutomationExecution automationExecution) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/automation_execution/$id',
        data: automationExecution.toJson(),
      );
      return AutomationExecution.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AutomationExecution
  Future<void> deleteAutomationExecution(String id) async {
    try {
      await _dioClient.delete('/api/v1/automation_execution/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
