import 'agency.dart';
import 'agent.dart';
import 'extra_charge.dart';
import 'included_service.dart';
import 'organization.dart';
import 'reference_source.dart';
import 'report_execution.dart';
import 'tenant.dart';
import 'user.dart';

class Report {
  final String id;
  final String orgId;
  final String userId;
  final String name;
  final String? description;
  final String reportType;
  final DateTime? lastRunAt;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;
  final User user;
  final List<ReportExecution> executions;
  final List<Agent> agents;
  final List<ExtraCharge> extraCharges;
  final List<Agency> agencies;
  final List<ReferenceSource> referenceSources;
  final List<Tenant> tenants;
  final List<IncludedService> includedServices;

  const Report({
    required this.id,
    required this.orgId,
    required this.userId,
    required this.name,
    this.description,
    required this.reportType,
    this.lastRunAt,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
    required this.user,
    this.executions = const [],
    this.agents = const [],
    this.extraCharges = const [],
    this.agencies = const [],
    this.referenceSources = const [],
    this.tenants = const [],
    this.includedServices = const [],
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      reportType: json['reportType'] as String,
      lastRunAt: json['lastRunAt'] != null ? DateTime.parse(json['lastRunAt'] as String) : null,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      executions: (json['executions'] as List<dynamic>?)?.map((e) => ReportExecution.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agents: (json['agents'] as List<dynamic>?)?.map((e) => Agent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      extraCharges: (json['extraCharges'] as List<dynamic>?)?.map((e) => ExtraCharge.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      referenceSources: (json['referenceSources'] as List<dynamic>?)?.map((e) => ReferenceSource.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tenants: (json['tenants'] as List<dynamic>?)?.map((e) => Tenant.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      includedServices: (json['includedServices'] as List<dynamic>?)?.map((e) => IncludedService.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userId': userId,
      'name': name,
      'description': description,
      'reportType': reportType,
      'lastRunAt': lastRunAt?.toIso8601String(),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
      'user': user.toJson(),
      'executions': executions.map((e) => e.toJson()).toList(),
      'agents': agents.map((e) => e.toJson()).toList(),
      'extraCharges': extraCharges.map((e) => e.toJson()).toList(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'referenceSources': referenceSources.map((e) => e.toJson()).toList(),
      'tenants': tenants.map((e) => e.toJson()).toList(),
      'includedServices': includedServices.map((e) => e.toJson()).toList(),
    };
  }

  Report copyWith({
    String? id,
    String? orgId,
    String? userId,
    String? name,
    String? description,
    String? reportType,
    DateTime? lastRunAt,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
    User? user,
    List<ReportExecution>? executions,
    List<Agent>? agents,
    List<ExtraCharge>? extraCharges,
    List<Agency>? agencies,
    List<ReferenceSource>? referenceSources,
    List<Tenant>? tenants,
    List<IncludedService>? includedServices,
  }) {
    return Report(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      reportType: reportType ?? this.reportType,
      lastRunAt: lastRunAt ?? this.lastRunAt,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
      user: user ?? this.user,
      executions: executions ?? this.executions,
      agents: agents ?? this.agents,
      extraCharges: extraCharges ?? this.extraCharges,
      agencies: agencies ?? this.agencies,
      referenceSources: referenceSources ?? this.referenceSources,
      tenants: tenants ?? this.tenants,
      includedServices: includedServices ?? this.includedServices,
    );
  }
}
