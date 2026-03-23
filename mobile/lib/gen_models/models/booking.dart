
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'booking_status.dart';
import 'payment_status.dart';
import 'contact.dart';
import 'listing.dart';
import 'organization.dart';
import 'reservation.dart';
import 'contract.dart';
import 'financial_record.dart';
import 'guest_review.dart';
import 'task.dart';


class Booking implements PrismaModel<String, Booking> , Id<String> {
    @override
String? id;
	String? orgId;
	String? listingId;
	String? contactId;
	String? reservationId;
	BookingStatus? status;
	DateTime? startDate;
	DateTime? endDate;
	int? adults;
	int? children;
	double? priceTotal;
	String? currency;
	PaymentStatus? paymentStatus;
	String? notes;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contact? contact;
	Listing? listing;
	Organization? org;
	Reservation? reservation;
	List<Contract>? contracts;
	List<FinancialRecord>? financialRecords;
	List<GuestReview>? guestReviews;
	List<Task>? tasks;
	int? $contractsCount;
	int? $financialRecordsCount;
	int? $guestReviewsCount;
	int? $tasksCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Booking({ this.id,
	 this.orgId,
	 this.listingId,
	 this.contactId,
	 this.reservationId,
	 this.status = BookingStatus.DRAFT,
	 this.startDate,
	 this.endDate,
	 this.adults = 1,
	 this.children = 0,
	 this.priceTotal,
	 this.currency,
	 this.paymentStatus = PaymentStatus.UNPAID,
	 this.notes,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contact,
	 this.listing,
	 this.org,
	 this.reservation,
	 this.contracts,
	 this.financialRecords,
	 this.guestReviews,
	 this.tasks,
	this.$contractsCount,
	this.$financialRecordsCount,
	this.$guestReviewsCount,
	this.$tasksCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Booking, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"listingId": (m) => m.listingId,

	"contactId": (m) => m.contactId,

	"reservationId": (m) => m.reservationId,

	"status": (m) => m.status,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"adults": (m) => m.adults,

	"children": (m) => m.children,

	"priceTotal": (m) => m.priceTotal,

	"currency": (m) => m.currency,

	"paymentStatus": (m) => m.paymentStatus,

	"notes": (m) => m.notes,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contact": (m) => m.contact,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"reservation": (m) => m.reservation,

	"contracts": (m) => m.contracts,

	"financialRecords": (m) => m.financialRecords,

	"guestReviews": (m) => m.guestReviews,

	"tasks": (m) => m.tasks,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Booking) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Booking');
    }
    return propFunction as V? Function(Booking);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Booking.fromJson(JsonMap json) =>
      Booking(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	listingId: json['listingId'] as String?,
	contactId: json['contactId'] as String?,
	reservationId: json['reservationId'] as String?,
	status: json['status'] != null ? BookingStatus.fromJson(json['status']) : null,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	adults: int.tryParse(json['adults'].toString()),
	children: int.tryParse(json['children'].toString()),
	priceTotal: json['priceTotal'] as double?,
	currency: json['currency'] as String?,
	paymentStatus: json['paymentStatus'] != null ? PaymentStatus.fromJson(json['paymentStatus']) : null,
	notes: json['notes'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	reservation: json['reservation'] != null ? Reservation.fromJson(json['reservation'] as JsonMap) : null,
	contracts: json['contracts'] != null ? createModels<Contract>((json['contracts'] as List).cast<JsonMap>(), Contract.fromJson) : null,
	financialRecords: json['financialRecords'] != null ? createModels<FinancialRecord>((json['financialRecords'] as List).cast<JsonMap>(), FinancialRecord.fromJson) : null,
	guestReviews: json['guestReviews'] != null ? createModels<GuestReview>((json['guestReviews'] as List).cast<JsonMap>(), GuestReview.fromJson) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	$contractsCount: json['_count']?['contracts'] as int?,
	$financialRecordsCount: json['_count']?['financialRecords'] as int?,
	$guestReviewsCount: json['_count']?['guestReviews'] as int?,
	$tasksCount: json['_count']?['tasks'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Booking copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? listingId,
		Value<String?>? contactId,
		Value<String?>? reservationId,
		Value<BookingStatus?>? status,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<int?>? adults,
		Value<int?>? children,
		Value<double?>? priceTotal,
		Value<String?>? currency,
		Value<PaymentStatus?>? paymentStatus,
		Value<String?>? notes,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contact?>? contact,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Reservation?>? reservation,
		Value<List<Contract>?>? contracts,
		Value<List<FinancialRecord>?>? financialRecords,
		Value<List<GuestReview>?>? guestReviews,
		Value<List<Task>?>? tasks,
		int? $contractsCount,
		int? $financialRecordsCount,
		int? $guestReviewsCount,
		int? $tasksCount,
        }) {
        return Booking(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		listingId: listingId != null ? listingId.value : this.listingId,
		contactId: contactId != null ? contactId.value : this.contactId,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		status: status != null ? status.value : this.status,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		adults: adults != null ? adults.value : this.adults,
		children: children != null ? children.value : this.children,
		priceTotal: priceTotal != null ? priceTotal.value : this.priceTotal,
		currency: currency != null ? currency.value : this.currency,
		paymentStatus: paymentStatus != null ? paymentStatus.value : this.paymentStatus,
		notes: notes != null ? notes.value : this.notes,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contact: contact != null ? contact.value : this.contact,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		reservation: reservation != null ? reservation.value : this.reservation,
		contracts: contracts != null ? contracts.value : this.contracts,
		financialRecords: financialRecords != null ? financialRecords.value : this.financialRecords,
		guestReviews: guestReviews != null ? guestReviews.value : this.guestReviews,
		tasks: tasks != null ? tasks.value : this.tasks,
		$contractsCount: $contractsCount ?? this.$contractsCount,
		$financialRecordsCount: $financialRecordsCount ?? this.$financialRecordsCount,
		$guestReviewsCount: $guestReviewsCount ?? this.$guestReviewsCount,
		$tasksCount: $tasksCount ?? this.$tasksCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Booking copyWithInstanceValues(Booking booking) {
        return Booking(
            id: booking.id ?? id,
		orgId: booking.orgId ?? orgId,
		listingId: booking.listingId ?? listingId,
		contactId: booking.contactId ?? contactId,
		reservationId: booking.reservationId ?? reservationId,
		status: booking.status ?? status,
		startDate: booking.startDate ?? startDate,
		endDate: booking.endDate ?? endDate,
		adults: booking.adults ?? adults,
		children: booking.children ?? children,
		priceTotal: booking.priceTotal ?? priceTotal,
		currency: booking.currency ?? currency,
		paymentStatus: booking.paymentStatus ?? paymentStatus,
		notes: booking.notes ?? notes,
		createdBy: booking.createdBy ?? createdBy,
		createdAt: booking.createdAt ?? createdAt,
		updatedAt: booking.updatedAt ?? updatedAt,
		deletedAt: booking.deletedAt ?? deletedAt,
		contact: booking.contact ?? contact,
		listing: booking.listing ?? listing,
		org: booking.org ?? org,
		reservation: booking.reservation ?? reservation,
		contracts: booking.contracts ?? contracts,
		financialRecords: booking.financialRecords ?? financialRecords,
		guestReviews: booking.guestReviews ?? guestReviews,
		tasks: booking.tasks ?? tasks,
		$contractsCount: booking.$contractsCount ?? $contractsCount,
		$financialRecordsCount: booking.$financialRecordsCount ?? $financialRecordsCount,
		$guestReviewsCount: booking.$guestReviewsCount ?? $guestReviewsCount,
		$tasksCount: booking.$tasksCount ?? $tasksCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Booking mergeWithInstanceValues(Booking booking) {
        return Booking(
            id: booking.$assignedFields.contains('id') ? booking.id : id,
		orgId: booking.$assignedFields.contains('orgId') ? booking.orgId : orgId,
		listingId: booking.$assignedFields.contains('listingId') ? booking.listingId : listingId,
		contactId: booking.$assignedFields.contains('contactId') ? booking.contactId : contactId,
		reservationId: booking.$assignedFields.contains('reservationId') ? booking.reservationId : reservationId,
		status: booking.$assignedFields.contains('status') ? booking.status : status,
		startDate: booking.$assignedFields.contains('startDate') ? booking.startDate : startDate,
		endDate: booking.$assignedFields.contains('endDate') ? booking.endDate : endDate,
		adults: booking.$assignedFields.contains('adults') ? booking.adults : adults,
		children: booking.$assignedFields.contains('children') ? booking.children : children,
		priceTotal: booking.$assignedFields.contains('priceTotal') ? booking.priceTotal : priceTotal,
		currency: booking.$assignedFields.contains('currency') ? booking.currency : currency,
		paymentStatus: booking.$assignedFields.contains('paymentStatus') ? booking.paymentStatus : paymentStatus,
		notes: booking.$assignedFields.contains('notes') ? booking.notes : notes,
		createdBy: booking.$assignedFields.contains('createdBy') ? booking.createdBy : createdBy,
		createdAt: booking.$assignedFields.contains('createdAt') ? booking.createdAt : createdAt,
		updatedAt: booking.$assignedFields.contains('updatedAt') ? booking.updatedAt : updatedAt,
		deletedAt: booking.$assignedFields.contains('deletedAt') ? booking.deletedAt : deletedAt,
		contact: booking.$assignedFields.contains('contact') ? booking.contact : contact,
		listing: booking.$assignedFields.contains('listing') ? booking.listing : listing,
		org: booking.$assignedFields.contains('org') ? booking.org : org,
		reservation: booking.$assignedFields.contains('reservation') ? booking.reservation : reservation,
		contracts: (booking.$assignedFields.contains('contracts') && booking.contracts != null) ? mergeModelLists(contracts, booking.contracts) : contracts,
		financialRecords: (booking.$assignedFields.contains('financialRecords') && booking.financialRecords != null) ? mergeModelLists(financialRecords, booking.financialRecords) : financialRecords,
		guestReviews: (booking.$assignedFields.contains('guestReviews') && booking.guestReviews != null) ? mergeModelLists(guestReviews, booking.guestReviews) : guestReviews,
		tasks: (booking.$assignedFields.contains('tasks') && booking.tasks != null) ? mergeModelLists(tasks, booking.tasks) : tasks,
		$contractsCount: booking.$contractsCount ?? $contractsCount,
		$financialRecordsCount: booking.$financialRecordsCount ?? $financialRecordsCount,
		$guestReviewsCount: booking.$guestReviewsCount ?? $guestReviewsCount,
		$tasksCount: booking.$tasksCount ?? $tasksCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Booking updateWithInstanceValues(Booking booking) {
        if (booking.$assignedFields.contains('id')) { id = booking.id; }
		if (booking.$assignedFields.contains('orgId')) { orgId = booking.orgId; }
		if (booking.$assignedFields.contains('listingId')) { listingId = booking.listingId; }
		if (booking.$assignedFields.contains('contactId')) { contactId = booking.contactId; }
		if (booking.$assignedFields.contains('reservationId')) { reservationId = booking.reservationId; }
		if (booking.$assignedFields.contains('status')) { status = booking.status; }
		if (booking.$assignedFields.contains('startDate')) { startDate = booking.startDate; }
		if (booking.$assignedFields.contains('endDate')) { endDate = booking.endDate; }
		if (booking.$assignedFields.contains('adults')) { adults = booking.adults; }
		if (booking.$assignedFields.contains('children')) { children = booking.children; }
		if (booking.$assignedFields.contains('priceTotal')) { priceTotal = booking.priceTotal; }
		if (booking.$assignedFields.contains('currency')) { currency = booking.currency; }
		if (booking.$assignedFields.contains('paymentStatus')) { paymentStatus = booking.paymentStatus; }
		if (booking.$assignedFields.contains('notes')) { notes = booking.notes; }
		if (booking.$assignedFields.contains('createdBy')) { createdBy = booking.createdBy; }
		if (booking.$assignedFields.contains('createdAt')) { createdAt = booking.createdAt; }
		if (booking.$assignedFields.contains('updatedAt')) { updatedAt = booking.updatedAt; }
		if (booking.$assignedFields.contains('deletedAt')) { deletedAt = booking.deletedAt; }
		if (booking.$assignedFields.contains('contact')) { contact = booking.contact; }
		if (booking.$assignedFields.contains('listing')) { listing = booking.listing; }
		if (booking.$assignedFields.contains('org')) { org = booking.org; }
		if (booking.$assignedFields.contains('reservation')) { reservation = booking.reservation; }
		if (booking.$assignedFields.contains('contracts') && booking.contracts != null) { contracts = mergeModelLists(contracts, booking.contracts); }
		if (booking.$assignedFields.contains('financialRecords') && booking.financialRecords != null) { financialRecords = mergeModelLists(financialRecords, booking.financialRecords); }
		if (booking.$assignedFields.contains('guestReviews') && booking.guestReviews != null) { guestReviews = mergeModelLists(guestReviews, booking.guestReviews); }
		if (booking.$assignedFields.contains('tasks') && booking.tasks != null) { tasks = mergeModelLists(tasks, booking.tasks); }
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
          ? {...?serializedTypes, 'Booking'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(listingId != null) 'listingId': listingId,
	if(contactId != null) 'contactId': contactId,
	if(reservationId != null) 'reservationId': reservationId,
	if(status != null) 'status': status?.toJson(),
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(adults != null) 'adults': adults,
	if(children != null) 'children': children,
	if(priceTotal != null) 'priceTotal': priceTotal,
	if(currency != null) 'currency': currency,
	if(paymentStatus != null) 'paymentStatus': paymentStatus?.toJson(),
	if(notes != null) 'notes': notes,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'reservation': reservation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(contracts != null && (!preventCircularSerialization || !serializedModels.contains('Contract'))) 'contracts': contracts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(financialRecords != null && (!preventCircularSerialization || !serializedModels.contains('FinancialRecord'))) 'financialRecords': financialRecords?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(guestReviews != null && (!preventCircularSerialization || !serializedModels.contains('GuestReview'))) 'guestReviews': guestReviews?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($contractsCount != null || $financialRecordsCount != null || $guestReviewsCount != null || $tasksCount != null) '_count': { 
		if ($contractsCount != null) 'contracts': $contractsCount, 
		if ($financialRecordsCount != null) 'financialRecords': $financialRecordsCount, 
		if ($guestReviewsCount != null) 'guestReviews': $guestReviewsCount, 
		if ($tasksCount != null) 'tasks': $tasksCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Booking &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    