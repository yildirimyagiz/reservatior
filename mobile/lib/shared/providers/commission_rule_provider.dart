import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/commission_rule_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// CommissionRule Providers

final CommissionRuleServiceProvider = Provider<CommissionRuleService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CommissionRuleService(dioClient);
});

// List Provider
final commissionRuleProvider = FutureProvider.autoDispose<List<CommissionRule>>((ref) async {
  final service = ref.watch(CommissionRuleServiceProvider);
  return service.getCommissionRules();
});

// Create Provider
final CommissionRuleCreateProvider = FutureProvider.autoDispose<CommissionRule>((ref) async {
  final service = ref.watch(CommissionRuleServiceProvider);
  return service.createCommissionRule(CommissionRule());
});

// Update Provider  
final CommissionRuleUpdateProvider = FutureProvider.autoDispose<CommissionRule>((ref) async {
  final service = ref.watch(CommissionRuleServiceProvider);
  final state = ref.watch(CommissionRuleUpdateStateProvider);
  if (state['id'] != null && state['commission_rule'] != null) {
    return service.updateCommissionRule(state['id'], state['commission_rule']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final CommissionRuleDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(CommissionRuleServiceProvider);
  final state = ref.watch(CommissionRuleDeleteStateProvider);
  if (state != null) {
    return service.deleteCommissionRule(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final CommissionRuleUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final CommissionRuleDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final CommissionRuleLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(commissionRuleProvider);
  final createAsync = ref.watch(CommissionRuleCreateProvider);
  final updateAsync = ref.watch(CommissionRuleUpdateProvider);
  final deleteAsync = ref.watch(CommissionRuleDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
