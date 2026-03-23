
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'escrow_status.dart';
import 'escrow_account.dart';
import 'organization.dart';


class EscrowStatusHistory implements PrismaModel<String, EscrowStatusHistory> , Id<String> {
    @override
String? id;
	String? orgId;
	String? escrowId;
	EscrowStatus? fromStatus;
	EscrowStatus? toStatus;
	String? changedBy;
	String? reason;
	dynamic metadata;
	DateTime? changedAt;
	EscrowAccount? escrow;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    EscrowStatusHistory({ this.id,
	 this.orgId,
	 this.escrowId,
	 this.fromStatus,
	 this.toStatus,
	 this.changedBy,
	 this.reason,
	required this.metadata,
	 this.changedAt,
	 this.escrow,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<EscrowStatusHistory, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"escrowId": (m) => m.escrowId,

	"fromStatus": (m) => m.fromStatus,

	"toStatus": (m) => m.toStatus,

	"changedBy": (m) => m.changedBy,

	"reason": (m) => m.reason,

	"metadata": (m) => m.metadata,

	"changedAt": (m) => m.changedAt,

	"escrow": (m) => m.escrow,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(EscrowStatusHistory) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in EscrowStatusHistory');
    }
    return propFunction as V? Function(EscrowStatusHistory);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory EscrowStatusHistory.fromJson(JsonMap json) =>
      EscrowStatusHistory(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	escrowId: json['escrowId'] as String?,
	fromStatus: json['fromStatus'] != null ? EscrowStatus.fromJson(json['fromStatus']) : null,
	toStatus: json['toStatus'] != null ? EscrowStatus.fromJson(json['toStatus']) : null,
	changedBy: json['changedBy'] as String?,
	reason: json['reason'] as String?,
	metadata: json['metadata'] as dynamic,
	changedAt: json['changedAt'] != null ? DateTime.parse(json['changedAt']) : null,
	escrow: json['escrow'] != null ? EscrowAccount.fromJson(json['escrow'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    EscrowStatusHistory copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? escrowId,
		Value<EscrowStatus?>? fromStatus,
		Value<EscrowStatus?>? toStatus,
		Value<String?>? changedBy,
		Value<String?>? reason,
		Value<dynamic>? metadata,
		Value<DateTime?>? changedAt,
		Value<EscrowAccount?>? escrow,
		Value<Organization?>? org,
        }) {
        return EscrowStatusHistory(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		escrowId: escrowId != null ? escrowId.value : this.escrowId,
		fromStatus: fromStatus != null ? fromStatus.value : this.fromStatus,
		toStatus: toStatus != null ? toStatus.value : this.toStatus,
		changedBy: changedBy != null ? changedBy.value : this.changedBy,
		reason: reason != null ? reason.value : this.reason,
		metadata: metadata != null ? metadata.value : this.metadata,
		changedAt: changedAt != null ? changedAt.value : this.changedAt,
		escrow: escrow != null ? escrow.value : this.escrow,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    EscrowStatusHistory copyWithInstanceValues(EscrowStatusHistory escrowStatusHistory) {
        return EscrowStatusHistory(
            id: escrowStatusHistory.id ?? id,
		orgId: escrowStatusHistory.orgId ?? orgId,
		escrowId: escrowStatusHistory.escrowId ?? escrowId,
		fromStatus: escrowStatusHistory.fromStatus ?? fromStatus,
		toStatus: escrowStatusHistory.toStatus ?? toStatus,
		changedBy: escrowStatusHistory.changedBy ?? changedBy,
		reason: escrowStatusHistory.reason ?? reason,
		metadata: escrowStatusHistory.metadata ?? metadata,
		changedAt: escrowStatusHistory.changedAt ?? changedAt,
		escrow: escrowStatusHistory.escrow ?? escrow,
		org: escrowStatusHistory.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    EscrowStatusHistory mergeWithInstanceValues(EscrowStatusHistory escrowStatusHistory) {
        return EscrowStatusHistory(
            id: escrowStatusHistory.$assignedFields.contains('id') ? escrowStatusHistory.id : id,
		orgId: escrowStatusHistory.$assignedFields.contains('orgId') ? escrowStatusHistory.orgId : orgId,
		escrowId: escrowStatusHistory.$assignedFields.contains('escrowId') ? escrowStatusHistory.escrowId : escrowId,
		fromStatus: escrowStatusHistory.$assignedFields.contains('fromStatus') ? escrowStatusHistory.fromStatus : fromStatus,
		toStatus: escrowStatusHistory.$assignedFields.contains('toStatus') ? escrowStatusHistory.toStatus : toStatus,
		changedBy: escrowStatusHistory.$assignedFields.contains('changedBy') ? escrowStatusHistory.changedBy : changedBy,
		reason: escrowStatusHistory.$assignedFields.contains('reason') ? escrowStatusHistory.reason : reason,
		metadata: escrowStatusHistory.$assignedFields.contains('metadata') ? escrowStatusHistory.metadata : metadata,
		changedAt: escrowStatusHistory.$assignedFields.contains('changedAt') ? escrowStatusHistory.changedAt : changedAt,
		escrow: escrowStatusHistory.$assignedFields.contains('escrow') ? escrowStatusHistory.escrow : escrow,
		org: escrowStatusHistory.$assignedFields.contains('org') ? escrowStatusHistory.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    EscrowStatusHistory updateWithInstanceValues(EscrowStatusHistory escrowStatusHistory) {
        if (escrowStatusHistory.$assignedFields.contains('id')) { id = escrowStatusHistory.id; }
		if (escrowStatusHistory.$assignedFields.contains('orgId')) { orgId = escrowStatusHistory.orgId; }
		if (escrowStatusHistory.$assignedFields.contains('escrowId')) { escrowId = escrowStatusHistory.escrowId; }
		if (escrowStatusHistory.$assignedFields.contains('fromStatus')) { fromStatus = escrowStatusHistory.fromStatus; }
		if (escrowStatusHistory.$assignedFields.contains('toStatus')) { toStatus = escrowStatusHistory.toStatus; }
		if (escrowStatusHistory.$assignedFields.contains('changedBy')) { changedBy = escrowStatusHistory.changedBy; }
		if (escrowStatusHistory.$assignedFields.contains('reason')) { reason = escrowStatusHistory.reason; }
		if (escrowStatusHistory.$assignedFields.contains('metadata')) { metadata = escrowStatusHistory.metadata; }
		if (escrowStatusHistory.$assignedFields.contains('changedAt')) { changedAt = escrowStatusHistory.changedAt; }
		if (escrowStatusHistory.$assignedFields.contains('escrow')) { escrow = escrowStatusHistory.escrow; }
		if (escrowStatusHistory.$assignedFields.contains('org')) { org = escrowStatusHistory.org; }
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
          ? {...?serializedTypes, 'EscrowStatusHistory'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(escrowId != null) 'escrowId': escrowId,
	if(fromStatus != null) 'fromStatus': fromStatus?.toJson(),
	if(toStatus != null) 'toStatus': toStatus?.toJson(),
	if(changedBy != null) 'changedBy': changedBy,
	if(reason != null) 'reason': reason,
	if(metadata != null) 'metadata': metadata,
	if(changedAt != null) 'changedAt': changedAt?.toIso8601String(),
	if(escrow != null && (!preventCircularSerialization || !serializedModels.contains('EscrowAccount'))) 'escrow': escrow?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is EscrowStatusHistory &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    