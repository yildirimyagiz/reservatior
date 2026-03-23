import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/account_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../features/account/domain/account_state.dart';
import '../../features/account/domain/account_notifier.dart';
import 'dio_client_provider.dart';

// ─── Core Providers ─────────────────────────────────────────────────

/// DioClient provider - singleton instance

/// AccountService provider
final accountServiceProvider = Provider<AccountService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AccountService(dioClient);
});

// ─── State Notifier Providers ───────────────────────────────────────

/// Account list state notifier provider
final accountListProvider = StateNotifierProvider<AccountListNotifier, AccountListState>((ref) {
  final service = ref.watch(accountServiceProvider);
  return AccountListNotifier(service);
});

/// Single account state notifier provider
final accountListProvider = StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  final service = ref.watch(accountServiceProvider);
  return AccountNotifier(service);
});

/// Account stats state notifier provider
final accountStatsProvider = StateNotifierProvider<AccountStatsNotifier, AccountStatsState>((ref) {
  final service = ref.watch(accountServiceProvider);
  return AccountStatsNotifier(service);
});

// ─── Specific Data Providers ────────────────────────────────────────

/// Get account by ID
final accountByIdProvider = FutureProvider.family<Account, String>((ref, id) async {
  final service = ref.watch(accountServiceProvider);
  return service.getAccountById(id);
});

/// Get accounts by user ID
final accountsByUserIdProvider = FutureProvider.family<List<Account>, String>((ref, userId) async {
  final service = ref.watch(accountServiceProvider);
  return service.getAccountsByUserId(userId);
});

/// Search accounts provider
final accountSearchProvider = FutureProvider.family<List<Account>, String>((ref, query) async {
  final service = ref.watch(accountServiceProvider);
  return service.searchAccounts(query: query);
});

// ─── Action Providers ───────────────────────────────────────────────

/// Provider for creating an account
final createAccountProvider = Provider<Future<Account> Function(Account)>((ref) {
  final service = ref.watch(accountServiceProvider);
  return (account) => service.createAccount(account);
});

/// Provider for updating an account
final updateAccountProvider = Provider<Future<Account> Function(String, Account)>((ref) {
  final service = ref.watch(accountServiceProvider);
  return (id, account) => service.updateAccount(id, account);
});

/// Provider for deleting an account
final deleteAccountProvider = Provider<Future<void> Function(String)>((ref) {
  final service = ref.watch(accountServiceProvider);
  return (id) => service.deleteAccount(id);
});

/// Provider for activating an account
final activateAccountProvider = Provider<Future<Account> Function(String)>((ref) {
  final service = ref.watch(accountServiceProvider);
  return (id) => service.activateAccount(id);
});

/// Provider for deactivating an account
final deactivateAccountProvider = Provider<Future<Account> Function(String)>((ref) {
  final service = ref.watch(accountServiceProvider);
  return (id) => service.deactivateAccount(id);
});

/// Provider for refreshing account token
final refreshAccountTokenProvider = Provider<Future<Account> Function(String)>((ref) {
  final service = ref.watch(accountServiceProvider);
  return (id) => service.refreshToken(id);
});

// ─── Utility Providers ──────────────────────────────────────────────

/// Loading state provider - checks if any operation is in progress
final accountLoadingProvider = Provider<bool>((ref) {
  final listState = ref.watch(accountListProvider);
  final accountState = ref.watch(accountListProvider);
  final statsState = ref.watch(accountStatsProvider);
  
  return listState is _Loading || 
         accountState is _AccountLoading ||
         statsState is _StatsLoading;
});

/// Error message provider - returns current error if any
final accountErrorProvider = Provider<String?>((ref) {
  final listState = ref.watch(accountListProvider);
  final accountState = ref.watch(accountListProvider);
  final statsState = ref.watch(accountStatsProvider);
  
  return listState.maybeWhen(
    error: (message) => message,
    orElse: () => accountState.maybeWhen(
      error: (message) => message,
      orElse: () => statsState.maybeWhen(
        error: (message) => message,
        orElse: () => null,
      ),
    ),
  );
});

/// Current accounts list provider - extracts accounts from list state
final currentAccountsProvider = Provider<List<Account>>((ref) {
  final state = ref.watch(accountListProvider);
  return state.maybeWhen(
    loaded: (accounts, _, __, ___) => accounts,
    orElse: () => [],
  );
});

/// Current account provider - extracts account from account state
final currentAccountProvider = Provider<Account?>((ref) {
  final state = ref.watch(accountListProvider);
  return state.maybeWhen(
    loaded: (account) => account,
    orElse: () => null,
  );
});

/// Account stats data provider - extracts stats from stats state
final accountStatsDataProvider = Provider<Map<String, dynamic>?>((ref) {
  final state = ref.watch(accountStatsProvider);
  return state.maybeWhen(
    loaded: (stats) => stats,
    orElse: () => null,
  );
});

// ─── Legacy Compatibility (deprecated) ──────────────────────────────

@Deprecated('Use accountServiceProvider instead')
final accountServiceProvider = accountServiceProvider;

@Deprecated('Use accountListProvider instead')
final accountListStateProvider = accountListProvider;

@Deprecated('Use createAccountProvider instead')
final accountCreateProvider = createAccountProvider;

@Deprecated('Use updateAccountProvider instead')
final accountUpdateProvider = updateAccountProvider;

@Deprecated('Use deleteAccountProvider instead')
final accountDeleteProvider = deleteAccountProvider;

@Deprecated('Use accountStatsProvider instead')
final accountStatsProvider = accountStatsProvider;

@Deprecated('Use accountLoadingProvider instead')
final accountLoadingProvider = accountLoadingProvider;
