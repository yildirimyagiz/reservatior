
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';


class KeyManagement implements PrismaModel<String, KeyManagement> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? keyType;
	String? keyNumber;
	String? keyLocation;
	String? keySafeCode;
	String? keyStatus;
	DateTime? cutDate;
	String? cutBy;
	double? replacementCost;
	String? notes;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    KeyManagement({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.keyType,
	 this.keyNumber,
	 this.keyLocation,
	 this.keySafeCode,
	 this.keyStatus = "AVAILABLE",
	 this.cutDate,
	 this.cutBy,
	 this.replacementCost,
	 this.notes,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<KeyManagement, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"keyType": (m) => m.keyType,

	"keyNumber": (m) => m.keyNumber,

	"keyLocation": (m) => m.keyLocation,

	"keySafeCode": (m) => m.keySafeCode,

	"keyStatus": (m) => m.keyStatus,

	"cutDate": (m) => m.cutDate,

	"cutBy": (m) => m.cutBy,

	"replacementCost": (m) => m.replacementCost,

	"notes": (m) => m.notes,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(KeyManagement) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in KeyManagement');
    }
    return propFunction as V? Function(KeyManagement);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory KeyManagement.fromJson(JsonMap json) =>
      KeyManagement(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	keyType: json['keyType'] as String?,
	keyNumber: json['keyNumber'] as String?,
	keyLocation: json['keyLocation'] as String?,
	keySafeCode: json['keySafeCode'] as String?,
	keyStatus: json['keyStatus'] as String?,
	cutDate: json['cutDate'] != null ? DateTime.parse(json['cutDate']) : null,
	cutBy: json['cutBy'] as String?,
	replacementCost: json['replacementCost'] as double?,
	notes: json['notes'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    KeyManagement copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? keyType,
		Value<String?>? keyNumber,
		Value<String?>? keyLocation,
		Value<String?>? keySafeCode,
		Value<String?>? keyStatus,
		Value<DateTime?>? cutDate,
		Value<String?>? cutBy,
		Value<double?>? replacementCost,
		Value<String?>? notes,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return KeyManagement(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		keyType: keyType != null ? keyType.value : this.keyType,
		keyNumber: keyNumber != null ? keyNumber.value : this.keyNumber,
		keyLocation: keyLocation != null ? keyLocation.value : this.keyLocation,
		keySafeCode: keySafeCode != null ? keySafeCode.value : this.keySafeCode,
		keyStatus: keyStatus != null ? keyStatus.value : this.keyStatus,
		cutDate: cutDate != null ? cutDate.value : this.cutDate,
		cutBy: cutBy != null ? cutBy.value : this.cutBy,
		replacementCost: replacementCost != null ? replacementCost.value : this.replacementCost,
		notes: notes != null ? notes.value : this.notes,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    KeyManagement copyWithInstanceValues(KeyManagement keyManagement) {
        return KeyManagement(
            id: keyManagement.id ?? id,
		orgId: keyManagement.orgId ?? orgId,
		propertyId: keyManagement.propertyId ?? propertyId,
		keyType: keyManagement.keyType ?? keyType,
		keyNumber: keyManagement.keyNumber ?? keyNumber,
		keyLocation: keyManagement.keyLocation ?? keyLocation,
		keySafeCode: keyManagement.keySafeCode ?? keySafeCode,
		keyStatus: keyManagement.keyStatus ?? keyStatus,
		cutDate: keyManagement.cutDate ?? cutDate,
		cutBy: keyManagement.cutBy ?? cutBy,
		replacementCost: keyManagement.replacementCost ?? replacementCost,
		notes: keyManagement.notes ?? notes,
		createdAt: keyManagement.createdAt ?? createdAt,
		updatedAt: keyManagement.updatedAt ?? updatedAt,
		org: keyManagement.org ?? org,
		property: keyManagement.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    KeyManagement mergeWithInstanceValues(KeyManagement keyManagement) {
        return KeyManagement(
            id: keyManagement.$assignedFields.contains('id') ? keyManagement.id : id,
		orgId: keyManagement.$assignedFields.contains('orgId') ? keyManagement.orgId : orgId,
		propertyId: keyManagement.$assignedFields.contains('propertyId') ? keyManagement.propertyId : propertyId,
		keyType: keyManagement.$assignedFields.contains('keyType') ? keyManagement.keyType : keyType,
		keyNumber: keyManagement.$assignedFields.contains('keyNumber') ? keyManagement.keyNumber : keyNumber,
		keyLocation: keyManagement.$assignedFields.contains('keyLocation') ? keyManagement.keyLocation : keyLocation,
		keySafeCode: keyManagement.$assignedFields.contains('keySafeCode') ? keyManagement.keySafeCode : keySafeCode,
		keyStatus: keyManagement.$assignedFields.contains('keyStatus') ? keyManagement.keyStatus : keyStatus,
		cutDate: keyManagement.$assignedFields.contains('cutDate') ? keyManagement.cutDate : cutDate,
		cutBy: keyManagement.$assignedFields.contains('cutBy') ? keyManagement.cutBy : cutBy,
		replacementCost: keyManagement.$assignedFields.contains('replacementCost') ? keyManagement.replacementCost : replacementCost,
		notes: keyManagement.$assignedFields.contains('notes') ? keyManagement.notes : notes,
		createdAt: keyManagement.$assignedFields.contains('createdAt') ? keyManagement.createdAt : createdAt,
		updatedAt: keyManagement.$assignedFields.contains('updatedAt') ? keyManagement.updatedAt : updatedAt,
		org: keyManagement.$assignedFields.contains('org') ? keyManagement.org : org,
		property: keyManagement.$assignedFields.contains('property') ? keyManagement.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    KeyManagement updateWithInstanceValues(KeyManagement keyManagement) {
        if (keyManagement.$assignedFields.contains('id')) { id = keyManagement.id; }
		if (keyManagement.$assignedFields.contains('orgId')) { orgId = keyManagement.orgId; }
		if (keyManagement.$assignedFields.contains('propertyId')) { propertyId = keyManagement.propertyId; }
		if (keyManagement.$assignedFields.contains('keyType')) { keyType = keyManagement.keyType; }
		if (keyManagement.$assignedFields.contains('keyNumber')) { keyNumber = keyManagement.keyNumber; }
		if (keyManagement.$assignedFields.contains('keyLocation')) { keyLocation = keyManagement.keyLocation; }
		if (keyManagement.$assignedFields.contains('keySafeCode')) { keySafeCode = keyManagement.keySafeCode; }
		if (keyManagement.$assignedFields.contains('keyStatus')) { keyStatus = keyManagement.keyStatus; }
		if (keyManagement.$assignedFields.contains('cutDate')) { cutDate = keyManagement.cutDate; }
		if (keyManagement.$assignedFields.contains('cutBy')) { cutBy = keyManagement.cutBy; }
		if (keyManagement.$assignedFields.contains('replacementCost')) { replacementCost = keyManagement.replacementCost; }
		if (keyManagement.$assignedFields.contains('notes')) { notes = keyManagement.notes; }
		if (keyManagement.$assignedFields.contains('createdAt')) { createdAt = keyManagement.createdAt; }
		if (keyManagement.$assignedFields.contains('updatedAt')) { updatedAt = keyManagement.updatedAt; }
		if (keyManagement.$assignedFields.contains('org')) { org = keyManagement.org; }
		if (keyManagement.$assignedFields.contains('property')) { property = keyManagement.property; }
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
          ? {...?serializedTypes, 'KeyManagement'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(keyType != null) 'keyType': keyType,
	if(keyNumber != null) 'keyNumber': keyNumber,
	if(keyLocation != null) 'keyLocation': keyLocation,
	if(keySafeCode != null) 'keySafeCode': keySafeCode,
	if(keyStatus != null) 'keyStatus': keyStatus,
	if(cutDate != null) 'cutDate': cutDate?.toIso8601String(),
	if(cutBy != null) 'cutBy': cutBy,
	if(replacementCost != null) 'replacementCost': replacementCost,
	if(notes != null) 'notes': notes,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is KeyManagement &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    