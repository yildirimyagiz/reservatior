import 'package:reservatior/shared/enums/us_tax_form.dart';
import 'contact.dart';
import 'organization.dart';

class Tax1099Form {
  final String id;
  final String orgId;
  final String recipientId;
  final int taxYear;
  final USTaxForm formType;
  final double amount;
  final String? description;
  final DateTime? issuedAt;
  final DateTime? mailedAt;
  final Organization org;
  final Contact recipient;

  const Tax1099Form({
    required this.id,
    required this.orgId,
    required this.recipientId,
    required this.taxYear,
    required this.formType,
    required this.amount,
    this.description,
    this.issuedAt,
    this.mailedAt,
    required this.org,
    required this.recipient,
  });

  factory Tax1099Form.fromJson(Map<String, dynamic> json) {
    return Tax1099Form(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      recipientId: json['recipientId'] as String,
      taxYear: json['taxYear'] as int,
      formType: USTaxForm.values.firstWhere((v) => v.name == json['formType']),
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String?,
      issuedAt: json['issuedAt'] != null ? DateTime.parse(json['issuedAt'] as String) : null,
      mailedAt: json['mailedAt'] != null ? DateTime.parse(json['mailedAt'] as String) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      recipient: Contact.fromJson(json['recipient'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'recipientId': recipientId,
      'taxYear': taxYear,
      'formType': formType.name,
      'amount': amount,
      'description': description,
      'issuedAt': issuedAt?.toIso8601String(),
      'mailedAt': mailedAt?.toIso8601String(),
      'org': org.toJson(),
      'recipient': recipient.toJson(),
    };
  }

  Tax1099Form copyWith({
    String? id,
    String? orgId,
    String? recipientId,
    int? taxYear,
    USTaxForm? formType,
    double? amount,
    String? description,
    DateTime? issuedAt,
    DateTime? mailedAt,
    Organization? org,
    Contact? recipient,
  }) {
    return Tax1099Form(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      recipientId: recipientId ?? this.recipientId,
      taxYear: taxYear ?? this.taxYear,
      formType: formType ?? this.formType,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      issuedAt: issuedAt ?? this.issuedAt,
      mailedAt: mailedAt ?? this.mailedAt,
      org: org ?? this.org,
      recipient: recipient ?? this.recipient,
    );
  }
}
