import 'project.dart';

class ProjectAnalytics {
  final String id;
  final String projectId;
  final Project project;
  final String analysisType;
  final List<String> insights;
  final List<String> recommendations;
  final double? score;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProjectAnalytics({
    required this.id,
    required this.projectId,
    required this.project,
    required this.analysisType,
    this.insights = const [],
    this.recommendations = const [],
    this.score,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectAnalytics.fromJson(Map<String, dynamic> json) {
    return ProjectAnalytics(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      project: Project.fromJson(json['project'] as Map<String, dynamic>),
      analysisType: json['analysisType'] as String,
      insights: (json['insights'] as List<dynamic>?)?.cast<String>() ?? [],
      recommendations: (json['recommendations'] as List<dynamic>?)?.cast<String>() ?? [],
      score: (json['score'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'project': project.toJson(),
      'analysisType': analysisType,
      'insights': insights,
      'recommendations': recommendations,
      'score': score,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ProjectAnalytics copyWith({
    String? id,
    String? projectId,
    Project? project,
    String? analysisType,
    List<String>? insights,
    List<String>? recommendations,
    double? score,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProjectAnalytics(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      project: project ?? this.project,
      analysisType: analysisType ?? this.analysisType,
      insights: insights ?? this.insights,
      recommendations: recommendations ?? this.recommendations,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
