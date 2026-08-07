class SagaInstance {
  final String id;
  final String name;
  final String status;
  final String sagaType;
  final double progress;
  final String? currentStep;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final String? error;
  final Map<String, dynamic>? payload;

  const SagaInstance({
    required this.id,
    required this.name,
    required this.status,
    required this.sagaType,
    this.progress = 0,
    this.currentStep,
    required this.createdAt,
    this.startedAt,
    this.finishedAt,
    this.error,
    this.payload,
  });

  factory SagaInstance.fromJson(Map<String, dynamic> json) {
    return SagaInstance(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      status: (json['status'] ?? 'PENDING').toString(),
      sagaType: (json['sagaType'] ?? json['type'] ?? 'ORCHESTRATION').toString(),
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
      currentStep: json['currentStep']?.toString(),
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
              DateTime.now(),
      startedAt: DateTime.tryParse(json['startedAt']?.toString() ?? ''),
      finishedAt: DateTime.tryParse(json['finishedAt']?.toString() ?? ''),
      error: json['error']?.toString(),
      payload: json['payload'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'sagaType': sagaType,
      'type': sagaType,
      'progress': progress,
      'currentStep': currentStep,
      'createdAt': createdAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'finishedAt': finishedAt?.toIso8601String(),
      'error': error,
      'payload': payload,
    };
  }
}
