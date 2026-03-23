//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'account_type.dart';
import 'user.dart';

class Account implements PrismaModel<String, Account>, Id<String> {
  @override
  String? id;
  String? userId;
  AccountType? type;
  String? providerId;
  String? accountId;
  String? refreshToken;
  String? accessToken;
  DateTime? accessTokenExpiresAt;
  String? tokenType;
  String? scope;
  String? idToken;
  String? sessionState;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  Account({
    this.id,
    this.userId,
    this.type = AccountType.OAUTH,
    this.providerId,
    this.accountId,
    this.refreshToken,
    this.accessToken,
    this.accessTokenExpiresAt,
    this.tokenType,
    this.scope,
    this.idToken,
    this.sessionState,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<Account, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "userId": (m) => m.userId,
    "type": (m) => m.type,
    "providerId": (m) => m.providerId,
    "accountId": (m) => m.accountId,
    "refreshToken": (m) => m.refreshToken,
    "accessToken": (m) => m.accessToken,
    "accessTokenExpiresAt": (m) => m.accessTokenExpiresAt,
    "tokenType": (m) => m.tokenType,
    "scope": (m) => m.scope,
    "idToken": (m) => m.idToken,
    "sessionState": (m) => m.sessionState,
    "isActive": (m) => m.isActive,
    "createdAt": (m) => m.createdAt,
    "updatedAt": (m) => m.updatedAt,
    "user": (m) => m.user,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(Account) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Account');
    }
    return propFunction as V? Function(Account);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory Account.fromJson(JsonMap json) => Account(
        id: json['id'] as String?,
        userId: json['userId'] as String?,
        type: json['type'] != null ? AccountType.fromJson(json['type']) : null,
        providerId: json['providerId'] as String?,
        accountId: json['accountId'] as String?,
        refreshToken: json['refreshToken'] as String?,
        accessToken: json['accessToken'] as String?,
        accessTokenExpiresAt: json['accessTokenExpiresAt'] != null
            ? DateTime.parse(json['accessTokenExpiresAt'])
            : null,
        tokenType: json['tokenType'] as String?,
        scope: json['scope'] as String?,
        idToken: json['idToken'] as String?,
        sessionState: json['sessionState'] as String?,
        isActive: json['isActive'] as bool?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        user: json['user'] != null
            ? User.fromJson(json['user'] as JsonMap)
            : null,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  Account copyWith({
    Value<String?>? id,
    Value<String?>? userId,
    Value<AccountType?>? type,
    Value<String?>? providerId,
    Value<String?>? accountId,
    Value<String?>? refreshToken,
    Value<String?>? accessToken,
    Value<DateTime?>? accessTokenExpiresAt,
    Value<String?>? tokenType,
    Value<String?>? scope,
    Value<String?>? idToken,
    Value<String?>? sessionState,
    Value<bool?>? isActive,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<User?>? user,
  }) {
    return Account(
        id: id != null ? id.value : this.id,
        userId: userId != null ? userId.value : this.userId,
        type: type != null ? type.value : this.type,
        providerId: providerId != null ? providerId.value : this.providerId,
        accountId: accountId != null ? accountId.value : this.accountId,
        refreshToken:
            refreshToken != null ? refreshToken.value : this.refreshToken,
        accessToken: accessToken != null ? accessToken.value : this.accessToken,
        accessTokenExpiresAt: accessTokenExpiresAt != null
            ? accessTokenExpiresAt.value
            : this.accessTokenExpiresAt,
        tokenType: tokenType != null ? tokenType.value : this.tokenType,
        scope: scope != null ? scope.value : this.scope,
        idToken: idToken != null ? idToken.value : this.idToken,
        sessionState:
            sessionState != null ? sessionState.value : this.sessionState,
        isActive: isActive != null ? isActive.value : this.isActive,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
        user: user != null ? user.value : this.user);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  Account copyWithInstanceValues(Account account) {
    return Account(
        id: account.id ?? id,
        userId: account.userId ?? userId,
        type: account.type ?? type,
        providerId: account.providerId ?? providerId,
        accountId: account.accountId ?? accountId,
        refreshToken: account.refreshToken ?? refreshToken,
        accessToken: account.accessToken ?? accessToken,
        accessTokenExpiresAt:
            account.accessTokenExpiresAt ?? accessTokenExpiresAt,
        tokenType: account.tokenType ?? tokenType,
        scope: account.scope ?? scope,
        idToken: account.idToken ?? idToken,
        sessionState: account.sessionState ?? sessionState,
        isActive: account.isActive ?? isActive,
        createdAt: account.createdAt ?? createdAt,
        updatedAt: account.updatedAt ?? updatedAt,
        user: account.user ?? user);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  Account mergeWithInstanceValues(Account account) {
    return Account(
        id: account.$assignedFields.contains('id') ? account.id : id,
        userId: account.$assignedFields.contains('userId')
            ? account.userId
            : userId,
        type: account.$assignedFields.contains('type') ? account.type : type,
        providerId: account.$assignedFields.contains('providerId')
            ? account.providerId
            : providerId,
        accountId: account.$assignedFields.contains('accountId')
            ? account.accountId
            : accountId,
        refreshToken: account.$assignedFields.contains('refreshToken')
            ? account.refreshToken
            : refreshToken,
        accessToken: account.$assignedFields.contains('accessToken')
            ? account.accessToken
            : accessToken,
        accessTokenExpiresAt:
            account.$assignedFields.contains('accessTokenExpiresAt')
                ? account.accessTokenExpiresAt
                : accessTokenExpiresAt,
        tokenType: account.$assignedFields.contains('tokenType')
            ? account.tokenType
            : tokenType,
        scope:
            account.$assignedFields.contains('scope') ? account.scope : scope,
        idToken: account.$assignedFields.contains('idToken')
            ? account.idToken
            : idToken,
        sessionState: account.$assignedFields.contains('sessionState')
            ? account.sessionState
            : sessionState,
        isActive: account.$assignedFields.contains('isActive')
            ? account.isActive
            : isActive,
        createdAt: account.$assignedFields.contains('createdAt')
            ? account.createdAt
            : createdAt,
        updatedAt: account.$assignedFields.contains('updatedAt')
            ? account.updatedAt
            : updatedAt,
        user: account.$assignedFields.contains('user') ? account.user : user);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  Account updateWithInstanceValues(Account account) {
    if (account.$assignedFields.contains('id')) {
      id = account.id;
    }
    if (account.$assignedFields.contains('userId')) {
      userId = account.userId;
    }
    if (account.$assignedFields.contains('type')) {
      type = account.type;
    }
    if (account.$assignedFields.contains('providerId')) {
      providerId = account.providerId;
    }
    if (account.$assignedFields.contains('accountId')) {
      accountId = account.accountId;
    }
    if (account.$assignedFields.contains('refreshToken')) {
      refreshToken = account.refreshToken;
    }
    if (account.$assignedFields.contains('accessToken')) {
      accessToken = account.accessToken;
    }
    if (account.$assignedFields.contains('accessTokenExpiresAt')) {
      accessTokenExpiresAt = account.accessTokenExpiresAt;
    }
    if (account.$assignedFields.contains('tokenType')) {
      tokenType = account.tokenType;
    }
    if (account.$assignedFields.contains('scope')) {
      scope = account.scope;
    }
    if (account.$assignedFields.contains('idToken')) {
      idToken = account.idToken;
    }
    if (account.$assignedFields.contains('sessionState')) {
      sessionState = account.sessionState;
    }
    if (account.$assignedFields.contains('isActive')) {
      isActive = account.isActive;
    }
    if (account.$assignedFields.contains('createdAt')) {
      createdAt = account.createdAt;
    }
    if (account.$assignedFields.contains('updatedAt')) {
      updatedAt = account.updatedAt;
    }
    if (account.$assignedFields.contains('user')) {
      user = account.user;
    }
    return this;
  }

  /// Converts this instance to a JSON object.
  ///
  /// [serializedTypes] - Internal parameter tracking which model types have been serialized
  /// in the current chain to prevent circular references.
  /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
  /// skipping relations whose types have already been serialized in the current chain.
  /// Set to false to serialize all relations (use with caution - may cause infinite loops).
  @override
  JsonMap toJson({
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
  }) {
    final Set<String> serializedModels = preventCircularSerialization
        ? {...?serializedTypes, 'Account'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (type != null) 'type': type?.toJson(),
      if (providerId != null) 'providerId': providerId,
      if (accountId != null) 'accountId': accountId,
      if (refreshToken != null) 'refreshToken': refreshToken,
      if (accessToken != null) 'accessToken': accessToken,
      if (accessTokenExpiresAt != null)
        'accessTokenExpiresAt': accessTokenExpiresAt?.toIso8601String(),
      if (tokenType != null) 'tokenType': tokenType,
      if (scope != null) 'scope': scope,
      if (idToken != null) 'idToken': idToken,
      if (sessionState != null) 'sessionState': sessionState,
      if (isActive != null) 'isActive': isActive,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
      if (user != null &&
          (!preventCircularSerialization || !serializedModels.contains('User')))
        'user': user?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization)
    };
  }

  /// Determines whether this instance and another object represent the same
  /// instance.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Account &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
