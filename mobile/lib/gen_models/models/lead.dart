
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'lead_status.dart';
import 'ai_lead_score.dart';
import 'agent_team.dart';
import 'contact.dart';
import 'user.dart';
import 'marketing_campaign.dart';
import 'listing.dart';
import 'property.dart';
import 'organization.dart';
import 'lead_source.dart';


class Lead implements PrismaModel<String, Lead> , Id<String> {
    @override
String? id;
	String? orgId;
	String? campaignId;
	String? sourceId;
	String? firstName;
	String? lastName;
	String? email;
	String? phone;
	double? budget;
	String? timeline;
	String? notes;
	LeadStatus? status;
	String? sourceDetail;
	String? assignedToUserId;
	String? assignedToContactId;
	String? interestedPropertyId;
	String? interestedListingId;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? agentTeamId;
	List<AILeadScore>? aiScores;
	AgentTeam? agentTeam;
	Contact? assignedContact;
	User? assignedUser;
	MarketingCampaign? campaign;
	Listing? interestedListing;
	Property? interestedProperty;
	Organization? org;
	LeadSource? source;
	int? $aiScoresCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Lead({ this.id,
	 this.orgId,
	 this.campaignId,
	 this.sourceId,
	 this.firstName,
	 this.lastName,
	 this.email,
	 this.phone,
	 this.budget,
	 this.timeline,
	 this.notes,
	 this.status = LeadStatus.NEW,
	 this.sourceDetail,
	 this.assignedToUserId,
	 this.assignedToContactId,
	 this.interestedPropertyId,
	 this.interestedListingId,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.agentTeamId,
	 this.aiScores,
	 this.agentTeam,
	 this.assignedContact,
	 this.assignedUser,
	 this.campaign,
	 this.interestedListing,
	 this.interestedProperty,
	 this.org,
	 this.source,
	this.$aiScoresCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Lead, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"campaignId": (m) => m.campaignId,

	"sourceId": (m) => m.sourceId,

	"firstName": (m) => m.firstName,

	"lastName": (m) => m.lastName,

	"email": (m) => m.email,

	"phone": (m) => m.phone,

	"budget": (m) => m.budget,

	"timeline": (m) => m.timeline,

	"notes": (m) => m.notes,

	"status": (m) => m.status,

	"sourceDetail": (m) => m.sourceDetail,

	"assignedToUserId": (m) => m.assignedToUserId,

	"assignedToContactId": (m) => m.assignedToContactId,

	"interestedPropertyId": (m) => m.interestedPropertyId,

	"interestedListingId": (m) => m.interestedListingId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"agentTeamId": (m) => m.agentTeamId,

	"aiScores": (m) => m.aiScores,

	"agentTeam": (m) => m.agentTeam,

	"assignedContact": (m) => m.assignedContact,

	"assignedUser": (m) => m.assignedUser,

	"campaign": (m) => m.campaign,

	"interestedListing": (m) => m.interestedListing,

	"interestedProperty": (m) => m.interestedProperty,

	"org": (m) => m.org,

	"source": (m) => m.source,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Lead) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Lead');
    }
    return propFunction as V? Function(Lead);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Lead.fromJson(JsonMap json) =>
      Lead(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	campaignId: json['campaignId'] as String?,
	sourceId: json['sourceId'] as String?,
	firstName: json['firstName'] as String?,
	lastName: json['lastName'] as String?,
	email: json['email'] as String?,
	phone: json['phone'] as String?,
	budget: json['budget'] as double?,
	timeline: json['timeline'] as String?,
	notes: json['notes'] as String?,
	status: json['status'] != null ? LeadStatus.fromJson(json['status']) : null,
	sourceDetail: json['sourceDetail'] as String?,
	assignedToUserId: json['assignedToUserId'] as String?,
	assignedToContactId: json['assignedToContactId'] as String?,
	interestedPropertyId: json['interestedPropertyId'] as String?,
	interestedListingId: json['interestedListingId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	agentTeamId: json['agentTeamId'] as String?,
	aiScores: json['aiScores'] != null ? createModels<AILeadScore>((json['aiScores'] as List).cast<JsonMap>(), AILeadScore.fromJson) : null,
	agentTeam: json['agentTeam'] != null ? AgentTeam.fromJson(json['agentTeam'] as JsonMap) : null,
	assignedContact: json['assignedContact'] != null ? Contact.fromJson(json['assignedContact'] as JsonMap) : null,
	assignedUser: json['assignedUser'] != null ? User.fromJson(json['assignedUser'] as JsonMap) : null,
	campaign: json['campaign'] != null ? MarketingCampaign.fromJson(json['campaign'] as JsonMap) : null,
	interestedListing: json['interestedListing'] != null ? Listing.fromJson(json['interestedListing'] as JsonMap) : null,
	interestedProperty: json['interestedProperty'] != null ? Property.fromJson(json['interestedProperty'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	source: json['source'] != null ? LeadSource.fromJson(json['source'] as JsonMap) : null,
	$aiScoresCount: json['_count']?['aiScores'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Lead copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? campaignId,
		Value<String?>? sourceId,
		Value<String?>? firstName,
		Value<String?>? lastName,
		Value<String?>? email,
		Value<String?>? phone,
		Value<double?>? budget,
		Value<String?>? timeline,
		Value<String?>? notes,
		Value<LeadStatus?>? status,
		Value<String?>? sourceDetail,
		Value<String?>? assignedToUserId,
		Value<String?>? assignedToContactId,
		Value<String?>? interestedPropertyId,
		Value<String?>? interestedListingId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? agentTeamId,
		Value<List<AILeadScore>?>? aiScores,
		Value<AgentTeam?>? agentTeam,
		Value<Contact?>? assignedContact,
		Value<User?>? assignedUser,
		Value<MarketingCampaign?>? campaign,
		Value<Listing?>? interestedListing,
		Value<Property?>? interestedProperty,
		Value<Organization?>? org,
		Value<LeadSource?>? source,
		int? $aiScoresCount,
        }) {
        return Lead(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		campaignId: campaignId != null ? campaignId.value : this.campaignId,
		sourceId: sourceId != null ? sourceId.value : this.sourceId,
		firstName: firstName != null ? firstName.value : this.firstName,
		lastName: lastName != null ? lastName.value : this.lastName,
		email: email != null ? email.value : this.email,
		phone: phone != null ? phone.value : this.phone,
		budget: budget != null ? budget.value : this.budget,
		timeline: timeline != null ? timeline.value : this.timeline,
		notes: notes != null ? notes.value : this.notes,
		status: status != null ? status.value : this.status,
		sourceDetail: sourceDetail != null ? sourceDetail.value : this.sourceDetail,
		assignedToUserId: assignedToUserId != null ? assignedToUserId.value : this.assignedToUserId,
		assignedToContactId: assignedToContactId != null ? assignedToContactId.value : this.assignedToContactId,
		interestedPropertyId: interestedPropertyId != null ? interestedPropertyId.value : this.interestedPropertyId,
		interestedListingId: interestedListingId != null ? interestedListingId.value : this.interestedListingId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		agentTeamId: agentTeamId != null ? agentTeamId.value : this.agentTeamId,
		aiScores: aiScores != null ? aiScores.value : this.aiScores,
		agentTeam: agentTeam != null ? agentTeam.value : this.agentTeam,
		assignedContact: assignedContact != null ? assignedContact.value : this.assignedContact,
		assignedUser: assignedUser != null ? assignedUser.value : this.assignedUser,
		campaign: campaign != null ? campaign.value : this.campaign,
		interestedListing: interestedListing != null ? interestedListing.value : this.interestedListing,
		interestedProperty: interestedProperty != null ? interestedProperty.value : this.interestedProperty,
		org: org != null ? org.value : this.org,
		source: source != null ? source.value : this.source,
		$aiScoresCount: $aiScoresCount ?? this.$aiScoresCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Lead copyWithInstanceValues(Lead lead) {
        return Lead(
            id: lead.id ?? id,
		orgId: lead.orgId ?? orgId,
		campaignId: lead.campaignId ?? campaignId,
		sourceId: lead.sourceId ?? sourceId,
		firstName: lead.firstName ?? firstName,
		lastName: lead.lastName ?? lastName,
		email: lead.email ?? email,
		phone: lead.phone ?? phone,
		budget: lead.budget ?? budget,
		timeline: lead.timeline ?? timeline,
		notes: lead.notes ?? notes,
		status: lead.status ?? status,
		sourceDetail: lead.sourceDetail ?? sourceDetail,
		assignedToUserId: lead.assignedToUserId ?? assignedToUserId,
		assignedToContactId: lead.assignedToContactId ?? assignedToContactId,
		interestedPropertyId: lead.interestedPropertyId ?? interestedPropertyId,
		interestedListingId: lead.interestedListingId ?? interestedListingId,
		createdAt: lead.createdAt ?? createdAt,
		updatedAt: lead.updatedAt ?? updatedAt,
		deletedAt: lead.deletedAt ?? deletedAt,
		agentTeamId: lead.agentTeamId ?? agentTeamId,
		aiScores: lead.aiScores ?? aiScores,
		agentTeam: lead.agentTeam ?? agentTeam,
		assignedContact: lead.assignedContact ?? assignedContact,
		assignedUser: lead.assignedUser ?? assignedUser,
		campaign: lead.campaign ?? campaign,
		interestedListing: lead.interestedListing ?? interestedListing,
		interestedProperty: lead.interestedProperty ?? interestedProperty,
		org: lead.org ?? org,
		source: lead.source ?? source,
		$aiScoresCount: lead.$aiScoresCount ?? $aiScoresCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Lead mergeWithInstanceValues(Lead lead) {
        return Lead(
            id: lead.$assignedFields.contains('id') ? lead.id : id,
		orgId: lead.$assignedFields.contains('orgId') ? lead.orgId : orgId,
		campaignId: lead.$assignedFields.contains('campaignId') ? lead.campaignId : campaignId,
		sourceId: lead.$assignedFields.contains('sourceId') ? lead.sourceId : sourceId,
		firstName: lead.$assignedFields.contains('firstName') ? lead.firstName : firstName,
		lastName: lead.$assignedFields.contains('lastName') ? lead.lastName : lastName,
		email: lead.$assignedFields.contains('email') ? lead.email : email,
		phone: lead.$assignedFields.contains('phone') ? lead.phone : phone,
		budget: lead.$assignedFields.contains('budget') ? lead.budget : budget,
		timeline: lead.$assignedFields.contains('timeline') ? lead.timeline : timeline,
		notes: lead.$assignedFields.contains('notes') ? lead.notes : notes,
		status: lead.$assignedFields.contains('status') ? lead.status : status,
		sourceDetail: lead.$assignedFields.contains('sourceDetail') ? lead.sourceDetail : sourceDetail,
		assignedToUserId: lead.$assignedFields.contains('assignedToUserId') ? lead.assignedToUserId : assignedToUserId,
		assignedToContactId: lead.$assignedFields.contains('assignedToContactId') ? lead.assignedToContactId : assignedToContactId,
		interestedPropertyId: lead.$assignedFields.contains('interestedPropertyId') ? lead.interestedPropertyId : interestedPropertyId,
		interestedListingId: lead.$assignedFields.contains('interestedListingId') ? lead.interestedListingId : interestedListingId,
		createdAt: lead.$assignedFields.contains('createdAt') ? lead.createdAt : createdAt,
		updatedAt: lead.$assignedFields.contains('updatedAt') ? lead.updatedAt : updatedAt,
		deletedAt: lead.$assignedFields.contains('deletedAt') ? lead.deletedAt : deletedAt,
		agentTeamId: lead.$assignedFields.contains('agentTeamId') ? lead.agentTeamId : agentTeamId,
		aiScores: (lead.$assignedFields.contains('aiScores') && lead.aiScores != null) ? mergeModelLists(aiScores, lead.aiScores) : aiScores,
		agentTeam: lead.$assignedFields.contains('agentTeam') ? lead.agentTeam : agentTeam,
		assignedContact: lead.$assignedFields.contains('assignedContact') ? lead.assignedContact : assignedContact,
		assignedUser: lead.$assignedFields.contains('assignedUser') ? lead.assignedUser : assignedUser,
		campaign: lead.$assignedFields.contains('campaign') ? lead.campaign : campaign,
		interestedListing: lead.$assignedFields.contains('interestedListing') ? lead.interestedListing : interestedListing,
		interestedProperty: lead.$assignedFields.contains('interestedProperty') ? lead.interestedProperty : interestedProperty,
		org: lead.$assignedFields.contains('org') ? lead.org : org,
		source: lead.$assignedFields.contains('source') ? lead.source : source,
		$aiScoresCount: lead.$aiScoresCount ?? $aiScoresCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Lead updateWithInstanceValues(Lead lead) {
        if (lead.$assignedFields.contains('id')) { id = lead.id; }
		if (lead.$assignedFields.contains('orgId')) { orgId = lead.orgId; }
		if (lead.$assignedFields.contains('campaignId')) { campaignId = lead.campaignId; }
		if (lead.$assignedFields.contains('sourceId')) { sourceId = lead.sourceId; }
		if (lead.$assignedFields.contains('firstName')) { firstName = lead.firstName; }
		if (lead.$assignedFields.contains('lastName')) { lastName = lead.lastName; }
		if (lead.$assignedFields.contains('email')) { email = lead.email; }
		if (lead.$assignedFields.contains('phone')) { phone = lead.phone; }
		if (lead.$assignedFields.contains('budget')) { budget = lead.budget; }
		if (lead.$assignedFields.contains('timeline')) { timeline = lead.timeline; }
		if (lead.$assignedFields.contains('notes')) { notes = lead.notes; }
		if (lead.$assignedFields.contains('status')) { status = lead.status; }
		if (lead.$assignedFields.contains('sourceDetail')) { sourceDetail = lead.sourceDetail; }
		if (lead.$assignedFields.contains('assignedToUserId')) { assignedToUserId = lead.assignedToUserId; }
		if (lead.$assignedFields.contains('assignedToContactId')) { assignedToContactId = lead.assignedToContactId; }
		if (lead.$assignedFields.contains('interestedPropertyId')) { interestedPropertyId = lead.interestedPropertyId; }
		if (lead.$assignedFields.contains('interestedListingId')) { interestedListingId = lead.interestedListingId; }
		if (lead.$assignedFields.contains('createdAt')) { createdAt = lead.createdAt; }
		if (lead.$assignedFields.contains('updatedAt')) { updatedAt = lead.updatedAt; }
		if (lead.$assignedFields.contains('deletedAt')) { deletedAt = lead.deletedAt; }
		if (lead.$assignedFields.contains('agentTeamId')) { agentTeamId = lead.agentTeamId; }
		if (lead.$assignedFields.contains('aiScores') && lead.aiScores != null) { aiScores = mergeModelLists(aiScores, lead.aiScores); }
		if (lead.$assignedFields.contains('agentTeam')) { agentTeam = lead.agentTeam; }
		if (lead.$assignedFields.contains('assignedContact')) { assignedContact = lead.assignedContact; }
		if (lead.$assignedFields.contains('assignedUser')) { assignedUser = lead.assignedUser; }
		if (lead.$assignedFields.contains('campaign')) { campaign = lead.campaign; }
		if (lead.$assignedFields.contains('interestedListing')) { interestedListing = lead.interestedListing; }
		if (lead.$assignedFields.contains('interestedProperty')) { interestedProperty = lead.interestedProperty; }
		if (lead.$assignedFields.contains('org')) { org = lead.org; }
		if (lead.$assignedFields.contains('source')) { source = lead.source; }
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
          ? {...?serializedTypes, 'Lead'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(campaignId != null) 'campaignId': campaignId,
	if(sourceId != null) 'sourceId': sourceId,
	if(firstName != null) 'firstName': firstName,
	if(lastName != null) 'lastName': lastName,
	if(email != null) 'email': email,
	if(phone != null) 'phone': phone,
	if(budget != null) 'budget': budget,
	if(timeline != null) 'timeline': timeline,
	if(notes != null) 'notes': notes,
	if(status != null) 'status': status?.toJson(),
	if(sourceDetail != null) 'sourceDetail': sourceDetail,
	if(assignedToUserId != null) 'assignedToUserId': assignedToUserId,
	if(assignedToContactId != null) 'assignedToContactId': assignedToContactId,
	if(interestedPropertyId != null) 'interestedPropertyId': interestedPropertyId,
	if(interestedListingId != null) 'interestedListingId': interestedListingId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(agentTeamId != null) 'agentTeamId': agentTeamId,
	if(aiScores != null && (!preventCircularSerialization || !serializedModels.contains('AILeadScore'))) 'aiScores': aiScores?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agentTeam != null && (!preventCircularSerialization || !serializedModels.contains('AgentTeam'))) 'agentTeam': agentTeam?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(assignedContact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'assignedContact': assignedContact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(assignedUser != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'assignedUser': assignedUser?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(campaign != null && (!preventCircularSerialization || !serializedModels.contains('MarketingCampaign'))) 'campaign': campaign?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(interestedListing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'interestedListing': interestedListing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(interestedProperty != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'interestedProperty': interestedProperty?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(source != null && (!preventCircularSerialization || !serializedModels.contains('LeadSource'))) 'source': source?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($aiScoresCount != null) '_count': { 
		if ($aiScoresCount != null) 'aiScores': $aiScoresCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Lead &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    