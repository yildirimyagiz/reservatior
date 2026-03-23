//***  AUTO-GENERATED FILE - DO NOT MODIFY ***//

import '../abcx3_common.library.dart';
import 'goal_type.dart';
import 'organization.dart';
import 'user.dart';

class Achievement implements PrismaModel<String, Achievement>, Id<String> {
  @override
  String? id;
  String? userId;
  GoalType? goalType;
  int? goalValue;
  int? currentValue;
  bool? isCompleted;
  DateTime? completedAt;
  int? pointsReward;
  String? bonusReward;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? organizationId;
  Organization? organization;
  User? user;

  Set<String> $assignedFields = {};

  /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
  Achievement({
    this.id,
    this.userId,
    this.goalType,
    this.goalValue,
    this.currentValue = 0,
    this.isCompleted = false,
    this.completedAt,
    this.pointsReward = 0,
    this.bonusReward,
    this.createdAt,
    this.updatedAt,
    this.organizationId,
    this.organization,
    this.user,
    this.$assignedFields = const {},
  });

  @override
  String? get $uid => id;

  Map<String, GetPropertyValueFunction<Achievement, dynamic>>
      propertyValueFunctionMap = {
    "id": (m) => m.id,
    "userId": (m) => m.userId,
    "goalType": (m) => m.goalType,
    "goalValue": (m) => m.goalValue,
    "currentValue": (m) => m.currentValue,
    "isCompleted": (m) => m.isCompleted,
    "completedAt": (m) => m.completedAt,
    "pointsReward": (m) => m.pointsReward,
    "bonusReward": (m) => m.bonusReward,
    "createdAt": (m) => m.createdAt,
    "updatedAt": (m) => m.updatedAt,
    "organizationId": (m) => m.organizationId,
    "organization": (m) => m.organization,
    "user": (m) => m.user,
  };

  /// gets a function by property name that returns the property value from the model
  @override
  V? Function(Achievement) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Achievement');
    }
    return propFunction as V? Function(Achievement);
  }

  @override
  bool equalById(UID<String> other) => $uid == other.$uid;

  /// Creates a new instance of this class from a JSON object.
  @override
  factory Achievement.fromJson(JsonMap json) => Achievement(
        id: json['id'] as String?,
        userId: json['userId'] as String?,
        goalType: json['goalType'] != null
            ? GoalType.fromJson(json['goalType'])
            : null,
        goalValue: int.tryParse(json['goalValue'].toString()),
        currentValue: int.tryParse(json['currentValue'].toString()),
        isCompleted: json['isCompleted'] as bool?,
        completedAt: json['completedAt'] != null
            ? DateTime.parse(json['completedAt'])
            : null,
        pointsReward: int.tryParse(json['pointsReward'].toString()),
        bonusReward: json['bonusReward'] as String?,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : null,
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'])
            : null,
        organizationId: json['organizationId'] as String?,
        organization: json['organization'] != null
            ? Organization.fromJson(json['organization'] as JsonMap)
            : null,
        user: json['user'] != null
            ? User.fromJson(json['user'] as JsonMap)
            : null,
        $assignedFields: json.keys.toSet(),
      );

  /// Creates a new instance populated with the values of this instance and the given values,
  /// where the given values has precedence.
  @override
  Achievement copyWith({
    Value<String?>? id,
    Value<String?>? userId,
    Value<GoalType?>? goalType,
    Value<int?>? goalValue,
    Value<int?>? currentValue,
    Value<bool?>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<int?>? pointsReward,
    Value<String?>? bonusReward,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<String?>? organizationId,
    Value<Organization?>? organization,
    Value<User?>? user,
  }) {
    return Achievement(
        id: id != null ? id.value : this.id,
        userId: userId != null ? userId.value : this.userId,
        goalType: goalType != null ? goalType.value : this.goalType,
        goalValue: goalValue != null ? goalValue.value : this.goalValue,
        currentValue:
            currentValue != null ? currentValue.value : this.currentValue,
        isCompleted: isCompleted != null ? isCompleted.value : this.isCompleted,
        completedAt: completedAt != null ? completedAt.value : this.completedAt,
        pointsReward:
            pointsReward != null ? pointsReward.value : this.pointsReward,
        bonusReward: bonusReward != null ? bonusReward.value : this.bonusReward,
        createdAt: createdAt != null ? createdAt.value : this.createdAt,
        updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
        organizationId:
            organizationId != null ? organizationId.value : this.organizationId,
        organization:
            organization != null ? organization.value : this.organization,
        user: user != null ? user.value : this.user);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.

  @override
  Achievement copyWithInstanceValues(Achievement achievement) {
    return Achievement(
        id: achievement.id ?? id,
        userId: achievement.userId ?? userId,
        goalType: achievement.goalType ?? goalType,
        goalValue: achievement.goalValue ?? goalValue,
        currentValue: achievement.currentValue ?? currentValue,
        isCompleted: achievement.isCompleted ?? isCompleted,
        completedAt: achievement.completedAt ?? completedAt,
        pointsReward: achievement.pointsReward ?? pointsReward,
        bonusReward: achievement.bonusReward ?? bonusReward,
        createdAt: achievement.createdAt ?? createdAt,
        updatedAt: achievement.updatedAt ?? updatedAt,
        organizationId: achievement.organizationId ?? organizationId,
        organization: achievement.organization ?? organization,
        user: achievement.user ?? user);
  }

  /// Creates a new instance populated with the values of this instance and the given instance,
  /// where the given instance's values has precedence.
  /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

  @override
  Achievement mergeWithInstanceValues(Achievement achievement) {
    return Achievement(
        id: achievement.$assignedFields.contains('id') ? achievement.id : id,
        userId: achievement.$assignedFields.contains('userId')
            ? achievement.userId
            : userId,
        goalType: achievement.$assignedFields.contains('goalType')
            ? achievement.goalType
            : goalType,
        goalValue: achievement.$assignedFields.contains('goalValue')
            ? achievement.goalValue
            : goalValue,
        currentValue: achievement.$assignedFields.contains('currentValue')
            ? achievement.currentValue
            : currentValue,
        isCompleted: achievement.$assignedFields.contains('isCompleted')
            ? achievement.isCompleted
            : isCompleted,
        completedAt: achievement.$assignedFields.contains('completedAt')
            ? achievement.completedAt
            : completedAt,
        pointsReward: achievement.$assignedFields.contains('pointsReward')
            ? achievement.pointsReward
            : pointsReward,
        bonusReward: achievement.$assignedFields.contains('bonusReward')
            ? achievement.bonusReward
            : bonusReward,
        createdAt: achievement.$assignedFields.contains('createdAt')
            ? achievement.createdAt
            : createdAt,
        updatedAt: achievement.$assignedFields.contains('updatedAt')
            ? achievement.updatedAt
            : updatedAt,
        organizationId: achievement.$assignedFields.contains('organizationId')
            ? achievement.organizationId
            : organizationId,
        organization: achievement.$assignedFields.contains('organization')
            ? achievement.organization
            : organization,
        user: achievement.$assignedFields.contains('user')
            ? achievement.user
            : user);
  }

  /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

  @override
  Achievement updateWithInstanceValues(Achievement achievement) {
    if (achievement.$assignedFields.contains('id')) {
      id = achievement.id;
    }
    if (achievement.$assignedFields.contains('userId')) {
      userId = achievement.userId;
    }
    if (achievement.$assignedFields.contains('goalType')) {
      goalType = achievement.goalType;
    }
    if (achievement.$assignedFields.contains('goalValue')) {
      goalValue = achievement.goalValue;
    }
    if (achievement.$assignedFields.contains('currentValue')) {
      currentValue = achievement.currentValue;
    }
    if (achievement.$assignedFields.contains('isCompleted')) {
      isCompleted = achievement.isCompleted;
    }
    if (achievement.$assignedFields.contains('completedAt')) {
      completedAt = achievement.completedAt;
    }
    if (achievement.$assignedFields.contains('pointsReward')) {
      pointsReward = achievement.pointsReward;
    }
    if (achievement.$assignedFields.contains('bonusReward')) {
      bonusReward = achievement.bonusReward;
    }
    if (achievement.$assignedFields.contains('createdAt')) {
      createdAt = achievement.createdAt;
    }
    if (achievement.$assignedFields.contains('updatedAt')) {
      updatedAt = achievement.updatedAt;
    }
    if (achievement.$assignedFields.contains('organizationId')) {
      organizationId = achievement.organizationId;
    }
    if (achievement.$assignedFields.contains('organization')) {
      organization = achievement.organization;
    }
    if (achievement.$assignedFields.contains('user')) {
      user = achievement.user;
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
        ? {...?serializedTypes, 'Achievement'}
        : const {};
    return {
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId,
      if (goalType != null) 'goalType': goalType?.toJson(),
      if (goalValue != null) 'goalValue': goalValue,
      if (currentValue != null) 'currentValue': currentValue,
      if (isCompleted != null) 'isCompleted': isCompleted,
      if (completedAt != null) 'completedAt': completedAt?.toIso8601String(),
      if (pointsReward != null) 'pointsReward': pointsReward,
      if (bonusReward != null) 'bonusReward': bonusReward,
      if (createdAt != null) 'createdAt': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
      if (organizationId != null) 'organizationId': organizationId,
      if (organization != null &&
          (!preventCircularSerialization ||
              !serializedModels.contains('Organization')))
        'organization': organization?.toJson(
            serializedTypes: serializedModels,
            preventCircularSerialization: preventCircularSerialization),
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
      other is Achievement &&
          runtimeType == other.runtimeType &&
          $uid == other.$uid;

  /// Updates this instance with the values of the given instance,
  /// where this instance has precedence.
  @override
  int get hashCode => $uid.hashCode;
}
