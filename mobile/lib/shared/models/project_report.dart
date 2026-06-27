import 'project.dart';

class ProjectReport {
  final String id;
  final String? projectId;
  final Project? project;
  final String reportType;
  final String title;
  final String content;
  final String generatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProjectReport({
    required this.id,
    this.projectId,
    this.project,
    required this.reportType,
    required this.title,
    required this.content,
    required this.generatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectReport.fromJson(Map<String, dynamic> json) {
    return ProjectReport(
      id: json['id'] as String,
      projectId: json['projectId'] as String?,
      project: json['project'] != null ? Project.fromJson(json['project'] as Map<String, dynamic>) : null,
      reportType: json['reportType'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      generatedBy: json['generatedBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'project': project?.toJson(),
      'reportType': reportType,
      'title': title,
      'content': content,
      'generatedBy': generatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ProjectReport copyWith({
    String? id,
    String? projectId,
    Project? project,
    String? reportType,
    String? title,
    String? content,
    String? generatedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProjectReport(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      project: project ?? this.project,
      reportType: reportType ?? this.reportType,
      title: title ?? this.title,
      content: content ?? this.content,
      generatedBy: generatedBy ?? this.generatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
