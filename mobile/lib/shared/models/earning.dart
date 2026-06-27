import 'package:reservatior/shared/enums/earning_type.dart';
import 'organization.dart';
import 'user.dart';

class Earning {
  final String id;
  final String orgId;
  final String? userId;
  final String name;
  final EarningType type;
  final double? percentage;
  final double? fixedAmount;
  final bool appliesToUsers;
  final bool appliesToAgents;
  final bool appliesToVendors;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization org;
  final User? user;

  const Earning({
    required this.id,
    required this.orgId,
    this.userId,
    required this.name,
    required this.type,
    this.percentage,
    this.fixedAmount,
    required this.appliesToUsers,
    required this.appliesToAgents,
    required this.appliesToVendors,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.org,
    this.user,
  });

  factory Earning.fromJson(Map<String, dynamic> json) {
    return Earning(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String?,
      name: json['name'] as String,
      type: EarningType.values.firstWhere((v) => v.name == json['type']),
      percentage: (json['percentage'] as num?)?.toDouble(),
      fixedAmount: (json['fixedAmount'] as num?)?.toDouble(),
      appliesToUsers: json['appliesToUsers'] as bool,
      appliesToAgents: json['appliesToAgents'] as bool,
      appliesToVendors: json['appliesToVendors'] as bool,
      isActive: json['isActive'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
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
      'type': type.name,
      'percentage': percentage,
      'fixedAmount': fixedAmount,
      'appliesToUsers': appliesToUsers,
      'appliesToAgents': appliesToAgents,
      'appliesToVendors': appliesToVendors,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org.toJson(),
      'user': user?.toJson(),
    };
  }

  Earning copyWith({
    String? id,
    String? orgId,
    String? userId,
    String? name,
    EarningType? type,
    double? percentage,
    double? fixedAmount,
    bool? appliesToUsers,
    bool? appliesToAgents,
    bool? appliesToVendors,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
    User? user,
  }) {
    return Earning(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      percentage: percentage ?? this.percentage,
      fixedAmount: fixedAmount ?? this.fixedAmount,
      appliesToUsers: appliesToUsers ?? this.appliesToUsers,
      appliesToAgents: appliesToAgents ?? this.appliesToAgents,
      appliesToVendors: appliesToVendors ?? this.appliesToVendors,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
