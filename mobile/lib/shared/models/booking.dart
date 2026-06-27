import 'package:reservatior/shared/enums/booking_status.dart';
import 'package:reservatior/shared/enums/payment_status.dart';
import 'contact.dart';
import 'contract.dart';
import 'financial_record.dart';
import 'guest_review.dart';
import 'listing.dart';
import 'organization.dart';
import 'reservation.dart';
import 'task.dart';

class Booking {
  final String id;
  final String orgId;
  final String listingId;
  final String? contactId;
  final String? reservationId;
  final BookingStatus status;
  final DateTime startDate;
  final DateTime endDate;
  final int? adults;
  final int? children;
  final double? priceTotal;
  final String? currency;
  final PaymentStatus paymentStatus;
  final String? notes;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final Contact? contact;
  final Listing listing;
  final Organization org;
  final Reservation? reservation;
  final List<Contract> contracts;
  final List<FinancialRecord> financialRecords;
  final List<GuestReview> guestReviews;
  final List<Task> tasks;

  const Booking({
    required this.id,
    required this.orgId,
    required this.listingId,
    this.contactId,
    this.reservationId,
    required this.status,
    required this.startDate,
    required this.endDate,
    this.adults,
    this.children,
    this.priceTotal,
    this.currency,
    required this.paymentStatus,
    this.notes,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.contact,
    required this.listing,
    required this.org,
    this.reservation,
    this.contracts = const [],
    this.financialRecords = const [],
    this.guestReviews = const [],
    this.tasks = const [],
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      listingId: json['listingId'] as String,
      contactId: json['contactId'] as String?,
      reservationId: json['reservationId'] as String?,
      status: BookingStatus.values.firstWhere((v) => v.name == json['status']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      adults: json['adults'] as int?,
      children: json['children'] as int?,
      priceTotal: (json['priceTotal'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      paymentStatus: PaymentStatus.values.firstWhere((v) => v.name == json['paymentStatus']),
      notes: json['notes'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      contact: json['contact'] != null ? Contact.fromJson(json['contact'] as Map<String, dynamic>) : null,
      listing: Listing.fromJson(json['listing'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      reservation: json['reservation'] != null ? Reservation.fromJson(json['reservation'] as Map<String, dynamic>) : null,
      contracts: (json['contracts'] as List<dynamic>?)?.map((e) => Contract.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      financialRecords: (json['financialRecords'] as List<dynamic>?)?.map((e) => FinancialRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      guestReviews: (json['guestReviews'] as List<dynamic>?)?.map((e) => GuestReview.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'listingId': listingId,
      'contactId': contactId,
      'reservationId': reservationId,
      'status': status.name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'adults': adults,
      'children': children,
      'priceTotal': priceTotal,
      'currency': currency,
      'paymentStatus': paymentStatus.name,
      'notes': notes,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'contact': contact?.toJson(),
      'listing': listing.toJson(),
      'org': org.toJson(),
      'reservation': reservation?.toJson(),
      'contracts': contracts.map((e) => e.toJson()).toList(),
      'financialRecords': financialRecords.map((e) => e.toJson()).toList(),
      'guestReviews': guestReviews.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
    };
  }

  Booking copyWith({
    String? id,
    String? orgId,
    String? listingId,
    String? contactId,
    String? reservationId,
    BookingStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    int? adults,
    int? children,
    double? priceTotal,
    String? currency,
    PaymentStatus? paymentStatus,
    String? notes,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    Contact? contact,
    Listing? listing,
    Organization? org,
    Reservation? reservation,
    List<Contract>? contracts,
    List<FinancialRecord>? financialRecords,
    List<GuestReview>? guestReviews,
    List<Task>? tasks,
  }) {
    return Booking(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      contactId: contactId ?? this.contactId,
      reservationId: reservationId ?? this.reservationId,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      priceTotal: priceTotal ?? this.priceTotal,
      currency: currency ?? this.currency,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      notes: notes ?? this.notes,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      contact: contact ?? this.contact,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      reservation: reservation ?? this.reservation,
      contracts: contracts ?? this.contracts,
      financialRecords: financialRecords ?? this.financialRecords,
      guestReviews: guestReviews ?? this.guestReviews,
      tasks: tasks ?? this.tasks,
    );
  }
}
