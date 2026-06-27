import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/automation_rule_service.dart';
import 'package:reservatior/shared/repositories/automation_rule_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final automationRuleServiceProvider = Provider<AutomationRuleService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AutomationRuleService(dioClient);
});

final automationRuleRepositoryProvider = Provider<AutomationRuleRepository>((ref) {
  final service = ref.watch(automationRuleServiceProvider);
  return AutomationRuleRepositoryImpl(service);
});

final automationRuleListProvider = FutureProvider.autoDispose<List<AutomationRule>>((ref) async {
  final repository = ref.watch(automationRuleRepositoryProvider);
  return repository.getAll();
});

final automationRuleCreateProvider = StateProvider<AutomationRule?>((ref) => null);
final automationRuleUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final automationRuleDeleteProvider = StateProvider<String?>((ref) => null);
final automationRuleLoadingProvider = StateProvider<bool>((ref) => false);
