import 'package:reservatior/shared/enums/signature_status.dart';
import 'contract.dart';
import 'organization.dart';
import 'signature_signer.dart';

class SignatureRequest {
  final String id;
  final String orgId;
  final String contractId;
  final String? provider;
  final SignatureStatus status;
  final String? signUrl;
  final String? signedDocumentUrl;
  final DateTime? expiresAt;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contract contract;
  final Organization org;
  final List<SignatureSigner> signers;

  const SignatureRequest({
    required this.id,
    required this.orgId,
    required this.contractId,
    this.provider,
    required this.status,
    this.signUrl,
    this.signedDocumentUrl,
    this.expiresAt,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.contract,
    required this.org,
    this.signers = const [],
  });

  factory SignatureRequest.fromJson(Map<String, dynamic> json) {
    return SignatureRequest(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      contractId: json['contractId'] as String,
      provider: json['provider'] as String?,
      status: SignatureStatus.values.firstWhere((v) => v.name == json['status']),
      signUrl: json['signUrl'] as String?,
      signedDocumentUrl: json['signedDocumentUrl'] as String?,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt'] as String) : null,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contract: Contract.fromJson(json['contract'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      signers: (json['signers'] as List<dynamic>?)?.map((e) => SignatureSigner.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'contractId': contractId,
      'provider': provider,
      'status': status.name,
      'signUrl': signUrl,
      'signedDocumentUrl': signedDocumentUrl,
      'expiresAt': expiresAt?.toIso8601String(),
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contract': contract.toJson(),
      'org': org.toJson(),
      'signers': signers.map((e) => e.toJson()).toList(),
    };
  }

  SignatureRequest copyWith({
    String? id,
    String? orgId,
    String? contractId,
    String? provider,
    SignatureStatus? status,
    String? signUrl,
    String? signedDocumentUrl,
    DateTime? expiresAt,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contract? contract,
    Organization? org,
    List<SignatureSigner>? signers,
  }) {
    return SignatureRequest(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      contractId: contractId ?? this.contractId,
      provider: provider ?? this.provider,
      status: status ?? this.status,
      signUrl: signUrl ?? this.signUrl,
      signedDocumentUrl: signedDocumentUrl ?? this.signedDocumentUrl,
      expiresAt: expiresAt ?? this.expiresAt,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contract: contract ?? this.contract,
      org: org ?? this.org,
      signers: signers ?? this.signers,
    );
  }
}
