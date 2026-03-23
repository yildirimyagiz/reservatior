
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';


class HomeInformationPack implements PrismaModel<String, HomeInformationPack> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? title;
	String? description;
	String? fileUrl;
	String? fileName;
	int? fileSize;
	String? mimeType;
	String? checksum;
	int? version;
	bool? isActive;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    HomeInformationPack({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.title,
	 this.description,
	 this.fileUrl,
	 this.fileName,
	 this.fileSize,
	 this.mimeType,
	 this.checksum,
	 this.version = 1,
	 this.isActive = true,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<HomeInformationPack, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"title": (m) => m.title,

	"description": (m) => m.description,

	"fileUrl": (m) => m.fileUrl,

	"fileName": (m) => m.fileName,

	"fileSize": (m) => m.fileSize,

	"mimeType": (m) => m.mimeType,

	"checksum": (m) => m.checksum,

	"version": (m) => m.version,

	"isActive": (m) => m.isActive,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(HomeInformationPack) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in HomeInformationPack');
    }
    return propFunction as V? Function(HomeInformationPack);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory HomeInformationPack.fromJson(JsonMap json) =>
      HomeInformationPack(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	title: json['title'] as String?,
	description: json['description'] as String?,
	fileUrl: json['fileUrl'] as String?,
	fileName: json['fileName'] as String?,
	fileSize: int.tryParse(json['fileSize'].toString()),
	mimeType: json['mimeType'] as String?,
	checksum: json['checksum'] as String?,
	version: int.tryParse(json['version'].toString()),
	isActive: json['isActive'] as bool?,
	createdBy: json['createdBy'] as String?,
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
    HomeInformationPack copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? title,
		Value<String?>? description,
		Value<String?>? fileUrl,
		Value<String?>? fileName,
		Value<int?>? fileSize,
		Value<String?>? mimeType,
		Value<String?>? checksum,
		Value<int?>? version,
		Value<bool?>? isActive,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return HomeInformationPack(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		title: title != null ? title.value : this.title,
		description: description != null ? description.value : this.description,
		fileUrl: fileUrl != null ? fileUrl.value : this.fileUrl,
		fileName: fileName != null ? fileName.value : this.fileName,
		fileSize: fileSize != null ? fileSize.value : this.fileSize,
		mimeType: mimeType != null ? mimeType.value : this.mimeType,
		checksum: checksum != null ? checksum.value : this.checksum,
		version: version != null ? version.value : this.version,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
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
    HomeInformationPack copyWithInstanceValues(HomeInformationPack homeInformationPack) {
        return HomeInformationPack(
            id: homeInformationPack.id ?? id,
		orgId: homeInformationPack.orgId ?? orgId,
		propertyId: homeInformationPack.propertyId ?? propertyId,
		title: homeInformationPack.title ?? title,
		description: homeInformationPack.description ?? description,
		fileUrl: homeInformationPack.fileUrl ?? fileUrl,
		fileName: homeInformationPack.fileName ?? fileName,
		fileSize: homeInformationPack.fileSize ?? fileSize,
		mimeType: homeInformationPack.mimeType ?? mimeType,
		checksum: homeInformationPack.checksum ?? checksum,
		version: homeInformationPack.version ?? version,
		isActive: homeInformationPack.isActive ?? isActive,
		createdBy: homeInformationPack.createdBy ?? createdBy,
		createdAt: homeInformationPack.createdAt ?? createdAt,
		updatedAt: homeInformationPack.updatedAt ?? updatedAt,
		deletedAt: homeInformationPack.deletedAt ?? deletedAt,
		org: homeInformationPack.org ?? org,
		property: homeInformationPack.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    HomeInformationPack mergeWithInstanceValues(HomeInformationPack homeInformationPack) {
        return HomeInformationPack(
            id: homeInformationPack.$assignedFields.contains('id') ? homeInformationPack.id : id,
		orgId: homeInformationPack.$assignedFields.contains('orgId') ? homeInformationPack.orgId : orgId,
		propertyId: homeInformationPack.$assignedFields.contains('propertyId') ? homeInformationPack.propertyId : propertyId,
		title: homeInformationPack.$assignedFields.contains('title') ? homeInformationPack.title : title,
		description: homeInformationPack.$assignedFields.contains('description') ? homeInformationPack.description : description,
		fileUrl: homeInformationPack.$assignedFields.contains('fileUrl') ? homeInformationPack.fileUrl : fileUrl,
		fileName: homeInformationPack.$assignedFields.contains('fileName') ? homeInformationPack.fileName : fileName,
		fileSize: homeInformationPack.$assignedFields.contains('fileSize') ? homeInformationPack.fileSize : fileSize,
		mimeType: homeInformationPack.$assignedFields.contains('mimeType') ? homeInformationPack.mimeType : mimeType,
		checksum: homeInformationPack.$assignedFields.contains('checksum') ? homeInformationPack.checksum : checksum,
		version: homeInformationPack.$assignedFields.contains('version') ? homeInformationPack.version : version,
		isActive: homeInformationPack.$assignedFields.contains('isActive') ? homeInformationPack.isActive : isActive,
		createdBy: homeInformationPack.$assignedFields.contains('createdBy') ? homeInformationPack.createdBy : createdBy,
		createdAt: homeInformationPack.$assignedFields.contains('createdAt') ? homeInformationPack.createdAt : createdAt,
		updatedAt: homeInformationPack.$assignedFields.contains('updatedAt') ? homeInformationPack.updatedAt : updatedAt,
		deletedAt: homeInformationPack.$assignedFields.contains('deletedAt') ? homeInformationPack.deletedAt : deletedAt,
		org: homeInformationPack.$assignedFields.contains('org') ? homeInformationPack.org : org,
		property: homeInformationPack.$assignedFields.contains('property') ? homeInformationPack.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    HomeInformationPack updateWithInstanceValues(HomeInformationPack homeInformationPack) {
        if (homeInformationPack.$assignedFields.contains('id')) { id = homeInformationPack.id; }
		if (homeInformationPack.$assignedFields.contains('orgId')) { orgId = homeInformationPack.orgId; }
		if (homeInformationPack.$assignedFields.contains('propertyId')) { propertyId = homeInformationPack.propertyId; }
		if (homeInformationPack.$assignedFields.contains('title')) { title = homeInformationPack.title; }
		if (homeInformationPack.$assignedFields.contains('description')) { description = homeInformationPack.description; }
		if (homeInformationPack.$assignedFields.contains('fileUrl')) { fileUrl = homeInformationPack.fileUrl; }
		if (homeInformationPack.$assignedFields.contains('fileName')) { fileName = homeInformationPack.fileName; }
		if (homeInformationPack.$assignedFields.contains('fileSize')) { fileSize = homeInformationPack.fileSize; }
		if (homeInformationPack.$assignedFields.contains('mimeType')) { mimeType = homeInformationPack.mimeType; }
		if (homeInformationPack.$assignedFields.contains('checksum')) { checksum = homeInformationPack.checksum; }
		if (homeInformationPack.$assignedFields.contains('version')) { version = homeInformationPack.version; }
		if (homeInformationPack.$assignedFields.contains('isActive')) { isActive = homeInformationPack.isActive; }
		if (homeInformationPack.$assignedFields.contains('createdBy')) { createdBy = homeInformationPack.createdBy; }
		if (homeInformationPack.$assignedFields.contains('createdAt')) { createdAt = homeInformationPack.createdAt; }
		if (homeInformationPack.$assignedFields.contains('updatedAt')) { updatedAt = homeInformationPack.updatedAt; }
		if (homeInformationPack.$assignedFields.contains('deletedAt')) { deletedAt = homeInformationPack.deletedAt; }
		if (homeInformationPack.$assignedFields.contains('org')) { org = homeInformationPack.org; }
		if (homeInformationPack.$assignedFields.contains('property')) { property = homeInformationPack.property; }
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
          ? {...?serializedTypes, 'HomeInformationPack'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(title != null) 'title': title,
	if(description != null) 'description': description,
	if(fileUrl != null) 'fileUrl': fileUrl,
	if(fileName != null) 'fileName': fileName,
	if(fileSize != null) 'fileSize': fileSize,
	if(mimeType != null) 'mimeType': mimeType,
	if(checksum != null) 'checksum': checksum,
	if(version != null) 'version': version,
	if(isActive != null) 'isActive': isActive,
	if(createdBy != null) 'createdBy': createdBy,
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
            identical(this, other) || other is HomeInformationPack &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    