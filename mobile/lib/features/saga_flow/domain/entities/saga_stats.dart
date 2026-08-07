/// Aggregated saga workflow statistics from `GET /system/saga/stats`.
class SagaStats {
  final int totalSagas;
  final int completedSagas;
  final int failedSteps;
  final double avgDurationMs;
  final int running;
  final int failed;
  final int completed;
  final int compensating;
  final Map<String, (int total, int avgDurationMs)> bySagaType;

  const SagaStats({
    required this.totalSagas,
    required this.completedSagas,
    required this.failedSteps,
    required this.avgDurationMs,
    required this.running,
    required this.failed,
    required this.completed,
    required this.compensating,
    required this.bySagaType,
  });

  factory SagaStats.fromJson(Map<String, dynamic> json) {
    final byType = <String, (int, int)>{};
    final raw = json['bySagaType'] as Map<String, dynamic>? ?? {};
    raw.forEach((key, value) {
      final v = value as Map<String, dynamic>? ?? {};
      byType[key] = ((v['total'] as num?)?.toInt() ?? 0,
          (v['avgDurationMs'] as num?)?.toInt() ?? 0);
    });
    return SagaStats(
      totalSagas: (json['totalSagas'] as num?)?.toInt() ?? 0,
      completedSagas: (json['completedSagas'] as num?)?.toInt() ?? 0,
      failedSteps: (json['failedSteps'] as num?)?.toInt() ?? 0,
      avgDurationMs: (json['avgDurationMs'] as num?)?.toDouble() ?? 0,
      running: (json['running'] as num?)?.toInt() ?? 0,
      failed: (json['failed'] as num?)?.toInt() ?? 0,
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      compensating: (json['compensating'] as num?)?.toInt() ?? 0,
      bySagaType: byType,
    );
  }
}
