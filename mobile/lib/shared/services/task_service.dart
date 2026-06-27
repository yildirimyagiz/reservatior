import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class TaskService {
  final DioClient _dioClient;
  TaskService(this._dioClient);

  Future<Task> getTaskById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.tasks}/$id');
    return Task.fromJson(response.data['data']);
  }

  Future<List<Task>> getTasks({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.tasks, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Task.fromJson(json)).toList();
  }

  Future<Task> createTask(Task item) async {
    final response = await _dioClient.post(ApiEndpoints.tasks, data: item.toJson());
    return Task.fromJson(response.data['data']);
  }

  Future<Task> updateTask(String id, Task item) async {
    final response = await _dioClient.patch('${ApiEndpoints.tasks}/$id', data: item.toJson());
    return Task.fromJson(response.data['data']);
  }

  Future<void> deleteTask(String id) async {
    await _dioClient.delete('${ApiEndpoints.tasks}/$id');
  }
}
