
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AutomationExecutionStore extends ModelStreamStore<String, AutomationExecution> {

  static AutomationExecutionStore? _instance;

  static AutomationExecutionStore get instance {
    _instance ??= AutomationExecutionStore();
    return _instance!;
  }

  AutomationExecutionStore() : super(AutomationExecution.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AutomationExecutionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AutomationExecutionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AutomationExecutionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAutomationExecutionId(AutomationExecution automationExecution) => automationExecution.id;

	String? getAutomationExecutionOrgId(AutomationExecution automationExecution) => automationExecution.orgId;

	String? getAutomationExecutionRuleId(AutomationExecution automationExecution) => automationExecution.ruleId;

	dynamic? getAutomationExecutionTriggerEvent(AutomationExecution automationExecution) => automationExecution.triggerEvent;

	dynamic? getAutomationExecutionExecutionData(AutomationExecution automationExecution) => automationExecution.executionData;

	String? getAutomationExecutionStatus(AutomationExecution automationExecution) => automationExecution.status;

	DateTime? getAutomationExecutionExecutedAt(AutomationExecution automationExecution) => automationExecution.executedAt;

	int? getAutomationExecutionProcessingTimeMs(AutomationExecution automationExecution) => automationExecution.processingTimeMs;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AutomationExecution> getByOrgId(
    String orgId,
    {ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}
    ) =>
    getManyIncluding(getAutomationExecutionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AutomationExecution> getByRuleId(
    String ruleId,
    {ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}
    ) =>
    getManyIncluding(getAutomationExecutionRuleId, ruleId, modelFilter: modelFilter, includes: includes);

	
List<AutomationExecution> getByTriggerEvent(
    dynamic triggerEvent,
    {ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}
    ) =>
    getManyIncluding(getAutomationExecutionTriggerEvent, triggerEvent, modelFilter: modelFilter, includes: includes);

	
List<AutomationExecution> getByExecutionData(
    dynamic executionData,
    {ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}
    ) =>
    getManyIncluding(getAutomationExecutionExecutionData, executionData, modelFilter: modelFilter, includes: includes);

	
List<AutomationExecution> getByStatus(
    String status,
    {ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}
    ) =>
    getManyIncluding(getAutomationExecutionStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AutomationExecution> getByExecutedAt(
    DateTime executedAt,
    {ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}
    ) =>
    getManyIncluding(getAutomationExecutionExecutedAt, executedAt, modelFilter: modelFilter, includes: includes);

	
List<AutomationExecution> getByProcessingTimeMs(
    int processingTimeMs,
    {ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}
    ) =>
    getManyIncluding(getAutomationExecutionProcessingTimeMs, processingTimeMs, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AutomationExecution automationExecution, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (automationExecution.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(automationExecution.orgId!, includes: includes);
        automationExecution.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	AutomationRule? getRule(
    AutomationExecution automationExecution, {ModelFilter? modelFilter, List<AutomationRuleInclude>? includes}) {
    if (automationExecution.ruleId == null) {
        return null;
    } else {
        final rule = AutomationRuleStore.instance.getById(automationExecution.ruleId!, includes: includes);
        automationExecution.rule = rule;
        // setIncludedReferences(rule, includes: includes);
        return rule;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AutomationExecution>> getAll$({bool useCache = true, ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AutomationExecutionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AutomationExecution?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AutomationExecution>? modelFilter,
        List<AutomationExecutionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAutomationExecutionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AutomationExecutionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AutomationExecution>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AutomationExecution>? modelFilter,
        List<AutomationExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationExecutionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AutomationExecutionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationExecution>> getByRuleId$(
        String ruleId,
        {bool useCache = true,
        ModelFilter<AutomationExecution>? modelFilter,
        List<AutomationExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationExecutionRuleId,
        value: ruleId,
        modelFilter: modelFilter,
        endpoint: AutomationExecutionEndpoints.getManyByRuleId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationExecution>> getByTriggerEvent$(
        dynamic triggerEvent,
        {bool useCache = true,
        ModelFilter<AutomationExecution>? modelFilter,
        List<AutomationExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAutomationExecutionTriggerEvent,
        value: triggerEvent,
        modelFilter: modelFilter,
        endpoint: AutomationExecutionEndpoints.getManyByTriggerEvent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationExecution>> getByExecutionData$(
        dynamic executionData,
        {bool useCache = true,
        ModelFilter<AutomationExecution>? modelFilter,
        List<AutomationExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAutomationExecutionExecutionData,
        value: executionData,
        modelFilter: modelFilter,
        endpoint: AutomationExecutionEndpoints.getManyByExecutionData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationExecution>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<AutomationExecution>? modelFilter,
        List<AutomationExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationExecutionStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AutomationExecutionEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationExecution>> getByExecutedAt$(
        DateTime executedAt,
        {bool useCache = true,
        ModelFilter<AutomationExecution>? modelFilter,
        List<AutomationExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAutomationExecutionExecutedAt,
        value: executedAt,
        modelFilter: modelFilter,
        endpoint: AutomationExecutionEndpoints.getManyByExecutedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationExecution>> getByProcessingTimeMs$(
        int processingTimeMs,
        {bool useCache = true,
        ModelFilter<AutomationExecution>? modelFilter,
        List<AutomationExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAutomationExecutionProcessingTimeMs,
        value: processingTimeMs,
        modelFilter: modelFilter,
        endpoint: AutomationExecutionEndpoints.getManyByProcessingTimeMs,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AutomationExecution automationExecution, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (automationExecution.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            automationExecution.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            automationExecution.org = org;
        });
    }
}

	Stream<AutomationRule?> getRule$(
    AutomationExecution automationExecution, {bool useCache = true, ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}) {
    if (automationExecution.ruleId == null) {
        return Stream.value(null);
    } else {
        return AutomationRuleStore.instance.getById$(
            automationExecution.ruleId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((rule) {
            automationExecution.rule = rule;
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
AutomationExecution recursiveUpsert(AutomationExecution automationExecution, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AutomationExecution'} 
        : const {};
    if (automationExecution.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        automationExecution.org = OrganizationStore.instance.recursiveUpsert(automationExecution.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (automationExecution.rule != null && (!preventCircularSerialization || !upsertedTypes.contains('AutomationRule'))) {
        automationExecution.rule = AutomationRuleStore.instance.recursiveUpsert(automationExecution.rule!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(automationExecution);
}

  List<AutomationExecution> recursiveListUpsert(List<AutomationExecution> automationExecutions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAutomationExecutions = <AutomationExecution>[];
    for (var automationExecution in automationExecutions) {
        updatedAutomationExecutions.add(recursiveUpsert(automationExecution, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAutomationExecutions;
}

//   @override
//   AutomationExecution upsert(AutomationExecution item) {
//     return recursiveUpsert(item);
//   }

}


class AutomationExecutionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AutomationExecutionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (automationExecution) => AutomationExecutionStore.instance
            .getOrg$(automationExecution, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (automationExecution) => AutomationExecutionStore.instance
            .getOrg(automationExecution, modelFilter: modelFilter, includes: includes);
      }
}

	AutomationExecutionInclude.rule({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AutomationRule>? modelFilter,
    List<AutomationRuleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (automationExecution) => AutomationExecutionStore.instance
            .getRule$(automationExecution, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (automationExecution) => AutomationExecutionStore.instance
            .getRule(automationExecution, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AutomationExecutionEndpoints implements Endpoint {

    getAll('/automationExecution', HttpMethod.post, List<AutomationExecution>),
	getById('/automationExecution/byId/:id', HttpMethod.post, AutomationExecution),
	getManyByOrgId('/automationExecution/byOrgId/:orgId', HttpMethod.post, List<AutomationExecution>),
	getManyByRuleId('/automationExecution/byRuleId/:ruleId', HttpMethod.post, List<AutomationExecution>),
	getManyByTriggerEvent('/automationExecution/byTriggerEvent/:triggerEvent', HttpMethod.post, List<AutomationExecution>),
	getManyByExecutionData('/automationExecution/byExecutionData/:executionData', HttpMethod.post, List<AutomationExecution>),
	getManyByStatus('/automationExecution/byStatus/:status', HttpMethod.post, List<AutomationExecution>),
	getManyByExecutedAt('/automationExecution/byExecutedAt/:executedAt', HttpMethod.post, List<AutomationExecution>),
	getManyByProcessingTimeMs('/automationExecution/byProcessingTimeMs/:processingTimeMs', HttpMethod.post, List<AutomationExecution>);

    const AutomationExecutionEndpoints(this.path, this.method, this.responseType);

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
