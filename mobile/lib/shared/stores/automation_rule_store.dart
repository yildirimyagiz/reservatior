
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AutomationRuleStore extends ModelStreamStore<String, AutomationRule> {

  static AutomationRuleStore? _instance;

  static AutomationRuleStore get instance {
    _instance ??= AutomationRuleStore();
    return _instance!;
  }

  AutomationRuleStore() : super(AutomationRule.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AutomationRuleStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AutomationRuleStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AutomationRuleStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAutomationRuleId(AutomationRule automationRule) => automationRule.id;

	String? getAutomationRuleOrgId(AutomationRule automationRule) => automationRule.orgId;

	String? getAutomationRuleRuleName(AutomationRule automationRule) => automationRule.ruleName;

	String? getAutomationRuleRuleType(AutomationRule automationRule) => automationRule.ruleType;

	String? getAutomationRuleTriggerType(AutomationRule automationRule) => automationRule.triggerType;

	dynamic? getAutomationRuleTriggerConfig(AutomationRule automationRule) => automationRule.triggerConfig;

	dynamic? getAutomationRuleConditions(AutomationRule automationRule) => automationRule.conditions;

	dynamic? getAutomationRuleActions(AutomationRule automationRule) => automationRule.actions;

	bool? getAutomationRuleIsActive(AutomationRule automationRule) => automationRule.isActive;

	DateTime? getAutomationRuleLastExecutedAt(AutomationRule automationRule) => automationRule.lastExecutedAt;

	int? getAutomationRuleExecutionCount(AutomationRule automationRule) => automationRule.executionCount;

	String? getAutomationRuleCreatedBy(AutomationRule automationRule) => automationRule.createdBy;

	DateTime? getAutomationRuleCreatedAt(AutomationRule automationRule) => automationRule.createdAt;

	DateTime? getAutomationRuleUpdatedAt(AutomationRule automationRule) => automationRule.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AutomationRule> getByOrgId(
    String orgId,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByRuleName(
    String ruleName,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleRuleName, ruleName, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByRuleType(
    String ruleType,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleRuleType, ruleType, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByTriggerType(
    String triggerType,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleTriggerType, triggerType, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByTriggerConfig(
    dynamic triggerConfig,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleTriggerConfig, triggerConfig, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByConditions(
    dynamic conditions,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleConditions, conditions, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByActions(
    dynamic actions,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleActions, actions, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByIsActive(
    bool isActive,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByLastExecutedAt(
    DateTime lastExecutedAt,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleLastExecutedAt, lastExecutedAt, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByExecutionCount(
    int executionCount,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleExecutionCount, executionCount, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByCreatedBy(
    String createdBy,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AutomationRule> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}
    ) =>
    getManyIncluding(getAutomationRuleUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AutomationRule automationRule, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (automationRule.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(automationRule.orgId!, includes: includes);
        automationRule.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<AutomationExecution> getExecutions(
    AutomationRule automationRule, {ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}) {
    final executions = AutomationExecutionStore.instance.getByRuleId(automationRule.$uid!, modelFilter: modelFilter, includes: includes);
    automationRule.executions = executions;
    // setIncludedReferencesForList(executions, includes: includes);
    return executions;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AutomationRule>> getAll$({bool useCache = true, ModelFilter<AutomationRule>? modelFilter, List<AutomationRuleInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AutomationRuleEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AutomationRule?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAutomationRuleId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AutomationRule>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationRuleOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByRuleName$(
        String ruleName,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationRuleRuleName,
        value: ruleName,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByRuleName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByRuleType$(
        String ruleType,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationRuleRuleType,
        value: ruleType,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByRuleType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByTriggerType$(
        String triggerType,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationRuleTriggerType,
        value: triggerType,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByTriggerType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByTriggerConfig$(
        dynamic triggerConfig,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAutomationRuleTriggerConfig,
        value: triggerConfig,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByTriggerConfig,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByConditions$(
        dynamic conditions,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAutomationRuleConditions,
        value: conditions,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByConditions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByActions$(
        dynamic actions,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAutomationRuleActions,
        value: actions,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByActions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAutomationRuleIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByLastExecutedAt$(
        DateTime lastExecutedAt,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAutomationRuleLastExecutedAt,
        value: lastExecutedAt,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByLastExecutedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByExecutionCount$(
        int executionCount,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAutomationRuleExecutionCount,
        value: executionCount,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByExecutionCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationRuleCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAutomationRuleCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationRule>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AutomationRule>? modelFilter,
        List<AutomationRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAutomationRuleUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AutomationRuleEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AutomationRule automationRule, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (automationRule.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            automationRule.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            automationRule.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<AutomationExecution>> getExecutions$(
    AutomationRule automationRule, {bool useCache = true, ModelFilter<AutomationExecution>? modelFilter, List<AutomationExecutionInclude>? includes}) {
    return AutomationExecutionStore.instance.getByRuleId$(
        automationRule.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((executions) {
        automationRule.executions = executions;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
AutomationRule recursiveUpsert(AutomationRule automationRule, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AutomationRule'} 
        : const {};
    if (automationRule.executions != null && (!preventCircularSerialization || !upsertedTypes.contains('AutomationExecution'))) {
        automationRule.executions = AutomationExecutionStore.instance.recursiveListUpsert(automationRule.executions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (automationRule.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        automationRule.org = OrganizationStore.instance.recursiveUpsert(automationRule.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(automationRule);
}

  List<AutomationRule> recursiveListUpsert(List<AutomationRule> automationRules, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAutomationRules = <AutomationRule>[];
    for (var automationRule in automationRules) {
        updatedAutomationRules.add(recursiveUpsert(automationRule, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAutomationRules;
}

//   @override
//   AutomationRule upsert(AutomationRule item) {
//     return recursiveUpsert(item);
//   }

}


class AutomationRuleInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AutomationRuleInclude.executions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AutomationExecution>? modelFilter,
    List<AutomationExecutionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (automationRule) => AutomationRuleStore.instance
            .getExecutions$(automationRule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (automationRule) => AutomationRuleStore.instance
            .getExecutions(automationRule, modelFilter: modelFilter, includes: includes);
      }
}

	AutomationRuleInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (automationRule) => AutomationRuleStore.instance
            .getOrg$(automationRule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (automationRule) => AutomationRuleStore.instance
            .getOrg(automationRule, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AutomationRuleEndpoints implements Endpoint {

    getAll('/automationRule', HttpMethod.post, List<AutomationRule>),
	getById('/automationRule/byId/:id', HttpMethod.post, AutomationRule),
	getManyByOrgId('/automationRule/byOrgId/:orgId', HttpMethod.post, List<AutomationRule>),
	getManyByRuleName('/automationRule/byRuleName/:ruleName', HttpMethod.post, List<AutomationRule>),
	getManyByRuleType('/automationRule/byRuleType/:ruleType', HttpMethod.post, List<AutomationRule>),
	getManyByTriggerType('/automationRule/byTriggerType/:triggerType', HttpMethod.post, List<AutomationRule>),
	getManyByTriggerConfig('/automationRule/byTriggerConfig/:triggerConfig', HttpMethod.post, List<AutomationRule>),
	getManyByConditions('/automationRule/byConditions/:conditions', HttpMethod.post, List<AutomationRule>),
	getManyByActions('/automationRule/byActions/:actions', HttpMethod.post, List<AutomationRule>),
	getManyByIsActive('/automationRule/byIsActive/:isActive', HttpMethod.post, List<AutomationRule>),
	getManyByLastExecutedAt('/automationRule/byLastExecutedAt/:lastExecutedAt', HttpMethod.post, List<AutomationRule>),
	getManyByExecutionCount('/automationRule/byExecutionCount/:executionCount', HttpMethod.post, List<AutomationRule>),
	getManyByCreatedBy('/automationRule/byCreatedBy/:createdBy', HttpMethod.post, List<AutomationRule>),
	getManyByCreatedAt('/automationRule/byCreatedAt/:createdAt', HttpMethod.post, List<AutomationRule>),
	getManyByUpdatedAt('/automationRule/byUpdatedAt/:updatedAt', HttpMethod.post, List<AutomationRule>);

    const AutomationRuleEndpoints(this.path, this.method, this.responseType);

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
