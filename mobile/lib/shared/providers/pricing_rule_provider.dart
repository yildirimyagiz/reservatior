import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/pricing_rule_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PricingRule Providers

final PricingRuleServiceProvider = Provider<PricingRuleService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PricingRuleService(dioClient);
});

// List Provider
final pricingRuleProvider = FutureProvider.autoDispose<List<PricingRule>>((ref) async {
  final service = ref.watch(PricingRuleServiceProvider);
  return service.getPricingRules();
});

// Create Provider
final PricingRuleCreateProvider = FutureProvider.autoDispose<PricingRule>((ref) async {
  final service = ref.watch(PricingRuleServiceProvider);
  return service.createPricingRule(PricingRule());
});

// Update Provider  
final PricingRuleUpdateProvider = FutureProvider.autoDispose<PricingRule>((ref) async {
  final service = ref.watch(PricingRuleServiceProvider);
  final state = ref.watch(PricingRuleUpdateStateProvider);
  if (state['id'] != null && state['pricing_rule'] != null) {
    return service.updatePricingRule(state['id'], state['pricing_rule']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PricingRuleDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PricingRuleServiceProvider);
  final state = ref.watch(PricingRuleDeleteStateProvider);
  if (state != null) {
    return service.deletePricingRule(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PricingRuleUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PricingRuleDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PricingRuleLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(pricingRuleProvider);
  final createAsync = ref.watch(PricingRuleCreateProvider);
  final updateAsync = ref.watch(PricingRuleUpdateProvider);
  final deleteAsync = ref.watch(PricingRuleDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
