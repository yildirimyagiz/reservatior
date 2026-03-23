
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'loyalty_tier.dart';
import 'organization.dart';
import 'user.dart';


class LoyaltyAccount implements PrismaModel<String, LoyaltyAccount> , Id<String> {
    @override
String? id;
	String? orgId;
	String? userId;
	String? name;
	String? description;
	double? pointsPerDollar;
	int? pointsExpiryDays;
	bool? tiersEnabled;
	int? bronzeThreshold;
	int? silverThreshold;
	int? goldThreshold;
	int? platinumThreshold;
	int? diamondThreshold;
	int? currentPoints;
	LoyaltyTier? currentTier;
	int? totalEarned;
	dynamic pointsHistory;
	dynamic rewards;
	bool? isActive;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    LoyaltyAccount({ this.id,
	 this.orgId,
	 this.userId,
	 this.name,
	 this.description,
	 this.pointsPerDollar = 1,
	 this.pointsExpiryDays,
	 this.tiersEnabled = true,
	 this.bronzeThreshold = 0,
	 this.silverThreshold = 1000,
	 this.goldThreshold = 5000,
	 this.platinumThreshold = 15000,
	 this.diamondThreshold = 50000,
	 this.currentPoints = 0,
	 this.currentTier = LoyaltyTier.BRONZE,
	 this.totalEarned = 0,
	required this.pointsHistory,
	required this.rewards,
	 this.isActive = true,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<LoyaltyAccount, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"userId": (m) => m.userId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"pointsPerDollar": (m) => m.pointsPerDollar,

	"pointsExpiryDays": (m) => m.pointsExpiryDays,

	"tiersEnabled": (m) => m.tiersEnabled,

	"bronzeThreshold": (m) => m.bronzeThreshold,

	"silverThreshold": (m) => m.silverThreshold,

	"goldThreshold": (m) => m.goldThreshold,

	"platinumThreshold": (m) => m.platinumThreshold,

	"diamondThreshold": (m) => m.diamondThreshold,

	"currentPoints": (m) => m.currentPoints,

	"currentTier": (m) => m.currentTier,

	"totalEarned": (m) => m.totalEarned,

	"pointsHistory": (m) => m.pointsHistory,

	"rewards": (m) => m.rewards,

	"isActive": (m) => m.isActive,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(LoyaltyAccount) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in LoyaltyAccount');
    }
    return propFunction as V? Function(LoyaltyAccount);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory LoyaltyAccount.fromJson(JsonMap json) =>
      LoyaltyAccount(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	userId: json['userId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	pointsPerDollar: json['pointsPerDollar']?.toDouble(),
	pointsExpiryDays: int.tryParse(json['pointsExpiryDays'].toString()),
	tiersEnabled: json['tiersEnabled'] as bool?,
	bronzeThreshold: int.tryParse(json['bronzeThreshold'].toString()),
	silverThreshold: int.tryParse(json['silverThreshold'].toString()),
	goldThreshold: int.tryParse(json['goldThreshold'].toString()),
	platinumThreshold: int.tryParse(json['platinumThreshold'].toString()),
	diamondThreshold: int.tryParse(json['diamondThreshold'].toString()),
	currentPoints: int.tryParse(json['currentPoints'].toString()),
	currentTier: json['currentTier'] != null ? LoyaltyTier.fromJson(json['currentTier']) : null,
	totalEarned: int.tryParse(json['totalEarned'].toString()),
	pointsHistory: json['pointsHistory'] as dynamic,
	rewards: json['rewards'] as dynamic,
	isActive: json['isActive'] as bool?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    LoyaltyAccount copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? userId,
		Value<String?>? name,
		Value<String?>? description,
		Value<double?>? pointsPerDollar,
		Value<int?>? pointsExpiryDays,
		Value<bool?>? tiersEnabled,
		Value<int?>? bronzeThreshold,
		Value<int?>? silverThreshold,
		Value<int?>? goldThreshold,
		Value<int?>? platinumThreshold,
		Value<int?>? diamondThreshold,
		Value<int?>? currentPoints,
		Value<LoyaltyTier?>? currentTier,
		Value<int?>? totalEarned,
		Value<dynamic>? pointsHistory,
		Value<dynamic>? rewards,
		Value<bool?>? isActive,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
		Value<User?>? user,
        }) {
        return LoyaltyAccount(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		userId: userId != null ? userId.value : this.userId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		pointsPerDollar: pointsPerDollar != null ? pointsPerDollar.value : this.pointsPerDollar,
		pointsExpiryDays: pointsExpiryDays != null ? pointsExpiryDays.value : this.pointsExpiryDays,
		tiersEnabled: tiersEnabled != null ? tiersEnabled.value : this.tiersEnabled,
		bronzeThreshold: bronzeThreshold != null ? bronzeThreshold.value : this.bronzeThreshold,
		silverThreshold: silverThreshold != null ? silverThreshold.value : this.silverThreshold,
		goldThreshold: goldThreshold != null ? goldThreshold.value : this.goldThreshold,
		platinumThreshold: platinumThreshold != null ? platinumThreshold.value : this.platinumThreshold,
		diamondThreshold: diamondThreshold != null ? diamondThreshold.value : this.diamondThreshold,
		currentPoints: currentPoints != null ? currentPoints.value : this.currentPoints,
		currentTier: currentTier != null ? currentTier.value : this.currentTier,
		totalEarned: totalEarned != null ? totalEarned.value : this.totalEarned,
		pointsHistory: pointsHistory != null ? pointsHistory.value : this.pointsHistory,
		rewards: rewards != null ? rewards.value : this.rewards,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    LoyaltyAccount copyWithInstanceValues(LoyaltyAccount loyaltyAccount) {
        return LoyaltyAccount(
            id: loyaltyAccount.id ?? id,
		orgId: loyaltyAccount.orgId ?? orgId,
		userId: loyaltyAccount.userId ?? userId,
		name: loyaltyAccount.name ?? name,
		description: loyaltyAccount.description ?? description,
		pointsPerDollar: loyaltyAccount.pointsPerDollar ?? pointsPerDollar,
		pointsExpiryDays: loyaltyAccount.pointsExpiryDays ?? pointsExpiryDays,
		tiersEnabled: loyaltyAccount.tiersEnabled ?? tiersEnabled,
		bronzeThreshold: loyaltyAccount.bronzeThreshold ?? bronzeThreshold,
		silverThreshold: loyaltyAccount.silverThreshold ?? silverThreshold,
		goldThreshold: loyaltyAccount.goldThreshold ?? goldThreshold,
		platinumThreshold: loyaltyAccount.platinumThreshold ?? platinumThreshold,
		diamondThreshold: loyaltyAccount.diamondThreshold ?? diamondThreshold,
		currentPoints: loyaltyAccount.currentPoints ?? currentPoints,
		currentTier: loyaltyAccount.currentTier ?? currentTier,
		totalEarned: loyaltyAccount.totalEarned ?? totalEarned,
		pointsHistory: loyaltyAccount.pointsHistory ?? pointsHistory,
		rewards: loyaltyAccount.rewards ?? rewards,
		isActive: loyaltyAccount.isActive ?? isActive,
		createdBy: loyaltyAccount.createdBy ?? createdBy,
		createdAt: loyaltyAccount.createdAt ?? createdAt,
		updatedAt: loyaltyAccount.updatedAt ?? updatedAt,
		org: loyaltyAccount.org ?? org,
		user: loyaltyAccount.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    LoyaltyAccount mergeWithInstanceValues(LoyaltyAccount loyaltyAccount) {
        return LoyaltyAccount(
            id: loyaltyAccount.$assignedFields.contains('id') ? loyaltyAccount.id : id,
		orgId: loyaltyAccount.$assignedFields.contains('orgId') ? loyaltyAccount.orgId : orgId,
		userId: loyaltyAccount.$assignedFields.contains('userId') ? loyaltyAccount.userId : userId,
		name: loyaltyAccount.$assignedFields.contains('name') ? loyaltyAccount.name : name,
		description: loyaltyAccount.$assignedFields.contains('description') ? loyaltyAccount.description : description,
		pointsPerDollar: loyaltyAccount.$assignedFields.contains('pointsPerDollar') ? loyaltyAccount.pointsPerDollar : pointsPerDollar,
		pointsExpiryDays: loyaltyAccount.$assignedFields.contains('pointsExpiryDays') ? loyaltyAccount.pointsExpiryDays : pointsExpiryDays,
		tiersEnabled: loyaltyAccount.$assignedFields.contains('tiersEnabled') ? loyaltyAccount.tiersEnabled : tiersEnabled,
		bronzeThreshold: loyaltyAccount.$assignedFields.contains('bronzeThreshold') ? loyaltyAccount.bronzeThreshold : bronzeThreshold,
		silverThreshold: loyaltyAccount.$assignedFields.contains('silverThreshold') ? loyaltyAccount.silverThreshold : silverThreshold,
		goldThreshold: loyaltyAccount.$assignedFields.contains('goldThreshold') ? loyaltyAccount.goldThreshold : goldThreshold,
		platinumThreshold: loyaltyAccount.$assignedFields.contains('platinumThreshold') ? loyaltyAccount.platinumThreshold : platinumThreshold,
		diamondThreshold: loyaltyAccount.$assignedFields.contains('diamondThreshold') ? loyaltyAccount.diamondThreshold : diamondThreshold,
		currentPoints: loyaltyAccount.$assignedFields.contains('currentPoints') ? loyaltyAccount.currentPoints : currentPoints,
		currentTier: loyaltyAccount.$assignedFields.contains('currentTier') ? loyaltyAccount.currentTier : currentTier,
		totalEarned: loyaltyAccount.$assignedFields.contains('totalEarned') ? loyaltyAccount.totalEarned : totalEarned,
		pointsHistory: loyaltyAccount.$assignedFields.contains('pointsHistory') ? loyaltyAccount.pointsHistory : pointsHistory,
		rewards: loyaltyAccount.$assignedFields.contains('rewards') ? loyaltyAccount.rewards : rewards,
		isActive: loyaltyAccount.$assignedFields.contains('isActive') ? loyaltyAccount.isActive : isActive,
		createdBy: loyaltyAccount.$assignedFields.contains('createdBy') ? loyaltyAccount.createdBy : createdBy,
		createdAt: loyaltyAccount.$assignedFields.contains('createdAt') ? loyaltyAccount.createdAt : createdAt,
		updatedAt: loyaltyAccount.$assignedFields.contains('updatedAt') ? loyaltyAccount.updatedAt : updatedAt,
		org: loyaltyAccount.$assignedFields.contains('org') ? loyaltyAccount.org : org,
		user: loyaltyAccount.$assignedFields.contains('user') ? loyaltyAccount.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    LoyaltyAccount updateWithInstanceValues(LoyaltyAccount loyaltyAccount) {
        if (loyaltyAccount.$assignedFields.contains('id')) { id = loyaltyAccount.id; }
		if (loyaltyAccount.$assignedFields.contains('orgId')) { orgId = loyaltyAccount.orgId; }
		if (loyaltyAccount.$assignedFields.contains('userId')) { userId = loyaltyAccount.userId; }
		if (loyaltyAccount.$assignedFields.contains('name')) { name = loyaltyAccount.name; }
		if (loyaltyAccount.$assignedFields.contains('description')) { description = loyaltyAccount.description; }
		if (loyaltyAccount.$assignedFields.contains('pointsPerDollar')) { pointsPerDollar = loyaltyAccount.pointsPerDollar; }
		if (loyaltyAccount.$assignedFields.contains('pointsExpiryDays')) { pointsExpiryDays = loyaltyAccount.pointsExpiryDays; }
		if (loyaltyAccount.$assignedFields.contains('tiersEnabled')) { tiersEnabled = loyaltyAccount.tiersEnabled; }
		if (loyaltyAccount.$assignedFields.contains('bronzeThreshold')) { bronzeThreshold = loyaltyAccount.bronzeThreshold; }
		if (loyaltyAccount.$assignedFields.contains('silverThreshold')) { silverThreshold = loyaltyAccount.silverThreshold; }
		if (loyaltyAccount.$assignedFields.contains('goldThreshold')) { goldThreshold = loyaltyAccount.goldThreshold; }
		if (loyaltyAccount.$assignedFields.contains('platinumThreshold')) { platinumThreshold = loyaltyAccount.platinumThreshold; }
		if (loyaltyAccount.$assignedFields.contains('diamondThreshold')) { diamondThreshold = loyaltyAccount.diamondThreshold; }
		if (loyaltyAccount.$assignedFields.contains('currentPoints')) { currentPoints = loyaltyAccount.currentPoints; }
		if (loyaltyAccount.$assignedFields.contains('currentTier')) { currentTier = loyaltyAccount.currentTier; }
		if (loyaltyAccount.$assignedFields.contains('totalEarned')) { totalEarned = loyaltyAccount.totalEarned; }
		if (loyaltyAccount.$assignedFields.contains('pointsHistory')) { pointsHistory = loyaltyAccount.pointsHistory; }
		if (loyaltyAccount.$assignedFields.contains('rewards')) { rewards = loyaltyAccount.rewards; }
		if (loyaltyAccount.$assignedFields.contains('isActive')) { isActive = loyaltyAccount.isActive; }
		if (loyaltyAccount.$assignedFields.contains('createdBy')) { createdBy = loyaltyAccount.createdBy; }
		if (loyaltyAccount.$assignedFields.contains('createdAt')) { createdAt = loyaltyAccount.createdAt; }
		if (loyaltyAccount.$assignedFields.contains('updatedAt')) { updatedAt = loyaltyAccount.updatedAt; }
		if (loyaltyAccount.$assignedFields.contains('org')) { org = loyaltyAccount.org; }
		if (loyaltyAccount.$assignedFields.contains('user')) { user = loyaltyAccount.user; }
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
          ? {...?serializedTypes, 'LoyaltyAccount'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(userId != null) 'userId': userId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(pointsPerDollar != null) 'pointsPerDollar': pointsPerDollar,
	if(pointsExpiryDays != null) 'pointsExpiryDays': pointsExpiryDays,
	if(tiersEnabled != null) 'tiersEnabled': tiersEnabled,
	if(bronzeThreshold != null) 'bronzeThreshold': bronzeThreshold,
	if(silverThreshold != null) 'silverThreshold': silverThreshold,
	if(goldThreshold != null) 'goldThreshold': goldThreshold,
	if(platinumThreshold != null) 'platinumThreshold': platinumThreshold,
	if(diamondThreshold != null) 'diamondThreshold': diamondThreshold,
	if(currentPoints != null) 'currentPoints': currentPoints,
	if(currentTier != null) 'currentTier': currentTier?.toJson(),
	if(totalEarned != null) 'totalEarned': totalEarned,
	if(pointsHistory != null) 'pointsHistory': pointsHistory,
	if(rewards != null) 'rewards': rewards,
	if(isActive != null) 'isActive': isActive,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is LoyaltyAccount &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    