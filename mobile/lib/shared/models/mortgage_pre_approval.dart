import 'contact.dart';
import 'deal.dart';
import 'organization.dart';

class MortgagePreApproval {
  final String id;
  final String orgId;
  final String? dealId;
  final String contactId;
  final String lenderName;
  final String mortgageType;
  final int mortgageTerm;
  final double interestRate;
  final double arrangementFee;
  final double valuationFee;
  final double loanAmount;
  final double depositAmount;
  final double loanToValue;
  final double monthlyPayment;
  final double totalPayable;
  final String offerStatus;
  final DateTime offerDate;
  final DateTime? expiryDate;
  final DateTime? acceptedDate;
  final String? solicitorName;
  final String? solicitorEmail;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Contact contact;
  final Deal? deal;
  final Organization org;

  const MortgagePreApproval({
    required this.id,
    required this.orgId,
    this.dealId,
    required this.contactId,
    required this.lenderName,
    required this.mortgageType,
    required this.mortgageTerm,
    required this.interestRate,
    required this.arrangementFee,
    required this.valuationFee,
    required this.loanAmount,
    required this.depositAmount,
    required this.loanToValue,
    required this.monthlyPayment,
    required this.totalPayable,
    required this.offerStatus,
    required this.offerDate,
    this.expiryDate,
    this.acceptedDate,
    this.solicitorName,
    this.solicitorEmail,
    required this.createdAt,
    required this.updatedAt,
    required this.contact,
    this.deal,
    required this.org,
  });

  factory MortgagePreApproval.fromJson(Map<String, dynamic> json) {
    return MortgagePreApproval(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      dealId: json['dealId'] as String?,
      contactId: json['contactId'] as String,
      lenderName: json['lenderName'] as String,
      mortgageType: json['mortgageType'] as String,
      mortgageTerm: json['mortgageTerm'] as int,
      interestRate: (json['interestRate'] as num).toDouble(),
      arrangementFee: (json['arrangementFee'] as num).toDouble(),
      valuationFee: (json['valuationFee'] as num).toDouble(),
      loanAmount: (json['loanAmount'] as num).toDouble(),
      depositAmount: (json['depositAmount'] as num).toDouble(),
      loanToValue: (json['loanToValue'] as num).toDouble(),
      monthlyPayment: (json['monthlyPayment'] as num).toDouble(),
      totalPayable: (json['totalPayable'] as num).toDouble(),
      offerStatus: json['offerStatus'] as String,
      offerDate: DateTime.parse(json['offerDate'] as String),
      expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate'] as String) : null,
      acceptedDate: json['acceptedDate'] != null ? DateTime.parse(json['acceptedDate'] as String) : null,
      solicitorName: json['solicitorName'] as String?,
      solicitorEmail: json['solicitorEmail'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
      deal: json['deal'] != null ? Deal.fromJson(json['deal'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'dealId': dealId,
      'contactId': contactId,
      'lenderName': lenderName,
      'mortgageType': mortgageType,
      'mortgageTerm': mortgageTerm,
      'interestRate': interestRate,
      'arrangementFee': arrangementFee,
      'valuationFee': valuationFee,
      'loanAmount': loanAmount,
      'depositAmount': depositAmount,
      'loanToValue': loanToValue,
      'monthlyPayment': monthlyPayment,
      'totalPayable': totalPayable,
      'offerStatus': offerStatus,
      'offerDate': offerDate.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'acceptedDate': acceptedDate?.toIso8601String(),
      'solicitorName': solicitorName,
      'solicitorEmail': solicitorEmail,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'contact': contact.toJson(),
      'deal': deal?.toJson(),
      'org': org.toJson(),
    };
  }

  MortgagePreApproval copyWith({
    String? id,
    String? orgId,
    String? dealId,
    String? contactId,
    String? lenderName,
    String? mortgageType,
    int? mortgageTerm,
    double? interestRate,
    double? arrangementFee,
    double? valuationFee,
    double? loanAmount,
    double? depositAmount,
    double? loanToValue,
    double? monthlyPayment,
    double? totalPayable,
    String? offerStatus,
    DateTime? offerDate,
    DateTime? expiryDate,
    DateTime? acceptedDate,
    String? solicitorName,
    String? solicitorEmail,
    DateTime? createdAt,
    DateTime? updatedAt,
    Contact? contact,
    Deal? deal,
    Organization? org,
  }) {
    return MortgagePreApproval(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      dealId: dealId ?? this.dealId,
      contactId: contactId ?? this.contactId,
      lenderName: lenderName ?? this.lenderName,
      mortgageType: mortgageType ?? this.mortgageType,
      mortgageTerm: mortgageTerm ?? this.mortgageTerm,
      interestRate: interestRate ?? this.interestRate,
      arrangementFee: arrangementFee ?? this.arrangementFee,
      valuationFee: valuationFee ?? this.valuationFee,
      loanAmount: loanAmount ?? this.loanAmount,
      depositAmount: depositAmount ?? this.depositAmount,
      loanToValue: loanToValue ?? this.loanToValue,
      monthlyPayment: monthlyPayment ?? this.monthlyPayment,
      totalPayable: totalPayable ?? this.totalPayable,
      offerStatus: offerStatus ?? this.offerStatus,
      offerDate: offerDate ?? this.offerDate,
      expiryDate: expiryDate ?? this.expiryDate,
      acceptedDate: acceptedDate ?? this.acceptedDate,
      solicitorName: solicitorName ?? this.solicitorName,
      solicitorEmail: solicitorEmail ?? this.solicitorEmail,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      contact: contact ?? this.contact,
      deal: deal ?? this.deal,
      org: org ?? this.org,
    );
  }
}
