import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/budget_service.dart';
import 'package:reservatior/shared/repositories/budget_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final budgetServiceProvider = Provider<BudgetService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BudgetService(dioClient);
});

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  final service = ref.watch(budgetServiceProvider);
  return BudgetRepositoryImpl(service);
});

final budgetListProvider = FutureProvider.autoDispose<List<Budget>>((ref) async {
  final repository = ref.watch(budgetRepositoryProvider);
  return repository.getAll();
});

final budgetCreateProvider = StateProvider<Budget?>((ref) => null);
final budgetUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final budgetDeleteProvider = StateProvider<String?>((ref) => null);
final budgetLoadingProvider = StateProvider<bool>((ref) => false);
