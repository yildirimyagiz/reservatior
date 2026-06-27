import 'contact.dart';
import 'deal.dart';
import 'organization.dart';

class AttorneyManagement {
  final String id;
  final String orgId;
  final String dealId;
  final String contactId;
  final String solicitorFirm;
  final String solicitorName;
  final String solicitorEmail;
  final String? solicitorPhone;
  final String appointmentType;
  final DateTime? appointmentDate;
  final String? appointmentNotes;
  final String status;
  final DateTime? searchDate;
  final DateTime? draftContractDate;
  final DateTime? finalContractDate;
  final DateTime? completionDate;
  final String? completionNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Contact contact;
  final Deal deal;
  final Organization org;

  const AttorneyManagement({
    required this.id,
    required this.orgId,
    required this.dealId,
    required this.contactId,
    required this.solicitorFirm,
    required this.solicitorName,
    required this.solicitorEmail,
    this.solicitorPhone,
    required this.appointmentType,
    this.appointmentDate,
    this.appointmentNotes,
    required this.status,
    this.searchDate,
    this.draftContractDate,
    this.finalContractDate,
    this.completionDate,
    this.completionNotes,
    required this.createdAt,
    required this.updatedAt,
    required this.contact,
    required this.deal,
    required this.org,
  });

  factory AttorneyManagement.fromJson(Map<String, dynamic> json) {
    return AttorneyManagement(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      dealId: json['dealId'] as String,
      contactId: json['contactId'] as String,
      solicitorFirm: json['solicitorFirm'] as String,
      solicitorName: json['solicitorName'] as String,
      solicitorEmail: json['solicitorEmail'] as String,
      solicitorPhone: json['solicitorPhone'] as String?,
      appointmentType: json['appointmentType'] as String,
      appointmentDate: json['appointmentDate'] != null ? DateTime.parse(json['appointmentDate'] as String) : null,
      appointmentNotes: json['appointmentNotes'] as String?,
      status: json['status'] as String,
      searchDate: json['searchDate'] != null ? DateTime.parse(json['searchDate'] as String) : null,
      draftContractDate: json['draftContractDate'] != null ? DateTime.parse(json['draftContractDate'] as String) : null,
      finalContractDate: json['finalContractDate'] != null ? DateTime.parse(json['finalContractDate'] as String) : null,
      completionDate: json['completionDate'] != null ? DateTime.parse(json['completionDate'] as String) : null,
      completionNotes: json['completionNotes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
      deal: Deal.fromJson(json['deal'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'dealId': dealId,
      'contactId': contactId,
      'solicitorFirm': solicitorFirm,
      'solicitorName': solicitorName,
      'solicitorEmail': solicitorEmail,
      'solicitorPhone': solicitorPhone,
      'appointmentType': appointmentType,
      'appointmentDate': appointmentDate?.toIso8601String(),
      'appointmentNotes': appointmentNotes,
      'status': status,
      'searchDate': searchDate?.toIso8601String(),
      'draftContractDate': draftContractDate?.toIso8601String(),
      'finalContractDate': finalContractDate?.toIso8601String(),
      'completionDate': completionDate?.toIso8601String(),
      'completionNotes': completionNotes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'contact': contact.toJson(),
      'deal': deal.toJson(),
      'org': org.toJson(),
    };
  }

  AttorneyManagement copyWith({
    String? id,
    String? orgId,
    String? dealId,
    String? contactId,
    String? solicitorFirm,
    String? solicitorName,
    String? solicitorEmail,
    String? solicitorPhone,
    String? appointmentType,
    DateTime? appointmentDate,
    String? appointmentNotes,
    String? status,
    DateTime? searchDate,
    DateTime? draftContractDate,
    DateTime? finalContractDate,
    DateTime? completionDate,
    String? completionNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
    Contact? contact,
    Deal? deal,
    Organization? org,
  }) {
    return AttorneyManagement(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      dealId: dealId ?? this.dealId,
      contactId: contactId ?? this.contactId,
      solicitorFirm: solicitorFirm ?? this.solicitorFirm,
      solicitorName: solicitorName ?? this.solicitorName,
      solicitorEmail: solicitorEmail ?? this.solicitorEmail,
      solicitorPhone: solicitorPhone ?? this.solicitorPhone,
      appointmentType: appointmentType ?? this.appointmentType,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentNotes: appointmentNotes ?? this.appointmentNotes,
      status: status ?? this.status,
      searchDate: searchDate ?? this.searchDate,
      draftContractDate: draftContractDate ?? this.draftContractDate,
      finalContractDate: finalContractDate ?? this.finalContractDate,
      completionDate: completionDate ?? this.completionDate,
      completionNotes: completionNotes ?? this.completionNotes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      contact: contact ?? this.contact,
      deal: deal ?? this.deal,
      org: org ?? this.org,
    );
  }
}
