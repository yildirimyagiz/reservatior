import 'package:reservatior/shared/enums/source_type.dart';
import 'lead.dart';
import 'organization.dart';

class LeadSource {
  final String id;
  final String orgId;
  final String name;
  final SourceType type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Lead> leads;
  final Organization org;

  const LeadSource({
    required this.id,
    required this.orgId,
    required this.name,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.leads = const [],
    required this.org,
  });

  factory LeadSource.fromJson(Map<String, dynamic> json) {
    return LeadSource(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      type: SourceType.values.firstWhere((v) => v.name == json['type']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      leads: (json['leads'] as List<dynamic>?)?.map((e) => Lead.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'name': name,
      'type': type.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'leads': leads.map((e) => e.toJson()).toList(),
      'org': org.toJson(),
    };
  }

  LeadSource copyWith({
    String? id,
    String? orgId,
    String? name,
    SourceType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Lead>? leads,
    Organization? org,
  }) {
    return LeadSource(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      leads: leads ?? this.leads,
      org: org ?? this.org,
    );
  }
}
