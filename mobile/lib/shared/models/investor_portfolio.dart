import 'package:reservatior/shared/enums/risk_tolerance.dart';
import 'investor_property.dart';
import 'organization.dart';
import 'user.dart';

class InvestorPortfolio {
  final String id;
  final String userId;
  final String name;
  final double? targetIrr;
  final RiskTolerance riskTolerance;
  final String? investmentHorizon;
  final double totalInvested;
  final double currentValue;
  final double totalReturns;
  final String? organizationId;
  final Organization? organization;
  final User user;
  final List<InvestorProperty> properties;

  const InvestorPortfolio({
    required this.id,
    required this.userId,
    required this.name,
    this.targetIrr,
    required this.riskTolerance,
    this.investmentHorizon,
    required this.totalInvested,
    required this.currentValue,
    required this.totalReturns,
    this.organizationId,
    this.organization,
    required this.user,
    this.properties = const [],
  });

  factory InvestorPortfolio.fromJson(Map<String, dynamic> json) {
    return InvestorPortfolio(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      targetIrr: (json['targetIrr'] as num?)?.toDouble(),
      riskTolerance: RiskTolerance.values.firstWhere((v) => v.name == json['riskTolerance']),
      investmentHorizon: json['investmentHorizon'] as String?,
      totalInvested: (json['totalInvested'] as num).toDouble(),
      currentValue: (json['currentValue'] as num).toDouble(),
      totalReturns: (json['totalReturns'] as num).toDouble(),
      organizationId: json['organizationId'] as String?,
      organization: json['organization'] != null ? Organization.fromJson(json['organization'] as Map<String, dynamic>) : null,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      properties: (json['properties'] as List<dynamic>?)?.map((e) => InvestorProperty.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'targetIrr': targetIrr,
      'riskTolerance': riskTolerance.name,
      'investmentHorizon': investmentHorizon,
      'totalInvested': totalInvested,
      'currentValue': currentValue,
      'totalReturns': totalReturns,
      'organizationId': organizationId,
      'organization': organization?.toJson(),
      'user': user.toJson(),
      'properties': properties.map((e) => e.toJson()).toList(),
    };
  }

  InvestorPortfolio copyWith({
    String? id,
    String? userId,
    String? name,
    double? targetIrr,
    RiskTolerance? riskTolerance,
    String? investmentHorizon,
    double? totalInvested,
    double? currentValue,
    double? totalReturns,
    String? organizationId,
    Organization? organization,
    User? user,
    List<InvestorProperty>? properties,
  }) {
    return InvestorPortfolio(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      targetIrr: targetIrr ?? this.targetIrr,
      riskTolerance: riskTolerance ?? this.riskTolerance,
      investmentHorizon: investmentHorizon ?? this.investmentHorizon,
      totalInvested: totalInvested ?? this.totalInvested,
      currentValue: currentValue ?? this.currentValue,
      totalReturns: totalReturns ?? this.totalReturns,
      organizationId: organizationId ?? this.organizationId,
      organization: organization ?? this.organization,
      user: user ?? this.user,
      properties: properties ?? this.properties,
    );
  }
}
