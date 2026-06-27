import 'contact.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';

class Quote {
  final String id;
  final String orgId;
  final String contactId;
  final String quoteNumber;
  final String title;
  final String? description;
  final String? propertyId;
  final String? listingId;
  final double subtotal;
  final double taxAmount;
  final double totalAmount;
  final String currency;
  final DateTime? validUntil;
  final String status;
  final String? notes;
  final String? terms;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contact contact;
  final Listing? listing;
  final Organization org;
  final Property? property;

  const Quote({
    required this.id,
    required this.orgId,
    required this.contactId,
    required this.quoteNumber,
    required this.title,
    this.description,
    this.propertyId,
    this.listingId,
    required this.subtotal,
    required this.taxAmount,
    required this.totalAmount,
    required this.currency,
    this.validUntil,
    required this.status,
    this.notes,
    this.terms,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.contact,
    this.listing,
    required this.org,
    this.property,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      contactId: json['contactId'] as String,
      quoteNumber: json['quoteNumber'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      propertyId: json['propertyId'] as String?,
      listingId: json['listingId'] as String?,
      subtotal: (json['subtotal'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      validUntil: json['validUntil'] != null ? DateTime.parse(json['validUntil'] as String) : null,
      status: json['status'] as String,
      notes: json['notes'] as String?,
      terms: json['terms'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'contactId': contactId,
      'quoteNumber': quoteNumber,
      'title': title,
      'description': description,
      'propertyId': propertyId,
      'listingId': listingId,
      'subtotal': subtotal,
      'taxAmount': taxAmount,
      'totalAmount': totalAmount,
      'currency': currency,
      'validUntil': validUntil?.toIso8601String(),
      'status': status,
      'notes': notes,
      'terms': terms,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contact': contact.toJson(),
      'listing': listing?.toJson(),
      'org': org.toJson(),
      'property': property?.toJson(),
    };
  }

  Quote copyWith({
    String? id,
    String? orgId,
    String? contactId,
    String? quoteNumber,
    String? title,
    String? description,
    String? propertyId,
    String? listingId,
    double? subtotal,
    double? taxAmount,
    double? totalAmount,
    String? currency,
    DateTime? validUntil,
    String? status,
    String? notes,
    String? terms,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contact? contact,
    Listing? listing,
    Organization? org,
    Property? property,
  }) {
    return Quote(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      contactId: contactId ?? this.contactId,
      quoteNumber: quoteNumber ?? this.quoteNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      subtotal: subtotal ?? this.subtotal,
      taxAmount: taxAmount ?? this.taxAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      currency: currency ?? this.currency,
      validUntil: validUntil ?? this.validUntil,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      terms: terms ?? this.terms,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contact: contact ?? this.contact,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      property: property ?? this.property,
    );
  }
}
