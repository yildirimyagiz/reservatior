
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'compliance_type.dart';
import 'compliance_status.dart';
import 'agency.dart';
import 'agent.dart';
import 'property.dart';
import 'reservation.dart';


class ComplianceRecord implements PrismaModel<String, ComplianceRecord> , Id<String> {
    @override
String? id;
	String? entityId;
	String? entityType;
	ComplianceType? type;
	ComplianceStatus? status;
	String? documentUrl;
	DateTime? expiryDate;
	String? notes;
	bool? isVerified;
	String? propertyId;
	String? agentId;
	String? agencyId;
	String? reservationId;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Agency? Agency;
	Agent? Agent;
	Property? Property;
	Reservation? Reservation;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ComplianceRecord({ this.id,
	 this.entityId,
	 this.entityType,
	 this.type,
	 this.status,
	 this.documentUrl,
	 this.expiryDate,
	 this.notes,
	 this.isVerified = false,
	 this.propertyId,
	 this.agentId,
	 this.agencyId,
	 this.reservationId,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.Agency,
	 this.Agent,
	 this.Property,
	 this.Reservation,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ComplianceRecord, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"entityId": (m) => m.entityId,

	"entityType": (m) => m.entityType,

	"type": (m) => m.type,

	"status": (m) => m.status,

	"documentUrl": (m) => m.documentUrl,

	"expiryDate": (m) => m.expiryDate,

	"notes": (m) => m.notes,

	"isVerified": (m) => m.isVerified,

	"propertyId": (m) => m.propertyId,

	"agentId": (m) => m.agentId,

	"agencyId": (m) => m.agencyId,

	"reservationId": (m) => m.reservationId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"Agency": (m) => m.Agency,

	"Agent": (m) => m.Agent,

	"Property": (m) => m.Property,

	"Reservation": (m) => m.Reservation,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ComplianceRecord) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ComplianceRecord');
    }
    return propFunction as V? Function(ComplianceRecord);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ComplianceRecord.fromJson(JsonMap json) =>
      ComplianceRecord(
        id: json['id'] as String?,
	entityId: json['entityId'] as String?,
	entityType: json['entityType'] as String?,
	type: json['type'] != null ? ComplianceType.fromJson(json['type']) : null,
	status: json['status'] != null ? ComplianceStatus.fromJson(json['status']) : null,
	documentUrl: json['documentUrl'] as String?,
	expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null,
	notes: json['notes'] as String?,
	isVerified: json['isVerified'] as bool?,
	propertyId: json['propertyId'] as String?,
	agentId: json['agentId'] as String?,
	agencyId: json['agencyId'] as String?,
	reservationId: json['reservationId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	Agent: json['Agent'] != null ? Agent.fromJson(json['Agent'] as JsonMap) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	Reservation: json['Reservation'] != null ? Reservation.fromJson(json['Reservation'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ComplianceRecord copyWith({
        Value<String?>? id,
		Value<String?>? entityId,
		Value<String?>? entityType,
		Value<ComplianceType?>? type,
		Value<ComplianceStatus?>? status,
		Value<String?>? documentUrl,
		Value<DateTime?>? expiryDate,
		Value<String?>? notes,
		Value<bool?>? isVerified,
		Value<String?>? propertyId,
		Value<String?>? agentId,
		Value<String?>? agencyId,
		Value<String?>? reservationId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Agency?>? Agency,
		Value<Agent?>? Agent,
		Value<Property?>? Property,
		Value<Reservation?>? Reservation,
        }) {
        return ComplianceRecord(
            id: id != null ? id.value : this.id,
		entityId: entityId != null ? entityId.value : this.entityId,
		entityType: entityType != null ? entityType.value : this.entityType,
		type: type != null ? type.value : this.type,
		status: status != null ? status.value : this.status,
		documentUrl: documentUrl != null ? documentUrl.value : this.documentUrl,
		expiryDate: expiryDate != null ? expiryDate.value : this.expiryDate,
		notes: notes != null ? notes.value : this.notes,
		isVerified: isVerified != null ? isVerified.value : this.isVerified,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		agentId: agentId != null ? agentId.value : this.agentId,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		Agency: Agency != null ? Agency.value : this.Agency,
		Agent: Agent != null ? Agent.value : this.Agent,
		Property: Property != null ? Property.value : this.Property,
		Reservation: Reservation != null ? Reservation.value : this.Reservation
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ComplianceRecord copyWithInstanceValues(ComplianceRecord complianceRecord) {
        return ComplianceRecord(
            id: complianceRecord.id ?? id,
		entityId: complianceRecord.entityId ?? entityId,
		entityType: complianceRecord.entityType ?? entityType,
		type: complianceRecord.type ?? type,
		status: complianceRecord.status ?? status,
		documentUrl: complianceRecord.documentUrl ?? documentUrl,
		expiryDate: complianceRecord.expiryDate ?? expiryDate,
		notes: complianceRecord.notes ?? notes,
		isVerified: complianceRecord.isVerified ?? isVerified,
		propertyId: complianceRecord.propertyId ?? propertyId,
		agentId: complianceRecord.agentId ?? agentId,
		agencyId: complianceRecord.agencyId ?? agencyId,
		reservationId: complianceRecord.reservationId ?? reservationId,
		createdAt: complianceRecord.createdAt ?? createdAt,
		updatedAt: complianceRecord.updatedAt ?? updatedAt,
		deletedAt: complianceRecord.deletedAt ?? deletedAt,
		Agency: complianceRecord.Agency ?? Agency,
		Agent: complianceRecord.Agent ?? Agent,
		Property: complianceRecord.Property ?? Property,
		Reservation: complianceRecord.Reservation ?? Reservation
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ComplianceRecord mergeWithInstanceValues(ComplianceRecord complianceRecord) {
        return ComplianceRecord(
            id: complianceRecord.$assignedFields.contains('id') ? complianceRecord.id : id,
		entityId: complianceRecord.$assignedFields.contains('entityId') ? complianceRecord.entityId : entityId,
		entityType: complianceRecord.$assignedFields.contains('entityType') ? complianceRecord.entityType : entityType,
		type: complianceRecord.$assignedFields.contains('type') ? complianceRecord.type : type,
		status: complianceRecord.$assignedFields.contains('status') ? complianceRecord.status : status,
		documentUrl: complianceRecord.$assignedFields.contains('documentUrl') ? complianceRecord.documentUrl : documentUrl,
		expiryDate: complianceRecord.$assignedFields.contains('expiryDate') ? complianceRecord.expiryDate : expiryDate,
		notes: complianceRecord.$assignedFields.contains('notes') ? complianceRecord.notes : notes,
		isVerified: complianceRecord.$assignedFields.contains('isVerified') ? complianceRecord.isVerified : isVerified,
		propertyId: complianceRecord.$assignedFields.contains('propertyId') ? complianceRecord.propertyId : propertyId,
		agentId: complianceRecord.$assignedFields.contains('agentId') ? complianceRecord.agentId : agentId,
		agencyId: complianceRecord.$assignedFields.contains('agencyId') ? complianceRecord.agencyId : agencyId,
		reservationId: complianceRecord.$assignedFields.contains('reservationId') ? complianceRecord.reservationId : reservationId,
		createdAt: complianceRecord.$assignedFields.contains('createdAt') ? complianceRecord.createdAt : createdAt,
		updatedAt: complianceRecord.$assignedFields.contains('updatedAt') ? complianceRecord.updatedAt : updatedAt,
		deletedAt: complianceRecord.$assignedFields.contains('deletedAt') ? complianceRecord.deletedAt : deletedAt,
		Agency: complianceRecord.$assignedFields.contains('Agency') ? complianceRecord.Agency : Agency,
		Agent: complianceRecord.$assignedFields.contains('Agent') ? complianceRecord.Agent : Agent,
		Property: complianceRecord.$assignedFields.contains('Property') ? complianceRecord.Property : Property,
		Reservation: complianceRecord.$assignedFields.contains('Reservation') ? complianceRecord.Reservation : Reservation
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ComplianceRecord updateWithInstanceValues(ComplianceRecord complianceRecord) {
        if (complianceRecord.$assignedFields.contains('id')) { id = complianceRecord.id; }
		if (complianceRecord.$assignedFields.contains('entityId')) { entityId = complianceRecord.entityId; }
		if (complianceRecord.$assignedFields.contains('entityType')) { entityType = complianceRecord.entityType; }
		if (complianceRecord.$assignedFields.contains('type')) { type = complianceRecord.type; }
		if (complianceRecord.$assignedFields.contains('status')) { status = complianceRecord.status; }
		if (complianceRecord.$assignedFields.contains('documentUrl')) { documentUrl = complianceRecord.documentUrl; }
		if (complianceRecord.$assignedFields.contains('expiryDate')) { expiryDate = complianceRecord.expiryDate; }
		if (complianceRecord.$assignedFields.contains('notes')) { notes = complianceRecord.notes; }
		if (complianceRecord.$assignedFields.contains('isVerified')) { isVerified = complianceRecord.isVerified; }
		if (complianceRecord.$assignedFields.contains('propertyId')) { propertyId = complianceRecord.propertyId; }
		if (complianceRecord.$assignedFields.contains('agentId')) { agentId = complianceRecord.agentId; }
		if (complianceRecord.$assignedFields.contains('agencyId')) { agencyId = complianceRecord.agencyId; }
		if (complianceRecord.$assignedFields.contains('reservationId')) { reservationId = complianceRecord.reservationId; }
		if (complianceRecord.$assignedFields.contains('createdAt')) { createdAt = complianceRecord.createdAt; }
		if (complianceRecord.$assignedFields.contains('updatedAt')) { updatedAt = complianceRecord.updatedAt; }
		if (complianceRecord.$assignedFields.contains('deletedAt')) { deletedAt = complianceRecord.deletedAt; }
		if (complianceRecord.$assignedFields.contains('Agency')) { Agency = complianceRecord.Agency; }
		if (complianceRecord.$assignedFields.contains('Agent')) { Agent = complianceRecord.Agent; }
		if (complianceRecord.$assignedFields.contains('Property')) { Property = complianceRecord.Property; }
		if (complianceRecord.$assignedFields.contains('Reservation')) { Reservation = complianceRecord.Reservation; }
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
          ? {...?serializedTypes, 'ComplianceRecord'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(entityId != null) 'entityId': entityId,
	if(entityType != null) 'entityType': entityType,
	if(type != null) 'type': type?.toJson(),
	if(status != null) 'status': status?.toJson(),
	if(documentUrl != null) 'documentUrl': documentUrl,
	if(expiryDate != null) 'expiryDate': expiryDate?.toIso8601String(),
	if(notes != null) 'notes': notes,
	if(isVerified != null) 'isVerified': isVerified,
	if(propertyId != null) 'propertyId': propertyId,
	if(agentId != null) 'agentId': agentId,
	if(agencyId != null) 'agencyId': agencyId,
	if(reservationId != null) 'reservationId': reservationId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Agent != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'Agent': Agent?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'Reservation': Reservation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ComplianceRecord &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    