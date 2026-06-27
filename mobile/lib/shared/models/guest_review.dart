import 'booking.dart';
import 'contact.dart';
import 'property.dart';

class GuestReview {
  final String id;
  final String bookingId;
  final String guestId;
  final String propertyId;
  final int rating;
  final int? cleanlines;
  final int? communication;
  final int? checkIn;
  final int? accuracy;
  final int? location;
  final int? value;
  final String? comment;
  final String? response;
  final bool isPublic;
  final Booking booking;
  final Contact guest;
  final Property property;

  const GuestReview({
    required this.id,
    required this.bookingId,
    required this.guestId,
    required this.propertyId,
    required this.rating,
    this.cleanlines,
    this.communication,
    this.checkIn,
    this.accuracy,
    this.location,
    this.value,
    this.comment,
    this.response,
    required this.isPublic,
    required this.booking,
    required this.guest,
    required this.property,
  });

  factory GuestReview.fromJson(Map<String, dynamic> json) {
    return GuestReview(
      id: json['id'] as String,
      bookingId: json['bookingId'] as String,
      guestId: json['guestId'] as String,
      propertyId: json['propertyId'] as String,
      rating: json['rating'] as int,
      cleanlines: json['Cleanlines'] as int?,
      communication: json['communication'] as int?,
      checkIn: json['checkIn'] as int?,
      accuracy: json['accuracy'] as int?,
      location: json['location'] as int?,
      value: json['value'] as int?,
      comment: json['comment'] as String?,
      response: json['response'] as String?,
      isPublic: json['isPublic'] as bool,
      booking: Booking.fromJson(json['booking'] as Map<String, dynamic>),
      guest: Contact.fromJson(json['guest'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingId': bookingId,
      'guestId': guestId,
      'propertyId': propertyId,
      'rating': rating,
      'Cleanlines': cleanlines,
      'communication': communication,
      'checkIn': checkIn,
      'accuracy': accuracy,
      'location': location,
      'value': value,
      'comment': comment,
      'response': response,
      'isPublic': isPublic,
      'booking': booking.toJson(),
      'guest': guest.toJson(),
      'property': property.toJson(),
    };
  }

  GuestReview copyWith({
    String? id,
    String? bookingId,
    String? guestId,
    String? propertyId,
    int? rating,
    int? cleanlines,
    int? communication,
    int? checkIn,
    int? accuracy,
    int? location,
    int? value,
    String? comment,
    String? response,
    bool? isPublic,
    Booking? booking,
    Contact? guest,
    Property? property,
  }) {
    return GuestReview(
      id: id ?? this.id,
      bookingId: bookingId ?? this.bookingId,
      guestId: guestId ?? this.guestId,
      propertyId: propertyId ?? this.propertyId,
      rating: rating ?? this.rating,
      cleanlines: cleanlines ?? this.cleanlines,
      communication: communication ?? this.communication,
      checkIn: checkIn ?? this.checkIn,
      accuracy: accuracy ?? this.accuracy,
      location: location ?? this.location,
      value: value ?? this.value,
      comment: comment ?? this.comment,
      response: response ?? this.response,
      isPublic: isPublic ?? this.isPublic,
      booking: booking ?? this.booking,
      guest: guest ?? this.guest,
      property: property ?? this.property,
    );
  }
}
