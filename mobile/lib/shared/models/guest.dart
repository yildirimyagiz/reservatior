import 'package:reservatior/shared/enums/gender.dart';
import 'agency.dart';
import 'property.dart';
import 'reservation.dart';

class Guest {
  final String id;
  final String name;
  final String phone;
  final String? image;
  final String nationality;
  final String passportNumber;
  final Gender gender;
  final DateTime birthDate;
  final String addres;
  final String city;
  final String country;
  final String zipCode;
  final String email;
  final String? agencyId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Agency? agency;
  final List<Property> property;
  final List<Reservation> reservation;

  const Guest({
    required this.id,
    required this.name,
    required this.phone,
    this.image,
    required this.nationality,
    required this.passportNumber,
    required this.gender,
    required this.birthDate,
    required this.addres,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.email,
    this.agencyId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.agency,
    this.property = const [],
    this.reservation = const [],
  });

  factory Guest.fromJson(Map<String, dynamic> json) {
    return Guest(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String?,
      nationality: json['nationality'] as String,
      passportNumber: json['passportNumber'] as String,
      gender: Gender.values.firstWhere((v) => v.name == json['gender']),
      birthDate: DateTime.parse(json['birthDate'] as String),
      addres: json['Addres'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      zipCode: json['zipCode'] as String,
      email: json['email'] as String,
      agencyId: json['agencyId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as Map<String, dynamic>) : null,
      property: (json['Property'] as List<dynamic>?)?.map((e) => Property.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reservation: (json['Reservation'] as List<dynamic>?)?.map((e) => Reservation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'image': image,
      'nationality': nationality,
      'passportNumber': passportNumber,
      'gender': gender.name,
      'birthDate': birthDate.toIso8601String(),
      'Addres': addres,
      'city': city,
      'country': country,
      'zipCode': zipCode,
      'email': email,
      'agencyId': agencyId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'Agency': agency?.toJson(),
      'Property': property.map((e) => e.toJson()).toList(),
      'Reservation': reservation.map((e) => e.toJson()).toList(),
    };
  }

  Guest copyWith({
    String? id,
    String? name,
    String? phone,
    String? image,
    String? nationality,
    String? passportNumber,
    Gender? gender,
    DateTime? birthDate,
    String? addres,
    String? city,
    String? country,
    String? zipCode,
    String? email,
    String? agencyId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Agency? agency,
    List<Property>? property,
    List<Reservation>? reservation,
  }) {
    return Guest(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      nationality: nationality ?? this.nationality,
      passportNumber: passportNumber ?? this.passportNumber,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      addres: addres ?? this.addres,
      city: city ?? this.city,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      email: email ?? this.email,
      agencyId: agencyId ?? this.agencyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      agency: agency ?? this.agency,
      property: property ?? this.property,
      reservation: reservation ?? this.reservation,
    );
  }
}
