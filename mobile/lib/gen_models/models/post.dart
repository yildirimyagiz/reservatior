
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'photo.dart';
import 'agency.dart';
import 'agent.dart';
import 'hashtag.dart';
import 'user.dart';


class Post implements PrismaModel<String, Post> , Id<String> {
    DateTime? deletedAt;
	@override
String? id;
	String? title;
	String? content;
	String? slug;
	DateTime? createdAt;
	DateTime? updatedAt;
	String? userId;
	String? agencyId;
	String? hashtagId;
	String? agentId;
	List<Photo>? Photo;
	Agency? Agency;
	Agent? Agent;
	Hashtag? Hashtag;
	User? User;
	int? $PhotoCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Post({ this.deletedAt,
	 this.id,
	 this.title,
	 this.content,
	 this.slug,
	 this.createdAt,
	 this.updatedAt,
	 this.userId,
	 this.agencyId,
	 this.hashtagId,
	 this.agentId,
	 this.Photo,
	 this.Agency,
	 this.Agent,
	 this.Hashtag,
	 this.User,
	this.$PhotoCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Post, dynamic>> propertyValueFunctionMap = {
      "deletedAt": (m) => m.deletedAt,

	"id": (m) => m.id,

	"title": (m) => m.title,

	"content": (m) => m.content,

	"slug": (m) => m.slug,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"userId": (m) => m.userId,

	"agencyId": (m) => m.agencyId,

	"hashtagId": (m) => m.hashtagId,

	"agentId": (m) => m.agentId,

	"Photo": (m) => m.Photo,

	"Agency": (m) => m.Agency,

	"Agent": (m) => m.Agent,

	"Hashtag": (m) => m.Hashtag,

	"User": (m) => m.User,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Post) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Post');
    }
    return propFunction as V? Function(Post);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Post.fromJson(JsonMap json) =>
      Post(
        deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	id: json['id'] as String?,
	title: json['title'] as String?,
	content: json['content'] as String?,
	slug: json['slug'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	userId: json['userId'] as String?,
	agencyId: json['agencyId'] as String?,
	hashtagId: json['hashtagId'] as String?,
	agentId: json['agentId'] as String?,
	Photo: json['Photo'] != null ? createModels<Photo>((json['Photo'] as List).cast<JsonMap>(), Photo.fromJson) : null,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	Agent: json['Agent'] != null ? Agent.fromJson(json['Agent'] as JsonMap) : null,
	Hashtag: json['Hashtag'] != null ? Hashtag.fromJson(json['Hashtag'] as JsonMap) : null,
	User: json['User'] != null ? User.fromJson(json['User'] as JsonMap) : null,
	$PhotoCount: json['_count']?['Photo'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Post copyWith({
        Value<DateTime?>? deletedAt,
		Value<String?>? id,
		Value<String?>? title,
		Value<String?>? content,
		Value<String?>? slug,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<String?>? userId,
		Value<String?>? agencyId,
		Value<String?>? hashtagId,
		Value<String?>? agentId,
		Value<List<Photo>?>? Photo,
		Value<Agency?>? Agency,
		Value<Agent?>? Agent,
		Value<Hashtag?>? Hashtag,
		Value<User?>? User,
		int? $PhotoCount,
        }) {
        return Post(
            deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		id: id != null ? id.value : this.id,
		title: title != null ? title.value : this.title,
		content: content != null ? content.value : this.content,
		slug: slug != null ? slug.value : this.slug,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		userId: userId != null ? userId.value : this.userId,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		hashtagId: hashtagId != null ? hashtagId.value : this.hashtagId,
		agentId: agentId != null ? agentId.value : this.agentId,
		Photo: Photo != null ? Photo.value : this.Photo,
		Agency: Agency != null ? Agency.value : this.Agency,
		Agent: Agent != null ? Agent.value : this.Agent,
		Hashtag: Hashtag != null ? Hashtag.value : this.Hashtag,
		User: User != null ? User.value : this.User,
		$PhotoCount: $PhotoCount ?? this.$PhotoCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Post copyWithInstanceValues(Post post) {
        return Post(
            deletedAt: post.deletedAt ?? deletedAt,
		id: post.id ?? id,
		title: post.title ?? title,
		content: post.content ?? content,
		slug: post.slug ?? slug,
		createdAt: post.createdAt ?? createdAt,
		updatedAt: post.updatedAt ?? updatedAt,
		userId: post.userId ?? userId,
		agencyId: post.agencyId ?? agencyId,
		hashtagId: post.hashtagId ?? hashtagId,
		agentId: post.agentId ?? agentId,
		Photo: post.Photo ?? Photo,
		Agency: post.Agency ?? Agency,
		Agent: post.Agent ?? Agent,
		Hashtag: post.Hashtag ?? Hashtag,
		User: post.User ?? User,
		$PhotoCount: post.$PhotoCount ?? $PhotoCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Post mergeWithInstanceValues(Post post) {
        return Post(
            deletedAt: post.$assignedFields.contains('deletedAt') ? post.deletedAt : deletedAt,
		id: post.$assignedFields.contains('id') ? post.id : id,
		title: post.$assignedFields.contains('title') ? post.title : title,
		content: post.$assignedFields.contains('content') ? post.content : content,
		slug: post.$assignedFields.contains('slug') ? post.slug : slug,
		createdAt: post.$assignedFields.contains('createdAt') ? post.createdAt : createdAt,
		updatedAt: post.$assignedFields.contains('updatedAt') ? post.updatedAt : updatedAt,
		userId: post.$assignedFields.contains('userId') ? post.userId : userId,
		agencyId: post.$assignedFields.contains('agencyId') ? post.agencyId : agencyId,
		hashtagId: post.$assignedFields.contains('hashtagId') ? post.hashtagId : hashtagId,
		agentId: post.$assignedFields.contains('agentId') ? post.agentId : agentId,
		Photo: (post.$assignedFields.contains('Photo') && post.Photo != null) ? mergeModelLists(Photo, post.Photo) : Photo,
		Agency: post.$assignedFields.contains('Agency') ? post.Agency : Agency,
		Agent: post.$assignedFields.contains('Agent') ? post.Agent : Agent,
		Hashtag: post.$assignedFields.contains('Hashtag') ? post.Hashtag : Hashtag,
		User: post.$assignedFields.contains('User') ? post.User : User,
		$PhotoCount: post.$PhotoCount ?? $PhotoCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Post updateWithInstanceValues(Post post) {
        if (post.$assignedFields.contains('deletedAt')) { deletedAt = post.deletedAt; }
		if (post.$assignedFields.contains('id')) { id = post.id; }
		if (post.$assignedFields.contains('title')) { title = post.title; }
		if (post.$assignedFields.contains('content')) { content = post.content; }
		if (post.$assignedFields.contains('slug')) { slug = post.slug; }
		if (post.$assignedFields.contains('createdAt')) { createdAt = post.createdAt; }
		if (post.$assignedFields.contains('updatedAt')) { updatedAt = post.updatedAt; }
		if (post.$assignedFields.contains('userId')) { userId = post.userId; }
		if (post.$assignedFields.contains('agencyId')) { agencyId = post.agencyId; }
		if (post.$assignedFields.contains('hashtagId')) { hashtagId = post.hashtagId; }
		if (post.$assignedFields.contains('agentId')) { agentId = post.agentId; }
		if (post.$assignedFields.contains('Photo') && post.Photo != null) { Photo = mergeModelLists(Photo, post.Photo); }
		if (post.$assignedFields.contains('Agency')) { Agency = post.Agency; }
		if (post.$assignedFields.contains('Agent')) { Agent = post.Agent; }
		if (post.$assignedFields.contains('Hashtag')) { Hashtag = post.Hashtag; }
		if (post.$assignedFields.contains('User')) { User = post.User; }
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
          ? {...?serializedTypes, 'Post'} 
          : const {};
      return {
        if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(id != null) 'id': id,
	if(title != null) 'title': title,
	if(content != null) 'content': content,
	if(slug != null) 'slug': slug,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(userId != null) 'userId': userId,
	if(agencyId != null) 'agencyId': agencyId,
	if(hashtagId != null) 'hashtagId': hashtagId,
	if(agentId != null) 'agentId': agentId,
	if(Photo != null && (!preventCircularSerialization || !serializedModels.contains('Photo'))) 'Photo': Photo?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Agent != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'Agent': Agent?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Hashtag != null && (!preventCircularSerialization || !serializedModels.contains('Hashtag'))) 'Hashtag': Hashtag?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(User != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'User': User?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($PhotoCount != null) '_count': { 
		if ($PhotoCount != null) 'Photo': $PhotoCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Post &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    