
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'user.dart';
import 'listing.dart';
import 'organization.dart';


class AgentAssignment implements PrismaModel<String, AgentAssignment> , Id<String> {
    @override
String? id;
	String? orgId;
	String? listingId;
	String? agentUserId;
	String? agencyOrgId;
	int? commissionBps;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	User? agent;
	Listing? listing;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AgentAssignment({ this.id,
	 this.orgId,
	 this.listingId,
	 this.agentUserId,
	 this.agencyOrgId,
	 this.commissionBps,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.agent,
	 this.listing,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AgentAssignment, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"listingId": (m) => m.listingId,

	"agentUserId": (m) => m.agentUserId,

	"agencyOrgId": (m) => m.agencyOrgId,

	"commissionBps": (m) => m.commissionBps,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"agent": (m) => m.agent,

	"listing": (m) => m.listing,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AgentAssignment) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AgentAssignment');
    }
    return propFunction as V? Function(AgentAssignment);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AgentAssignment.fromJson(JsonMap json) =>
      AgentAssignment(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	listingId: json['listingId'] as String?,
	agentUserId: json['agentUserId'] as String?,
	agencyOrgId: json['agencyOrgId'] as String?,
	commissionBps: int.tryParse(json['commissionBps'].toString()),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	agent: json['agent'] != null ? User.fromJson(json['agent'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AgentAssignment copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? listingId,
		Value<String?>? agentUserId,
		Value<String?>? agencyOrgId,
		Value<int?>? commissionBps,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<User?>? agent,
		Value<Listing?>? listing,
		Value<Organization?>? org,
        }) {
        return AgentAssignment(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		listingId: listingId != null ? listingId.value : this.listingId,
		agentUserId: agentUserId != null ? agentUserId.value : this.agentUserId,
		agencyOrgId: agencyOrgId != null ? agencyOrgId.value : this.agencyOrgId,
		commissionBps: commissionBps != null ? commissionBps.value : this.commissionBps,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		agent: agent != null ? agent.value : this.agent,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AgentAssignment copyWithInstanceValues(AgentAssignment agentAssignment) {
        return AgentAssignment(
            id: agentAssignment.id ?? id,
		orgId: agentAssignment.orgId ?? orgId,
		listingId: agentAssignment.listingId ?? listingId,
		agentUserId: agentAssignment.agentUserId ?? agentUserId,
		agencyOrgId: agentAssignment.agencyOrgId ?? agencyOrgId,
		commissionBps: agentAssignment.commissionBps ?? commissionBps,
		createdAt: agentAssignment.createdAt ?? createdAt,
		updatedAt: agentAssignment.updatedAt ?? updatedAt,
		deletedAt: agentAssignment.deletedAt ?? deletedAt,
		agent: agentAssignment.agent ?? agent,
		listing: agentAssignment.listing ?? listing,
		org: agentAssignment.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AgentAssignment mergeWithInstanceValues(AgentAssignment agentAssignment) {
        return AgentAssignment(
            id: agentAssignment.$assignedFields.contains('id') ? agentAssignment.id : id,
		orgId: agentAssignment.$assignedFields.contains('orgId') ? agentAssignment.orgId : orgId,
		listingId: agentAssignment.$assignedFields.contains('listingId') ? agentAssignment.listingId : listingId,
		agentUserId: agentAssignment.$assignedFields.contains('agentUserId') ? agentAssignment.agentUserId : agentUserId,
		agencyOrgId: agentAssignment.$assignedFields.contains('agencyOrgId') ? agentAssignment.agencyOrgId : agencyOrgId,
		commissionBps: agentAssignment.$assignedFields.contains('commissionBps') ? agentAssignment.commissionBps : commissionBps,
		createdAt: agentAssignment.$assignedFields.contains('createdAt') ? agentAssignment.createdAt : createdAt,
		updatedAt: agentAssignment.$assignedFields.contains('updatedAt') ? agentAssignment.updatedAt : updatedAt,
		deletedAt: agentAssignment.$assignedFields.contains('deletedAt') ? agentAssignment.deletedAt : deletedAt,
		agent: agentAssignment.$assignedFields.contains('agent') ? agentAssignment.agent : agent,
		listing: agentAssignment.$assignedFields.contains('listing') ? agentAssignment.listing : listing,
		org: agentAssignment.$assignedFields.contains('org') ? agentAssignment.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AgentAssignment updateWithInstanceValues(AgentAssignment agentAssignment) {
        if (agentAssignment.$assignedFields.contains('id')) { id = agentAssignment.id; }
		if (agentAssignment.$assignedFields.contains('orgId')) { orgId = agentAssignment.orgId; }
		if (agentAssignment.$assignedFields.contains('listingId')) { listingId = agentAssignment.listingId; }
		if (agentAssignment.$assignedFields.contains('agentUserId')) { agentUserId = agentAssignment.agentUserId; }
		if (agentAssignment.$assignedFields.contains('agencyOrgId')) { agencyOrgId = agentAssignment.agencyOrgId; }
		if (agentAssignment.$assignedFields.contains('commissionBps')) { commissionBps = agentAssignment.commissionBps; }
		if (agentAssignment.$assignedFields.contains('createdAt')) { createdAt = agentAssignment.createdAt; }
		if (agentAssignment.$assignedFields.contains('updatedAt')) { updatedAt = agentAssignment.updatedAt; }
		if (agentAssignment.$assignedFields.contains('deletedAt')) { deletedAt = agentAssignment.deletedAt; }
		if (agentAssignment.$assignedFields.contains('agent')) { agent = agentAssignment.agent; }
		if (agentAssignment.$assignedFields.contains('listing')) { listing = agentAssignment.listing; }
		if (agentAssignment.$assignedFields.contains('org')) { org = agentAssignment.org; }
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
          ? {...?serializedTypes, 'AgentAssignment'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(listingId != null) 'listingId': listingId,
	if(agentUserId != null) 'agentUserId': agentUserId,
	if(agencyOrgId != null) 'agencyOrgId': agencyOrgId,
	if(commissionBps != null) 'commissionBps': commissionBps,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(agent != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'agent': agent?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AgentAssignment &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    