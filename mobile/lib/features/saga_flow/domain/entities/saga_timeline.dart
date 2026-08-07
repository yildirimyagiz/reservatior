/// A single recorded step within a saga workflow timeline.
class SagaStep {
  final String step;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int? durationMs;
  final int retryCount;
  final String outcome;
  final String? error;

  const SagaStep({
    required this.step,
    this.startedAt,
    this.completedAt,
    this.durationMs,
    this.retryCount = 0,
    required this.outcome,
    this.error,
  });

  factory SagaStep.fromJson(Map<String, dynamic> json) {
    return SagaStep(
      step: (json['step'] ?? '').toString(),
      startedAt: DateTime.tryParse(json['startedAt']?.toString() ?? ''),
      completedAt: DateTime.tryParse(json['completedAt']?.toString() ?? ''),
      durationMs: (json['durationMs'] as num?)?.toInt(),
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      outcome: (json['outcome'] ?? 'UNKNOWN').toString(),
      error: json['error']?.toString(),
    );
  }
}

/// Full observability view for one saga workflow instance.
class SagaTimeline {
  final String sagaId;
  final String sagaType;
  final String status;
  final int totalDurationMs;
  final List<SagaStep> steps;

  const SagaTimeline({
    required this.sagaId,
    required this.sagaType,
    required this.status,
    required this.totalDurationMs,
    required this.steps,
  });

  factory SagaTimeline.fromJson(Map<String, dynamic> json) {
    return SagaTimeline(
      sagaId: (json['sagaId'] ?? '').toString(),
      sagaType: (json['sagaType'] ?? 'UNKNOWN').toString(),
      status: (json['status'] ?? 'RUNNING').toString(),
      totalDurationMs: (json['totalDurationMs'] as num?)?.toInt() ?? 0,
      steps: (json['steps'] as List? ?? [])
          .map((s) => SagaStep.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Current step label (last recorded step, falling back to status).
  String get currentStep =>
      steps.isNotEmpty ? steps.last.step : status;

  /// Aggregate progress from SUCCESS steps (rough completion heuristic).
  double get progress {
    if (steps.isEmpty) return 0;
    final success = steps.where((s) => s.outcome == 'SUCCESS').length;
    return (success / steps.length).clamp(0.0, 1.0);
  }
}
