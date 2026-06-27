import 'package:reservatior/shared/enums/rental_platform.dart';
import 'package:reservatior/shared/enums/rental_status.dart';
import 'api_integration.dart';
import 'organization.dart';

class ExternalRentalListing {
  final String id;
  final String orgId;
  final String integrationId;
  final RentalPlatform platform;
  final String externalId;
  final String? externalUrl;
  final String title;
  final String? description;
  final RentalStatus status;
  final String? addres;
  final String? city;
  final String? state;
  final String? zip;
  final String country;
  final double? latitude;
  final double? longitude;
  final double? nightlyRate;
  final String currency;
  final double? cleaningFee;
  final double? serviceFee;
  final String? checkInTime;
  final String? checkOutTime;
  final int? minStay;
  final int? maxStay;
  final int? bedrooms;
  final double? bathrooms;
  final int? maxGuests;
  final List<String> amenities;
  final DateTime? lastSyncedAt;
  final bool isActive;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final APIIntegration integration;
  final Organization org;

  const ExternalRentalListing({
    required this.id,
    required this.orgId,
    required this.integrationId,
    required this.platform,
    required this.externalId,
    this.externalUrl,
    required this.title,
    this.description,
    required this.status,
    this.addres,
    this.city,
    this.state,
    this.zip,
    required this.country,
    this.latitude,
    this.longitude,
    this.nightlyRate,
    required this.currency,
    this.cleaningFee,
    this.serviceFee,
    this.checkInTime,
    this.checkOutTime,
    this.minStay,
    this.maxStay,
    this.bedrooms,
    this.bathrooms,
    this.maxGuests,
    this.amenities = const [],
    this.lastSyncedAt,
    required this.isActive,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.integration,
    required this.org,
  });

  factory ExternalRentalListing.fromJson(Map<String, dynamic> json) {
    return ExternalRentalListing(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      integrationId: json['integrationId'] as String,
      platform: RentalPlatform.values.firstWhere((v) => v.name == json['platform']),
      externalId: json['externalId'] as String,
      externalUrl: json['externalUrl'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: RentalStatus.values.firstWhere((v) => v.name == json['status']),
      addres: json['Addres'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zip: json['zip'] as String?,
      country: json['country'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      nightlyRate: (json['nightlyRate'] as num?)?.toDouble(),
      currency: json['currency'] as String,
      cleaningFee: (json['cleaningFee'] as num?)?.toDouble(),
      serviceFee: (json['serviceFee'] as num?)?.toDouble(),
      checkInTime: json['checkInTime'] as String?,
      checkOutTime: json['checkOutTime'] as String?,
      minStay: json['minStay'] as int?,
      maxStay: json['maxStay'] as int?,
      bedrooms: json['bedrooms'] as int?,
      bathrooms: (json['bathrooms'] as num?)?.toDouble(),
      maxGuests: json['maxGuests'] as int?,
      amenities: (json['amenities'] as List<dynamic>?)?.cast<String>() ?? [],
      lastSyncedAt: json['lastSyncedAt'] != null ? DateTime.parse(json['lastSyncedAt'] as String) : null,
      isActive: json['isActive'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      integration: APIIntegration.fromJson(json['integration'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'integrationId': integrationId,
      'platform': platform.name,
      'externalId': externalId,
      'externalUrl': externalUrl,
      'title': title,
      'description': description,
      'status': status.name,
      'Addres': addres,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'nightlyRate': nightlyRate,
      'currency': currency,
      'cleaningFee': cleaningFee,
      'serviceFee': serviceFee,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'minStay': minStay,
      'maxStay': maxStay,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'maxGuests': maxGuests,
      'amenities': amenities,
      'lastSyncedAt': lastSyncedAt?.toIso8601String(),
      'isActive': isActive,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'integration': integration.toJson(),
      'org': org.toJson(),
    };
  }

  ExternalRentalListing copyWith({
    String? id,
    String? orgId,
    String? integrationId,
    RentalPlatform? platform,
    String? externalId,
    String? externalUrl,
    String? title,
    String? description,
    RentalStatus? status,
    String? addres,
    String? city,
    String? state,
    String? zip,
    String? country,
    double? latitude,
    double? longitude,
    double? nightlyRate,
    String? currency,
    double? cleaningFee,
    double? serviceFee,
    String? checkInTime,
    String? checkOutTime,
    int? minStay,
    int? maxStay,
    int? bedrooms,
    double? bathrooms,
    int? maxGuests,
    List<String>? amenities,
    DateTime? lastSyncedAt,
    bool? isActive,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    APIIntegration? integration,
    Organization? org,
  }) {
    return ExternalRentalListing(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      integrationId: integrationId ?? this.integrationId,
      platform: platform ?? this.platform,
      externalId: externalId ?? this.externalId,
      externalUrl: externalUrl ?? this.externalUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      addres: addres ?? this.addres,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      nightlyRate: nightlyRate ?? this.nightlyRate,
      currency: currency ?? this.currency,
      cleaningFee: cleaningFee ?? this.cleaningFee,
      serviceFee: serviceFee ?? this.serviceFee,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      minStay: minStay ?? this.minStay,
      maxStay: maxStay ?? this.maxStay,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      maxGuests: maxGuests ?? this.maxGuests,
      amenities: amenities ?? this.amenities,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      isActive: isActive ?? this.isActive,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      integration: integration ?? this.integration,
      org: org ?? this.org,
    );
  }
}
