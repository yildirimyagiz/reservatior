
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AutomationTaskStore extends ModelStreamStore<String, AutomationTask> {

  static AutomationTaskStore? _instance;

  static AutomationTaskStore get instance {
    _instance ??= AutomationTaskStore();
    return _instance!;
  }

  AutomationTaskStore() : super(AutomationTask.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AutomationTaskStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AutomationTaskStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AutomationTaskStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAutomationTaskId(AutomationTask automationTask) => automationTask.id;

	String? getAutomationTaskTaskType(AutomationTask automationTask) => automationTask.taskType;

	String? getAutomationTaskPersona(AutomationTask automationTask) => automationTask.persona;

	String? getAutomationTaskCommand(AutomationTask automationTask) => automationTask.command;

	String? getAutomationTaskStatus(AutomationTask automationTask) => automationTask.status;

	String? getAutomationTaskSchedule(AutomationTask automationTask) => automationTask.schedule;

	DateTime? getAutomationTaskLastRun(AutomationTask automationTask) => automationTask.lastRun;

	DateTime? getAutomationTaskNextRun(AutomationTask automationTask) => automationTask.nextRun;

	dynamic? getAutomationTaskConfiguration(AutomationTask automationTask) => automationTask.configuration;

	dynamic? getAutomationTaskResult(AutomationTask automationTask) => automationTask.result;

	String? getAutomationTaskError(AutomationTask automationTask) => automationTask.error;

	DateTime? getAutomationTaskCreatedAt(AutomationTask automationTask) => automationTask.createdAt;

	DateTime? getAutomationTaskUpdatedAt(AutomationTask automationTask) => automationTask.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AutomationTask> getByTaskType(
    String taskType,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskTaskType, taskType, modelFilter: modelFilter, includes: includes);

	
List<AutomationTask> getByPersona(
    String persona,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskPersona, persona, modelFilter: modelFilter, includes: includes);

	
List<AutomationTask> getByCommand(
    String command,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskCommand, command, modelFilter: modelFilter, includes: includes);

	
List<AutomationTask> getByStatus(
    String status,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AutomationTask> getBySchedule(
    String schedule,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskSchedule, schedule, modelFilter: modelFilter, includes: includes);

	
List<AutomationTask> getByLastRun(
    DateTime lastRun,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskLastRun, lastRun, modelFilter: modelFilter, includes: includes);

	
List<AutomationTask> getByNextRun(
    DateTime nextRun,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskNextRun, nextRun, modelFilter: modelFilter, includes: includes);

	
List<AutomationTask> getByConfiguration(
    dynamic configuration,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskConfiguration, configuration, modelFilter: modelFilter, includes: includes);

	
List<AutomationTask> getByResult(
    dynamic result,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskResult, result, modelFilter: modelFilter, includes: includes);

	
List<AutomationTask> getByError(
    String error,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskError, error, modelFilter: modelFilter, includes: includes);

	
List<AutomationTask> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AutomationTask> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}
    ) =>
    getManyIncluding(getAutomationTaskUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AutomationTask>> getAll$({bool useCache = true, ModelFilter<AutomationTask>? modelFilter, List<AutomationTaskInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AutomationTaskEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AutomationTask?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAutomationTaskId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AutomationTask>> getByTaskType$(
        String taskType,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationTaskTaskType,
        value: taskType,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyByTaskType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationTask>> getByPersona$(
        String persona,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationTaskPersona,
        value: persona,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyByPersona,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationTask>> getByCommand$(
        String command,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationTaskCommand,
        value: command,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyByCommand,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationTask>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationTaskStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationTask>> getBySchedule$(
        String schedule,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationTaskSchedule,
        value: schedule,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyBySchedule,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationTask>> getByLastRun$(
        DateTime lastRun,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAutomationTaskLastRun,
        value: lastRun,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyByLastRun,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationTask>> getByNextRun$(
        DateTime nextRun,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAutomationTaskNextRun,
        value: nextRun,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyByNextRun,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationTask>> getByConfiguration$(
        dynamic configuration,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAutomationTaskConfiguration,
        value: configuration,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyByConfiguration,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationTask>> getByResult$(
        dynamic result,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAutomationTaskResult,
        value: result,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyByResult,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationTask>> getByError$(
        String error,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAutomationTaskError,
        value: error,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyByError,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationTask>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAutomationTaskCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AutomationTask>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AutomationTask>? modelFilter,
        List<AutomationTaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAutomationTaskUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AutomationTaskEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  

  /// GET RELATED MODELS as STREAM

  

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
AutomationTask recursiveUpsert(AutomationTask automationTask, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AutomationTask'} 
        : const {};
    
    return super.upsert(automationTask);
}

  List<AutomationTask> recursiveListUpsert(List<AutomationTask> automationTasks, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAutomationTasks = <AutomationTask>[];
    for (var automationTask in automationTasks) {
        updatedAutomationTasks.add(recursiveUpsert(automationTask, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAutomationTasks;
}

//   @override
//   AutomationTask upsert(AutomationTask item) {
//     return recursiveUpsert(item);
//   }

}


class AutomationTaskInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AutomationTaskInclude.empty({this.useCache = true, this.useAsync = true});
  }


enum AutomationTaskEndpoints implements Endpoint {

    getAll('/automationTask', HttpMethod.post, List<AutomationTask>),
	getById('/automationTask/byId/:id', HttpMethod.post, AutomationTask),
	getManyByTaskType('/automationTask/byTaskType/:taskType', HttpMethod.post, List<AutomationTask>),
	getManyByPersona('/automationTask/byPersona/:persona', HttpMethod.post, List<AutomationTask>),
	getManyByCommand('/automationTask/byCommand/:command', HttpMethod.post, List<AutomationTask>),
	getManyByStatus('/automationTask/byStatus/:status', HttpMethod.post, List<AutomationTask>),
	getManyBySchedule('/automationTask/bySchedule/:schedule', HttpMethod.post, List<AutomationTask>),
	getManyByLastRun('/automationTask/byLastRun/:lastRun', HttpMethod.post, List<AutomationTask>),
	getManyByNextRun('/automationTask/byNextRun/:nextRun', HttpMethod.post, List<AutomationTask>),
	getManyByConfiguration('/automationTask/byConfiguration/:configuration', HttpMethod.post, List<AutomationTask>),
	getManyByResult('/automationTask/byResult/:result', HttpMethod.post, List<AutomationTask>),
	getManyByError('/automationTask/byError/:error', HttpMethod.post, List<AutomationTask>),
	getManyByCreatedAt('/automationTask/byCreatedAt/:createdAt', HttpMethod.post, List<AutomationTask>),
	getManyByUpdatedAt('/automationTask/byUpdatedAt/:updatedAt', HttpMethod.post, List<AutomationTask>);

    const AutomationTaskEndpoints(this.path, this.method, this.responseType);

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
