import 'contract.dart';
import 'organization.dart';

class ContractVersion {
  final String id;
  final String orgId;
  final String contractId;
  final int version;
  final String documentUrl;
  final String? checksum;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contract contract;
  final Organization org;

  const ContractVersion({
    required this.id,
    required this.orgId,
    required this.contractId,
    required this.version,
    required this.documentUrl,
    this.checksum,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.contract,
    required this.org,
  });

  factory ContractVersion.fromJson(Map<String, dynamic> json) {
    return ContractVersion(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      contractId: json['contractId'] as String,
      version: json['version'] as int,
      documentUrl: json['documentUrl'] as String,
      checksum: json['checksum'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contract: Contract.fromJson(json['contract'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'contractId': contractId,
      'version': version,
      'documentUrl': documentUrl,
      'checksum': checksum,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contract': contract.toJson(),
      'org': org.toJson(),
    };
  }

  ContractVersion copyWith({
    String? id,
    String? orgId,
    String? contractId,
    int? version,
    String? documentUrl,
    String? checksum,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contract? contract,
    Organization? org,
  }) {
    return ContractVersion(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      contractId: contractId ?? this.contractId,
      version: version ?? this.version,
      documentUrl: documentUrl ?? this.documentUrl,
      checksum: checksum ?? this.checksum,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contract: contract ?? this.contract,
      org: org ?? this.org,
    );
  }
}
