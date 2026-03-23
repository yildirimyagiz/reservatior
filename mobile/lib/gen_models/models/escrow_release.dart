
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'escrow_trigger_event.dart';
import 'escrow_release_status.dart';
import 'escrow_account.dart';
import 'organization.dart';


class EscrowRelease implements PrismaModel<String, EscrowRelease> , Id<String> {
    @override
String? id;
	String? orgId;
	String? escrowId;
	EscrowTriggerEvent? triggerEvent;
	double? releasePercent;
	double? amount;
	String? currency;
	EscrowReleaseStatus? status;
	DateTime? scheduledAt;
	DateTime? releasedAt;
	List<String>? approvalRequiredBy;
	dynamic approvals;
	DateTime? approvalCompletedAt;
	String? approvedBy;
	String? failureReason;
	int? retryCount;
	String? notes;
	DateTime? deletedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	EscrowAccount? escrow;
	Organization? org;
	int? $approvalRequiredByCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    EscrowRelease({ this.id,
	 this.orgId,
	 this.escrowId,
	 this.triggerEvent,
	 this.releasePercent,
	 this.amount,
	 this.currency = "USD",
	 this.status = EscrowReleaseStatus.PENDING,
	 this.scheduledAt,
	 this.releasedAt,
	 this.approvalRequiredBy,
	required this.approvals,
	 this.approvalCompletedAt,
	 this.approvedBy,
	 this.failureReason,
	 this.retryCount = 0,
	 this.notes,
	 this.deletedAt,
	 this.createdAt,
	 this.updatedAt,
	 this.escrow,
	 this.org,
	this.$approvalRequiredByCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<EscrowRelease, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"escrowId": (m) => m.escrowId,

	"triggerEvent": (m) => m.triggerEvent,

	"releasePercent": (m) => m.releasePercent,

	"amount": (m) => m.amount,

	"currency": (m) => m.currency,

	"status": (m) => m.status,

	"scheduledAt": (m) => m.scheduledAt,

	"releasedAt": (m) => m.releasedAt,

	"approvalRequiredBy": (m) => m.approvalRequiredBy,

	"approvals": (m) => m.approvals,

	"approvalCompletedAt": (m) => m.approvalCompletedAt,

	"approvedBy": (m) => m.approvedBy,

	"failureReason": (m) => m.failureReason,

	"retryCount": (m) => m.retryCount,

	"notes": (m) => m.notes,

	"deletedAt": (m) => m.deletedAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"escrow": (m) => m.escrow,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(EscrowRelease) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in EscrowRelease');
    }
    return propFunction as V? Function(EscrowRelease);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory EscrowRelease.fromJson(JsonMap json) =>
      EscrowRelease(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	escrowId: json['escrowId'] as String?,
	triggerEvent: json['triggerEvent'] != null ? EscrowTriggerEvent.fromJson(json['triggerEvent']) : null,
	releasePercent: json['releasePercent']?.toDouble(),
	amount: json['amount'] as double?,
	currency: json['currency'] as String?,
	status: json['status'] != null ? EscrowReleaseStatus.fromJson(json['status']) : null,
	scheduledAt: json['scheduledAt'] != null ? DateTime.parse(json['scheduledAt']) : null,
	releasedAt: json['releasedAt'] != null ? DateTime.parse(json['releasedAt']) : null,
	approvalRequiredBy: json['approvalRequiredBy'] != null ? (json['approvalRequiredBy'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	approvals: json['approvals'] as dynamic,
	approvalCompletedAt: json['approvalCompletedAt'] != null ? DateTime.parse(json['approvalCompletedAt']) : null,
	approvedBy: json['approvedBy'] as String?,
	failureReason: json['failureReason'] as String?,
	retryCount: int.tryParse(json['retryCount'].toString()),
	notes: json['notes'] as String?,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	escrow: json['escrow'] != null ? EscrowAccount.fromJson(json['escrow'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	$approvalRequiredByCount: json['_count']?['approvalRequiredBy'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    EscrowRelease copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? escrowId,
		Value<EscrowTriggerEvent?>? triggerEvent,
		Value<double?>? releasePercent,
		Value<double?>? amount,
		Value<String?>? currency,
		Value<EscrowReleaseStatus?>? status,
		Value<DateTime?>? scheduledAt,
		Value<DateTime?>? releasedAt,
		Value<List<String>?>? approvalRequiredBy,
		Value<dynamic>? approvals,
		Value<DateTime?>? approvalCompletedAt,
		Value<String?>? approvedBy,
		Value<String?>? failureReason,
		Value<int?>? retryCount,
		Value<String?>? notes,
		Value<DateTime?>? deletedAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<EscrowAccount?>? escrow,
		Value<Organization?>? org,
		int? $approvalRequiredByCount,
        }) {
        return EscrowRelease(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		escrowId: escrowId != null ? escrowId.value : this.escrowId,
		triggerEvent: triggerEvent != null ? triggerEvent.value : this.triggerEvent,
		releasePercent: releasePercent != null ? releasePercent.value : this.releasePercent,
		amount: amount != null ? amount.value : this.amount,
		currency: currency != null ? currency.value : this.currency,
		status: status != null ? status.value : this.status,
		scheduledAt: scheduledAt != null ? scheduledAt.value : this.scheduledAt,
		releasedAt: releasedAt != null ? releasedAt.value : this.releasedAt,
		approvalRequiredBy: approvalRequiredBy != null ? approvalRequiredBy.value : this.approvalRequiredBy,
		approvals: approvals != null ? approvals.value : this.approvals,
		approvalCompletedAt: approvalCompletedAt != null ? approvalCompletedAt.value : this.approvalCompletedAt,
		approvedBy: approvedBy != null ? approvedBy.value : this.approvedBy,
		failureReason: failureReason != null ? failureReason.value : this.failureReason,
		retryCount: retryCount != null ? retryCount.value : this.retryCount,
		notes: notes != null ? notes.value : this.notes,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		escrow: escrow != null ? escrow.value : this.escrow,
		org: org != null ? org.value : this.org,
		$approvalRequiredByCount: $approvalRequiredByCount ?? this.$approvalRequiredByCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    EscrowRelease copyWithInstanceValues(EscrowRelease escrowRelease) {
        return EscrowRelease(
            id: escrowRelease.id ?? id,
		orgId: escrowRelease.orgId ?? orgId,
		escrowId: escrowRelease.escrowId ?? escrowId,
		triggerEvent: escrowRelease.triggerEvent ?? triggerEvent,
		releasePercent: escrowRelease.releasePercent ?? releasePercent,
		amount: escrowRelease.amount ?? amount,
		currency: escrowRelease.currency ?? currency,
		status: escrowRelease.status ?? status,
		scheduledAt: escrowRelease.scheduledAt ?? scheduledAt,
		releasedAt: escrowRelease.releasedAt ?? releasedAt,
		approvalRequiredBy: escrowRelease.approvalRequiredBy ?? approvalRequiredBy,
		approvals: escrowRelease.approvals ?? approvals,
		approvalCompletedAt: escrowRelease.approvalCompletedAt ?? approvalCompletedAt,
		approvedBy: escrowRelease.approvedBy ?? approvedBy,
		failureReason: escrowRelease.failureReason ?? failureReason,
		retryCount: escrowRelease.retryCount ?? retryCount,
		notes: escrowRelease.notes ?? notes,
		deletedAt: escrowRelease.deletedAt ?? deletedAt,
		createdAt: escrowRelease.createdAt ?? createdAt,
		updatedAt: escrowRelease.updatedAt ?? updatedAt,
		escrow: escrowRelease.escrow ?? escrow,
		org: escrowRelease.org ?? org,
		$approvalRequiredByCount: escrowRelease.$approvalRequiredByCount ?? $approvalRequiredByCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    EscrowRelease mergeWithInstanceValues(EscrowRelease escrowRelease) {
        return EscrowRelease(
            id: escrowRelease.$assignedFields.contains('id') ? escrowRelease.id : id,
		orgId: escrowRelease.$assignedFields.contains('orgId') ? escrowRelease.orgId : orgId,
		escrowId: escrowRelease.$assignedFields.contains('escrowId') ? escrowRelease.escrowId : escrowId,
		triggerEvent: escrowRelease.$assignedFields.contains('triggerEvent') ? escrowRelease.triggerEvent : triggerEvent,
		releasePercent: escrowRelease.$assignedFields.contains('releasePercent') ? escrowRelease.releasePercent : releasePercent,
		amount: escrowRelease.$assignedFields.contains('amount') ? escrowRelease.amount : amount,
		currency: escrowRelease.$assignedFields.contains('currency') ? escrowRelease.currency : currency,
		status: escrowRelease.$assignedFields.contains('status') ? escrowRelease.status : status,
		scheduledAt: escrowRelease.$assignedFields.contains('scheduledAt') ? escrowRelease.scheduledAt : scheduledAt,
		releasedAt: escrowRelease.$assignedFields.contains('releasedAt') ? escrowRelease.releasedAt : releasedAt,
		approvalRequiredBy: escrowRelease.$assignedFields.contains('approvalRequiredBy') ? escrowRelease.approvalRequiredBy : approvalRequiredBy,
		approvals: escrowRelease.$assignedFields.contains('approvals') ? escrowRelease.approvals : approvals,
		approvalCompletedAt: escrowRelease.$assignedFields.contains('approvalCompletedAt') ? escrowRelease.approvalCompletedAt : approvalCompletedAt,
		approvedBy: escrowRelease.$assignedFields.contains('approvedBy') ? escrowRelease.approvedBy : approvedBy,
		failureReason: escrowRelease.$assignedFields.contains('failureReason') ? escrowRelease.failureReason : failureReason,
		retryCount: escrowRelease.$assignedFields.contains('retryCount') ? escrowRelease.retryCount : retryCount,
		notes: escrowRelease.$assignedFields.contains('notes') ? escrowRelease.notes : notes,
		deletedAt: escrowRelease.$assignedFields.contains('deletedAt') ? escrowRelease.deletedAt : deletedAt,
		createdAt: escrowRelease.$assignedFields.contains('createdAt') ? escrowRelease.createdAt : createdAt,
		updatedAt: escrowRelease.$assignedFields.contains('updatedAt') ? escrowRelease.updatedAt : updatedAt,
		escrow: escrowRelease.$assignedFields.contains('escrow') ? escrowRelease.escrow : escrow,
		org: escrowRelease.$assignedFields.contains('org') ? escrowRelease.org : org,
		$approvalRequiredByCount: escrowRelease.$approvalRequiredByCount ?? $approvalRequiredByCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    EscrowRelease updateWithInstanceValues(EscrowRelease escrowRelease) {
        if (escrowRelease.$assignedFields.contains('id')) { id = escrowRelease.id; }
		if (escrowRelease.$assignedFields.contains('orgId')) { orgId = escrowRelease.orgId; }
		if (escrowRelease.$assignedFields.contains('escrowId')) { escrowId = escrowRelease.escrowId; }
		if (escrowRelease.$assignedFields.contains('triggerEvent')) { triggerEvent = escrowRelease.triggerEvent; }
		if (escrowRelease.$assignedFields.contains('releasePercent')) { releasePercent = escrowRelease.releasePercent; }
		if (escrowRelease.$assignedFields.contains('amount')) { amount = escrowRelease.amount; }
		if (escrowRelease.$assignedFields.contains('currency')) { currency = escrowRelease.currency; }
		if (escrowRelease.$assignedFields.contains('status')) { status = escrowRelease.status; }
		if (escrowRelease.$assignedFields.contains('scheduledAt')) { scheduledAt = escrowRelease.scheduledAt; }
		if (escrowRelease.$assignedFields.contains('releasedAt')) { releasedAt = escrowRelease.releasedAt; }
		if (escrowRelease.$assignedFields.contains('approvalRequiredBy')) { approvalRequiredBy = escrowRelease.approvalRequiredBy; }
		if (escrowRelease.$assignedFields.contains('approvals')) { approvals = escrowRelease.approvals; }
		if (escrowRelease.$assignedFields.contains('approvalCompletedAt')) { approvalCompletedAt = escrowRelease.approvalCompletedAt; }
		if (escrowRelease.$assignedFields.contains('approvedBy')) { approvedBy = escrowRelease.approvedBy; }
		if (escrowRelease.$assignedFields.contains('failureReason')) { failureReason = escrowRelease.failureReason; }
		if (escrowRelease.$assignedFields.contains('retryCount')) { retryCount = escrowRelease.retryCount; }
		if (escrowRelease.$assignedFields.contains('notes')) { notes = escrowRelease.notes; }
		if (escrowRelease.$assignedFields.contains('deletedAt')) { deletedAt = escrowRelease.deletedAt; }
		if (escrowRelease.$assignedFields.contains('createdAt')) { createdAt = escrowRelease.createdAt; }
		if (escrowRelease.$assignedFields.contains('updatedAt')) { updatedAt = escrowRelease.updatedAt; }
		if (escrowRelease.$assignedFields.contains('escrow')) { escrow = escrowRelease.escrow; }
		if (escrowRelease.$assignedFields.contains('org')) { org = escrowRelease.org; }
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
          ? {...?serializedTypes, 'EscrowRelease'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(escrowId != null) 'escrowId': escrowId,
	if(triggerEvent != null) 'triggerEvent': triggerEvent?.toJson(),
	if(releasePercent != null) 'releasePercent': releasePercent,
	if(amount != null) 'amount': amount,
	if(currency != null) 'currency': currency,
	if(status != null) 'status': status?.toJson(),
	if(scheduledAt != null) 'scheduledAt': scheduledAt?.toIso8601String(),
	if(releasedAt != null) 'releasedAt': releasedAt?.toIso8601String(),
	if(approvalRequiredBy != null) 'approvalRequiredBy': approvalRequiredBy,
	if(approvals != null) 'approvals': approvals,
	if(approvalCompletedAt != null) 'approvalCompletedAt': approvalCompletedAt?.toIso8601String(),
	if(approvedBy != null) 'approvedBy': approvedBy,
	if(failureReason != null) 'failureReason': failureReason,
	if(retryCount != null) 'retryCount': retryCount,
	if(notes != null) 'notes': notes,
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(escrow != null && (!preventCircularSerialization || !serializedModels.contains('EscrowAccount'))) 'escrow': escrow?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($approvalRequiredByCount != null) '_count': { 
		if ($approvalRequiredByCount != null) 'approvalRequiredBy': $approvalRequiredByCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is EscrowRelease &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    