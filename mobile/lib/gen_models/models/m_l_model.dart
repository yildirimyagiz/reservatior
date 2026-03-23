
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';


class MLModel implements PrismaModel<String, MLModel> , Id<String> {
    @override
String? id;
	String? modelName;
	String? modelType;
	String? version;
	double? accuracy;
	dynamic trainingData;
	String? modelPath;
	bool? isActive;
	DateTime? createdAt;
	DateTime? updatedAt;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MLModel({ this.id,
	 this.modelName,
	 this.modelType,
	 this.version,
	 this.accuracy,
	required this.trainingData,
	 this.modelPath,
	 this.isActive = true,
	 this.createdAt,
	 this.updatedAt,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MLModel, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"modelName": (m) => m.modelName,

	"modelType": (m) => m.modelType,

	"version": (m) => m.version,

	"accuracy": (m) => m.accuracy,

	"trainingData": (m) => m.trainingData,

	"modelPath": (m) => m.modelPath,

	"isActive": (m) => m.isActive,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MLModel) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MLModel');
    }
    return propFunction as V? Function(MLModel);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MLModel.fromJson(JsonMap json) =>
      MLModel(
        id: json['id'] as String?,
	modelName: json['modelName'] as String?,
	modelType: json['modelType'] as String?,
	version: json['version'] as String?,
	accuracy: json['accuracy']?.toDouble(),
	trainingData: json['trainingData'] as dynamic,
	modelPath: json['modelPath'] as String?,
	isActive: json['isActive'] as bool?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MLModel copyWith({
        Value<String?>? id,
		Value<String?>? modelName,
		Value<String?>? modelType,
		Value<String?>? version,
		Value<double?>? accuracy,
		Value<dynamic>? trainingData,
		Value<String?>? modelPath,
		Value<bool?>? isActive,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
        }) {
        return MLModel(
            id: id != null ? id.value : this.id,
		modelName: modelName != null ? modelName.value : this.modelName,
		modelType: modelType != null ? modelType.value : this.modelType,
		version: version != null ? version.value : this.version,
		accuracy: accuracy != null ? accuracy.value : this.accuracy,
		trainingData: trainingData != null ? trainingData.value : this.trainingData,
		modelPath: modelPath != null ? modelPath.value : this.modelPath,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MLModel copyWithInstanceValues(MLModel mLModel) {
        return MLModel(
            id: mLModel.id ?? id,
		modelName: mLModel.modelName ?? modelName,
		modelType: mLModel.modelType ?? modelType,
		version: mLModel.version ?? version,
		accuracy: mLModel.accuracy ?? accuracy,
		trainingData: mLModel.trainingData ?? trainingData,
		modelPath: mLModel.modelPath ?? modelPath,
		isActive: mLModel.isActive ?? isActive,
		createdAt: mLModel.createdAt ?? createdAt,
		updatedAt: mLModel.updatedAt ?? updatedAt
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MLModel mergeWithInstanceValues(MLModel mLModel) {
        return MLModel(
            id: mLModel.$assignedFields.contains('id') ? mLModel.id : id,
		modelName: mLModel.$assignedFields.contains('modelName') ? mLModel.modelName : modelName,
		modelType: mLModel.$assignedFields.contains('modelType') ? mLModel.modelType : modelType,
		version: mLModel.$assignedFields.contains('version') ? mLModel.version : version,
		accuracy: mLModel.$assignedFields.contains('accuracy') ? mLModel.accuracy : accuracy,
		trainingData: mLModel.$assignedFields.contains('trainingData') ? mLModel.trainingData : trainingData,
		modelPath: mLModel.$assignedFields.contains('modelPath') ? mLModel.modelPath : modelPath,
		isActive: mLModel.$assignedFields.contains('isActive') ? mLModel.isActive : isActive,
		createdAt: mLModel.$assignedFields.contains('createdAt') ? mLModel.createdAt : createdAt,
		updatedAt: mLModel.$assignedFields.contains('updatedAt') ? mLModel.updatedAt : updatedAt
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MLModel updateWithInstanceValues(MLModel mLModel) {
        if (mLModel.$assignedFields.contains('id')) { id = mLModel.id; }
		if (mLModel.$assignedFields.contains('modelName')) { modelName = mLModel.modelName; }
		if (mLModel.$assignedFields.contains('modelType')) { modelType = mLModel.modelType; }
		if (mLModel.$assignedFields.contains('version')) { version = mLModel.version; }
		if (mLModel.$assignedFields.contains('accuracy')) { accuracy = mLModel.accuracy; }
		if (mLModel.$assignedFields.contains('trainingData')) { trainingData = mLModel.trainingData; }
		if (mLModel.$assignedFields.contains('modelPath')) { modelPath = mLModel.modelPath; }
		if (mLModel.$assignedFields.contains('isActive')) { isActive = mLModel.isActive; }
		if (mLModel.$assignedFields.contains('createdAt')) { createdAt = mLModel.createdAt; }
		if (mLModel.$assignedFields.contains('updatedAt')) { updatedAt = mLModel.updatedAt; }
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
          ? {...?serializedTypes, 'MLModel'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(modelName != null) 'modelName': modelName,
	if(modelType != null) 'modelType': modelType,
	if(version != null) 'version': version,
	if(accuracy != null) 'accuracy': accuracy,
	if(trainingData != null) 'trainingData': trainingData,
	if(modelPath != null) 'modelPath': modelPath,
	if(isActive != null) 'isActive': isActive,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String()
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MLModel &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    