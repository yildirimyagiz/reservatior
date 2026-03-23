
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'ledger_event_type.dart';
import 'organization.dart';
import 'property.dart';


class LedgerEntry implements PrismaModel<String, LedgerEntry> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? listingId;
	String? leaseId;
	String? bookingId;
	String? contractId;
	String? billId;
	String? transactionId;
	LedgerEventType? type;
	double? amount;
	String? currency;
	DateTime? occurredAt;
	String? note;
	dynamic meta;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    LedgerEntry({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.listingId,
	 this.leaseId,
	 this.bookingId,
	 this.contractId,
	 this.billId,
	 this.transactionId,
	 this.type,
	 this.amount,
	 this.currency,
	 this.occurredAt,
	 this.note,
	required this.meta,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<LedgerEntry, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"leaseId": (m) => m.leaseId,

	"bookingId": (m) => m.bookingId,

	"contractId": (m) => m.contractId,

	"billId": (m) => m.billId,

	"transactionId": (m) => m.transactionId,

	"type": (m) => m.type,

	"amount": (m) => m.amount,

	"currency": (m) => m.currency,

	"occurredAt": (m) => m.occurredAt,

	"note": (m) => m.note,

	"meta": (m) => m.meta,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(LedgerEntry) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in LedgerEntry');
    }
    return propFunction as V? Function(LedgerEntry);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory LedgerEntry.fromJson(JsonMap json) =>
      LedgerEntry(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	leaseId: json['leaseId'] as String?,
	bookingId: json['bookingId'] as String?,
	contractId: json['contractId'] as String?,
	billId: json['billId'] as String?,
	transactionId: json['transactionId'] as String?,
	type: json['type'] != null ? LedgerEventType.fromJson(json['type']) : null,
	amount: json['amount'] as double?,
	currency: json['currency'] as String?,
	occurredAt: json['occurredAt'] != null ? DateTime.parse(json['occurredAt']) : null,
	note: json['note'] as String?,
	meta: json['meta'] as dynamic,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    LedgerEntry copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<String?>? leaseId,
		Value<String?>? bookingId,
		Value<String?>? contractId,
		Value<String?>? billId,
		Value<String?>? transactionId,
		Value<LedgerEventType?>? type,
		Value<double?>? amount,
		Value<String?>? currency,
		Value<DateTime?>? occurredAt,
		Value<String?>? note,
		Value<dynamic>? meta,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return LedgerEntry(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		bookingId: bookingId != null ? bookingId.value : this.bookingId,
		contractId: contractId != null ? contractId.value : this.contractId,
		billId: billId != null ? billId.value : this.billId,
		transactionId: transactionId != null ? transactionId.value : this.transactionId,
		type: type != null ? type.value : this.type,
		amount: amount != null ? amount.value : this.amount,
		currency: currency != null ? currency.value : this.currency,
		occurredAt: occurredAt != null ? occurredAt.value : this.occurredAt,
		note: note != null ? note.value : this.note,
		meta: meta != null ? meta.value : this.meta,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    LedgerEntry copyWithInstanceValues(LedgerEntry ledgerEntry) {
        return LedgerEntry(
            id: ledgerEntry.id ?? id,
		orgId: ledgerEntry.orgId ?? orgId,
		propertyId: ledgerEntry.propertyId ?? propertyId,
		listingId: ledgerEntry.listingId ?? listingId,
		leaseId: ledgerEntry.leaseId ?? leaseId,
		bookingId: ledgerEntry.bookingId ?? bookingId,
		contractId: ledgerEntry.contractId ?? contractId,
		billId: ledgerEntry.billId ?? billId,
		transactionId: ledgerEntry.transactionId ?? transactionId,
		type: ledgerEntry.type ?? type,
		amount: ledgerEntry.amount ?? amount,
		currency: ledgerEntry.currency ?? currency,
		occurredAt: ledgerEntry.occurredAt ?? occurredAt,
		note: ledgerEntry.note ?? note,
		meta: ledgerEntry.meta ?? meta,
		createdBy: ledgerEntry.createdBy ?? createdBy,
		createdAt: ledgerEntry.createdAt ?? createdAt,
		updatedAt: ledgerEntry.updatedAt ?? updatedAt,
		deletedAt: ledgerEntry.deletedAt ?? deletedAt,
		org: ledgerEntry.org ?? org,
		property: ledgerEntry.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    LedgerEntry mergeWithInstanceValues(LedgerEntry ledgerEntry) {
        return LedgerEntry(
            id: ledgerEntry.$assignedFields.contains('id') ? ledgerEntry.id : id,
		orgId: ledgerEntry.$assignedFields.contains('orgId') ? ledgerEntry.orgId : orgId,
		propertyId: ledgerEntry.$assignedFields.contains('propertyId') ? ledgerEntry.propertyId : propertyId,
		listingId: ledgerEntry.$assignedFields.contains('listingId') ? ledgerEntry.listingId : listingId,
		leaseId: ledgerEntry.$assignedFields.contains('leaseId') ? ledgerEntry.leaseId : leaseId,
		bookingId: ledgerEntry.$assignedFields.contains('bookingId') ? ledgerEntry.bookingId : bookingId,
		contractId: ledgerEntry.$assignedFields.contains('contractId') ? ledgerEntry.contractId : contractId,
		billId: ledgerEntry.$assignedFields.contains('billId') ? ledgerEntry.billId : billId,
		transactionId: ledgerEntry.$assignedFields.contains('transactionId') ? ledgerEntry.transactionId : transactionId,
		type: ledgerEntry.$assignedFields.contains('type') ? ledgerEntry.type : type,
		amount: ledgerEntry.$assignedFields.contains('amount') ? ledgerEntry.amount : amount,
		currency: ledgerEntry.$assignedFields.contains('currency') ? ledgerEntry.currency : currency,
		occurredAt: ledgerEntry.$assignedFields.contains('occurredAt') ? ledgerEntry.occurredAt : occurredAt,
		note: ledgerEntry.$assignedFields.contains('note') ? ledgerEntry.note : note,
		meta: ledgerEntry.$assignedFields.contains('meta') ? ledgerEntry.meta : meta,
		createdBy: ledgerEntry.$assignedFields.contains('createdBy') ? ledgerEntry.createdBy : createdBy,
		createdAt: ledgerEntry.$assignedFields.contains('createdAt') ? ledgerEntry.createdAt : createdAt,
		updatedAt: ledgerEntry.$assignedFields.contains('updatedAt') ? ledgerEntry.updatedAt : updatedAt,
		deletedAt: ledgerEntry.$assignedFields.contains('deletedAt') ? ledgerEntry.deletedAt : deletedAt,
		org: ledgerEntry.$assignedFields.contains('org') ? ledgerEntry.org : org,
		property: ledgerEntry.$assignedFields.contains('property') ? ledgerEntry.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    LedgerEntry updateWithInstanceValues(LedgerEntry ledgerEntry) {
        if (ledgerEntry.$assignedFields.contains('id')) { id = ledgerEntry.id; }
		if (ledgerEntry.$assignedFields.contains('orgId')) { orgId = ledgerEntry.orgId; }
		if (ledgerEntry.$assignedFields.contains('propertyId')) { propertyId = ledgerEntry.propertyId; }
		if (ledgerEntry.$assignedFields.contains('listingId')) { listingId = ledgerEntry.listingId; }
		if (ledgerEntry.$assignedFields.contains('leaseId')) { leaseId = ledgerEntry.leaseId; }
		if (ledgerEntry.$assignedFields.contains('bookingId')) { bookingId = ledgerEntry.bookingId; }
		if (ledgerEntry.$assignedFields.contains('contractId')) { contractId = ledgerEntry.contractId; }
		if (ledgerEntry.$assignedFields.contains('billId')) { billId = ledgerEntry.billId; }
		if (ledgerEntry.$assignedFields.contains('transactionId')) { transactionId = ledgerEntry.transactionId; }
		if (ledgerEntry.$assignedFields.contains('type')) { type = ledgerEntry.type; }
		if (ledgerEntry.$assignedFields.contains('amount')) { amount = ledgerEntry.amount; }
		if (ledgerEntry.$assignedFields.contains('currency')) { currency = ledgerEntry.currency; }
		if (ledgerEntry.$assignedFields.contains('occurredAt')) { occurredAt = ledgerEntry.occurredAt; }
		if (ledgerEntry.$assignedFields.contains('note')) { note = ledgerEntry.note; }
		if (ledgerEntry.$assignedFields.contains('meta')) { meta = ledgerEntry.meta; }
		if (ledgerEntry.$assignedFields.contains('createdBy')) { createdBy = ledgerEntry.createdBy; }
		if (ledgerEntry.$assignedFields.contains('createdAt')) { createdAt = ledgerEntry.createdAt; }
		if (ledgerEntry.$assignedFields.contains('updatedAt')) { updatedAt = ledgerEntry.updatedAt; }
		if (ledgerEntry.$assignedFields.contains('deletedAt')) { deletedAt = ledgerEntry.deletedAt; }
		if (ledgerEntry.$assignedFields.contains('org')) { org = ledgerEntry.org; }
		if (ledgerEntry.$assignedFields.contains('property')) { property = ledgerEntry.property; }
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
          ? {...?serializedTypes, 'LedgerEntry'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(leaseId != null) 'leaseId': leaseId,
	if(bookingId != null) 'bookingId': bookingId,
	if(contractId != null) 'contractId': contractId,
	if(billId != null) 'billId': billId,
	if(transactionId != null) 'transactionId': transactionId,
	if(type != null) 'type': type?.toJson(),
	if(amount != null) 'amount': amount,
	if(currency != null) 'currency': currency,
	if(occurredAt != null) 'occurredAt': occurredAt?.toIso8601String(),
	if(note != null) 'note': note,
	if(meta != null) 'meta': meta,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is LedgerEntry &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    