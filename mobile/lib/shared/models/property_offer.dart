import 'contact.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';

class PropertyOffer {
  final String id;
  final String orgId;
  final String propertyId;
  final String? listingId;
  final String contactId;
  final String? originalOfferId;
  final double offerPrice;
  final String currency;
  final DateTime? closingDate;
  final String? financingType;
  final double? earnestMoneyDeposit;
  final int? dueDiligencePeriod;
  final bool inspectionContingency;
  final bool appraisalContingency;
  final String? specialConditions;
  final String status;
  final DateTime? validUntil;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contact contact;
  final Listing? listing;
  final Organization org;
  final PropertyOffer? originalOffer;
  final List<PropertyOffer> counterOffers;
  final Property property;

  const PropertyOffer({
    required this.id,
    required this.orgId,
    required this.propertyId,
    this.listingId,
    required this.contactId,
    this.originalOfferId,
    required this.offerPrice,
    required this.currency,
    this.closingDate,
    this.financingType,
    this.earnestMoneyDeposit,
    this.dueDiligencePeriod,
    required this.inspectionContingency,
    required this.appraisalContingency,
    this.specialConditions,
    required this.status,
    this.validUntil,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.contact,
    this.listing,
    required this.org,
    this.originalOffer,
    this.counterOffers = const [],
    required this.property,
  });

  factory PropertyOffer.fromJson(Map<String, dynamic> json) {
    return PropertyOffer(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      listingId: json['listingId'] as String?,
      contactId: json['contactId'] as String,
      originalOfferId: json['originalOfferId'] as String?,
      offerPrice: (json['offerPrice'] as num).toDouble(),
      currency: json['currency'] as String,
      closingDate: json['closingDate'] != null ? DateTime.parse(json['closingDate'] as String) : null,
      financingType: json['financingType'] as String?,
      earnestMoneyDeposit: (json['earnestMoneyDeposit'] as num?)?.toDouble(),
      dueDiligencePeriod: json['dueDiligencePeriod'] as int?,
      inspectionContingency: json['inspectionContingency'] as bool,
      appraisalContingency: json['appraisalContingency'] as bool,
      specialConditions: json['specialConditions'] as String?,
      status: json['status'] as String,
      validUntil: json['validUntil'] != null ? DateTime.parse(json['validUntil'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      originalOffer: json['originalOffer'] != null ? PropertyOffer.fromJson(json['originalOffer'] as Map<String, dynamic>) : null,
      counterOffers: (json['counterOffers'] as List<dynamic>?)?.map((e) => PropertyOffer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'listingId': listingId,
      'contactId': contactId,
      'originalOfferId': originalOfferId,
      'offerPrice': offerPrice,
      'currency': currency,
      'closingDate': closingDate?.toIso8601String(),
      'financingType': financingType,
      'earnestMoneyDeposit': earnestMoneyDeposit,
      'dueDiligencePeriod': dueDiligencePeriod,
      'inspectionContingency': inspectionContingency,
      'appraisalContingency': appraisalContingency,
      'specialConditions': specialConditions,
      'status': status,
      'validUntil': validUntil?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contact': contact.toJson(),
      'listing': listing?.toJson(),
      'org': org.toJson(),
      'originalOffer': originalOffer?.toJson(),
      'counterOffers': counterOffers.map((e) => e.toJson()).toList(),
      'property': property.toJson(),
    };
  }

  PropertyOffer copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? listingId,
    String? contactId,
    String? originalOfferId,
    double? offerPrice,
    String? currency,
    DateTime? closingDate,
    String? financingType,
    double? earnestMoneyDeposit,
    int? dueDiligencePeriod,
    bool? inspectionContingency,
    bool? appraisalContingency,
    String? specialConditions,
    String? status,
    DateTime? validUntil,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contact? contact,
    Listing? listing,
    Organization? org,
    PropertyOffer? originalOffer,
    List<PropertyOffer>? counterOffers,
    Property? property,
  }) {
    return PropertyOffer(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      contactId: contactId ?? this.contactId,
      originalOfferId: originalOfferId ?? this.originalOfferId,
      offerPrice: offerPrice ?? this.offerPrice,
      currency: currency ?? this.currency,
      closingDate: closingDate ?? this.closingDate,
      financingType: financingType ?? this.financingType,
      earnestMoneyDeposit: earnestMoneyDeposit ?? this.earnestMoneyDeposit,
      dueDiligencePeriod: dueDiligencePeriod ?? this.dueDiligencePeriod,
      inspectionContingency: inspectionContingency ?? this.inspectionContingency,
      appraisalContingency: appraisalContingency ?? this.appraisalContingency,
      specialConditions: specialConditions ?? this.specialConditions,
      status: status ?? this.status,
      validUntil: validUntil ?? this.validUntil,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contact: contact ?? this.contact,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      originalOffer: originalOffer ?? this.originalOffer,
      counterOffers: counterOffers ?? this.counterOffers,
      property: property ?? this.property,
    );
  }
}
