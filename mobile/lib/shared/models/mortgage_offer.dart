import 'contact.dart';
import 'organization.dart';
import 'property.dart';

class MortgageOffer {
  final String id;
  final String orgId;
  final String contactId;
  final String? propertyId;
  final String lender;
  final double offerAmount;
  final double interestRate;
  final int termYears;
  final double monthlyPayment;
  final String currency;
  final String status;
  final DateTime? offeredAt;
  final DateTime? acceptedAt;
  final DateTime? expiresAt;
  final String? conditions;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contact contact;
  final Organization org;
  final Property? property;

  const MortgageOffer({
    required this.id,
    required this.orgId,
    required this.contactId,
    this.propertyId,
    required this.lender,
    required this.offerAmount,
    required this.interestRate,
    required this.termYears,
    required this.monthlyPayment,
    required this.currency,
    required this.status,
    this.offeredAt,
    this.acceptedAt,
    this.expiresAt,
    this.conditions,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.contact,
    required this.org,
    this.property,
  });

  factory MortgageOffer.fromJson(Map<String, dynamic> json) {
    return MortgageOffer(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      contactId: json['contactId'] as String,
      propertyId: json['propertyId'] as String?,
      lender: json['lender'] as String,
      offerAmount: (json['offerAmount'] as num).toDouble(),
      interestRate: (json['interestRate'] as num).toDouble(),
      termYears: json['termYears'] as int,
      monthlyPayment: (json['monthlyPayment'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      offeredAt: json['offeredAt'] != null ? DateTime.parse(json['offeredAt'] as String) : null,
      acceptedAt: json['acceptedAt'] != null ? DateTime.parse(json['acceptedAt'] as String) : null,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt'] as String) : null,
      conditions: json['conditions'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'contactId': contactId,
      'propertyId': propertyId,
      'lender': lender,
      'offerAmount': offerAmount,
      'interestRate': interestRate,
      'termYears': termYears,
      'monthlyPayment': monthlyPayment,
      'currency': currency,
      'status': status,
      'offeredAt': offeredAt?.toIso8601String(),
      'acceptedAt': acceptedAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'conditions': conditions,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contact': contact.toJson(),
      'org': org.toJson(),
      'property': property?.toJson(),
    };
  }

  MortgageOffer copyWith({
    String? id,
    String? orgId,
    String? contactId,
    String? propertyId,
    String? lender,
    double? offerAmount,
    double? interestRate,
    int? termYears,
    double? monthlyPayment,
    String? currency,
    String? status,
    DateTime? offeredAt,
    DateTime? acceptedAt,
    DateTime? expiresAt,
    String? conditions,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contact? contact,
    Organization? org,
    Property? property,
  }) {
    return MortgageOffer(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      contactId: contactId ?? this.contactId,
      propertyId: propertyId ?? this.propertyId,
      lender: lender ?? this.lender,
      offerAmount: offerAmount ?? this.offerAmount,
      interestRate: interestRate ?? this.interestRate,
      termYears: termYears ?? this.termYears,
      monthlyPayment: monthlyPayment ?? this.monthlyPayment,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      offeredAt: offeredAt ?? this.offeredAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      conditions: conditions ?? this.conditions,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contact: contact ?? this.contact,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
