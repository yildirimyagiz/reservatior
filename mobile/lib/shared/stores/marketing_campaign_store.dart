
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MarketingCampaignStore extends ModelStreamStore<String, MarketingCampaign> {

  static MarketingCampaignStore? _instance;

  static MarketingCampaignStore get instance {
    _instance ??= MarketingCampaignStore();
    return _instance!;
  }

  MarketingCampaignStore() : super(MarketingCampaign.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MarketingCampaignStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MarketingCampaignStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MarketingCampaignStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMarketingCampaignId(MarketingCampaign marketingCampaign) => marketingCampaign.id;

	String? getMarketingCampaignOrgId(MarketingCampaign marketingCampaign) => marketingCampaign.orgId;

	String? getMarketingCampaignName(MarketingCampaign marketingCampaign) => marketingCampaign.name;

	CampaignType? getMarketingCampaignType(MarketingCampaign marketingCampaign) => marketingCampaign.type;

	CampaignStatus? getMarketingCampaignStatus(MarketingCampaign marketingCampaign) => marketingCampaign.status;

	String? getMarketingCampaignTargetType(MarketingCampaign marketingCampaign) => marketingCampaign.targetType;

	List<String>? getMarketingCampaignTargetIds(MarketingCampaign marketingCampaign) => marketingCampaign.targetIds;

	String? getMarketingCampaignSubject(MarketingCampaign marketingCampaign) => marketingCampaign.subject;

	String? getMarketingCampaignContent(MarketingCampaign marketingCampaign) => marketingCampaign.content;

	String? getMarketingCampaignTemplateId(MarketingCampaign marketingCampaign) => marketingCampaign.templateId;

	DateTime? getMarketingCampaignScheduledAt(MarketingCampaign marketingCampaign) => marketingCampaign.scheduledAt;

	DateTime? getMarketingCampaignSentAt(MarketingCampaign marketingCampaign) => marketingCampaign.sentAt;

	DateTime? getMarketingCampaignCompletedAt(MarketingCampaign marketingCampaign) => marketingCampaign.completedAt;

	int? getMarketingCampaignSentCount(MarketingCampaign marketingCampaign) => marketingCampaign.sentCount;

	int? getMarketingCampaignOpenCount(MarketingCampaign marketingCampaign) => marketingCampaign.openCount;

	int? getMarketingCampaignClickCount(MarketingCampaign marketingCampaign) => marketingCampaign.clickCount;

	int? getMarketingCampaignConversionCount(MarketingCampaign marketingCampaign) => marketingCampaign.conversionCount;

	double? getMarketingCampaignBudget(MarketingCampaign marketingCampaign) => marketingCampaign.budget;

	double? getMarketingCampaignActualSpend(MarketingCampaign marketingCampaign) => marketingCampaign.actualSpend;

	String? getMarketingCampaignObjective(MarketingCampaign marketingCampaign) => marketingCampaign.objective;

	DateTime? getMarketingCampaignCreatedAt(MarketingCampaign marketingCampaign) => marketingCampaign.createdAt;

	DateTime? getMarketingCampaignUpdatedAt(MarketingCampaign marketingCampaign) => marketingCampaign.updatedAt;

	DateTime? getMarketingCampaignDeletedAt(MarketingCampaign marketingCampaign) => marketingCampaign.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MarketingCampaign> getByOrgId(
    String orgId,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByName(
    String name,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignName, name, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByType(
    CampaignType type,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignType, type, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByStatus(
    CampaignStatus status,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignStatus, status, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByTargetType(
    String targetType,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignTargetType, targetType, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByTargetIds(
    String targetIds,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignTargetIds, targetIds, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getBySubject(
    String subject,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignSubject, subject, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByContent(
    String content,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignContent, content, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByTemplateId(
    String templateId,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignTemplateId, templateId, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByScheduledAt(
    DateTime scheduledAt,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignScheduledAt, scheduledAt, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getBySentAt(
    DateTime sentAt,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignSentAt, sentAt, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByCompletedAt(
    DateTime completedAt,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignCompletedAt, completedAt, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getBySentCount(
    int sentCount,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignSentCount, sentCount, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByOpenCount(
    int openCount,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignOpenCount, openCount, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByClickCount(
    int clickCount,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignClickCount, clickCount, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByConversionCount(
    int conversionCount,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignConversionCount, conversionCount, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByBudget(
    double budget,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignBudget, budget, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByActualSpend(
    double actualSpend,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignActualSpend, actualSpend, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByObjective(
    String objective,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignObjective, objective, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<MarketingCampaign> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}
    ) =>
    getManyIncluding(getMarketingCampaignDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    MarketingCampaign marketingCampaign, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (marketingCampaign.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(marketingCampaign.orgId!, includes: includes);
        marketingCampaign.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<Lead> getLeads(
    MarketingCampaign marketingCampaign, {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    final leads = LeadStore.instance.getByCampaignId(marketingCampaign.$uid!, modelFilter: modelFilter, includes: includes);
    marketingCampaign.leads = leads;
    // setIncludedReferencesForList(leads, includes: includes);
    return leads;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MarketingCampaign>> getAll$({bool useCache = true, ModelFilter<MarketingCampaign>? modelFilter, List<MarketingCampaignInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MarketingCampaignEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MarketingCampaign?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMarketingCampaignId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MarketingCampaign>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMarketingCampaignOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMarketingCampaignName,
        value: name,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByType$(
        CampaignType type,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<CampaignType>(
        getPropVal: getMarketingCampaignType,
        value: type,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByStatus$(
        CampaignStatus status,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<CampaignStatus>(
        getPropVal: getMarketingCampaignStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByTargetType$(
        String targetType,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMarketingCampaignTargetType,
        value: targetType,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByTargetType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByTargetIds$(
        String targetIds,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMarketingCampaignTargetIds,
        value: targetIds,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByTargetIds,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getBySubject$(
        String subject,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMarketingCampaignSubject,
        value: subject,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyBySubject,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByContent$(
        String content,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMarketingCampaignContent,
        value: content,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByContent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByTemplateId$(
        String templateId,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMarketingCampaignTemplateId,
        value: templateId,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByTemplateId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByScheduledAt$(
        DateTime scheduledAt,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMarketingCampaignScheduledAt,
        value: scheduledAt,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByScheduledAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getBySentAt$(
        DateTime sentAt,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMarketingCampaignSentAt,
        value: sentAt,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyBySentAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByCompletedAt$(
        DateTime completedAt,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMarketingCampaignCompletedAt,
        value: completedAt,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByCompletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getBySentCount$(
        int sentCount,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMarketingCampaignSentCount,
        value: sentCount,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyBySentCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByOpenCount$(
        int openCount,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMarketingCampaignOpenCount,
        value: openCount,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByOpenCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByClickCount$(
        int clickCount,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMarketingCampaignClickCount,
        value: clickCount,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByClickCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByConversionCount$(
        int conversionCount,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMarketingCampaignConversionCount,
        value: conversionCount,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByConversionCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByBudget$(
        double budget,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMarketingCampaignBudget,
        value: budget,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByBudget,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByActualSpend$(
        double actualSpend,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMarketingCampaignActualSpend,
        value: actualSpend,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByActualSpend,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByObjective$(
        String objective,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMarketingCampaignObjective,
        value: objective,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByObjective,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMarketingCampaignCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMarketingCampaignUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MarketingCampaign>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<MarketingCampaign>? modelFilter,
        List<MarketingCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMarketingCampaignDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: MarketingCampaignEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    MarketingCampaign marketingCampaign, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (marketingCampaign.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            marketingCampaign.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            marketingCampaign.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Lead>> getLeads$(
    MarketingCampaign marketingCampaign, {bool useCache = true, ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    return LeadStore.instance.getByCampaignId$(
        marketingCampaign.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leads) {
        marketingCampaign.leads = leads;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
MarketingCampaign recursiveUpsert(MarketingCampaign marketingCampaign, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MarketingCampaign'} 
        : const {};
    if (marketingCampaign.leads != null && (!preventCircularSerialization || !upsertedTypes.contains('Lead'))) {
        marketingCampaign.leads = LeadStore.instance.recursiveListUpsert(marketingCampaign.leads!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (marketingCampaign.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        marketingCampaign.org = OrganizationStore.instance.recursiveUpsert(marketingCampaign.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(marketingCampaign);
}

  List<MarketingCampaign> recursiveListUpsert(List<MarketingCampaign> marketingCampaigns, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMarketingCampaigns = <MarketingCampaign>[];
    for (var marketingCampaign in marketingCampaigns) {
        updatedMarketingCampaigns.add(recursiveUpsert(marketingCampaign, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMarketingCampaigns;
}

//   @override
//   MarketingCampaign upsert(MarketingCampaign item) {
//     return recursiveUpsert(item);
//   }

}


class MarketingCampaignInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MarketingCampaignInclude.leads({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lead>? modelFilter,
    List<LeadInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (marketingCampaign) => MarketingCampaignStore.instance
            .getLeads$(marketingCampaign, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (marketingCampaign) => MarketingCampaignStore.instance
            .getLeads(marketingCampaign, modelFilter: modelFilter, includes: includes);
      }
}

	MarketingCampaignInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (marketingCampaign) => MarketingCampaignStore.instance
            .getOrg$(marketingCampaign, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (marketingCampaign) => MarketingCampaignStore.instance
            .getOrg(marketingCampaign, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MarketingCampaignEndpoints implements Endpoint {

    getAll('/marketingCampaign', HttpMethod.post, List<MarketingCampaign>),
	getById('/marketingCampaign/byId/:id', HttpMethod.post, MarketingCampaign),
	getManyByOrgId('/marketingCampaign/byOrgId/:orgId', HttpMethod.post, List<MarketingCampaign>),
	getManyByName('/marketingCampaign/byName/:name', HttpMethod.post, List<MarketingCampaign>),
	getManyByType('/marketingCampaign/byType/:type', HttpMethod.post, List<MarketingCampaign>),
	getManyByStatus('/marketingCampaign/byStatus/:status', HttpMethod.post, List<MarketingCampaign>),
	getManyByTargetType('/marketingCampaign/byTargetType/:targetType', HttpMethod.post, List<MarketingCampaign>),
	getManyByTargetIds('/marketingCampaign/byTargetIds/:targetIds', HttpMethod.post, List<MarketingCampaign>),
	getManyBySubject('/marketingCampaign/bySubject/:subject', HttpMethod.post, List<MarketingCampaign>),
	getManyByContent('/marketingCampaign/byContent/:content', HttpMethod.post, List<MarketingCampaign>),
	getManyByTemplateId('/marketingCampaign/byTemplateId/:templateId', HttpMethod.post, List<MarketingCampaign>),
	getManyByScheduledAt('/marketingCampaign/byScheduledAt/:scheduledAt', HttpMethod.post, List<MarketingCampaign>),
	getManyBySentAt('/marketingCampaign/bySentAt/:sentAt', HttpMethod.post, List<MarketingCampaign>),
	getManyByCompletedAt('/marketingCampaign/byCompletedAt/:completedAt', HttpMethod.post, List<MarketingCampaign>),
	getManyBySentCount('/marketingCampaign/bySentCount/:sentCount', HttpMethod.post, List<MarketingCampaign>),
	getManyByOpenCount('/marketingCampaign/byOpenCount/:openCount', HttpMethod.post, List<MarketingCampaign>),
	getManyByClickCount('/marketingCampaign/byClickCount/:clickCount', HttpMethod.post, List<MarketingCampaign>),
	getManyByConversionCount('/marketingCampaign/byConversionCount/:conversionCount', HttpMethod.post, List<MarketingCampaign>),
	getManyByBudget('/marketingCampaign/byBudget/:budget', HttpMethod.post, List<MarketingCampaign>),
	getManyByActualSpend('/marketingCampaign/byActualSpend/:actualSpend', HttpMethod.post, List<MarketingCampaign>),
	getManyByObjective('/marketingCampaign/byObjective/:objective', HttpMethod.post, List<MarketingCampaign>),
	getManyByCreatedAt('/marketingCampaign/byCreatedAt/:createdAt', HttpMethod.post, List<MarketingCampaign>),
	getManyByUpdatedAt('/marketingCampaign/byUpdatedAt/:updatedAt', HttpMethod.post, List<MarketingCampaign>),
	getManyByDeletedAt('/marketingCampaign/byDeletedAt/:deletedAt', HttpMethod.post, List<MarketingCampaign>);

    const MarketingCampaignEndpoints(this.path, this.method, this.responseType);

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
