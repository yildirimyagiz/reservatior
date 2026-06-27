import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/task_service.dart';
import 'package:reservatior/shared/repositories/task_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final taskServiceProvider = Provider<TaskService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TaskService(dioClient);
});

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final service = ref.watch(taskServiceProvider);
  return TaskRepositoryImpl(service);
});

final taskListProvider = FutureProvider.autoDispose<List<Task>>((ref) async {
  final repository = ref.watch(taskRepositoryProvider);
  return repository.getAll();
});

final taskCreateProvider = StateProvider<Task?>((ref) => null);
final taskUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final taskDeleteProvider = StateProvider<String?>((ref) => null);
final taskLoadingProvider = StateProvider<bool>((ref) => false);
