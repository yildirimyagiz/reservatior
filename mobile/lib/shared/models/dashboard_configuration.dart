import 'organization.dart';
import 'user.dart';

class DashboardConfiguration {
  final String id;
  final String userId;
  final String? orgId;
  final String dashboardName;
  final bool isDefault;
  final String timeRange;
  final bool isPublic;
  final List<String> sharedWith;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization? org;
  final User user;

  const DashboardConfiguration({
    required this.id,
    required this.userId,
    this.orgId,
    required this.dashboardName,
    required this.isDefault,
    required this.timeRange,
    required this.isPublic,
    this.sharedWith = const [],
    required this.createdAt,
    required this.updatedAt,
    this.org,
    required this.user,
  });

  factory DashboardConfiguration.fromJson(Map<String, dynamic> json) {
    return DashboardConfiguration(
      id: json['id'] as String,
      userId: json['userId'] as String,
      orgId: json['orgId'] as String?,
      dashboardName: json['dashboardName'] as String,
      isDefault: json['isDefault'] as bool,
      timeRange: json['timeRange'] as String,
      isPublic: json['isPublic'] as bool,
      sharedWith: (json['sharedWith'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'orgId': orgId,
      'dashboardName': dashboardName,
      'isDefault': isDefault,
      'timeRange': timeRange,
      'isPublic': isPublic,
      'sharedWith': sharedWith,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org?.toJson(),
      'user': user.toJson(),
    };
  }

  DashboardConfiguration copyWith({
    String? id,
    String? userId,
    String? orgId,
    String? dashboardName,
    bool? isDefault,
    String? timeRange,
    bool? isPublic,
    List<String>? sharedWith,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
    User? user,
  }) {
    return DashboardConfiguration(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orgId: orgId ?? this.orgId,
      dashboardName: dashboardName ?? this.dashboardName,
      isDefault: isDefault ?? this.isDefault,
      timeRange: timeRange ?? this.timeRange,
      isPublic: isPublic ?? this.isPublic,
      sharedWith: sharedWith ?? this.sharedWith,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
