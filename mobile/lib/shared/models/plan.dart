import 'org_subscription.dart';

class Plan {
  final String id;
  final String key;
  final String name;
  final int? priceMonthlyCents;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<OrgSubscription> orgSubscriptions;

  const Plan({
    required this.id,
    required this.key,
    required this.name,
    this.priceMonthlyCents,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.orgSubscriptions = const [],
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] as String,
      key: json['key'] as String,
      name: json['name'] as String,
      priceMonthlyCents: json['priceMonthlyCents'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      orgSubscriptions: (json['orgSubscriptions'] as List<dynamic>?)?.map((e) => OrgSubscription.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'name': name,
      'priceMonthlyCents': priceMonthlyCents,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'orgSubscriptions': orgSubscriptions.map((e) => e.toJson()).toList(),
    };
  }

  Plan copyWith({
    String? id,
    String? key,
    String? name,
    int? priceMonthlyCents,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<OrgSubscription>? orgSubscriptions,
  }) {
    return Plan(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      priceMonthlyCents: priceMonthlyCents ?? this.priceMonthlyCents,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      orgSubscriptions: orgSubscriptions ?? this.orgSubscriptions,
    );
  }
}
