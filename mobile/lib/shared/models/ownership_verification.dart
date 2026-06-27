import 'property.dart';
import 'user.dart';
import 'organization.dart';
import 'booking.dart';
import 'reservation.dart';
import 'vacation_rental.dart';

enum OwnershipVerificationStatus {
  PENDING,
  VERIFIED,
  REJECTED,
  EXPIRED,
}

enum VerificationMethod {
  MANUAL,
  API,
  BLOCKCHAIN,
  AI,
}

class PropertyOwnershipVerification {
  final String id;
  final String propertyId;
  final String orgId;
  final String? currentOwnerId;
  final OwnershipVerificationStatus verificationStatus;
  final VerificationMethod verificationMethod;
  final DateTime? verifiedAt;
  final String? verifiedBy;
  final DateTime? expiresAt;
  final String? rejectionReason;
  final String? governmentTransactionId;
  final double? aiConfidenceScore;
  final bool manualReviewRequired;
  final bool priorityVerification;
  final String? verificationNotes;
  final Map<String, dynamic>? supportingDocuments;
  final Map<String, dynamic>? ownershipHistory;
  final String? legalDescription;
  final String? parcelNumber;
  final String? jurisdiction;
  final DateTime? recordingDate;
  final Map<String, dynamic>? chainOfCustody;
  final Map<String, dynamic>? verificationMetadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Relations
  final Property? property;
  final Organization? organization;
  final User? currentOwner;
  final User? verifier;
  final List<OwnershipVerificationDocument>? documents;
  final List<Booking>? bookings;
  final List<Reservation>? reservations;
  final List<VacationRental>? vacationRentals;

  const PropertyOwnershipVerification({
    required this.id,
    required this.propertyId,
    required this.orgId,
    this.currentOwnerId,
    required this.verificationStatus,
    required this.verificationMethod,
    this.verifiedAt,
    this.verifiedBy,
    this.expiresAt,
    this.rejectionReason,
    this.governmentTransactionId,
    this.aiConfidenceScore,
    required this.manualReviewRequired,
    required this.priorityVerification,
    this.verificationNotes,
    this.supportingDocuments,
    this.ownershipHistory,
    this.legalDescription,
    this.parcelNumber,
    this.jurisdiction,
    this.recordingDate,
    this.chainOfCustody,
    this.verificationMetadata,
    required this.createdAt,
    required this.updatedAt,
    this.property,
    this.organization,
    this.currentOwner,
    this.verifier,
    this.documents,
    this.bookings,
    this.reservations,
    this.vacationRentals,
  });

  factory PropertyOwnershipVerification.fromJson(Map<String, dynamic> json) {
    return PropertyOwnershipVerification(
      id: json['id'] as String,
      propertyId: json['propertyId'] as String,
      orgId: json['orgId'] as String,
      currentOwnerId: json['currentOwnerId'] as String?,
      verificationStatus: OwnershipVerificationStatus.values.firstWhere(
        (e) => e.name == json['verificationStatus'],
        orElse: () => OwnershipVerificationStatus.PENDING,
      ),
      verificationMethod: VerificationMethod.values.firstWhere(
        (e) => e.name == json['verificationMethod'],
        orElse: () => VerificationMethod.MANUAL,
      ),
      verifiedAt: json['verifiedAt'] != null 
          ? DateTime.parse(json['verifiedAt'] as String) 
          : null,
      verifiedBy: json['verifiedBy'] as String?,
      expiresAt: json['expiresAt'] != null 
          ? DateTime.parse(json['expiresAt'] as String) 
          : null,
      rejectionReason: json['rejectionReason'] as String?,
      governmentTransactionId: json['governmentTransactionId'] as String?,
      aiConfidenceScore: (json['aiConfidenceScore'] as num?)?.toDouble(),
      manualReviewRequired: json['manualReviewRequired'] as bool,
      priorityVerification: json['priorityVerification'] as bool,
      verificationNotes: json['verificationNotes'] as String?,
      supportingDocuments: json['supportingDocuments'] as Map<String, dynamic>?,
      ownershipHistory: json['ownershipHistory'] as Map<String, dynamic>?,
      legalDescription: json['legalDescription'] as String?,
      parcelNumber: json['parcelNumber'] as String?,
      jurisdiction: json['jurisdiction'] as String?,
      recordingDate: json['recordingDate'] != null 
          ? DateTime.parse(json['recordingDate'] as String) 
          : null,
      chainOfCustody: json['chainOfCustody'] as Map<String, dynamic>?,
      verificationMetadata: json['verificationMetadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      property: json['property'] != null 
          ? Property.fromJson(json['property'] as Map<String, dynamic>) 
          : null,
      organization: json['organization'] != null 
          ? Organization.fromJson(json['organization'] as Map<String, dynamic>) 
          : null,
      currentOwner: json['currentOwner'] != null 
          ? User.fromJson(json['currentOwner'] as Map<String, dynamic>) 
          : null,
      verifier: json['verifier'] != null 
          ? User.fromJson(json['verifier'] as Map<String, dynamic>) 
          : null,
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => OwnershipVerificationDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => Booking.fromJson(e as Map<String, dynamic>))
          .toList(),
      reservations: (json['reservations'] as List<dynamic>?)
          ?.map((e) => Reservation.fromJson(e as Map<String, dynamic>))
          .toList(),
      vacationRentals: (json['vacationRentals'] as List<dynamic>?)
          ?.map((e) => VacationRental.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyId': propertyId,
      'orgId': orgId,
      'currentOwnerId': currentOwnerId,
      'verificationStatus': verificationStatus.name,
      'verificationMethod': verificationMethod.name,
      'verifiedAt': verifiedAt?.toIso8601String(),
      'verifiedBy': verifiedBy,
      'expiresAt': expiresAt?.toIso8601String(),
      'rejectionReason': rejectionReason,
      'governmentTransactionId': governmentTransactionId,
      'aiConfidenceScore': aiConfidenceScore,
      'manualReviewRequired': manualReviewRequired,
      'priorityVerification': priorityVerification,
      'verificationNotes': verificationNotes,
      'supportingDocuments': supportingDocuments,
      'ownershipHistory': ownershipHistory,
      'legalDescription': legalDescription,
      'parcelNumber': parcelNumber,
      'jurisdiction': jurisdiction,
      'recordingDate': recordingDate?.toIso8601String(),
      'chainOfCustody': chainOfCustody,
      'verificationMetadata': verificationMetadata,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'property': property?.toJson(),
      'organization': organization?.toJson(),
      'currentOwner': currentOwner?.toJson(),
      'verifier': verifier?.toJson(),
      'documents': documents?.map((e) => e.toJson()).toList(),
      'bookings': bookings?.map((e) => e.toJson()).toList(),
      'reservations': reservations?.map((e) => e.toJson()).toList(),
      'vacationRentals': vacationRentals?.map((e) => e.toJson()).toList(),
    };
  }

  PropertyOwnershipVerification copyWith({
    String? id,
    String? propertyId,
    String? orgId,
    String? currentOwnerId,
    OwnershipVerificationStatus? verificationStatus,
    VerificationMethod? verificationMethod,
    DateTime? verifiedAt,
    String? verifiedBy,
    DateTime? expiresAt,
    String? rejectionReason,
    String? governmentTransactionId,
    double? aiConfidenceScore,
    bool? manualReviewRequired,
    bool? priorityVerification,
    String? verificationNotes,
    Map<String, dynamic>? supportingDocuments,
    Map<String, dynamic>? ownershipHistory,
    String? legalDescription,
    String? parcelNumber,
    String? jurisdiction,
    DateTime? recordingDate,
    Map<String, dynamic>? chainOfCustody,
    Map<String, dynamic>? verificationMetadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    Property? property,
    Organization? organization,
    User? currentOwner,
    User? verifier,
    List<OwnershipVerificationDocument>? documents,
    List<Booking>? bookings,
    List<Reservation>? reservations,
    List<VacationRental>? vacationRentals,
  }) {
    return PropertyOwnershipVerification(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      orgId: orgId ?? this.orgId,
      currentOwnerId: currentOwnerId ?? this.currentOwnerId,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      verificationMethod: verificationMethod ?? this.verificationMethod,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      expiresAt: expiresAt ?? this.expiresAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      governmentTransactionId: governmentTransactionId ?? this.governmentTransactionId,
      aiConfidenceScore: aiConfidenceScore ?? this.aiConfidenceScore,
      manualReviewRequired: manualReviewRequired ?? this.manualReviewRequired,
      priorityVerification: priorityVerification ?? this.priorityVerification,
      verificationNotes: verificationNotes ?? this.verificationNotes,
      supportingDocuments: supportingDocuments ?? this.supportingDocuments,
      ownershipHistory: ownershipHistory ?? this.ownershipHistory,
      legalDescription: legalDescription ?? this.legalDescription,
      parcelNumber: parcelNumber ?? this.parcelNumber,
      jurisdiction: jurisdiction ?? this.jurisdiction,
      recordingDate: recordingDate ?? this.recordingDate,
      chainOfCustody: chainOfCustody ?? this.chainOfCustody,
      verificationMetadata: verificationMetadata ?? this.verificationMetadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      property: property ?? this.property,
      organization: organization ?? this.organization,
      currentOwner: currentOwner ?? this.currentOwner,
      verifier: verifier ?? this.verifier,
      documents: documents ?? this.documents,
      bookings: bookings ?? this.bookings,
      reservations: reservations ?? this.reservations,
      vacationRentals: vacationRentals ?? this.vacationRentals,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropertyOwnershipVerification &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class OwnershipVerificationDocument {
  final String id;
  final String verificationId;
  final String type;
  final String url;
  final String status;
  final DateTime uploadedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OwnershipVerificationDocument({
    required this.id,
    required this.verificationId,
    required this.type,
    required this.url,
    required this.status,
    required this.uploadedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OwnershipVerificationDocument.fromJson(Map<String, dynamic> json) {
    return OwnershipVerificationDocument(
      id: json['id'] as String,
      verificationId: json['verificationId'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      status: json['status'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'verificationId': verificationId,
      'type': type,
      'url': url,
      'status': status,
      'uploadedAt': uploadedAt.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnershipVerificationDocument &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
