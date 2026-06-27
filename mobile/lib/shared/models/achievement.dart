import 'package:reservatior/shared/enums/goal_type.dart';
import 'organization.dart';
import 'user.dart';

class Achievement {
  final String id;
  final String userId;
  final GoalType goalType;
  final int goalValue;
  final int currentValue;
  final bool isCompleted;
  final DateTime? completedAt;
  final int pointsReward;
  final String? bonusReward;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? organizationId;
  final Organization? organization;
  final User user;

  const Achievement({
    required this.id,
    required this.userId,
    required this.goalType,
    required this.goalValue,
    required this.currentValue,
    required this.isCompleted,
    this.completedAt,
    required this.pointsReward,
    this.bonusReward,
    required this.createdAt,
    required this.updatedAt,
    this.organizationId,
    this.organization,
    required this.user,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      userId: json['userId'] as String,
      goalType: GoalType.values.firstWhere((v) => v.name == json['goalType']),
      goalValue: json['goalValue'] as int,
      currentValue: json['currentValue'] as int,
      isCompleted: json['isCompleted'] as bool,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt'] as String) : null,
      pointsReward: json['pointsReward'] as int,
      bonusReward: json['bonusReward'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      organizationId: json['organizationId'] as String?,
      organization: json['organization'] != null ? Organization.fromJson(json['organization'] as Map<String, dynamic>) : null,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'goalType': goalType.name,
      'goalValue': goalValue,
      'currentValue': currentValue,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
      'pointsReward': pointsReward,
      'bonusReward': bonusReward,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'organizationId': organizationId,
      'organization': organization?.toJson(),
      'user': user.toJson(),
    };
  }

  Achievement copyWith({
    String? id,
    String? userId,
    GoalType? goalType,
    int? goalValue,
    int? currentValue,
    bool? isCompleted,
    DateTime? completedAt,
    int? pointsReward,
    String? bonusReward,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? organizationId,
    Organization? organization,
    User? user,
  }) {
    return Achievement(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      goalType: goalType ?? this.goalType,
      goalValue: goalValue ?? this.goalValue,
      currentValue: currentValue ?? this.currentValue,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      pointsReward: pointsReward ?? this.pointsReward,
      bonusReward: bonusReward ?? this.bonusReward,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      organizationId: organizationId ?? this.organizationId,
      organization: organization ?? this.organization,
      user: user ?? this.user,
    );
  }
}
