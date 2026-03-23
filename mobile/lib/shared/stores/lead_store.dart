
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class LeadStore extends ModelStreamStore<String, Lead> {

  static LeadStore? _instance;

  static LeadStore get instance {
    _instance ??= LeadStore();
    return _instance!;
  }

  LeadStore() : super(Lead.fromJson) {
    if (_instance != null) {
        throw Exception(
            'LeadStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending LeadStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use LeadStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getLeadId(Lead lead) => lead.id;

	String? getLeadOrgId(Lead lead) => lead.orgId;

	String? getLeadCampaignId(Lead lead) => lead.campaignId;

	String? getLeadSourceId(Lead lead) => lead.sourceId;

	String? getLeadFirstName(Lead lead) => lead.firstName;

	String? getLeadLastName(Lead lead) => lead.lastName;

	String? getLeadEmail(Lead lead) => lead.email;

	String? getLeadPhone(Lead lead) => lead.phone;

	double? getLeadBudget(Lead lead) => lead.budget;

	String? getLeadTimeline(Lead lead) => lead.timeline;

	String? getLeadNotes(Lead lead) => lead.notes;

	LeadStatus? getLeadStatus(Lead lead) => lead.status;

	String? getLeadSourceDetail(Lead lead) => lead.sourceDetail;

	String? getLeadAssignedToUserId(Lead lead) => lead.assignedToUserId;

	String? getLeadAssignedToContactId(Lead lead) => lead.assignedToContactId;

	String? getLeadInterestedPropertyId(Lead lead) => lead.interestedPropertyId;

	String? getLeadInterestedListingId(Lead lead) => lead.interestedListingId;

	DateTime? getLeadCreatedAt(Lead lead) => lead.createdAt;

	DateTime? getLeadUpdatedAt(Lead lead) => lead.updatedAt;

	DateTime? getLeadDeletedAt(Lead lead) => lead.deletedAt;

	String? getLeadAgentTeamId(Lead lead) => lead.agentTeamId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Lead> getByOrgId(
    String orgId,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByCampaignId(
    String campaignId,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadCampaignId, campaignId, modelFilter: modelFilter, includes: includes);

	
List<Lead> getBySourceId(
    String sourceId,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadSourceId, sourceId, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByFirstName(
    String firstName,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadFirstName, firstName, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByLastName(
    String lastName,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadLastName, lastName, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByEmail(
    String email,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadEmail, email, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByPhone(
    String phone,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadPhone, phone, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByBudget(
    double budget,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadBudget, budget, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByTimeline(
    String timeline,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadTimeline, timeline, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByNotes(
    String notes,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByStatus(
    LeadStatus status,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Lead> getBySourceDetail(
    String sourceDetail,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadSourceDetail, sourceDetail, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByAssignedToUserId(
    String assignedToUserId,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadAssignedToUserId, assignedToUserId, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByAssignedToContactId(
    String assignedToContactId,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadAssignedToContactId, assignedToContactId, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByInterestedPropertyId(
    String interestedPropertyId,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadInterestedPropertyId, interestedPropertyId, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByInterestedListingId(
    String interestedListingId,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadInterestedListingId, interestedListingId, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Lead> getByAgentTeamId(
    String agentTeamId,
    {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}
    ) =>
    getManyIncluding(getLeadAgentTeamId, agentTeamId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  AgentTeam? getAgentTeam(
    Lead lead, {ModelFilter? modelFilter, List<AgentTeamInclude>? includes}) {
    if (lead.agentTeamId == null) {
        return null;
    } else {
        final agentTeam = AgentTeamStore.instance.getById(lead.agentTeamId!, includes: includes);
        lead.agentTeam = agentTeam;
        // setIncludedReferences(agentTeam, includes: includes);
        return agentTeam;
    }
}

	Contact? getAssignedContact(
    Lead lead, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (lead.assignedToContactId == null) {
        return null;
    } else {
        final assignedContact = ContactStore.instance.getById(lead.assignedToContactId!, includes: includes);
        lead.assignedContact = assignedContact;
        // setIncludedReferences(assignedContact, includes: includes);
        return assignedContact;
    }
}

	User? getAssignedUser(
    Lead lead, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (lead.assignedToUserId == null) {
        return null;
    } else {
        final assignedUser = UserStore.instance.getById(lead.assignedToUserId!, includes: includes);
        lead.assignedUser = assignedUser;
        // setIncludedReferences(assignedUser, includes: includes);
        return assignedUser;
    }
}

	MarketingCampaign? getCampaign(
    Lead lead, {ModelFilter? modelFilter, List<MarketingCampaignInclude>? includes}) {
    if (lead.campaignId == null) {
        return null;
    } else {
        final campaign = MarketingCampaignStore.instance.getById(lead.campaignId!, includes: includes);
        lead.campaign = campaign;
        // setIncludedReferences(campaign, includes: includes);
        return campaign;
    }
}

	Listing? getInterestedListing(
    Lead lead, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (lead.interestedListingId == null) {
        return null;
    } else {
        final interestedListing = ListingStore.instance.getById(lead.interestedListingId!, includes: includes);
        lead.interestedListing = interestedListing;
        // setIncludedReferences(interestedListing, includes: includes);
        return interestedListing;
    }
}

	Property? getInterestedProperty(
    Lead lead, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (lead.interestedPropertyId == null) {
        return null;
    } else {
        final interestedProperty = PropertyStore.instance.getById(lead.interestedPropertyId!, includes: includes);
        lead.interestedProperty = interestedProperty;
        // setIncludedReferences(interestedProperty, includes: includes);
        return interestedProperty;
    }
}

	Organization? getOrg(
    Lead lead, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (lead.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(lead.orgId!, includes: includes);
        lead.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	LeadSource? getSource(
    Lead lead, {ModelFilter? modelFilter, List<LeadSourceInclude>? includes}) {
    if (lead.sourceId == null) {
        return null;
    } else {
        final source = LeadSourceStore.instance.getById(lead.sourceId!, includes: includes);
        lead.source = source;
        // setIncludedReferences(source, includes: includes);
        return source;
    }
}

  /// GET RELATED MODELS 

  List<AILeadScore> getAiScores(
    Lead lead, {ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}) {
    final aiScores = AILeadScoreStore.instance.getByLeadId(lead.$uid!, modelFilter: modelFilter, includes: includes);
    lead.aiScores = aiScores;
    // setIncludedReferencesForList(aiScores, includes: includes);
    return aiScores;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Lead>> getAll$({bool useCache = true, ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: LeadEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Lead?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getLeadId,
        value: id,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Lead>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByCampaignId$(
        String campaignId,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadCampaignId,
        value: campaignId,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByCampaignId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getBySourceId$(
        String sourceId,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadSourceId,
        value: sourceId,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyBySourceId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByFirstName$(
        String firstName,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadFirstName,
        value: firstName,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByFirstName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByLastName$(
        String lastName,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadLastName,
        value: lastName,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByLastName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByEmail$(
        String email,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadEmail,
        value: email,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByPhone$(
        String phone,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadPhone,
        value: phone,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByPhone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByBudget$(
        double budget,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLeadBudget,
        value: budget,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByBudget,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByTimeline$(
        String timeline,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadTimeline,
        value: timeline,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByTimeline,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByStatus$(
        LeadStatus status,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<LeadStatus>(
        getPropVal: getLeadStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getBySourceDetail$(
        String sourceDetail,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadSourceDetail,
        value: sourceDetail,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyBySourceDetail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByAssignedToUserId$(
        String assignedToUserId,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadAssignedToUserId,
        value: assignedToUserId,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByAssignedToUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByAssignedToContactId$(
        String assignedToContactId,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadAssignedToContactId,
        value: assignedToContactId,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByAssignedToContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByInterestedPropertyId$(
        String interestedPropertyId,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadInterestedPropertyId,
        value: interestedPropertyId,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByInterestedPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByInterestedListingId$(
        String interestedListingId,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadInterestedListingId,
        value: interestedListingId,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByInterestedListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeadCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeadUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeadDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Lead>> getByAgentTeamId$(
        String agentTeamId,
        {bool useCache = true,
        ModelFilter<Lead>? modelFilter,
        List<LeadInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadAgentTeamId,
        value: agentTeamId,
        modelFilter: modelFilter,
        endpoint: LeadEndpoints.getManyByAgentTeamId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<AgentTeam?> getAgentTeam$(
    Lead lead, {bool useCache = true, ModelFilter<AgentTeam>? modelFilter, List<AgentTeamInclude>? includes}) {
    if (lead.agentTeamId == null) {
        return Stream.value(null);
    } else {
        return AgentTeamStore.instance.getById$(
            lead.agentTeamId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((agentTeam) {
            lead.agentTeam = agentTeam;
        });
    }
}

	Stream<Contact?> getAssignedContact$(
    Lead lead, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (lead.assignedToContactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            lead.assignedToContactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((assignedContact) {
            lead.assignedContact = assignedContact;
        });
    }
}

	Stream<User?> getAssignedUser$(
    Lead lead, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (lead.assignedToUserId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            lead.assignedToUserId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((assignedUser) {
            lead.assignedUser = assignedUser;
        });
    }
}

	Stream<MarketingCampaign?> getCampaign$(
    Lead lead, {bool useCache = true, ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}) {
    if (lead.campaignId == null) {
        return Stream.value(null);
    } else {
        return MarketingCampaignStore.instance.getById$(
            lead.campaignId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((campaign) {
            lead.campaign = campaign;
        });
    }
}

	Stream<Listing?> getInterestedListing$(
    Lead lead, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (lead.interestedListingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            lead.interestedListingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((interestedListing) {
            lead.interestedListing = interestedListing;
        });
    }
}

	Stream<Property?> getInterestedProperty$(
    Lead lead, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (lead.interestedPropertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            lead.interestedPropertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((interestedProperty) {
            lead.interestedProperty = interestedProperty;
        });
    }
}

	Stream<Organization?> getOrg$(
    Lead lead, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (lead.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            lead.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            lead.org = org;
        });
    }
}

	Stream<LeadSource?> getSource$(
    Lead lead, {bool useCache = true, ModelFilter<LeadSource>? modelFilter, List<LeadSourceInclude>? includes}) {
    if (lead.sourceId == null) {
        return Stream.value(null);
    } else {
        return LeadSourceStore.instance.getById$(
            lead.sourceId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((source) {
            lead.source = source;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<AILeadScore>> getAiScores$(
    Lead lead, {bool useCache = true, ModelFilter<AILeadScore>? modelFilter, List<AILeadScoreInclude>? includes}) {
    return AILeadScoreStore.instance.getByLeadId$(
        lead.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiScores) {
        lead.aiScores = aiScores;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Lead recursiveUpsert(Lead lead, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Lead'} 
        : const {};
    if (lead.aiScores != null && (!preventCircularSerialization || !upsertedTypes.contains('AILeadScore'))) {
        lead.aiScores = AILeadScoreStore.instance.recursiveListUpsert(lead.aiScores!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lead.agentTeam != null && (!preventCircularSerialization || !upsertedTypes.contains('AgentTeam'))) {
        lead.agentTeam = AgentTeamStore.instance.recursiveUpsert(lead.agentTeam!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lead.assignedContact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        lead.assignedContact = ContactStore.instance.recursiveUpsert(lead.assignedContact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lead.assignedUser != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        lead.assignedUser = UserStore.instance.recursiveUpsert(lead.assignedUser!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lead.campaign != null && (!preventCircularSerialization || !upsertedTypes.contains('MarketingCampaign'))) {
        lead.campaign = MarketingCampaignStore.instance.recursiveUpsert(lead.campaign!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lead.interestedListing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        lead.interestedListing = ListingStore.instance.recursiveUpsert(lead.interestedListing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lead.interestedProperty != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        lead.interestedProperty = PropertyStore.instance.recursiveUpsert(lead.interestedProperty!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lead.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        lead.org = OrganizationStore.instance.recursiveUpsert(lead.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (lead.source != null && (!preventCircularSerialization || !upsertedTypes.contains('LeadSource'))) {
        lead.source = LeadSourceStore.instance.recursiveUpsert(lead.source!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(lead);
}

  List<Lead> recursiveListUpsert(List<Lead> leads, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedLeads = <Lead>[];
    for (var lead in leads) {
        updatedLeads.add(recursiveUpsert(lead, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedLeads;
}

//   @override
//   Lead upsert(Lead item) {
//     return recursiveUpsert(item);
//   }

}


class LeadInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      LeadInclude.aiScores({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AILeadScore>? modelFilter,
    List<AILeadScoreInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lead) => LeadStore.instance
            .getAiScores$(lead, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lead) => LeadStore.instance
            .getAiScores(lead, modelFilter: modelFilter, includes: includes);
      }
}

	LeadInclude.agentTeam({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AgentTeam>? modelFilter,
    List<AgentTeamInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lead) => LeadStore.instance
            .getAgentTeam$(lead, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lead) => LeadStore.instance
            .getAgentTeam(lead, modelFilter: modelFilter, includes: includes);
      }
}

	LeadInclude.assignedContact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lead) => LeadStore.instance
            .getAssignedContact$(lead, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lead) => LeadStore.instance
            .getAssignedContact(lead, modelFilter: modelFilter, includes: includes);
      }
}

	LeadInclude.assignedUser({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lead) => LeadStore.instance
            .getAssignedUser$(lead, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lead) => LeadStore.instance
            .getAssignedUser(lead, modelFilter: modelFilter, includes: includes);
      }
}

	LeadInclude.campaign({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MarketingCampaign>? modelFilter,
    List<MarketingCampaignInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lead) => LeadStore.instance
            .getCampaign$(lead, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lead) => LeadStore.instance
            .getCampaign(lead, modelFilter: modelFilter, includes: includes);
      }
}

	LeadInclude.interestedListing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lead) => LeadStore.instance
            .getInterestedListing$(lead, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lead) => LeadStore.instance
            .getInterestedListing(lead, modelFilter: modelFilter, includes: includes);
      }
}

	LeadInclude.interestedProperty({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lead) => LeadStore.instance
            .getInterestedProperty$(lead, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lead) => LeadStore.instance
            .getInterestedProperty(lead, modelFilter: modelFilter, includes: includes);
      }
}

	LeadInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lead) => LeadStore.instance
            .getOrg$(lead, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lead) => LeadStore.instance
            .getOrg(lead, modelFilter: modelFilter, includes: includes);
      }
}

	LeadInclude.source({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<LeadSource>? modelFilter,
    List<LeadSourceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (lead) => LeadStore.instance
            .getSource$(lead, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (lead) => LeadStore.instance
            .getSource(lead, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum LeadEndpoints implements Endpoint {

    getAll('/lead', HttpMethod.post, List<Lead>),
	getById('/lead/byId/:id', HttpMethod.post, Lead),
	getManyByOrgId('/lead/byOrgId/:orgId', HttpMethod.post, List<Lead>),
	getManyByCampaignId('/lead/byCampaignId/:campaignId', HttpMethod.post, List<Lead>),
	getManyBySourceId('/lead/bySourceId/:sourceId', HttpMethod.post, List<Lead>),
	getManyByFirstName('/lead/byFirstName/:firstName', HttpMethod.post, List<Lead>),
	getManyByLastName('/lead/byLastName/:lastName', HttpMethod.post, List<Lead>),
	getManyByEmail('/lead/byEmail/:email', HttpMethod.post, List<Lead>),
	getManyByPhone('/lead/byPhone/:phone', HttpMethod.post, List<Lead>),
	getManyByBudget('/lead/byBudget/:budget', HttpMethod.post, List<Lead>),
	getManyByTimeline('/lead/byTimeline/:timeline', HttpMethod.post, List<Lead>),
	getManyByNotes('/lead/byNotes/:notes', HttpMethod.post, List<Lead>),
	getManyByStatus('/lead/byStatus/:status', HttpMethod.post, List<Lead>),
	getManyBySourceDetail('/lead/bySourceDetail/:sourceDetail', HttpMethod.post, List<Lead>),
	getManyByAssignedToUserId('/lead/byAssignedToUserId/:assignedToUserId', HttpMethod.post, List<Lead>),
	getManyByAssignedToContactId('/lead/byAssignedToContactId/:assignedToContactId', HttpMethod.post, List<Lead>),
	getManyByInterestedPropertyId('/lead/byInterestedPropertyId/:interestedPropertyId', HttpMethod.post, List<Lead>),
	getManyByInterestedListingId('/lead/byInterestedListingId/:interestedListingId', HttpMethod.post, List<Lead>),
	getManyByCreatedAt('/lead/byCreatedAt/:createdAt', HttpMethod.post, List<Lead>),
	getManyByUpdatedAt('/lead/byUpdatedAt/:updatedAt', HttpMethod.post, List<Lead>),
	getManyByDeletedAt('/lead/byDeletedAt/:deletedAt', HttpMethod.post, List<Lead>),
	getManyByAgentTeamId('/lead/byAgentTeamId/:agentTeamId', HttpMethod.post, List<Lead>);

    const LeadEndpoints(this.path, this.method, this.responseType);

    @override
  final String path;

  @override
  final HttpMethod method;

  final Type responseType;

  static String withPathParameter(String path, dynamic param) {
    final regex = RegExp(r':([a-zA-Z]+)');
    return path.replaceFirst(regex, param.toString());
  }
}
