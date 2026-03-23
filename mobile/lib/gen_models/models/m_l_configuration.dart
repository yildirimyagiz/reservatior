
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';


class MLConfiguration implements PrismaModel<String, MLConfiguration> , Id<String> {
    @override
String? id;
	bool? enableAutoTagging;
	double? qualityThreshold;
	bool? enableMLFeatures;
	int? maxTagsPerImage;
	String? analysisMode;
	List<String>? allowedModels;
	dynamic customSettings;
	String? updatedBy;
	int? version;
	DateTime? createdAt;
	DateTime? updatedAt;
	int? $allowedModelsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MLConfiguration({ this.id = "singleton",
	 this.enableAutoTagging = true,
	 this.qualityThreshold = 0.75,
	 this.enableMLFeatures = true,
	 this.maxTagsPerImage = 5,
	 this.analysisMode = "standard",
	 this.allowedModels,
	required this.customSettings,
	 this.updatedBy,
	 this.version = 1,
	 this.createdAt,
	 this.updatedAt,
	this.$allowedModelsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MLConfiguration, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"enableAutoTagging": (m) => m.enableAutoTagging,

	"qualityThreshold": (m) => m.qualityThreshold,

	"enableMLFeatures": (m) => m.enableMLFeatures,

	"maxTagsPerImage": (m) => m.maxTagsPerImage,

	"analysisMode": (m) => m.analysisMode,

	"allowedModels": (m) => m.allowedModels,

	"customSettings": (m) => m.customSettings,

	"updatedBy": (m) => m.updatedBy,

	"version": (m) => m.version,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MLConfiguration) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MLConfiguration');
    }
    return propFunction as V? Function(MLConfiguration);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MLConfiguration.fromJson(JsonMap json) =>
      MLConfiguration(
        id: json['id'] as String?,
	enableAutoTagging: json['enableAutoTagging'] as bool?,
	qualityThreshold: json['qualityThreshold']?.toDouble(),
	enableMLFeatures: json['enableMLFeatures'] as bool?,
	maxTagsPerImage: int.tryParse(json['maxTagsPerImage'].toString()),
	analysisMode: json['analysisMode'] as String?,
	allowedModels: json['allowedModels'] != null ? (json['allowedModels'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	customSettings: json['customSettings'] as dynamic,
	updatedBy: json['updatedBy'] as String?,
	version: int.tryParse(json['version'].toString()),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	$allowedModelsCount: json['_count']?['allowedModels'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MLConfiguration copyWith({
        Value<String?>? id,
		Value<bool?>? enableAutoTagging,
		Value<double?>? qualityThreshold,
		Value<bool?>? enableMLFeatures,
		Value<int?>? maxTagsPerImage,
		Value<String?>? analysisMode,
		Value<List<String>?>? allowedModels,
		Value<dynamic>? customSettings,
		Value<String?>? updatedBy,
		Value<int?>? version,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		int? $allowedModelsCount,
        }) {
        return MLConfiguration(
            id: id != null ? id.value : this.id,
		enableAutoTagging: enableAutoTagging != null ? enableAutoTagging.value : this.enableAutoTagging,
		qualityThreshold: qualityThreshold != null ? qualityThreshold.value : this.qualityThreshold,
		enableMLFeatures: enableMLFeatures != null ? enableMLFeatures.value : this.enableMLFeatures,
		maxTagsPerImage: maxTagsPerImage != null ? maxTagsPerImage.value : this.maxTagsPerImage,
		analysisMode: analysisMode != null ? analysisMode.value : this.analysisMode,
		allowedModels: allowedModels != null ? allowedModels.value : this.allowedModels,
		customSettings: customSettings != null ? customSettings.value : this.customSettings,
		updatedBy: updatedBy != null ? updatedBy.value : this.updatedBy,
		version: version != null ? version.value : this.version,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		$allowedModelsCount: $allowedModelsCount ?? this.$allowedModelsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MLConfiguration copyWithInstanceValues(MLConfiguration mLConfiguration) {
        return MLConfiguration(
            id: mLConfiguration.id ?? id,
		enableAutoTagging: mLConfiguration.enableAutoTagging ?? enableAutoTagging,
		qualityThreshold: mLConfiguration.qualityThreshold ?? qualityThreshold,
		enableMLFeatures: mLConfiguration.enableMLFeatures ?? enableMLFeatures,
		maxTagsPerImage: mLConfiguration.maxTagsPerImage ?? maxTagsPerImage,
		analysisMode: mLConfiguration.analysisMode ?? analysisMode,
		allowedModels: mLConfiguration.allowedModels ?? allowedModels,
		customSettings: mLConfiguration.customSettings ?? customSettings,
		updatedBy: mLConfiguration.updatedBy ?? updatedBy,
		version: mLConfiguration.version ?? version,
		createdAt: mLConfiguration.createdAt ?? createdAt,
		updatedAt: mLConfiguration.updatedAt ?? updatedAt,
		$allowedModelsCount: mLConfiguration.$allowedModelsCount ?? $allowedModelsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MLConfiguration mergeWithInstanceValues(MLConfiguration mLConfiguration) {
        return MLConfiguration(
            id: mLConfiguration.$assignedFields.contains('id') ? mLConfiguration.id : id,
		enableAutoTagging: mLConfiguration.$assignedFields.contains('enableAutoTagging') ? mLConfiguration.enableAutoTagging : enableAutoTagging,
		qualityThreshold: mLConfiguration.$assignedFields.contains('qualityThreshold') ? mLConfiguration.qualityThreshold : qualityThreshold,
		enableMLFeatures: mLConfiguration.$assignedFields.contains('enableMLFeatures') ? mLConfiguration.enableMLFeatures : enableMLFeatures,
		maxTagsPerImage: mLConfiguration.$assignedFields.contains('maxTagsPerImage') ? mLConfiguration.maxTagsPerImage : maxTagsPerImage,
		analysisMode: mLConfiguration.$assignedFields.contains('analysisMode') ? mLConfiguration.analysisMode : analysisMode,
		allowedModels: mLConfiguration.$assignedFields.contains('allowedModels') ? mLConfiguration.allowedModels : allowedModels,
		customSettings: mLConfiguration.$assignedFields.contains('customSettings') ? mLConfiguration.customSettings : customSettings,
		updatedBy: mLConfiguration.$assignedFields.contains('updatedBy') ? mLConfiguration.updatedBy : updatedBy,
		version: mLConfiguration.$assignedFields.contains('version') ? mLConfiguration.version : version,
		createdAt: mLConfiguration.$assignedFields.contains('createdAt') ? mLConfiguration.createdAt : createdAt,
		updatedAt: mLConfiguration.$assignedFields.contains('updatedAt') ? mLConfiguration.updatedAt : updatedAt,
		$allowedModelsCount: mLConfiguration.$allowedModelsCount ?? $allowedModelsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MLConfiguration updateWithInstanceValues(MLConfiguration mLConfiguration) {
        if (mLConfiguration.$assignedFields.contains('id')) { id = mLConfiguration.id; }
		if (mLConfiguration.$assignedFields.contains('enableAutoTagging')) { enableAutoTagging = mLConfiguration.enableAutoTagging; }
		if (mLConfiguration.$assignedFields.contains('qualityThreshold')) { qualityThreshold = mLConfiguration.qualityThreshold; }
		if (mLConfiguration.$assignedFields.contains('enableMLFeatures')) { enableMLFeatures = mLConfiguration.enableMLFeatures; }
		if (mLConfiguration.$assignedFields.contains('maxTagsPerImage')) { maxTagsPerImage = mLConfiguration.maxTagsPerImage; }
		if (mLConfiguration.$assignedFields.contains('analysisMode')) { analysisMode = mLConfiguration.analysisMode; }
		if (mLConfiguration.$assignedFields.contains('allowedModels')) { allowedModels = mLConfiguration.allowedModels; }
		if (mLConfiguration.$assignedFields.contains('customSettings')) { customSettings = mLConfiguration.customSettings; }
		if (mLConfiguration.$assignedFields.contains('updatedBy')) { updatedBy = mLConfiguration.updatedBy; }
		if (mLConfiguration.$assignedFields.contains('version')) { version = mLConfiguration.version; }
		if (mLConfiguration.$assignedFields.contains('createdAt')) { createdAt = mLConfiguration.createdAt; }
		if (mLConfiguration.$assignedFields.contains('updatedAt')) { updatedAt = mLConfiguration.updatedAt; }
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
          ? {...?serializedTypes, 'MLConfiguration'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(enableAutoTagging != null) 'enableAutoTagging': enableAutoTagging,
	if(qualityThreshold != null) 'qualityThreshold': qualityThreshold,
	if(enableMLFeatures != null) 'enableMLFeatures': enableMLFeatures,
	if(maxTagsPerImage != null) 'maxTagsPerImage': maxTagsPerImage,
	if(analysisMode != null) 'analysisMode': analysisMode,
	if(allowedModels != null) 'allowedModels': allowedModels,
	if(customSettings != null) 'customSettings': customSettings,
	if(updatedBy != null) 'updatedBy': updatedBy,
	if(version != null) 'version': version,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
		if ($allowedModelsCount != null) '_count': { 
		if ($allowedModelsCount != null) 'allowedModels': $allowedModelsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MLConfiguration &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    