import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class TaskService {
  final DioClient _dioClient;

  TaskService(this._dioClient);

  // Get Task by ID
  Future<Task> getTaskById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/task/$id');
      return Task.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all tasks
  Future<List<Task>> getTasks({
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

      final response = await _dioClient.get('/api/v1/task', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Task.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Task
  Future<Task> createTask(Task task) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/task',
        data: task.toJson(),
      );
      return Task.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Task
  Future<Task> updateTask(String id, Task task) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/task/$id',
        data: task.toJson(),
      );
      return Task.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Task
  Future<void> deleteTask(String id) async {
    try {
      await _dioClient.delete('/api/v1/task/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
