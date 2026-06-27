import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/pricing_rule_service.dart';
import 'package:reservatior/shared/repositories/pricing_rule_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final pricingRuleServiceProvider = Provider<PricingRuleService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PricingRuleService(dioClient);
});

final pricingRuleRepositoryProvider = Provider<PricingRuleRepository>((ref) {
  final service = ref.watch(pricingRuleServiceProvider);
  return PricingRuleRepositoryImpl(service);
});

final pricingRuleListProvider = FutureProvider.autoDispose<List<PricingRule>>((ref) async {
  final repository = ref.watch(pricingRuleRepositoryProvider);
  return repository.getAll();
});

final pricingRuleCreateProvider = StateProvider<PricingRule?>((ref) => null);
final pricingRuleUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final pricingRuleDeleteProvider = StateProvider<String?>((ref) => null);
final pricingRuleLoadingProvider = StateProvider<bool>((ref) => false);
