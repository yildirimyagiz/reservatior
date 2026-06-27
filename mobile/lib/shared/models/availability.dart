import 'pricing_rule.dart';
import 'property.dart';
import 'reservation.dart';

class Availability {
  final String id;
  final DateTime date;
  final bool isBlocked;
  final bool isBooked;
  final String propertyId;
  final String? reservationId;
  final String? pricingRuleId;
  final int totalUnits;
  final int availableUnits;
  final int bookedUnits;
  final int blockedUnits;
  final double basePrice;
  final double currentPrice;
  final int? minNights;
  final int? maxNights;
  final int maxGuests;
  final double? weekendRate;
  final double? weekdayRate;
  final double? weekendMultiplier;
  final double? weekdayMultiplier;
  final double? seasonalMultiplier;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final PricingRule? pricingRule;
  final Property property;
  final Reservation? reservation;

  const Availability({
    required this.id,
    required this.date,
    required this.isBlocked,
    required this.isBooked,
    required this.propertyId,
    this.reservationId,
    this.pricingRuleId,
    required this.totalUnits,
    required this.availableUnits,
    required this.bookedUnits,
    required this.blockedUnits,
    required this.basePrice,
    required this.currentPrice,
    this.minNights,
    this.maxNights,
    required this.maxGuests,
    this.weekendRate,
    this.weekdayRate,
    this.weekendMultiplier,
    this.weekdayMultiplier,
    this.seasonalMultiplier,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.pricingRule,
    required this.property,
    this.reservation,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      isBlocked: json['isBlocked'] as bool,
      isBooked: json['isBooked'] as bool,
      propertyId: json['propertyId'] as String,
      reservationId: json['reservationId'] as String?,
      pricingRuleId: json['pricingRuleId'] as String?,
      totalUnits: json['totalUnits'] as int,
      availableUnits: json['availableUnits'] as int,
      bookedUnits: json['bookedUnits'] as int,
      blockedUnits: json['blockedUnits'] as int,
      basePrice: (json['basePrice'] as num).toDouble(),
      currentPrice: (json['currentPrice'] as num).toDouble(),
      minNights: json['minNights'] as int?,
      maxNights: json['maxNights'] as int?,
      maxGuests: json['maxGuests'] as int,
      weekendRate: (json['weekendRate'] as num?)?.toDouble(),
      weekdayRate: (json['weekdayRate'] as num?)?.toDouble(),
      weekendMultiplier: (json['weekendMultiplier'] as num?)?.toDouble(),
      weekdayMultiplier: (json['weekdayMultiplier'] as num?)?.toDouble(),
      seasonalMultiplier: (json['seasonalMultiplier'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      pricingRule: json['pricingRule'] != null ? PricingRule.fromJson(json['pricingRule'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
      reservation: json['reservation'] != null ? Reservation.fromJson(json['reservation'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'isBlocked': isBlocked,
      'isBooked': isBooked,
      'propertyId': propertyId,
      'reservationId': reservationId,
      'pricingRuleId': pricingRuleId,
      'totalUnits': totalUnits,
      'availableUnits': availableUnits,
      'bookedUnits': bookedUnits,
      'blockedUnits': blockedUnits,
      'basePrice': basePrice,
      'currentPrice': currentPrice,
      'minNights': minNights,
      'maxNights': maxNights,
      'maxGuests': maxGuests,
      'weekendRate': weekendRate,
      'weekdayRate': weekdayRate,
      'weekendMultiplier': weekendMultiplier,
      'weekdayMultiplier': weekdayMultiplier,
      'seasonalMultiplier': seasonalMultiplier,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'pricingRule': pricingRule?.toJson(),
      'property': property.toJson(),
      'reservation': reservation?.toJson(),
    };
  }

  Availability copyWith({
    String? id,
    DateTime? date,
    bool? isBlocked,
    bool? isBooked,
    String? propertyId,
    String? reservationId,
    String? pricingRuleId,
    int? totalUnits,
    int? availableUnits,
    int? bookedUnits,
    int? blockedUnits,
    double? basePrice,
    double? currentPrice,
    int? minNights,
    int? maxNights,
    int? maxGuests,
    double? weekendRate,
    double? weekdayRate,
    double? weekendMultiplier,
    double? weekdayMultiplier,
    double? seasonalMultiplier,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    PricingRule? pricingRule,
    Property? property,
    Reservation? reservation,
  }) {
    return Availability(
      id: id ?? this.id,
      date: date ?? this.date,
      isBlocked: isBlocked ?? this.isBlocked,
      isBooked: isBooked ?? this.isBooked,
      propertyId: propertyId ?? this.propertyId,
      reservationId: reservationId ?? this.reservationId,
      pricingRuleId: pricingRuleId ?? this.pricingRuleId,
      totalUnits: totalUnits ?? this.totalUnits,
      availableUnits: availableUnits ?? this.availableUnits,
      bookedUnits: bookedUnits ?? this.bookedUnits,
      blockedUnits: blockedUnits ?? this.blockedUnits,
      basePrice: basePrice ?? this.basePrice,
      currentPrice: currentPrice ?? this.currentPrice,
      minNights: minNights ?? this.minNights,
      maxNights: maxNights ?? this.maxNights,
      maxGuests: maxGuests ?? this.maxGuests,
      weekendRate: weekendRate ?? this.weekendRate,
      weekdayRate: weekdayRate ?? this.weekdayRate,
      weekendMultiplier: weekendMultiplier ?? this.weekendMultiplier,
      weekdayMultiplier: weekdayMultiplier ?? this.weekdayMultiplier,
      seasonalMultiplier: seasonalMultiplier ?? this.seasonalMultiplier,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      pricingRule: pricingRule ?? this.pricingRule,
      property: property ?? this.property,
      reservation: reservation ?? this.reservation,
    );
  }
}
