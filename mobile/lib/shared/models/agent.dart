import 'package:reservatior/shared/enums/agent_specialities.dart';
import 'package:reservatior/shared/enums/shared_status.dart';
import 'agency.dart';
import 'analytics.dart';
import 'compliance_record.dart';
import 'language.dart';
import 'location.dart';
import 'notification.dart';
import 'photo.dart';
import 'post.dart';
import 'property.dart';
import 'property_promotion.dart';
import 'report.dart';
import 'reservation.dart';
import 'review.dart';
import 'subscription.dart';
import 'task.dart';
import 'user.dart';

class Agent {
  final String id;
  final String name;
  final String? email;
  final String? phoneNumber;
  final String? bio;
  final String? locationId;
  final String? addres;
  final String? website;
  final String? logoUrl;
  final SharedStatus status;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final DateTime updatedAt;
  final String? agencyId;
  final String? licenseNumber;
  final double? commissionRate;
  final List<String> specialties;
  final List<String> serviceAreas;
  final int? yearsOfExperience;
  final List<String> certifications;
  final String? education;
  final List<String> languageCodes;
  final List<AgentSpecialities> specialities;
  final String? externalId;
  final String? ownerId;
  final DateTime? lastActive;
  final Agency? agency;
  final Location? location;
  final User? owner;
  final List<Analytics> analytics;
  final List<ComplianceRecord> complianceRecords;
  final List<Language> languages;
  final List<Notification> notifications;
  final List<Photo> photos;
  final List<Post> posts;
  final List<Property> properties;
  final List<Report> reports;
  final List<Reservation> reservations;
  final List<Review> reviews;
  final List<Subscription> subscriptions;
  final List<Task> tasks;
  final List<PropertyPromotion> propertyPromotions;

  const Agent({
    required this.id,
    required this.name,
    this.email,
    this.phoneNumber,
    this.bio,
    this.locationId,
    this.addres,
    this.website,
    this.logoUrl,
    required this.status,
    required this.createdAt,
    this.deletedAt,
    required this.updatedAt,
    this.agencyId,
    this.licenseNumber,
    this.commissionRate,
    this.specialties = const [],
    this.serviceAreas = const [],
    this.yearsOfExperience,
    this.certifications = const [],
    this.education,
    this.languageCodes = const [],
    this.specialities = const [],
    this.externalId,
    this.ownerId,
    this.lastActive,
    this.agency,
    this.location,
    this.owner,
    this.analytics = const [],
    this.complianceRecords = const [],
    this.languages = const [],
    this.notifications = const [],
    this.photos = const [],
    this.posts = const [],
    this.properties = const [],
    this.reports = const [],
    this.reservations = const [],
    this.reviews = const [],
    this.subscriptions = const [],
    this.tasks = const [],
    this.propertyPromotions = const [],
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      bio: json['bio'] as String?,
      locationId: json['locationId'] as String?,
      addres: json['Addres'] as String?,
      website: json['website'] as String?,
      logoUrl: json['logoUrl'] as String?,
      status: (() {
        final valUpper = json['status']?.toString().toUpperCase() ?? '';
        return SharedStatus.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => SharedStatus.PENDING,
        );
      })(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      agencyId: json['agencyId'] as String?,
      licenseNumber: json['licenseNumber'] as String?,
      commissionRate: (json['commissionRate'] as num?)?.toDouble(),
      specialties: (json['specialties'] as List<dynamic>?)?.cast<String>() ?? [],
      serviceAreas: (json['serviceAreas'] as List<dynamic>?)?.cast<String>() ?? [],
      yearsOfExperience: json['yearsOfExperience'] as int?,
      certifications: (json['certifications'] as List<dynamic>?)?.cast<String>() ?? [],
      education: json['education'] as String?,
      languageCodes: (json['languages'] as List<dynamic>?)?.cast<String>() ?? [],
      specialities: (json['specialities'] as List<dynamic>?)?.map((e) {
        final valUpper = e?.toString().toUpperCase() ?? '';
        return AgentSpecialities.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => AgentSpecialities.OTHER,
        );
      }).toList() ?? [],
      externalId: json['externalId'] as String?,
      ownerId: json['ownerId'] as String?,
      lastActive: json['lastActive'] != null ? DateTime.parse(json['lastActive'] as String) : null,
      agency: json['agency'] != null ? Agency.fromJson(json['agency'] as Map<String, dynamic>) : null,
      location: json['location'] != null ? Location.fromJson(json['location'] as Map<String, dynamic>) : null,
      owner: json['owner'] != null ? User.fromJson(json['owner'] as Map<String, dynamic>) : null,
      analytics: (json['analytics'] as List<dynamic>?)?.map((e) => Analytics.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      complianceRecords: (json['complianceRecords'] as List<dynamic>?)?.map((e) => ComplianceRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      languages: (json['languages'] as List<dynamic>?)?.map((e) => Language.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      notifications: (json['notifications'] as List<dynamic>?)?.map((e) => Notification.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      photos: (json['photos'] as List<dynamic>?)?.map((e) => Photo.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      posts: (json['posts'] as List<dynamic>?)?.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      properties: (json['properties'] as List<dynamic>?)?.map((e) => Property.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reports: (json['reports'] as List<dynamic>?)?.map((e) => Report.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reservations: (json['reservations'] as List<dynamic>?)?.map((e) => Reservation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reviews: (json['reviews'] as List<dynamic>?)?.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      subscriptions: (json['subscriptions'] as List<dynamic>?)?.map((e) => Subscription.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyPromotions: (json['propertyPromotions'] as List<dynamic>?)?.map((e) => PropertyPromotion.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'locationId': locationId,
      'Addres': addres,
      'website': website,
      'logoUrl': logoUrl,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'agencyId': agencyId,
      'licenseNumber': licenseNumber,
      'commissionRate': commissionRate,
      'specialties': specialties,
      'serviceAreas': serviceAreas,
      'yearsOfExperience': yearsOfExperience,
      'certifications': certifications,
      'education': education,
      'languageCodes': languageCodes,
      'specialities': specialities.map((e) => e.name).toList(),
      'externalId': externalId,
      'ownerId': ownerId,
      'lastActive': lastActive?.toIso8601String(),
      'agency': agency?.toJson(),
      'location': location?.toJson(),
      'owner': owner?.toJson(),
      'analytics': analytics.map((e) => e.toJson()).toList(),
      'complianceRecords': complianceRecords.map((e) => e.toJson()).toList(),
      'languages': languages.map((e) => e.toJson()).toList(),
      'notifications': notifications.map((e) => e.toJson()).toList(),
      'photos': photos.map((e) => e.toJson()).toList(),
      'posts': posts.map((e) => e.toJson()).toList(),
      'properties': properties.map((e) => e.toJson()).toList(),
      'reports': reports.map((e) => e.toJson()).toList(),
      'reservations': reservations.map((e) => e.toJson()).toList(),
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'subscriptions': subscriptions.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'propertyPromotions': propertyPromotions.map((e) => e.toJson()).toList(),
    };
  }

  Agent copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? bio,
    String? locationId,
    String? addres,
    String? website,
    String? logoUrl,
    SharedStatus? status,
    DateTime? createdAt,
    DateTime? deletedAt,
    DateTime? updatedAt,
    String? agencyId,
    String? licenseNumber,
    double? commissionRate,
    List<String>? specialties,
    List<String>? serviceAreas,
    int? yearsOfExperience,
    List<String>? certifications,
    String? education,
    List<String>? languageCodes,
    List<AgentSpecialities>? specialities,
    String? externalId,
    String? ownerId,
    DateTime? lastActive,
    Agency? agency,
    Location? location,
    User? owner,
    List<Analytics>? analytics,
    List<ComplianceRecord>? complianceRecords,
    List<Language>? languages,
    List<Notification>? notifications,
    List<Photo>? photos,
    List<Post>? posts,
    List<Property>? properties,
    List<Report>? reports,
    List<Reservation>? reservations,
    List<Review>? reviews,
    List<Subscription>? subscriptions,
    List<Task>? tasks,
    List<PropertyPromotion>? propertyPromotions,
  }) {
    return Agent(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      bio: bio ?? this.bio,
      locationId: locationId ?? this.locationId,
      addres: addres ?? this.addres,
      website: website ?? this.website,
      logoUrl: logoUrl ?? this.logoUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      agencyId: agencyId ?? this.agencyId,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      commissionRate: commissionRate ?? this.commissionRate,
      specialties: specialties ?? this.specialties,
      serviceAreas: serviceAreas ?? this.serviceAreas,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      certifications: certifications ?? this.certifications,
      education: education ?? this.education,
      languageCodes: languageCodes ?? this.languageCodes,
      specialities: specialities ?? this.specialities,
      externalId: externalId ?? this.externalId,
      ownerId: ownerId ?? this.ownerId,
      lastActive: lastActive ?? this.lastActive,
      agency: agency ?? this.agency,
      location: location ?? this.location,
      owner: owner ?? this.owner,
      analytics: analytics ?? this.analytics,
      complianceRecords: complianceRecords ?? this.complianceRecords,
      languages: languages ?? this.languages,
      notifications: notifications ?? this.notifications,
      photos: photos ?? this.photos,
      posts: posts ?? this.posts,
      properties: properties ?? this.properties,
      reports: reports ?? this.reports,
      reservations: reservations ?? this.reservations,
      reviews: reviews ?? this.reviews,
      subscriptions: subscriptions ?? this.subscriptions,
      tasks: tasks ?? this.tasks,
      propertyPromotions: propertyPromotions ?? this.propertyPromotions,
    );
  }
}
