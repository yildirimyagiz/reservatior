import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../gen_models/models_library.dart';

part 'account_state.freezed.dart';

/// State for account list
@freezed
class AccountListState with _$AccountListState {
  const factory AccountListState.initial() = _Initial;
  const factory AccountListState.loading() = _Loading;
  const factory AccountListState.loaded(List<Account> accounts, {
    @Default(1) int currentPage,
    @Default(false) bool hasMore,
    @Default(0) int total,
  }) = _Loaded;
  const factory AccountListState.error(String message) = _Error;
}

/// State for single account
@freezed
class AccountState with _$AccountState {
  const factory AccountState.initial() = _AccountInitial;
  const factory AccountState.loading() = _AccountLoading;
  const factory AccountState.loaded(Account account) = _AccountLoaded;
  const factory AccountState.error(String message) = _AccountError;
}

/// State for account form
@freezed
class AccountFormState with _$AccountFormState {
  const factory AccountFormState.initial() = _FormInitial;
  const factory AccountFormState.editing(Account account) = _FormEditing;
  const factory AccountFormState.submitting() = _FormSubmitting;
  const factory AccountFormState.success(Account account) = _FormSuccess;
  const factory AccountFormState.error(String message) = _FormError;
}

/// State for account stats
@freezed
class AccountStatsState with _$AccountStatsState {
  const factory AccountStatsState.initial() = _StatsInitial;
  const factory AccountStatsState.loading() = _StatsLoading;
  const factory AccountStatsState.loaded(Map<String, dynamic> stats) = _StatsLoaded;
  const factory AccountStatsState.error(String message) = _StatsError;
}
