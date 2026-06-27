import 'package:reservatior/shared/enums/offer_status.dart';
import 'package:reservatior/shared/enums/offer_type.dart';
import 'increase.dart';
import 'property.dart';
import 'reservation.dart';
import 'user.dart';

class Offer {
  final String? increaseId;
  final String id;
  final OfferType offerType;
  final OfferStatus status;
  final double basePrice;
  final double? discountRate;
  final double finalPrice;
  final String? guestId;
  final DateTime startDate;
  final DateTime endDate;
  final String? specialRequirements;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? reservationId;
  final String propertyId;
  final User? user;
  final Increase? increase;
  final Property property;
  final Reservation? reservation;

  const Offer({
    this.increaseId,
    required this.id,
    required this.offerType,
    required this.status,
    required this.basePrice,
    this.discountRate,
    required this.finalPrice,
    this.guestId,
    required this.startDate,
    required this.endDate,
    this.specialRequirements,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.reservationId,
    required this.propertyId,
    this.user,
    this.increase,
    required this.property,
    this.reservation,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      increaseId: json['increaseId'] as String?,
      id: json['id'] as String,
      offerType: OfferType.values.firstWhere((v) => v.name == json['offerType']),
      status: OfferStatus.values.firstWhere((v) => v.name == json['status']),
      basePrice: (json['basePrice'] as num).toDouble(),
      discountRate: (json['discountRate'] as num?)?.toDouble(),
      finalPrice: (json['finalPrice'] as num).toDouble(),
      guestId: json['guestId'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      specialRequirements: json['specialRequirements'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      reservationId: json['reservationId'] as String?,
      propertyId: json['propertyId'] as String,
      user: json['User'] != null ? User.fromJson(json['User'] as Map<String, dynamic>) : null,
      increase: json['Increase'] != null ? Increase.fromJson(json['Increase'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['Property'] as Map<String, dynamic>),
      reservation: json['Reservation'] != null ? Reservation.fromJson(json['Reservation'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'increaseId': increaseId,
      'id': id,
      'offerType': offerType.name,
      'status': status.name,
      'basePrice': basePrice,
      'discountRate': discountRate,
      'finalPrice': finalPrice,
      'guestId': guestId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'specialRequirements': specialRequirements,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'reservationId': reservationId,
      'propertyId': propertyId,
      'User': user?.toJson(),
      'Increase': increase?.toJson(),
      'Property': property.toJson(),
      'Reservation': reservation?.toJson(),
    };
  }

  Offer copyWith({
    String? increaseId,
    String? id,
    OfferType? offerType,
    OfferStatus? status,
    double? basePrice,
    double? discountRate,
    double? finalPrice,
    String? guestId,
    DateTime? startDate,
    DateTime? endDate,
    String? specialRequirements,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? reservationId,
    String? propertyId,
    User? user,
    Increase? increase,
    Property? property,
    Reservation? reservation,
  }) {
    return Offer(
      increaseId: increaseId ?? this.increaseId,
      id: id ?? this.id,
      offerType: offerType ?? this.offerType,
      status: status ?? this.status,
      basePrice: basePrice ?? this.basePrice,
      discountRate: discountRate ?? this.discountRate,
      finalPrice: finalPrice ?? this.finalPrice,
      guestId: guestId ?? this.guestId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      specialRequirements: specialRequirements ?? this.specialRequirements,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      reservationId: reservationId ?? this.reservationId,
      propertyId: propertyId ?? this.propertyId,
      user: user ?? this.user,
      increase: increase ?? this.increase,
      property: property ?? this.property,
      reservation: reservation ?? this.reservation,
    );
  }
}
