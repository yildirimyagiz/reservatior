
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';


class PropertyDocument implements PrismaModel<String, PropertyDocument> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? title;
	String? fileName;
	String? mimeType;
	int? sizeBytes;
	String? storageKey;
	String? category;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PropertyDocument({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.title,
	 this.fileName,
	 this.mimeType,
	 this.sizeBytes,
	 this.storageKey,
	 this.category,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PropertyDocument, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"title": (m) => m.title,

	"fileName": (m) => m.fileName,

	"mimeType": (m) => m.mimeType,

	"sizeBytes": (m) => m.sizeBytes,

	"storageKey": (m) => m.storageKey,

	"category": (m) => m.category,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PropertyDocument) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PropertyDocument');
    }
    return propFunction as V? Function(PropertyDocument);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PropertyDocument.fromJson(JsonMap json) =>
      PropertyDocument(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	title: json['title'] as String?,
	fileName: json['fileName'] as String?,
	mimeType: json['mimeType'] as String?,
	sizeBytes: int.tryParse(json['sizeBytes'].toString()),
	storageKey: json['storageKey'] as String?,
	category: json['category'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PropertyDocument copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? title,
		Value<String?>? fileName,
		Value<String?>? mimeType,
		Value<int?>? sizeBytes,
		Value<String?>? storageKey,
		Value<String?>? category,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return PropertyDocument(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		title: title != null ? title.value : this.title,
		fileName: fileName != null ? fileName.value : this.fileName,
		mimeType: mimeType != null ? mimeType.value : this.mimeType,
		sizeBytes: sizeBytes != null ? sizeBytes.value : this.sizeBytes,
		storageKey: storageKey != null ? storageKey.value : this.storageKey,
		category: category != null ? category.value : this.category,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PropertyDocument copyWithInstanceValues(PropertyDocument propertyDocument) {
        return PropertyDocument(
            id: propertyDocument.id ?? id,
		orgId: propertyDocument.orgId ?? orgId,
		propertyId: propertyDocument.propertyId ?? propertyId,
		title: propertyDocument.title ?? title,
		fileName: propertyDocument.fileName ?? fileName,
		mimeType: propertyDocument.mimeType ?? mimeType,
		sizeBytes: propertyDocument.sizeBytes ?? sizeBytes,
		storageKey: propertyDocument.storageKey ?? storageKey,
		category: propertyDocument.category ?? category,
		createdAt: propertyDocument.createdAt ?? createdAt,
		updatedAt: propertyDocument.updatedAt ?? updatedAt,
		deletedAt: propertyDocument.deletedAt ?? deletedAt,
		org: propertyDocument.org ?? org,
		property: propertyDocument.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PropertyDocument mergeWithInstanceValues(PropertyDocument propertyDocument) {
        return PropertyDocument(
            id: propertyDocument.$assignedFields.contains('id') ? propertyDocument.id : id,
		orgId: propertyDocument.$assignedFields.contains('orgId') ? propertyDocument.orgId : orgId,
		propertyId: propertyDocument.$assignedFields.contains('propertyId') ? propertyDocument.propertyId : propertyId,
		title: propertyDocument.$assignedFields.contains('title') ? propertyDocument.title : title,
		fileName: propertyDocument.$assignedFields.contains('fileName') ? propertyDocument.fileName : fileName,
		mimeType: propertyDocument.$assignedFields.contains('mimeType') ? propertyDocument.mimeType : mimeType,
		sizeBytes: propertyDocument.$assignedFields.contains('sizeBytes') ? propertyDocument.sizeBytes : sizeBytes,
		storageKey: propertyDocument.$assignedFields.contains('storageKey') ? propertyDocument.storageKey : storageKey,
		category: propertyDocument.$assignedFields.contains('category') ? propertyDocument.category : category,
		createdAt: propertyDocument.$assignedFields.contains('createdAt') ? propertyDocument.createdAt : createdAt,
		updatedAt: propertyDocument.$assignedFields.contains('updatedAt') ? propertyDocument.updatedAt : updatedAt,
		deletedAt: propertyDocument.$assignedFields.contains('deletedAt') ? propertyDocument.deletedAt : deletedAt,
		org: propertyDocument.$assignedFields.contains('org') ? propertyDocument.org : org,
		property: propertyDocument.$assignedFields.contains('property') ? propertyDocument.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PropertyDocument updateWithInstanceValues(PropertyDocument propertyDocument) {
        if (propertyDocument.$assignedFields.contains('id')) { id = propertyDocument.id; }
		if (propertyDocument.$assignedFields.contains('orgId')) { orgId = propertyDocument.orgId; }
		if (propertyDocument.$assignedFields.contains('propertyId')) { propertyId = propertyDocument.propertyId; }
		if (propertyDocument.$assignedFields.contains('title')) { title = propertyDocument.title; }
		if (propertyDocument.$assignedFields.contains('fileName')) { fileName = propertyDocument.fileName; }
		if (propertyDocument.$assignedFields.contains('mimeType')) { mimeType = propertyDocument.mimeType; }
		if (propertyDocument.$assignedFields.contains('sizeBytes')) { sizeBytes = propertyDocument.sizeBytes; }
		if (propertyDocument.$assignedFields.contains('storageKey')) { storageKey = propertyDocument.storageKey; }
		if (propertyDocument.$assignedFields.contains('category')) { category = propertyDocument.category; }
		if (propertyDocument.$assignedFields.contains('createdAt')) { createdAt = propertyDocument.createdAt; }
		if (propertyDocument.$assignedFields.contains('updatedAt')) { updatedAt = propertyDocument.updatedAt; }
		if (propertyDocument.$assignedFields.contains('deletedAt')) { deletedAt = propertyDocument.deletedAt; }
		if (propertyDocument.$assignedFields.contains('org')) { org = propertyDocument.org; }
		if (propertyDocument.$assignedFields.contains('property')) { property = propertyDocument.property; }
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
          ? {...?serializedTypes, 'PropertyDocument'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(title != null) 'title': title,
	if(fileName != null) 'fileName': fileName,
	if(mimeType != null) 'mimeType': mimeType,
	if(sizeBytes != null) 'sizeBytes': sizeBytes,
	if(storageKey != null) 'storageKey': storageKey,
	if(category != null) 'category': category,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PropertyDocument &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    