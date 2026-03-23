import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/automation_execution_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AutomationExecution Providers

final automationExecutionServiceProvider = Provider<AutomationExecutionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AutomationExecutionService(dioClient);
});

// List Provider
final automationExecutionListProvider = FutureProvider.autoDispose<List<AutomationExecution>>((ref) async {
  final service = ref.watch(automationExecutionServiceProvider);
  return service.getAutomationExecutions();
});

// Create Provider
final automationExecutionCreateProvider = FutureProvider.autoDispose<AutomationExecution>((ref) async {
  final service = ref.watch(automationExecutionServiceProvider);
  return service.createAutomationExecution(AutomationExecution());
});

// Update Provider  
final automationExecutionUpdateProvider = FutureProvider.autoDispose<AutomationExecution>((ref) async {
  final service = ref.watch(automationExecutionServiceProvider);
  final state = ref.watch(automationExecutionUpdateStateProvider);
  if (state['id'] != null && state['automation_execution'] != null) {
    return service.updateAutomationExecution(state['id'], state['automation_execution']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final automationExecutionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(automationExecutionServiceProvider);
  final state = ref.watch(automationExecutionDeleteStateProvider);
  if (state != null) {
    return service.deleteAutomationExecution(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final automationExecutionCreateStateProvider = StateProvider<AutomationExecution?>((ref) => null);
final automationExecutionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final automationExecutionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final automationExecutionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(automationExecutionListProvider);
  final createAsync = ref.watch(automationExecutionCreateProvider);
  final updateAsync = ref.watch(automationExecutionUpdateProvider);
  final deleteAsync = ref.watch(automationExecutionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
