
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'listing_tag.dart';
import 'organization.dart';


class Tag implements PrismaModel<String, Tag> , Id<String> {
    @override
String? id;
	String? orgId;
	String? name;
	String? color;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<ListingTag>? listingTags;
	Organization? org;
	int? $listingTagsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Tag({ this.id,
	 this.orgId,
	 this.name,
	 this.color,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.listingTags,
	 this.org,
	this.$listingTagsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Tag, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"color": (m) => m.color,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"listingTags": (m) => m.listingTags,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Tag) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Tag');
    }
    return propFunction as V? Function(Tag);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Tag.fromJson(JsonMap json) =>
      Tag(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	color: json['color'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	listingTags: json['listingTags'] != null ? createModels<ListingTag>((json['listingTags'] as List).cast<JsonMap>(), ListingTag.fromJson) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	$listingTagsCount: json['_count']?['listingTags'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Tag copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<String?>? color,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<ListingTag>?>? listingTags,
		Value<Organization?>? org,
		int? $listingTagsCount,
        }) {
        return Tag(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		color: color != null ? color.value : this.color,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		listingTags: listingTags != null ? listingTags.value : this.listingTags,
		org: org != null ? org.value : this.org,
		$listingTagsCount: $listingTagsCount ?? this.$listingTagsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Tag copyWithInstanceValues(Tag tag) {
        return Tag(
            id: tag.id ?? id,
		orgId: tag.orgId ?? orgId,
		name: tag.name ?? name,
		color: tag.color ?? color,
		createdAt: tag.createdAt ?? createdAt,
		updatedAt: tag.updatedAt ?? updatedAt,
		deletedAt: tag.deletedAt ?? deletedAt,
		listingTags: tag.listingTags ?? listingTags,
		org: tag.org ?? org,
		$listingTagsCount: tag.$listingTagsCount ?? $listingTagsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Tag mergeWithInstanceValues(Tag tag) {
        return Tag(
            id: tag.$assignedFields.contains('id') ? tag.id : id,
		orgId: tag.$assignedFields.contains('orgId') ? tag.orgId : orgId,
		name: tag.$assignedFields.contains('name') ? tag.name : name,
		color: tag.$assignedFields.contains('color') ? tag.color : color,
		createdAt: tag.$assignedFields.contains('createdAt') ? tag.createdAt : createdAt,
		updatedAt: tag.$assignedFields.contains('updatedAt') ? tag.updatedAt : updatedAt,
		deletedAt: tag.$assignedFields.contains('deletedAt') ? tag.deletedAt : deletedAt,
		listingTags: (tag.$assignedFields.contains('listingTags') && tag.listingTags != null) ? mergeModelLists(listingTags, tag.listingTags) : listingTags,
		org: tag.$assignedFields.contains('org') ? tag.org : org,
		$listingTagsCount: tag.$listingTagsCount ?? $listingTagsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Tag updateWithInstanceValues(Tag tag) {
        if (tag.$assignedFields.contains('id')) { id = tag.id; }
		if (tag.$assignedFields.contains('orgId')) { orgId = tag.orgId; }
		if (tag.$assignedFields.contains('name')) { name = tag.name; }
		if (tag.$assignedFields.contains('color')) { color = tag.color; }
		if (tag.$assignedFields.contains('createdAt')) { createdAt = tag.createdAt; }
		if (tag.$assignedFields.contains('updatedAt')) { updatedAt = tag.updatedAt; }
		if (tag.$assignedFields.contains('deletedAt')) { deletedAt = tag.deletedAt; }
		if (tag.$assignedFields.contains('listingTags') && tag.listingTags != null) { listingTags = mergeModelLists(listingTags, tag.listingTags); }
		if (tag.$assignedFields.contains('org')) { org = tag.org; }
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
          ? {...?serializedTypes, 'Tag'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(color != null) 'color': color,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(listingTags != null && (!preventCircularSerialization || !serializedModels.contains('ListingTag'))) 'listingTags': listingTags?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($listingTagsCount != null) '_count': { 
		if ($listingTagsCount != null) 'listingTags': $listingTagsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Tag &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    