import 'package:reservatior/shared/enums/shared_status.dart';
import 'extra_charge.dart';
import 'facility.dart';
import 'included_service.dart';
import 'organization.dart';
import 'user.dart';

class Agency {
  final String id;
  final String organizationId;
  final String name;
  final String? description;
  final String? email;
  final String? phoneNumber;
  final String? addres;
  final String? website;
  final String? logoUrl;
  final SharedStatus status;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final DateTime updatedAt;
  final String? facilityId;
  final String? includedServiceId;
  final String? extraChargeId;
  final bool isActive;
  final String? ownerId;
  final String? theme;
  final String? externalId;
  final int? totalProperties;
  final int? totalAgents;
  final int? establishedYear;
  final String? licenseNumber;
  final double? commissionRate;
  final String? taxIdentificationNumber;
  final String? taxJurisdiction;
  final Organization organization;
  final ExtraCharge? extraCharge;
  final Facility? facility;
  final IncludedService? includedService;
  final User? owner;
  final List<dynamic> agents;
  final List<dynamic> analytics;
  final List<dynamic> agencyRelations;
  final List<dynamic> organizationAgencies;
  final List<dynamic> communicationLogs;
  final List<dynamic> complianceRecords;
  final List<dynamic> contracts;
  final List<dynamic> expenses;
  final List<dynamic> guests;
  final List<dynamic> hashtags;
  final List<dynamic> languages;
  final List<dynamic> location;
  final List<dynamic> mentions;
  final List<dynamic> notifications;
  final List<dynamic> photos;
  final List<dynamic> posts;
  final List<dynamic> properties;
  final List<dynamic> reports;
  final List<dynamic> reservations;
  final List<dynamic> reviews;
  final List<dynamic> subscriptions;
  final List<dynamic> tasks;
  final List<dynamic> users;
  final List<dynamic> propertyPromotions;

  const Agency({
    required this.id,
    required this.organizationId,
    required this.name,
    this.description,
    this.email,
    this.phoneNumber,
    this.addres,
    this.website,
    this.logoUrl,
    required this.status,
    required this.createdAt,
    this.deletedAt,
    required this.updatedAt,
    this.facilityId,
    this.includedServiceId,
    this.extraChargeId,
    required this.isActive,
    this.ownerId,
    this.theme,
    this.externalId,
    this.totalProperties,
    this.totalAgents,
    this.establishedYear,
    this.licenseNumber,
    this.commissionRate,
    this.taxIdentificationNumber,
    this.taxJurisdiction,
    required this.organization,
    this.extraCharge,
    this.facility,
    this.includedService,
    this.owner,
    this.agents = const [],
    this.analytics = const [],
    this.agencyRelations = const [],
    this.organizationAgencies = const [],
    this.communicationLogs = const [],
    this.complianceRecords = const [],
    this.contracts = const [],
    this.expenses = const [],
    this.guests = const [],
    this.hashtags = const [],
    this.languages = const [],
    this.location = const [],
    this.mentions = const [],
    this.notifications = const [],
    this.photos = const [],
    this.posts = const [],
    this.properties = const [],
    this.reports = const [],
    this.reservations = const [],
    this.reviews = const [],
    this.subscriptions = const [],
    this.tasks = const [],
    this.users = const [],
    this.propertyPromotions = const [],
  });

  factory Agency.fromJson(Map<String, dynamic> json) {
    return Agency(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
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
      facilityId: json['facilityId'] as String?,
      includedServiceId: json['includedServiceId'] as String?,
      extraChargeId: json['extraChargeId'] as String?,
      isActive: json['isActive'] as bool,
      ownerId: json['ownerId'] as String?,
      theme: json['theme'] as String?,
      externalId: json['externalId'] as String?,
      totalProperties: json['totalProperties'] as int?,
      totalAgents: json['totalAgents'] as int?,
      establishedYear: json['establishedYear'] as int?,
      licenseNumber: json['licenseNumber'] as String?,
      commissionRate: (json['commissionRate'] as num?)?.toDouble(),
      taxIdentificationNumber: json['taxIdentificationNumber'] as String?,
      taxJurisdiction: json['taxJurisdiction'] as String?,
      organization: Organization.fromJson(json['organization'] as Map<String, dynamic>),
      extraCharge: json['extraCharge'] != null ? ExtraCharge.fromJson(json['extraCharge'] as Map<String, dynamic>) : null,
      facility: json['facility'] != null ? Facility.fromJson(json['facility'] as Map<String, dynamic>) : null,
      includedService: json['includedService'] != null ? IncludedService.fromJson(json['includedService'] as Map<String, dynamic>) : null,
      owner: json['owner'] != null ? User.fromJson(json['owner'] as Map<String, dynamic>) : null,
      agents: (json['agents'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      analytics: (json['analytics'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      agencyRelations: (json['agencyRelations'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      organizationAgencies: (json['organizationAgencies'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      communicationLogs: (json['communicationLogs'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      complianceRecords: (json['complianceRecords'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      contracts: (json['contracts'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      expenses: (json['expenses'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      guests: (json['guests'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      hashtags: (json['hashtags'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      languages: (json['languages'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      location: (json['location'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      mentions: (json['mentions'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      notifications: (json['notifications'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      photos: (json['photos'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      posts: (json['posts'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      properties: (json['properties'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      reports: (json['reports'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      reservations: (json['reservations'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      reviews: (json['reviews'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      subscriptions: (json['subscriptions'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      tasks: (json['tasks'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      users: (json['users'] as List<dynamic>?)?.cast<dynamic>() ?? [],
      propertyPromotions: (json['propertyPromotions'] as List<dynamic>?)?.cast<dynamic>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'name': name,
      'description': description,
      'email': email,
      'phoneNumber': phoneNumber,
      'Addres': addres,
      'website': website,
      'logoUrl': logoUrl,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'facilityId': facilityId,
      'includedServiceId': includedServiceId,
      'extraChargeId': extraChargeId,
      'isActive': isActive,
      'ownerId': ownerId,
      'theme': theme,
      'externalId': externalId,
      'totalProperties': totalProperties,
      'totalAgents': totalAgents,
      'establishedYear': establishedYear,
      'licenseNumber': licenseNumber,
      'commissionRate': commissionRate,
      'taxIdentificationNumber': taxIdentificationNumber,
      'taxJurisdiction': taxJurisdiction,
      'organization': organization.toJson(),
      'extraCharge': extraCharge?.toJson(),
      'facility': facility?.toJson(),
      'includedService': includedService?.toJson(),
      'owner': owner?.toJson(),
      'agents': agents,
      'analytics': analytics,
      'agencyRelations': agencyRelations,
      'organizationAgencies': organizationAgencies,
      'communicationLogs': communicationLogs,
      'complianceRecords': complianceRecords,
      'contracts': contracts,
      'expenses': expenses,
      'guests': guests,
      'hashtags': hashtags,
      'languages': languages,
      'location': location,
      'mentions': mentions,
      'notifications': notifications,
      'photos': photos,
      'posts': posts,
      'properties': properties,
      'reports': reports,
      'reservations': reservations,
      'reviews': reviews,
      'subscriptions': subscriptions,
      'tasks': tasks,
      'users': users,
      'propertyPromotions': propertyPromotions,
    };
  }

  Agency copyWith({
    String? id,
    String? organizationId,
    String? name,
    String? description,
    String? email,
    String? phoneNumber,
    String? addres,
    String? website,
    String? logoUrl,
    SharedStatus? status,
    DateTime? createdAt,
    DateTime? deletedAt,
    DateTime? updatedAt,
    String? facilityId,
    String? includedServiceId,
    String? extraChargeId,
    bool? isActive,
    String? ownerId,
    String? theme,
    String? externalId,
    int? totalProperties,
    int? totalAgents,
    int? establishedYear,
    String? licenseNumber,
    double? commissionRate,
    String? taxIdentificationNumber,
    String? taxJurisdiction,
    Organization? organization,
    ExtraCharge? extraCharge,
    Facility? facility,
    IncludedService? includedService,
    User? owner,
    List<dynamic>? agents,
    List<dynamic>? analytics,
    List<dynamic>? agencyRelations,
    List<dynamic>? organizationAgencies,
    List<dynamic>? communicationLogs,
    List<dynamic>? complianceRecords,
    List<dynamic>? contracts,
    List<dynamic>? expenses,
    List<dynamic>? guests,
    List<dynamic>? hashtags,
    List<dynamic>? languages,
    List<dynamic>? location,
    List<dynamic>? mentions,
    List<dynamic>? notifications,
    List<dynamic>? photos,
    List<dynamic>? posts,
    List<dynamic>? properties,
    List<dynamic>? reports,
    List<dynamic>? reservations,
    List<dynamic>? reviews,
    List<dynamic>? subscriptions,
    List<dynamic>? tasks,
    List<dynamic>? users,
    List<dynamic>? propertyPromotions,
  }) {
    return Agency(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      description: description ?? this.description,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addres: addres ?? this.addres,
      website: website ?? this.website,
      logoUrl: logoUrl ?? this.logoUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      facilityId: facilityId ?? this.facilityId,
      includedServiceId: includedServiceId ?? this.includedServiceId,
      extraChargeId: extraChargeId ?? this.extraChargeId,
      isActive: isActive ?? this.isActive,
      ownerId: ownerId ?? this.ownerId,
      theme: theme ?? this.theme,
      externalId: externalId ?? this.externalId,
      totalProperties: totalProperties ?? this.totalProperties,
      totalAgents: totalAgents ?? this.totalAgents,
      establishedYear: establishedYear ?? this.establishedYear,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      commissionRate: commissionRate ?? this.commissionRate,
      taxIdentificationNumber: taxIdentificationNumber ?? this.taxIdentificationNumber,
      taxJurisdiction: taxJurisdiction ?? this.taxJurisdiction,
      organization: organization ?? this.organization,
      extraCharge: extraCharge ?? this.extraCharge,
      facility: facility ?? this.facility,
      includedService: includedService ?? this.includedService,
      owner: owner ?? this.owner,
      agents: agents ?? this.agents,
      analytics: analytics ?? this.analytics,
      agencyRelations: agencyRelations ?? this.agencyRelations,
      organizationAgencies: organizationAgencies ?? this.organizationAgencies,
      communicationLogs: communicationLogs ?? this.communicationLogs,
      complianceRecords: complianceRecords ?? this.complianceRecords,
      contracts: contracts ?? this.contracts,
      expenses: expenses ?? this.expenses,
      guests: guests ?? this.guests,
      hashtags: hashtags ?? this.hashtags,
      languages: languages ?? this.languages,
      location: location ?? this.location,
      mentions: mentions ?? this.mentions,
      notifications: notifications ?? this.notifications,
      photos: photos ?? this.photos,
      posts: posts ?? this.posts,
      properties: properties ?? this.properties,
      reports: reports ?? this.reports,
      reservations: reservations ?? this.reservations,
      reviews: reviews ?? this.reviews,
      subscriptions: subscriptions ?? this.subscriptions,
      tasks: tasks ?? this.tasks,
      users: users ?? this.users,
      propertyPromotions: propertyPromotions ?? this.propertyPromotions,
    );
  }
}
