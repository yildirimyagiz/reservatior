import 'booking.dart';
import 'property.dart';
import 'user.dart';
import 'organization.dart';
import 'contact.dart';
import 'vacation_rental.dart';
import 'reservation.dart';

enum SecurityScreeningStatus {
  PENDING,
  PASSED,
  FAILED,
  REVIEW_REQUIRED,
}

enum SecurityRiskLevel {
  LOW,
  MEDIUM,
  HIGH,
  CRITICAL,
}

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

class BookingSecurityScreening {
  final String id;
  final String? bookingId;
  final String? reservationId;
  final String contactId;
  final String propertyId;
  final String orgId;
  final String? vacationRentalId;
  final SecurityScreeningStatus screeningStatus;
  final SecurityRiskLevel? riskLevel;
  final double? riskScore;
  final double? confidenceScore;
  final Map<String, dynamic>? screeningResults;
  final Map<String, dynamic>? fraudIndicators;
  final Map<String, dynamic>? identityVerification;
  final Map<String, dynamic>? backgroundCheckResults;
  final Map<String, dynamic>? paymentRiskAssessment;
  final Map<String, dynamic>? behavioralAnalysis;
  final String? deviceFingerprint;
  final Map<String, dynamic>? ipGeolocation;
  final Map<String, dynamic>? verificationMethods;
  final bool manualReviewRequired;
  final String? manualReviewBy;
  final String? manualReviewNotes;
  final DateTime? reviewedAt;
  final DateTime? expiresAt;
  final Map<String, dynamic>? screeningMetadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  
  // Relations
  final User? reviewer;
  final Contact? contact;
  final Property? property;
  final Booking? booking;
  final Reservation? reservation;
  final VacationRental? vacationRental;

  const BookingSecurityScreening({
    required this.id,
    this.bookingId,
    this.reservationId,
    required this.contactId,
    required this.propertyId,
    required this.orgId,
    this.vacationRentalId,
    required this.screeningStatus,
    this.riskLevel,
    this.riskScore,
    this.confidenceScore,
    this.screeningResults,
    this.fraudIndicators,
    this.identityVerification,
    this.backgroundCheckResults,
    this.paymentRiskAssessment,
    this.behavioralAnalysis,
    this.deviceFingerprint,
    this.ipGeolocation,
    this.verificationMethods,
    required this.manualReviewRequired,
    this.manualReviewBy,
    this.manualReviewNotes,
    this.reviewedAt,
    this.expiresAt,
    this.screeningMetadata,
    required this.createdAt,
    required this.updatedAt,
    this.reviewer,
    this.contact,
    this.property,
    this.booking,
    this.reservation,
    this.vacationRental,
  });

  factory BookingSecurityScreening.fromJson(Map<String, dynamic> json) {
    return BookingSecurityScreening(
      id: json['id'] as String,
      bookingId: json['bookingId'] as String?,
      reservationId: json['reservationId'] as String?,
      contactId: json['contactId'] as String,
      propertyId: json['propertyId'] as String,
      orgId: json['orgId'] as String,
      vacationRentalId: json['vacationRentalId'] as String?,
      screeningStatus: SecurityScreeningStatus.values.firstWhere(
        (e) => e.name == json['screeningStatus'],
        orElse: () => SecurityScreeningStatus.PENDING,
      ),
      riskLevel: json['riskLevel'] != null 
          ? SecurityRiskLevel.values.firstWhere(
              (e) => e.name == json['riskLevel'],
              orElse: () => SecurityRiskLevel.MEDIUM,
            )
          : null,
      riskScore: (json['riskScore'] as num?)?.toDouble(),
      confidenceScore: (json['confidenceScore'] as num?)?.toDouble(),
      screeningResults: json['screeningResults'] as Map<String, dynamic>?,
      fraudIndicators: json['fraudIndicators'] as Map<String, dynamic>?,
      identityVerification: json['identityVerification'] as Map<String, dynamic>?,
      backgroundCheckResults: json['backgroundCheckResults'] as Map<String, dynamic>?,
      paymentRiskAssessment: json['paymentRiskAssessment'] as Map<String, dynamic>?,
      behavioralAnalysis: json['behavioralAnalysis'] as Map<String, dynamic>?,
      deviceFingerprint: json['deviceFingerprint'] as String?,
      ipGeolocation: json['ipGeolocation'] as Map<String, dynamic>?,
      verificationMethods: json['verificationMethods'] as Map<String, dynamic>?,
      manualReviewRequired: json['manualReviewRequired'] as bool,
      manualReviewBy: json['manualReviewBy'] as String?,
      manualReviewNotes: json['manualReviewNotes'] as String?,
      reviewedAt: json['reviewedAt'] != null 
          ? DateTime.parse(json['reviewedAt'] as String) 
          : null,
      expiresAt: json['expiresAt'] != null 
          ? DateTime.parse(json['expiresAt'] as String) 
          : null,
      screeningMetadata: json['screeningMetadata'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      reviewer: json['reviewer'] != null 
          ? User.fromJson(json['reviewer'] as Map<String, dynamic>) 
          : null,
      contact: json['contact'] != null 
          ? Contact.fromJson(json['contact'] as Map<String, dynamic>) 
          : null,
      property: json['property'] != null 
          ? Property.fromJson(json['property'] as Map<String, dynamic>) 
          : null,
      booking: json['booking'] != null 
          ? Booking.fromJson(json['booking'] as Map<String, dynamic>) 
          : null,
      reservation: json['reservation'] != null 
          ? Reservation.fromJson(json['reservation'] as Map<String, dynamic>) 
          : null,
      vacationRental: json['vacationRental'] != null 
          ? VacationRental.fromJson(json['vacationRental'] as Map<String, dynamic>) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingId': bookingId,
      'reservationId': reservationId,
      'contactId': contactId,
      'propertyId': propertyId,
      'orgId': orgId,
      'vacationRentalId': vacationRentalId,
      'screeningStatus': screeningStatus.name,
      'riskLevel': riskLevel?.name,
      'riskScore': riskScore,
      'confidenceScore': confidenceScore,
      'screeningResults': screeningResults,
      'fraudIndicators': fraudIndicators,
      'identityVerification': identityVerification,
      'backgroundCheckResults': backgroundCheckResults,
      'paymentRiskAssessment': paymentRiskAssessment,
      'behavioralAnalysis': behavioralAnalysis,
      'deviceFingerprint': deviceFingerprint,
      'ipGeolocation': ipGeolocation,
      'verificationMethods': verificationMethods,
      'manualReviewRequired': manualReviewRequired,
      'manualReviewBy': manualReviewBy,
      'manualReviewNotes': manualReviewNotes,
      'reviewedAt': reviewedAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
      'screeningMetadata': screeningMetadata,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'reviewer': reviewer?.toJson(),
      'contact': contact?.toJson(),
      'property': property?.toJson(),
      'booking': booking?.toJson(),
      'reservation': reservation?.toJson(),
      'vacationRental': vacationRental?.toJson(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookingSecurityScreening &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
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
