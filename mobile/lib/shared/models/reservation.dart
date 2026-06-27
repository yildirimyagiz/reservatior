import 'package:reservatior/shared/enums/payment_status.dart';
import 'agency.dart';
import 'agent.dart';
import 'ai_chat_message.dart';
import 'analytics.dart';
import 'availability.dart';
import 'booking.dart';
import 'compliance_record.dart';
import 'contact.dart';
import 'currency.dart';
import 'discount.dart';
import 'escrow_account.dart';
import 'extra_charge.dart';
import 'financial_record.dart';
import 'guest.dart';
import 'listing.dart';
import 'offer.dart';
import 'organization.dart';
import 'payment.dart';
import 'payment_negotiation.dart';
import 'pricing_rule.dart';
import 'reference_source.dart';
import 'task.dart';

class Reservation {
  final String id;
  final String orgId;
  final String listingId;
  final String contactId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int guestCount;
  final String? specialRequests;
  final double nightlyRate;
  final double cleaningFee;
  final double totalAmount;
  final String currency;
  final String status;
  final PaymentStatus paymentStatus;
  final DateTime? validUntil;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Booking> bookings;
  final List<FinancialRecord> financialRecords;
  final Contact contact;
  final Listing listing;
  final Organization org;
  final List<Task> tasks;
  final EscrowAccount? escrowAccount;
  final PaymentNegotiation? paymentNegotiation;
  final List<AiChatMessage> aiChatMessages;
  final List<PricingRule> pricingRules;
  final List<Agent> agents;
  final List<Currency> currencies;
  final List<Guest> guests;
  final List<Agency> agencies;
  final List<ReferenceSource> referenceSources;
  final List<Discount> discounts;
  final List<Analytics> analytics;
  final List<Availability> availabilities;
  final List<ComplianceRecord> complianceRecords;
  final Offer? offer;
  final List<Payment> payments;
  final List<ExtraCharge> extraCharges;

  const Reservation({
    required this.id,
    required this.orgId,
    required this.listingId,
    required this.contactId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.guestCount,
    this.specialRequests,
    required this.nightlyRate,
    required this.cleaningFee,
    required this.totalAmount,
    required this.currency,
    required this.status,
    required this.paymentStatus,
    this.validUntil,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.bookings = const [],
    this.financialRecords = const [],
    required this.contact,
    required this.listing,
    required this.org,
    this.tasks = const [],
    this.escrowAccount,
    this.paymentNegotiation,
    this.aiChatMessages = const [],
    this.pricingRules = const [],
    this.agents = const [],
    this.currencies = const [],
    this.guests = const [],
    this.agencies = const [],
    this.referenceSources = const [],
    this.discounts = const [],
    this.analytics = const [],
    this.availabilities = const [],
    this.complianceRecords = const [],
    this.offer,
    this.payments = const [],
    this.extraCharges = const [],
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      listingId: json['listingId'] as String,
      contactId: json['contactId'] as String,
      checkInDate: DateTime.parse(json['checkInDate'] as String),
      checkOutDate: DateTime.parse(json['checkOutDate'] as String),
      guestCount: json['guestCount'] as int,
      specialRequests: json['specialRequests'] as String?,
      nightlyRate: (json['nightlyRate'] as num).toDouble(),
      cleaningFee: (json['cleaningFee'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      paymentStatus: PaymentStatus.values.firstWhere((v) => v.name == json['paymentStatus']),
      validUntil: json['validUntil'] != null ? DateTime.parse(json['validUntil'] as String) : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      bookings: (json['bookings'] as List<dynamic>?)?.map((e) => Booking.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      financialRecords: (json['financialRecords'] as List<dynamic>?)?.map((e) => FinancialRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
      listing: Listing.fromJson(json['listing'] as Map<String, dynamic>),
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      escrowAccount: json['escrowAccount'] != null ? EscrowAccount.fromJson(json['escrowAccount'] as Map<String, dynamic>) : null,
      paymentNegotiation: json['paymentNegotiation'] != null ? PaymentNegotiation.fromJson(json['paymentNegotiation'] as Map<String, dynamic>) : null,
      aiChatMessages: (json['aiChatMessages'] as List<dynamic>?)?.map((e) => AiChatMessage.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      pricingRules: (json['pricingRules'] as List<dynamic>?)?.map((e) => PricingRule.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agents: (json['agents'] as List<dynamic>?)?.map((e) => Agent.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      currencies: (json['currencies'] as List<dynamic>?)?.map((e) => Currency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      guests: (json['guests'] as List<dynamic>?)?.map((e) => Guest.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      agencies: (json['agencies'] as List<dynamic>?)?.map((e) => Agency.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      referenceSources: (json['referenceSources'] as List<dynamic>?)?.map((e) => ReferenceSource.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      discounts: (json['discounts'] as List<dynamic>?)?.map((e) => Discount.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      analytics: (json['analytics'] as List<dynamic>?)?.map((e) => Analytics.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      availabilities: (json['availabilities'] as List<dynamic>?)?.map((e) => Availability.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      complianceRecords: (json['complianceRecords'] as List<dynamic>?)?.map((e) => ComplianceRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      offer: json['offer'] != null ? Offer.fromJson(json['offer'] as Map<String, dynamic>) : null,
      payments: (json['payments'] as List<dynamic>?)?.map((e) => Payment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      extraCharges: (json['ExtraCharges'] as List<dynamic>?)?.map((e) => ExtraCharge.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'listingId': listingId,
      'contactId': contactId,
      'checkInDate': checkInDate.toIso8601String(),
      'checkOutDate': checkOutDate.toIso8601String(),
      'guestCount': guestCount,
      'specialRequests': specialRequests,
      'nightlyRate': nightlyRate,
      'cleaningFee': cleaningFee,
      'totalAmount': totalAmount,
      'currency': currency,
      'status': status,
      'paymentStatus': paymentStatus.name,
      'validUntil': validUntil?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'bookings': bookings.map((e) => e.toJson()).toList(),
      'financialRecords': financialRecords.map((e) => e.toJson()).toList(),
      'contact': contact.toJson(),
      'listing': listing.toJson(),
      'org': org.toJson(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'escrowAccount': escrowAccount?.toJson(),
      'paymentNegotiation': paymentNegotiation?.toJson(),
      'aiChatMessages': aiChatMessages.map((e) => e.toJson()).toList(),
      'pricingRules': pricingRules.map((e) => e.toJson()).toList(),
      'agents': agents.map((e) => e.toJson()).toList(),
      'currencies': currencies.map((e) => e.toJson()).toList(),
      'guests': guests.map((e) => e.toJson()).toList(),
      'agencies': agencies.map((e) => e.toJson()).toList(),
      'referenceSources': referenceSources.map((e) => e.toJson()).toList(),
      'discounts': discounts.map((e) => e.toJson()).toList(),
      'analytics': analytics.map((e) => e.toJson()).toList(),
      'availabilities': availabilities.map((e) => e.toJson()).toList(),
      'complianceRecords': complianceRecords.map((e) => e.toJson()).toList(),
      'offer': offer?.toJson(),
      'payments': payments.map((e) => e.toJson()).toList(),
      'ExtraCharges': extraCharges.map((e) => e.toJson()).toList(),
    };
  }

  Reservation copyWith({
    String? id,
    String? orgId,
    String? listingId,
    String? contactId,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? guestCount,
    String? specialRequests,
    double? nightlyRate,
    double? cleaningFee,
    double? totalAmount,
    String? currency,
    String? status,
    PaymentStatus? paymentStatus,
    DateTime? validUntil,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Booking>? bookings,
    List<FinancialRecord>? financialRecords,
    Contact? contact,
    Listing? listing,
    Organization? org,
    List<Task>? tasks,
    EscrowAccount? escrowAccount,
    PaymentNegotiation? paymentNegotiation,
    List<AiChatMessage>? aiChatMessages,
    List<PricingRule>? pricingRules,
    List<Agent>? agents,
    List<Currency>? currencies,
    List<Guest>? guests,
    List<Agency>? agencies,
    List<ReferenceSource>? referenceSources,
    List<Discount>? discounts,
    List<Analytics>? analytics,
    List<Availability>? availabilities,
    List<ComplianceRecord>? complianceRecords,
    Offer? offer,
    List<Payment>? payments,
    List<ExtraCharge>? extraCharges,
  }) {
    return Reservation(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      contactId: contactId ?? this.contactId,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      guestCount: guestCount ?? this.guestCount,
      specialRequests: specialRequests ?? this.specialRequests,
      nightlyRate: nightlyRate ?? this.nightlyRate,
      cleaningFee: cleaningFee ?? this.cleaningFee,
      totalAmount: totalAmount ?? this.totalAmount,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      validUntil: validUntil ?? this.validUntil,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      bookings: bookings ?? this.bookings,
      financialRecords: financialRecords ?? this.financialRecords,
      contact: contact ?? this.contact,
      listing: listing ?? this.listing,
      org: org ?? this.org,
      tasks: tasks ?? this.tasks,
      escrowAccount: escrowAccount ?? this.escrowAccount,
      paymentNegotiation: paymentNegotiation ?? this.paymentNegotiation,
      aiChatMessages: aiChatMessages ?? this.aiChatMessages,
      pricingRules: pricingRules ?? this.pricingRules,
      agents: agents ?? this.agents,
      currencies: currencies ?? this.currencies,
      guests: guests ?? this.guests,
      agencies: agencies ?? this.agencies,
      referenceSources: referenceSources ?? this.referenceSources,
      discounts: discounts ?? this.discounts,
      analytics: analytics ?? this.analytics,
      availabilities: availabilities ?? this.availabilities,
      complianceRecords: complianceRecords ?? this.complianceRecords,
      offer: offer ?? this.offer,
      payments: payments ?? this.payments,
      extraCharges: extraCharges ?? this.extraCharges,
    );
  }
}
