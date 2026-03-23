
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'lease.dart';
import 'organization.dart';


class DepositProtection implements PrismaModel<String, DepositProtection> , Id<String> {
    @override
String? id;
	String? orgId;
	String? leaseId;
	String? provider;
	String? scheme;
	String? reference;
	double? amount;
	String? currency;
	String? status;
	DateTime? protectedAt;
	DateTime? claimedAt;
	DateTime? returnedAt;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Lease? lease;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    DepositProtection({ this.id,
	 this.orgId,
	 this.leaseId,
	 this.provider,
	 this.scheme,
	 this.reference,
	 this.amount,
	 this.currency,
	 this.status = "pending",
	 this.protectedAt,
	 this.claimedAt,
	 this.returnedAt,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.lease,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<DepositProtection, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"leaseId": (m) => m.leaseId,

	"provider": (m) => m.provider,

	"scheme": (m) => m.scheme,

	"reference": (m) => m.reference,

	"amount": (m) => m.amount,

	"currency": (m) => m.currency,

	"status": (m) => m.status,

	"protectedAt": (m) => m.protectedAt,

	"claimedAt": (m) => m.claimedAt,

	"returnedAt": (m) => m.returnedAt,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"lease": (m) => m.lease,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(DepositProtection) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in DepositProtection');
    }
    return propFunction as V? Function(DepositProtection);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory DepositProtection.fromJson(JsonMap json) =>
      DepositProtection(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	leaseId: json['leaseId'] as String?,
	provider: json['provider'] as String?,
	scheme: json['scheme'] as String?,
	reference: json['reference'] as String?,
	amount: json['amount'] as double?,
	currency: json['currency'] as String?,
	status: json['status'] as String?,
	protectedAt: json['protectedAt'] != null ? DateTime.parse(json['protectedAt']) : null,
	claimedAt: json['claimedAt'] != null ? DateTime.parse(json['claimedAt']) : null,
	returnedAt: json['returnedAt'] != null ? DateTime.parse(json['returnedAt']) : null,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	lease: json['lease'] != null ? Lease.fromJson(json['lease'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    DepositProtection copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? leaseId,
		Value<String?>? provider,
		Value<String?>? scheme,
		Value<String?>? reference,
		Value<double?>? amount,
		Value<String?>? currency,
		Value<String?>? status,
		Value<DateTime?>? protectedAt,
		Value<DateTime?>? claimedAt,
		Value<DateTime?>? returnedAt,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Lease?>? lease,
		Value<Organization?>? org,
        }) {
        return DepositProtection(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		provider: provider != null ? provider.value : this.provider,
		scheme: scheme != null ? scheme.value : this.scheme,
		reference: reference != null ? reference.value : this.reference,
		amount: amount != null ? amount.value : this.amount,
		currency: currency != null ? currency.value : this.currency,
		status: status != null ? status.value : this.status,
		protectedAt: protectedAt != null ? protectedAt.value : this.protectedAt,
		claimedAt: claimedAt != null ? claimedAt.value : this.claimedAt,
		returnedAt: returnedAt != null ? returnedAt.value : this.returnedAt,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		lease: lease != null ? lease.value : this.lease,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    DepositProtection copyWithInstanceValues(DepositProtection depositProtection) {
        return DepositProtection(
            id: depositProtection.id ?? id,
		orgId: depositProtection.orgId ?? orgId,
		leaseId: depositProtection.leaseId ?? leaseId,
		provider: depositProtection.provider ?? provider,
		scheme: depositProtection.scheme ?? scheme,
		reference: depositProtection.reference ?? reference,
		amount: depositProtection.amount ?? amount,
		currency: depositProtection.currency ?? currency,
		status: depositProtection.status ?? status,
		protectedAt: depositProtection.protectedAt ?? protectedAt,
		claimedAt: depositProtection.claimedAt ?? claimedAt,
		returnedAt: depositProtection.returnedAt ?? returnedAt,
		createdBy: depositProtection.createdBy ?? createdBy,
		createdAt: depositProtection.createdAt ?? createdAt,
		updatedAt: depositProtection.updatedAt ?? updatedAt,
		deletedAt: depositProtection.deletedAt ?? deletedAt,
		lease: depositProtection.lease ?? lease,
		org: depositProtection.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    DepositProtection mergeWithInstanceValues(DepositProtection depositProtection) {
        return DepositProtection(
            id: depositProtection.$assignedFields.contains('id') ? depositProtection.id : id,
		orgId: depositProtection.$assignedFields.contains('orgId') ? depositProtection.orgId : orgId,
		leaseId: depositProtection.$assignedFields.contains('leaseId') ? depositProtection.leaseId : leaseId,
		provider: depositProtection.$assignedFields.contains('provider') ? depositProtection.provider : provider,
		scheme: depositProtection.$assignedFields.contains('scheme') ? depositProtection.scheme : scheme,
		reference: depositProtection.$assignedFields.contains('reference') ? depositProtection.reference : reference,
		amount: depositProtection.$assignedFields.contains('amount') ? depositProtection.amount : amount,
		currency: depositProtection.$assignedFields.contains('currency') ? depositProtection.currency : currency,
		status: depositProtection.$assignedFields.contains('status') ? depositProtection.status : status,
		protectedAt: depositProtection.$assignedFields.contains('protectedAt') ? depositProtection.protectedAt : protectedAt,
		claimedAt: depositProtection.$assignedFields.contains('claimedAt') ? depositProtection.claimedAt : claimedAt,
		returnedAt: depositProtection.$assignedFields.contains('returnedAt') ? depositProtection.returnedAt : returnedAt,
		createdBy: depositProtection.$assignedFields.contains('createdBy') ? depositProtection.createdBy : createdBy,
		createdAt: depositProtection.$assignedFields.contains('createdAt') ? depositProtection.createdAt : createdAt,
		updatedAt: depositProtection.$assignedFields.contains('updatedAt') ? depositProtection.updatedAt : updatedAt,
		deletedAt: depositProtection.$assignedFields.contains('deletedAt') ? depositProtection.deletedAt : deletedAt,
		lease: depositProtection.$assignedFields.contains('lease') ? depositProtection.lease : lease,
		org: depositProtection.$assignedFields.contains('org') ? depositProtection.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    DepositProtection updateWithInstanceValues(DepositProtection depositProtection) {
        if (depositProtection.$assignedFields.contains('id')) { id = depositProtection.id; }
		if (depositProtection.$assignedFields.contains('orgId')) { orgId = depositProtection.orgId; }
		if (depositProtection.$assignedFields.contains('leaseId')) { leaseId = depositProtection.leaseId; }
		if (depositProtection.$assignedFields.contains('provider')) { provider = depositProtection.provider; }
		if (depositProtection.$assignedFields.contains('scheme')) { scheme = depositProtection.scheme; }
		if (depositProtection.$assignedFields.contains('reference')) { reference = depositProtection.reference; }
		if (depositProtection.$assignedFields.contains('amount')) { amount = depositProtection.amount; }
		if (depositProtection.$assignedFields.contains('currency')) { currency = depositProtection.currency; }
		if (depositProtection.$assignedFields.contains('status')) { status = depositProtection.status; }
		if (depositProtection.$assignedFields.contains('protectedAt')) { protectedAt = depositProtection.protectedAt; }
		if (depositProtection.$assignedFields.contains('claimedAt')) { claimedAt = depositProtection.claimedAt; }
		if (depositProtection.$assignedFields.contains('returnedAt')) { returnedAt = depositProtection.returnedAt; }
		if (depositProtection.$assignedFields.contains('createdBy')) { createdBy = depositProtection.createdBy; }
		if (depositProtection.$assignedFields.contains('createdAt')) { createdAt = depositProtection.createdAt; }
		if (depositProtection.$assignedFields.contains('updatedAt')) { updatedAt = depositProtection.updatedAt; }
		if (depositProtection.$assignedFields.contains('deletedAt')) { deletedAt = depositProtection.deletedAt; }
		if (depositProtection.$assignedFields.contains('lease')) { lease = depositProtection.lease; }
		if (depositProtection.$assignedFields.contains('org')) { org = depositProtection.org; }
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
          ? {...?serializedTypes, 'DepositProtection'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(leaseId != null) 'leaseId': leaseId,
	if(provider != null) 'provider': provider,
	if(scheme != null) 'scheme': scheme,
	if(reference != null) 'reference': reference,
	if(amount != null) 'amount': amount,
	if(currency != null) 'currency': currency,
	if(status != null) 'status': status,
	if(protectedAt != null) 'protectedAt': protectedAt?.toIso8601String(),
	if(claimedAt != null) 'claimedAt': claimedAt?.toIso8601String(),
	if(returnedAt != null) 'returnedAt': returnedAt?.toIso8601String(),
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'lease': lease?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is DepositProtection &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    