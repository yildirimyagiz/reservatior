
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'earning_type.dart';
import 'organization.dart';
import 'user.dart';


class Earning implements PrismaModel<String, Earning> , Id<String> {
    @override
String? id;
	String? orgId;
	String? userId;
	String? name;
	EarningType? type;
	double? percentage;
	double? fixedAmount;
	dynamic conditions;
	bool? appliesToUsers;
	bool? appliesToAgents;
	bool? appliesToVendors;
	bool? isActive;
	dynamic earningsRecords;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Earning({ this.id,
	 this.orgId,
	 this.userId,
	 this.name,
	 this.type,
	 this.percentage,
	 this.fixedAmount,
	required this.conditions,
	 this.appliesToUsers = true,
	 this.appliesToAgents = false,
	 this.appliesToVendors = false,
	 this.isActive = true,
	required this.earningsRecords,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Earning, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"userId": (m) => m.userId,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"percentage": (m) => m.percentage,

	"fixedAmount": (m) => m.fixedAmount,

	"conditions": (m) => m.conditions,

	"appliesToUsers": (m) => m.appliesToUsers,

	"appliesToAgents": (m) => m.appliesToAgents,

	"appliesToVendors": (m) => m.appliesToVendors,

	"isActive": (m) => m.isActive,

	"earningsRecords": (m) => m.earningsRecords,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Earning) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Earning');
    }
    return propFunction as V? Function(Earning);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Earning.fromJson(JsonMap json) =>
      Earning(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	userId: json['userId'] as String?,
	name: json['name'] as String?,
	type: json['type'] != null ? EarningType.fromJson(json['type']) : null,
	percentage: json['percentage']?.toDouble(),
	fixedAmount: json['fixedAmount'] as double?,
	conditions: json['conditions'] as dynamic,
	appliesToUsers: json['appliesToUsers'] as bool?,
	appliesToAgents: json['appliesToAgents'] as bool?,
	appliesToVendors: json['appliesToVendors'] as bool?,
	isActive: json['isActive'] as bool?,
	earningsRecords: json['earningsRecords'] as dynamic,
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
    Earning copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? userId,
		Value<String?>? name,
		Value<EarningType?>? type,
		Value<double?>? percentage,
		Value<double?>? fixedAmount,
		Value<dynamic>? conditions,
		Value<bool?>? appliesToUsers,
		Value<bool?>? appliesToAgents,
		Value<bool?>? appliesToVendors,
		Value<bool?>? isActive,
		Value<dynamic>? earningsRecords,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
		Value<User?>? user,
        }) {
        return Earning(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		userId: userId != null ? userId.value : this.userId,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		percentage: percentage != null ? percentage.value : this.percentage,
		fixedAmount: fixedAmount != null ? fixedAmount.value : this.fixedAmount,
		conditions: conditions != null ? conditions.value : this.conditions,
		appliesToUsers: appliesToUsers != null ? appliesToUsers.value : this.appliesToUsers,
		appliesToAgents: appliesToAgents != null ? appliesToAgents.value : this.appliesToAgents,
		appliesToVendors: appliesToVendors != null ? appliesToVendors.value : this.appliesToVendors,
		isActive: isActive != null ? isActive.value : this.isActive,
		earningsRecords: earningsRecords != null ? earningsRecords.value : this.earningsRecords,
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
    Earning copyWithInstanceValues(Earning earning) {
        return Earning(
            id: earning.id ?? id,
		orgId: earning.orgId ?? orgId,
		userId: earning.userId ?? userId,
		name: earning.name ?? name,
		type: earning.type ?? type,
		percentage: earning.percentage ?? percentage,
		fixedAmount: earning.fixedAmount ?? fixedAmount,
		conditions: earning.conditions ?? conditions,
		appliesToUsers: earning.appliesToUsers ?? appliesToUsers,
		appliesToAgents: earning.appliesToAgents ?? appliesToAgents,
		appliesToVendors: earning.appliesToVendors ?? appliesToVendors,
		isActive: earning.isActive ?? isActive,
		earningsRecords: earning.earningsRecords ?? earningsRecords,
		createdBy: earning.createdBy ?? createdBy,
		createdAt: earning.createdAt ?? createdAt,
		updatedAt: earning.updatedAt ?? updatedAt,
		org: earning.org ?? org,
		user: earning.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Earning mergeWithInstanceValues(Earning earning) {
        return Earning(
            id: earning.$assignedFields.contains('id') ? earning.id : id,
		orgId: earning.$assignedFields.contains('orgId') ? earning.orgId : orgId,
		userId: earning.$assignedFields.contains('userId') ? earning.userId : userId,
		name: earning.$assignedFields.contains('name') ? earning.name : name,
		type: earning.$assignedFields.contains('type') ? earning.type : type,
		percentage: earning.$assignedFields.contains('percentage') ? earning.percentage : percentage,
		fixedAmount: earning.$assignedFields.contains('fixedAmount') ? earning.fixedAmount : fixedAmount,
		conditions: earning.$assignedFields.contains('conditions') ? earning.conditions : conditions,
		appliesToUsers: earning.$assignedFields.contains('appliesToUsers') ? earning.appliesToUsers : appliesToUsers,
		appliesToAgents: earning.$assignedFields.contains('appliesToAgents') ? earning.appliesToAgents : appliesToAgents,
		appliesToVendors: earning.$assignedFields.contains('appliesToVendors') ? earning.appliesToVendors : appliesToVendors,
		isActive: earning.$assignedFields.contains('isActive') ? earning.isActive : isActive,
		earningsRecords: earning.$assignedFields.contains('earningsRecords') ? earning.earningsRecords : earningsRecords,
		createdBy: earning.$assignedFields.contains('createdBy') ? earning.createdBy : createdBy,
		createdAt: earning.$assignedFields.contains('createdAt') ? earning.createdAt : createdAt,
		updatedAt: earning.$assignedFields.contains('updatedAt') ? earning.updatedAt : updatedAt,
		org: earning.$assignedFields.contains('org') ? earning.org : org,
		user: earning.$assignedFields.contains('user') ? earning.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Earning updateWithInstanceValues(Earning earning) {
        if (earning.$assignedFields.contains('id')) { id = earning.id; }
		if (earning.$assignedFields.contains('orgId')) { orgId = earning.orgId; }
		if (earning.$assignedFields.contains('userId')) { userId = earning.userId; }
		if (earning.$assignedFields.contains('name')) { name = earning.name; }
		if (earning.$assignedFields.contains('type')) { type = earning.type; }
		if (earning.$assignedFields.contains('percentage')) { percentage = earning.percentage; }
		if (earning.$assignedFields.contains('fixedAmount')) { fixedAmount = earning.fixedAmount; }
		if (earning.$assignedFields.contains('conditions')) { conditions = earning.conditions; }
		if (earning.$assignedFields.contains('appliesToUsers')) { appliesToUsers = earning.appliesToUsers; }
		if (earning.$assignedFields.contains('appliesToAgents')) { appliesToAgents = earning.appliesToAgents; }
		if (earning.$assignedFields.contains('appliesToVendors')) { appliesToVendors = earning.appliesToVendors; }
		if (earning.$assignedFields.contains('isActive')) { isActive = earning.isActive; }
		if (earning.$assignedFields.contains('earningsRecords')) { earningsRecords = earning.earningsRecords; }
		if (earning.$assignedFields.contains('createdBy')) { createdBy = earning.createdBy; }
		if (earning.$assignedFields.contains('createdAt')) { createdAt = earning.createdAt; }
		if (earning.$assignedFields.contains('updatedAt')) { updatedAt = earning.updatedAt; }
		if (earning.$assignedFields.contains('org')) { org = earning.org; }
		if (earning.$assignedFields.contains('user')) { user = earning.user; }
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
          ? {...?serializedTypes, 'Earning'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(userId != null) 'userId': userId,
	if(name != null) 'name': name,
	if(type != null) 'type': type?.toJson(),
	if(percentage != null) 'percentage': percentage,
	if(fixedAmount != null) 'fixedAmount': fixedAmount,
	if(conditions != null) 'conditions': conditions,
	if(appliesToUsers != null) 'appliesToUsers': appliesToUsers,
	if(appliesToAgents != null) 'appliesToAgents': appliesToAgents,
	if(appliesToVendors != null) 'appliesToVendors': appliesToVendors,
	if(isActive != null) 'isActive': isActive,
	if(earningsRecords != null) 'earningsRecords': earningsRecords,
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
            identical(this, other) || other is Earning &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    