
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'payment_status.dart';
import 'booking.dart';
import 'financial_record.dart';
import 'contact.dart';
import 'listing.dart';
import 'organization.dart';
import 'task.dart';
import 'escrow_account.dart';
import 'payment_negotiation.dart';
import 'ai_chat_message.dart';
import 'pricing_rule.dart';
import 'agent.dart';
import 'currency.dart';
import 'guest.dart';
import 'agency.dart';
import 'reference_source.dart';
import 'discount.dart';
import 'analytics.dart';
import 'availability.dart';
import 'compliance_record.dart';
import 'offer.dart';
import 'payment.dart';
import 'extra_charge.dart';


class Reservation implements PrismaModel<String, Reservation> , Id<String> {
    @override
String? id;
	String? orgId;
	String? listingId;
	String? contactId;
	DateTime? checkInDate;
	DateTime? checkOutDate;
	int? guestCount;
	String? specialRequests;
	double? nightlyRate;
	double? cleaningFee;
	double? totalAmount;
	String? currency;
	String? status;
	PaymentStatus? paymentStatus;
	DateTime? validUntil;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Booking>? bookings;
	List<FinancialRecord>? financialRecords;
	Contact? contact;
	Listing? listing;
	Organization? org;
	List<Task>? tasks;
	EscrowAccount? escrowAccount;
	PaymentNegotiation? paymentNegotiation;
	List<AIChatMessage>? aiChatMessages;
	List<PricingRule>? pricingRules;
	List<Agent>? agents;
	List<Currency>? currencies;
	List<Guest>? guests;
	List<Agency>? agencies;
	List<ReferenceSource>? referenceSources;
	List<Discount>? discounts;
	List<Analytics>? analytics;
	List<Availability>? availabilities;
	List<ComplianceRecord>? complianceRecords;
	Offer? offer;
	List<Payment>? payments;
	List<ExtraCharge>? ExtraCharges;
	int? $bookingsCount;
	int? $financialRecordsCount;
	int? $tasksCount;
	int? $aiChatMessagesCount;
	int? $pricingRulesCount;
	int? $agentsCount;
	int? $currenciesCount;
	int? $guestsCount;
	int? $agenciesCount;
	int? $referenceSourcesCount;
	int? $discountsCount;
	int? $analyticsCount;
	int? $availabilitiesCount;
	int? $complianceRecordsCount;
	int? $paymentsCount;
	int? $ExtraChargesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Reservation({ this.id,
	 this.orgId,
	 this.listingId,
	 this.contactId,
	 this.checkInDate,
	 this.checkOutDate,
	 this.guestCount,
	 this.specialRequests,
	 this.nightlyRate,
	 this.cleaningFee,
	 this.totalAmount,
	 this.currency = "USD",
	 this.status = "PENDING",
	 this.paymentStatus = PaymentStatus.UNPAID,
	 this.validUntil,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.bookings,
	 this.financialRecords,
	 this.contact,
	 this.listing,
	 this.org,
	 this.tasks,
	 this.escrowAccount,
	 this.paymentNegotiation,
	 this.aiChatMessages,
	 this.pricingRules,
	 this.agents,
	 this.currencies,
	 this.guests,
	 this.agencies,
	 this.referenceSources,
	 this.discounts,
	 this.analytics,
	 this.availabilities,
	 this.complianceRecords,
	 this.offer,
	 this.payments,
	 this.ExtraCharges,
	this.$bookingsCount,
	this.$financialRecordsCount,
	this.$tasksCount,
	this.$aiChatMessagesCount,
	this.$pricingRulesCount,
	this.$agentsCount,
	this.$currenciesCount,
	this.$guestsCount,
	this.$agenciesCount,
	this.$referenceSourcesCount,
	this.$discountsCount,
	this.$analyticsCount,
	this.$availabilitiesCount,
	this.$complianceRecordsCount,
	this.$paymentsCount,
	this.$ExtraChargesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Reservation, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"listingId": (m) => m.listingId,

	"contactId": (m) => m.contactId,

	"checkInDate": (m) => m.checkInDate,

	"checkOutDate": (m) => m.checkOutDate,

	"guestCount": (m) => m.guestCount,

	"specialRequests": (m) => m.specialRequests,

	"nightlyRate": (m) => m.nightlyRate,

	"cleaningFee": (m) => m.cleaningFee,

	"totalAmount": (m) => m.totalAmount,

	"currency": (m) => m.currency,

	"status": (m) => m.status,

	"paymentStatus": (m) => m.paymentStatus,

	"validUntil": (m) => m.validUntil,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"bookings": (m) => m.bookings,

	"financialRecords": (m) => m.financialRecords,

	"contact": (m) => m.contact,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"tasks": (m) => m.tasks,

	"escrowAccount": (m) => m.escrowAccount,

	"paymentNegotiation": (m) => m.paymentNegotiation,

	"aiChatMessages": (m) => m.aiChatMessages,

	"pricingRules": (m) => m.pricingRules,

	"agents": (m) => m.agents,

	"currencies": (m) => m.currencies,

	"guests": (m) => m.guests,

	"agencies": (m) => m.agencies,

	"referenceSources": (m) => m.referenceSources,

	"discounts": (m) => m.discounts,

	"analytics": (m) => m.analytics,

	"availabilities": (m) => m.availabilities,

	"complianceRecords": (m) => m.complianceRecords,

	"offer": (m) => m.offer,

	"payments": (m) => m.payments,

	"ExtraCharges": (m) => m.ExtraCharges,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Reservation) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Reservation');
    }
    return propFunction as V? Function(Reservation);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Reservation.fromJson(JsonMap json) =>
      Reservation(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	listingId: json['listingId'] as String?,
	contactId: json['contactId'] as String?,
	checkInDate: json['checkInDate'] != null ? DateTime.parse(json['checkInDate']) : null,
	checkOutDate: json['checkOutDate'] != null ? DateTime.parse(json['checkOutDate']) : null,
	guestCount: int.tryParse(json['guestCount'].toString()),
	specialRequests: json['specialRequests'] as String?,
	nightlyRate: json['nightlyRate'] as double?,
	cleaningFee: json['cleaningFee'] as double?,
	totalAmount: json['totalAmount'] as double?,
	currency: json['currency'] as String?,
	status: json['status'] as String?,
	paymentStatus: json['paymentStatus'] != null ? PaymentStatus.fromJson(json['paymentStatus']) : null,
	validUntil: json['validUntil'] != null ? DateTime.parse(json['validUntil']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	bookings: json['bookings'] != null ? createModels<Booking>((json['bookings'] as List).cast<JsonMap>(), Booking.fromJson) : null,
	financialRecords: json['financialRecords'] != null ? createModels<FinancialRecord>((json['financialRecords'] as List).cast<JsonMap>(), FinancialRecord.fromJson) : null,
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	escrowAccount: json['escrowAccount'] != null ? EscrowAccount.fromJson(json['escrowAccount'] as JsonMap) : null,
	paymentNegotiation: json['paymentNegotiation'] != null ? PaymentNegotiation.fromJson(json['paymentNegotiation'] as JsonMap) : null,
	aiChatMessages: json['aiChatMessages'] != null ? createModels<AIChatMessage>((json['aiChatMessages'] as List).cast<JsonMap>(), AIChatMessage.fromJson) : null,
	pricingRules: json['pricingRules'] != null ? createModels<PricingRule>((json['pricingRules'] as List).cast<JsonMap>(), PricingRule.fromJson) : null,
	agents: json['agents'] != null ? createModels<Agent>((json['agents'] as List).cast<JsonMap>(), Agent.fromJson) : null,
	currencies: json['currencies'] != null ? createModels<Currency>((json['currencies'] as List).cast<JsonMap>(), Currency.fromJson) : null,
	guests: json['guests'] != null ? createModels<Guest>((json['guests'] as List).cast<JsonMap>(), Guest.fromJson) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	referenceSources: json['referenceSources'] != null ? createModels<ReferenceSource>((json['referenceSources'] as List).cast<JsonMap>(), ReferenceSource.fromJson) : null,
	discounts: json['discounts'] != null ? createModels<Discount>((json['discounts'] as List).cast<JsonMap>(), Discount.fromJson) : null,
	analytics: json['analytics'] != null ? createModels<Analytics>((json['analytics'] as List).cast<JsonMap>(), Analytics.fromJson) : null,
	availabilities: json['availabilities'] != null ? createModels<Availability>((json['availabilities'] as List).cast<JsonMap>(), Availability.fromJson) : null,
	complianceRecords: json['complianceRecords'] != null ? createModels<ComplianceRecord>((json['complianceRecords'] as List).cast<JsonMap>(), ComplianceRecord.fromJson) : null,
	offer: json['offer'] != null ? Offer.fromJson(json['offer'] as JsonMap) : null,
	payments: json['payments'] != null ? createModels<Payment>((json['payments'] as List).cast<JsonMap>(), Payment.fromJson) : null,
	ExtraCharges: json['ExtraCharges'] != null ? createModels<ExtraCharge>((json['ExtraCharges'] as List).cast<JsonMap>(), ExtraCharge.fromJson) : null,
	$bookingsCount: json['_count']?['bookings'] as int?,
	$financialRecordsCount: json['_count']?['financialRecords'] as int?,
	$tasksCount: json['_count']?['tasks'] as int?,
	$aiChatMessagesCount: json['_count']?['aiChatMessages'] as int?,
	$pricingRulesCount: json['_count']?['pricingRules'] as int?,
	$agentsCount: json['_count']?['agents'] as int?,
	$currenciesCount: json['_count']?['currencies'] as int?,
	$guestsCount: json['_count']?['guests'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$referenceSourcesCount: json['_count']?['referenceSources'] as int?,
	$discountsCount: json['_count']?['discounts'] as int?,
	$analyticsCount: json['_count']?['analytics'] as int?,
	$availabilitiesCount: json['_count']?['availabilities'] as int?,
	$complianceRecordsCount: json['_count']?['complianceRecords'] as int?,
	$paymentsCount: json['_count']?['payments'] as int?,
	$ExtraChargesCount: json['_count']?['ExtraCharges'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Reservation copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? listingId,
		Value<String?>? contactId,
		Value<DateTime?>? checkInDate,
		Value<DateTime?>? checkOutDate,
		Value<int?>? guestCount,
		Value<String?>? specialRequests,
		Value<double?>? nightlyRate,
		Value<double?>? cleaningFee,
		Value<double?>? totalAmount,
		Value<String?>? currency,
		Value<String?>? status,
		Value<PaymentStatus?>? paymentStatus,
		Value<DateTime?>? validUntil,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Booking>?>? bookings,
		Value<List<FinancialRecord>?>? financialRecords,
		Value<Contact?>? contact,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<List<Task>?>? tasks,
		Value<EscrowAccount?>? escrowAccount,
		Value<PaymentNegotiation?>? paymentNegotiation,
		Value<List<AIChatMessage>?>? aiChatMessages,
		Value<List<PricingRule>?>? pricingRules,
		Value<List<Agent>?>? agents,
		Value<List<Currency>?>? currencies,
		Value<List<Guest>?>? guests,
		Value<List<Agency>?>? agencies,
		Value<List<ReferenceSource>?>? referenceSources,
		Value<List<Discount>?>? discounts,
		Value<List<Analytics>?>? analytics,
		Value<List<Availability>?>? availabilities,
		Value<List<ComplianceRecord>?>? complianceRecords,
		Value<Offer?>? offer,
		Value<List<Payment>?>? payments,
		Value<List<ExtraCharge>?>? ExtraCharges,
		int? $bookingsCount,
		int? $financialRecordsCount,
		int? $tasksCount,
		int? $aiChatMessagesCount,
		int? $pricingRulesCount,
		int? $agentsCount,
		int? $currenciesCount,
		int? $guestsCount,
		int? $agenciesCount,
		int? $referenceSourcesCount,
		int? $discountsCount,
		int? $analyticsCount,
		int? $availabilitiesCount,
		int? $complianceRecordsCount,
		int? $paymentsCount,
		int? $ExtraChargesCount,
        }) {
        return Reservation(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		listingId: listingId != null ? listingId.value : this.listingId,
		contactId: contactId != null ? contactId.value : this.contactId,
		checkInDate: checkInDate != null ? checkInDate.value : this.checkInDate,
		checkOutDate: checkOutDate != null ? checkOutDate.value : this.checkOutDate,
		guestCount: guestCount != null ? guestCount.value : this.guestCount,
		specialRequests: specialRequests != null ? specialRequests.value : this.specialRequests,
		nightlyRate: nightlyRate != null ? nightlyRate.value : this.nightlyRate,
		cleaningFee: cleaningFee != null ? cleaningFee.value : this.cleaningFee,
		totalAmount: totalAmount != null ? totalAmount.value : this.totalAmount,
		currency: currency != null ? currency.value : this.currency,
		status: status != null ? status.value : this.status,
		paymentStatus: paymentStatus != null ? paymentStatus.value : this.paymentStatus,
		validUntil: validUntil != null ? validUntil.value : this.validUntil,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		bookings: bookings != null ? bookings.value : this.bookings,
		financialRecords: financialRecords != null ? financialRecords.value : this.financialRecords,
		contact: contact != null ? contact.value : this.contact,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		tasks: tasks != null ? tasks.value : this.tasks,
		escrowAccount: escrowAccount != null ? escrowAccount.value : this.escrowAccount,
		paymentNegotiation: paymentNegotiation != null ? paymentNegotiation.value : this.paymentNegotiation,
		aiChatMessages: aiChatMessages != null ? aiChatMessages.value : this.aiChatMessages,
		pricingRules: pricingRules != null ? pricingRules.value : this.pricingRules,
		agents: agents != null ? agents.value : this.agents,
		currencies: currencies != null ? currencies.value : this.currencies,
		guests: guests != null ? guests.value : this.guests,
		agencies: agencies != null ? agencies.value : this.agencies,
		referenceSources: referenceSources != null ? referenceSources.value : this.referenceSources,
		discounts: discounts != null ? discounts.value : this.discounts,
		analytics: analytics != null ? analytics.value : this.analytics,
		availabilities: availabilities != null ? availabilities.value : this.availabilities,
		complianceRecords: complianceRecords != null ? complianceRecords.value : this.complianceRecords,
		offer: offer != null ? offer.value : this.offer,
		payments: payments != null ? payments.value : this.payments,
		ExtraCharges: ExtraCharges != null ? ExtraCharges.value : this.ExtraCharges,
		$bookingsCount: $bookingsCount ?? this.$bookingsCount,
		$financialRecordsCount: $financialRecordsCount ?? this.$financialRecordsCount,
		$tasksCount: $tasksCount ?? this.$tasksCount,
		$aiChatMessagesCount: $aiChatMessagesCount ?? this.$aiChatMessagesCount,
		$pricingRulesCount: $pricingRulesCount ?? this.$pricingRulesCount,
		$agentsCount: $agentsCount ?? this.$agentsCount,
		$currenciesCount: $currenciesCount ?? this.$currenciesCount,
		$guestsCount: $guestsCount ?? this.$guestsCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$referenceSourcesCount: $referenceSourcesCount ?? this.$referenceSourcesCount,
		$discountsCount: $discountsCount ?? this.$discountsCount,
		$analyticsCount: $analyticsCount ?? this.$analyticsCount,
		$availabilitiesCount: $availabilitiesCount ?? this.$availabilitiesCount,
		$complianceRecordsCount: $complianceRecordsCount ?? this.$complianceRecordsCount,
		$paymentsCount: $paymentsCount ?? this.$paymentsCount,
		$ExtraChargesCount: $ExtraChargesCount ?? this.$ExtraChargesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Reservation copyWithInstanceValues(Reservation reservation) {
        return Reservation(
            id: reservation.id ?? id,
		orgId: reservation.orgId ?? orgId,
		listingId: reservation.listingId ?? listingId,
		contactId: reservation.contactId ?? contactId,
		checkInDate: reservation.checkInDate ?? checkInDate,
		checkOutDate: reservation.checkOutDate ?? checkOutDate,
		guestCount: reservation.guestCount ?? guestCount,
		specialRequests: reservation.specialRequests ?? specialRequests,
		nightlyRate: reservation.nightlyRate ?? nightlyRate,
		cleaningFee: reservation.cleaningFee ?? cleaningFee,
		totalAmount: reservation.totalAmount ?? totalAmount,
		currency: reservation.currency ?? currency,
		status: reservation.status ?? status,
		paymentStatus: reservation.paymentStatus ?? paymentStatus,
		validUntil: reservation.validUntil ?? validUntil,
		createdAt: reservation.createdAt ?? createdAt,
		updatedAt: reservation.updatedAt ?? updatedAt,
		deletedAt: reservation.deletedAt ?? deletedAt,
		bookings: reservation.bookings ?? bookings,
		financialRecords: reservation.financialRecords ?? financialRecords,
		contact: reservation.contact ?? contact,
		listing: reservation.listing ?? listing,
		org: reservation.org ?? org,
		tasks: reservation.tasks ?? tasks,
		escrowAccount: reservation.escrowAccount ?? escrowAccount,
		paymentNegotiation: reservation.paymentNegotiation ?? paymentNegotiation,
		aiChatMessages: reservation.aiChatMessages ?? aiChatMessages,
		pricingRules: reservation.pricingRules ?? pricingRules,
		agents: reservation.agents ?? agents,
		currencies: reservation.currencies ?? currencies,
		guests: reservation.guests ?? guests,
		agencies: reservation.agencies ?? agencies,
		referenceSources: reservation.referenceSources ?? referenceSources,
		discounts: reservation.discounts ?? discounts,
		analytics: reservation.analytics ?? analytics,
		availabilities: reservation.availabilities ?? availabilities,
		complianceRecords: reservation.complianceRecords ?? complianceRecords,
		offer: reservation.offer ?? offer,
		payments: reservation.payments ?? payments,
		ExtraCharges: reservation.ExtraCharges ?? ExtraCharges,
		$bookingsCount: reservation.$bookingsCount ?? $bookingsCount,
		$financialRecordsCount: reservation.$financialRecordsCount ?? $financialRecordsCount,
		$tasksCount: reservation.$tasksCount ?? $tasksCount,
		$aiChatMessagesCount: reservation.$aiChatMessagesCount ?? $aiChatMessagesCount,
		$pricingRulesCount: reservation.$pricingRulesCount ?? $pricingRulesCount,
		$agentsCount: reservation.$agentsCount ?? $agentsCount,
		$currenciesCount: reservation.$currenciesCount ?? $currenciesCount,
		$guestsCount: reservation.$guestsCount ?? $guestsCount,
		$agenciesCount: reservation.$agenciesCount ?? $agenciesCount,
		$referenceSourcesCount: reservation.$referenceSourcesCount ?? $referenceSourcesCount,
		$discountsCount: reservation.$discountsCount ?? $discountsCount,
		$analyticsCount: reservation.$analyticsCount ?? $analyticsCount,
		$availabilitiesCount: reservation.$availabilitiesCount ?? $availabilitiesCount,
		$complianceRecordsCount: reservation.$complianceRecordsCount ?? $complianceRecordsCount,
		$paymentsCount: reservation.$paymentsCount ?? $paymentsCount,
		$ExtraChargesCount: reservation.$ExtraChargesCount ?? $ExtraChargesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Reservation mergeWithInstanceValues(Reservation reservation) {
        return Reservation(
            id: reservation.$assignedFields.contains('id') ? reservation.id : id,
		orgId: reservation.$assignedFields.contains('orgId') ? reservation.orgId : orgId,
		listingId: reservation.$assignedFields.contains('listingId') ? reservation.listingId : listingId,
		contactId: reservation.$assignedFields.contains('contactId') ? reservation.contactId : contactId,
		checkInDate: reservation.$assignedFields.contains('checkInDate') ? reservation.checkInDate : checkInDate,
		checkOutDate: reservation.$assignedFields.contains('checkOutDate') ? reservation.checkOutDate : checkOutDate,
		guestCount: reservation.$assignedFields.contains('guestCount') ? reservation.guestCount : guestCount,
		specialRequests: reservation.$assignedFields.contains('specialRequests') ? reservation.specialRequests : specialRequests,
		nightlyRate: reservation.$assignedFields.contains('nightlyRate') ? reservation.nightlyRate : nightlyRate,
		cleaningFee: reservation.$assignedFields.contains('cleaningFee') ? reservation.cleaningFee : cleaningFee,
		totalAmount: reservation.$assignedFields.contains('totalAmount') ? reservation.totalAmount : totalAmount,
		currency: reservation.$assignedFields.contains('currency') ? reservation.currency : currency,
		status: reservation.$assignedFields.contains('status') ? reservation.status : status,
		paymentStatus: reservation.$assignedFields.contains('paymentStatus') ? reservation.paymentStatus : paymentStatus,
		validUntil: reservation.$assignedFields.contains('validUntil') ? reservation.validUntil : validUntil,
		createdAt: reservation.$assignedFields.contains('createdAt') ? reservation.createdAt : createdAt,
		updatedAt: reservation.$assignedFields.contains('updatedAt') ? reservation.updatedAt : updatedAt,
		deletedAt: reservation.$assignedFields.contains('deletedAt') ? reservation.deletedAt : deletedAt,
		bookings: (reservation.$assignedFields.contains('bookings') && reservation.bookings != null) ? mergeModelLists(bookings, reservation.bookings) : bookings,
		financialRecords: (reservation.$assignedFields.contains('financialRecords') && reservation.financialRecords != null) ? mergeModelLists(financialRecords, reservation.financialRecords) : financialRecords,
		contact: reservation.$assignedFields.contains('contact') ? reservation.contact : contact,
		listing: reservation.$assignedFields.contains('listing') ? reservation.listing : listing,
		org: reservation.$assignedFields.contains('org') ? reservation.org : org,
		tasks: (reservation.$assignedFields.contains('tasks') && reservation.tasks != null) ? mergeModelLists(tasks, reservation.tasks) : tasks,
		escrowAccount: reservation.$assignedFields.contains('escrowAccount') ? reservation.escrowAccount : escrowAccount,
		paymentNegotiation: reservation.$assignedFields.contains('paymentNegotiation') ? reservation.paymentNegotiation : paymentNegotiation,
		aiChatMessages: (reservation.$assignedFields.contains('aiChatMessages') && reservation.aiChatMessages != null) ? mergeModelLists(aiChatMessages, reservation.aiChatMessages) : aiChatMessages,
		pricingRules: (reservation.$assignedFields.contains('pricingRules') && reservation.pricingRules != null) ? mergeModelLists(pricingRules, reservation.pricingRules) : pricingRules,
		agents: (reservation.$assignedFields.contains('agents') && reservation.agents != null) ? mergeModelLists(agents, reservation.agents) : agents,
		currencies: (reservation.$assignedFields.contains('currencies') && reservation.currencies != null) ? mergeModelLists(currencies, reservation.currencies) : currencies,
		guests: (reservation.$assignedFields.contains('guests') && reservation.guests != null) ? mergeModelLists(guests, reservation.guests) : guests,
		agencies: (reservation.$assignedFields.contains('agencies') && reservation.agencies != null) ? mergeModelLists(agencies, reservation.agencies) : agencies,
		referenceSources: (reservation.$assignedFields.contains('referenceSources') && reservation.referenceSources != null) ? mergeModelLists(referenceSources, reservation.referenceSources) : referenceSources,
		discounts: (reservation.$assignedFields.contains('discounts') && reservation.discounts != null) ? mergeModelLists(discounts, reservation.discounts) : discounts,
		analytics: (reservation.$assignedFields.contains('analytics') && reservation.analytics != null) ? mergeModelLists(analytics, reservation.analytics) : analytics,
		availabilities: (reservation.$assignedFields.contains('availabilities') && reservation.availabilities != null) ? mergeModelLists(availabilities, reservation.availabilities) : availabilities,
		complianceRecords: (reservation.$assignedFields.contains('complianceRecords') && reservation.complianceRecords != null) ? mergeModelLists(complianceRecords, reservation.complianceRecords) : complianceRecords,
		offer: reservation.$assignedFields.contains('offer') ? reservation.offer : offer,
		payments: (reservation.$assignedFields.contains('payments') && reservation.payments != null) ? mergeModelLists(payments, reservation.payments) : payments,
		ExtraCharges: (reservation.$assignedFields.contains('ExtraCharges') && reservation.ExtraCharges != null) ? mergeModelLists(ExtraCharges, reservation.ExtraCharges) : ExtraCharges,
		$bookingsCount: reservation.$bookingsCount ?? $bookingsCount,
		$financialRecordsCount: reservation.$financialRecordsCount ?? $financialRecordsCount,
		$tasksCount: reservation.$tasksCount ?? $tasksCount,
		$aiChatMessagesCount: reservation.$aiChatMessagesCount ?? $aiChatMessagesCount,
		$pricingRulesCount: reservation.$pricingRulesCount ?? $pricingRulesCount,
		$agentsCount: reservation.$agentsCount ?? $agentsCount,
		$currenciesCount: reservation.$currenciesCount ?? $currenciesCount,
		$guestsCount: reservation.$guestsCount ?? $guestsCount,
		$agenciesCount: reservation.$agenciesCount ?? $agenciesCount,
		$referenceSourcesCount: reservation.$referenceSourcesCount ?? $referenceSourcesCount,
		$discountsCount: reservation.$discountsCount ?? $discountsCount,
		$analyticsCount: reservation.$analyticsCount ?? $analyticsCount,
		$availabilitiesCount: reservation.$availabilitiesCount ?? $availabilitiesCount,
		$complianceRecordsCount: reservation.$complianceRecordsCount ?? $complianceRecordsCount,
		$paymentsCount: reservation.$paymentsCount ?? $paymentsCount,
		$ExtraChargesCount: reservation.$ExtraChargesCount ?? $ExtraChargesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Reservation updateWithInstanceValues(Reservation reservation) {
        if (reservation.$assignedFields.contains('id')) { id = reservation.id; }
		if (reservation.$assignedFields.contains('orgId')) { orgId = reservation.orgId; }
		if (reservation.$assignedFields.contains('listingId')) { listingId = reservation.listingId; }
		if (reservation.$assignedFields.contains('contactId')) { contactId = reservation.contactId; }
		if (reservation.$assignedFields.contains('checkInDate')) { checkInDate = reservation.checkInDate; }
		if (reservation.$assignedFields.contains('checkOutDate')) { checkOutDate = reservation.checkOutDate; }
		if (reservation.$assignedFields.contains('guestCount')) { guestCount = reservation.guestCount; }
		if (reservation.$assignedFields.contains('specialRequests')) { specialRequests = reservation.specialRequests; }
		if (reservation.$assignedFields.contains('nightlyRate')) { nightlyRate = reservation.nightlyRate; }
		if (reservation.$assignedFields.contains('cleaningFee')) { cleaningFee = reservation.cleaningFee; }
		if (reservation.$assignedFields.contains('totalAmount')) { totalAmount = reservation.totalAmount; }
		if (reservation.$assignedFields.contains('currency')) { currency = reservation.currency; }
		if (reservation.$assignedFields.contains('status')) { status = reservation.status; }
		if (reservation.$assignedFields.contains('paymentStatus')) { paymentStatus = reservation.paymentStatus; }
		if (reservation.$assignedFields.contains('validUntil')) { validUntil = reservation.validUntil; }
		if (reservation.$assignedFields.contains('createdAt')) { createdAt = reservation.createdAt; }
		if (reservation.$assignedFields.contains('updatedAt')) { updatedAt = reservation.updatedAt; }
		if (reservation.$assignedFields.contains('deletedAt')) { deletedAt = reservation.deletedAt; }
		if (reservation.$assignedFields.contains('bookings') && reservation.bookings != null) { bookings = mergeModelLists(bookings, reservation.bookings); }
		if (reservation.$assignedFields.contains('financialRecords') && reservation.financialRecords != null) { financialRecords = mergeModelLists(financialRecords, reservation.financialRecords); }
		if (reservation.$assignedFields.contains('contact')) { contact = reservation.contact; }
		if (reservation.$assignedFields.contains('listing')) { listing = reservation.listing; }
		if (reservation.$assignedFields.contains('org')) { org = reservation.org; }
		if (reservation.$assignedFields.contains('tasks') && reservation.tasks != null) { tasks = mergeModelLists(tasks, reservation.tasks); }
		if (reservation.$assignedFields.contains('escrowAccount')) { escrowAccount = reservation.escrowAccount; }
		if (reservation.$assignedFields.contains('paymentNegotiation')) { paymentNegotiation = reservation.paymentNegotiation; }
		if (reservation.$assignedFields.contains('aiChatMessages') && reservation.aiChatMessages != null) { aiChatMessages = mergeModelLists(aiChatMessages, reservation.aiChatMessages); }
		if (reservation.$assignedFields.contains('pricingRules') && reservation.pricingRules != null) { pricingRules = mergeModelLists(pricingRules, reservation.pricingRules); }
		if (reservation.$assignedFields.contains('agents') && reservation.agents != null) { agents = mergeModelLists(agents, reservation.agents); }
		if (reservation.$assignedFields.contains('currencies') && reservation.currencies != null) { currencies = mergeModelLists(currencies, reservation.currencies); }
		if (reservation.$assignedFields.contains('guests') && reservation.guests != null) { guests = mergeModelLists(guests, reservation.guests); }
		if (reservation.$assignedFields.contains('agencies') && reservation.agencies != null) { agencies = mergeModelLists(agencies, reservation.agencies); }
		if (reservation.$assignedFields.contains('referenceSources') && reservation.referenceSources != null) { referenceSources = mergeModelLists(referenceSources, reservation.referenceSources); }
		if (reservation.$assignedFields.contains('discounts') && reservation.discounts != null) { discounts = mergeModelLists(discounts, reservation.discounts); }
		if (reservation.$assignedFields.contains('analytics') && reservation.analytics != null) { analytics = mergeModelLists(analytics, reservation.analytics); }
		if (reservation.$assignedFields.contains('availabilities') && reservation.availabilities != null) { availabilities = mergeModelLists(availabilities, reservation.availabilities); }
		if (reservation.$assignedFields.contains('complianceRecords') && reservation.complianceRecords != null) { complianceRecords = mergeModelLists(complianceRecords, reservation.complianceRecords); }
		if (reservation.$assignedFields.contains('offer')) { offer = reservation.offer; }
		if (reservation.$assignedFields.contains('payments') && reservation.payments != null) { payments = mergeModelLists(payments, reservation.payments); }
		if (reservation.$assignedFields.contains('ExtraCharges') && reservation.ExtraCharges != null) { ExtraCharges = mergeModelLists(ExtraCharges, reservation.ExtraCharges); }
        return this;
    }

    /// Converts this instance to a JSON object.
    /// 
    /// [serializedTypes] - Internal parameter tracking which model types have been serialized
    /// in the current chain to prevent circular references.
    /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
    /// skipping relations whose types have already been serialized in the current chain.
    /// Set to false to serialize all relations (use with caution - may cause infinite loops).
    @override
    JsonMap toJson({
      Set<String>? serializedTypes,
      bool preventCircularSerialization = true,
    }) {
      final Set<String> serializedModels = preventCircularSerialization 
          ? {...?serializedTypes, 'Reservation'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(listingId != null) 'listingId': listingId,
	if(contactId != null) 'contactId': contactId,
	if(checkInDate != null) 'checkInDate': checkInDate?.toIso8601String(),
	if(checkOutDate != null) 'checkOutDate': checkOutDate?.toIso8601String(),
	if(guestCount != null) 'guestCount': guestCount,
	if(specialRequests != null) 'specialRequests': specialRequests,
	if(nightlyRate != null) 'nightlyRate': nightlyRate,
	if(cleaningFee != null) 'cleaningFee': cleaningFee,
	if(totalAmount != null) 'totalAmount': totalAmount,
	if(currency != null) 'currency': currency,
	if(status != null) 'status': status,
	if(paymentStatus != null) 'paymentStatus': paymentStatus?.toJson(),
	if(validUntil != null) 'validUntil': validUntil?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(bookings != null && (!preventCircularSerialization || !serializedModels.contains('Booking'))) 'bookings': bookings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(financialRecords != null && (!preventCircularSerialization || !serializedModels.contains('FinancialRecord'))) 'financialRecords': financialRecords?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(escrowAccount != null && (!preventCircularSerialization || !serializedModels.contains('EscrowAccount'))) 'escrowAccount': escrowAccount?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(paymentNegotiation != null && (!preventCircularSerialization || !serializedModels.contains('PaymentNegotiation'))) 'paymentNegotiation': paymentNegotiation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(aiChatMessages != null && (!preventCircularSerialization || !serializedModels.contains('AIChatMessage'))) 'aiChatMessages': aiChatMessages?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(pricingRules != null && (!preventCircularSerialization || !serializedModels.contains('PricingRule'))) 'pricingRules': pricingRules?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agents != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'agents': agents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(currencies != null && (!preventCircularSerialization || !serializedModels.contains('Currency'))) 'currencies': currencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(guests != null && (!preventCircularSerialization || !serializedModels.contains('Guest'))) 'guests': guests?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(referenceSources != null && (!preventCircularSerialization || !serializedModels.contains('ReferenceSource'))) 'referenceSources': referenceSources?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(discounts != null && (!preventCircularSerialization || !serializedModels.contains('Discount'))) 'discounts': discounts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(analytics != null && (!preventCircularSerialization || !serializedModels.contains('Analytics'))) 'analytics': analytics?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(availabilities != null && (!preventCircularSerialization || !serializedModels.contains('Availability'))) 'availabilities': availabilities?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(complianceRecords != null && (!preventCircularSerialization || !serializedModels.contains('ComplianceRecord'))) 'complianceRecords': complianceRecords?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(offer != null && (!preventCircularSerialization || !serializedModels.contains('Offer'))) 'offer': offer?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(payments != null && (!preventCircularSerialization || !serializedModels.contains('Payment'))) 'payments': payments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(ExtraCharges != null && (!preventCircularSerialization || !serializedModels.contains('ExtraCharge'))) 'ExtraCharges': ExtraCharges?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($bookingsCount != null || $financialRecordsCount != null || $tasksCount != null || $aiChatMessagesCount != null || $pricingRulesCount != null || $agentsCount != null || $currenciesCount != null || $guestsCount != null || $agenciesCount != null || $referenceSourcesCount != null || $discountsCount != null || $analyticsCount != null || $availabilitiesCount != null || $complianceRecordsCount != null || $paymentsCount != null || $ExtraChargesCount != null) '_count': { 
		if ($bookingsCount != null) 'bookings': $bookingsCount, 
		if ($financialRecordsCount != null) 'financialRecords': $financialRecordsCount, 
		if ($tasksCount != null) 'tasks': $tasksCount, 
		if ($aiChatMessagesCount != null) 'aiChatMessages': $aiChatMessagesCount, 
		if ($pricingRulesCount != null) 'pricingRules': $pricingRulesCount, 
		if ($agentsCount != null) 'agents': $agentsCount, 
		if ($currenciesCount != null) 'currencies': $currenciesCount, 
		if ($guestsCount != null) 'guests': $guestsCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($referenceSourcesCount != null) 'referenceSources': $referenceSourcesCount, 
		if ($discountsCount != null) 'discounts': $discountsCount, 
		if ($analyticsCount != null) 'analytics': $analyticsCount, 
		if ($availabilitiesCount != null) 'availabilities': $availabilitiesCount, 
		if ($complianceRecordsCount != null) 'complianceRecords': $complianceRecordsCount, 
		if ($paymentsCount != null) 'payments': $paymentsCount, 
		if ($ExtraChargesCount != null) 'ExtraCharges': $ExtraChargesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Reservation &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    