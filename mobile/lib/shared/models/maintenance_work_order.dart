import 'package:reservatior/shared/enums/priority.dart';
import 'package:reservatior/shared/enums/work_order_status.dart';
import 'contact.dart';
import 'organization.dart';
import 'property.dart';
import 'tenant.dart';
import 'user.dart';

class MaintenanceWorkOrder {
  final String id;
  final String propertyId;
  final String? tenantId;
  final String reportedBy;
  final String title;
  final String description;
  final Priority priority;
  final String category;
  final WorkOrderStatus status;
  final DateTime reportedAt;
  final DateTime? dueDate;
  final String? assignedTo;
  final String? assignedVendor;
  final double? estimatedCost;
  final double? actualCost;
  final String? userId;
  final String? organizationId;
  final bool isActive;
  final Organization? organization;
  final Property property;
  final Tenant? tenant;
  final User? user;
  final User? assignedToUser;
  final List<Contact> contact;

  const MaintenanceWorkOrder({
    required this.id,
    required this.propertyId,
    this.tenantId,
    required this.reportedBy,
    required this.title,
    required this.description,
    required this.priority,
    required this.category,
    required this.status,
    required this.reportedAt,
    this.dueDate,
    this.assignedTo,
    this.assignedVendor,
    this.estimatedCost,
    this.actualCost,
    this.userId,
    this.organizationId,
    required this.isActive,
    this.organization,
    required this.property,
    this.tenant,
    this.user,
    this.assignedToUser,
    this.contact = const [],
  });

  factory MaintenanceWorkOrder.fromJson(Map<String, dynamic> json) {
    return MaintenanceWorkOrder(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      tenantId: json['tenantId'] as String?,
      reportedBy: json['reportedBy'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: Priority.values.firstWhere((v) => v.name == json['priority']),
      category: json['category'] as String,
      status: WorkOrderStatus.values.firstWhere((v) => v.name == json['status']),
      reportedAt: DateTime.parse(json['reportedAt'] as String),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
      assignedTo: json['assignedTo'] as String?,
      assignedVendor: json['assignedVendor'] as String?,
      estimatedCost: (json['estimatedCost'] as num?)?.toDouble(),
      actualCost: (json['actualCost'] as num?)?.toDouble(),
      userId: json['userId'] as String?,
      organizationId: json['organizationId'] as String?,
      isActive: json['isActive'] as bool,
      organization: json['organization'] != null ? Organization.fromJson(json['organization'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
      tenant: json['tenant'] != null ? Tenant.fromJson(json['tenant'] as Map<String, dynamic>) : null,
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
      assignedToUser: json['assignedToUser'] != null ? User.fromJson(json['assignedToUser'] as Map<String, dynamic>) : null,
      contact: (json['Contact'] as List<dynamic>?)?.map((e) => Contact.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'tenantId': tenantId,
      'reportedBy': reportedBy,
      'title': title,
      'description': description,
      'priority': priority.name,
      'category': category,
      'status': status.name,
      'reportedAt': reportedAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'assignedTo': assignedTo,
      'assignedVendor': assignedVendor,
      'estimatedCost': estimatedCost,
      'actualCost': actualCost,
      'userId': userId,
      'organizationId': organizationId,
      'isActive': isActive,
      'organization': organization?.toJson(),
      'property': property.toJson(),
      'tenant': tenant?.toJson(),
      'user': user?.toJson(),
      'assignedToUser': assignedToUser?.toJson(),
      'Contact': contact.map((e) => e.toJson()).toList(),
    };
  }

  MaintenanceWorkOrder copyWith({
    String? id,
    String? propertyId,
    String? tenantId,
    String? reportedBy,
    String? title,
    String? description,
    Priority? priority,
    String? category,
    WorkOrderStatus? status,
    DateTime? reportedAt,
    DateTime? dueDate,
    String? assignedTo,
    String? assignedVendor,
    double? estimatedCost,
    double? actualCost,
    String? userId,
    String? organizationId,
    bool? isActive,
    Organization? organization,
    Property? property,
    Tenant? tenant,
    User? user,
    User? assignedToUser,
    List<Contact>? contact,
  }) {
    return MaintenanceWorkOrder(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      tenantId: tenantId ?? this.tenantId,
      reportedBy: reportedBy ?? this.reportedBy,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      status: status ?? this.status,
      reportedAt: reportedAt ?? this.reportedAt,
      dueDate: dueDate ?? this.dueDate,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedVendor: assignedVendor ?? this.assignedVendor,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      actualCost: actualCost ?? this.actualCost,
      userId: userId ?? this.userId,
      organizationId: organizationId ?? this.organizationId,
      isActive: isActive ?? this.isActive,
      organization: organization ?? this.organization,
      property: property ?? this.property,
      tenant: tenant ?? this.tenant,
      user: user ?? this.user,
      assignedToUser: assignedToUser ?? this.assignedToUser,
      contact: contact ?? this.contact,
    );
  }
}
