import 'package:reservatior/shared/enums/membership_type.dart';
import 'agency.dart';
import 'agent.dart';
import 'organization.dart';
import 'payment.dart';
import 'pricing_rule.dart';

class Subscription {
  final String id;
  final String orgId;
  final String? userId;
  final String name;
  final MembershipType type;
  final double price;
  final String currency;
  final String billingCycle;
  final int maxProperties;
  final int maxListings;
  final int featuredListings;
  final bool prioritySupport;
  final bool apiAcces;
  final double commissionDiscount;
  final double loyaltyMultiplier;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Organization org;
  final List<PricingRule> pricingRules;
  final List<Agent> agents;
  final List<Agency> agencies;
  final List<Payment> payments;

  const Subscription({
    required this.id,
    required this.orgId,
    this.userId,
    required this.name,
    required this.type,
    required this.price,
    required this.currency,
    required this.billingCycle,
    required this.maxProperties,
    required this.maxListings,
    required this.featuredListings,
    required this.prioritySupport,
    required this.apiAcces,
    required this.commissionDiscount,
    required this.loyaltyMultiplier,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.org,
    this.pricingRules = const [],
    this.agents = const [],
    this.agencies = const [],
    this.payments = const [],
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      userId: json['userId'] as String?,
      name: json['name'] as String,
      type: MembershipType.values.firstWhere((v) => v.name == json['type']),
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      billingCycle: json['billingCycle'] as String,
      maxProperties: json['maxProperties'] as int,
      maxListings: json['maxListings'] as int,
      featuredListings: json['featuredListings'] as int,
      prioritySupport: json['prioritySupport'] as bool,
      apiAcces: json['ApiAcces'] as bool,
      commissionDiscount: (json['commissionDiscount'] as num).toDouble(),
      loyaltyMultiplier: (json['loyaltyMultiplier'] as num).toDouble(),
      isActive: json['isActive'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      pricingRules: (json['pricingRules'] as List<dynamic>?)?.map((e) => PricingRule.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agents: (json['agents'] as List<dynamic>?)?.map((e) => Agent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      payments: (json['payments'] as List<dynamic>?)?.map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'userId': userId,
      'name': name,
      'type': type.name,
      'price': price,
      'currency': currency,
      'billingCycle': billingCycle,
      'maxProperties': maxProperties,
      'maxListings': maxListings,
      'featuredListings': featuredListings,
      'prioritySupport': prioritySupport,
      'ApiAcces': apiAcces,
      'commissionDiscount': commissionDiscount,
      'loyaltyMultiplier': loyaltyMultiplier,
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'org': org.toJson(),
      'pricingRules': pricingRules.map((e) => e.toJson()).toList(),
      'agents': agents.map((e) => e.toJson()).toList(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'payments': payments.map((e) => e.toJson()).toList(),
    };
  }

  Subscription copyWith({
    String? id,
    String? orgId,
    String? userId,
    String? name,
    MembershipType? type,
    double? price,
    String? currency,
    String? billingCycle,
    int? maxProperties,
    int? maxListings,
    int? featuredListings,
    bool? prioritySupport,
    bool? apiAcces,
    double? commissionDiscount,
    double? loyaltyMultiplier,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    Organization? org,
    List<PricingRule>? pricingRules,
    List<Agent>? agents,
    List<Agency>? agencies,
    List<Payment>? payments,
  }) {
    return Subscription(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      billingCycle: billingCycle ?? this.billingCycle,
      maxProperties: maxProperties ?? this.maxProperties,
      maxListings: maxListings ?? this.maxListings,
      featuredListings: featuredListings ?? this.featuredListings,
      prioritySupport: prioritySupport ?? this.prioritySupport,
      apiAcces: apiAcces ?? this.apiAcces,
      commissionDiscount: commissionDiscount ?? this.commissionDiscount,
      loyaltyMultiplier: loyaltyMultiplier ?? this.loyaltyMultiplier,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      org: org ?? this.org,
      pricingRules: pricingRules ?? this.pricingRules,
      agents: agents ?? this.agents,
      agencies: agencies ?? this.agencies,
      payments: payments ?? this.payments,
    );
  }
}
