
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'user_financial_profile.dart';


class RecommendationResult implements PrismaModel<String, RecommendationResult> , Id<String> {
    @override
String? id;
	String? profileId;
	String? orgId;
	String? listingId;
	int? score;
	String? explanation;
	dynamic breakdown;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	UserFinancialProfile? profile;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    RecommendationResult({ this.id,
	 this.profileId,
	 this.orgId,
	 this.listingId,
	 this.score,
	 this.explanation,
	required this.breakdown,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.profile,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<RecommendationResult, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"profileId": (m) => m.profileId,

	"orgId": (m) => m.orgId,

	"listingId": (m) => m.listingId,

	"score": (m) => m.score,

	"explanation": (m) => m.explanation,

	"breakdown": (m) => m.breakdown,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"profile": (m) => m.profile,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(RecommendationResult) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in RecommendationResult');
    }
    return propFunction as V? Function(RecommendationResult);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory RecommendationResult.fromJson(JsonMap json) =>
      RecommendationResult(
        id: json['id'] as String?,
	profileId: json['profileId'] as String?,
	orgId: json['orgId'] as String?,
	listingId: json['listingId'] as String?,
	score: int.tryParse(json['score'].toString()),
	explanation: json['explanation'] as String?,
	breakdown: json['breakdown'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	profile: json['profile'] != null ? UserFinancialProfile.fromJson(json['profile'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    RecommendationResult copyWith({
        Value<String?>? id,
		Value<String?>? profileId,
		Value<String?>? orgId,
		Value<String?>? listingId,
		Value<int?>? score,
		Value<String?>? explanation,
		Value<dynamic>? breakdown,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<UserFinancialProfile?>? profile,
        }) {
        return RecommendationResult(
            id: id != null ? id.value : this.id,
		profileId: profileId != null ? profileId.value : this.profileId,
		orgId: orgId != null ? orgId.value : this.orgId,
		listingId: listingId != null ? listingId.value : this.listingId,
		score: score != null ? score.value : this.score,
		explanation: explanation != null ? explanation.value : this.explanation,
		breakdown: breakdown != null ? breakdown.value : this.breakdown,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		profile: profile != null ? profile.value : this.profile
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    RecommendationResult copyWithInstanceValues(RecommendationResult recommendationResult) {
        return RecommendationResult(
            id: recommendationResult.id ?? id,
		profileId: recommendationResult.profileId ?? profileId,
		orgId: recommendationResult.orgId ?? orgId,
		listingId: recommendationResult.listingId ?? listingId,
		score: recommendationResult.score ?? score,
		explanation: recommendationResult.explanation ?? explanation,
		breakdown: recommendationResult.breakdown ?? breakdown,
		createdAt: recommendationResult.createdAt ?? createdAt,
		updatedAt: recommendationResult.updatedAt ?? updatedAt,
		deletedAt: recommendationResult.deletedAt ?? deletedAt,
		org: recommendationResult.org ?? org,
		profile: recommendationResult.profile ?? profile
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    RecommendationResult mergeWithInstanceValues(RecommendationResult recommendationResult) {
        return RecommendationResult(
            id: recommendationResult.$assignedFields.contains('id') ? recommendationResult.id : id,
		profileId: recommendationResult.$assignedFields.contains('profileId') ? recommendationResult.profileId : profileId,
		orgId: recommendationResult.$assignedFields.contains('orgId') ? recommendationResult.orgId : orgId,
		listingId: recommendationResult.$assignedFields.contains('listingId') ? recommendationResult.listingId : listingId,
		score: recommendationResult.$assignedFields.contains('score') ? recommendationResult.score : score,
		explanation: recommendationResult.$assignedFields.contains('explanation') ? recommendationResult.explanation : explanation,
		breakdown: recommendationResult.$assignedFields.contains('breakdown') ? recommendationResult.breakdown : breakdown,
		createdAt: recommendationResult.$assignedFields.contains('createdAt') ? recommendationResult.createdAt : createdAt,
		updatedAt: recommendationResult.$assignedFields.contains('updatedAt') ? recommendationResult.updatedAt : updatedAt,
		deletedAt: recommendationResult.$assignedFields.contains('deletedAt') ? recommendationResult.deletedAt : deletedAt,
		org: recommendationResult.$assignedFields.contains('org') ? recommendationResult.org : org,
		profile: recommendationResult.$assignedFields.contains('profile') ? recommendationResult.profile : profile
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    RecommendationResult updateWithInstanceValues(RecommendationResult recommendationResult) {
        if (recommendationResult.$assignedFields.contains('id')) { id = recommendationResult.id; }
		if (recommendationResult.$assignedFields.contains('profileId')) { profileId = recommendationResult.profileId; }
		if (recommendationResult.$assignedFields.contains('orgId')) { orgId = recommendationResult.orgId; }
		if (recommendationResult.$assignedFields.contains('listingId')) { listingId = recommendationResult.listingId; }
		if (recommendationResult.$assignedFields.contains('score')) { score = recommendationResult.score; }
		if (recommendationResult.$assignedFields.contains('explanation')) { explanation = recommendationResult.explanation; }
		if (recommendationResult.$assignedFields.contains('breakdown')) { breakdown = recommendationResult.breakdown; }
		if (recommendationResult.$assignedFields.contains('createdAt')) { createdAt = recommendationResult.createdAt; }
		if (recommendationResult.$assignedFields.contains('updatedAt')) { updatedAt = recommendationResult.updatedAt; }
		if (recommendationResult.$assignedFields.contains('deletedAt')) { deletedAt = recommendationResult.deletedAt; }
		if (recommendationResult.$assignedFields.contains('org')) { org = recommendationResult.org; }
		if (recommendationResult.$assignedFields.contains('profile')) { profile = recommendationResult.profile; }
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
          ? {...?serializedTypes, 'RecommendationResult'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(profileId != null) 'profileId': profileId,
	if(orgId != null) 'orgId': orgId,
	if(listingId != null) 'listingId': listingId,
	if(score != null) 'score': score,
	if(explanation != null) 'explanation': explanation,
	if(breakdown != null) 'breakdown': breakdown,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(profile != null && (!preventCircularSerialization || !serializedModels.contains('UserFinancialProfile'))) 'profile': profile?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is RecommendationResult &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    