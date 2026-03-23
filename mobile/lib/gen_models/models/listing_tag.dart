
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'listing.dart';
import 'organization.dart';
import 'tag.dart';


class ListingTag implements PrismaModel<String, ListingTag> , Id<String> {
    @override
String? id;
	String? listingId;
	String? tagId;
	String? orgId;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Listing? listing;
	Organization? org;
	Tag? tag;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ListingTag({ this.id,
	 this.listingId,
	 this.tagId,
	 this.orgId,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.listing,
	 this.org,
	 this.tag,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ListingTag, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"listingId": (m) => m.listingId,

	"tagId": (m) => m.tagId,

	"orgId": (m) => m.orgId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"tag": (m) => m.tag,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ListingTag) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ListingTag');
    }
    return propFunction as V? Function(ListingTag);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ListingTag.fromJson(JsonMap json) =>
      ListingTag(
        id: json['id'] as String?,
	listingId: json['listingId'] as String?,
	tagId: json['tagId'] as String?,
	orgId: json['orgId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	tag: json['tag'] != null ? Tag.fromJson(json['tag'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ListingTag copyWith({
        Value<String?>? id,
		Value<String?>? listingId,
		Value<String?>? tagId,
		Value<String?>? orgId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Tag?>? tag,
        }) {
        return ListingTag(
            id: id != null ? id.value : this.id,
		listingId: listingId != null ? listingId.value : this.listingId,
		tagId: tagId != null ? tagId.value : this.tagId,
		orgId: orgId != null ? orgId.value : this.orgId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		tag: tag != null ? tag.value : this.tag
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ListingTag copyWithInstanceValues(ListingTag listingTag) {
        return ListingTag(
            id: listingTag.id ?? id,
		listingId: listingTag.listingId ?? listingId,
		tagId: listingTag.tagId ?? tagId,
		orgId: listingTag.orgId ?? orgId,
		createdAt: listingTag.createdAt ?? createdAt,
		updatedAt: listingTag.updatedAt ?? updatedAt,
		deletedAt: listingTag.deletedAt ?? deletedAt,
		listing: listingTag.listing ?? listing,
		org: listingTag.org ?? org,
		tag: listingTag.tag ?? tag
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ListingTag mergeWithInstanceValues(ListingTag listingTag) {
        return ListingTag(
            id: listingTag.$assignedFields.contains('id') ? listingTag.id : id,
		listingId: listingTag.$assignedFields.contains('listingId') ? listingTag.listingId : listingId,
		tagId: listingTag.$assignedFields.contains('tagId') ? listingTag.tagId : tagId,
		orgId: listingTag.$assignedFields.contains('orgId') ? listingTag.orgId : orgId,
		createdAt: listingTag.$assignedFields.contains('createdAt') ? listingTag.createdAt : createdAt,
		updatedAt: listingTag.$assignedFields.contains('updatedAt') ? listingTag.updatedAt : updatedAt,
		deletedAt: listingTag.$assignedFields.contains('deletedAt') ? listingTag.deletedAt : deletedAt,
		listing: listingTag.$assignedFields.contains('listing') ? listingTag.listing : listing,
		org: listingTag.$assignedFields.contains('org') ? listingTag.org : org,
		tag: listingTag.$assignedFields.contains('tag') ? listingTag.tag : tag
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ListingTag updateWithInstanceValues(ListingTag listingTag) {
        if (listingTag.$assignedFields.contains('id')) { id = listingTag.id; }
		if (listingTag.$assignedFields.contains('listingId')) { listingId = listingTag.listingId; }
		if (listingTag.$assignedFields.contains('tagId')) { tagId = listingTag.tagId; }
		if (listingTag.$assignedFields.contains('orgId')) { orgId = listingTag.orgId; }
		if (listingTag.$assignedFields.contains('createdAt')) { createdAt = listingTag.createdAt; }
		if (listingTag.$assignedFields.contains('updatedAt')) { updatedAt = listingTag.updatedAt; }
		if (listingTag.$assignedFields.contains('deletedAt')) { deletedAt = listingTag.deletedAt; }
		if (listingTag.$assignedFields.contains('listing')) { listing = listingTag.listing; }
		if (listingTag.$assignedFields.contains('org')) { org = listingTag.org; }
		if (listingTag.$assignedFields.contains('tag')) { tag = listingTag.tag; }
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
          ? {...?serializedTypes, 'ListingTag'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(listingId != null) 'listingId': listingId,
	if(tagId != null) 'tagId': tagId,
	if(orgId != null) 'orgId': orgId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(tag != null && (!preventCircularSerialization || !serializedModels.contains('Tag'))) 'tag': tag?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ListingTag &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    