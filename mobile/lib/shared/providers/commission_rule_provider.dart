import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/commission_rule_service.dart';
import 'package:reservatior/shared/repositories/commission_rule_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final commissionRuleServiceProvider = Provider<CommissionRuleService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CommissionRuleService(dioClient);
});

final commissionRuleRepositoryProvider = Provider<CommissionRuleRepository>((ref) {
  final service = ref.watch(commissionRuleServiceProvider);
  return CommissionRuleRepositoryImpl(service);
});

final commissionRuleListProvider = FutureProvider.autoDispose<List<CommissionRule>>((ref) async {
  final repository = ref.watch(commissionRuleRepositoryProvider);
  return repository.getAll();
});

final commissionRuleCreateProvider = StateProvider<CommissionRule?>((ref) => null);
final commissionRuleUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final commissionRuleDeleteProvider = StateProvider<String?>((ref) => null);
final commissionRuleLoadingProvider = StateProvider<bool>((ref) => false);
