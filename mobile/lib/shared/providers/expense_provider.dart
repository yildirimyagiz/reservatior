import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/expense_service.dart';
import 'package:reservatior/shared/repositories/expense_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final expenseServiceProvider = Provider<ExpenseService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExpenseService(dioClient);
});

final expenseRepositoryProvider = Provider<ExpenseRepository>((ref) {
  final service = ref.watch(expenseServiceProvider);
  return ExpenseRepositoryImpl(service);
});

final expenseListProvider = FutureProvider.autoDispose<List<Expense>>((ref) async {
  final repository = ref.watch(expenseRepositoryProvider);
  return repository.getAll();
});

final expenseCreateProvider = StateProvider<Expense?>((ref) => null);
final expenseUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final expenseDeleteProvider = StateProvider<String?>((ref) => null);
final expenseLoadingProvider = StateProvider<bool>((ref) => false);
