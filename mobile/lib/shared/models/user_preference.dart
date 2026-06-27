import 'organization.dart';
import 'user.dart';

class UserPreference {
  final String id;
  final String userId;
  final String? orgId;
  final String theme;
  final String language;
  final String timezone;
  final String dateFormat;
  final String currency;
  final bool emailNotifications;
  final bool pushNotifications;
  final bool marketingEmails;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization? org;
  final User user;

  const UserPreference({
    required this.id,
    required this.userId,
    this.orgId,
    required this.theme,
    required this.language,
    required this.timezone,
    required this.dateFormat,
    required this.currency,
    required this.emailNotifications,
    required this.pushNotifications,
    required this.marketingEmails,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.org,
    required this.user,
  });

  factory UserPreference.fromJson(Map<String, dynamic> json) {
    return UserPreference(
      id: json['id'] as String,
      userId: json['userId'] as String,
      orgId: json['orgId'] as String?,
      theme: json['theme'] as String,
      language: json['language'] as String,
      timezone: json['timezone'] as String,
      dateFormat: json['dateFormat'] as String,
      currency: json['currency'] as String,
      emailNotifications: json['emailNotifications'] as bool,
      pushNotifications: json['pushNotifications'] as bool,
      marketingEmails: json['marketingEmails'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'orgId': orgId,
      'theme': theme,
      'language': language,
      'timezone': timezone,
      'dateFormat': dateFormat,
      'currency': currency,
      'emailNotifications': emailNotifications,
      'pushNotifications': pushNotifications,
      'marketingEmails': marketingEmails,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org?.toJson(),
      'user': user.toJson(),
    };
  }

  UserPreference copyWith({
    String? id,
    String? userId,
    String? orgId,
    String? theme,
    String? language,
    String? timezone,
    String? dateFormat,
    String? currency,
    bool? emailNotifications,
    bool? pushNotifications,
    bool? marketingEmails,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    User? user,
  }) {
    return UserPreference(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orgId: orgId ?? this.orgId,
      theme: theme ?? this.theme,
      language: language ?? this.language,
      timezone: timezone ?? this.timezone,
      dateFormat: dateFormat ?? this.dateFormat,
      currency: currency ?? this.currency,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      marketingEmails: marketingEmails ?? this.marketingEmails,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
