
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'attachment.dart';
import 'organization.dart';
import 'agent.dart';
import 'agency.dart';


class Review implements PrismaModel<String, Review> , Id<String> {
    @override
String? id;
	String? orgId;
	String? reviewerId;
	String? targetId;
	String? targetType;
	int? rating;
	String? title;
	String? comment;
	bool? isVerified;
	dynamic responses;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Attachment>? attachments;
	Organization? org;
	List<Agent>? agents;
	List<Agency>? agencies;
	int? $attachmentsCount;
	int? $agentsCount;
	int? $agenciesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Review({ this.id,
	 this.orgId,
	 this.reviewerId,
	 this.targetId,
	 this.targetType,
	 this.rating,
	 this.title,
	 this.comment,
	 this.isVerified = false,
	required this.responses,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.attachments,
	 this.org,
	 this.agents,
	 this.agencies,
	this.$attachmentsCount,
	this.$agentsCount,
	this.$agenciesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Review, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"reviewerId": (m) => m.reviewerId,

	"targetId": (m) => m.targetId,

	"targetType": (m) => m.targetType,

	"rating": (m) => m.rating,

	"title": (m) => m.title,

	"comment": (m) => m.comment,

	"isVerified": (m) => m.isVerified,

	"responses": (m) => m.responses,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"attachments": (m) => m.attachments,

	"org": (m) => m.org,

	"agents": (m) => m.agents,

	"agencies": (m) => m.agencies,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Review) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Review');
    }
    return propFunction as V? Function(Review);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Review.fromJson(JsonMap json) =>
      Review(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	reviewerId: json['reviewerId'] as String?,
	targetId: json['targetId'] as String?,
	targetType: json['targetType'] as String?,
	rating: int.tryParse(json['rating'].toString()),
	title: json['title'] as String?,
	comment: json['comment'] as String?,
	isVerified: json['isVerified'] as bool?,
	responses: json['responses'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	attachments: json['attachments'] != null ? createModels<Attachment>((json['attachments'] as List).cast<JsonMap>(), Attachment.fromJson) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	agents: json['agents'] != null ? createModels<Agent>((json['agents'] as List).cast<JsonMap>(), Agent.fromJson) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	$attachmentsCount: json['_count']?['attachments'] as int?,
	$agentsCount: json['_count']?['agents'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Review copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? reviewerId,
		Value<String?>? targetId,
		Value<String?>? targetType,
		Value<int?>? rating,
		Value<String?>? title,
		Value<String?>? comment,
		Value<bool?>? isVerified,
		Value<dynamic>? responses,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Attachment>?>? attachments,
		Value<Organization?>? org,
		Value<List<Agent>?>? agents,
		Value<List<Agency>?>? agencies,
		int? $attachmentsCount,
		int? $agentsCount,
		int? $agenciesCount,
        }) {
        return Review(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		reviewerId: reviewerId != null ? reviewerId.value : this.reviewerId,
		targetId: targetId != null ? targetId.value : this.targetId,
		targetType: targetType != null ? targetType.value : this.targetType,
		rating: rating != null ? rating.value : this.rating,
		title: title != null ? title.value : this.title,
		comment: comment != null ? comment.value : this.comment,
		isVerified: isVerified != null ? isVerified.value : this.isVerified,
		responses: responses != null ? responses.value : this.responses,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		attachments: attachments != null ? attachments.value : this.attachments,
		org: org != null ? org.value : this.org,
		agents: agents != null ? agents.value : this.agents,
		agencies: agencies != null ? agencies.value : this.agencies,
		$attachmentsCount: $attachmentsCount ?? this.$attachmentsCount,
		$agentsCount: $agentsCount ?? this.$agentsCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Review copyWithInstanceValues(Review review) {
        return Review(
            id: review.id ?? id,
		orgId: review.orgId ?? orgId,
		reviewerId: review.reviewerId ?? reviewerId,
		targetId: review.targetId ?? targetId,
		targetType: review.targetType ?? targetType,
		rating: review.rating ?? rating,
		title: review.title ?? title,
		comment: review.comment ?? comment,
		isVerified: review.isVerified ?? isVerified,
		responses: review.responses ?? responses,
		createdAt: review.createdAt ?? createdAt,
		updatedAt: review.updatedAt ?? updatedAt,
		deletedAt: review.deletedAt ?? deletedAt,
		attachments: review.attachments ?? attachments,
		org: review.org ?? org,
		agents: review.agents ?? agents,
		agencies: review.agencies ?? agencies,
		$attachmentsCount: review.$attachmentsCount ?? $attachmentsCount,
		$agentsCount: review.$agentsCount ?? $agentsCount,
		$agenciesCount: review.$agenciesCount ?? $agenciesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Review mergeWithInstanceValues(Review review) {
        return Review(
            id: review.$assignedFields.contains('id') ? review.id : id,
		orgId: review.$assignedFields.contains('orgId') ? review.orgId : orgId,
		reviewerId: review.$assignedFields.contains('reviewerId') ? review.reviewerId : reviewerId,
		targetId: review.$assignedFields.contains('targetId') ? review.targetId : targetId,
		targetType: review.$assignedFields.contains('targetType') ? review.targetType : targetType,
		rating: review.$assignedFields.contains('rating') ? review.rating : rating,
		title: review.$assignedFields.contains('title') ? review.title : title,
		comment: review.$assignedFields.contains('comment') ? review.comment : comment,
		isVerified: review.$assignedFields.contains('isVerified') ? review.isVerified : isVerified,
		responses: review.$assignedFields.contains('responses') ? review.responses : responses,
		createdAt: review.$assignedFields.contains('createdAt') ? review.createdAt : createdAt,
		updatedAt: review.$assignedFields.contains('updatedAt') ? review.updatedAt : updatedAt,
		deletedAt: review.$assignedFields.contains('deletedAt') ? review.deletedAt : deletedAt,
		attachments: (review.$assignedFields.contains('attachments') && review.attachments != null) ? mergeModelLists(attachments, review.attachments) : attachments,
		org: review.$assignedFields.contains('org') ? review.org : org,
		agents: (review.$assignedFields.contains('agents') && review.agents != null) ? mergeModelLists(agents, review.agents) : agents,
		agencies: (review.$assignedFields.contains('agencies') && review.agencies != null) ? mergeModelLists(agencies, review.agencies) : agencies,
		$attachmentsCount: review.$attachmentsCount ?? $attachmentsCount,
		$agentsCount: review.$agentsCount ?? $agentsCount,
		$agenciesCount: review.$agenciesCount ?? $agenciesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Review updateWithInstanceValues(Review review) {
        if (review.$assignedFields.contains('id')) { id = review.id; }
		if (review.$assignedFields.contains('orgId')) { orgId = review.orgId; }
		if (review.$assignedFields.contains('reviewerId')) { reviewerId = review.reviewerId; }
		if (review.$assignedFields.contains('targetId')) { targetId = review.targetId; }
		if (review.$assignedFields.contains('targetType')) { targetType = review.targetType; }
		if (review.$assignedFields.contains('rating')) { rating = review.rating; }
		if (review.$assignedFields.contains('title')) { title = review.title; }
		if (review.$assignedFields.contains('comment')) { comment = review.comment; }
		if (review.$assignedFields.contains('isVerified')) { isVerified = review.isVerified; }
		if (review.$assignedFields.contains('responses')) { responses = review.responses; }
		if (review.$assignedFields.contains('createdAt')) { createdAt = review.createdAt; }
		if (review.$assignedFields.contains('updatedAt')) { updatedAt = review.updatedAt; }
		if (review.$assignedFields.contains('deletedAt')) { deletedAt = review.deletedAt; }
		if (review.$assignedFields.contains('attachments') && review.attachments != null) { attachments = mergeModelLists(attachments, review.attachments); }
		if (review.$assignedFields.contains('org')) { org = review.org; }
		if (review.$assignedFields.contains('agents') && review.agents != null) { agents = mergeModelLists(agents, review.agents); }
		if (review.$assignedFields.contains('agencies') && review.agencies != null) { agencies = mergeModelLists(agencies, review.agencies); }
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
          ? {...?serializedTypes, 'Review'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(reviewerId != null) 'reviewerId': reviewerId,
	if(targetId != null) 'targetId': targetId,
	if(targetType != null) 'targetType': targetType,
	if(rating != null) 'rating': rating,
	if(title != null) 'title': title,
	if(comment != null) 'comment': comment,
	if(isVerified != null) 'isVerified': isVerified,
	if(responses != null) 'responses': responses,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(attachments != null && (!preventCircularSerialization || !serializedModels.contains('Attachment'))) 'attachments': attachments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(agents != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'agents': agents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($attachmentsCount != null || $agentsCount != null || $agenciesCount != null) '_count': { 
		if ($attachmentsCount != null) 'attachments': $attachmentsCount, 
		if ($agentsCount != null) 'agents': $agentsCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Review &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    