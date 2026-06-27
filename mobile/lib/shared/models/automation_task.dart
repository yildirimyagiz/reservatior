

class AutomationTask {
  final String id;
  final String taskType;
  final String? persona;
  final String? command;
  final String status;
  final String? schedule;
  final DateTime? lastRun;
  final DateTime? nextRun;
  final String? error;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AutomationTask({
    required this.id,
    required this.taskType,
    this.persona,
    this.command,
    required this.status,
    this.schedule,
    this.lastRun,
    this.nextRun,
    this.error,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AutomationTask.fromJson(Map<String, dynamic> json) {
    return AutomationTask(
      id: json['id'] as String,
      taskType: json['taskType'] as String,
      persona: json['persona'] as String?,
      command: json['command'] as String?,
      status: json['status'] as String,
      schedule: json['schedule'] as String?,
      lastRun: json['lastRun'] != null ? DateTime.parse(json['lastRun'] as String) : null,
      nextRun: json['nextRun'] != null ? DateTime.parse(json['nextRun'] as String) : null,
      error: json['error'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskType': taskType,
      'persona': persona,
      'command': command,
      'status': status,
      'schedule': schedule,
      'lastRun': lastRun?.toIso8601String(),
      'nextRun': nextRun?.toIso8601String(),
      'error': error,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  AutomationTask copyWith({
    String? id,
    String? taskType,
    String? persona,
    String? command,
    String? status,
    String? schedule,
    DateTime? lastRun,
    DateTime? nextRun,
    String? error,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AutomationTask(
      id: id ?? this.id,
      taskType: taskType ?? this.taskType,
      persona: persona ?? this.persona,
      command: command ?? this.command,
      status: status ?? this.status,
      schedule: schedule ?? this.schedule,
      lastRun: lastRun ?? this.lastRun,
      nextRun: nextRun ?? this.nextRun,
      error: error ?? this.error,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
