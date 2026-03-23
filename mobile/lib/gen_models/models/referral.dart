
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'user.dart';


class Referral implements PrismaModel<String, Referral> , Id<String> {
    @override
String? id;
	String? userId;
	String? code;
	double? commissionRate;
	int? bonusPoints;
	DateTime? expiresAt;
	int? totalReferrals;
	int? successfulReferrals;
	double? totalEarnings;
	dynamic trackingHistory;
	DateTime? createdAt;
	DateTime? updatedAt;
	String? organizationId;
	Organization? organization;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Referral({ this.id,
	 this.userId,
	 this.code,
	 this.commissionRate = 0.05,
	 this.bonusPoints = 500,
	 this.expiresAt,
	 this.totalReferrals = 0,
	 this.successfulReferrals = 0,
	 this.totalEarnings = 0,
	required this.trackingHistory,
	 this.createdAt,
	 this.updatedAt,
	 this.organizationId,
	 this.organization,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Referral, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"code": (m) => m.code,

	"commissionRate": (m) => m.commissionRate,

	"bonusPoints": (m) => m.bonusPoints,

	"expiresAt": (m) => m.expiresAt,

	"totalReferrals": (m) => m.totalReferrals,

	"successfulReferrals": (m) => m.successfulReferrals,

	"totalEarnings": (m) => m.totalEarnings,

	"trackingHistory": (m) => m.trackingHistory,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"organizationId": (m) => m.organizationId,

	"organization": (m) => m.organization,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Referral) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Referral');
    }
    return propFunction as V? Function(Referral);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Referral.fromJson(JsonMap json) =>
      Referral(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	code: json['code'] as String?,
	commissionRate: json['commissionRate']?.toDouble(),
	bonusPoints: int.tryParse(json['bonusPoints'].toString()),
	expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
	totalReferrals: int.tryParse(json['totalReferrals'].toString()),
	successfulReferrals: int.tryParse(json['successfulReferrals'].toString()),
	totalEarnings: json['totalEarnings'] as double?,
	trackingHistory: json['trackingHistory'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	organizationId: json['organizationId'] as String?,
	organization: json['organization'] != null ? Organization.fromJson(json['organization'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Referral copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? code,
		Value<double?>? commissionRate,
		Value<int?>? bonusPoints,
		Value<DateTime?>? expiresAt,
		Value<int?>? totalReferrals,
		Value<int?>? successfulReferrals,
		Value<double?>? totalEarnings,
		Value<dynamic>? trackingHistory,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<String?>? organizationId,
		Value<Organization?>? organization,
		Value<User?>? user,
        }) {
        return Referral(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		code: code != null ? code.value : this.code,
		commissionRate: commissionRate != null ? commissionRate.value : this.commissionRate,
		bonusPoints: bonusPoints != null ? bonusPoints.value : this.bonusPoints,
		expiresAt: expiresAt != null ? expiresAt.value : this.expiresAt,
		totalReferrals: totalReferrals != null ? totalReferrals.value : this.totalReferrals,
		successfulReferrals: successfulReferrals != null ? successfulReferrals.value : this.successfulReferrals,
		totalEarnings: totalEarnings != null ? totalEarnings.value : this.totalEarnings,
		trackingHistory: trackingHistory != null ? trackingHistory.value : this.trackingHistory,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		organizationId: organizationId != null ? organizationId.value : this.organizationId,
		organization: organization != null ? organization.value : this.organization,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Referral copyWithInstanceValues(Referral referral) {
        return Referral(
            id: referral.id ?? id,
		userId: referral.userId ?? userId,
		code: referral.code ?? code,
		commissionRate: referral.commissionRate ?? commissionRate,
		bonusPoints: referral.bonusPoints ?? bonusPoints,
		expiresAt: referral.expiresAt ?? expiresAt,
		totalReferrals: referral.totalReferrals ?? totalReferrals,
		successfulReferrals: referral.successfulReferrals ?? successfulReferrals,
		totalEarnings: referral.totalEarnings ?? totalEarnings,
		trackingHistory: referral.trackingHistory ?? trackingHistory,
		createdAt: referral.createdAt ?? createdAt,
		updatedAt: referral.updatedAt ?? updatedAt,
		organizationId: referral.organizationId ?? organizationId,
		organization: referral.organization ?? organization,
		user: referral.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Referral mergeWithInstanceValues(Referral referral) {
        return Referral(
            id: referral.$assignedFields.contains('id') ? referral.id : id,
		userId: referral.$assignedFields.contains('userId') ? referral.userId : userId,
		code: referral.$assignedFields.contains('code') ? referral.code : code,
		commissionRate: referral.$assignedFields.contains('commissionRate') ? referral.commissionRate : commissionRate,
		bonusPoints: referral.$assignedFields.contains('bonusPoints') ? referral.bonusPoints : bonusPoints,
		expiresAt: referral.$assignedFields.contains('expiresAt') ? referral.expiresAt : expiresAt,
		totalReferrals: referral.$assignedFields.contains('totalReferrals') ? referral.totalReferrals : totalReferrals,
		successfulReferrals: referral.$assignedFields.contains('successfulReferrals') ? referral.successfulReferrals : successfulReferrals,
		totalEarnings: referral.$assignedFields.contains('totalEarnings') ? referral.totalEarnings : totalEarnings,
		trackingHistory: referral.$assignedFields.contains('trackingHistory') ? referral.trackingHistory : trackingHistory,
		createdAt: referral.$assignedFields.contains('createdAt') ? referral.createdAt : createdAt,
		updatedAt: referral.$assignedFields.contains('updatedAt') ? referral.updatedAt : updatedAt,
		organizationId: referral.$assignedFields.contains('organizationId') ? referral.organizationId : organizationId,
		organization: referral.$assignedFields.contains('organization') ? referral.organization : organization,
		user: referral.$assignedFields.contains('user') ? referral.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Referral updateWithInstanceValues(Referral referral) {
        if (referral.$assignedFields.contains('id')) { id = referral.id; }
		if (referral.$assignedFields.contains('userId')) { userId = referral.userId; }
		if (referral.$assignedFields.contains('code')) { code = referral.code; }
		if (referral.$assignedFields.contains('commissionRate')) { commissionRate = referral.commissionRate; }
		if (referral.$assignedFields.contains('bonusPoints')) { bonusPoints = referral.bonusPoints; }
		if (referral.$assignedFields.contains('expiresAt')) { expiresAt = referral.expiresAt; }
		if (referral.$assignedFields.contains('totalReferrals')) { totalReferrals = referral.totalReferrals; }
		if (referral.$assignedFields.contains('successfulReferrals')) { successfulReferrals = referral.successfulReferrals; }
		if (referral.$assignedFields.contains('totalEarnings')) { totalEarnings = referral.totalEarnings; }
		if (referral.$assignedFields.contains('trackingHistory')) { trackingHistory = referral.trackingHistory; }
		if (referral.$assignedFields.contains('createdAt')) { createdAt = referral.createdAt; }
		if (referral.$assignedFields.contains('updatedAt')) { updatedAt = referral.updatedAt; }
		if (referral.$assignedFields.contains('organizationId')) { organizationId = referral.organizationId; }
		if (referral.$assignedFields.contains('organization')) { organization = referral.organization; }
		if (referral.$assignedFields.contains('user')) { user = referral.user; }
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
          ? {...?serializedTypes, 'Referral'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(code != null) 'code': code,
	if(commissionRate != null) 'commissionRate': commissionRate,
	if(bonusPoints != null) 'bonusPoints': bonusPoints,
	if(expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
	if(totalReferrals != null) 'totalReferrals': totalReferrals,
	if(successfulReferrals != null) 'successfulReferrals': successfulReferrals,
	if(totalEarnings != null) 'totalEarnings': totalEarnings,
	if(trackingHistory != null) 'trackingHistory': trackingHistory,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(organizationId != null) 'organizationId': organizationId,
	if(organization != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'organization': organization?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Referral &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    