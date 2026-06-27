import 'package:reservatior/shared/enums/mortgage_status.dart';
import 'property.dart';

class Mortgage {
  final String id;
  final String propertyId;
  final String lender;
  final double principal;
  final double interestRate;
  final DateTime startDate;
  final DateTime? endDate;
  final MortgageStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Property property;

  const Mortgage({
    required this.id,
    required this.propertyId,
    required this.lender,
    required this.principal,
    required this.interestRate,
    required this.startDate,
    this.endDate,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.property,
  });

  factory Mortgage.fromJson(Map<String, dynamic> json) {
    return Mortgage(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      lender: json['lender'] as String,
      principal: (json['principal'] as num).toDouble(),
      interestRate: (json['interestRate'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      status: MortgageStatus.values.firstWhere((v) => v.name == json['status']),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      property: Property.fromJson(json['Property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'lender': lender,
      'principal': principal,
      'interestRate': interestRate,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'status': status.name,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'Property': property.toJson(),
    };
  }

  Mortgage copyWith({
    String? id,
    String? propertyId,
    String? lender,
    double? principal,
    double? interestRate,
    DateTime? startDate,
    DateTime? endDate,
    MortgageStatus? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Property? property,
  }) {
    return Mortgage(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      lender: lender ?? this.lender,
      principal: principal ?? this.principal,
      interestRate: interestRate ?? this.interestRate,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      property: property ?? this.property,
    );
  }
}
