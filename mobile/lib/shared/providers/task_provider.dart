import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/task_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Task Providers

final TaskServiceProvider = Provider<TaskService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TaskService(dioClient);
});

// List Provider
final taskProvider = FutureProvider.autoDispose<List<Task>>((ref) async {
  final service = ref.watch(TaskServiceProvider);
  return service.getTasks();
});

// Create Provider
final TaskCreateProvider = FutureProvider.autoDispose<Task>((ref) async {
  final service = ref.watch(TaskServiceProvider);
  return service.createTask(Task());
});

// Update Provider  
final TaskUpdateProvider = FutureProvider.autoDispose<Task>((ref) async {
  final service = ref.watch(TaskServiceProvider);
  final state = ref.watch(TaskUpdateStateProvider);
  if (state['id'] != null && state['task'] != null) {
    return service.updateTask(state['id'], state['task']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final TaskDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(TaskServiceProvider);
  final state = ref.watch(TaskDeleteStateProvider);
  if (state != null) {
    return service.deleteTask(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final TaskUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final TaskDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final TaskLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(taskProvider);
  final createAsync = ref.watch(TaskCreateProvider);
  final updateAsync = ref.watch(TaskUpdateProvider);
  final deleteAsync = ref.watch(TaskDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
