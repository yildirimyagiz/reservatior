// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AccountListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountListStateCopyWith<$Res> {
  factory $AccountListStateCopyWith(
    AccountListState value,
    $Res Function(AccountListState) then,
  ) = _$AccountListStateCopyWithImpl<$Res, AccountListState>;
}

/// @nodoc
class _$AccountListStateCopyWithImpl<$Res, $Val extends AccountListState>
    implements $AccountListStateCopyWith<$Res> {
  _$AccountListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AccountListStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AccountListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AccountListState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AccountListStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AccountListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AccountListState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Account> accounts, int currentPage, bool hasMore, int total});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$AccountListStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? total = null,
  }) {
    return _then(
      _$LoadedImpl(
        null == accounts
            ? _value._accounts
            : accounts // ignore: cast_nullable_to_non_nullable
                  as List<Account>,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
    final List<Account> accounts, {
    this.currentPage = 1,
    this.hasMore = false,
    this.total = 0,
  }) : _accounts = accounts;

  final List<Account> _accounts;
  @override
  List<Account> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final int total;

  @override
  String toString() {
    return 'AccountListState.loaded(accounts: $accounts, currentPage: $currentPage, hasMore: $hasMore, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality().equals(other._accounts, _accounts) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_accounts),
    currentPage,
    hasMore,
    total,
  );

  /// Create a copy of AccountListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(accounts, currentPage, hasMore, total);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(accounts, currentPage, hasMore, total);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(accounts, currentPage, hasMore, total);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements AccountListState {
  const factory _Loaded(
    final List<Account> accounts, {
    final int currentPage,
    final bool hasMore,
    final int total,
  }) = _$LoadedImpl;

  List<Account> get accounts;
  int get currentPage;
  bool get hasMore;
  int get total;

  /// Create a copy of AccountListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$AccountListStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AccountListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AccountListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      List<Account> accounts,
      int currentPage,
      bool hasMore,
      int total,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AccountListState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of AccountListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AccountState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Account account) loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Account account)? loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Account account)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccountInitial value) initial,
    required TResult Function(_AccountLoading value) loading,
    required TResult Function(_AccountLoaded value) loaded,
    required TResult Function(_AccountError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccountInitial value)? initial,
    TResult? Function(_AccountLoading value)? loading,
    TResult? Function(_AccountLoaded value)? loaded,
    TResult? Function(_AccountError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccountInitial value)? initial,
    TResult Function(_AccountLoading value)? loading,
    TResult Function(_AccountLoaded value)? loaded,
    TResult Function(_AccountError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountStateCopyWith<$Res> {
  factory $AccountStateCopyWith(
    AccountState value,
    $Res Function(AccountState) then,
  ) = _$AccountStateCopyWithImpl<$Res, AccountState>;
}

/// @nodoc
class _$AccountStateCopyWithImpl<$Res, $Val extends AccountState>
    implements $AccountStateCopyWith<$Res> {
  _$AccountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AccountInitialImplCopyWith<$Res> {
  factory _$$AccountInitialImplCopyWith(
    _$AccountInitialImpl value,
    $Res Function(_$AccountInitialImpl) then,
  ) = __$$AccountInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AccountInitialImplCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountInitialImpl>
    implements _$$AccountInitialImplCopyWith<$Res> {
  __$$AccountInitialImplCopyWithImpl(
    _$AccountInitialImpl _value,
    $Res Function(_$AccountInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AccountInitialImpl implements _AccountInitial {
  const _$AccountInitialImpl();

  @override
  String toString() {
    return 'AccountState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AccountInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Account account) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Account account)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Account account)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccountInitial value) initial,
    required TResult Function(_AccountLoading value) loading,
    required TResult Function(_AccountLoaded value) loaded,
    required TResult Function(_AccountError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccountInitial value)? initial,
    TResult? Function(_AccountLoading value)? loading,
    TResult? Function(_AccountLoaded value)? loaded,
    TResult? Function(_AccountError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccountInitial value)? initial,
    TResult Function(_AccountLoading value)? loading,
    TResult Function(_AccountLoaded value)? loaded,
    TResult Function(_AccountError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _AccountInitial implements AccountState {
  const factory _AccountInitial() = _$AccountInitialImpl;
}

/// @nodoc
abstract class _$$AccountLoadingImplCopyWith<$Res> {
  factory _$$AccountLoadingImplCopyWith(
    _$AccountLoadingImpl value,
    $Res Function(_$AccountLoadingImpl) then,
  ) = __$$AccountLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AccountLoadingImplCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountLoadingImpl>
    implements _$$AccountLoadingImplCopyWith<$Res> {
  __$$AccountLoadingImplCopyWithImpl(
    _$AccountLoadingImpl _value,
    $Res Function(_$AccountLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AccountLoadingImpl implements _AccountLoading {
  const _$AccountLoadingImpl();

  @override
  String toString() {
    return 'AccountState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AccountLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Account account) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Account account)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Account account)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccountInitial value) initial,
    required TResult Function(_AccountLoading value) loading,
    required TResult Function(_AccountLoaded value) loaded,
    required TResult Function(_AccountError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccountInitial value)? initial,
    TResult? Function(_AccountLoading value)? loading,
    TResult? Function(_AccountLoaded value)? loaded,
    TResult? Function(_AccountError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccountInitial value)? initial,
    TResult Function(_AccountLoading value)? loading,
    TResult Function(_AccountLoaded value)? loaded,
    TResult Function(_AccountError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _AccountLoading implements AccountState {
  const factory _AccountLoading() = _$AccountLoadingImpl;
}

/// @nodoc
abstract class _$$AccountLoadedImplCopyWith<$Res> {
  factory _$$AccountLoadedImplCopyWith(
    _$AccountLoadedImpl value,
    $Res Function(_$AccountLoadedImpl) then,
  ) = __$$AccountLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Account account});
}

/// @nodoc
class __$$AccountLoadedImplCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountLoadedImpl>
    implements _$$AccountLoadedImplCopyWith<$Res> {
  __$$AccountLoadedImplCopyWithImpl(
    _$AccountLoadedImpl _value,
    $Res Function(_$AccountLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? account = null}) {
    return _then(
      _$AccountLoadedImpl(
        null == account
            ? _value.account
            : account // ignore: cast_nullable_to_non_nullable
                  as Account,
      ),
    );
  }
}

/// @nodoc

class _$AccountLoadedImpl implements _AccountLoaded {
  const _$AccountLoadedImpl(this.account);

  @override
  final Account account;

  @override
  String toString() {
    return 'AccountState.loaded(account: $account)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountLoadedImpl &&
            (identical(other.account, account) || other.account == account));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account);

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountLoadedImplCopyWith<_$AccountLoadedImpl> get copyWith =>
      __$$AccountLoadedImplCopyWithImpl<_$AccountLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Account account) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(account);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Account account)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(account);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Account account)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(account);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccountInitial value) initial,
    required TResult Function(_AccountLoading value) loading,
    required TResult Function(_AccountLoaded value) loaded,
    required TResult Function(_AccountError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccountInitial value)? initial,
    TResult? Function(_AccountLoading value)? loading,
    TResult? Function(_AccountLoaded value)? loaded,
    TResult? Function(_AccountError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccountInitial value)? initial,
    TResult Function(_AccountLoading value)? loading,
    TResult Function(_AccountLoaded value)? loaded,
    TResult Function(_AccountError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _AccountLoaded implements AccountState {
  const factory _AccountLoaded(final Account account) = _$AccountLoadedImpl;

  Account get account;

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountLoadedImplCopyWith<_$AccountLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AccountErrorImplCopyWith<$Res> {
  factory _$$AccountErrorImplCopyWith(
    _$AccountErrorImpl value,
    $Res Function(_$AccountErrorImpl) then,
  ) = __$$AccountErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AccountErrorImplCopyWithImpl<$Res>
    extends _$AccountStateCopyWithImpl<$Res, _$AccountErrorImpl>
    implements _$$AccountErrorImplCopyWith<$Res> {
  __$$AccountErrorImplCopyWithImpl(
    _$AccountErrorImpl _value,
    $Res Function(_$AccountErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AccountErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AccountErrorImpl implements _AccountError {
  const _$AccountErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AccountState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountErrorImplCopyWith<_$AccountErrorImpl> get copyWith =>
      __$$AccountErrorImplCopyWithImpl<_$AccountErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Account account) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Account account)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Account account)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AccountInitial value) initial,
    required TResult Function(_AccountLoading value) loading,
    required TResult Function(_AccountLoaded value) loaded,
    required TResult Function(_AccountError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AccountInitial value)? initial,
    TResult? Function(_AccountLoading value)? loading,
    TResult? Function(_AccountLoaded value)? loaded,
    TResult? Function(_AccountError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AccountInitial value)? initial,
    TResult Function(_AccountLoading value)? loading,
    TResult Function(_AccountLoaded value)? loaded,
    TResult Function(_AccountError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AccountError implements AccountState {
  const factory _AccountError(final String message) = _$AccountErrorImpl;

  String get message;

  /// Create a copy of AccountState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountErrorImplCopyWith<_$AccountErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AccountFormState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Account account) editing,
    required TResult Function() submitting,
    required TResult Function(Account account) success,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Account account)? editing,
    TResult? Function()? submitting,
    TResult? Function(Account account)? success,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Account account)? editing,
    TResult Function()? submitting,
    TResult Function(Account account)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FormInitial value) initial,
    required TResult Function(_FormEditing value) editing,
    required TResult Function(_FormSubmitting value) submitting,
    required TResult Function(_FormSuccess value) success,
    required TResult Function(_FormError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FormInitial value)? initial,
    TResult? Function(_FormEditing value)? editing,
    TResult? Function(_FormSubmitting value)? submitting,
    TResult? Function(_FormSuccess value)? success,
    TResult? Function(_FormError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FormInitial value)? initial,
    TResult Function(_FormEditing value)? editing,
    TResult Function(_FormSubmitting value)? submitting,
    TResult Function(_FormSuccess value)? success,
    TResult Function(_FormError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountFormStateCopyWith<$Res> {
  factory $AccountFormStateCopyWith(
    AccountFormState value,
    $Res Function(AccountFormState) then,
  ) = _$AccountFormStateCopyWithImpl<$Res, AccountFormState>;
}

/// @nodoc
class _$AccountFormStateCopyWithImpl<$Res, $Val extends AccountFormState>
    implements $AccountFormStateCopyWith<$Res> {
  _$AccountFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FormInitialImplCopyWith<$Res> {
  factory _$$FormInitialImplCopyWith(
    _$FormInitialImpl value,
    $Res Function(_$FormInitialImpl) then,
  ) = __$$FormInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FormInitialImplCopyWithImpl<$Res>
    extends _$AccountFormStateCopyWithImpl<$Res, _$FormInitialImpl>
    implements _$$FormInitialImplCopyWith<$Res> {
  __$$FormInitialImplCopyWithImpl(
    _$FormInitialImpl _value,
    $Res Function(_$FormInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FormInitialImpl implements _FormInitial {
  const _$FormInitialImpl();

  @override
  String toString() {
    return 'AccountFormState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FormInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Account account) editing,
    required TResult Function() submitting,
    required TResult Function(Account account) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Account account)? editing,
    TResult? Function()? submitting,
    TResult? Function(Account account)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Account account)? editing,
    TResult Function()? submitting,
    TResult Function(Account account)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FormInitial value) initial,
    required TResult Function(_FormEditing value) editing,
    required TResult Function(_FormSubmitting value) submitting,
    required TResult Function(_FormSuccess value) success,
    required TResult Function(_FormError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FormInitial value)? initial,
    TResult? Function(_FormEditing value)? editing,
    TResult? Function(_FormSubmitting value)? submitting,
    TResult? Function(_FormSuccess value)? success,
    TResult? Function(_FormError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FormInitial value)? initial,
    TResult Function(_FormEditing value)? editing,
    TResult Function(_FormSubmitting value)? submitting,
    TResult Function(_FormSuccess value)? success,
    TResult Function(_FormError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _FormInitial implements AccountFormState {
  const factory _FormInitial() = _$FormInitialImpl;
}

/// @nodoc
abstract class _$$FormEditingImplCopyWith<$Res> {
  factory _$$FormEditingImplCopyWith(
    _$FormEditingImpl value,
    $Res Function(_$FormEditingImpl) then,
  ) = __$$FormEditingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Account account});
}

/// @nodoc
class __$$FormEditingImplCopyWithImpl<$Res>
    extends _$AccountFormStateCopyWithImpl<$Res, _$FormEditingImpl>
    implements _$$FormEditingImplCopyWith<$Res> {
  __$$FormEditingImplCopyWithImpl(
    _$FormEditingImpl _value,
    $Res Function(_$FormEditingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? account = null}) {
    return _then(
      _$FormEditingImpl(
        null == account
            ? _value.account
            : account // ignore: cast_nullable_to_non_nullable
                  as Account,
      ),
    );
  }
}

/// @nodoc

class _$FormEditingImpl implements _FormEditing {
  const _$FormEditingImpl(this.account);

  @override
  final Account account;

  @override
  String toString() {
    return 'AccountFormState.editing(account: $account)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormEditingImpl &&
            (identical(other.account, account) || other.account == account));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account);

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormEditingImplCopyWith<_$FormEditingImpl> get copyWith =>
      __$$FormEditingImplCopyWithImpl<_$FormEditingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Account account) editing,
    required TResult Function() submitting,
    required TResult Function(Account account) success,
    required TResult Function(String message) error,
  }) {
    return editing(account);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Account account)? editing,
    TResult? Function()? submitting,
    TResult? Function(Account account)? success,
    TResult? Function(String message)? error,
  }) {
    return editing?.call(account);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Account account)? editing,
    TResult Function()? submitting,
    TResult Function(Account account)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (editing != null) {
      return editing(account);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FormInitial value) initial,
    required TResult Function(_FormEditing value) editing,
    required TResult Function(_FormSubmitting value) submitting,
    required TResult Function(_FormSuccess value) success,
    required TResult Function(_FormError value) error,
  }) {
    return editing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FormInitial value)? initial,
    TResult? Function(_FormEditing value)? editing,
    TResult? Function(_FormSubmitting value)? submitting,
    TResult? Function(_FormSuccess value)? success,
    TResult? Function(_FormError value)? error,
  }) {
    return editing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FormInitial value)? initial,
    TResult Function(_FormEditing value)? editing,
    TResult Function(_FormSubmitting value)? submitting,
    TResult Function(_FormSuccess value)? success,
    TResult Function(_FormError value)? error,
    required TResult orElse(),
  }) {
    if (editing != null) {
      return editing(this);
    }
    return orElse();
  }
}

abstract class _FormEditing implements AccountFormState {
  const factory _FormEditing(final Account account) = _$FormEditingImpl;

  Account get account;

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormEditingImplCopyWith<_$FormEditingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FormSubmittingImplCopyWith<$Res> {
  factory _$$FormSubmittingImplCopyWith(
    _$FormSubmittingImpl value,
    $Res Function(_$FormSubmittingImpl) then,
  ) = __$$FormSubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FormSubmittingImplCopyWithImpl<$Res>
    extends _$AccountFormStateCopyWithImpl<$Res, _$FormSubmittingImpl>
    implements _$$FormSubmittingImplCopyWith<$Res> {
  __$$FormSubmittingImplCopyWithImpl(
    _$FormSubmittingImpl _value,
    $Res Function(_$FormSubmittingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FormSubmittingImpl implements _FormSubmitting {
  const _$FormSubmittingImpl();

  @override
  String toString() {
    return 'AccountFormState.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FormSubmittingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Account account) editing,
    required TResult Function() submitting,
    required TResult Function(Account account) success,
    required TResult Function(String message) error,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Account account)? editing,
    TResult? Function()? submitting,
    TResult? Function(Account account)? success,
    TResult? Function(String message)? error,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Account account)? editing,
    TResult Function()? submitting,
    TResult Function(Account account)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FormInitial value) initial,
    required TResult Function(_FormEditing value) editing,
    required TResult Function(_FormSubmitting value) submitting,
    required TResult Function(_FormSuccess value) success,
    required TResult Function(_FormError value) error,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FormInitial value)? initial,
    TResult? Function(_FormEditing value)? editing,
    TResult? Function(_FormSubmitting value)? submitting,
    TResult? Function(_FormSuccess value)? success,
    TResult? Function(_FormError value)? error,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FormInitial value)? initial,
    TResult Function(_FormEditing value)? editing,
    TResult Function(_FormSubmitting value)? submitting,
    TResult Function(_FormSuccess value)? success,
    TResult Function(_FormError value)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class _FormSubmitting implements AccountFormState {
  const factory _FormSubmitting() = _$FormSubmittingImpl;
}

/// @nodoc
abstract class _$$FormSuccessImplCopyWith<$Res> {
  factory _$$FormSuccessImplCopyWith(
    _$FormSuccessImpl value,
    $Res Function(_$FormSuccessImpl) then,
  ) = __$$FormSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Account account});
}

/// @nodoc
class __$$FormSuccessImplCopyWithImpl<$Res>
    extends _$AccountFormStateCopyWithImpl<$Res, _$FormSuccessImpl>
    implements _$$FormSuccessImplCopyWith<$Res> {
  __$$FormSuccessImplCopyWithImpl(
    _$FormSuccessImpl _value,
    $Res Function(_$FormSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? account = null}) {
    return _then(
      _$FormSuccessImpl(
        null == account
            ? _value.account
            : account // ignore: cast_nullable_to_non_nullable
                  as Account,
      ),
    );
  }
}

/// @nodoc

class _$FormSuccessImpl implements _FormSuccess {
  const _$FormSuccessImpl(this.account);

  @override
  final Account account;

  @override
  String toString() {
    return 'AccountFormState.success(account: $account)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormSuccessImpl &&
            (identical(other.account, account) || other.account == account));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account);

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormSuccessImplCopyWith<_$FormSuccessImpl> get copyWith =>
      __$$FormSuccessImplCopyWithImpl<_$FormSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Account account) editing,
    required TResult Function() submitting,
    required TResult Function(Account account) success,
    required TResult Function(String message) error,
  }) {
    return success(account);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Account account)? editing,
    TResult? Function()? submitting,
    TResult? Function(Account account)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(account);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Account account)? editing,
    TResult Function()? submitting,
    TResult Function(Account account)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(account);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FormInitial value) initial,
    required TResult Function(_FormEditing value) editing,
    required TResult Function(_FormSubmitting value) submitting,
    required TResult Function(_FormSuccess value) success,
    required TResult Function(_FormError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FormInitial value)? initial,
    TResult? Function(_FormEditing value)? editing,
    TResult? Function(_FormSubmitting value)? submitting,
    TResult? Function(_FormSuccess value)? success,
    TResult? Function(_FormError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FormInitial value)? initial,
    TResult Function(_FormEditing value)? editing,
    TResult Function(_FormSubmitting value)? submitting,
    TResult Function(_FormSuccess value)? success,
    TResult Function(_FormError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _FormSuccess implements AccountFormState {
  const factory _FormSuccess(final Account account) = _$FormSuccessImpl;

  Account get account;

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormSuccessImplCopyWith<_$FormSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FormErrorImplCopyWith<$Res> {
  factory _$$FormErrorImplCopyWith(
    _$FormErrorImpl value,
    $Res Function(_$FormErrorImpl) then,
  ) = __$$FormErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FormErrorImplCopyWithImpl<$Res>
    extends _$AccountFormStateCopyWithImpl<$Res, _$FormErrorImpl>
    implements _$$FormErrorImplCopyWith<$Res> {
  __$$FormErrorImplCopyWithImpl(
    _$FormErrorImpl _value,
    $Res Function(_$FormErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$FormErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FormErrorImpl implements _FormError {
  const _$FormErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AccountFormState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FormErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FormErrorImplCopyWith<_$FormErrorImpl> get copyWith =>
      __$$FormErrorImplCopyWithImpl<_$FormErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Account account) editing,
    required TResult Function() submitting,
    required TResult Function(Account account) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Account account)? editing,
    TResult? Function()? submitting,
    TResult? Function(Account account)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Account account)? editing,
    TResult Function()? submitting,
    TResult Function(Account account)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FormInitial value) initial,
    required TResult Function(_FormEditing value) editing,
    required TResult Function(_FormSubmitting value) submitting,
    required TResult Function(_FormSuccess value) success,
    required TResult Function(_FormError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FormInitial value)? initial,
    TResult? Function(_FormEditing value)? editing,
    TResult? Function(_FormSubmitting value)? submitting,
    TResult? Function(_FormSuccess value)? success,
    TResult? Function(_FormError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FormInitial value)? initial,
    TResult Function(_FormEditing value)? editing,
    TResult Function(_FormSubmitting value)? submitting,
    TResult Function(_FormSuccess value)? success,
    TResult Function(_FormError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _FormError implements AccountFormState {
  const factory _FormError(final String message) = _$FormErrorImpl;

  String get message;

  /// Create a copy of AccountFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FormErrorImplCopyWith<_$FormErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AccountStatsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Map<String, dynamic> stats) loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Map<String, dynamic> stats)? loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Map<String, dynamic> stats)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsInitial value) initial,
    required TResult Function(_StatsLoading value) loading,
    required TResult Function(_StatsLoaded value) loaded,
    required TResult Function(_StatsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StatsInitial value)? initial,
    TResult? Function(_StatsLoading value)? loading,
    TResult? Function(_StatsLoaded value)? loaded,
    TResult? Function(_StatsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_StatsLoading value)? loading,
    TResult Function(_StatsLoaded value)? loaded,
    TResult Function(_StatsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountStatsStateCopyWith<$Res> {
  factory $AccountStatsStateCopyWith(
    AccountStatsState value,
    $Res Function(AccountStatsState) then,
  ) = _$AccountStatsStateCopyWithImpl<$Res, AccountStatsState>;
}

/// @nodoc
class _$AccountStatsStateCopyWithImpl<$Res, $Val extends AccountStatsState>
    implements $AccountStatsStateCopyWith<$Res> {
  _$AccountStatsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountStatsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StatsInitialImplCopyWith<$Res> {
  factory _$$StatsInitialImplCopyWith(
    _$StatsInitialImpl value,
    $Res Function(_$StatsInitialImpl) then,
  ) = __$$StatsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StatsInitialImplCopyWithImpl<$Res>
    extends _$AccountStatsStateCopyWithImpl<$Res, _$StatsInitialImpl>
    implements _$$StatsInitialImplCopyWith<$Res> {
  __$$StatsInitialImplCopyWithImpl(
    _$StatsInitialImpl _value,
    $Res Function(_$StatsInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountStatsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StatsInitialImpl implements _StatsInitial {
  const _$StatsInitialImpl();

  @override
  String toString() {
    return 'AccountStatsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StatsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Map<String, dynamic> stats) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Map<String, dynamic> stats)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Map<String, dynamic> stats)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsInitial value) initial,
    required TResult Function(_StatsLoading value) loading,
    required TResult Function(_StatsLoaded value) loaded,
    required TResult Function(_StatsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StatsInitial value)? initial,
    TResult? Function(_StatsLoading value)? loading,
    TResult? Function(_StatsLoaded value)? loaded,
    TResult? Function(_StatsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_StatsLoading value)? loading,
    TResult Function(_StatsLoaded value)? loaded,
    TResult Function(_StatsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _StatsInitial implements AccountStatsState {
  const factory _StatsInitial() = _$StatsInitialImpl;
}

/// @nodoc
abstract class _$$StatsLoadingImplCopyWith<$Res> {
  factory _$$StatsLoadingImplCopyWith(
    _$StatsLoadingImpl value,
    $Res Function(_$StatsLoadingImpl) then,
  ) = __$$StatsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StatsLoadingImplCopyWithImpl<$Res>
    extends _$AccountStatsStateCopyWithImpl<$Res, _$StatsLoadingImpl>
    implements _$$StatsLoadingImplCopyWith<$Res> {
  __$$StatsLoadingImplCopyWithImpl(
    _$StatsLoadingImpl _value,
    $Res Function(_$StatsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountStatsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StatsLoadingImpl implements _StatsLoading {
  const _$StatsLoadingImpl();

  @override
  String toString() {
    return 'AccountStatsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StatsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Map<String, dynamic> stats) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Map<String, dynamic> stats)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Map<String, dynamic> stats)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsInitial value) initial,
    required TResult Function(_StatsLoading value) loading,
    required TResult Function(_StatsLoaded value) loaded,
    required TResult Function(_StatsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StatsInitial value)? initial,
    TResult? Function(_StatsLoading value)? loading,
    TResult? Function(_StatsLoaded value)? loaded,
    TResult? Function(_StatsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_StatsLoading value)? loading,
    TResult Function(_StatsLoaded value)? loaded,
    TResult Function(_StatsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _StatsLoading implements AccountStatsState {
  const factory _StatsLoading() = _$StatsLoadingImpl;
}

/// @nodoc
abstract class _$$StatsLoadedImplCopyWith<$Res> {
  factory _$$StatsLoadedImplCopyWith(
    _$StatsLoadedImpl value,
    $Res Function(_$StatsLoadedImpl) then,
  ) = __$$StatsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> stats});
}

/// @nodoc
class __$$StatsLoadedImplCopyWithImpl<$Res>
    extends _$AccountStatsStateCopyWithImpl<$Res, _$StatsLoadedImpl>
    implements _$$StatsLoadedImplCopyWith<$Res> {
  __$$StatsLoadedImplCopyWithImpl(
    _$StatsLoadedImpl _value,
    $Res Function(_$StatsLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountStatsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? stats = null}) {
    return _then(
      _$StatsLoadedImpl(
        null == stats
            ? _value._stats
            : stats // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$StatsLoadedImpl implements _StatsLoaded {
  const _$StatsLoadedImpl(final Map<String, dynamic> stats) : _stats = stats;

  final Map<String, dynamic> _stats;
  @override
  Map<String, dynamic> get stats {
    if (_stats is EqualUnmodifiableMapView) return _stats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stats);
  }

  @override
  String toString() {
    return 'AccountStatsState.loaded(stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsLoadedImpl &&
            const DeepCollectionEquality().equals(other._stats, _stats));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_stats));

  /// Create a copy of AccountStatsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatsLoadedImplCopyWith<_$StatsLoadedImpl> get copyWith =>
      __$$StatsLoadedImplCopyWithImpl<_$StatsLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Map<String, dynamic> stats) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(stats);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Map<String, dynamic> stats)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(stats);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Map<String, dynamic> stats)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(stats);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsInitial value) initial,
    required TResult Function(_StatsLoading value) loading,
    required TResult Function(_StatsLoaded value) loaded,
    required TResult Function(_StatsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StatsInitial value)? initial,
    TResult? Function(_StatsLoading value)? loading,
    TResult? Function(_StatsLoaded value)? loaded,
    TResult? Function(_StatsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_StatsLoading value)? loading,
    TResult Function(_StatsLoaded value)? loaded,
    TResult Function(_StatsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _StatsLoaded implements AccountStatsState {
  const factory _StatsLoaded(final Map<String, dynamic> stats) =
      _$StatsLoadedImpl;

  Map<String, dynamic> get stats;

  /// Create a copy of AccountStatsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatsLoadedImplCopyWith<_$StatsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StatsErrorImplCopyWith<$Res> {
  factory _$$StatsErrorImplCopyWith(
    _$StatsErrorImpl value,
    $Res Function(_$StatsErrorImpl) then,
  ) = __$$StatsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$StatsErrorImplCopyWithImpl<$Res>
    extends _$AccountStatsStateCopyWithImpl<$Res, _$StatsErrorImpl>
    implements _$$StatsErrorImplCopyWith<$Res> {
  __$$StatsErrorImplCopyWithImpl(
    _$StatsErrorImpl _value,
    $Res Function(_$StatsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AccountStatsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$StatsErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$StatsErrorImpl implements _StatsError {
  const _$StatsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AccountStatsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AccountStatsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StatsErrorImplCopyWith<_$StatsErrorImpl> get copyWith =>
      __$$StatsErrorImplCopyWithImpl<_$StatsErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Map<String, dynamic> stats) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Map<String, dynamic> stats)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Map<String, dynamic> stats)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsInitial value) initial,
    required TResult Function(_StatsLoading value) loading,
    required TResult Function(_StatsLoaded value) loaded,
    required TResult Function(_StatsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StatsInitial value)? initial,
    TResult? Function(_StatsLoading value)? loading,
    TResult? Function(_StatsLoaded value)? loaded,
    TResult? Function(_StatsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsInitial value)? initial,
    TResult Function(_StatsLoading value)? loading,
    TResult Function(_StatsLoaded value)? loaded,
    TResult Function(_StatsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _StatsError implements AccountStatsState {
  const factory _StatsError(final String message) = _$StatsErrorImpl;

  String get message;

  /// Create a copy of AccountStatsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StatsErrorImplCopyWith<_$StatsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
