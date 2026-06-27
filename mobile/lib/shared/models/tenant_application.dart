import 'package:reservatior/shared/enums/application_status.dart';
import 'contact.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';

class TenantApplication {
  final String id;
  final String propertyId;
  final String? listingId;
  final String applicantId;
  final ApplicationStatus status;
  final DateTime submittedAt;
  final DateTime? reviewedAt;
  final String? reviewedBy;
  final int? creditScore;
  final bool incomeVerified;
  final bool backgroundCheck;
  final String? organizationId;
  final Contact applicant;
  final Listing? listing;
  final Organization? organization;
  final Property property;

  const TenantApplication({
    required this.id,
    required this.propertyId,
    this.listingId,
    required this.applicantId,
    required this.status,
    required this.submittedAt,
    this.reviewedAt,
    this.reviewedBy,
    this.creditScore,
    required this.incomeVerified,
    required this.backgroundCheck,
    this.organizationId,
    required this.applicant,
    this.listing,
    this.organization,
    required this.property,
  });

  factory TenantApplication.fromJson(Map<String, dynamic> json) {
    return TenantApplication(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      listingId: json['listingId'] as String?,
      applicantId: json['applicantId'] as String,
      status: ApplicationStatus.values.firstWhere((v) => v.name == json['status']),
      submittedAt: DateTime.parse(json['submittedAt'] as String),
      reviewedAt: json['reviewedAt'] != null ? DateTime.parse(json['reviewedAt'] as String) : null,
      reviewedBy: json['reviewedBy'] as String?,
      creditScore: json['creditScore'] as int?,
      incomeVerified: json['incomeVerified'] as bool,
      backgroundCheck: json['backgroundCheck'] as bool,
      organizationId: json['organizationId'] as String?,
      applicant: Contact.fromJson(json['applicant'] as Map<String, dynamic>),
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      organization: json['organization'] != null ? Organization.fromJson(json['organization'] as Map<String, dynamic>) : null,
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'listingId': listingId,
      'applicantId': applicantId,
      'status': status.name,
      'submittedAt': submittedAt.toIso8601String(),
      'reviewedAt': reviewedAt?.toIso8601String(),
      'reviewedBy': reviewedBy,
      'creditScore': creditScore,
      'incomeVerified': incomeVerified,
      'backgroundCheck': backgroundCheck,
      'organizationId': organizationId,
      'applicant': applicant.toJson(),
      'listing': listing?.toJson(),
      'organization': organization?.toJson(),
      'property': property.toJson(),
    };
  }

  TenantApplication copyWith({
    String? id,
    String? propertyId,
    String? listingId,
    String? applicantId,
    ApplicationStatus? status,
    DateTime? submittedAt,
    DateTime? reviewedAt,
    String? reviewedBy,
    int? creditScore,
    bool? incomeVerified,
    bool? backgroundCheck,
    String? organizationId,
    Contact? applicant,
    Listing? listing,
    Organization? organization,
    Property? property,
  }) {
    return TenantApplication(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      applicantId: applicantId ?? this.applicantId,
      status: status ?? this.status,
      submittedAt: submittedAt ?? this.submittedAt,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      creditScore: creditScore ?? this.creditScore,
      incomeVerified: incomeVerified ?? this.incomeVerified,
      backgroundCheck: backgroundCheck ?? this.backgroundCheck,
      organizationId: organizationId ?? this.organizationId,
      applicant: applicant ?? this.applicant,
      listing: listing ?? this.listing,
      organization: organization ?? this.organization,
      property: property ?? this.property,
    );
  }
}
