import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../gen_models/models_library.dart';
import '../../../shared/services/account_service.dart';
import '../../../core/error/service_exception.dart';
import 'account_state.dart';

/// Notifier for account list management
class AccountListNotifier extends StateNotifier<AccountListState> {
  final AccountService _service;
  
  AccountListNotifier(this._service) : super(const AccountListState.initial());

  /// Load accounts with pagination
  Future<void> loadAccounts({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    state = const AccountListState.loading();
    
    try {
      final accounts = await _service.getAccounts(
        page: page,
        limit: limit,
        filters: filters,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );
      
      state = AccountListState.loaded(
        accounts,
        currentPage: page,
        hasMore: accounts.length >= limit,
        total: accounts.length,
      );
    } on ServiceException catch (e) {
      state = AccountListState.error(e.message);
    } catch (e) {
      state = AccountListState.error('An unexpected error occurred');
    }
  }

  /// Load more accounts (pagination)
  Future<void> loadMore({
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    state.whenOrNull(
      loaded: (accounts, currentPage, hasMore, total) async {
        if (!hasMore) return;
        
        try {
          final newAccounts = await _service.getAccounts(
            page: currentPage + 1,
            filters: filters,
            sortBy: sortBy,
            sortOrder: sortOrder,
          );
          
          state = AccountListState.loaded(
            [...accounts, ...newAccounts],
            currentPage: currentPage + 1,
            hasMore: newAccounts.isNotEmpty,
            total: total + newAccounts.length,
          );
        } on ServiceException catch (e) {
          state = AccountListState.error(e.message);
        }
      },
    );
  }

  /// Search accounts
  Future<void> searchAccounts(String query, {int page = 1}) async {
    state = const AccountListState.loading();
    
    try {
      final accounts = await _service.searchAccounts(
        query: query,
        page: page,
      );
      
      state = AccountListState.loaded(
        accounts,
        currentPage: page,
        hasMore: accounts.length >= 20,
        total: accounts.length,
      );
    } on ServiceException catch (e) {
      state = AccountListState.error(e.message);
    } catch (e) {
      state = AccountListState.error('Search failed');
    }
  }

  /// Refresh accounts
  Future<void> refresh() async {
    await loadAccounts();
  }
}

/// Notifier for single account management
class AccountNotifier extends StateNotifier<AccountState> {
  final AccountService _service;
  
  AccountNotifier(this._service) : super(const AccountState.initial());

  /// Load account by ID
  Future<void> loadAccount(String id) async {
    state = const AccountState.loading();
    
    try {
      final account = await _service.getAccountById(id);
      state = AccountState.loaded(account);
    } on ServiceException catch (e) {
      state = AccountState.error(e.message);
    } catch (e) {
      state = AccountState.error('Failed to load account');
    }
  }

  /// Create new account
  Future<bool> createAccount(Account account) async {
    state = const AccountState.loading();
    
    try {
      final created = await _service.createAccount(account);
      state = AccountState.loaded(created);
      return true;
    } on ServiceException catch (e) {
      state = AccountState.error(e.message);
      return false;
    } catch (e) {
      state = AccountState.error('Failed to create account');
      return false;
    }
  }

  /// Update account
  Future<bool> updateAccount(String id, Account account) async {
    state = const AccountState.loading();
    
    try {
      final updated = await _service.updateAccount(id, account);
      state = AccountState.loaded(updated);
      return true;
    } on ServiceException catch (e) {
      state = AccountState.error(e.message);
      return false;
    } catch (e) {
      state = AccountState.error('Failed to update account');
      return false;
    }
  }

  /// Delete account
  Future<bool> deleteAccount(String id) async {
    state = const AccountState.loading();
    
    try {
      await _service.deleteAccount(id);
      state = const AccountState.initial();
      return true;
    } on ServiceException catch (e) {
      state = AccountState.error(e.message);
      return false;
    } catch (e) {
      state = AccountState.error('Failed to delete account');
      return false;
    }
  }

  /// Activate account
  Future<bool> activateAccount(String id) async {
    state = const AccountState.loading();
    
    try {
      final activated = await _service.activateAccount(id);
      state = AccountState.loaded(activated);
      return true;
    } on ServiceException catch (e) {
      state = AccountState.error(e.message);
      return false;
    } catch (e) {
      state = AccountState.error('Failed to activate account');
      return false;
    }
  }

  /// Deactivate account
  Future<bool> deactivateAccount(String id) async {
    state = const AccountState.loading();
    
    try {
      final deactivated = await _service.deactivateAccount(id);
      state = AccountState.loaded(deactivated);
      return true;
    } on ServiceException catch (e) {
      state = AccountState.error(e.message);
      return false;
    } catch (e) {
      state = AccountState.error('Failed to deactivate account');
      return false;
    }
  }

  /// Refresh token
  Future<bool> refreshToken(String id) async {
    state = const AccountState.loading();
    
    try {
      final refreshed = await _service.refreshToken(id);
      state = AccountState.loaded(refreshed);
      return true;
    } on ServiceException catch (e) {
      state = AccountState.error(e.message);
      return false;
    } catch (e) {
      state = AccountState.error('Failed to refresh token');
      return false;
    }
  }

  /// Clear state
  void clear() {
    state = const AccountState.initial();
  }
}

/// Notifier for account stats
class AccountStatsNotifier extends StateNotifier<AccountStatsState> {
  final AccountService _service;
  
  AccountStatsNotifier(this._service) : super(const AccountStatsState.initial());

  /// Load account statistics
  Future<void> loadStats() async {
    state = const AccountStatsState.loading();
    
    try {
      final stats = await _service.getAccountStats();
      state = AccountStatsState.loaded(stats);
    } on ServiceException catch (e) {
      state = AccountStatsState.error(e.message);
    } catch (e) {
      state = AccountStatsState.error('Failed to load statistics');
    }
  }

  /// Refresh statistics
  Future<void> refresh() async {
    await loadStats();
  }
}
