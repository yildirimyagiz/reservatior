
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ProjectAlertStore extends ModelStreamStore<String, ProjectAlert> {

  static ProjectAlertStore? _instance;

  static ProjectAlertStore get instance {
    _instance ??= ProjectAlertStore();
    return _instance!;
  }

  ProjectAlertStore() : super(ProjectAlert.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ProjectAlertStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ProjectAlertStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ProjectAlertStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getProjectAlertId(ProjectAlert projectAlert) => projectAlert.id;

	String? getProjectAlertProjectId(ProjectAlert projectAlert) => projectAlert.projectId;

	String? getProjectAlertAlertType(ProjectAlert projectAlert) => projectAlert.alertType;

	String? getProjectAlertTitle(ProjectAlert projectAlert) => projectAlert.title;

	String? getProjectAlertMessage(ProjectAlert projectAlert) => projectAlert.message;

	String? getProjectAlertSeverity(ProjectAlert projectAlert) => projectAlert.severity;

	bool? getProjectAlertIsRead(ProjectAlert projectAlert) => projectAlert.isRead;

	bool? getProjectAlertIsResolved(ProjectAlert projectAlert) => projectAlert.isResolved;

	DateTime? getProjectAlertCreatedAt(ProjectAlert projectAlert) => projectAlert.createdAt;

	DateTime? getProjectAlertUpdatedAt(ProjectAlert projectAlert) => projectAlert.updatedAt;

	DateTime? getProjectAlertResolvedAt(ProjectAlert projectAlert) => projectAlert.resolvedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ProjectAlert> getByProjectId(
    String projectId,
    {ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}
    ) =>
    getManyIncluding(getProjectAlertProjectId, projectId, modelFilter: modelFilter, includes: includes);

	
List<ProjectAlert> getByAlertType(
    String alertType,
    {ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}
    ) =>
    getManyIncluding(getProjectAlertAlertType, alertType, modelFilter: modelFilter, includes: includes);

	
List<ProjectAlert> getByTitle(
    String title,
    {ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}
    ) =>
    getManyIncluding(getProjectAlertTitle, title, modelFilter: modelFilter, includes: includes);

	
List<ProjectAlert> getByMessage(
    String message,
    {ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}
    ) =>
    getManyIncluding(getProjectAlertMessage, message, modelFilter: modelFilter, includes: includes);

	
List<ProjectAlert> getBySeverity(
    String severity,
    {ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}
    ) =>
    getManyIncluding(getProjectAlertSeverity, severity, modelFilter: modelFilter, includes: includes);

	
List<ProjectAlert> getByIsRead(
    bool isRead,
    {ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}
    ) =>
    getManyIncluding(getProjectAlertIsRead, isRead, modelFilter: modelFilter, includes: includes);

	
List<ProjectAlert> getByIsResolved(
    bool isResolved,
    {ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}
    ) =>
    getManyIncluding(getProjectAlertIsResolved, isResolved, modelFilter: modelFilter, includes: includes);

	
List<ProjectAlert> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}
    ) =>
    getManyIncluding(getProjectAlertCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ProjectAlert> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}
    ) =>
    getManyIncluding(getProjectAlertUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ProjectAlert> getByResolvedAt(
    DateTime resolvedAt,
    {ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}
    ) =>
    getManyIncluding(getProjectAlertResolvedAt, resolvedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Project? getProject(
    ProjectAlert projectAlert, {ModelFilter? modelFilter, List<ProjectInclude>? includes}) {
    if (projectAlert.projectId == null) {
        return null;
    } else {
        final project = ProjectStore.instance.getById(projectAlert.projectId!, includes: includes);
        projectAlert.project = project;
        // setIncludedReferences(project, includes: includes);
        return project;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ProjectAlert>> getAll$({bool useCache = true, ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ProjectAlertEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ProjectAlert?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ProjectAlert>? modelFilter,
        List<ProjectAlertInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getProjectAlertId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ProjectAlertEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ProjectAlert>> getByProjectId$(
        String projectId,
        {bool useCache = true,
        ModelFilter<ProjectAlert>? modelFilter,
        List<ProjectAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectAlertProjectId,
        value: projectId,
        modelFilter: modelFilter,
        endpoint: ProjectAlertEndpoints.getManyByProjectId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAlert>> getByAlertType$(
        String alertType,
        {bool useCache = true,
        ModelFilter<ProjectAlert>? modelFilter,
        List<ProjectAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectAlertAlertType,
        value: alertType,
        modelFilter: modelFilter,
        endpoint: ProjectAlertEndpoints.getManyByAlertType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAlert>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<ProjectAlert>? modelFilter,
        List<ProjectAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectAlertTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: ProjectAlertEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAlert>> getByMessage$(
        String message,
        {bool useCache = true,
        ModelFilter<ProjectAlert>? modelFilter,
        List<ProjectAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectAlertMessage,
        value: message,
        modelFilter: modelFilter,
        endpoint: ProjectAlertEndpoints.getManyByMessage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAlert>> getBySeverity$(
        String severity,
        {bool useCache = true,
        ModelFilter<ProjectAlert>? modelFilter,
        List<ProjectAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectAlertSeverity,
        value: severity,
        modelFilter: modelFilter,
        endpoint: ProjectAlertEndpoints.getManyBySeverity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAlert>> getByIsRead$(
        bool isRead,
        {bool useCache = true,
        ModelFilter<ProjectAlert>? modelFilter,
        List<ProjectAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getProjectAlertIsRead,
        value: isRead,
        modelFilter: modelFilter,
        endpoint: ProjectAlertEndpoints.getManyByIsRead,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAlert>> getByIsResolved$(
        bool isResolved,
        {bool useCache = true,
        ModelFilter<ProjectAlert>? modelFilter,
        List<ProjectAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getProjectAlertIsResolved,
        value: isResolved,
        modelFilter: modelFilter,
        endpoint: ProjectAlertEndpoints.getManyByIsResolved,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAlert>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ProjectAlert>? modelFilter,
        List<ProjectAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectAlertCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ProjectAlertEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAlert>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ProjectAlert>? modelFilter,
        List<ProjectAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectAlertUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ProjectAlertEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAlert>> getByResolvedAt$(
        DateTime resolvedAt,
        {bool useCache = true,
        ModelFilter<ProjectAlert>? modelFilter,
        List<ProjectAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectAlertResolvedAt,
        value: resolvedAt,
        modelFilter: modelFilter,
        endpoint: ProjectAlertEndpoints.getManyByResolvedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Project?> getProject$(
    ProjectAlert projectAlert, {bool useCache = true, ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    if (projectAlert.projectId == null) {
        return Stream.value(null);
    } else {
        return ProjectStore.instance.getById$(
            projectAlert.projectId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((project) {
            projectAlert.project = project;
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
ProjectAlert recursiveUpsert(ProjectAlert projectAlert, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ProjectAlert'} 
        : const {};
    if (projectAlert.project != null && (!preventCircularSerialization || !upsertedTypes.contains('Project'))) {
        projectAlert.project = ProjectStore.instance.recursiveUpsert(projectAlert.project!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(projectAlert);
}

  List<ProjectAlert> recursiveListUpsert(List<ProjectAlert> projectAlerts, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedProjectAlerts = <ProjectAlert>[];
    for (var projectAlert in projectAlerts) {
        updatedProjectAlerts.add(recursiveUpsert(projectAlert, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedProjectAlerts;
}

//   @override
//   ProjectAlert upsert(ProjectAlert item) {
//     return recursiveUpsert(item);
//   }

}


class ProjectAlertInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ProjectAlertInclude.project({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Project>? modelFilter,
    List<ProjectInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (projectAlert) => ProjectAlertStore.instance
            .getProject$(projectAlert, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (projectAlert) => ProjectAlertStore.instance
            .getProject(projectAlert, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ProjectAlertEndpoints implements Endpoint {

    getAll('/projectAlert', HttpMethod.post, List<ProjectAlert>),
	getById('/projectAlert/byId/:id', HttpMethod.post, ProjectAlert),
	getManyByProjectId('/projectAlert/byProjectId/:projectId', HttpMethod.post, List<ProjectAlert>),
	getManyByAlertType('/projectAlert/byAlertType/:alertType', HttpMethod.post, List<ProjectAlert>),
	getManyByTitle('/projectAlert/byTitle/:title', HttpMethod.post, List<ProjectAlert>),
	getManyByMessage('/projectAlert/byMessage/:message', HttpMethod.post, List<ProjectAlert>),
	getManyBySeverity('/projectAlert/bySeverity/:severity', HttpMethod.post, List<ProjectAlert>),
	getManyByIsRead('/projectAlert/byIsRead/:isRead', HttpMethod.post, List<ProjectAlert>),
	getManyByIsResolved('/projectAlert/byIsResolved/:isResolved', HttpMethod.post, List<ProjectAlert>),
	getManyByCreatedAt('/projectAlert/byCreatedAt/:createdAt', HttpMethod.post, List<ProjectAlert>),
	getManyByUpdatedAt('/projectAlert/byUpdatedAt/:updatedAt', HttpMethod.post, List<ProjectAlert>),
	getManyByResolvedAt('/projectAlert/byResolvedAt/:resolvedAt', HttpMethod.post, List<ProjectAlert>);

    const ProjectAlertEndpoints(this.path, this.method, this.responseType);

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
