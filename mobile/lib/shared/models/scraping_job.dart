

class ScrapingJob {
  final String id;
  final String jobType;
  final String status;
  final DateTime? startTime;
  final DateTime? endTime;
  final int projectsScraped;
  final List<String> errors;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ScrapingJob({
    required this.id,
    required this.jobType,
    required this.status,
    this.startTime,
    this.endTime,
    required this.projectsScraped,
    this.errors = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScrapingJob.fromJson(Map<String, dynamic> json) {
    return ScrapingJob(
      id: json['id'] as String,
      jobType: json['jobType'] as String,
      status: json['status'] as String,
      startTime: json['startTime'] != null ? DateTime.parse(json['startTime'] as String) : null,
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime'] as String) : null,
      projectsScraped: json['projectsScraped'] as int,
      errors: (json['errors'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobType': jobType,
      'status': status,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'projectsScraped': projectsScraped,
      'errors': errors,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ScrapingJob copyWith({
    String? id,
    String? jobType,
    String? status,
    DateTime? startTime,
    DateTime? endTime,
    int? projectsScraped,
    List<String>? errors,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScrapingJob(
      id: id ?? this.id,
      jobType: jobType ?? this.jobType,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      projectsScraped: projectsScraped ?? this.projectsScraped,
      errors: errors ?? this.errors,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
