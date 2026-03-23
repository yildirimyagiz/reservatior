
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'property.dart';


class PropertyValuation implements PrismaModel<String, PropertyValuation> , Id<String> {
    @override
String? id;
	String? propertyId;
	DateTime? valuationDate;
	double? value;
	String? source;
	double? confidence;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PropertyValuation({ this.id,
	 this.propertyId,
	 this.valuationDate,
	 this.value,
	 this.source,
	 this.confidence,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PropertyValuation, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"propertyId": (m) => m.propertyId,

	"valuationDate": (m) => m.valuationDate,

	"value": (m) => m.value,

	"source": (m) => m.source,

	"confidence": (m) => m.confidence,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PropertyValuation) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PropertyValuation');
    }
    return propFunction as V? Function(PropertyValuation);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PropertyValuation.fromJson(JsonMap json) =>
      PropertyValuation(
        id: json['id'] as String?,
	propertyId: json['propertyId'] as String?,
	valuationDate: json['valuationDate'] != null ? DateTime.parse(json['valuationDate']) : null,
	value: json['value'] as double?,
	source: json['source'] as String?,
	confidence: json['confidence']?.toDouble(),
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PropertyValuation copyWith({
        Value<String?>? id,
		Value<String?>? propertyId,
		Value<DateTime?>? valuationDate,
		Value<double?>? value,
		Value<String?>? source,
		Value<double?>? confidence,
		Value<Property?>? property,
        }) {
        return PropertyValuation(
            id: id != null ? id.value : this.id,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		valuationDate: valuationDate != null ? valuationDate.value : this.valuationDate,
		value: value != null ? value.value : this.value,
		source: source != null ? source.value : this.source,
		confidence: confidence != null ? confidence.value : this.confidence,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PropertyValuation copyWithInstanceValues(PropertyValuation propertyValuation) {
        return PropertyValuation(
            id: propertyValuation.id ?? id,
		propertyId: propertyValuation.propertyId ?? propertyId,
		valuationDate: propertyValuation.valuationDate ?? valuationDate,
		value: propertyValuation.value ?? value,
		source: propertyValuation.source ?? source,
		confidence: propertyValuation.confidence ?? confidence,
		property: propertyValuation.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PropertyValuation mergeWithInstanceValues(PropertyValuation propertyValuation) {
        return PropertyValuation(
            id: propertyValuation.$assignedFields.contains('id') ? propertyValuation.id : id,
		propertyId: propertyValuation.$assignedFields.contains('propertyId') ? propertyValuation.propertyId : propertyId,
		valuationDate: propertyValuation.$assignedFields.contains('valuationDate') ? propertyValuation.valuationDate : valuationDate,
		value: propertyValuation.$assignedFields.contains('value') ? propertyValuation.value : value,
		source: propertyValuation.$assignedFields.contains('source') ? propertyValuation.source : source,
		confidence: propertyValuation.$assignedFields.contains('confidence') ? propertyValuation.confidence : confidence,
		property: propertyValuation.$assignedFields.contains('property') ? propertyValuation.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PropertyValuation updateWithInstanceValues(PropertyValuation propertyValuation) {
        if (propertyValuation.$assignedFields.contains('id')) { id = propertyValuation.id; }
		if (propertyValuation.$assignedFields.contains('propertyId')) { propertyId = propertyValuation.propertyId; }
		if (propertyValuation.$assignedFields.contains('valuationDate')) { valuationDate = propertyValuation.valuationDate; }
		if (propertyValuation.$assignedFields.contains('value')) { value = propertyValuation.value; }
		if (propertyValuation.$assignedFields.contains('source')) { source = propertyValuation.source; }
		if (propertyValuation.$assignedFields.contains('confidence')) { confidence = propertyValuation.confidence; }
		if (propertyValuation.$assignedFields.contains('property')) { property = propertyValuation.property; }
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
          ? {...?serializedTypes, 'PropertyValuation'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(propertyId != null) 'propertyId': propertyId,
	if(valuationDate != null) 'valuationDate': valuationDate?.toIso8601String(),
	if(value != null) 'value': value,
	if(source != null) 'source': source,
	if(confidence != null) 'confidence': confidence,
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PropertyValuation &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    