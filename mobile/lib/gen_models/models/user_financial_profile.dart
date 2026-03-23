
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'region.dart';
import 'risk_tolerance.dart';
import 'recommendation_result.dart';
import 'user.dart';


class UserFinancialProfile implements PrismaModel<String, UserFinancialProfile> , Id<String> {
    @override
String? id;
	String? userId;
	Region? region;
	String? currency;
	double? monthlyIncome;
	double? monthlyObligations;
	RiskTolerance? riskTolerance;
	dynamic assumptions;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<RecommendationResult>? results;
	User? user;
	int? $resultsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    UserFinancialProfile({ this.id,
	 this.userId,
	 this.region,
	 this.currency,
	 this.monthlyIncome,
	 this.monthlyObligations,
	 this.riskTolerance = RiskTolerance.MEDIUM,
	required this.assumptions,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.results,
	 this.user,
	this.$resultsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<UserFinancialProfile, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"region": (m) => m.region,

	"currency": (m) => m.currency,

	"monthlyIncome": (m) => m.monthlyIncome,

	"monthlyObligations": (m) => m.monthlyObligations,

	"riskTolerance": (m) => m.riskTolerance,

	"assumptions": (m) => m.assumptions,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"results": (m) => m.results,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(UserFinancialProfile) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in UserFinancialProfile');
    }
    return propFunction as V? Function(UserFinancialProfile);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory UserFinancialProfile.fromJson(JsonMap json) =>
      UserFinancialProfile(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	region: json['region'] != null ? Region.fromJson(json['region']) : null,
	currency: json['currency'] as String?,
	monthlyIncome: json['monthlyIncome'] as double?,
	monthlyObligations: json['monthlyObligations'] as double?,
	riskTolerance: json['riskTolerance'] != null ? RiskTolerance.fromJson(json['riskTolerance']) : null,
	assumptions: json['assumptions'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	results: json['results'] != null ? createModels<RecommendationResult>((json['results'] as List).cast<JsonMap>(), RecommendationResult.fromJson) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
	$resultsCount: json['_count']?['results'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    UserFinancialProfile copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<Region?>? region,
		Value<String?>? currency,
		Value<double?>? monthlyIncome,
		Value<double?>? monthlyObligations,
		Value<RiskTolerance?>? riskTolerance,
		Value<dynamic>? assumptions,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<RecommendationResult>?>? results,
		Value<User?>? user,
		int? $resultsCount,
        }) {
        return UserFinancialProfile(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		region: region != null ? region.value : this.region,
		currency: currency != null ? currency.value : this.currency,
		monthlyIncome: monthlyIncome != null ? monthlyIncome.value : this.monthlyIncome,
		monthlyObligations: monthlyObligations != null ? monthlyObligations.value : this.monthlyObligations,
		riskTolerance: riskTolerance != null ? riskTolerance.value : this.riskTolerance,
		assumptions: assumptions != null ? assumptions.value : this.assumptions,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		results: results != null ? results.value : this.results,
		user: user != null ? user.value : this.user,
		$resultsCount: $resultsCount ?? this.$resultsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    UserFinancialProfile copyWithInstanceValues(UserFinancialProfile userFinancialProfile) {
        return UserFinancialProfile(
            id: userFinancialProfile.id ?? id,
		userId: userFinancialProfile.userId ?? userId,
		region: userFinancialProfile.region ?? region,
		currency: userFinancialProfile.currency ?? currency,
		monthlyIncome: userFinancialProfile.monthlyIncome ?? monthlyIncome,
		monthlyObligations: userFinancialProfile.monthlyObligations ?? monthlyObligations,
		riskTolerance: userFinancialProfile.riskTolerance ?? riskTolerance,
		assumptions: userFinancialProfile.assumptions ?? assumptions,
		createdAt: userFinancialProfile.createdAt ?? createdAt,
		updatedAt: userFinancialProfile.updatedAt ?? updatedAt,
		deletedAt: userFinancialProfile.deletedAt ?? deletedAt,
		results: userFinancialProfile.results ?? results,
		user: userFinancialProfile.user ?? user,
		$resultsCount: userFinancialProfile.$resultsCount ?? $resultsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    UserFinancialProfile mergeWithInstanceValues(UserFinancialProfile userFinancialProfile) {
        return UserFinancialProfile(
            id: userFinancialProfile.$assignedFields.contains('id') ? userFinancialProfile.id : id,
		userId: userFinancialProfile.$assignedFields.contains('userId') ? userFinancialProfile.userId : userId,
		region: userFinancialProfile.$assignedFields.contains('region') ? userFinancialProfile.region : region,
		currency: userFinancialProfile.$assignedFields.contains('currency') ? userFinancialProfile.currency : currency,
		monthlyIncome: userFinancialProfile.$assignedFields.contains('monthlyIncome') ? userFinancialProfile.monthlyIncome : monthlyIncome,
		monthlyObligations: userFinancialProfile.$assignedFields.contains('monthlyObligations') ? userFinancialProfile.monthlyObligations : monthlyObligations,
		riskTolerance: userFinancialProfile.$assignedFields.contains('riskTolerance') ? userFinancialProfile.riskTolerance : riskTolerance,
		assumptions: userFinancialProfile.$assignedFields.contains('assumptions') ? userFinancialProfile.assumptions : assumptions,
		createdAt: userFinancialProfile.$assignedFields.contains('createdAt') ? userFinancialProfile.createdAt : createdAt,
		updatedAt: userFinancialProfile.$assignedFields.contains('updatedAt') ? userFinancialProfile.updatedAt : updatedAt,
		deletedAt: userFinancialProfile.$assignedFields.contains('deletedAt') ? userFinancialProfile.deletedAt : deletedAt,
		results: (userFinancialProfile.$assignedFields.contains('results') && userFinancialProfile.results != null) ? mergeModelLists(results, userFinancialProfile.results) : results,
		user: userFinancialProfile.$assignedFields.contains('user') ? userFinancialProfile.user : user,
		$resultsCount: userFinancialProfile.$resultsCount ?? $resultsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    UserFinancialProfile updateWithInstanceValues(UserFinancialProfile userFinancialProfile) {
        if (userFinancialProfile.$assignedFields.contains('id')) { id = userFinancialProfile.id; }
		if (userFinancialProfile.$assignedFields.contains('userId')) { userId = userFinancialProfile.userId; }
		if (userFinancialProfile.$assignedFields.contains('region')) { region = userFinancialProfile.region; }
		if (userFinancialProfile.$assignedFields.contains('currency')) { currency = userFinancialProfile.currency; }
		if (userFinancialProfile.$assignedFields.contains('monthlyIncome')) { monthlyIncome = userFinancialProfile.monthlyIncome; }
		if (userFinancialProfile.$assignedFields.contains('monthlyObligations')) { monthlyObligations = userFinancialProfile.monthlyObligations; }
		if (userFinancialProfile.$assignedFields.contains('riskTolerance')) { riskTolerance = userFinancialProfile.riskTolerance; }
		if (userFinancialProfile.$assignedFields.contains('assumptions')) { assumptions = userFinancialProfile.assumptions; }
		if (userFinancialProfile.$assignedFields.contains('createdAt')) { createdAt = userFinancialProfile.createdAt; }
		if (userFinancialProfile.$assignedFields.contains('updatedAt')) { updatedAt = userFinancialProfile.updatedAt; }
		if (userFinancialProfile.$assignedFields.contains('deletedAt')) { deletedAt = userFinancialProfile.deletedAt; }
		if (userFinancialProfile.$assignedFields.contains('results') && userFinancialProfile.results != null) { results = mergeModelLists(results, userFinancialProfile.results); }
		if (userFinancialProfile.$assignedFields.contains('user')) { user = userFinancialProfile.user; }
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
          ? {...?serializedTypes, 'UserFinancialProfile'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(region != null) 'region': region?.toJson(),
	if(currency != null) 'currency': currency,
	if(monthlyIncome != null) 'monthlyIncome': monthlyIncome,
	if(monthlyObligations != null) 'monthlyObligations': monthlyObligations,
	if(riskTolerance != null) 'riskTolerance': riskTolerance?.toJson(),
	if(assumptions != null) 'assumptions': assumptions,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(results != null && (!preventCircularSerialization || !serializedModels.contains('RecommendationResult'))) 'results': results?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($resultsCount != null) '_count': { 
		if ($resultsCount != null) 'results': $resultsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is UserFinancialProfile &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    