import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/automation_task_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AutomationTask Providers

final automationTaskServiceProvider = Provider<AutomationTaskService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AutomationTaskService(dioClient);
});

// List Provider
final automationTaskListProvider = FutureProvider.autoDispose<List<AutomationTask>>((ref) async {
  final service = ref.watch(automationTaskServiceProvider);
  return service.getAutomationTasks();
});

// Create Provider
final automationTaskCreateProvider = FutureProvider.autoDispose<AutomationTask>((ref) async {
  final service = ref.watch(automationTaskServiceProvider);
  return service.createAutomationTask(AutomationTask());
});

// Update Provider  
final automationTaskUpdateProvider = FutureProvider.autoDispose<AutomationTask>((ref) async {
  final service = ref.watch(automationTaskServiceProvider);
  final state = ref.watch(automationTaskUpdateStateProvider);
  if (state['id'] != null && state['automation_task'] != null) {
    return service.updateAutomationTask(state['id'], state['automation_task']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final automationTaskDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(automationTaskServiceProvider);
  final state = ref.watch(automationTaskDeleteStateProvider);
  if (state != null) {
    return service.deleteAutomationTask(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final automationTaskCreateStateProvider = StateProvider<AutomationTask?>((ref) => null);
final automationTaskUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final automationTaskDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final automationTaskLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(automationTaskListProvider);
  final createAsync = ref.watch(automationTaskCreateProvider);
  final updateAsync = ref.watch(automationTaskUpdateProvider);
  final deleteAsync = ref.watch(automationTaskDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
