class SagaConfig {
  final String id;
  final String name;
  final String? description;
  final int timeoutSeconds;
  final int maxRetries;
  final int backoffMs;
  final bool enabled;

  const SagaConfig({
    required this.id,
    required this.name,
    this.description,
    this.timeoutSeconds = 300,
    this.maxRetries = 3,
    this.backoffMs = 1000,
    this.enabled = true,
  });

  factory SagaConfig.fromJson(Map<String, dynamic> json) {
    return SagaConfig(
      id: (json['id'] ?? json['configId'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      description: json['description']?.toString(),
      timeoutSeconds: (json['timeoutSeconds'] as num?)?.toInt() ?? 300,
      maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 3,
      backoffMs: (json['backoffMs'] as num?)?.toInt() ?? 1000,
      enabled: json['enabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'timeoutSeconds': timeoutSeconds,
      'maxRetries': maxRetries,
      'backoffMs': backoffMs,
      'enabled': enabled,
    };
  }
}
