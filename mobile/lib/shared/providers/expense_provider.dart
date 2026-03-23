import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/expense_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Expense Providers

final ExpenseServiceProvider = Provider<ExpenseService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExpenseService(dioClient);
});

// List Provider
final expenseProvider = FutureProvider.autoDispose<List<Expense>>((ref) async {
  final service = ref.watch(ExpenseServiceProvider);
  return service.getExpenses();
});

// Create Provider
final ExpenseCreateProvider = FutureProvider.autoDispose<Expense>((ref) async {
  final service = ref.watch(ExpenseServiceProvider);
  return service.createExpense(Expense());
});

// Update Provider  
final ExpenseUpdateProvider = FutureProvider.autoDispose<Expense>((ref) async {
  final service = ref.watch(ExpenseServiceProvider);
  final state = ref.watch(ExpenseUpdateStateProvider);
  if (state['id'] != null && state['expense'] != null) {
    return service.updateExpense(state['id'], state['expense']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ExpenseDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ExpenseServiceProvider);
  final state = ref.watch(ExpenseDeleteStateProvider);
  if (state != null) {
    return service.deleteExpense(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ExpenseUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ExpenseDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ExpenseLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(expenseProvider);
  final createAsync = ref.watch(ExpenseCreateProvider);
  final updateAsync = ref.watch(ExpenseUpdateProvider);
  final deleteAsync = ref.watch(ExpenseDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
