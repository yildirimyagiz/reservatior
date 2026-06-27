import 'package:reservatior/shared/enums/payment_status.dart';
import 'package:reservatior/shared/enums/transaction_type.dart';
import 'attachment.dart';
import 'booking.dart';
import 'contact.dart';
import 'lease.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'reservation.dart';

class FinancialRecord {
  final String id;
  final String orgId;
  final String propertyId;
  final String? listingId;
  final String? leaseId;
  final String? bookingId;
  final String? reservationId;
  final String? vendorContactId;
  final String type;
  final TransactionType? recordType;
  final double amount;
  final String currency;
  final DateTime? occurredAt;
  final DateTime? dueDate;
  final String? category;
  final String? description;
  final String? notes;
  final PaymentStatus paymentStatus;
  final DateTime? paidAt;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Attachment> attachments;
  final Booking? booking;
  final Lease? lease;
  final Listing? listing;
  final Organization org;
  final Property property;
  final Reservation? reservation;
  final Contact? vendor;

  const FinancialRecord({
    required this.id,
    required this.orgId,
    required this.propertyId,
    this.listingId,
    this.leaseId,
    this.bookingId,
    this.reservationId,
    this.vendorContactId,
    required this.type,
    this.recordType,
    required this.amount,
    required this.currency,
    this.occurredAt,
    this.dueDate,
    this.category,
    this.description,
    this.notes,
    required this.paymentStatus,
    this.paidAt,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.attachments = const [],
    this.booking,
    this.lease,
    this.listing,
    required this.org,
    required this.property,
    this.reservation,
    this.vendor,
  });

  factory FinancialRecord.fromJson(Map<String, dynamic> json) {
    return FinancialRecord(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      propertyId: json['propertyId'] as String,
      listingId: json['listingId'] as String?,
      leaseId: json['leaseId'] as String?,
      bookingId: json['bookingId'] as String?,
      reservationId: json['reservationId'] as String?,
      vendorContactId: json['vendorContactId'] as String?,
      type: json['type'] as String,
      recordType: json['recordType'] != null ? TransactionType.values.firstWhere((v) => v.name == json['recordType']) : null,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      occurredAt: json['occurredAt'] != null ? DateTime.parse(json['occurredAt'] as String) : null,
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate'] as String) : null,
      category: json['category'] as String?,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      paymentStatus: PaymentStatus.values.firstWhere((v) => v.name == json['paymentStatus']),
      paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt'] as String) : null,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      attachments: (json['attachments'] as List<dynamic>?)?.map((e) => Attachment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      booking: json['booking'] != null ? Booking.fromJson(json['booking'] as Map<String, dynamic>) : null,
      lease: json['lease'] != null ? Lease.fromJson(json['lease'] as Map<String, dynamic>) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: Property.fromJson(json['property'] as Map<String, dynamic>),
      reservation: json['reservation'] != null ? Reservation.fromJson(json['reservation'] as Map<String, dynamic>) : null,
      vendor: json['vendor'] != null ? Contact.fromJson(json['vendor'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'propertyId': propertyId,
      'listingId': listingId,
      'leaseId': leaseId,
      'bookingId': bookingId,
      'reservationId': reservationId,
      'vendorContactId': vendorContactId,
      'type': type,
      'recordType': recordType?.name,
      'amount': amount,
      'currency': currency,
      'occurredAt': occurredAt?.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'category': category,
      'description': description,
      'notes': notes,
      'paymentStatus': paymentStatus.name,
      'paidAt': paidAt?.toIso8601String(),
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'booking': booking?.toJson(),
      'lease': lease?.toJson(),
      'listing': listing?.toJson(),
      'org': org.toJson(),
      'property': property.toJson(),
      'reservation': reservation?.toJson(),
      'vendor': vendor?.toJson(),
    };
  }

  FinancialRecord copyWith({
    String? id,
    String? orgId,
    String? propertyId,
    String? listingId,
    String? leaseId,
    String? bookingId,
    String? reservationId,
    String? vendorContactId,
    String? type,
    TransactionType? recordType,
    double? amount,
    String? currency,
    DateTime? occurredAt,
    DateTime? dueDate,
    String? category,
    String? description,
    String? notes,
    PaymentStatus? paymentStatus,
    DateTime? paidAt,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Attachment>? attachments,
    Booking? booking,
    Lease? lease,
    Listing? listing,
    Organization? org,
    Property? property,
    Reservation? reservation,
    Contact? vendor,
  }) {
    return FinancialRecord(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      listingId: listingId ?? this.listingId,
      leaseId: leaseId ?? this.leaseId,
      bookingId: bookingId ?? this.bookingId,
      reservationId: reservationId ?? this.reservationId,
      vendorContactId: vendorContactId ?? this.vendorContactId,
      type: type ?? this.type,
      recordType: recordType ?? this.recordType,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      occurredAt: occurredAt ?? this.occurredAt,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paidAt: paidAt ?? this.paidAt,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      attachments: attachments ?? this.attachments,
      booking: booking ?? this.booking,
      lease: lease ?? this.lease,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      property: property ?? this.property,
      reservation: reservation ?? this.reservation,
      vendor: vendor ?? this.vendor,
    );
  }
}
