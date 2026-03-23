
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIModelDeploymentStore extends ModelStreamStore<String, AIModelDeployment> {

  static AIModelDeploymentStore? _instance;

  static AIModelDeploymentStore get instance {
    _instance ??= AIModelDeploymentStore();
    return _instance!;
  }

  AIModelDeploymentStore() : super(AIModelDeployment.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIModelDeploymentStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIModelDeploymentStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIModelDeploymentStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIModelDeploymentId(AIModelDeployment aIModelDeployment) => aIModelDeployment.id;

	String? getAIModelDeploymentOrgId(AIModelDeployment aIModelDeployment) => aIModelDeployment.orgId;

	String? getAIModelDeploymentModelId(AIModelDeployment aIModelDeployment) => aIModelDeployment.modelId;

	String? getAIModelDeploymentDeploymentId(AIModelDeployment aIModelDeployment) => aIModelDeployment.deploymentId;

	String? getAIModelDeploymentEnvironment(AIModelDeployment aIModelDeployment) => aIModelDeployment.environment;

	String? getAIModelDeploymentStatus(AIModelDeployment aIModelDeployment) => aIModelDeployment.status;

	DateTime? getAIModelDeploymentDeployedAt(AIModelDeployment aIModelDeployment) => aIModelDeployment.deployedAt;

	DateTime? getAIModelDeploymentLastHealthCheck(AIModelDeployment aIModelDeployment) => aIModelDeployment.lastHealthCheck;

	dynamic? getAIModelDeploymentConfig(AIModelDeployment aIModelDeployment) => aIModelDeployment.config;

	dynamic? getAIModelDeploymentMetrics(AIModelDeployment aIModelDeployment) => aIModelDeployment.metrics;

	DateTime? getAIModelDeploymentCreatedAt(AIModelDeployment aIModelDeployment) => aIModelDeployment.createdAt;

	DateTime? getAIModelDeploymentUpdatedAt(AIModelDeployment aIModelDeployment) => aIModelDeployment.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIModelDeployment> getByOrgId(
    String orgId,
    {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}
    ) =>
    getManyIncluding(getAIModelDeploymentOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIModelDeployment> getByModelId(
    String modelId,
    {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}
    ) =>
    getManyIncluding(getAIModelDeploymentModelId, modelId, modelFilter: modelFilter, includes: includes);

	
List<AIModelDeployment> getByDeploymentId(
    String deploymentId,
    {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}
    ) =>
    getManyIncluding(getAIModelDeploymentDeploymentId, deploymentId, modelFilter: modelFilter, includes: includes);

	
List<AIModelDeployment> getByEnvironment(
    String environment,
    {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}
    ) =>
    getManyIncluding(getAIModelDeploymentEnvironment, environment, modelFilter: modelFilter, includes: includes);

	
List<AIModelDeployment> getByStatus(
    String status,
    {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}
    ) =>
    getManyIncluding(getAIModelDeploymentStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AIModelDeployment> getByDeployedAt(
    DateTime deployedAt,
    {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}
    ) =>
    getManyIncluding(getAIModelDeploymentDeployedAt, deployedAt, modelFilter: modelFilter, includes: includes);

	
List<AIModelDeployment> getByLastHealthCheck(
    DateTime lastHealthCheck,
    {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}
    ) =>
    getManyIncluding(getAIModelDeploymentLastHealthCheck, lastHealthCheck, modelFilter: modelFilter, includes: includes);

	
List<AIModelDeployment> getByConfig(
    dynamic config,
    {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}
    ) =>
    getManyIncluding(getAIModelDeploymentConfig, config, modelFilter: modelFilter, includes: includes);

	
List<AIModelDeployment> getByMetrics(
    dynamic metrics,
    {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}
    ) =>
    getManyIncluding(getAIModelDeploymentMetrics, metrics, modelFilter: modelFilter, includes: includes);

	
List<AIModelDeployment> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}
    ) =>
    getManyIncluding(getAIModelDeploymentCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AIModelDeployment> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}
    ) =>
    getManyIncluding(getAIModelDeploymentUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  AIModel? getModel(
    AIModelDeployment aIModelDeployment, {ModelFilter? modelFilter, List<AIModelInclude>? includes}) {
    if (aIModelDeployment.modelId == null) {
        return null;
    } else {
        final model = AIModelStore.instance.getById(aIModelDeployment.modelId!, includes: includes);
        aIModelDeployment.model = model;
        // setIncludedReferences(model, includes: includes);
        return model;
    }
}

	Organization? getOrg(
    AIModelDeployment aIModelDeployment, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIModelDeployment.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIModelDeployment.orgId!, includes: includes);
        aIModelDeployment.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIModelDeployment>> getAll$({bool useCache = true, ModelFilter<AIModelDeployment>? modelFilter, List<AIModelDeploymentInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIModelDeploymentEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIModelDeployment?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIModelDeploymentId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIModelDeployment>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelDeploymentOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModelDeployment>> getByModelId$(
        String modelId,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelDeploymentModelId,
        value: modelId,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getManyByModelId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModelDeployment>> getByDeploymentId$(
        String deploymentId,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelDeploymentDeploymentId,
        value: deploymentId,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getManyByDeploymentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModelDeployment>> getByEnvironment$(
        String environment,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelDeploymentEnvironment,
        value: environment,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getManyByEnvironment,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModelDeployment>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIModelDeploymentStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModelDeployment>> getByDeployedAt$(
        DateTime deployedAt,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIModelDeploymentDeployedAt,
        value: deployedAt,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getManyByDeployedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModelDeployment>> getByLastHealthCheck$(
        DateTime lastHealthCheck,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIModelDeploymentLastHealthCheck,
        value: lastHealthCheck,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getManyByLastHealthCheck,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModelDeployment>> getByConfig$(
        dynamic config,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIModelDeploymentConfig,
        value: config,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getManyByConfig,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModelDeployment>> getByMetrics$(
        dynamic metrics,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIModelDeploymentMetrics,
        value: metrics,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getManyByMetrics,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModelDeployment>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIModelDeploymentCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIModelDeployment>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AIModelDeployment>? modelFilter,
        List<AIModelDeploymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIModelDeploymentUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AIModelDeploymentEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<AIModel?> getModel$(
    AIModelDeployment aIModelDeployment, {bool useCache = true, ModelFilter<AIModel>? modelFilter, List<AIModelInclude>? includes}) {
    if (aIModelDeployment.modelId == null) {
        return Stream.value(null);
    } else {
        return AIModelStore.instance.getById$(
            aIModelDeployment.modelId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((model) {
            aIModelDeployment.model = model;
        });
    }
}

	Stream<Organization?> getOrg$(
    AIModelDeployment aIModelDeployment, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIModelDeployment.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIModelDeployment.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIModelDeployment.org = org;
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
AIModelDeployment recursiveUpsert(AIModelDeployment aIModelDeployment, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIModelDeployment'} 
        : const {};
    if (aIModelDeployment.model != null && (!preventCircularSerialization || !upsertedTypes.contains('AIModel'))) {
        aIModelDeployment.model = AIModelStore.instance.recursiveUpsert(aIModelDeployment.model!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIModelDeployment.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIModelDeployment.org = OrganizationStore.instance.recursiveUpsert(aIModelDeployment.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIModelDeployment);
}

  List<AIModelDeployment> recursiveListUpsert(List<AIModelDeployment> aIModelDeployments, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIModelDeployments = <AIModelDeployment>[];
    for (var aIModelDeployment in aIModelDeployments) {
        updatedAIModelDeployments.add(recursiveUpsert(aIModelDeployment, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIModelDeployments;
}

//   @override
//   AIModelDeployment upsert(AIModelDeployment item) {
//     return recursiveUpsert(item);
//   }

}


class AIModelDeploymentInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIModelDeploymentInclude.model({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIModel>? modelFilter,
    List<AIModelInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIModelDeployment) => AIModelDeploymentStore.instance
            .getModel$(aIModelDeployment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIModelDeployment) => AIModelDeploymentStore.instance
            .getModel(aIModelDeployment, modelFilter: modelFilter, includes: includes);
      }
}

	AIModelDeploymentInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIModelDeployment) => AIModelDeploymentStore.instance
            .getOrg$(aIModelDeployment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIModelDeployment) => AIModelDeploymentStore.instance
            .getOrg(aIModelDeployment, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIModelDeploymentEndpoints implements Endpoint {

    getAll('/aIModelDeployment', HttpMethod.post, List<AIModelDeployment>),
	getById('/aIModelDeployment/byId/:id', HttpMethod.post, AIModelDeployment),
	getManyByOrgId('/aIModelDeployment/byOrgId/:orgId', HttpMethod.post, List<AIModelDeployment>),
	getManyByModelId('/aIModelDeployment/byModelId/:modelId', HttpMethod.post, List<AIModelDeployment>),
	getManyByDeploymentId('/aIModelDeployment/byDeploymentId/:deploymentId', HttpMethod.post, List<AIModelDeployment>),
	getManyByEnvironment('/aIModelDeployment/byEnvironment/:environment', HttpMethod.post, List<AIModelDeployment>),
	getManyByStatus('/aIModelDeployment/byStatus/:status', HttpMethod.post, List<AIModelDeployment>),
	getManyByDeployedAt('/aIModelDeployment/byDeployedAt/:deployedAt', HttpMethod.post, List<AIModelDeployment>),
	getManyByLastHealthCheck('/aIModelDeployment/byLastHealthCheck/:lastHealthCheck', HttpMethod.post, List<AIModelDeployment>),
	getManyByConfig('/aIModelDeployment/byConfig/:config', HttpMethod.post, List<AIModelDeployment>),
	getManyByMetrics('/aIModelDeployment/byMetrics/:metrics', HttpMethod.post, List<AIModelDeployment>),
	getManyByCreatedAt('/aIModelDeployment/byCreatedAt/:createdAt', HttpMethod.post, List<AIModelDeployment>),
	getManyByUpdatedAt('/aIModelDeployment/byUpdatedAt/:updatedAt', HttpMethod.post, List<AIModelDeployment>);

    const AIModelDeploymentEndpoints(this.path, this.method, this.responseType);

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
