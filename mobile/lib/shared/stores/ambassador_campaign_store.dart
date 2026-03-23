
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AmbassadorCampaignStore extends ModelStreamStore<String, AmbassadorCampaign> {

  static AmbassadorCampaignStore? _instance;

  static AmbassadorCampaignStore get instance {
    _instance ??= AmbassadorCampaignStore();
    return _instance!;
  }

  AmbassadorCampaignStore() : super(AmbassadorCampaign.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AmbassadorCampaignStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AmbassadorCampaignStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AmbassadorCampaignStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAmbassadorCampaignId(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.id;

	String? getAmbassadorCampaignOrgId(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.orgId;

	String? getAmbassadorCampaignAmbassadorId(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.ambassadorId;

	String? getAmbassadorCampaignName(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.name;

	String? getAmbassadorCampaignDescription(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.description;

	DateTime? getAmbassadorCampaignStartDate(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.startDate;

	DateTime? getAmbassadorCampaignEndDate(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.endDate;

	double? getAmbassadorCampaignBudget(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.budget;

	double? getAmbassadorCampaignActualSpend(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.actualSpend;

	String? getAmbassadorCampaignCurrency(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.currency;

	CampaignStatus? getAmbassadorCampaignStatus(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.status;

	int? getAmbassadorCampaignTargetReach(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.targetReach;

	int? getAmbassadorCampaignActualReach(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.actualReach;

	int? getAmbassadorCampaignImpressions(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.impressions;

	int? getAmbassadorCampaignClicks(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.clicks;

	int? getAmbassadorCampaignConversions(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.conversions;

	double? getAmbassadorCampaignConversionValue(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.conversionValue;

	double? getAmbassadorCampaignRoi(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.roi;

	dynamic? getAmbassadorCampaignContent(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.content;

	List<String>? getAmbassadorCampaignPlatforms(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.platforms;

	DateTime? getAmbassadorCampaignDeletedAt(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.deletedAt;

	DateTime? getAmbassadorCampaignCreatedAt(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.createdAt;

	DateTime? getAmbassadorCampaignUpdatedAt(AmbassadorCampaign ambassadorCampaign) => ambassadorCampaign.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AmbassadorCampaign> getByOrgId(
    String orgId,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByAmbassadorId(
    String ambassadorId,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignAmbassadorId, ambassadorId, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByName(
    String name,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignName, name, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByDescription(
    String description,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignDescription, description, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByStartDate(
    DateTime startDate,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByEndDate(
    DateTime endDate,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByBudget(
    double budget,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignBudget, budget, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByActualSpend(
    double actualSpend,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignActualSpend, actualSpend, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByCurrency(
    String currency,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByStatus(
    CampaignStatus status,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByTargetReach(
    int targetReach,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignTargetReach, targetReach, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByActualReach(
    int actualReach,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignActualReach, actualReach, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByImpressions(
    int impressions,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignImpressions, impressions, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByClicks(
    int clicks,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignClicks, clicks, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByConversions(
    int conversions,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignConversions, conversions, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByConversionValue(
    double conversionValue,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignConversionValue, conversionValue, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByRoi(
    double roi,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignRoi, roi, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByContent(
    dynamic content,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignContent, content, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByPlatforms(
    String platforms,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignPlatforms, platforms, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorCampaign> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorCampaignUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  BrandAmbassador? getAmbassador(
    AmbassadorCampaign ambassadorCampaign, {ModelFilter? modelFilter, List<BrandAmbassadorInclude>? includes}) {
    if (ambassadorCampaign.ambassadorId == null) {
        return null;
    } else {
        final ambassador = BrandAmbassadorStore.instance.getById(ambassadorCampaign.ambassadorId!, includes: includes);
        ambassadorCampaign.ambassador = ambassador;
        // setIncludedReferences(ambassador, includes: includes);
        return ambassador;
    }
}

	Organization? getOrg(
    AmbassadorCampaign ambassadorCampaign, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (ambassadorCampaign.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(ambassadorCampaign.orgId!, includes: includes);
        ambassadorCampaign.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<VideoContent> getVideoContents(
    AmbassadorCampaign ambassadorCampaign, {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    final videoContents = VideoContentStore.instance.getByAmbassadorCampaignId(ambassadorCampaign.$uid!, modelFilter: modelFilter, includes: includes);
    ambassadorCampaign.videoContents = videoContents;
    // setIncludedReferencesForList(videoContents, includes: includes);
    return videoContents;
}

	List<VideoContent> getCampaignVideos(
    AmbassadorCampaign ambassadorCampaign, {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    final campaignVideos = VideoContentStore.instance.getByCampaignId(ambassadorCampaign.$uid!, modelFilter: modelFilter, includes: includes);
    ambassadorCampaign.campaignVideos = campaignVideos;
    // setIncludedReferencesForList(campaignVideos, includes: includes);
    return campaignVideos;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AmbassadorCampaign>> getAll$({bool useCache = true, ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AmbassadorCampaignEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AmbassadorCampaign?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAmbassadorCampaignId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AmbassadorCampaign>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmbassadorCampaignOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByAmbassadorId$(
        String ambassadorId,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmbassadorCampaignAmbassadorId,
        value: ambassadorId,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByAmbassadorId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmbassadorCampaignName,
        value: name,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmbassadorCampaignDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmbassadorCampaignStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmbassadorCampaignEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByBudget$(
        double budget,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAmbassadorCampaignBudget,
        value: budget,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByBudget,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByActualSpend$(
        double actualSpend,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAmbassadorCampaignActualSpend,
        value: actualSpend,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByActualSpend,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmbassadorCampaignCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByStatus$(
        CampaignStatus status,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<CampaignStatus>(
        getPropVal: getAmbassadorCampaignStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByTargetReach$(
        int targetReach,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAmbassadorCampaignTargetReach,
        value: targetReach,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByTargetReach,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByActualReach$(
        int actualReach,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAmbassadorCampaignActualReach,
        value: actualReach,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByActualReach,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByImpressions$(
        int impressions,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAmbassadorCampaignImpressions,
        value: impressions,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByImpressions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByClicks$(
        int clicks,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAmbassadorCampaignClicks,
        value: clicks,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByClicks,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByConversions$(
        int conversions,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAmbassadorCampaignConversions,
        value: conversions,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByConversions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByConversionValue$(
        double conversionValue,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAmbassadorCampaignConversionValue,
        value: conversionValue,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByConversionValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByRoi$(
        double roi,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAmbassadorCampaignRoi,
        value: roi,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByRoi,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByContent$(
        dynamic content,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAmbassadorCampaignContent,
        value: content,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByContent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByPlatforms$(
        String platforms,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmbassadorCampaignPlatforms,
        value: platforms,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByPlatforms,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmbassadorCampaignDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmbassadorCampaignCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorCampaign>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AmbassadorCampaign>? modelFilter,
        List<AmbassadorCampaignInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmbassadorCampaignUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AmbassadorCampaignEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<BrandAmbassador?> getAmbassador$(
    AmbassadorCampaign ambassadorCampaign, {bool useCache = true, ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}) {
    if (ambassadorCampaign.ambassadorId == null) {
        return Stream.value(null);
    } else {
        return BrandAmbassadorStore.instance.getById$(
            ambassadorCampaign.ambassadorId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((ambassador) {
            ambassadorCampaign.ambassador = ambassador;
        });
    }
}

	Stream<Organization?> getOrg$(
    AmbassadorCampaign ambassadorCampaign, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (ambassadorCampaign.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            ambassadorCampaign.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            ambassadorCampaign.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<VideoContent>> getVideoContents$(
    AmbassadorCampaign ambassadorCampaign, {bool useCache = true, ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    return VideoContentStore.instance.getByAmbassadorCampaignId$(
        ambassadorCampaign.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((videoContents) {
        ambassadorCampaign.videoContents = videoContents;
    });

}

	Stream<List<VideoContent>> getCampaignVideos$(
    AmbassadorCampaign ambassadorCampaign, {bool useCache = true, ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    return VideoContentStore.instance.getByCampaignId$(
        ambassadorCampaign.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((campaignVideos) {
        ambassadorCampaign.campaignVideos = campaignVideos;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
AmbassadorCampaign recursiveUpsert(AmbassadorCampaign ambassadorCampaign, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AmbassadorCampaign'} 
        : const {};
    if (ambassadorCampaign.ambassador != null && (!preventCircularSerialization || !upsertedTypes.contains('BrandAmbassador'))) {
        ambassadorCampaign.ambassador = BrandAmbassadorStore.instance.recursiveUpsert(ambassadorCampaign.ambassador!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (ambassadorCampaign.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        ambassadorCampaign.org = OrganizationStore.instance.recursiveUpsert(ambassadorCampaign.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (ambassadorCampaign.videoContents != null && (!preventCircularSerialization || !upsertedTypes.contains('VideoContent'))) {
        ambassadorCampaign.videoContents = VideoContentStore.instance.recursiveListUpsert(ambassadorCampaign.videoContents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (ambassadorCampaign.campaignVideos != null && (!preventCircularSerialization || !upsertedTypes.contains('VideoContent'))) {
        ambassadorCampaign.campaignVideos = VideoContentStore.instance.recursiveListUpsert(ambassadorCampaign.campaignVideos!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(ambassadorCampaign);
}

  List<AmbassadorCampaign> recursiveListUpsert(List<AmbassadorCampaign> ambassadorCampaigns, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAmbassadorCampaigns = <AmbassadorCampaign>[];
    for (var ambassadorCampaign in ambassadorCampaigns) {
        updatedAmbassadorCampaigns.add(recursiveUpsert(ambassadorCampaign, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAmbassadorCampaigns;
}

//   @override
//   AmbassadorCampaign upsert(AmbassadorCampaign item) {
//     return recursiveUpsert(item);
//   }

}


class AmbassadorCampaignInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AmbassadorCampaignInclude.ambassador({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<BrandAmbassador>? modelFilter,
    List<BrandAmbassadorInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (ambassadorCampaign) => AmbassadorCampaignStore.instance
            .getAmbassador$(ambassadorCampaign, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (ambassadorCampaign) => AmbassadorCampaignStore.instance
            .getAmbassador(ambassadorCampaign, modelFilter: modelFilter, includes: includes);
      }
}

	AmbassadorCampaignInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (ambassadorCampaign) => AmbassadorCampaignStore.instance
            .getOrg$(ambassadorCampaign, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (ambassadorCampaign) => AmbassadorCampaignStore.instance
            .getOrg(ambassadorCampaign, modelFilter: modelFilter, includes: includes);
      }
}

	AmbassadorCampaignInclude.videoContents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VideoContent>? modelFilter,
    List<VideoContentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (ambassadorCampaign) => AmbassadorCampaignStore.instance
            .getVideoContents$(ambassadorCampaign, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (ambassadorCampaign) => AmbassadorCampaignStore.instance
            .getVideoContents(ambassadorCampaign, modelFilter: modelFilter, includes: includes);
      }
}

	AmbassadorCampaignInclude.campaignVideos({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VideoContent>? modelFilter,
    List<VideoContentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (ambassadorCampaign) => AmbassadorCampaignStore.instance
            .getCampaignVideos$(ambassadorCampaign, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (ambassadorCampaign) => AmbassadorCampaignStore.instance
            .getCampaignVideos(ambassadorCampaign, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AmbassadorCampaignEndpoints implements Endpoint {

    getAll('/ambassadorCampaign', HttpMethod.post, List<AmbassadorCampaign>),
	getById('/ambassadorCampaign/byId/:id', HttpMethod.post, AmbassadorCampaign),
	getManyByOrgId('/ambassadorCampaign/byOrgId/:orgId', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByAmbassadorId('/ambassadorCampaign/byAmbassadorId/:ambassadorId', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByName('/ambassadorCampaign/byName/:name', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByDescription('/ambassadorCampaign/byDescription/:description', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByStartDate('/ambassadorCampaign/byStartDate/:startDate', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByEndDate('/ambassadorCampaign/byEndDate/:endDate', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByBudget('/ambassadorCampaign/byBudget/:budget', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByActualSpend('/ambassadorCampaign/byActualSpend/:actualSpend', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByCurrency('/ambassadorCampaign/byCurrency/:currency', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByStatus('/ambassadorCampaign/byStatus/:status', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByTargetReach('/ambassadorCampaign/byTargetReach/:targetReach', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByActualReach('/ambassadorCampaign/byActualReach/:actualReach', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByImpressions('/ambassadorCampaign/byImpressions/:impressions', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByClicks('/ambassadorCampaign/byClicks/:clicks', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByConversions('/ambassadorCampaign/byConversions/:conversions', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByConversionValue('/ambassadorCampaign/byConversionValue/:conversionValue', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByRoi('/ambassadorCampaign/byRoi/:roi', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByContent('/ambassadorCampaign/byContent/:content', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByPlatforms('/ambassadorCampaign/byPlatforms/:platforms', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByDeletedAt('/ambassadorCampaign/byDeletedAt/:deletedAt', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByCreatedAt('/ambassadorCampaign/byCreatedAt/:createdAt', HttpMethod.post, List<AmbassadorCampaign>),
	getManyByUpdatedAt('/ambassadorCampaign/byUpdatedAt/:updatedAt', HttpMethod.post, List<AmbassadorCampaign>);

    const AmbassadorCampaignEndpoints(this.path, this.method, this.responseType);

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
