
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'payout.dart';


class Commission implements PrismaModel<String, Commission> , Id<String> {
    @override
String? id;
	String? orgId;
	String? listingId;
	String? leaseId;
	String? bookingId;
	String? transactionId;
	String? beneficiaryUserId;
	String? beneficiaryOrgId;
	dynamic ruleData;
	double? amountBase;
	double? commissionAmount;
	String? currency;
	dynamic records;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	List<Payout>? payouts;
	int? $payoutsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Commission({ this.id,
	 this.orgId,
	 this.listingId,
	 this.leaseId,
	 this.bookingId,
	 this.transactionId,
	 this.beneficiaryUserId,
	 this.beneficiaryOrgId,
	required this.ruleData,
	 this.amountBase,
	 this.commissionAmount,
	 this.currency,
	required this.records,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.payouts,
	this.$payoutsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Commission, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"listingId": (m) => m.listingId,

	"leaseId": (m) => m.leaseId,

	"bookingId": (m) => m.bookingId,

	"transactionId": (m) => m.transactionId,

	"beneficiaryUserId": (m) => m.beneficiaryUserId,

	"beneficiaryOrgId": (m) => m.beneficiaryOrgId,

	"ruleData": (m) => m.ruleData,

	"amountBase": (m) => m.amountBase,

	"commissionAmount": (m) => m.commissionAmount,

	"currency": (m) => m.currency,

	"records": (m) => m.records,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"payouts": (m) => m.payouts,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Commission) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Commission');
    }
    return propFunction as V? Function(Commission);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Commission.fromJson(JsonMap json) =>
      Commission(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	listingId: json['listingId'] as String?,
	leaseId: json['leaseId'] as String?,
	bookingId: json['bookingId'] as String?,
	transactionId: json['transactionId'] as String?,
	beneficiaryUserId: json['beneficiaryUserId'] as String?,
	beneficiaryOrgId: json['beneficiaryOrgId'] as String?,
	ruleData: json['ruleData'] as dynamic,
	amountBase: json['amountBase'] as double?,
	commissionAmount: json['commissionAmount'] as double?,
	currency: json['currency'] as String?,
	records: json['records'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	payouts: json['payouts'] != null ? createModels<Payout>((json['payouts'] as List).cast<JsonMap>(), Payout.fromJson) : null,
	$payoutsCount: json['_count']?['payouts'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Commission copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? listingId,
		Value<String?>? leaseId,
		Value<String?>? bookingId,
		Value<String?>? transactionId,
		Value<String?>? beneficiaryUserId,
		Value<String?>? beneficiaryOrgId,
		Value<dynamic>? ruleData,
		Value<double?>? amountBase,
		Value<double?>? commissionAmount,
		Value<String?>? currency,
		Value<dynamic>? records,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<List<Payout>?>? payouts,
		int? $payoutsCount,
        }) {
        return Commission(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		listingId: listingId != null ? listingId.value : this.listingId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		bookingId: bookingId != null ? bookingId.value : this.bookingId,
		transactionId: transactionId != null ? transactionId.value : this.transactionId,
		beneficiaryUserId: beneficiaryUserId != null ? beneficiaryUserId.value : this.beneficiaryUserId,
		beneficiaryOrgId: beneficiaryOrgId != null ? beneficiaryOrgId.value : this.beneficiaryOrgId,
		ruleData: ruleData != null ? ruleData.value : this.ruleData,
		amountBase: amountBase != null ? amountBase.value : this.amountBase,
		commissionAmount: commissionAmount != null ? commissionAmount.value : this.commissionAmount,
		currency: currency != null ? currency.value : this.currency,
		records: records != null ? records.value : this.records,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		payouts: payouts != null ? payouts.value : this.payouts,
		$payoutsCount: $payoutsCount ?? this.$payoutsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Commission copyWithInstanceValues(Commission commission) {
        return Commission(
            id: commission.id ?? id,
		orgId: commission.orgId ?? orgId,
		listingId: commission.listingId ?? listingId,
		leaseId: commission.leaseId ?? leaseId,
		bookingId: commission.bookingId ?? bookingId,
		transactionId: commission.transactionId ?? transactionId,
		beneficiaryUserId: commission.beneficiaryUserId ?? beneficiaryUserId,
		beneficiaryOrgId: commission.beneficiaryOrgId ?? beneficiaryOrgId,
		ruleData: commission.ruleData ?? ruleData,
		amountBase: commission.amountBase ?? amountBase,
		commissionAmount: commission.commissionAmount ?? commissionAmount,
		currency: commission.currency ?? currency,
		records: commission.records ?? records,
		createdAt: commission.createdAt ?? createdAt,
		updatedAt: commission.updatedAt ?? updatedAt,
		deletedAt: commission.deletedAt ?? deletedAt,
		org: commission.org ?? org,
		payouts: commission.payouts ?? payouts,
		$payoutsCount: commission.$payoutsCount ?? $payoutsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Commission mergeWithInstanceValues(Commission commission) {
        return Commission(
            id: commission.$assignedFields.contains('id') ? commission.id : id,
		orgId: commission.$assignedFields.contains('orgId') ? commission.orgId : orgId,
		listingId: commission.$assignedFields.contains('listingId') ? commission.listingId : listingId,
		leaseId: commission.$assignedFields.contains('leaseId') ? commission.leaseId : leaseId,
		bookingId: commission.$assignedFields.contains('bookingId') ? commission.bookingId : bookingId,
		transactionId: commission.$assignedFields.contains('transactionId') ? commission.transactionId : transactionId,
		beneficiaryUserId: commission.$assignedFields.contains('beneficiaryUserId') ? commission.beneficiaryUserId : beneficiaryUserId,
		beneficiaryOrgId: commission.$assignedFields.contains('beneficiaryOrgId') ? commission.beneficiaryOrgId : beneficiaryOrgId,
		ruleData: commission.$assignedFields.contains('ruleData') ? commission.ruleData : ruleData,
		amountBase: commission.$assignedFields.contains('amountBase') ? commission.amountBase : amountBase,
		commissionAmount: commission.$assignedFields.contains('commissionAmount') ? commission.commissionAmount : commissionAmount,
		currency: commission.$assignedFields.contains('currency') ? commission.currency : currency,
		records: commission.$assignedFields.contains('records') ? commission.records : records,
		createdAt: commission.$assignedFields.contains('createdAt') ? commission.createdAt : createdAt,
		updatedAt: commission.$assignedFields.contains('updatedAt') ? commission.updatedAt : updatedAt,
		deletedAt: commission.$assignedFields.contains('deletedAt') ? commission.deletedAt : deletedAt,
		org: commission.$assignedFields.contains('org') ? commission.org : org,
		payouts: (commission.$assignedFields.contains('payouts') && commission.payouts != null) ? mergeModelLists(payouts, commission.payouts) : payouts,
		$payoutsCount: commission.$payoutsCount ?? $payoutsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Commission updateWithInstanceValues(Commission commission) {
        if (commission.$assignedFields.contains('id')) { id = commission.id; }
		if (commission.$assignedFields.contains('orgId')) { orgId = commission.orgId; }
		if (commission.$assignedFields.contains('listingId')) { listingId = commission.listingId; }
		if (commission.$assignedFields.contains('leaseId')) { leaseId = commission.leaseId; }
		if (commission.$assignedFields.contains('bookingId')) { bookingId = commission.bookingId; }
		if (commission.$assignedFields.contains('transactionId')) { transactionId = commission.transactionId; }
		if (commission.$assignedFields.contains('beneficiaryUserId')) { beneficiaryUserId = commission.beneficiaryUserId; }
		if (commission.$assignedFields.contains('beneficiaryOrgId')) { beneficiaryOrgId = commission.beneficiaryOrgId; }
		if (commission.$assignedFields.contains('ruleData')) { ruleData = commission.ruleData; }
		if (commission.$assignedFields.contains('amountBase')) { amountBase = commission.amountBase; }
		if (commission.$assignedFields.contains('commissionAmount')) { commissionAmount = commission.commissionAmount; }
		if (commission.$assignedFields.contains('currency')) { currency = commission.currency; }
		if (commission.$assignedFields.contains('records')) { records = commission.records; }
		if (commission.$assignedFields.contains('createdAt')) { createdAt = commission.createdAt; }
		if (commission.$assignedFields.contains('updatedAt')) { updatedAt = commission.updatedAt; }
		if (commission.$assignedFields.contains('deletedAt')) { deletedAt = commission.deletedAt; }
		if (commission.$assignedFields.contains('org')) { org = commission.org; }
		if (commission.$assignedFields.contains('payouts') && commission.payouts != null) { payouts = mergeModelLists(payouts, commission.payouts); }
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
          ? {...?serializedTypes, 'Commission'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(listingId != null) 'listingId': listingId,
	if(leaseId != null) 'leaseId': leaseId,
	if(bookingId != null) 'bookingId': bookingId,
	if(transactionId != null) 'transactionId': transactionId,
	if(beneficiaryUserId != null) 'beneficiaryUserId': beneficiaryUserId,
	if(beneficiaryOrgId != null) 'beneficiaryOrgId': beneficiaryOrgId,
	if(ruleData != null) 'ruleData': ruleData,
	if(amountBase != null) 'amountBase': amountBase,
	if(commissionAmount != null) 'commissionAmount': commissionAmount,
	if(currency != null) 'currency': currency,
	if(records != null) 'records': records,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(payouts != null && (!preventCircularSerialization || !serializedModels.contains('Payout'))) 'payouts': payouts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($payoutsCount != null) '_count': { 
		if ($payoutsCount != null) 'payouts': $payoutsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Commission &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    