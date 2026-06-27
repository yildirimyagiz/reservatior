import 'package:reservatior/shared/enums/booking_source.dart';
import 'commission_rule.dart';
import 'report.dart';
import 'reservation.dart';

class ReferenceSource {
  final String id;
  final String name;
  final String? logo;
  final String? apiKey;
  final String? apiSecret;
  final String? baseUrl;
  final bool isActive;
  final double commission;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final BookingSource source;
  final List<CommissionRule> commissionRule;
  final List<Report> report;
  final List<Reservation> reservations;

  const ReferenceSource({
    required this.id,
    required this.name,
    this.logo,
    this.apiKey,
    this.apiSecret,
    this.baseUrl,
    required this.isActive,
    required this.commission,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.source,
    this.commissionRule = const [],
    this.report = const [],
    this.reservations = const [],
  });

  factory ReferenceSource.fromJson(Map<String, dynamic> json) {
    return ReferenceSource(
      id: json['id'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String?,
      apiKey: json['apiKey'] as String?,
      apiSecret: json['apiSecret'] as String?,
      baseUrl: json['baseUrl'] as String?,
      isActive: json['isActive'] as bool,
      commission: (json['commission'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      source: BookingSource.values.firstWhere((v) => v.name == json['source']),
      commissionRule: (json['commissionRule'] as List<dynamic>?)?.map((e) => CommissionRule.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      report: (json['report'] as List<dynamic>?)?.map((e) => Report.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reservations: (json['reservations'] as List<dynamic>?)?.map((e) => Reservation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'apiKey': apiKey,
      'apiSecret': apiSecret,
      'baseUrl': baseUrl,
      'isActive': isActive,
      'commission': commission,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'source': source.name,
      'commissionRule': commissionRule.map((e) => e.toJson()).toList(),
      'report': report.map((e) => e.toJson()).toList(),
      'reservations': reservations.map((e) => e.toJson()).toList(),
    };
  }

  ReferenceSource copyWith({
    String? id,
    String? name,
    String? logo,
    String? apiKey,
    String? apiSecret,
    String? baseUrl,
    bool? isActive,
    double? commission,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    BookingSource? source,
    List<CommissionRule>? commissionRule,
    List<Report>? report,
    List<Reservation>? reservations,
  }) {
    return ReferenceSource(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      apiKey: apiKey ?? this.apiKey,
      apiSecret: apiSecret ?? this.apiSecret,
      baseUrl: baseUrl ?? this.baseUrl,
      isActive: isActive ?? this.isActive,
      commission: commission ?? this.commission,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      source: source ?? this.source,
      commissionRule: commissionRule ?? this.commissionRule,
      report: report ?? this.report,
      reservations: reservations ?? this.reservations,
    );
  }
}
