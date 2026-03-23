import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/automation_rule_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AutomationRule Providers

final automationRuleServiceProvider = Provider<AutomationRuleService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AutomationRuleService(dioClient);
});

// List Provider
final automationRuleListProvider = FutureProvider.autoDispose<List<AutomationRule>>((ref) async {
  final service = ref.watch(automationRuleServiceProvider);
  return service.getAutomationRules();
});

// Create Provider
final automationRuleCreateProvider = FutureProvider.autoDispose<AutomationRule>((ref) async {
  final service = ref.watch(automationRuleServiceProvider);
  return service.createAutomationRule(AutomationRule());
});

// Update Provider  
final automationRuleUpdateProvider = FutureProvider.autoDispose<AutomationRule>((ref) async {
  final service = ref.watch(automationRuleServiceProvider);
  final state = ref.watch(automationRuleUpdateStateProvider);
  if (state['id'] != null && state['automation_rule'] != null) {
    return service.updateAutomationRule(state['id'], state['automation_rule']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final automationRuleDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(automationRuleServiceProvider);
  final state = ref.watch(automationRuleDeleteStateProvider);
  if (state != null) {
    return service.deleteAutomationRule(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final automationRuleCreateStateProvider = StateProvider<AutomationRule?>((ref) => null);
final automationRuleUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final automationRuleDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final automationRuleLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(automationRuleListProvider);
  final createAsync = ref.watch(automationRuleCreateProvider);
  final updateAsync = ref.watch(automationRuleUpdateProvider);
  final deleteAsync = ref.watch(automationRuleDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
