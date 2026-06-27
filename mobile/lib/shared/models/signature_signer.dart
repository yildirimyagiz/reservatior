import 'package:reservatior/shared/enums/message_participant_type.dart';
import 'package:reservatior/shared/enums/signature_status.dart';
import 'contact.dart';
import 'organization.dart';
import 'signature_request.dart';
import 'user.dart';

class SignatureSigner {
  final String id;
  final String orgId;
  final String signatureRequestId;
  final MessageParticipantType participantType;
  final String? userId;
  final String? contactId;
  final String fullName;
  final String? email;
  final SignatureStatus status;
  final DateTime? signedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contact? contact;
  final Organization org;
  final SignatureRequest request;
  final User? user;

  const SignatureSigner({
    required this.id,
    required this.orgId,
    required this.signatureRequestId,
    required this.participantType,
    this.userId,
    this.contactId,
    required this.fullName,
    this.email,
    required this.status,
    this.signedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.contact,
    required this.org,
    required this.request,
    this.user,
  });

  factory SignatureSigner.fromJson(Map<String, dynamic> json) {
    return SignatureSigner(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      signatureRequestId: json['signatureRequestId'] as String,
      participantType: MessageParticipantType.values.firstWhere((v) => v.name == json['participantType']),
      userId: json['userId'] as String?,
      contactId: json['contactId'] as String?,
      fullName: json['fullName'] as String,
      email: json['email'] as String?,
      status: SignatureStatus.values.firstWhere((v) => v.name == json['status']),
      signedAt: json['signedAt'] != null ? DateTime.parse(json['signedAt'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contact: json['contact'] != null ? Contact.fromJson(json['contact'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      request: SignatureRequest.fromJson(json['request'] as Map<String, dynamic>),
      user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'signatureRequestId': signatureRequestId,
      'participantType': participantType.name,
      'userId': userId,
      'contactId': contactId,
      'fullName': fullName,
      'email': email,
      'status': status.name,
      'signedAt': signedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contact': contact?.toJson(),
      'org': org.toJson(),
      'request': request.toJson(),
      'user': user?.toJson(),
    };
  }

  SignatureSigner copyWith({
    String? id,
    String? orgId,
    String? signatureRequestId,
    MessageParticipantType? participantType,
    String? userId,
    String? contactId,
    String? fullName,
    String? email,
    SignatureStatus? status,
    DateTime? signedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contact? contact,
    Organization? org,
    SignatureRequest? request,
    User? user,
  }) {
    return SignatureSigner(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      signatureRequestId: signatureRequestId ?? this.signatureRequestId,
      participantType: participantType ?? this.participantType,
      userId: userId ?? this.userId,
      contactId: contactId ?? this.contactId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      status: status ?? this.status,
      signedAt: signedAt ?? this.signedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contact: contact ?? this.contact,
      org: org ?? this.org,
      request: request ?? this.request,
      user: user ?? this.user,
    );
  }
}
