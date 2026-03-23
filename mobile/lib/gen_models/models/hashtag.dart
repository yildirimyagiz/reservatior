
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'hashtag_type.dart';
import 'agency.dart';
import 'user.dart';
import 'post.dart';
import 'property.dart';


class Hashtag implements PrismaModel<String, Hashtag> , Id<String> {
    DateTime? deletedAt;
	@override
String? id;
	String? name;
	HashtagType? type;
	String? description;
	int? usageCount;
	List<String>? relatedTags;
	String? createdById;
	String? agencyId;
	DateTime? createdAt;
	DateTime? updatedAt;
	Agency? Agency;
	User? User;
	List<Post>? Post;
	List<Property>? Property;
	int? $relatedTagsCount;
	int? $PostCount;
	int? $PropertyCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Hashtag({ this.deletedAt,
	 this.id,
	 this.name,
	 this.type = HashtagType.GENERAL,
	 this.description,
	 this.usageCount = 1,
	 this.relatedTags,
	 this.createdById,
	 this.agencyId,
	 this.createdAt,
	 this.updatedAt,
	 this.Agency,
	 this.User,
	 this.Post,
	 this.Property,
	this.$relatedTagsCount,
	this.$PostCount,
	this.$PropertyCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Hashtag, dynamic>> propertyValueFunctionMap = {
      "deletedAt": (m) => m.deletedAt,

	"id": (m) => m.id,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"description": (m) => m.description,

	"usageCount": (m) => m.usageCount,

	"relatedTags": (m) => m.relatedTags,

	"createdById": (m) => m.createdById,

	"agencyId": (m) => m.agencyId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"Agency": (m) => m.Agency,

	"User": (m) => m.User,

	"Post": (m) => m.Post,

	"Property": (m) => m.Property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Hashtag) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Hashtag');
    }
    return propFunction as V? Function(Hashtag);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Hashtag.fromJson(JsonMap json) =>
      Hashtag(
        deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	id: json['id'] as String?,
	name: json['name'] as String?,
	type: json['type'] != null ? HashtagType.fromJson(json['type']) : null,
	description: json['description'] as String?,
	usageCount: int.tryParse(json['usageCount'].toString()),
	relatedTags: json['relatedTags'] != null ? (json['relatedTags'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	createdById: json['createdById'] as String?,
	agencyId: json['agencyId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	User: json['User'] != null ? User.fromJson(json['User'] as JsonMap) : null,
	Post: json['Post'] != null ? createModels<Post>((json['Post'] as List).cast<JsonMap>(), Post.fromJson) : null,
	Property: json['Property'] != null ? createModels<Property>((json['Property'] as List).cast<JsonMap>(), Property.fromJson) : null,
	$relatedTagsCount: json['_count']?['relatedTags'] as int?,
	$PostCount: json['_count']?['Post'] as int?,
	$PropertyCount: json['_count']?['Property'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Hashtag copyWith({
        Value<DateTime?>? deletedAt,
		Value<String?>? id,
		Value<String?>? name,
		Value<HashtagType?>? type,
		Value<String?>? description,
		Value<int?>? usageCount,
		Value<List<String>?>? relatedTags,
		Value<String?>? createdById,
		Value<String?>? agencyId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Agency?>? Agency,
		Value<User?>? User,
		Value<List<Post>?>? Post,
		Value<List<Property>?>? Property,
		int? $relatedTagsCount,
		int? $PostCount,
		int? $PropertyCount,
        }) {
        return Hashtag(
            deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		id: id != null ? id.value : this.id,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		description: description != null ? description.value : this.description,
		usageCount: usageCount != null ? usageCount.value : this.usageCount,
		relatedTags: relatedTags != null ? relatedTags.value : this.relatedTags,
		createdById: createdById != null ? createdById.value : this.createdById,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		Agency: Agency != null ? Agency.value : this.Agency,
		User: User != null ? User.value : this.User,
		Post: Post != null ? Post.value : this.Post,
		Property: Property != null ? Property.value : this.Property,
		$relatedTagsCount: $relatedTagsCount ?? this.$relatedTagsCount,
		$PostCount: $PostCount ?? this.$PostCount,
		$PropertyCount: $PropertyCount ?? this.$PropertyCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Hashtag copyWithInstanceValues(Hashtag hashtag) {
        return Hashtag(
            deletedAt: hashtag.deletedAt ?? deletedAt,
		id: hashtag.id ?? id,
		name: hashtag.name ?? name,
		type: hashtag.type ?? type,
		description: hashtag.description ?? description,
		usageCount: hashtag.usageCount ?? usageCount,
		relatedTags: hashtag.relatedTags ?? relatedTags,
		createdById: hashtag.createdById ?? createdById,
		agencyId: hashtag.agencyId ?? agencyId,
		createdAt: hashtag.createdAt ?? createdAt,
		updatedAt: hashtag.updatedAt ?? updatedAt,
		Agency: hashtag.Agency ?? Agency,
		User: hashtag.User ?? User,
		Post: hashtag.Post ?? Post,
		Property: hashtag.Property ?? Property,
		$relatedTagsCount: hashtag.$relatedTagsCount ?? $relatedTagsCount,
		$PostCount: hashtag.$PostCount ?? $PostCount,
		$PropertyCount: hashtag.$PropertyCount ?? $PropertyCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Hashtag mergeWithInstanceValues(Hashtag hashtag) {
        return Hashtag(
            deletedAt: hashtag.$assignedFields.contains('deletedAt') ? hashtag.deletedAt : deletedAt,
		id: hashtag.$assignedFields.contains('id') ? hashtag.id : id,
		name: hashtag.$assignedFields.contains('name') ? hashtag.name : name,
		type: hashtag.$assignedFields.contains('type') ? hashtag.type : type,
		description: hashtag.$assignedFields.contains('description') ? hashtag.description : description,
		usageCount: hashtag.$assignedFields.contains('usageCount') ? hashtag.usageCount : usageCount,
		relatedTags: hashtag.$assignedFields.contains('relatedTags') ? hashtag.relatedTags : relatedTags,
		createdById: hashtag.$assignedFields.contains('createdById') ? hashtag.createdById : createdById,
		agencyId: hashtag.$assignedFields.contains('agencyId') ? hashtag.agencyId : agencyId,
		createdAt: hashtag.$assignedFields.contains('createdAt') ? hashtag.createdAt : createdAt,
		updatedAt: hashtag.$assignedFields.contains('updatedAt') ? hashtag.updatedAt : updatedAt,
		Agency: hashtag.$assignedFields.contains('Agency') ? hashtag.Agency : Agency,
		User: hashtag.$assignedFields.contains('User') ? hashtag.User : User,
		Post: (hashtag.$assignedFields.contains('Post') && hashtag.Post != null) ? mergeModelLists(Post, hashtag.Post) : Post,
		Property: (hashtag.$assignedFields.contains('Property') && hashtag.Property != null) ? mergeModelLists(Property, hashtag.Property) : Property,
		$relatedTagsCount: hashtag.$relatedTagsCount ?? $relatedTagsCount,
		$PostCount: hashtag.$PostCount ?? $PostCount,
		$PropertyCount: hashtag.$PropertyCount ?? $PropertyCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Hashtag updateWithInstanceValues(Hashtag hashtag) {
        if (hashtag.$assignedFields.contains('deletedAt')) { deletedAt = hashtag.deletedAt; }
		if (hashtag.$assignedFields.contains('id')) { id = hashtag.id; }
		if (hashtag.$assignedFields.contains('name')) { name = hashtag.name; }
		if (hashtag.$assignedFields.contains('type')) { type = hashtag.type; }
		if (hashtag.$assignedFields.contains('description')) { description = hashtag.description; }
		if (hashtag.$assignedFields.contains('usageCount')) { usageCount = hashtag.usageCount; }
		if (hashtag.$assignedFields.contains('relatedTags')) { relatedTags = hashtag.relatedTags; }
		if (hashtag.$assignedFields.contains('createdById')) { createdById = hashtag.createdById; }
		if (hashtag.$assignedFields.contains('agencyId')) { agencyId = hashtag.agencyId; }
		if (hashtag.$assignedFields.contains('createdAt')) { createdAt = hashtag.createdAt; }
		if (hashtag.$assignedFields.contains('updatedAt')) { updatedAt = hashtag.updatedAt; }
		if (hashtag.$assignedFields.contains('Agency')) { Agency = hashtag.Agency; }
		if (hashtag.$assignedFields.contains('User')) { User = hashtag.User; }
		if (hashtag.$assignedFields.contains('Post') && hashtag.Post != null) { Post = mergeModelLists(Post, hashtag.Post); }
		if (hashtag.$assignedFields.contains('Property') && hashtag.Property != null) { Property = mergeModelLists(Property, hashtag.Property); }
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
          ? {...?serializedTypes, 'Hashtag'} 
          : const {};
      return {
        if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(id != null) 'id': id,
	if(name != null) 'name': name,
	if(type != null) 'type': type?.toJson(),
	if(description != null) 'description': description,
	if(usageCount != null) 'usageCount': usageCount,
	if(relatedTags != null) 'relatedTags': relatedTags,
	if(createdById != null) 'createdById': createdById,
	if(agencyId != null) 'agencyId': agencyId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(User != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'User': User?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Post != null && (!preventCircularSerialization || !serializedModels.contains('Post'))) 'Post': Post?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($relatedTagsCount != null || $PostCount != null || $PropertyCount != null) '_count': { 
		if ($relatedTagsCount != null) 'relatedTags': $relatedTagsCount, 
		if ($PostCount != null) 'Post': $PostCount, 
		if ($PropertyCount != null) 'Property': $PropertyCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Hashtag &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    