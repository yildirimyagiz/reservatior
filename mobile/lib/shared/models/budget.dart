import 'organization.dart';
import 'user.dart';

class Budget {
  final String id;
  final String orgId;
  final String? userId;
  final String name;
  final String? description;
  final String budgetType;
  final String period;
  final DateTime startDate;
  final DateTime endDate;
  final double totalAmount;
  final String currency;
  final double actualSpent;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final User? user;

  const Budget({
    required this.id,
    required this.orgId,
    this.userId,
    required this.name,
    this.description,
    required this.budgetType,
    required this.period,
    required this.startDate,
    required this.endDate,
    required this.totalAmount,
    required this.currency,
    required this.actualSpent,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    this.user,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      budgetType: json['budgetType'] as String,
      period: json['period'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      actualSpent: (json['actualSpent'] as num).toDouble(),
      isActive: json['isActive'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userId': userId,
      'name': name,
      'description': description,
      'budgetType': budgetType,
      'period': period,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'totalAmount': totalAmount,
      'currency': currency,
      'actualSpent': actualSpent,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'user': user?.toJson(),
    };
  }

  Budget copyWith({
    String? id,
    String? orgId,
    String? userId,
    String? name,
    String? description,
    String? budgetType,
    String? period,
    DateTime? startDate,
    DateTime? endDate,
    double? totalAmount,
    String? currency,
    double? actualSpent,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    User? user,
  }) {
    return Budget(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      budgetType: budgetType ?? this.budgetType,
      period: period ?? this.period,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalAmount: totalAmount ?? this.totalAmount,
      currency: currency ?? this.currency,
      actualSpent: actualSpent ?? this.actualSpent,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
