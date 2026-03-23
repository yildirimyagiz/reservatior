
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'model_type.dart';
import 'organization.dart';


class PredictiveModel implements PrismaModel<String, PredictiveModel> , Id<String> {
    @override
String? id;
	String? orgId;
	ModelType? modelType;
	dynamic trainingData;
	dynamic parameters;
	double? accuracy;
	DateTime? lastTrained;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PredictiveModel({ this.id,
	 this.orgId,
	 this.modelType,
	required this.trainingData,
	required this.parameters,
	 this.accuracy,
	 this.lastTrained,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PredictiveModel, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"modelType": (m) => m.modelType,

	"trainingData": (m) => m.trainingData,

	"parameters": (m) => m.parameters,

	"accuracy": (m) => m.accuracy,

	"lastTrained": (m) => m.lastTrained,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PredictiveModel) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PredictiveModel');
    }
    return propFunction as V? Function(PredictiveModel);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PredictiveModel.fromJson(JsonMap json) =>
      PredictiveModel(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	modelType: json['modelType'] != null ? ModelType.fromJson(json['modelType']) : null,
	trainingData: json['trainingData'] as dynamic,
	parameters: json['parameters'] as dynamic,
	accuracy: json['accuracy']?.toDouble(),
	lastTrained: json['lastTrained'] != null ? DateTime.parse(json['lastTrained']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PredictiveModel copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<ModelType?>? modelType,
		Value<dynamic>? trainingData,
		Value<dynamic>? parameters,
		Value<double?>? accuracy,
		Value<DateTime?>? lastTrained,
		Value<Organization?>? org,
        }) {
        return PredictiveModel(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		modelType: modelType != null ? modelType.value : this.modelType,
		trainingData: trainingData != null ? trainingData.value : this.trainingData,
		parameters: parameters != null ? parameters.value : this.parameters,
		accuracy: accuracy != null ? accuracy.value : this.accuracy,
		lastTrained: lastTrained != null ? lastTrained.value : this.lastTrained,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PredictiveModel copyWithInstanceValues(PredictiveModel predictiveModel) {
        return PredictiveModel(
            id: predictiveModel.id ?? id,
		orgId: predictiveModel.orgId ?? orgId,
		modelType: predictiveModel.modelType ?? modelType,
		trainingData: predictiveModel.trainingData ?? trainingData,
		parameters: predictiveModel.parameters ?? parameters,
		accuracy: predictiveModel.accuracy ?? accuracy,
		lastTrained: predictiveModel.lastTrained ?? lastTrained,
		org: predictiveModel.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PredictiveModel mergeWithInstanceValues(PredictiveModel predictiveModel) {
        return PredictiveModel(
            id: predictiveModel.$assignedFields.contains('id') ? predictiveModel.id : id,
		orgId: predictiveModel.$assignedFields.contains('orgId') ? predictiveModel.orgId : orgId,
		modelType: predictiveModel.$assignedFields.contains('modelType') ? predictiveModel.modelType : modelType,
		trainingData: predictiveModel.$assignedFields.contains('trainingData') ? predictiveModel.trainingData : trainingData,
		parameters: predictiveModel.$assignedFields.contains('parameters') ? predictiveModel.parameters : parameters,
		accuracy: predictiveModel.$assignedFields.contains('accuracy') ? predictiveModel.accuracy : accuracy,
		lastTrained: predictiveModel.$assignedFields.contains('lastTrained') ? predictiveModel.lastTrained : lastTrained,
		org: predictiveModel.$assignedFields.contains('org') ? predictiveModel.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PredictiveModel updateWithInstanceValues(PredictiveModel predictiveModel) {
        if (predictiveModel.$assignedFields.contains('id')) { id = predictiveModel.id; }
		if (predictiveModel.$assignedFields.contains('orgId')) { orgId = predictiveModel.orgId; }
		if (predictiveModel.$assignedFields.contains('modelType')) { modelType = predictiveModel.modelType; }
		if (predictiveModel.$assignedFields.contains('trainingData')) { trainingData = predictiveModel.trainingData; }
		if (predictiveModel.$assignedFields.contains('parameters')) { parameters = predictiveModel.parameters; }
		if (predictiveModel.$assignedFields.contains('accuracy')) { accuracy = predictiveModel.accuracy; }
		if (predictiveModel.$assignedFields.contains('lastTrained')) { lastTrained = predictiveModel.lastTrained; }
		if (predictiveModel.$assignedFields.contains('org')) { org = predictiveModel.org; }
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
          ? {...?serializedTypes, 'PredictiveModel'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(modelType != null) 'modelType': modelType?.toJson(),
	if(trainingData != null) 'trainingData': trainingData,
	if(parameters != null) 'parameters': parameters,
	if(accuracy != null) 'accuracy': accuracy,
	if(lastTrained != null) 'lastTrained': lastTrained?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PredictiveModel &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    