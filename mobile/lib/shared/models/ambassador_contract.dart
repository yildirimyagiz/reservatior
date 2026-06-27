import 'package:reservatior/shared/enums/contract_status.dart';
import 'brand_ambassador.dart';
import 'organization.dart';

class AmbassadorContract {
  final String id;
  final String? orgId;
  final String ambassadorId;
  final int version;
  final double? equityPercent;
  final double? upfrontFee;
  final String currency;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime? signedAt;
  final String? documentUrl;
  final ContractStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final BrandAmbassador ambassador;
  final Organization? org;

  const AmbassadorContract({
    required this.id,
    this.orgId,
    required this.ambassadorId,
    required this.version,
    this.equityPercent,
    this.upfrontFee,
    required this.currency,
    required this.startDate,
    this.endDate,
    this.signedAt,
    this.documentUrl,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.ambassador,
    this.org,
  });

  factory AmbassadorContract.fromJson(Map<String, dynamic> json) {
    return AmbassadorContract(
      id: json['id'] as String,
      orgId: json['orgId'] as String?,
      ambassadorId: json['ambassadorId'] as String,
      version: json['version'] as int,
      equityPercent: (json['equityPercent'] as num?)?.toDouble(),
      upfrontFee: (json['upfrontFee'] as num?)?.toDouble(),
      currency: json['currency'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      signedAt: json['signedAt'] != null ? DateTime.parse(json['signedAt'] as String) : null,
      documentUrl: json['documentUrl'] as String?,
      status: ContractStatus.values.firstWhere((v) => v.name == json['status']),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      ambassador: BrandAmbassador.fromJson(json['ambassador'] as Map<String, dynamic>),
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'ambassadorId': ambassadorId,
      'version': version,
      'equityPercent': equityPercent,
      'upfrontFee': upfrontFee,
      'currency': currency,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'signedAt': signedAt?.toIso8601String(),
      'documentUrl': documentUrl,
      'status': status.name,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'ambassador': ambassador.toJson(),
      'org': org?.toJson(),
    };
  }

  AmbassadorContract copyWith({
    String? id,
    String? orgId,
    String? ambassadorId,
    int? version,
    double? equityPercent,
    double? upfrontFee,
    String? currency,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? signedAt,
    String? documentUrl,
    ContractStatus? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    BrandAmbassador? ambassador,
    Organization? org,
  }) {
    return AmbassadorContract(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      ambassadorId: ambassadorId ?? this.ambassadorId,
      version: version ?? this.version,
      equityPercent: equityPercent ?? this.equityPercent,
      upfrontFee: upfrontFee ?? this.upfrontFee,
      currency: currency ?? this.currency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      signedAt: signedAt ?? this.signedAt,
      documentUrl: documentUrl ?? this.documentUrl,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      ambassador: ambassador ?? this.ambassador,
      org: org ?? this.org,
    );
  }
}
