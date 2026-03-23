
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';


class Verification implements PrismaModel<String, Verification> , Id<String> {
    @override
String? id;
	String? identifier;
	String? value;
	DateTime? expiresAt;
	DateTime? createdAt;
	DateTime? updatedAt;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Verification({ this.id,
	 this.identifier,
	 this.value,
	 this.expiresAt,
	 this.createdAt,
	 this.updatedAt,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Verification, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"identifier": (m) => m.identifier,

	"value": (m) => m.value,

	"expiresAt": (m) => m.expiresAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Verification) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Verification');
    }
    return propFunction as V? Function(Verification);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Verification.fromJson(JsonMap json) =>
      Verification(
        id: json['id'] as String?,
	identifier: json['identifier'] as String?,
	value: json['value'] as String?,
	expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Verification copyWith({
        Value<String?>? id,
		Value<String?>? identifier,
		Value<String?>? value,
		Value<DateTime?>? expiresAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
        }) {
        return Verification(
            id: id != null ? id.value : this.id,
		identifier: identifier != null ? identifier.value : this.identifier,
		value: value != null ? value.value : this.value,
		expiresAt: expiresAt != null ? expiresAt.value : this.expiresAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Verification copyWithInstanceValues(Verification verification) {
        return Verification(
            id: verification.id ?? id,
		identifier: verification.identifier ?? identifier,
		value: verification.value ?? value,
		expiresAt: verification.expiresAt ?? expiresAt,
		createdAt: verification.createdAt ?? createdAt,
		updatedAt: verification.updatedAt ?? updatedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Verification mergeWithInstanceValues(Verification verification) {
        return Verification(
            id: verification.$assignedFields.contains('id') ? verification.id : id,
		identifier: verification.$assignedFields.contains('identifier') ? verification.identifier : identifier,
		value: verification.$assignedFields.contains('value') ? verification.value : value,
		expiresAt: verification.$assignedFields.contains('expiresAt') ? verification.expiresAt : expiresAt,
		createdAt: verification.$assignedFields.contains('createdAt') ? verification.createdAt : createdAt,
		updatedAt: verification.$assignedFields.contains('updatedAt') ? verification.updatedAt : updatedAt
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Verification updateWithInstanceValues(Verification verification) {
        if (verification.$assignedFields.contains('id')) { id = verification.id; }
		if (verification.$assignedFields.contains('identifier')) { identifier = verification.identifier; }
		if (verification.$assignedFields.contains('value')) { value = verification.value; }
		if (verification.$assignedFields.contains('expiresAt')) { expiresAt = verification.expiresAt; }
		if (verification.$assignedFields.contains('createdAt')) { createdAt = verification.createdAt; }
		if (verification.$assignedFields.contains('updatedAt')) { updatedAt = verification.updatedAt; }
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
          ? {...?serializedTypes, 'Verification'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(identifier != null) 'identifier': identifier,
	if(value != null) 'value': value,
	if(expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String()
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Verification &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    