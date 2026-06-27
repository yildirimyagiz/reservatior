import 'package:reservatior/shared/enums/account_type.dart';
import 'user.dart';

class Account {
  final String id;
  final String userId;
  final AccountType type;
  final String providerId;
  final String accountId;
  final String? refreshToken;
  final String? accessToken;
  final DateTime? accessTokenExpiresAt;
  final String? tokenType;
  final String? scope;
  final String? idToken;
  final String? sessionState;
  final bool? isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  const Account({
    required this.id,
    required this.userId,
    required this.type,
    required this.providerId,
    required this.accountId,
    this.refreshToken,
    this.accessToken,
    this.accessTokenExpiresAt,
    this.tokenType,
    this.scope,
    this.idToken,
    this.sessionState,
    this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: AccountType.values.firstWhere((v) => v.name == json['type']),
      providerId: json['providerId'] as String,
      accountId: json['accountId'] as String,
      refreshToken: json['refreshToken'] as String?,
      accessToken: json['accessToken'] as String?,
      accessTokenExpiresAt: json['accessTokenExpiresAt'] != null ? DateTime.parse(json['accessTokenExpiresAt'] as String) : null,
      tokenType: json['tokenType'] as String?,
      scope: json['scope'] as String?,
      idToken: json['idToken'] as String?,
      sessionState: json['sessionState'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.name,
      'providerId': providerId,
      'accountId': accountId,
      'refreshToken': refreshToken,
      'accessToken': accessToken,
      'accessTokenExpiresAt': accessTokenExpiresAt?.toIso8601String(),
      'tokenType': tokenType,
      'scope': scope,
      'idToken': idToken,
      'sessionState': sessionState,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'user': user.toJson(),
    };
  }

  Account copyWith({
    String? id,
    String? userId,
    AccountType? type,
    String? providerId,
    String? accountId,
    String? refreshToken,
    String? accessToken,
    DateTime? accessTokenExpiresAt,
    String? tokenType,
    String? scope,
    String? idToken,
    String? sessionState,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
  }) {
    return Account(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      providerId: providerId ?? this.providerId,
      accountId: accountId ?? this.accountId,
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
      accessTokenExpiresAt: accessTokenExpiresAt ?? this.accessTokenExpiresAt,
      tokenType: tokenType ?? this.tokenType,
      scope: scope ?? this.scope,
      idToken: idToken ?? this.idToken,
      sessionState: sessionState ?? this.sessionState,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }
}
