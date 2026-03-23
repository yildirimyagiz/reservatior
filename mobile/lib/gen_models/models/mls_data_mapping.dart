
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'm_l_s_provider_key.dart';
import 'organization.dart';


class MlsDataMapping implements PrismaModel<String, MlsDataMapping> , Id<String> {
    @override
String? id;
	String? orgId;
	MLSProviderKey? mlsProvider;
	String? fieldName;
	String? standardField;
	String? dataType;
	bool? isRequired;
	dynamic transformRule;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MlsDataMapping({ this.id,
	 this.orgId,
	 this.mlsProvider,
	 this.fieldName,
	 this.standardField,
	 this.dataType,
	 this.isRequired = false,
	required this.transformRule,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MlsDataMapping, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"mlsProvider": (m) => m.mlsProvider,

	"fieldName": (m) => m.fieldName,

	"standardField": (m) => m.standardField,

	"dataType": (m) => m.dataType,

	"isRequired": (m) => m.isRequired,

	"transformRule": (m) => m.transformRule,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MlsDataMapping) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MlsDataMapping');
    }
    return propFunction as V? Function(MlsDataMapping);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MlsDataMapping.fromJson(JsonMap json) =>
      MlsDataMapping(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	mlsProvider: json['mlsProvider'] != null ? MLSProviderKey.fromJson(json['mlsProvider']) : null,
	fieldName: json['fieldName'] as String?,
	standardField: json['standardField'] as String?,
	dataType: json['dataType'] as String?,
	isRequired: json['isRequired'] as bool?,
	transformRule: json['transformRule'] as dynamic,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MlsDataMapping copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<MLSProviderKey?>? mlsProvider,
		Value<String?>? fieldName,
		Value<String?>? standardField,
		Value<String?>? dataType,
		Value<bool?>? isRequired,
		Value<dynamic>? transformRule,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
        }) {
        return MlsDataMapping(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		mlsProvider: mlsProvider != null ? mlsProvider.value : this.mlsProvider,
		fieldName: fieldName != null ? fieldName.value : this.fieldName,
		standardField: standardField != null ? standardField.value : this.standardField,
		dataType: dataType != null ? dataType.value : this.dataType,
		isRequired: isRequired != null ? isRequired.value : this.isRequired,
		transformRule: transformRule != null ? transformRule.value : this.transformRule,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MlsDataMapping copyWithInstanceValues(MlsDataMapping mlsDataMapping) {
        return MlsDataMapping(
            id: mlsDataMapping.id ?? id,
		orgId: mlsDataMapping.orgId ?? orgId,
		mlsProvider: mlsDataMapping.mlsProvider ?? mlsProvider,
		fieldName: mlsDataMapping.fieldName ?? fieldName,
		standardField: mlsDataMapping.standardField ?? standardField,
		dataType: mlsDataMapping.dataType ?? dataType,
		isRequired: mlsDataMapping.isRequired ?? isRequired,
		transformRule: mlsDataMapping.transformRule ?? transformRule,
		createdBy: mlsDataMapping.createdBy ?? createdBy,
		createdAt: mlsDataMapping.createdAt ?? createdAt,
		updatedAt: mlsDataMapping.updatedAt ?? updatedAt,
		org: mlsDataMapping.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MlsDataMapping mergeWithInstanceValues(MlsDataMapping mlsDataMapping) {
        return MlsDataMapping(
            id: mlsDataMapping.$assignedFields.contains('id') ? mlsDataMapping.id : id,
		orgId: mlsDataMapping.$assignedFields.contains('orgId') ? mlsDataMapping.orgId : orgId,
		mlsProvider: mlsDataMapping.$assignedFields.contains('mlsProvider') ? mlsDataMapping.mlsProvider : mlsProvider,
		fieldName: mlsDataMapping.$assignedFields.contains('fieldName') ? mlsDataMapping.fieldName : fieldName,
		standardField: mlsDataMapping.$assignedFields.contains('standardField') ? mlsDataMapping.standardField : standardField,
		dataType: mlsDataMapping.$assignedFields.contains('dataType') ? mlsDataMapping.dataType : dataType,
		isRequired: mlsDataMapping.$assignedFields.contains('isRequired') ? mlsDataMapping.isRequired : isRequired,
		transformRule: mlsDataMapping.$assignedFields.contains('transformRule') ? mlsDataMapping.transformRule : transformRule,
		createdBy: mlsDataMapping.$assignedFields.contains('createdBy') ? mlsDataMapping.createdBy : createdBy,
		createdAt: mlsDataMapping.$assignedFields.contains('createdAt') ? mlsDataMapping.createdAt : createdAt,
		updatedAt: mlsDataMapping.$assignedFields.contains('updatedAt') ? mlsDataMapping.updatedAt : updatedAt,
		org: mlsDataMapping.$assignedFields.contains('org') ? mlsDataMapping.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MlsDataMapping updateWithInstanceValues(MlsDataMapping mlsDataMapping) {
        if (mlsDataMapping.$assignedFields.contains('id')) { id = mlsDataMapping.id; }
		if (mlsDataMapping.$assignedFields.contains('orgId')) { orgId = mlsDataMapping.orgId; }
		if (mlsDataMapping.$assignedFields.contains('mlsProvider')) { mlsProvider = mlsDataMapping.mlsProvider; }
		if (mlsDataMapping.$assignedFields.contains('fieldName')) { fieldName = mlsDataMapping.fieldName; }
		if (mlsDataMapping.$assignedFields.contains('standardField')) { standardField = mlsDataMapping.standardField; }
		if (mlsDataMapping.$assignedFields.contains('dataType')) { dataType = mlsDataMapping.dataType; }
		if (mlsDataMapping.$assignedFields.contains('isRequired')) { isRequired = mlsDataMapping.isRequired; }
		if (mlsDataMapping.$assignedFields.contains('transformRule')) { transformRule = mlsDataMapping.transformRule; }
		if (mlsDataMapping.$assignedFields.contains('createdBy')) { createdBy = mlsDataMapping.createdBy; }
		if (mlsDataMapping.$assignedFields.contains('createdAt')) { createdAt = mlsDataMapping.createdAt; }
		if (mlsDataMapping.$assignedFields.contains('updatedAt')) { updatedAt = mlsDataMapping.updatedAt; }
		if (mlsDataMapping.$assignedFields.contains('org')) { org = mlsDataMapping.org; }
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
          ? {...?serializedTypes, 'MlsDataMapping'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(mlsProvider != null) 'mlsProvider': mlsProvider?.toJson(),
	if(fieldName != null) 'fieldName': fieldName,
	if(standardField != null) 'standardField': standardField,
	if(dataType != null) 'dataType': dataType,
	if(isRequired != null) 'isRequired': isRequired,
	if(transformRule != null) 'transformRule': transformRule,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MlsDataMapping &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    