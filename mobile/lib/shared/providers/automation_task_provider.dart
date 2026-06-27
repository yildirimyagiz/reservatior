import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/automation_task_service.dart';
import 'package:reservatior/shared/repositories/automation_task_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final automationTaskServiceProvider = Provider<AutomationTaskService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AutomationTaskService(dioClient);
});

final automationTaskRepositoryProvider = Provider<AutomationTaskRepository>((ref) {
  final service = ref.watch(automationTaskServiceProvider);
  return AutomationTaskRepositoryImpl(service);
});

final automationTaskListProvider = FutureProvider.autoDispose<List<AutomationTask>>((ref) async {
  final repository = ref.watch(automationTaskRepositoryProvider);
  return repository.getAll();
});

final automationTaskCreateProvider = StateProvider<AutomationTask?>((ref) => null);
final automationTaskUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final automationTaskDeleteProvider = StateProvider<String?>((ref) => null);
final automationTaskLoadingProvider = StateProvider<bool>((ref) => false);
