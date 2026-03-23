
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class LeadSourceStore extends ModelStreamStore<String, LeadSource> {

  static LeadSourceStore? _instance;

  static LeadSourceStore get instance {
    _instance ??= LeadSourceStore();
    return _instance!;
  }

  LeadSourceStore() : super(LeadSource.fromJson) {
    if (_instance != null) {
        throw Exception(
            'LeadSourceStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending LeadSourceStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use LeadSourceStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getLeadSourceId(LeadSource leadSource) => leadSource.id;

	String? getLeadSourceOrgId(LeadSource leadSource) => leadSource.orgId;

	String? getLeadSourceName(LeadSource leadSource) => leadSource.name;

	SourceType? getLeadSourceType(LeadSource leadSource) => leadSource.type;

	dynamic? getLeadSourceConfig(LeadSource leadSource) => leadSource.config;

	DateTime? getLeadSourceCreatedAt(LeadSource leadSource) => leadSource.createdAt;

	DateTime? getLeadSourceUpdatedAt(LeadSource leadSource) => leadSource.updatedAt;

	DateTime? getLeadSourceDeletedAt(LeadSource leadSource) => leadSource.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<LeadSource> getByOrgId(
    String orgId,
    {ModelFilter<LeadSource>? modelFilter, List<LeadSourceInclude>? includes}
    ) =>
    getManyIncluding(getLeadSourceOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<LeadSource> getByName(
    String name,
    {ModelFilter<LeadSource>? modelFilter, List<LeadSourceInclude>? includes}
    ) =>
    getManyIncluding(getLeadSourceName, name, modelFilter: modelFilter, includes: includes);

	
List<LeadSource> getByType(
    SourceType type,
    {ModelFilter<LeadSource>? modelFilter, List<LeadSourceInclude>? includes}
    ) =>
    getManyIncluding(getLeadSourceType, type, modelFilter: modelFilter, includes: includes);

	
List<LeadSource> getByConfig(
    dynamic config,
    {ModelFilter<LeadSource>? modelFilter, List<LeadSourceInclude>? includes}
    ) =>
    getManyIncluding(getLeadSourceConfig, config, modelFilter: modelFilter, includes: includes);

	
List<LeadSource> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<LeadSource>? modelFilter, List<LeadSourceInclude>? includes}
    ) =>
    getManyIncluding(getLeadSourceCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<LeadSource> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<LeadSource>? modelFilter, List<LeadSourceInclude>? includes}
    ) =>
    getManyIncluding(getLeadSourceUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<LeadSource> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<LeadSource>? modelFilter, List<LeadSourceInclude>? includes}
    ) =>
    getManyIncluding(getLeadSourceDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    LeadSource leadSource, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (leadSource.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(leadSource.orgId!, includes: includes);
        leadSource.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<Lead> getLeads(
    LeadSource leadSource, {ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    final leads = LeadStore.instance.getBySourceId(leadSource.$uid!, modelFilter: modelFilter, includes: includes);
    leadSource.leads = leads;
    // setIncludedReferencesForList(leads, includes: includes);
    return leads;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<LeadSource>> getAll$({bool useCache = true, ModelFilter<LeadSource>? modelFilter, List<LeadSourceInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: LeadSourceEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<LeadSource?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<LeadSource>? modelFilter,
        List<LeadSourceInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getLeadSourceId,
        value: id,
        modelFilter: modelFilter,
        endpoint: LeadSourceEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<LeadSource>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<LeadSource>? modelFilter,
        List<LeadSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadSourceOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: LeadSourceEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeadSource>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<LeadSource>? modelFilter,
        List<LeadSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeadSourceName,
        value: name,
        modelFilter: modelFilter,
        endpoint: LeadSourceEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeadSource>> getByType$(
        SourceType type,
        {bool useCache = true,
        ModelFilter<LeadSource>? modelFilter,
        List<LeadSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<SourceType>(
        getPropVal: getLeadSourceType,
        value: type,
        modelFilter: modelFilter,
        endpoint: LeadSourceEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeadSource>> getByConfig$(
        dynamic config,
        {bool useCache = true,
        ModelFilter<LeadSource>? modelFilter,
        List<LeadSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getLeadSourceConfig,
        value: config,
        modelFilter: modelFilter,
        endpoint: LeadSourceEndpoints.getManyByConfig,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeadSource>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<LeadSource>? modelFilter,
        List<LeadSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeadSourceCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: LeadSourceEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeadSource>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<LeadSource>? modelFilter,
        List<LeadSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeadSourceUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: LeadSourceEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeadSource>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<LeadSource>? modelFilter,
        List<LeadSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeadSourceDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: LeadSourceEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    LeadSource leadSource, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (leadSource.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            leadSource.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            leadSource.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Lead>> getLeads$(
    LeadSource leadSource, {bool useCache = true, ModelFilter<Lead>? modelFilter, List<LeadInclude>? includes}) {
    return LeadStore.instance.getBySourceId$(
        leadSource.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((leads) {
        leadSource.leads = leads;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
LeadSource recursiveUpsert(LeadSource leadSource, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'LeadSource'} 
        : const {};
    if (leadSource.leads != null && (!preventCircularSerialization || !upsertedTypes.contains('Lead'))) {
        leadSource.leads = LeadStore.instance.recursiveListUpsert(leadSource.leads!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (leadSource.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        leadSource.org = OrganizationStore.instance.recursiveUpsert(leadSource.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(leadSource);
}

  List<LeadSource> recursiveListUpsert(List<LeadSource> leadSources, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedLeadSources = <LeadSource>[];
    for (var leadSource in leadSources) {
        updatedLeadSources.add(recursiveUpsert(leadSource, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedLeadSources;
}

//   @override
//   LeadSource upsert(LeadSource item) {
//     return recursiveUpsert(item);
//   }

}


class LeadSourceInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      LeadSourceInclude.leads({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lead>? modelFilter,
    List<LeadInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (leadSource) => LeadSourceStore.instance
            .getLeads$(leadSource, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (leadSource) => LeadSourceStore.instance
            .getLeads(leadSource, modelFilter: modelFilter, includes: includes);
      }
}

	LeadSourceInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (leadSource) => LeadSourceStore.instance
            .getOrg$(leadSource, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (leadSource) => LeadSourceStore.instance
            .getOrg(leadSource, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum LeadSourceEndpoints implements Endpoint {

    getAll('/leadSource', HttpMethod.post, List<LeadSource>),
	getById('/leadSource/byId/:id', HttpMethod.post, LeadSource),
	getManyByOrgId('/leadSource/byOrgId/:orgId', HttpMethod.post, List<LeadSource>),
	getManyByName('/leadSource/byName/:name', HttpMethod.post, List<LeadSource>),
	getManyByType('/leadSource/byType/:type', HttpMethod.post, List<LeadSource>),
	getManyByConfig('/leadSource/byConfig/:config', HttpMethod.post, List<LeadSource>),
	getManyByCreatedAt('/leadSource/byCreatedAt/:createdAt', HttpMethod.post, List<LeadSource>),
	getManyByUpdatedAt('/leadSource/byUpdatedAt/:updatedAt', HttpMethod.post, List<LeadSource>),
	getManyByDeletedAt('/leadSource/byDeletedAt/:deletedAt', HttpMethod.post, List<LeadSource>);

    const LeadSourceEndpoints(this.path, this.method, this.responseType);

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
