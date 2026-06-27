import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/features/client/task/data/models/task_model.dart';
import 'package:reservatior/features/client/task/data/services/task_service.dart';

final taskServiceProvider = Provider((ref) {
  return TaskService(DioClient());
});

final taskProvider = StateNotifierProvider<TaskNotifier, AsyncValue<List<TaskModel>>>((ref) {
  return TaskNotifier(ref.watch(taskServiceProvider));
});

class TaskNotifier extends StateNotifier<AsyncValue<List<TaskModel>>> {
  final TaskService _service;

  TaskNotifier(this._service) : super(const AsyncValue.loading()) {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    state = const AsyncValue.loading();
    try {
      final tasks = await _service.getTasks();
      state = AsyncValue.data(tasks);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createTask(String title, String description, String type, String priority) async {
    try {
      await _service.createTask(title, description, type, priority);
      await fetchTasks();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _service.deleteTask(id);
      await fetchTasks();
    } catch (e) {
      rethrow;
    }
  }
}
