
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class SocialImpactCounterStore extends ModelStreamStore<String, SocialImpactCounter> {

  static SocialImpactCounterStore? _instance;

  static SocialImpactCounterStore get instance {
    _instance ??= SocialImpactCounterStore();
    return _instance!;
  }

  SocialImpactCounterStore() : super(SocialImpactCounter.fromJson) {
    if (_instance != null) {
        throw Exception(
            'SocialImpactCounterStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending SocialImpactCounterStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use SocialImpactCounterStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getSocialImpactCounterId(SocialImpactCounter socialImpactCounter) => socialImpactCounter.id;

	String? getSocialImpactCounterOrgId(SocialImpactCounter socialImpactCounter) => socialImpactCounter.orgId;

	SocialImpactType? getSocialImpactCounterImpactType(SocialImpactCounter socialImpactCounter) => socialImpactCounter.impactType;

	String? getSocialImpactCounterCurrency(SocialImpactCounter socialImpactCounter) => socialImpactCounter.currency;

	String? getSocialImpactCounterPartnerName(SocialImpactCounter socialImpactCounter) => socialImpactCounter.partnerName;

	String? getSocialImpactCounterPartnerUrl(SocialImpactCounter socialImpactCounter) => socialImpactCounter.partnerUrl;

	String? getSocialImpactCounterPartnerOrgId(SocialImpactCounter socialImpactCounter) => socialImpactCounter.partnerOrgId;

	String? getSocialImpactCounterCampaignTag(SocialImpactCounter socialImpactCounter) => socialImpactCounter.campaignTag;

	bool? getSocialImpactCounterIsPublic(SocialImpactCounter socialImpactCounter) => socialImpactCounter.isPublic;

	int? getSocialImpactCounterDisplayGoal(SocialImpactCounter socialImpactCounter) => socialImpactCounter.displayGoal;

	DateTime? getSocialImpactCounterCreatedAt(SocialImpactCounter socialImpactCounter) => socialImpactCounter.createdAt;

	DateTime? getSocialImpactCounterUpdatedAt(SocialImpactCounter socialImpactCounter) => socialImpactCounter.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<SocialImpactCounter> getByOrgId(
    String orgId,
    {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactCounterOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactCounter> getByImpactType(
    SocialImpactType impactType,
    {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactCounterImpactType, impactType, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactCounter> getByCurrency(
    String currency,
    {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactCounterCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactCounter> getByPartnerName(
    String partnerName,
    {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactCounterPartnerName, partnerName, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactCounter> getByPartnerUrl(
    String partnerUrl,
    {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactCounterPartnerUrl, partnerUrl, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactCounter> getByPartnerOrgId(
    String partnerOrgId,
    {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactCounterPartnerOrgId, partnerOrgId, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactCounter> getByCampaignTag(
    String campaignTag,
    {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactCounterCampaignTag, campaignTag, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactCounter> getByIsPublic(
    bool isPublic,
    {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactCounterIsPublic, isPublic, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactCounter> getByDisplayGoal(
    int displayGoal,
    {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactCounterDisplayGoal, displayGoal, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactCounter> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactCounterCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactCounter> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactCounterUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    SocialImpactCounter socialImpactCounter, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (socialImpactCounter.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(socialImpactCounter.orgId!, includes: includes);
        socialImpactCounter.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<SocialImpactRecord> getRecords(
    SocialImpactCounter socialImpactCounter, {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}) {
    final records = SocialImpactRecordStore.instance.getByCounterId(socialImpactCounter.$uid!, modelFilter: modelFilter, includes: includes);
    socialImpactCounter.records = records;
    // setIncludedReferencesForList(records, includes: includes);
    return records;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<SocialImpactCounter>> getAll$({bool useCache = true, ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: SocialImpactCounterEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<SocialImpactCounter?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSocialImpactCounterId,
        value: id,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<SocialImpactCounter>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactCounterOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactCounter>> getByImpactType$(
        SocialImpactType impactType,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final items$ = getManyByFieldValue$<SocialImpactType>(
        getPropVal: getSocialImpactCounterImpactType,
        value: impactType,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getManyByImpactType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactCounter>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactCounterCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactCounter>> getByPartnerName$(
        String partnerName,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactCounterPartnerName,
        value: partnerName,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getManyByPartnerName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactCounter>> getByPartnerUrl$(
        String partnerUrl,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactCounterPartnerUrl,
        value: partnerUrl,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getManyByPartnerUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactCounter>> getByPartnerOrgId$(
        String partnerOrgId,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactCounterPartnerOrgId,
        value: partnerOrgId,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getManyByPartnerOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactCounter>> getByCampaignTag$(
        String campaignTag,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactCounterCampaignTag,
        value: campaignTag,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getManyByCampaignTag,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactCounter>> getByIsPublic$(
        bool isPublic,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getSocialImpactCounterIsPublic,
        value: isPublic,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getManyByIsPublic,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactCounter>> getByDisplayGoal$(
        int displayGoal,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getSocialImpactCounterDisplayGoal,
        value: displayGoal,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getManyByDisplayGoal,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactCounter>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSocialImpactCounterCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactCounter>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<SocialImpactCounter>? modelFilter,
        List<SocialImpactCounterInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSocialImpactCounterUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: SocialImpactCounterEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    SocialImpactCounter socialImpactCounter, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (socialImpactCounter.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            socialImpactCounter.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            socialImpactCounter.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<SocialImpactRecord>> getRecords$(
    SocialImpactCounter socialImpactCounter, {bool useCache = true, ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}) {
    return SocialImpactRecordStore.instance.getByCounterId$(
        socialImpactCounter.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((records) {
        socialImpactCounter.records = records;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
SocialImpactCounter recursiveUpsert(SocialImpactCounter socialImpactCounter, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'SocialImpactCounter'} 
        : const {};
    if (socialImpactCounter.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        socialImpactCounter.org = OrganizationStore.instance.recursiveUpsert(socialImpactCounter.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (socialImpactCounter.records != null && (!preventCircularSerialization || !upsertedTypes.contains('SocialImpactRecord'))) {
        socialImpactCounter.records = SocialImpactRecordStore.instance.recursiveListUpsert(socialImpactCounter.records!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(socialImpactCounter);
}

  List<SocialImpactCounter> recursiveListUpsert(List<SocialImpactCounter> socialImpactCounters, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedSocialImpactCounters = <SocialImpactCounter>[];
    for (var socialImpactCounter in socialImpactCounters) {
        updatedSocialImpactCounters.add(recursiveUpsert(socialImpactCounter, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedSocialImpactCounters;
}

//   @override
//   SocialImpactCounter upsert(SocialImpactCounter item) {
//     return recursiveUpsert(item);
//   }

}


class SocialImpactCounterInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      SocialImpactCounterInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (socialImpactCounter) => SocialImpactCounterStore.instance
            .getOrg$(socialImpactCounter, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (socialImpactCounter) => SocialImpactCounterStore.instance
            .getOrg(socialImpactCounter, modelFilter: modelFilter, includes: includes);
      }
}

	SocialImpactCounterInclude.records({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SocialImpactRecord>? modelFilter,
    List<SocialImpactRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (socialImpactCounter) => SocialImpactCounterStore.instance
            .getRecords$(socialImpactCounter, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (socialImpactCounter) => SocialImpactCounterStore.instance
            .getRecords(socialImpactCounter, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum SocialImpactCounterEndpoints implements Endpoint {

    getAll('/socialImpactCounter', HttpMethod.post, List<SocialImpactCounter>),
	getById('/socialImpactCounter/byId/:id', HttpMethod.post, SocialImpactCounter),
	getManyByOrgId('/socialImpactCounter/byOrgId/:orgId', HttpMethod.post, List<SocialImpactCounter>),
	getManyByImpactType('/socialImpactCounter/byImpactType/:impactType', HttpMethod.post, List<SocialImpactCounter>),
	getManyByCurrency('/socialImpactCounter/byCurrency/:currency', HttpMethod.post, List<SocialImpactCounter>),
	getManyByPartnerName('/socialImpactCounter/byPartnerName/:partnerName', HttpMethod.post, List<SocialImpactCounter>),
	getManyByPartnerUrl('/socialImpactCounter/byPartnerUrl/:partnerUrl', HttpMethod.post, List<SocialImpactCounter>),
	getManyByPartnerOrgId('/socialImpactCounter/byPartnerOrgId/:partnerOrgId', HttpMethod.post, List<SocialImpactCounter>),
	getManyByCampaignTag('/socialImpactCounter/byCampaignTag/:campaignTag', HttpMethod.post, List<SocialImpactCounter>),
	getManyByIsPublic('/socialImpactCounter/byIsPublic/:isPublic', HttpMethod.post, List<SocialImpactCounter>),
	getManyByDisplayGoal('/socialImpactCounter/byDisplayGoal/:displayGoal', HttpMethod.post, List<SocialImpactCounter>),
	getManyByCreatedAt('/socialImpactCounter/byCreatedAt/:createdAt', HttpMethod.post, List<SocialImpactCounter>),
	getManyByUpdatedAt('/socialImpactCounter/byUpdatedAt/:updatedAt', HttpMethod.post, List<SocialImpactCounter>);

    const SocialImpactCounterEndpoints(this.path, this.method, this.responseType);

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
