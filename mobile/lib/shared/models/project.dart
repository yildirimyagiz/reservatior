import 'contact.dart';
import 'organization.dart';
import 'project_alert.dart';
import 'project_analytics.dart';
import 'project_report.dart';
import 'property.dart';
import 'task.dart';
import 'user.dart';

class Project {
  final String id;
  final String orgId;
  final String name;
  final String? description;
  final String projectType;
  final String? propertyId;
  final String? addres;
  final String status;
  final DateTime? startDate;
  final DateTime? estimatedEndDate;
  final DateTime? actualEndDate;
  final double? budget;
  final String currency;
  final double? actualCost;
  final String? managerId;
  final String? contractorId;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contact? contractor;
  final User? manager;
  final Organization org;
  final Property? property;
  final List<Task> tasks;
  final List<ProjectAlert> projectAlerts;
  final List<ProjectAnalytics> projectAnalytics;
  final List<ProjectReport> projectReports;

  const Project({
    required this.id,
    required this.orgId,
    required this.name,
    this.description,
    required this.projectType,
    this.propertyId,
    this.addres,
    required this.status,
    this.startDate,
    this.estimatedEndDate,
    this.actualEndDate,
    this.budget,
    required this.currency,
    this.actualCost,
    this.managerId,
    this.contractorId,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.contractor,
    this.manager,
    required this.org,
    this.property,
    this.tasks = const [],
    this.projectAlerts = const [],
    this.projectAnalytics = const [],
    this.projectReports = const [],
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      projectType: json['projectType'] as String,
      propertyId: json['propertyId'] as String?,
      addres: json['Addres'] as String?,
      status: json['status'] as String,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate'] as String) : null,
      estimatedEndDate: json['estimatedEndDate'] != null ? DateTime.parse(json['estimatedEndDate'] as String) : null,
      actualEndDate: json['actualEndDate'] != null ? DateTime.parse(json['actualEndDate'] as String) : null,
      budget: (json['budget'] as num?)?.toDouble(),
      currency: json['currency'] as String,
      actualCost: (json['actualCost'] as num?)?.toDouble(),
      managerId: json['managerId'] as String?,
      contractorId: json['contractorId'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contractor: json['contractor'] != null ? Contact.fromJson(json['contractor'] as Map<String, dynamic>) : null,
      manager: json['manager'] != null ? User.fromJson(json['manager'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      projectAlerts: (json['projectAlerts'] as List<dynamic>?)?.map((e) => ProjectAlert.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      projectAnalytics: (json['projectAnalytics'] as List<dynamic>?)?.map((e) => ProjectAnalytics.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      projectReports: (json['projectReports'] as List<dynamic>?)?.map((e) => ProjectReport.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'name': name,
      'description': description,
      'projectType': projectType,
      'propertyId': propertyId,
      'Addres': addres,
      'status': status,
      'startDate': startDate?.toIso8601String(),
      'estimatedEndDate': estimatedEndDate?.toIso8601String(),
      'actualEndDate': actualEndDate?.toIso8601String(),
      'budget': budget,
      'currency': currency,
      'actualCost': actualCost,
      'managerId': managerId,
      'contractorId': contractorId,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contractor': contractor?.toJson(),
      'manager': manager?.toJson(),
      'org': org.toJson(),
      'property': property?.toJson(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'projectAlerts': projectAlerts.map((e) => e.toJson()).toList(),
      'projectAnalytics': projectAnalytics.map((e) => e.toJson()).toList(),
      'projectReports': projectReports.map((e) => e.toJson()).toList(),
    };
  }

  Project copyWith({
    String? id,
    String? orgId,
    String? name,
    String? description,
    String? projectType,
    String? propertyId,
    String? addres,
    String? status,
    DateTime? startDate,
    DateTime? estimatedEndDate,
    DateTime? actualEndDate,
    double? budget,
    String? currency,
    double? actualCost,
    String? managerId,
    String? contractorId,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contact? contractor,
    User? manager,
    Organization? org,
    Property? property,
    List<Task>? tasks,
    List<ProjectAlert>? projectAlerts,
    List<ProjectAnalytics>? projectAnalytics,
    List<ProjectReport>? projectReports,
  }) {
    return Project(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      name: name ?? this.name,
      description: description ?? this.description,
      projectType: projectType ?? this.projectType,
      propertyId: propertyId ?? this.propertyId,
      addres: addres ?? this.addres,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      estimatedEndDate: estimatedEndDate ?? this.estimatedEndDate,
      actualEndDate: actualEndDate ?? this.actualEndDate,
      budget: budget ?? this.budget,
      currency: currency ?? this.currency,
      actualCost: actualCost ?? this.actualCost,
      managerId: managerId ?? this.managerId,
      contractorId: contractorId ?? this.contractorId,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contractor: contractor ?? this.contractor,
      manager: manager ?? this.manager,
      org: org ?? this.org,
      property: property ?? this.property,
      tasks: tasks ?? this.tasks,
      projectAlerts: projectAlerts ?? this.projectAlerts,
      projectAnalytics: projectAnalytics ?? this.projectAnalytics,
      projectReports: projectReports ?? this.projectReports,
    );
  }
}
