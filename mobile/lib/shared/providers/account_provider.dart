import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/account_service.dart';
import 'package:reservatior/shared/repositories/account_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final accountServiceProvider = Provider<AccountService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AccountService(dioClient);
});

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  final service = ref.watch(accountServiceProvider);
  return AccountRepositoryImpl(service);
});

final accountListProvider = StateNotifierProvider.autoDispose<AccountNotifier, AsyncValue<List<Account>>>((ref) {
  final repository = ref.watch(accountRepositoryProvider);
  return AccountNotifier(repository);
});

class AccountNotifier extends StateNotifier<AsyncValue<List<Account>>> {
  final AccountRepository _repository;

  AccountNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchAccounts();
  }

  Future<void> fetchAccounts() async {
    state = const AsyncValue.loading();
    try {
      final items = await _repository.getAll();
      state = AsyncValue.data(items);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> create(Account item) async {
    try {
      await _repository.create(item);
      await fetchAccounts();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateItem(String id, Account item) async {
    try {
      await _repository.update(id, item);
      await fetchAccounts();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _repository.delete(id);
      await fetchAccounts();
    } catch (e) {
      rethrow;
    }
  }
}
