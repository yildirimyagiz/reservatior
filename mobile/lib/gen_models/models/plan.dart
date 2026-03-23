
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'org_subscription.dart';


class Plan implements PrismaModel<String, Plan> , Id<String> {
    @override
String? id;
	String? key;
	String? name;
	dynamic limits;
	int? priceMonthlyCents;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<OrgSubscription>? orgSubscriptions;
	int? $orgSubscriptionsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Plan({ this.id,
	 this.key,
	 this.name,
	required this.limits,
	 this.priceMonthlyCents,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.orgSubscriptions,
	this.$orgSubscriptionsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Plan, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"key": (m) => m.key,

	"name": (m) => m.name,

	"limits": (m) => m.limits,

	"priceMonthlyCents": (m) => m.priceMonthlyCents,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"orgSubscriptions": (m) => m.orgSubscriptions,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Plan) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Plan');
    }
    return propFunction as V? Function(Plan);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Plan.fromJson(JsonMap json) =>
      Plan(
        id: json['id'] as String?,
	key: json['key'] as String?,
	name: json['name'] as String?,
	limits: json['limits'] as dynamic,
	priceMonthlyCents: int.tryParse(json['priceMonthlyCents'].toString()),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	orgSubscriptions: json['orgSubscriptions'] != null ? createModels<OrgSubscription>((json['orgSubscriptions'] as List).cast<JsonMap>(), OrgSubscription.fromJson) : null,
	$orgSubscriptionsCount: json['_count']?['orgSubscriptions'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Plan copyWith({
        Value<String?>? id,
		Value<String?>? key,
		Value<String?>? name,
		Value<dynamic>? limits,
		Value<int?>? priceMonthlyCents,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<OrgSubscription>?>? orgSubscriptions,
		int? $orgSubscriptionsCount,
        }) {
        return Plan(
            id: id != null ? id.value : this.id,
		key: key != null ? key.value : this.key,
		name: name != null ? name.value : this.name,
		limits: limits != null ? limits.value : this.limits,
		priceMonthlyCents: priceMonthlyCents != null ? priceMonthlyCents.value : this.priceMonthlyCents,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		orgSubscriptions: orgSubscriptions != null ? orgSubscriptions.value : this.orgSubscriptions,
		$orgSubscriptionsCount: $orgSubscriptionsCount ?? this.$orgSubscriptionsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Plan copyWithInstanceValues(Plan plan) {
        return Plan(
            id: plan.id ?? id,
		key: plan.key ?? key,
		name: plan.name ?? name,
		limits: plan.limits ?? limits,
		priceMonthlyCents: plan.priceMonthlyCents ?? priceMonthlyCents,
		createdAt: plan.createdAt ?? createdAt,
		updatedAt: plan.updatedAt ?? updatedAt,
		deletedAt: plan.deletedAt ?? deletedAt,
		orgSubscriptions: plan.orgSubscriptions ?? orgSubscriptions,
		$orgSubscriptionsCount: plan.$orgSubscriptionsCount ?? $orgSubscriptionsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Plan mergeWithInstanceValues(Plan plan) {
        return Plan(
            id: plan.$assignedFields.contains('id') ? plan.id : id,
		key: plan.$assignedFields.contains('key') ? plan.key : key,
		name: plan.$assignedFields.contains('name') ? plan.name : name,
		limits: plan.$assignedFields.contains('limits') ? plan.limits : limits,
		priceMonthlyCents: plan.$assignedFields.contains('priceMonthlyCents') ? plan.priceMonthlyCents : priceMonthlyCents,
		createdAt: plan.$assignedFields.contains('createdAt') ? plan.createdAt : createdAt,
		updatedAt: plan.$assignedFields.contains('updatedAt') ? plan.updatedAt : updatedAt,
		deletedAt: plan.$assignedFields.contains('deletedAt') ? plan.deletedAt : deletedAt,
		orgSubscriptions: (plan.$assignedFields.contains('orgSubscriptions') && plan.orgSubscriptions != null) ? mergeModelLists(orgSubscriptions, plan.orgSubscriptions) : orgSubscriptions,
		$orgSubscriptionsCount: plan.$orgSubscriptionsCount ?? $orgSubscriptionsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Plan updateWithInstanceValues(Plan plan) {
        if (plan.$assignedFields.contains('id')) { id = plan.id; }
		if (plan.$assignedFields.contains('key')) { key = plan.key; }
		if (plan.$assignedFields.contains('name')) { name = plan.name; }
		if (plan.$assignedFields.contains('limits')) { limits = plan.limits; }
		if (plan.$assignedFields.contains('priceMonthlyCents')) { priceMonthlyCents = plan.priceMonthlyCents; }
		if (plan.$assignedFields.contains('createdAt')) { createdAt = plan.createdAt; }
		if (plan.$assignedFields.contains('updatedAt')) { updatedAt = plan.updatedAt; }
		if (plan.$assignedFields.contains('deletedAt')) { deletedAt = plan.deletedAt; }
		if (plan.$assignedFields.contains('orgSubscriptions') && plan.orgSubscriptions != null) { orgSubscriptions = mergeModelLists(orgSubscriptions, plan.orgSubscriptions); }
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
          ? {...?serializedTypes, 'Plan'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(key != null) 'key': key,
	if(name != null) 'name': name,
	if(limits != null) 'limits': limits,
	if(priceMonthlyCents != null) 'priceMonthlyCents': priceMonthlyCents,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(orgSubscriptions != null && (!preventCircularSerialization || !serializedModels.contains('OrgSubscription'))) 'orgSubscriptions': orgSubscriptions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($orgSubscriptionsCount != null) '_count': { 
		if ($orgSubscriptionsCount != null) 'orgSubscriptions': $orgSubscriptionsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Plan &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    