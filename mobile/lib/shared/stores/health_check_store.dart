
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class HealthCheckStore extends ModelStreamStore<String, HealthCheck> {

  static HealthCheckStore? _instance;

  static HealthCheckStore get instance {
    _instance ??= HealthCheckStore();
    return _instance!;
  }

  HealthCheckStore() : super(HealthCheck.fromJson) {
    if (_instance != null) {
        throw Exception(
            'HealthCheckStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending HealthCheckStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use HealthCheckStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getHealthCheckId(HealthCheck healthCheck) => healthCheck.id;

	String? getHealthCheckOrgId(HealthCheck healthCheck) => healthCheck.orgId;

	String? getHealthCheckServiceName(HealthCheck healthCheck) => healthCheck.serviceName;

	String? getHealthCheckComponentName(HealthCheck healthCheck) => healthCheck.componentName;

	String? getHealthCheckStatus(HealthCheck healthCheck) => healthCheck.status;

	int? getHealthCheckResponseTime(HealthCheck healthCheck) => healthCheck.responseTime;

	dynamic? getHealthCheckDetails(HealthCheck healthCheck) => healthCheck.details;

	String? getHealthCheckErrorMessage(HealthCheck healthCheck) => healthCheck.errorMessage;

	DateTime? getHealthCheckCheckedAt(HealthCheck healthCheck) => healthCheck.checkedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<HealthCheck> getByOrgId(
    String orgId,
    {ModelFilter<HealthCheck>? modelFilter, List<HealthCheckInclude>? includes}
    ) =>
    getManyIncluding(getHealthCheckOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<HealthCheck> getByServiceName(
    String serviceName,
    {ModelFilter<HealthCheck>? modelFilter, List<HealthCheckInclude>? includes}
    ) =>
    getManyIncluding(getHealthCheckServiceName, serviceName, modelFilter: modelFilter, includes: includes);

	
List<HealthCheck> getByComponentName(
    String componentName,
    {ModelFilter<HealthCheck>? modelFilter, List<HealthCheckInclude>? includes}
    ) =>
    getManyIncluding(getHealthCheckComponentName, componentName, modelFilter: modelFilter, includes: includes);

	
List<HealthCheck> getByStatus(
    String status,
    {ModelFilter<HealthCheck>? modelFilter, List<HealthCheckInclude>? includes}
    ) =>
    getManyIncluding(getHealthCheckStatus, status, modelFilter: modelFilter, includes: includes);

	
List<HealthCheck> getByResponseTime(
    int responseTime,
    {ModelFilter<HealthCheck>? modelFilter, List<HealthCheckInclude>? includes}
    ) =>
    getManyIncluding(getHealthCheckResponseTime, responseTime, modelFilter: modelFilter, includes: includes);

	
List<HealthCheck> getByDetails(
    dynamic details,
    {ModelFilter<HealthCheck>? modelFilter, List<HealthCheckInclude>? includes}
    ) =>
    getManyIncluding(getHealthCheckDetails, details, modelFilter: modelFilter, includes: includes);

	
List<HealthCheck> getByErrorMessage(
    String errorMessage,
    {ModelFilter<HealthCheck>? modelFilter, List<HealthCheckInclude>? includes}
    ) =>
    getManyIncluding(getHealthCheckErrorMessage, errorMessage, modelFilter: modelFilter, includes: includes);

	
List<HealthCheck> getByCheckedAt(
    DateTime checkedAt,
    {ModelFilter<HealthCheck>? modelFilter, List<HealthCheckInclude>? includes}
    ) =>
    getManyIncluding(getHealthCheckCheckedAt, checkedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    HealthCheck healthCheck, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (healthCheck.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(healthCheck.orgId!, includes: includes);
        healthCheck.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<HealthCheck>> getAll$({bool useCache = true, ModelFilter<HealthCheck>? modelFilter, List<HealthCheckInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: HealthCheckEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<HealthCheck?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<HealthCheck>? modelFilter,
        List<HealthCheckInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getHealthCheckId,
        value: id,
        modelFilter: modelFilter,
        endpoint: HealthCheckEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<HealthCheck>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<HealthCheck>? modelFilter,
        List<HealthCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHealthCheckOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: HealthCheckEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HealthCheck>> getByServiceName$(
        String serviceName,
        {bool useCache = true,
        ModelFilter<HealthCheck>? modelFilter,
        List<HealthCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHealthCheckServiceName,
        value: serviceName,
        modelFilter: modelFilter,
        endpoint: HealthCheckEndpoints.getManyByServiceName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HealthCheck>> getByComponentName$(
        String componentName,
        {bool useCache = true,
        ModelFilter<HealthCheck>? modelFilter,
        List<HealthCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHealthCheckComponentName,
        value: componentName,
        modelFilter: modelFilter,
        endpoint: HealthCheckEndpoints.getManyByComponentName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HealthCheck>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<HealthCheck>? modelFilter,
        List<HealthCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHealthCheckStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: HealthCheckEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HealthCheck>> getByResponseTime$(
        int responseTime,
        {bool useCache = true,
        ModelFilter<HealthCheck>? modelFilter,
        List<HealthCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getHealthCheckResponseTime,
        value: responseTime,
        modelFilter: modelFilter,
        endpoint: HealthCheckEndpoints.getManyByResponseTime,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HealthCheck>> getByDetails$(
        dynamic details,
        {bool useCache = true,
        ModelFilter<HealthCheck>? modelFilter,
        List<HealthCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getHealthCheckDetails,
        value: details,
        modelFilter: modelFilter,
        endpoint: HealthCheckEndpoints.getManyByDetails,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HealthCheck>> getByErrorMessage$(
        String errorMessage,
        {bool useCache = true,
        ModelFilter<HealthCheck>? modelFilter,
        List<HealthCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHealthCheckErrorMessage,
        value: errorMessage,
        modelFilter: modelFilter,
        endpoint: HealthCheckEndpoints.getManyByErrorMessage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HealthCheck>> getByCheckedAt$(
        DateTime checkedAt,
        {bool useCache = true,
        ModelFilter<HealthCheck>? modelFilter,
        List<HealthCheckInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getHealthCheckCheckedAt,
        value: checkedAt,
        modelFilter: modelFilter,
        endpoint: HealthCheckEndpoints.getManyByCheckedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    HealthCheck healthCheck, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (healthCheck.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            healthCheck.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            healthCheck.org = org;
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
HealthCheck recursiveUpsert(HealthCheck healthCheck, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'HealthCheck'} 
        : const {};
    if (healthCheck.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        healthCheck.org = OrganizationStore.instance.recursiveUpsert(healthCheck.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(healthCheck);
}

  List<HealthCheck> recursiveListUpsert(List<HealthCheck> healthChecks, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedHealthChecks = <HealthCheck>[];
    for (var healthCheck in healthChecks) {
        updatedHealthChecks.add(recursiveUpsert(healthCheck, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedHealthChecks;
}

//   @override
//   HealthCheck upsert(HealthCheck item) {
//     return recursiveUpsert(item);
//   }

}


class HealthCheckInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      HealthCheckInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (healthCheck) => HealthCheckStore.instance
            .getOrg$(healthCheck, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (healthCheck) => HealthCheckStore.instance
            .getOrg(healthCheck, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum HealthCheckEndpoints implements Endpoint {

    getAll('/healthCheck', HttpMethod.post, List<HealthCheck>),
	getById('/healthCheck/byId/:id', HttpMethod.post, HealthCheck),
	getManyByOrgId('/healthCheck/byOrgId/:orgId', HttpMethod.post, List<HealthCheck>),
	getManyByServiceName('/healthCheck/byServiceName/:serviceName', HttpMethod.post, List<HealthCheck>),
	getManyByComponentName('/healthCheck/byComponentName/:componentName', HttpMethod.post, List<HealthCheck>),
	getManyByStatus('/healthCheck/byStatus/:status', HttpMethod.post, List<HealthCheck>),
	getManyByResponseTime('/healthCheck/byResponseTime/:responseTime', HttpMethod.post, List<HealthCheck>),
	getManyByDetails('/healthCheck/byDetails/:details', HttpMethod.post, List<HealthCheck>),
	getManyByErrorMessage('/healthCheck/byErrorMessage/:errorMessage', HttpMethod.post, List<HealthCheck>),
	getManyByCheckedAt('/healthCheck/byCheckedAt/:checkedAt', HttpMethod.post, List<HealthCheck>);

    const HealthCheckEndpoints(this.path, this.method, this.responseType);

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
