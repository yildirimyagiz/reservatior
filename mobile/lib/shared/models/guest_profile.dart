import 'contact.dart';

class GuestProfile {
  final String id;
  final String contactId;
  final String? preferredCheckInTime;
  final List<String> preferredAmenities;
  final String? dietaryRestrictions;
  final String? accessibilityNeeds;
  final int loyaltyPoints;
  final double lifetimeSpent;
  final int bookingCount;
  final Contact contact;

  const GuestProfile({
    required this.id,
    required this.contactId,
    this.preferredCheckInTime,
    this.preferredAmenities = const [],
    this.dietaryRestrictions,
    this.accessibilityNeeds,
    required this.loyaltyPoints,
    required this.lifetimeSpent,
    required this.bookingCount,
    required this.contact,
  });

  factory GuestProfile.fromJson(Map<String, dynamic> json) {
    return GuestProfile(
      id: json['id'] as String,
      contactId: json['contactId'] as String,
      preferredCheckInTime: json['preferredCheckInTime'] as String?,
      preferredAmenities: (json['preferredAmenities'] as List<dynamic>?)?.cast<String>() ?? [],
      dietaryRestrictions: json['dietaryRestrictions'] as String?,
      accessibilityNeeds: json['accessibilityNeeds'] as String?,
      loyaltyPoints: json['loyaltyPoints'] as int,
      lifetimeSpent: (json['lifetimeSpent'] as num).toDouble(),
      bookingCount: json['bookingCount'] as int,
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contactId': contactId,
      'preferredCheckInTime': preferredCheckInTime,
      'preferredAmenities': preferredAmenities,
      'dietaryRestrictions': dietaryRestrictions,
      'accessibilityNeeds': accessibilityNeeds,
      'loyaltyPoints': loyaltyPoints,
      'lifetimeSpent': lifetimeSpent,
      'bookingCount': bookingCount,
      'contact': contact.toJson(),
    };
  }

  GuestProfile copyWith({
    String? id,
    String? contactId,
    String? preferredCheckInTime,
    List<String>? preferredAmenities,
    String? dietaryRestrictions,
    String? accessibilityNeeds,
    int? loyaltyPoints,
    double? lifetimeSpent,
    int? bookingCount,
    Contact? contact,
  }) {
    return GuestProfile(
      id: id ?? this.id,
      contactId: contactId ?? this.contactId,
      preferredCheckInTime: preferredCheckInTime ?? this.preferredCheckInTime,
      preferredAmenities: preferredAmenities ?? this.preferredAmenities,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      accessibilityNeeds: accessibilityNeeds ?? this.accessibilityNeeds,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      lifetimeSpent: lifetimeSpent ?? this.lifetimeSpent,
      bookingCount: bookingCount ?? this.bookingCount,
      contact: contact ?? this.contact,
    );
  }
}
