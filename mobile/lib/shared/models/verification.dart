

class Verification {
  final String id;
  final String identifier;
  final String value;
  final DateTime expiresAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Verification({
    required this.id,
    required this.identifier,
    required this.value,
    required this.expiresAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      id: json['id'] as String,
      identifier: json['identifier'] as String,
      value: json['value'] as String,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identifier': identifier,
      'value': value,
      'expiresAt': expiresAt.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Verification copyWith({
    String? id,
    String? identifier,
    String? value,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Verification(
      id: id ?? this.id,
      identifier: identifier ?? this.identifier,
      value: value ?? this.value,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
