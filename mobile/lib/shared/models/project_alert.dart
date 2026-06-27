import 'project.dart';

class ProjectAlert {
  final String id;
  final String projectId;
  final Project project;
  final String alertType;
  final String title;
  final String message;
  final String severity;
  final bool isRead;
  final bool isResolved;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? resolvedAt;

  const ProjectAlert({
    required this.id,
    required this.projectId,
    required this.project,
    required this.alertType,
    required this.title,
    required this.message,
    required this.severity,
    required this.isRead,
    required this.isResolved,
    required this.createdAt,
    required this.updatedAt,
    this.resolvedAt,
  });

  factory ProjectAlert.fromJson(Map<String, dynamic> json) {
    return ProjectAlert(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      project: Project.fromJson(json['project'] as Map<String, dynamic>),
      alertType: json['alertType'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      severity: json['severity'] as String,
      isRead: json['isRead'] as bool,
      isResolved: json['isResolved'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      resolvedAt: json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'project': project.toJson(),
      'alertType': alertType,
      'title': title,
      'message': message,
      'severity': severity,
      'isRead': isRead,
      'isResolved': isResolved,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'resolvedAt': resolvedAt?.toIso8601String(),
    };
  }

  ProjectAlert copyWith({
    String? id,
    String? projectId,
    Project? project,
    String? alertType,
    String? title,
    String? message,
    String? severity,
    bool? isRead,
    bool? isResolved,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? resolvedAt,
  }) {
    return ProjectAlert(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      project: project ?? this.project,
      alertType: alertType ?? this.alertType,
      title: title ?? this.title,
      message: message ?? this.message,
      severity: severity ?? this.severity,
      isRead: isRead ?? this.isRead,
      isResolved: isResolved ?? this.isResolved,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }
}
