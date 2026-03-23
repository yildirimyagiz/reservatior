
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'plan.dart';


class OrgSubscription implements PrismaModel<String, OrgSubscription> , Id<String> {
    @override
String? id;
	String? orgId;
	String? planId;
	String? status;
	String? stripeCustomerId;
	String? stripeSubscriptionId;
	DateTime? currentPeriodEnd;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	Plan? plan;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    OrgSubscription({ this.id,
	 this.orgId,
	 this.planId,
	 this.status = "ACTIVE",
	 this.stripeCustomerId,
	 this.stripeSubscriptionId,
	 this.currentPeriodEnd,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.plan,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<OrgSubscription, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"planId": (m) => m.planId,

	"status": (m) => m.status,

	"stripeCustomerId": (m) => m.stripeCustomerId,

	"stripeSubscriptionId": (m) => m.stripeSubscriptionId,

	"currentPeriodEnd": (m) => m.currentPeriodEnd,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"plan": (m) => m.plan,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(OrgSubscription) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in OrgSubscription');
    }
    return propFunction as V? Function(OrgSubscription);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory OrgSubscription.fromJson(JsonMap json) =>
      OrgSubscription(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	planId: json['planId'] as String?,
	status: json['status'] as String?,
	stripeCustomerId: json['stripeCustomerId'] as String?,
	stripeSubscriptionId: json['stripeSubscriptionId'] as String?,
	currentPeriodEnd: json['currentPeriodEnd'] != null ? DateTime.parse(json['currentPeriodEnd']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	plan: json['plan'] != null ? Plan.fromJson(json['plan'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    OrgSubscription copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? planId,
		Value<String?>? status,
		Value<String?>? stripeCustomerId,
		Value<String?>? stripeSubscriptionId,
		Value<DateTime?>? currentPeriodEnd,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<Plan?>? plan,
        }) {
        return OrgSubscription(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		planId: planId != null ? planId.value : this.planId,
		status: status != null ? status.value : this.status,
		stripeCustomerId: stripeCustomerId != null ? stripeCustomerId.value : this.stripeCustomerId,
		stripeSubscriptionId: stripeSubscriptionId != null ? stripeSubscriptionId.value : this.stripeSubscriptionId,
		currentPeriodEnd: currentPeriodEnd != null ? currentPeriodEnd.value : this.currentPeriodEnd,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		plan: plan != null ? plan.value : this.plan
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    OrgSubscription copyWithInstanceValues(OrgSubscription orgSubscription) {
        return OrgSubscription(
            id: orgSubscription.id ?? id,
		orgId: orgSubscription.orgId ?? orgId,
		planId: orgSubscription.planId ?? planId,
		status: orgSubscription.status ?? status,
		stripeCustomerId: orgSubscription.stripeCustomerId ?? stripeCustomerId,
		stripeSubscriptionId: orgSubscription.stripeSubscriptionId ?? stripeSubscriptionId,
		currentPeriodEnd: orgSubscription.currentPeriodEnd ?? currentPeriodEnd,
		createdAt: orgSubscription.createdAt ?? createdAt,
		updatedAt: orgSubscription.updatedAt ?? updatedAt,
		deletedAt: orgSubscription.deletedAt ?? deletedAt,
		org: orgSubscription.org ?? org,
		plan: orgSubscription.plan ?? plan
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    OrgSubscription mergeWithInstanceValues(OrgSubscription orgSubscription) {
        return OrgSubscription(
            id: orgSubscription.$assignedFields.contains('id') ? orgSubscription.id : id,
		orgId: orgSubscription.$assignedFields.contains('orgId') ? orgSubscription.orgId : orgId,
		planId: orgSubscription.$assignedFields.contains('planId') ? orgSubscription.planId : planId,
		status: orgSubscription.$assignedFields.contains('status') ? orgSubscription.status : status,
		stripeCustomerId: orgSubscription.$assignedFields.contains('stripeCustomerId') ? orgSubscription.stripeCustomerId : stripeCustomerId,
		stripeSubscriptionId: orgSubscription.$assignedFields.contains('stripeSubscriptionId') ? orgSubscription.stripeSubscriptionId : stripeSubscriptionId,
		currentPeriodEnd: orgSubscription.$assignedFields.contains('currentPeriodEnd') ? orgSubscription.currentPeriodEnd : currentPeriodEnd,
		createdAt: orgSubscription.$assignedFields.contains('createdAt') ? orgSubscription.createdAt : createdAt,
		updatedAt: orgSubscription.$assignedFields.contains('updatedAt') ? orgSubscription.updatedAt : updatedAt,
		deletedAt: orgSubscription.$assignedFields.contains('deletedAt') ? orgSubscription.deletedAt : deletedAt,
		org: orgSubscription.$assignedFields.contains('org') ? orgSubscription.org : org,
		plan: orgSubscription.$assignedFields.contains('plan') ? orgSubscription.plan : plan
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    OrgSubscription updateWithInstanceValues(OrgSubscription orgSubscription) {
        if (orgSubscription.$assignedFields.contains('id')) { id = orgSubscription.id; }
		if (orgSubscription.$assignedFields.contains('orgId')) { orgId = orgSubscription.orgId; }
		if (orgSubscription.$assignedFields.contains('planId')) { planId = orgSubscription.planId; }
		if (orgSubscription.$assignedFields.contains('status')) { status = orgSubscription.status; }
		if (orgSubscription.$assignedFields.contains('stripeCustomerId')) { stripeCustomerId = orgSubscription.stripeCustomerId; }
		if (orgSubscription.$assignedFields.contains('stripeSubscriptionId')) { stripeSubscriptionId = orgSubscription.stripeSubscriptionId; }
		if (orgSubscription.$assignedFields.contains('currentPeriodEnd')) { currentPeriodEnd = orgSubscription.currentPeriodEnd; }
		if (orgSubscription.$assignedFields.contains('createdAt')) { createdAt = orgSubscription.createdAt; }
		if (orgSubscription.$assignedFields.contains('updatedAt')) { updatedAt = orgSubscription.updatedAt; }
		if (orgSubscription.$assignedFields.contains('deletedAt')) { deletedAt = orgSubscription.deletedAt; }
		if (orgSubscription.$assignedFields.contains('org')) { org = orgSubscription.org; }
		if (orgSubscription.$assignedFields.contains('plan')) { plan = orgSubscription.plan; }
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
          ? {...?serializedTypes, 'OrgSubscription'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(planId != null) 'planId': planId,
	if(status != null) 'status': status,
	if(stripeCustomerId != null) 'stripeCustomerId': stripeCustomerId,
	if(stripeSubscriptionId != null) 'stripeSubscriptionId': stripeSubscriptionId,
	if(currentPeriodEnd != null) 'currentPeriodEnd': currentPeriodEnd?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(plan != null && (!preventCircularSerialization || !serializedModels.contains('Plan'))) 'plan': plan?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is OrgSubscription &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    