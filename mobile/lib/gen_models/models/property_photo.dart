
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'ai_image_analysis.dart';
import 'organization.dart';
import 'property.dart';


class PropertyPhoto implements PrismaModel<String, PropertyPhoto> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? url;
	String? caption;
	bool? isPrimary;
	int? sortOrder;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<AIImageAnalysis>? aiAnalyses;
	Organization? org;
	Property? property;
	int? $aiAnalysesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PropertyPhoto({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.url,
	 this.caption,
	 this.isPrimary = false,
	 this.sortOrder = 0,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.aiAnalyses,
	 this.org,
	 this.property,
	this.$aiAnalysesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PropertyPhoto, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"url": (m) => m.url,

	"caption": (m) => m.caption,

	"isPrimary": (m) => m.isPrimary,

	"sortOrder": (m) => m.sortOrder,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"aiAnalyses": (m) => m.aiAnalyses,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PropertyPhoto) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PropertyPhoto');
    }
    return propFunction as V? Function(PropertyPhoto);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PropertyPhoto.fromJson(JsonMap json) =>
      PropertyPhoto(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	url: json['url'] as String?,
	caption: json['caption'] as String?,
	isPrimary: json['isPrimary'] as bool?,
	sortOrder: int.tryParse(json['sortOrder'].toString()),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	aiAnalyses: json['aiAnalyses'] != null ? createModels<AIImageAnalysis>((json['aiAnalyses'] as List).cast<JsonMap>(), AIImageAnalysis.fromJson) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	$aiAnalysesCount: json['_count']?['aiAnalyses'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PropertyPhoto copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? url,
		Value<String?>? caption,
		Value<bool?>? isPrimary,
		Value<int?>? sortOrder,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<AIImageAnalysis>?>? aiAnalyses,
		Value<Organization?>? org,
		Value<Property?>? property,
		int? $aiAnalysesCount,
        }) {
        return PropertyPhoto(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		url: url != null ? url.value : this.url,
		caption: caption != null ? caption.value : this.caption,
		isPrimary: isPrimary != null ? isPrimary.value : this.isPrimary,
		sortOrder: sortOrder != null ? sortOrder.value : this.sortOrder,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		aiAnalyses: aiAnalyses != null ? aiAnalyses.value : this.aiAnalyses,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		$aiAnalysesCount: $aiAnalysesCount ?? this.$aiAnalysesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PropertyPhoto copyWithInstanceValues(PropertyPhoto propertyPhoto) {
        return PropertyPhoto(
            id: propertyPhoto.id ?? id,
		orgId: propertyPhoto.orgId ?? orgId,
		propertyId: propertyPhoto.propertyId ?? propertyId,
		url: propertyPhoto.url ?? url,
		caption: propertyPhoto.caption ?? caption,
		isPrimary: propertyPhoto.isPrimary ?? isPrimary,
		sortOrder: propertyPhoto.sortOrder ?? sortOrder,
		createdAt: propertyPhoto.createdAt ?? createdAt,
		updatedAt: propertyPhoto.updatedAt ?? updatedAt,
		deletedAt: propertyPhoto.deletedAt ?? deletedAt,
		aiAnalyses: propertyPhoto.aiAnalyses ?? aiAnalyses,
		org: propertyPhoto.org ?? org,
		property: propertyPhoto.property ?? property,
		$aiAnalysesCount: propertyPhoto.$aiAnalysesCount ?? $aiAnalysesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PropertyPhoto mergeWithInstanceValues(PropertyPhoto propertyPhoto) {
        return PropertyPhoto(
            id: propertyPhoto.$assignedFields.contains('id') ? propertyPhoto.id : id,
		orgId: propertyPhoto.$assignedFields.contains('orgId') ? propertyPhoto.orgId : orgId,
		propertyId: propertyPhoto.$assignedFields.contains('propertyId') ? propertyPhoto.propertyId : propertyId,
		url: propertyPhoto.$assignedFields.contains('url') ? propertyPhoto.url : url,
		caption: propertyPhoto.$assignedFields.contains('caption') ? propertyPhoto.caption : caption,
		isPrimary: propertyPhoto.$assignedFields.contains('isPrimary') ? propertyPhoto.isPrimary : isPrimary,
		sortOrder: propertyPhoto.$assignedFields.contains('sortOrder') ? propertyPhoto.sortOrder : sortOrder,
		createdAt: propertyPhoto.$assignedFields.contains('createdAt') ? propertyPhoto.createdAt : createdAt,
		updatedAt: propertyPhoto.$assignedFields.contains('updatedAt') ? propertyPhoto.updatedAt : updatedAt,
		deletedAt: propertyPhoto.$assignedFields.contains('deletedAt') ? propertyPhoto.deletedAt : deletedAt,
		aiAnalyses: (propertyPhoto.$assignedFields.contains('aiAnalyses') && propertyPhoto.aiAnalyses != null) ? mergeModelLists(aiAnalyses, propertyPhoto.aiAnalyses) : aiAnalyses,
		org: propertyPhoto.$assignedFields.contains('org') ? propertyPhoto.org : org,
		property: propertyPhoto.$assignedFields.contains('property') ? propertyPhoto.property : property,
		$aiAnalysesCount: propertyPhoto.$aiAnalysesCount ?? $aiAnalysesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PropertyPhoto updateWithInstanceValues(PropertyPhoto propertyPhoto) {
        if (propertyPhoto.$assignedFields.contains('id')) { id = propertyPhoto.id; }
		if (propertyPhoto.$assignedFields.contains('orgId')) { orgId = propertyPhoto.orgId; }
		if (propertyPhoto.$assignedFields.contains('propertyId')) { propertyId = propertyPhoto.propertyId; }
		if (propertyPhoto.$assignedFields.contains('url')) { url = propertyPhoto.url; }
		if (propertyPhoto.$assignedFields.contains('caption')) { caption = propertyPhoto.caption; }
		if (propertyPhoto.$assignedFields.contains('isPrimary')) { isPrimary = propertyPhoto.isPrimary; }
		if (propertyPhoto.$assignedFields.contains('sortOrder')) { sortOrder = propertyPhoto.sortOrder; }
		if (propertyPhoto.$assignedFields.contains('createdAt')) { createdAt = propertyPhoto.createdAt; }
		if (propertyPhoto.$assignedFields.contains('updatedAt')) { updatedAt = propertyPhoto.updatedAt; }
		if (propertyPhoto.$assignedFields.contains('deletedAt')) { deletedAt = propertyPhoto.deletedAt; }
		if (propertyPhoto.$assignedFields.contains('aiAnalyses') && propertyPhoto.aiAnalyses != null) { aiAnalyses = mergeModelLists(aiAnalyses, propertyPhoto.aiAnalyses); }
		if (propertyPhoto.$assignedFields.contains('org')) { org = propertyPhoto.org; }
		if (propertyPhoto.$assignedFields.contains('property')) { property = propertyPhoto.property; }
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
          ? {...?serializedTypes, 'PropertyPhoto'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(url != null) 'url': url,
	if(caption != null) 'caption': caption,
	if(isPrimary != null) 'isPrimary': isPrimary,
	if(sortOrder != null) 'sortOrder': sortOrder,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(aiAnalyses != null && (!preventCircularSerialization || !serializedModels.contains('AIImageAnalysis'))) 'aiAnalyses': aiAnalyses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($aiAnalysesCount != null) '_count': { 
		if ($aiAnalysesCount != null) 'aiAnalyses': $aiAnalysesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PropertyPhoto &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    