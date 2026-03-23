import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/budget_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Budget Providers

final BudgetServiceProvider = Provider<BudgetService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BudgetService(dioClient);
});

// List Provider
final budgetProvider = FutureProvider.autoDispose<List<Budget>>((ref) async {
  final service = ref.watch(BudgetServiceProvider);
  return service.getBudgets();
});

// Create Provider
final BudgetCreateProvider = FutureProvider.autoDispose<Budget>((ref) async {
  final service = ref.watch(BudgetServiceProvider);
  return service.createBudget(Budget());
});

// Update Provider  
final BudgetUpdateProvider = FutureProvider.autoDispose<Budget>((ref) async {
  final service = ref.watch(BudgetServiceProvider);
  final state = ref.watch(BudgetUpdateStateProvider);
  if (state['id'] != null && state['budget'] != null) {
    return service.updateBudget(state['id'], state['budget']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final BudgetDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(BudgetServiceProvider);
  final state = ref.watch(BudgetDeleteStateProvider);
  if (state != null) {
    return service.deleteBudget(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final BudgetUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final BudgetDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final BudgetLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(budgetProvider);
  final createAsync = ref.watch(BudgetCreateProvider);
  final updateAsync = ref.watch(BudgetUpdateProvider);
  final deleteAsync = ref.watch(BudgetDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
