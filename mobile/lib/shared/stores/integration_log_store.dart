
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class IntegrationLogStore extends ModelStreamStore<String, IntegrationLog> {

  static IntegrationLogStore? _instance;

  static IntegrationLogStore get instance {
    _instance ??= IntegrationLogStore();
    return _instance!;
  }

  IntegrationLogStore() : super(IntegrationLog.fromJson) {
    if (_instance != null) {
        throw Exception(
            'IntegrationLogStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending IntegrationLogStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use IntegrationLogStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getIntegrationLogId(IntegrationLog integrationLog) => integrationLog.id;

	String? getIntegrationLogOrgId(IntegrationLog integrationLog) => integrationLog.orgId;

	String? getIntegrationLogIntegrationType(IntegrationLog integrationLog) => integrationLog.integrationType;

	String? getIntegrationLogOperation(IntegrationLog integrationLog) => integrationLog.operation;

	dynamic? getIntegrationLogRequestData(IntegrationLog integrationLog) => integrationLog.requestData;

	dynamic? getIntegrationLogResponseData(IntegrationLog integrationLog) => integrationLog.responseData;

	int? getIntegrationLogStatusCode(IntegrationLog integrationLog) => integrationLog.statusCode;

	bool? getIntegrationLogSuccess(IntegrationLog integrationLog) => integrationLog.success;

	String? getIntegrationLogErrorMessage(IntegrationLog integrationLog) => integrationLog.errorMessage;

	int? getIntegrationLogProcessingTimeMs(IntegrationLog integrationLog) => integrationLog.processingTimeMs;

	String? getIntegrationLogExternalId(IntegrationLog integrationLog) => integrationLog.externalId;

	String? getIntegrationLogCorrelationId(IntegrationLog integrationLog) => integrationLog.correlationId;

	DateTime? getIntegrationLogCreatedAt(IntegrationLog integrationLog) => integrationLog.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<IntegrationLog> getByOrgId(
    String orgId,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<IntegrationLog> getByIntegrationType(
    String integrationType,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogIntegrationType, integrationType, modelFilter: modelFilter, includes: includes);

	
List<IntegrationLog> getByOperation(
    String operation,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogOperation, operation, modelFilter: modelFilter, includes: includes);

	
List<IntegrationLog> getByRequestData(
    dynamic requestData,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogRequestData, requestData, modelFilter: modelFilter, includes: includes);

	
List<IntegrationLog> getByResponseData(
    dynamic responseData,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogResponseData, responseData, modelFilter: modelFilter, includes: includes);

	
List<IntegrationLog> getByStatusCode(
    int statusCode,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogStatusCode, statusCode, modelFilter: modelFilter, includes: includes);

	
List<IntegrationLog> getBySuccess(
    bool success,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogSuccess, success, modelFilter: modelFilter, includes: includes);

	
List<IntegrationLog> getByErrorMessage(
    String errorMessage,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogErrorMessage, errorMessage, modelFilter: modelFilter, includes: includes);

	
List<IntegrationLog> getByProcessingTimeMs(
    int processingTimeMs,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogProcessingTimeMs, processingTimeMs, modelFilter: modelFilter, includes: includes);

	
List<IntegrationLog> getByExternalId(
    String externalId,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogExternalId, externalId, modelFilter: modelFilter, includes: includes);

	
List<IntegrationLog> getByCorrelationId(
    String correlationId,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogCorrelationId, correlationId, modelFilter: modelFilter, includes: includes);

	
List<IntegrationLog> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}
    ) =>
    getManyIncluding(getIntegrationLogCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    IntegrationLog integrationLog, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (integrationLog.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(integrationLog.orgId!, includes: includes);
        integrationLog.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<IntegrationLog>> getAll$({bool useCache = true, ModelFilter<IntegrationLog>? modelFilter, List<IntegrationLogInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: IntegrationLogEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<IntegrationLog?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getIntegrationLogId,
        value: id,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<IntegrationLog>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIntegrationLogOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IntegrationLog>> getByIntegrationType$(
        String integrationType,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIntegrationLogIntegrationType,
        value: integrationType,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyByIntegrationType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IntegrationLog>> getByOperation$(
        String operation,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIntegrationLogOperation,
        value: operation,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyByOperation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IntegrationLog>> getByRequestData$(
        dynamic requestData,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getIntegrationLogRequestData,
        value: requestData,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyByRequestData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IntegrationLog>> getByResponseData$(
        dynamic responseData,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getIntegrationLogResponseData,
        value: responseData,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyByResponseData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IntegrationLog>> getByStatusCode$(
        int statusCode,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getIntegrationLogStatusCode,
        value: statusCode,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyByStatusCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IntegrationLog>> getBySuccess$(
        bool success,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getIntegrationLogSuccess,
        value: success,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyBySuccess,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IntegrationLog>> getByErrorMessage$(
        String errorMessage,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIntegrationLogErrorMessage,
        value: errorMessage,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyByErrorMessage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IntegrationLog>> getByProcessingTimeMs$(
        int processingTimeMs,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getIntegrationLogProcessingTimeMs,
        value: processingTimeMs,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyByProcessingTimeMs,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IntegrationLog>> getByExternalId$(
        String externalId,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIntegrationLogExternalId,
        value: externalId,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyByExternalId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IntegrationLog>> getByCorrelationId$(
        String correlationId,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIntegrationLogCorrelationId,
        value: correlationId,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyByCorrelationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<IntegrationLog>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<IntegrationLog>? modelFilter,
        List<IntegrationLogInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getIntegrationLogCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: IntegrationLogEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    IntegrationLog integrationLog, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (integrationLog.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            integrationLog.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            integrationLog.org = org;
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
IntegrationLog recursiveUpsert(IntegrationLog integrationLog, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'IntegrationLog'} 
        : const {};
    if (integrationLog.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        integrationLog.org = OrganizationStore.instance.recursiveUpsert(integrationLog.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(integrationLog);
}

  List<IntegrationLog> recursiveListUpsert(List<IntegrationLog> integrationLogs, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedIntegrationLogs = <IntegrationLog>[];
    for (var integrationLog in integrationLogs) {
        updatedIntegrationLogs.add(recursiveUpsert(integrationLog, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedIntegrationLogs;
}

//   @override
//   IntegrationLog upsert(IntegrationLog item) {
//     return recursiveUpsert(item);
//   }

}


class IntegrationLogInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      IntegrationLogInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (integrationLog) => IntegrationLogStore.instance
            .getOrg$(integrationLog, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (integrationLog) => IntegrationLogStore.instance
            .getOrg(integrationLog, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum IntegrationLogEndpoints implements Endpoint {

    getAll('/integrationLog', HttpMethod.post, List<IntegrationLog>),
	getById('/integrationLog/byId/:id', HttpMethod.post, IntegrationLog),
	getManyByOrgId('/integrationLog/byOrgId/:orgId', HttpMethod.post, List<IntegrationLog>),
	getManyByIntegrationType('/integrationLog/byIntegrationType/:integrationType', HttpMethod.post, List<IntegrationLog>),
	getManyByOperation('/integrationLog/byOperation/:operation', HttpMethod.post, List<IntegrationLog>),
	getManyByRequestData('/integrationLog/byRequestData/:requestData', HttpMethod.post, List<IntegrationLog>),
	getManyByResponseData('/integrationLog/byResponseData/:responseData', HttpMethod.post, List<IntegrationLog>),
	getManyByStatusCode('/integrationLog/byStatusCode/:statusCode', HttpMethod.post, List<IntegrationLog>),
	getManyBySuccess('/integrationLog/bySuccess/:success', HttpMethod.post, List<IntegrationLog>),
	getManyByErrorMessage('/integrationLog/byErrorMessage/:errorMessage', HttpMethod.post, List<IntegrationLog>),
	getManyByProcessingTimeMs('/integrationLog/byProcessingTimeMs/:processingTimeMs', HttpMethod.post, List<IntegrationLog>),
	getManyByExternalId('/integrationLog/byExternalId/:externalId', HttpMethod.post, List<IntegrationLog>),
	getManyByCorrelationId('/integrationLog/byCorrelationId/:correlationId', HttpMethod.post, List<IntegrationLog>),
	getManyByCreatedAt('/integrationLog/byCreatedAt/:createdAt', HttpMethod.post, List<IntegrationLog>);

    const IntegrationLogEndpoints(this.path, this.method, this.responseType);

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
