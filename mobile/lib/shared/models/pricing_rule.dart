import 'availability.dart';
import 'currency.dart';
import 'discount.dart';
import 'listing.dart';
import 'property.dart';
import 'reservation.dart';
import 'subscription.dart';

class PricingRule {
  final String id;
  final String listingId;
  final String name;
  final String? description;
  final String ruleType;
  final int priority;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final double? basePrice;
  final String strategy;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? minNights;
  final int? maxNights;
  final String? currencyId;
  final List<Availability> availability;
  final List<Discount> discounts;
  final Currency? currency;
  final Property property;
  final List<Reservation> reservation;
  final List<Subscription> subscriptions;
  final Listing listing;

  const PricingRule({
    required this.id,
    required this.listingId,
    required this.name,
    this.description,
    required this.ruleType,
    required this.priority,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.basePrice,
    required this.strategy,
    this.startDate,
    this.endDate,
    this.minNights,
    this.maxNights,
    this.currencyId,
    this.availability = const [],
    this.discounts = const [],
    this.currency,
    required this.property,
    this.reservation = const [],
    this.subscriptions = const [],
    required this.listing,
  });

  factory PricingRule.fromJson(Map<String, dynamic> json) {
    return PricingRule(
      id: json['id'] as String,
      listingId: json['listingId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      ruleType: json['ruleType'] as String,
      priority: json['priority'] as int,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      basePrice: (json['basePrice'] as num?)?.toDouble(),
      strategy: json['strategy'] as String,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate'] as String) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate'] as String) : null,
      minNights: json['minNights'] as int?,
      maxNights: json['maxNights'] as int?,
      currencyId: json['currencyId'] as String?,
      availability: (json['Availability'] as List<dynamic>?)?.map((e) => Availability.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      discounts: (json['Discounts'] as List<dynamic>?)?.map((e) => Discount.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      currency: json['currency'] != null ? Currency.fromJson(json['currency'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['Property'] as Map<String, dynamic>),
      reservation: (json['Reservation'] as List<dynamic>?)?.map((e) => Reservation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      subscriptions: (json['Subscriptions'] as List<dynamic>?)?.map((e) => Subscription.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      listing: Listing.fromJson(json['Listing'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'listingId': listingId,
      'name': name,
      'description': description,
      'ruleType': ruleType,
      'priority': priority,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'basePrice': basePrice,
      'strategy': strategy,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'minNights': minNights,
      'maxNights': maxNights,
      'currencyId': currencyId,
      'Availability': availability.map((e) => e.toJson()).toList(),
      'Discounts': discounts.map((e) => e.toJson()).toList(),
      'currency': currency?.toJson(),
      'Property': property.toJson(),
      'Reservation': reservation.map((e) => e.toJson()).toList(),
      'Subscriptions': subscriptions.map((e) => e.toJson()).toList(),
      'Listing': listing.toJson(),
    };
  }

  PricingRule copyWith({
    String? id,
    String? listingId,
    String? name,
    String? description,
    String? ruleType,
    int? priority,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    double? basePrice,
    String? strategy,
    DateTime? startDate,
    DateTime? endDate,
    int? minNights,
    int? maxNights,
    String? currencyId,
    List<Availability>? availability,
    List<Discount>? discounts,
    Currency? currency,
    Property? property,
    List<Reservation>? reservation,
    List<Subscription>? subscriptions,
    Listing? listing,
  }) {
    return PricingRule(
      id: id ?? this.id,
      listingId: listingId ?? this.listingId,
      name: name ?? this.name,
      description: description ?? this.description,
      ruleType: ruleType ?? this.ruleType,
      priority: priority ?? this.priority,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      basePrice: basePrice ?? this.basePrice,
      strategy: strategy ?? this.strategy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      minNights: minNights ?? this.minNights,
      maxNights: maxNights ?? this.maxNights,
      currencyId: currencyId ?? this.currencyId,
      availability: availability ?? this.availability,
      discounts: discounts ?? this.discounts,
      currency: currency ?? this.currency,
      property: property ?? this.property,
      reservation: reservation ?? this.reservation,
      subscriptions: subscriptions ?? this.subscriptions,
      listing: listing ?? this.listing,
    );
  }
}
