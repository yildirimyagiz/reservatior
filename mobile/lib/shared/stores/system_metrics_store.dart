
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class SystemMetricsStore extends ModelStreamStore<String, SystemMetrics> {

  static SystemMetricsStore? _instance;

  static SystemMetricsStore get instance {
    _instance ??= SystemMetricsStore();
    return _instance!;
  }

  SystemMetricsStore() : super(SystemMetrics.fromJson) {
    if (_instance != null) {
        throw Exception(
            'SystemMetricsStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending SystemMetricsStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use SystemMetricsStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getSystemMetricsId(SystemMetrics systemMetrics) => systemMetrics.id;

	String? getSystemMetricsOrgId(SystemMetrics systemMetrics) => systemMetrics.orgId;

	String? getSystemMetricsMetricType(SystemMetrics systemMetrics) => systemMetrics.metricType;

	String? getSystemMetricsMetricName(SystemMetrics systemMetrics) => systemMetrics.metricName;

	double? getSystemMetricsValue(SystemMetrics systemMetrics) => systemMetrics.value;

	String? getSystemMetricsUnit(SystemMetrics systemMetrics) => systemMetrics.unit;

	DateTime? getSystemMetricsTimestamp(SystemMetrics systemMetrics) => systemMetrics.timestamp;

	dynamic? getSystemMetricsDimensions(SystemMetrics systemMetrics) => systemMetrics.dimensions;

	dynamic? getSystemMetricsTags(SystemMetrics systemMetrics) => systemMetrics.tags;

	DateTime? getSystemMetricsCollectedAt(SystemMetrics systemMetrics) => systemMetrics.collectedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<SystemMetrics> getByOrgId(
    String orgId,
    {ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}
    ) =>
    getManyIncluding(getSystemMetricsOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<SystemMetrics> getByMetricType(
    String metricType,
    {ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}
    ) =>
    getManyIncluding(getSystemMetricsMetricType, metricType, modelFilter: modelFilter, includes: includes);

	
List<SystemMetrics> getByMetricName(
    String metricName,
    {ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}
    ) =>
    getManyIncluding(getSystemMetricsMetricName, metricName, modelFilter: modelFilter, includes: includes);

	
List<SystemMetrics> getByValue(
    double value,
    {ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}
    ) =>
    getManyIncluding(getSystemMetricsValue, value, modelFilter: modelFilter, includes: includes);

	
List<SystemMetrics> getByUnit(
    String unit,
    {ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}
    ) =>
    getManyIncluding(getSystemMetricsUnit, unit, modelFilter: modelFilter, includes: includes);

	
List<SystemMetrics> getByTimestamp(
    DateTime timestamp,
    {ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}
    ) =>
    getManyIncluding(getSystemMetricsTimestamp, timestamp, modelFilter: modelFilter, includes: includes);

	
List<SystemMetrics> getByDimensions(
    dynamic dimensions,
    {ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}
    ) =>
    getManyIncluding(getSystemMetricsDimensions, dimensions, modelFilter: modelFilter, includes: includes);

	
List<SystemMetrics> getByTags(
    dynamic tags,
    {ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}
    ) =>
    getManyIncluding(getSystemMetricsTags, tags, modelFilter: modelFilter, includes: includes);

	
List<SystemMetrics> getByCollectedAt(
    DateTime collectedAt,
    {ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}
    ) =>
    getManyIncluding(getSystemMetricsCollectedAt, collectedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    SystemMetrics systemMetrics, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (systemMetrics.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(systemMetrics.orgId!, includes: includes);
        systemMetrics.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<SystemMetrics>> getAll$({bool useCache = true, ModelFilter<SystemMetrics>? modelFilter, List<SystemMetricsInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: SystemMetricsEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<SystemMetrics?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<SystemMetrics>? modelFilter,
        List<SystemMetricsInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSystemMetricsId,
        value: id,
        modelFilter: modelFilter,
        endpoint: SystemMetricsEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<SystemMetrics>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<SystemMetrics>? modelFilter,
        List<SystemMetricsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSystemMetricsOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: SystemMetricsEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SystemMetrics>> getByMetricType$(
        String metricType,
        {bool useCache = true,
        ModelFilter<SystemMetrics>? modelFilter,
        List<SystemMetricsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSystemMetricsMetricType,
        value: metricType,
        modelFilter: modelFilter,
        endpoint: SystemMetricsEndpoints.getManyByMetricType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SystemMetrics>> getByMetricName$(
        String metricName,
        {bool useCache = true,
        ModelFilter<SystemMetrics>? modelFilter,
        List<SystemMetricsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSystemMetricsMetricName,
        value: metricName,
        modelFilter: modelFilter,
        endpoint: SystemMetricsEndpoints.getManyByMetricName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SystemMetrics>> getByValue$(
        double value,
        {bool useCache = true,
        ModelFilter<SystemMetrics>? modelFilter,
        List<SystemMetricsInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getSystemMetricsValue,
        value: value,
        modelFilter: modelFilter,
        endpoint: SystemMetricsEndpoints.getManyByValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SystemMetrics>> getByUnit$(
        String unit,
        {bool useCache = true,
        ModelFilter<SystemMetrics>? modelFilter,
        List<SystemMetricsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSystemMetricsUnit,
        value: unit,
        modelFilter: modelFilter,
        endpoint: SystemMetricsEndpoints.getManyByUnit,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SystemMetrics>> getByTimestamp$(
        DateTime timestamp,
        {bool useCache = true,
        ModelFilter<SystemMetrics>? modelFilter,
        List<SystemMetricsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSystemMetricsTimestamp,
        value: timestamp,
        modelFilter: modelFilter,
        endpoint: SystemMetricsEndpoints.getManyByTimestamp,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SystemMetrics>> getByDimensions$(
        dynamic dimensions,
        {bool useCache = true,
        ModelFilter<SystemMetrics>? modelFilter,
        List<SystemMetricsInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getSystemMetricsDimensions,
        value: dimensions,
        modelFilter: modelFilter,
        endpoint: SystemMetricsEndpoints.getManyByDimensions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SystemMetrics>> getByTags$(
        dynamic tags,
        {bool useCache = true,
        ModelFilter<SystemMetrics>? modelFilter,
        List<SystemMetricsInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getSystemMetricsTags,
        value: tags,
        modelFilter: modelFilter,
        endpoint: SystemMetricsEndpoints.getManyByTags,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SystemMetrics>> getByCollectedAt$(
        DateTime collectedAt,
        {bool useCache = true,
        ModelFilter<SystemMetrics>? modelFilter,
        List<SystemMetricsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSystemMetricsCollectedAt,
        value: collectedAt,
        modelFilter: modelFilter,
        endpoint: SystemMetricsEndpoints.getManyByCollectedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    SystemMetrics systemMetrics, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (systemMetrics.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            systemMetrics.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            systemMetrics.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
SystemMetrics recursiveUpsert(SystemMetrics systemMetrics, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'SystemMetrics'} 
        : const {};
    if (systemMetrics.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        systemMetrics.org = OrganizationStore.instance.recursiveUpsert(systemMetrics.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(systemMetrics);
}

  List<SystemMetrics> recursiveListUpsert(List<SystemMetrics> systemMetricss, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedSystemMetricss = <SystemMetrics>[];
    for (var systemMetrics in systemMetricss) {
        updatedSystemMetricss.add(recursiveUpsert(systemMetrics, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedSystemMetricss;
}

//   @override
//   SystemMetrics upsert(SystemMetrics item) {
//     return recursiveUpsert(item);
//   }

}


class SystemMetricsInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      SystemMetricsInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (systemMetrics) => SystemMetricsStore.instance
            .getOrg$(systemMetrics, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (systemMetrics) => SystemMetricsStore.instance
            .getOrg(systemMetrics, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum SystemMetricsEndpoints implements Endpoint {

    getAll('/systemMetrics', HttpMethod.post, List<SystemMetrics>),
	getById('/systemMetrics/byId/:id', HttpMethod.post, SystemMetrics),
	getManyByOrgId('/systemMetrics/byOrgId/:orgId', HttpMethod.post, List<SystemMetrics>),
	getManyByMetricType('/systemMetrics/byMetricType/:metricType', HttpMethod.post, List<SystemMetrics>),
	getManyByMetricName('/systemMetrics/byMetricName/:metricName', HttpMethod.post, List<SystemMetrics>),
	getManyByValue('/systemMetrics/byValue/:value', HttpMethod.post, List<SystemMetrics>),
	getManyByUnit('/systemMetrics/byUnit/:unit', HttpMethod.post, List<SystemMetrics>),
	getManyByTimestamp('/systemMetrics/byTimestamp/:timestamp', HttpMethod.post, List<SystemMetrics>),
	getManyByDimensions('/systemMetrics/byDimensions/:dimensions', HttpMethod.post, List<SystemMetrics>),
	getManyByTags('/systemMetrics/byTags/:tags', HttpMethod.post, List<SystemMetrics>),
	getManyByCollectedAt('/systemMetrics/byCollectedAt/:collectedAt', HttpMethod.post, List<SystemMetrics>);

    const SystemMetricsEndpoints(this.path, this.method, this.responseType);

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
