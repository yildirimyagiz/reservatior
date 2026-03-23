
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'escrow_status.dart';
import 'organization.dart';
import 'reservation.dart';
import 'escrow_release.dart';
import 'escrow_dispute.dart';
import 'escrow_status_history.dart';


class EscrowAccount implements PrismaModel<String, EscrowAccount> , Id<String> {
    @override
String? id;
	String? orgId;
	String? reservationId;
	double? totalAmount;
	double? depositAmount;
	String? currency;
	EscrowStatus? status;
	DateTime? heldAt;
	DateTime? releasedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	Reservation? reservation;
	List<EscrowRelease>? releases;
	List<EscrowDispute>? disputes;
	List<EscrowStatusHistory>? statusHistory;
	int? $releasesCount;
	int? $disputesCount;
	int? $statusHistoryCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    EscrowAccount({ this.id,
	 this.orgId,
	 this.reservationId,
	 this.totalAmount,
	 this.depositAmount,
	 this.currency = "USD",
	 this.status = EscrowStatus.HOLDING,
	 this.heldAt,
	 this.releasedAt,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.reservation,
	 this.releases,
	 this.disputes,
	 this.statusHistory,
	this.$releasesCount,
	this.$disputesCount,
	this.$statusHistoryCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<EscrowAccount, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"reservationId": (m) => m.reservationId,

	"totalAmount": (m) => m.totalAmount,

	"depositAmount": (m) => m.depositAmount,

	"currency": (m) => m.currency,

	"status": (m) => m.status,

	"heldAt": (m) => m.heldAt,

	"releasedAt": (m) => m.releasedAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"reservation": (m) => m.reservation,

	"releases": (m) => m.releases,

	"disputes": (m) => m.disputes,

	"statusHistory": (m) => m.statusHistory,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(EscrowAccount) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in EscrowAccount');
    }
    return propFunction as V? Function(EscrowAccount);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory EscrowAccount.fromJson(JsonMap json) =>
      EscrowAccount(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	reservationId: json['reservationId'] as String?,
	totalAmount: json['totalAmount'] as double?,
	depositAmount: json['depositAmount'] as double?,
	currency: json['currency'] as String?,
	status: json['status'] != null ? EscrowStatus.fromJson(json['status']) : null,
	heldAt: json['heldAt'] != null ? DateTime.parse(json['heldAt']) : null,
	releasedAt: json['releasedAt'] != null ? DateTime.parse(json['releasedAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	reservation: json['reservation'] != null ? Reservation.fromJson(json['reservation'] as JsonMap) : null,
	releases: json['releases'] != null ? createModels<EscrowRelease>((json['releases'] as List).cast<JsonMap>(), EscrowRelease.fromJson) : null,
	disputes: json['disputes'] != null ? createModels<EscrowDispute>((json['disputes'] as List).cast<JsonMap>(), EscrowDispute.fromJson) : null,
	statusHistory: json['statusHistory'] != null ? createModels<EscrowStatusHistory>((json['statusHistory'] as List).cast<JsonMap>(), EscrowStatusHistory.fromJson) : null,
	$releasesCount: json['_count']?['releases'] as int?,
	$disputesCount: json['_count']?['disputes'] as int?,
	$statusHistoryCount: json['_count']?['statusHistory'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    EscrowAccount copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? reservationId,
		Value<double?>? totalAmount,
		Value<double?>? depositAmount,
		Value<String?>? currency,
		Value<EscrowStatus?>? status,
		Value<DateTime?>? heldAt,
		Value<DateTime?>? releasedAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<Reservation?>? reservation,
		Value<List<EscrowRelease>?>? releases,
		Value<List<EscrowDispute>?>? disputes,
		Value<List<EscrowStatusHistory>?>? statusHistory,
		int? $releasesCount,
		int? $disputesCount,
		int? $statusHistoryCount,
        }) {
        return EscrowAccount(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		totalAmount: totalAmount != null ? totalAmount.value : this.totalAmount,
		depositAmount: depositAmount != null ? depositAmount.value : this.depositAmount,
		currency: currency != null ? currency.value : this.currency,
		status: status != null ? status.value : this.status,
		heldAt: heldAt != null ? heldAt.value : this.heldAt,
		releasedAt: releasedAt != null ? releasedAt.value : this.releasedAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		reservation: reservation != null ? reservation.value : this.reservation,
		releases: releases != null ? releases.value : this.releases,
		disputes: disputes != null ? disputes.value : this.disputes,
		statusHistory: statusHistory != null ? statusHistory.value : this.statusHistory,
		$releasesCount: $releasesCount ?? this.$releasesCount,
		$disputesCount: $disputesCount ?? this.$disputesCount,
		$statusHistoryCount: $statusHistoryCount ?? this.$statusHistoryCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    EscrowAccount copyWithInstanceValues(EscrowAccount escrowAccount) {
        return EscrowAccount(
            id: escrowAccount.id ?? id,
		orgId: escrowAccount.orgId ?? orgId,
		reservationId: escrowAccount.reservationId ?? reservationId,
		totalAmount: escrowAccount.totalAmount ?? totalAmount,
		depositAmount: escrowAccount.depositAmount ?? depositAmount,
		currency: escrowAccount.currency ?? currency,
		status: escrowAccount.status ?? status,
		heldAt: escrowAccount.heldAt ?? heldAt,
		releasedAt: escrowAccount.releasedAt ?? releasedAt,
		createdAt: escrowAccount.createdAt ?? createdAt,
		updatedAt: escrowAccount.updatedAt ?? updatedAt,
		deletedAt: escrowAccount.deletedAt ?? deletedAt,
		org: escrowAccount.org ?? org,
		reservation: escrowAccount.reservation ?? reservation,
		releases: escrowAccount.releases ?? releases,
		disputes: escrowAccount.disputes ?? disputes,
		statusHistory: escrowAccount.statusHistory ?? statusHistory,
		$releasesCount: escrowAccount.$releasesCount ?? $releasesCount,
		$disputesCount: escrowAccount.$disputesCount ?? $disputesCount,
		$statusHistoryCount: escrowAccount.$statusHistoryCount ?? $statusHistoryCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    EscrowAccount mergeWithInstanceValues(EscrowAccount escrowAccount) {
        return EscrowAccount(
            id: escrowAccount.$assignedFields.contains('id') ? escrowAccount.id : id,
		orgId: escrowAccount.$assignedFields.contains('orgId') ? escrowAccount.orgId : orgId,
		reservationId: escrowAccount.$assignedFields.contains('reservationId') ? escrowAccount.reservationId : reservationId,
		totalAmount: escrowAccount.$assignedFields.contains('totalAmount') ? escrowAccount.totalAmount : totalAmount,
		depositAmount: escrowAccount.$assignedFields.contains('depositAmount') ? escrowAccount.depositAmount : depositAmount,
		currency: escrowAccount.$assignedFields.contains('currency') ? escrowAccount.currency : currency,
		status: escrowAccount.$assignedFields.contains('status') ? escrowAccount.status : status,
		heldAt: escrowAccount.$assignedFields.contains('heldAt') ? escrowAccount.heldAt : heldAt,
		releasedAt: escrowAccount.$assignedFields.contains('releasedAt') ? escrowAccount.releasedAt : releasedAt,
		createdAt: escrowAccount.$assignedFields.contains('createdAt') ? escrowAccount.createdAt : createdAt,
		updatedAt: escrowAccount.$assignedFields.contains('updatedAt') ? escrowAccount.updatedAt : updatedAt,
		deletedAt: escrowAccount.$assignedFields.contains('deletedAt') ? escrowAccount.deletedAt : deletedAt,
		org: escrowAccount.$assignedFields.contains('org') ? escrowAccount.org : org,
		reservation: escrowAccount.$assignedFields.contains('reservation') ? escrowAccount.reservation : reservation,
		releases: (escrowAccount.$assignedFields.contains('releases') && escrowAccount.releases != null) ? mergeModelLists(releases, escrowAccount.releases) : releases,
		disputes: (escrowAccount.$assignedFields.contains('disputes') && escrowAccount.disputes != null) ? mergeModelLists(disputes, escrowAccount.disputes) : disputes,
		statusHistory: (escrowAccount.$assignedFields.contains('statusHistory') && escrowAccount.statusHistory != null) ? mergeModelLists(statusHistory, escrowAccount.statusHistory) : statusHistory,
		$releasesCount: escrowAccount.$releasesCount ?? $releasesCount,
		$disputesCount: escrowAccount.$disputesCount ?? $disputesCount,
		$statusHistoryCount: escrowAccount.$statusHistoryCount ?? $statusHistoryCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    EscrowAccount updateWithInstanceValues(EscrowAccount escrowAccount) {
        if (escrowAccount.$assignedFields.contains('id')) { id = escrowAccount.id; }
		if (escrowAccount.$assignedFields.contains('orgId')) { orgId = escrowAccount.orgId; }
		if (escrowAccount.$assignedFields.contains('reservationId')) { reservationId = escrowAccount.reservationId; }
		if (escrowAccount.$assignedFields.contains('totalAmount')) { totalAmount = escrowAccount.totalAmount; }
		if (escrowAccount.$assignedFields.contains('depositAmount')) { depositAmount = escrowAccount.depositAmount; }
		if (escrowAccount.$assignedFields.contains('currency')) { currency = escrowAccount.currency; }
		if (escrowAccount.$assignedFields.contains('status')) { status = escrowAccount.status; }
		if (escrowAccount.$assignedFields.contains('heldAt')) { heldAt = escrowAccount.heldAt; }
		if (escrowAccount.$assignedFields.contains('releasedAt')) { releasedAt = escrowAccount.releasedAt; }
		if (escrowAccount.$assignedFields.contains('createdAt')) { createdAt = escrowAccount.createdAt; }
		if (escrowAccount.$assignedFields.contains('updatedAt')) { updatedAt = escrowAccount.updatedAt; }
		if (escrowAccount.$assignedFields.contains('deletedAt')) { deletedAt = escrowAccount.deletedAt; }
		if (escrowAccount.$assignedFields.contains('org')) { org = escrowAccount.org; }
		if (escrowAccount.$assignedFields.contains('reservation')) { reservation = escrowAccount.reservation; }
		if (escrowAccount.$assignedFields.contains('releases') && escrowAccount.releases != null) { releases = mergeModelLists(releases, escrowAccount.releases); }
		if (escrowAccount.$assignedFields.contains('disputes') && escrowAccount.disputes != null) { disputes = mergeModelLists(disputes, escrowAccount.disputes); }
		if (escrowAccount.$assignedFields.contains('statusHistory') && escrowAccount.statusHistory != null) { statusHistory = mergeModelLists(statusHistory, escrowAccount.statusHistory); }
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
          ? {...?serializedTypes, 'EscrowAccount'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(reservationId != null) 'reservationId': reservationId,
	if(totalAmount != null) 'totalAmount': totalAmount,
	if(depositAmount != null) 'depositAmount': depositAmount,
	if(currency != null) 'currency': currency,
	if(status != null) 'status': status?.toJson(),
	if(heldAt != null) 'heldAt': heldAt?.toIso8601String(),
	if(releasedAt != null) 'releasedAt': releasedAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'reservation': reservation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(releases != null && (!preventCircularSerialization || !serializedModels.contains('EscrowRelease'))) 'releases': releases?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(disputes != null && (!preventCircularSerialization || !serializedModels.contains('EscrowDispute'))) 'disputes': disputes?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(statusHistory != null && (!preventCircularSerialization || !serializedModels.contains('EscrowStatusHistory'))) 'statusHistory': statusHistory?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($releasesCount != null || $disputesCount != null || $statusHistoryCount != null) '_count': { 
		if ($releasesCount != null) 'releases': $releasesCount, 
		if ($disputesCount != null) 'disputes': $disputesCount, 
		if ($statusHistoryCount != null) 'statusHistory': $statusHistoryCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is EscrowAccount &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    