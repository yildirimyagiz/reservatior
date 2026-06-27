import 'investor_portfolio.dart';
import 'property.dart';

class InvestorProperty {
  final String id;
  final String portfolioId;
  final String propertyId;
  final DateTime acquiredAt;
  final double acquiredCost;
  final double? mortgageBalance;
  final double? mortgageRate;
  final int? mortgageTerm;
  final String? insuranceProvider;
  final double? insuranceAmount;
  final InvestorPortfolio portfolio;
  final Property property;

  const InvestorProperty({
    required this.id,
    required this.portfolioId,
    required this.propertyId,
    required this.acquiredAt,
    required this.acquiredCost,
    this.mortgageBalance,
    this.mortgageRate,
    this.mortgageTerm,
    this.insuranceProvider,
    this.insuranceAmount,
    required this.portfolio,
    required this.property,
  });

  factory InvestorProperty.fromJson(Map<String, dynamic> json) {
    return InvestorProperty(
      id: json['id'] as String,
      portfolioId: json['portfolioId'] as String,
      propertyId: json['propertyId'] as String,
      acquiredAt: DateTime.parse(json['acquiredAt'] as String),
      acquiredCost: (json['acquiredCost'] as num).toDouble(),
      mortgageBalance: (json['mortgageBalance'] as num?)?.toDouble(),
      mortgageRate: (json['mortgageRate'] as num?)?.toDouble(),
      mortgageTerm: json['mortgageTerm'] as int?,
      insuranceProvider: json['insuranceProvider'] as String?,
      insuranceAmount: (json['insuranceAmount'] as num?)?.toDouble(),
      portfolio: InvestorPortfolio.fromJson(json['portfolio'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'portfolioId': portfolioId,
      'propertyId': propertyId,
      'acquiredAt': acquiredAt.toIso8601String(),
      'acquiredCost': acquiredCost,
      'mortgageBalance': mortgageBalance,
      'mortgageRate': mortgageRate,
      'mortgageTerm': mortgageTerm,
      'insuranceProvider': insuranceProvider,
      'insuranceAmount': insuranceAmount,
      'portfolio': portfolio.toJson(),
      'property': property.toJson(),
    };
  }

  InvestorProperty copyWith({
    String? id,
    String? portfolioId,
    String? propertyId,
    DateTime? acquiredAt,
    double? acquiredCost,
    double? mortgageBalance,
    double? mortgageRate,
    int? mortgageTerm,
    String? insuranceProvider,
    double? insuranceAmount,
    InvestorPortfolio? portfolio,
    Property? property,
  }) {
    return InvestorProperty(
      id: id ?? this.id,
      portfolioId: portfolioId ?? this.portfolioId,
      propertyId: propertyId ?? this.propertyId,
      acquiredAt: acquiredAt ?? this.acquiredAt,
      acquiredCost: acquiredCost ?? this.acquiredCost,
      mortgageBalance: mortgageBalance ?? this.mortgageBalance,
      mortgageRate: mortgageRate ?? this.mortgageRate,
      mortgageTerm: mortgageTerm ?? this.mortgageTerm,
      insuranceProvider: insuranceProvider ?? this.insuranceProvider,
      insuranceAmount: insuranceAmount ?? this.insuranceAmount,
      portfolio: portfolio ?? this.portfolio,
      property: property ?? this.property,
    );
  }
}
