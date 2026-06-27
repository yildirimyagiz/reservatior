import 'organization.dart';

class ExchangeRate {
  final String id;
  final String orgId;
  final String baseCurrency;
  final String quoteCurrency;
  final double rate;
  final DateTime asOfDate;
  final String? source;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Organization org;

  const ExchangeRate({
    required this.id,
    required this.orgId,
    required this.baseCurrency,
    required this.quoteCurrency,
    required this.rate,
    required this.asOfDate,
    this.source,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.org,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      baseCurrency: json['baseCurrency'] as String,
      quoteCurrency: json['quoteCurrency'] as String,
      rate: (json['rate'] as num).toDouble(),
      asOfDate: DateTime.parse(json['asOfDate'] as String),
      source: json['source'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'baseCurrency': baseCurrency,
      'quoteCurrency': quoteCurrency,
      'rate': rate,
      'asOfDate': asOfDate.toIso8601String(),
      'source': source,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'org': org.toJson(),
    };
  }

  ExchangeRate copyWith({
    String? id,
    String? orgId,
    String? baseCurrency,
    String? quoteCurrency,
    double? rate,
    DateTime? asOfDate,
    String? source,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Organization? org,
  }) {
    return ExchangeRate(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      quoteCurrency: quoteCurrency ?? this.quoteCurrency,
      rate: rate ?? this.rate,
      asOfDate: asOfDate ?? this.asOfDate,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      org: org ?? this.org,
    );
  }
}
