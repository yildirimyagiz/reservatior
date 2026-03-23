
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'transaction_type.dart';
import 'payment_status.dart';
import 'attachment.dart';
import 'booking.dart';
import 'lease.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'reservation.dart';
import 'contact.dart';


class FinancialRecord implements PrismaModel<String, FinancialRecord> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? listingId;
	String? leaseId;
	String? bookingId;
	String? reservationId;
	String? vendorContactId;
	String? type;
	TransactionType? recordType;
	double? amount;
	String? currency;
	DateTime? occurredAt;
	DateTime? dueDate;
	dynamic billData;
	String? category;
	String? description;
	String? notes;
	PaymentStatus? paymentStatus;
	DateTime? paidAt;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Attachment>? attachments;
	Booking? booking;
	Lease? lease;
	Listing? listing;
	Organization? org;
	Property? property;
	Reservation? reservation;
	Contact? vendor;
	int? $attachmentsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    FinancialRecord({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.listingId,
	 this.leaseId,
	 this.bookingId,
	 this.reservationId,
	 this.vendorContactId,
	 this.type,
	 this.recordType,
	 this.amount,
	 this.currency,
	 this.occurredAt,
	 this.dueDate,
	required this.billData,
	 this.category,
	 this.description,
	 this.notes,
	 this.paymentStatus = PaymentStatus.UNPAID,
	 this.paidAt,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.attachments,
	 this.booking,
	 this.lease,
	 this.listing,
	 this.org,
	 this.property,
	 this.reservation,
	 this.vendor,
	this.$attachmentsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<FinancialRecord, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"leaseId": (m) => m.leaseId,

	"bookingId": (m) => m.bookingId,

	"reservationId": (m) => m.reservationId,

	"vendorContactId": (m) => m.vendorContactId,

	"type": (m) => m.type,

	"recordType": (m) => m.recordType,

	"amount": (m) => m.amount,

	"currency": (m) => m.currency,

	"occurredAt": (m) => m.occurredAt,

	"dueDate": (m) => m.dueDate,

	"billData": (m) => m.billData,

	"category": (m) => m.category,

	"description": (m) => m.description,

	"notes": (m) => m.notes,

	"paymentStatus": (m) => m.paymentStatus,

	"paidAt": (m) => m.paidAt,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"attachments": (m) => m.attachments,

	"booking": (m) => m.booking,

	"lease": (m) => m.lease,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"property": (m) => m.property,

	"reservation": (m) => m.reservation,

	"vendor": (m) => m.vendor,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(FinancialRecord) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in FinancialRecord');
    }
    return propFunction as V? Function(FinancialRecord);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory FinancialRecord.fromJson(JsonMap json) =>
      FinancialRecord(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	leaseId: json['leaseId'] as String?,
	bookingId: json['bookingId'] as String?,
	reservationId: json['reservationId'] as String?,
	vendorContactId: json['vendorContactId'] as String?,
	type: json['type'] as String?,
	recordType: json['recordType'] != null ? TransactionType.fromJson(json['recordType']) : null,
	amount: json['amount'] as double?,
	currency: json['currency'] as String?,
	occurredAt: json['occurredAt'] != null ? DateTime.parse(json['occurredAt']) : null,
	dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
	billData: json['billData'] as dynamic,
	category: json['category'] as String?,
	description: json['description'] as String?,
	notes: json['notes'] as String?,
	paymentStatus: json['paymentStatus'] != null ? PaymentStatus.fromJson(json['paymentStatus']) : null,
	paidAt: json['paidAt'] != null ? DateTime.parse(json['paidAt']) : null,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	attachments: json['attachments'] != null ? createModels<Attachment>((json['attachments'] as List).cast<JsonMap>(), Attachment.fromJson) : null,
	booking: json['booking'] != null ? Booking.fromJson(json['booking'] as JsonMap) : null,
	lease: json['lease'] != null ? Lease.fromJson(json['lease'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	reservation: json['reservation'] != null ? Reservation.fromJson(json['reservation'] as JsonMap) : null,
	vendor: json['vendor'] != null ? Contact.fromJson(json['vendor'] as JsonMap) : null,
	$attachmentsCount: json['_count']?['attachments'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    FinancialRecord copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<String?>? leaseId,
		Value<String?>? bookingId,
		Value<String?>? reservationId,
		Value<String?>? vendorContactId,
		Value<String?>? type,
		Value<TransactionType?>? recordType,
		Value<double?>? amount,
		Value<String?>? currency,
		Value<DateTime?>? occurredAt,
		Value<DateTime?>? dueDate,
		Value<dynamic>? billData,
		Value<String?>? category,
		Value<String?>? description,
		Value<String?>? notes,
		Value<PaymentStatus?>? paymentStatus,
		Value<DateTime?>? paidAt,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Attachment>?>? attachments,
		Value<Booking?>? booking,
		Value<Lease?>? lease,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Property?>? property,
		Value<Reservation?>? reservation,
		Value<Contact?>? vendor,
		int? $attachmentsCount,
        }) {
        return FinancialRecord(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		bookingId: bookingId != null ? bookingId.value : this.bookingId,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		vendorContactId: vendorContactId != null ? vendorContactId.value : this.vendorContactId,
		type: type != null ? type.value : this.type,
		recordType: recordType != null ? recordType.value : this.recordType,
		amount: amount != null ? amount.value : this.amount,
		currency: currency != null ? currency.value : this.currency,
		occurredAt: occurredAt != null ? occurredAt.value : this.occurredAt,
		dueDate: dueDate != null ? dueDate.value : this.dueDate,
		billData: billData != null ? billData.value : this.billData,
		category: category != null ? category.value : this.category,
		description: description != null ? description.value : this.description,
		notes: notes != null ? notes.value : this.notes,
		paymentStatus: paymentStatus != null ? paymentStatus.value : this.paymentStatus,
		paidAt: paidAt != null ? paidAt.value : this.paidAt,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		attachments: attachments != null ? attachments.value : this.attachments,
		booking: booking != null ? booking.value : this.booking,
		lease: lease != null ? lease.value : this.lease,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		reservation: reservation != null ? reservation.value : this.reservation,
		vendor: vendor != null ? vendor.value : this.vendor,
		$attachmentsCount: $attachmentsCount ?? this.$attachmentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    FinancialRecord copyWithInstanceValues(FinancialRecord financialRecord) {
        return FinancialRecord(
            id: financialRecord.id ?? id,
		orgId: financialRecord.orgId ?? orgId,
		propertyId: financialRecord.propertyId ?? propertyId,
		listingId: financialRecord.listingId ?? listingId,
		leaseId: financialRecord.leaseId ?? leaseId,
		bookingId: financialRecord.bookingId ?? bookingId,
		reservationId: financialRecord.reservationId ?? reservationId,
		vendorContactId: financialRecord.vendorContactId ?? vendorContactId,
		type: financialRecord.type ?? type,
		recordType: financialRecord.recordType ?? recordType,
		amount: financialRecord.amount ?? amount,
		currency: financialRecord.currency ?? currency,
		occurredAt: financialRecord.occurredAt ?? occurredAt,
		dueDate: financialRecord.dueDate ?? dueDate,
		billData: financialRecord.billData ?? billData,
		category: financialRecord.category ?? category,
		description: financialRecord.description ?? description,
		notes: financialRecord.notes ?? notes,
		paymentStatus: financialRecord.paymentStatus ?? paymentStatus,
		paidAt: financialRecord.paidAt ?? paidAt,
		createdBy: financialRecord.createdBy ?? createdBy,
		createdAt: financialRecord.createdAt ?? createdAt,
		updatedAt: financialRecord.updatedAt ?? updatedAt,
		deletedAt: financialRecord.deletedAt ?? deletedAt,
		attachments: financialRecord.attachments ?? attachments,
		booking: financialRecord.booking ?? booking,
		lease: financialRecord.lease ?? lease,
		listing: financialRecord.listing ?? listing,
		org: financialRecord.org ?? org,
		property: financialRecord.property ?? property,
		reservation: financialRecord.reservation ?? reservation,
		vendor: financialRecord.vendor ?? vendor,
		$attachmentsCount: financialRecord.$attachmentsCount ?? $attachmentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    FinancialRecord mergeWithInstanceValues(FinancialRecord financialRecord) {
        return FinancialRecord(
            id: financialRecord.$assignedFields.contains('id') ? financialRecord.id : id,
		orgId: financialRecord.$assignedFields.contains('orgId') ? financialRecord.orgId : orgId,
		propertyId: financialRecord.$assignedFields.contains('propertyId') ? financialRecord.propertyId : propertyId,
		listingId: financialRecord.$assignedFields.contains('listingId') ? financialRecord.listingId : listingId,
		leaseId: financialRecord.$assignedFields.contains('leaseId') ? financialRecord.leaseId : leaseId,
		bookingId: financialRecord.$assignedFields.contains('bookingId') ? financialRecord.bookingId : bookingId,
		reservationId: financialRecord.$assignedFields.contains('reservationId') ? financialRecord.reservationId : reservationId,
		vendorContactId: financialRecord.$assignedFields.contains('vendorContactId') ? financialRecord.vendorContactId : vendorContactId,
		type: financialRecord.$assignedFields.contains('type') ? financialRecord.type : type,
		recordType: financialRecord.$assignedFields.contains('recordType') ? financialRecord.recordType : recordType,
		amount: financialRecord.$assignedFields.contains('amount') ? financialRecord.amount : amount,
		currency: financialRecord.$assignedFields.contains('currency') ? financialRecord.currency : currency,
		occurredAt: financialRecord.$assignedFields.contains('occurredAt') ? financialRecord.occurredAt : occurredAt,
		dueDate: financialRecord.$assignedFields.contains('dueDate') ? financialRecord.dueDate : dueDate,
		billData: financialRecord.$assignedFields.contains('billData') ? financialRecord.billData : billData,
		category: financialRecord.$assignedFields.contains('category') ? financialRecord.category : category,
		description: financialRecord.$assignedFields.contains('description') ? financialRecord.description : description,
		notes: financialRecord.$assignedFields.contains('notes') ? financialRecord.notes : notes,
		paymentStatus: financialRecord.$assignedFields.contains('paymentStatus') ? financialRecord.paymentStatus : paymentStatus,
		paidAt: financialRecord.$assignedFields.contains('paidAt') ? financialRecord.paidAt : paidAt,
		createdBy: financialRecord.$assignedFields.contains('createdBy') ? financialRecord.createdBy : createdBy,
		createdAt: financialRecord.$assignedFields.contains('createdAt') ? financialRecord.createdAt : createdAt,
		updatedAt: financialRecord.$assignedFields.contains('updatedAt') ? financialRecord.updatedAt : updatedAt,
		deletedAt: financialRecord.$assignedFields.contains('deletedAt') ? financialRecord.deletedAt : deletedAt,
		attachments: (financialRecord.$assignedFields.contains('attachments') && financialRecord.attachments != null) ? mergeModelLists(attachments, financialRecord.attachments) : attachments,
		booking: financialRecord.$assignedFields.contains('booking') ? financialRecord.booking : booking,
		lease: financialRecord.$assignedFields.contains('lease') ? financialRecord.lease : lease,
		listing: financialRecord.$assignedFields.contains('listing') ? financialRecord.listing : listing,
		org: financialRecord.$assignedFields.contains('org') ? financialRecord.org : org,
		property: financialRecord.$assignedFields.contains('property') ? financialRecord.property : property,
		reservation: financialRecord.$assignedFields.contains('reservation') ? financialRecord.reservation : reservation,
		vendor: financialRecord.$assignedFields.contains('vendor') ? financialRecord.vendor : vendor,
		$attachmentsCount: financialRecord.$attachmentsCount ?? $attachmentsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    FinancialRecord updateWithInstanceValues(FinancialRecord financialRecord) {
        if (financialRecord.$assignedFields.contains('id')) { id = financialRecord.id; }
		if (financialRecord.$assignedFields.contains('orgId')) { orgId = financialRecord.orgId; }
		if (financialRecord.$assignedFields.contains('propertyId')) { propertyId = financialRecord.propertyId; }
		if (financialRecord.$assignedFields.contains('listingId')) { listingId = financialRecord.listingId; }
		if (financialRecord.$assignedFields.contains('leaseId')) { leaseId = financialRecord.leaseId; }
		if (financialRecord.$assignedFields.contains('bookingId')) { bookingId = financialRecord.bookingId; }
		if (financialRecord.$assignedFields.contains('reservationId')) { reservationId = financialRecord.reservationId; }
		if (financialRecord.$assignedFields.contains('vendorContactId')) { vendorContactId = financialRecord.vendorContactId; }
		if (financialRecord.$assignedFields.contains('type')) { type = financialRecord.type; }
		if (financialRecord.$assignedFields.contains('recordType')) { recordType = financialRecord.recordType; }
		if (financialRecord.$assignedFields.contains('amount')) { amount = financialRecord.amount; }
		if (financialRecord.$assignedFields.contains('currency')) { currency = financialRecord.currency; }
		if (financialRecord.$assignedFields.contains('occurredAt')) { occurredAt = financialRecord.occurredAt; }
		if (financialRecord.$assignedFields.contains('dueDate')) { dueDate = financialRecord.dueDate; }
		if (financialRecord.$assignedFields.contains('billData')) { billData = financialRecord.billData; }
		if (financialRecord.$assignedFields.contains('category')) { category = financialRecord.category; }
		if (financialRecord.$assignedFields.contains('description')) { description = financialRecord.description; }
		if (financialRecord.$assignedFields.contains('notes')) { notes = financialRecord.notes; }
		if (financialRecord.$assignedFields.contains('paymentStatus')) { paymentStatus = financialRecord.paymentStatus; }
		if (financialRecord.$assignedFields.contains('paidAt')) { paidAt = financialRecord.paidAt; }
		if (financialRecord.$assignedFields.contains('createdBy')) { createdBy = financialRecord.createdBy; }
		if (financialRecord.$assignedFields.contains('createdAt')) { createdAt = financialRecord.createdAt; }
		if (financialRecord.$assignedFields.contains('updatedAt')) { updatedAt = financialRecord.updatedAt; }
		if (financialRecord.$assignedFields.contains('deletedAt')) { deletedAt = financialRecord.deletedAt; }
		if (financialRecord.$assignedFields.contains('attachments') && financialRecord.attachments != null) { attachments = mergeModelLists(attachments, financialRecord.attachments); }
		if (financialRecord.$assignedFields.contains('booking')) { booking = financialRecord.booking; }
		if (financialRecord.$assignedFields.contains('lease')) { lease = financialRecord.lease; }
		if (financialRecord.$assignedFields.contains('listing')) { listing = financialRecord.listing; }
		if (financialRecord.$assignedFields.contains('org')) { org = financialRecord.org; }
		if (financialRecord.$assignedFields.contains('property')) { property = financialRecord.property; }
		if (financialRecord.$assignedFields.contains('reservation')) { reservation = financialRecord.reservation; }
		if (financialRecord.$assignedFields.contains('vendor')) { vendor = financialRecord.vendor; }
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
          ? {...?serializedTypes, 'FinancialRecord'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(leaseId != null) 'leaseId': leaseId,
	if(bookingId != null) 'bookingId': bookingId,
	if(reservationId != null) 'reservationId': reservationId,
	if(vendorContactId != null) 'vendorContactId': vendorContactId,
	if(type != null) 'type': type,
	if(recordType != null) 'recordType': recordType?.toJson(),
	if(amount != null) 'amount': amount,
	if(currency != null) 'currency': currency,
	if(occurredAt != null) 'occurredAt': occurredAt?.toIso8601String(),
	if(dueDate != null) 'dueDate': dueDate?.toIso8601String(),
	if(billData != null) 'billData': billData,
	if(category != null) 'category': category,
	if(description != null) 'description': description,
	if(notes != null) 'notes': notes,
	if(paymentStatus != null) 'paymentStatus': paymentStatus?.toJson(),
	if(paidAt != null) 'paidAt': paidAt?.toIso8601String(),
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(attachments != null && (!preventCircularSerialization || !serializedModels.contains('Attachment'))) 'attachments': attachments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(booking != null && (!preventCircularSerialization || !serializedModels.contains('Booking'))) 'booking': booking?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'lease': lease?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'reservation': reservation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(vendor != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'vendor': vendor?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($attachmentsCount != null) '_count': { 
		if ($attachmentsCount != null) 'attachments': $attachmentsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is FinancialRecord &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    