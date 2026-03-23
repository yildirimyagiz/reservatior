
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'asset_type.dart';
import 'depreciation_method.dart';
import 'organization.dart';
import 'property.dart';


class TaxDepreciation implements PrismaModel<String, TaxDepreciation> , Id<String> {
    @override
String? id;
	String? propertyId;
	AssetType? assetType;
	double? costBasis;
	DepreciationMethod? depreciationMethod;
	int? usefulLife;
	double? salvageValue;
	DateTime? startDate;
	double? accumulatedDepreciation;
	String? organizationId;
	Organization? organization;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    TaxDepreciation({ this.id,
	 this.propertyId,
	 this.assetType,
	 this.costBasis,
	 this.depreciationMethod,
	 this.usefulLife,
	 this.salvageValue = 0,
	 this.startDate,
	 this.accumulatedDepreciation = 0,
	 this.organizationId,
	 this.organization,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<TaxDepreciation, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"propertyId": (m) => m.propertyId,

	"assetType": (m) => m.assetType,

	"costBasis": (m) => m.costBasis,

	"depreciationMethod": (m) => m.depreciationMethod,

	"usefulLife": (m) => m.usefulLife,

	"salvageValue": (m) => m.salvageValue,

	"startDate": (m) => m.startDate,

	"accumulatedDepreciation": (m) => m.accumulatedDepreciation,

	"organizationId": (m) => m.organizationId,

	"organization": (m) => m.organization,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(TaxDepreciation) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in TaxDepreciation');
    }
    return propFunction as V? Function(TaxDepreciation);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory TaxDepreciation.fromJson(JsonMap json) =>
      TaxDepreciation(
        id: json['id'] as String?,
	propertyId: json['propertyId'] as String?,
	assetType: json['assetType'] != null ? AssetType.fromJson(json['assetType']) : null,
	costBasis: json['costBasis'] as double?,
	depreciationMethod: json['depreciationMethod'] != null ? DepreciationMethod.fromJson(json['depreciationMethod']) : null,
	usefulLife: int.tryParse(json['usefulLife'].toString()),
	salvageValue: json['salvageValue'] as double?,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	accumulatedDepreciation: json['accumulatedDepreciation'] as double?,
	organizationId: json['organizationId'] as String?,
	organization: json['organization'] != null ? Organization.fromJson(json['organization'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    TaxDepreciation copyWith({
        Value<String?>? id,
		Value<String?>? propertyId,
		Value<AssetType?>? assetType,
		Value<double?>? costBasis,
		Value<DepreciationMethod?>? depreciationMethod,
		Value<int?>? usefulLife,
		Value<double?>? salvageValue,
		Value<DateTime?>? startDate,
		Value<double?>? accumulatedDepreciation,
		Value<String?>? organizationId,
		Value<Organization?>? organization,
		Value<Property?>? property,
        }) {
        return TaxDepreciation(
            id: id != null ? id.value : this.id,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		assetType: assetType != null ? assetType.value : this.assetType,
		costBasis: costBasis != null ? costBasis.value : this.costBasis,
		depreciationMethod: depreciationMethod != null ? depreciationMethod.value : this.depreciationMethod,
		usefulLife: usefulLife != null ? usefulLife.value : this.usefulLife,
		salvageValue: salvageValue != null ? salvageValue.value : this.salvageValue,
		startDate: startDate != null ? startDate.value : this.startDate,
		accumulatedDepreciation: accumulatedDepreciation != null ? accumulatedDepreciation.value : this.accumulatedDepreciation,
		organizationId: organizationId != null ? organizationId.value : this.organizationId,
		organization: organization != null ? organization.value : this.organization,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    TaxDepreciation copyWithInstanceValues(TaxDepreciation taxDepreciation) {
        return TaxDepreciation(
            id: taxDepreciation.id ?? id,
		propertyId: taxDepreciation.propertyId ?? propertyId,
		assetType: taxDepreciation.assetType ?? assetType,
		costBasis: taxDepreciation.costBasis ?? costBasis,
		depreciationMethod: taxDepreciation.depreciationMethod ?? depreciationMethod,
		usefulLife: taxDepreciation.usefulLife ?? usefulLife,
		salvageValue: taxDepreciation.salvageValue ?? salvageValue,
		startDate: taxDepreciation.startDate ?? startDate,
		accumulatedDepreciation: taxDepreciation.accumulatedDepreciation ?? accumulatedDepreciation,
		organizationId: taxDepreciation.organizationId ?? organizationId,
		organization: taxDepreciation.organization ?? organization,
		property: taxDepreciation.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    TaxDepreciation mergeWithInstanceValues(TaxDepreciation taxDepreciation) {
        return TaxDepreciation(
            id: taxDepreciation.$assignedFields.contains('id') ? taxDepreciation.id : id,
		propertyId: taxDepreciation.$assignedFields.contains('propertyId') ? taxDepreciation.propertyId : propertyId,
		assetType: taxDepreciation.$assignedFields.contains('assetType') ? taxDepreciation.assetType : assetType,
		costBasis: taxDepreciation.$assignedFields.contains('costBasis') ? taxDepreciation.costBasis : costBasis,
		depreciationMethod: taxDepreciation.$assignedFields.contains('depreciationMethod') ? taxDepreciation.depreciationMethod : depreciationMethod,
		usefulLife: taxDepreciation.$assignedFields.contains('usefulLife') ? taxDepreciation.usefulLife : usefulLife,
		salvageValue: taxDepreciation.$assignedFields.contains('salvageValue') ? taxDepreciation.salvageValue : salvageValue,
		startDate: taxDepreciation.$assignedFields.contains('startDate') ? taxDepreciation.startDate : startDate,
		accumulatedDepreciation: taxDepreciation.$assignedFields.contains('accumulatedDepreciation') ? taxDepreciation.accumulatedDepreciation : accumulatedDepreciation,
		organizationId: taxDepreciation.$assignedFields.contains('organizationId') ? taxDepreciation.organizationId : organizationId,
		organization: taxDepreciation.$assignedFields.contains('organization') ? taxDepreciation.organization : organization,
		property: taxDepreciation.$assignedFields.contains('property') ? taxDepreciation.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    TaxDepreciation updateWithInstanceValues(TaxDepreciation taxDepreciation) {
        if (taxDepreciation.$assignedFields.contains('id')) { id = taxDepreciation.id; }
		if (taxDepreciation.$assignedFields.contains('propertyId')) { propertyId = taxDepreciation.propertyId; }
		if (taxDepreciation.$assignedFields.contains('assetType')) { assetType = taxDepreciation.assetType; }
		if (taxDepreciation.$assignedFields.contains('costBasis')) { costBasis = taxDepreciation.costBasis; }
		if (taxDepreciation.$assignedFields.contains('depreciationMethod')) { depreciationMethod = taxDepreciation.depreciationMethod; }
		if (taxDepreciation.$assignedFields.contains('usefulLife')) { usefulLife = taxDepreciation.usefulLife; }
		if (taxDepreciation.$assignedFields.contains('salvageValue')) { salvageValue = taxDepreciation.salvageValue; }
		if (taxDepreciation.$assignedFields.contains('startDate')) { startDate = taxDepreciation.startDate; }
		if (taxDepreciation.$assignedFields.contains('accumulatedDepreciation')) { accumulatedDepreciation = taxDepreciation.accumulatedDepreciation; }
		if (taxDepreciation.$assignedFields.contains('organizationId')) { organizationId = taxDepreciation.organizationId; }
		if (taxDepreciation.$assignedFields.contains('organization')) { organization = taxDepreciation.organization; }
		if (taxDepreciation.$assignedFields.contains('property')) { property = taxDepreciation.property; }
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
          ? {...?serializedTypes, 'TaxDepreciation'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(propertyId != null) 'propertyId': propertyId,
	if(assetType != null) 'assetType': assetType?.toJson(),
	if(costBasis != null) 'costBasis': costBasis,
	if(depreciationMethod != null) 'depreciationMethod': depreciationMethod?.toJson(),
	if(usefulLife != null) 'usefulLife': usefulLife,
	if(salvageValue != null) 'salvageValue': salvageValue,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(accumulatedDepreciation != null) 'accumulatedDepreciation': accumulatedDepreciation,
	if(organizationId != null) 'organizationId': organizationId,
	if(organization != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'organization': organization?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is TaxDepreciation &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    