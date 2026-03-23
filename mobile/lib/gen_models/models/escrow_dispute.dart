
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'escrow_dispute_party.dart';
import 'escrow_dispute_type.dart';
import 'escrow_dispute_status.dart';
import 'organization.dart';
import 'escrow_account.dart';


class EscrowDispute implements PrismaModel<String, EscrowDispute> , Id<String> {
    @override
String? id;
	String? orgId;
	String? reservationId;
	String? escrowAccountId;
	EscrowDisputeParty? openedBy;
	EscrowDisputeType? disputeType;
	String? description;
	double? claimedAmount;
	String? currency;
	EscrowDisputeStatus? status;
	dynamic evidence;
	String? resolution;
	double? resolvedAmount;
	DateTime? resolvedAt;
	String? resolvedBy;
	String? moderatorNotes;
	DateTime? escalatedAt;
	DateTime? deadlineAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	EscrowAccount? escrowAccount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    EscrowDispute({ this.id,
	 this.orgId,
	 this.reservationId,
	 this.escrowAccountId,
	 this.openedBy,
	 this.disputeType,
	 this.description,
	 this.claimedAmount,
	 this.currency = "USD",
	 this.status = EscrowDisputeStatus.OPEN,
	required this.evidence,
	 this.resolution,
	 this.resolvedAmount,
	 this.resolvedAt,
	 this.resolvedBy,
	 this.moderatorNotes,
	 this.escalatedAt,
	 this.deadlineAt,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.escrowAccount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<EscrowDispute, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"reservationId": (m) => m.reservationId,

	"escrowAccountId": (m) => m.escrowAccountId,

	"openedBy": (m) => m.openedBy,

	"disputeType": (m) => m.disputeType,

	"description": (m) => m.description,

	"claimedAmount": (m) => m.claimedAmount,

	"currency": (m) => m.currency,

	"status": (m) => m.status,

	"evidence": (m) => m.evidence,

	"resolution": (m) => m.resolution,

	"resolvedAmount": (m) => m.resolvedAmount,

	"resolvedAt": (m) => m.resolvedAt,

	"resolvedBy": (m) => m.resolvedBy,

	"moderatorNotes": (m) => m.moderatorNotes,

	"escalatedAt": (m) => m.escalatedAt,

	"deadlineAt": (m) => m.deadlineAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"escrowAccount": (m) => m.escrowAccount,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(EscrowDispute) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in EscrowDispute');
    }
    return propFunction as V? Function(EscrowDispute);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory EscrowDispute.fromJson(JsonMap json) =>
      EscrowDispute(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	reservationId: json['reservationId'] as String?,
	escrowAccountId: json['escrowAccountId'] as String?,
	openedBy: json['openedBy'] != null ? EscrowDisputeParty.fromJson(json['openedBy']) : null,
	disputeType: json['disputeType'] != null ? EscrowDisputeType.fromJson(json['disputeType']) : null,
	description: json['description'] as String?,
	claimedAmount: json['claimedAmount'] as double?,
	currency: json['currency'] as String?,
	status: json['status'] != null ? EscrowDisputeStatus.fromJson(json['status']) : null,
	evidence: json['evidence'] as dynamic,
	resolution: json['resolution'] as String?,
	resolvedAmount: json['resolvedAmount'] as double?,
	resolvedAt: json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt']) : null,
	resolvedBy: json['resolvedBy'] as String?,
	moderatorNotes: json['moderatorNotes'] as String?,
	escalatedAt: json['escalatedAt'] != null ? DateTime.parse(json['escalatedAt']) : null,
	deadlineAt: json['deadlineAt'] != null ? DateTime.parse(json['deadlineAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	escrowAccount: json['escrowAccount'] != null ? EscrowAccount.fromJson(json['escrowAccount'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    EscrowDispute copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? reservationId,
		Value<String?>? escrowAccountId,
		Value<EscrowDisputeParty?>? openedBy,
		Value<EscrowDisputeType?>? disputeType,
		Value<String?>? description,
		Value<double?>? claimedAmount,
		Value<String?>? currency,
		Value<EscrowDisputeStatus?>? status,
		Value<dynamic>? evidence,
		Value<String?>? resolution,
		Value<double?>? resolvedAmount,
		Value<DateTime?>? resolvedAt,
		Value<String?>? resolvedBy,
		Value<String?>? moderatorNotes,
		Value<DateTime?>? escalatedAt,
		Value<DateTime?>? deadlineAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<EscrowAccount?>? escrowAccount,
        }) {
        return EscrowDispute(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		escrowAccountId: escrowAccountId != null ? escrowAccountId.value : this.escrowAccountId,
		openedBy: openedBy != null ? openedBy.value : this.openedBy,
		disputeType: disputeType != null ? disputeType.value : this.disputeType,
		description: description != null ? description.value : this.description,
		claimedAmount: claimedAmount != null ? claimedAmount.value : this.claimedAmount,
		currency: currency != null ? currency.value : this.currency,
		status: status != null ? status.value : this.status,
		evidence: evidence != null ? evidence.value : this.evidence,
		resolution: resolution != null ? resolution.value : this.resolution,
		resolvedAmount: resolvedAmount != null ? resolvedAmount.value : this.resolvedAmount,
		resolvedAt: resolvedAt != null ? resolvedAt.value : this.resolvedAt,
		resolvedBy: resolvedBy != null ? resolvedBy.value : this.resolvedBy,
		moderatorNotes: moderatorNotes != null ? moderatorNotes.value : this.moderatorNotes,
		escalatedAt: escalatedAt != null ? escalatedAt.value : this.escalatedAt,
		deadlineAt: deadlineAt != null ? deadlineAt.value : this.deadlineAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		escrowAccount: escrowAccount != null ? escrowAccount.value : this.escrowAccount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    EscrowDispute copyWithInstanceValues(EscrowDispute escrowDispute) {
        return EscrowDispute(
            id: escrowDispute.id ?? id,
		orgId: escrowDispute.orgId ?? orgId,
		reservationId: escrowDispute.reservationId ?? reservationId,
		escrowAccountId: escrowDispute.escrowAccountId ?? escrowAccountId,
		openedBy: escrowDispute.openedBy ?? openedBy,
		disputeType: escrowDispute.disputeType ?? disputeType,
		description: escrowDispute.description ?? description,
		claimedAmount: escrowDispute.claimedAmount ?? claimedAmount,
		currency: escrowDispute.currency ?? currency,
		status: escrowDispute.status ?? status,
		evidence: escrowDispute.evidence ?? evidence,
		resolution: escrowDispute.resolution ?? resolution,
		resolvedAmount: escrowDispute.resolvedAmount ?? resolvedAmount,
		resolvedAt: escrowDispute.resolvedAt ?? resolvedAt,
		resolvedBy: escrowDispute.resolvedBy ?? resolvedBy,
		moderatorNotes: escrowDispute.moderatorNotes ?? moderatorNotes,
		escalatedAt: escrowDispute.escalatedAt ?? escalatedAt,
		deadlineAt: escrowDispute.deadlineAt ?? deadlineAt,
		createdAt: escrowDispute.createdAt ?? createdAt,
		updatedAt: escrowDispute.updatedAt ?? updatedAt,
		deletedAt: escrowDispute.deletedAt ?? deletedAt,
		org: escrowDispute.org ?? org,
		escrowAccount: escrowDispute.escrowAccount ?? escrowAccount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    EscrowDispute mergeWithInstanceValues(EscrowDispute escrowDispute) {
        return EscrowDispute(
            id: escrowDispute.$assignedFields.contains('id') ? escrowDispute.id : id,
		orgId: escrowDispute.$assignedFields.contains('orgId') ? escrowDispute.orgId : orgId,
		reservationId: escrowDispute.$assignedFields.contains('reservationId') ? escrowDispute.reservationId : reservationId,
		escrowAccountId: escrowDispute.$assignedFields.contains('escrowAccountId') ? escrowDispute.escrowAccountId : escrowAccountId,
		openedBy: escrowDispute.$assignedFields.contains('openedBy') ? escrowDispute.openedBy : openedBy,
		disputeType: escrowDispute.$assignedFields.contains('disputeType') ? escrowDispute.disputeType : disputeType,
		description: escrowDispute.$assignedFields.contains('description') ? escrowDispute.description : description,
		claimedAmount: escrowDispute.$assignedFields.contains('claimedAmount') ? escrowDispute.claimedAmount : claimedAmount,
		currency: escrowDispute.$assignedFields.contains('currency') ? escrowDispute.currency : currency,
		status: escrowDispute.$assignedFields.contains('status') ? escrowDispute.status : status,
		evidence: escrowDispute.$assignedFields.contains('evidence') ? escrowDispute.evidence : evidence,
		resolution: escrowDispute.$assignedFields.contains('resolution') ? escrowDispute.resolution : resolution,
		resolvedAmount: escrowDispute.$assignedFields.contains('resolvedAmount') ? escrowDispute.resolvedAmount : resolvedAmount,
		resolvedAt: escrowDispute.$assignedFields.contains('resolvedAt') ? escrowDispute.resolvedAt : resolvedAt,
		resolvedBy: escrowDispute.$assignedFields.contains('resolvedBy') ? escrowDispute.resolvedBy : resolvedBy,
		moderatorNotes: escrowDispute.$assignedFields.contains('moderatorNotes') ? escrowDispute.moderatorNotes : moderatorNotes,
		escalatedAt: escrowDispute.$assignedFields.contains('escalatedAt') ? escrowDispute.escalatedAt : escalatedAt,
		deadlineAt: escrowDispute.$assignedFields.contains('deadlineAt') ? escrowDispute.deadlineAt : deadlineAt,
		createdAt: escrowDispute.$assignedFields.contains('createdAt') ? escrowDispute.createdAt : createdAt,
		updatedAt: escrowDispute.$assignedFields.contains('updatedAt') ? escrowDispute.updatedAt : updatedAt,
		deletedAt: escrowDispute.$assignedFields.contains('deletedAt') ? escrowDispute.deletedAt : deletedAt,
		org: escrowDispute.$assignedFields.contains('org') ? escrowDispute.org : org,
		escrowAccount: escrowDispute.$assignedFields.contains('escrowAccount') ? escrowDispute.escrowAccount : escrowAccount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    EscrowDispute updateWithInstanceValues(EscrowDispute escrowDispute) {
        if (escrowDispute.$assignedFields.contains('id')) { id = escrowDispute.id; }
		if (escrowDispute.$assignedFields.contains('orgId')) { orgId = escrowDispute.orgId; }
		if (escrowDispute.$assignedFields.contains('reservationId')) { reservationId = escrowDispute.reservationId; }
		if (escrowDispute.$assignedFields.contains('escrowAccountId')) { escrowAccountId = escrowDispute.escrowAccountId; }
		if (escrowDispute.$assignedFields.contains('openedBy')) { openedBy = escrowDispute.openedBy; }
		if (escrowDispute.$assignedFields.contains('disputeType')) { disputeType = escrowDispute.disputeType; }
		if (escrowDispute.$assignedFields.contains('description')) { description = escrowDispute.description; }
		if (escrowDispute.$assignedFields.contains('claimedAmount')) { claimedAmount = escrowDispute.claimedAmount; }
		if (escrowDispute.$assignedFields.contains('currency')) { currency = escrowDispute.currency; }
		if (escrowDispute.$assignedFields.contains('status')) { status = escrowDispute.status; }
		if (escrowDispute.$assignedFields.contains('evidence')) { evidence = escrowDispute.evidence; }
		if (escrowDispute.$assignedFields.contains('resolution')) { resolution = escrowDispute.resolution; }
		if (escrowDispute.$assignedFields.contains('resolvedAmount')) { resolvedAmount = escrowDispute.resolvedAmount; }
		if (escrowDispute.$assignedFields.contains('resolvedAt')) { resolvedAt = escrowDispute.resolvedAt; }
		if (escrowDispute.$assignedFields.contains('resolvedBy')) { resolvedBy = escrowDispute.resolvedBy; }
		if (escrowDispute.$assignedFields.contains('moderatorNotes')) { moderatorNotes = escrowDispute.moderatorNotes; }
		if (escrowDispute.$assignedFields.contains('escalatedAt')) { escalatedAt = escrowDispute.escalatedAt; }
		if (escrowDispute.$assignedFields.contains('deadlineAt')) { deadlineAt = escrowDispute.deadlineAt; }
		if (escrowDispute.$assignedFields.contains('createdAt')) { createdAt = escrowDispute.createdAt; }
		if (escrowDispute.$assignedFields.contains('updatedAt')) { updatedAt = escrowDispute.updatedAt; }
		if (escrowDispute.$assignedFields.contains('deletedAt')) { deletedAt = escrowDispute.deletedAt; }
		if (escrowDispute.$assignedFields.contains('org')) { org = escrowDispute.org; }
		if (escrowDispute.$assignedFields.contains('escrowAccount')) { escrowAccount = escrowDispute.escrowAccount; }
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
          ? {...?serializedTypes, 'EscrowDispute'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(reservationId != null) 'reservationId': reservationId,
	if(escrowAccountId != null) 'escrowAccountId': escrowAccountId,
	if(openedBy != null) 'openedBy': openedBy?.toJson(),
	if(disputeType != null) 'disputeType': disputeType?.toJson(),
	if(description != null) 'description': description,
	if(claimedAmount != null) 'claimedAmount': claimedAmount,
	if(currency != null) 'currency': currency,
	if(status != null) 'status': status?.toJson(),
	if(evidence != null) 'evidence': evidence,
	if(resolution != null) 'resolution': resolution,
	if(resolvedAmount != null) 'resolvedAmount': resolvedAmount,
	if(resolvedAt != null) 'resolvedAt': resolvedAt?.toIso8601String(),
	if(resolvedBy != null) 'resolvedBy': resolvedBy,
	if(moderatorNotes != null) 'moderatorNotes': moderatorNotes,
	if(escalatedAt != null) 'escalatedAt': escalatedAt?.toIso8601String(),
	if(deadlineAt != null) 'deadlineAt': deadlineAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(escrowAccount != null && (!preventCircularSerialization || !serializedModels.contains('EscrowAccount'))) 'escrowAccount': escrowAccount?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is EscrowDispute &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    