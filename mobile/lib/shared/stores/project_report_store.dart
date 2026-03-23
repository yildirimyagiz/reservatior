
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ProjectReportStore extends ModelStreamStore<String, ProjectReport> {

  static ProjectReportStore? _instance;

  static ProjectReportStore get instance {
    _instance ??= ProjectReportStore();
    return _instance!;
  }

  ProjectReportStore() : super(ProjectReport.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ProjectReportStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ProjectReportStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ProjectReportStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getProjectReportId(ProjectReport projectReport) => projectReport.id;

	String? getProjectReportProjectId(ProjectReport projectReport) => projectReport.projectId;

	String? getProjectReportReportType(ProjectReport projectReport) => projectReport.reportType;

	String? getProjectReportTitle(ProjectReport projectReport) => projectReport.title;

	String? getProjectReportContent(ProjectReport projectReport) => projectReport.content;

	dynamic? getProjectReportData(ProjectReport projectReport) => projectReport.data;

	String? getProjectReportGeneratedBy(ProjectReport projectReport) => projectReport.generatedBy;

	DateTime? getProjectReportCreatedAt(ProjectReport projectReport) => projectReport.createdAt;

	DateTime? getProjectReportUpdatedAt(ProjectReport projectReport) => projectReport.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ProjectReport> getByProjectId(
    String projectId,
    {ModelFilter<ProjectReport>? modelFilter, List<ProjectReportInclude>? includes}
    ) =>
    getManyIncluding(getProjectReportProjectId, projectId, modelFilter: modelFilter, includes: includes);

	
List<ProjectReport> getByReportType(
    String reportType,
    {ModelFilter<ProjectReport>? modelFilter, List<ProjectReportInclude>? includes}
    ) =>
    getManyIncluding(getProjectReportReportType, reportType, modelFilter: modelFilter, includes: includes);

	
List<ProjectReport> getByTitle(
    String title,
    {ModelFilter<ProjectReport>? modelFilter, List<ProjectReportInclude>? includes}
    ) =>
    getManyIncluding(getProjectReportTitle, title, modelFilter: modelFilter, includes: includes);

	
List<ProjectReport> getByContent(
    String content,
    {ModelFilter<ProjectReport>? modelFilter, List<ProjectReportInclude>? includes}
    ) =>
    getManyIncluding(getProjectReportContent, content, modelFilter: modelFilter, includes: includes);

	
List<ProjectReport> getByData(
    dynamic data,
    {ModelFilter<ProjectReport>? modelFilter, List<ProjectReportInclude>? includes}
    ) =>
    getManyIncluding(getProjectReportData, data, modelFilter: modelFilter, includes: includes);

	
List<ProjectReport> getByGeneratedBy(
    String generatedBy,
    {ModelFilter<ProjectReport>? modelFilter, List<ProjectReportInclude>? includes}
    ) =>
    getManyIncluding(getProjectReportGeneratedBy, generatedBy, modelFilter: modelFilter, includes: includes);

	
List<ProjectReport> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ProjectReport>? modelFilter, List<ProjectReportInclude>? includes}
    ) =>
    getManyIncluding(getProjectReportCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ProjectReport> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ProjectReport>? modelFilter, List<ProjectReportInclude>? includes}
    ) =>
    getManyIncluding(getProjectReportUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Project? getProject(
    ProjectReport projectReport, {ModelFilter? modelFilter, List<ProjectInclude>? includes}) {
    if (projectReport.projectId == null) {
        return null;
    } else {
        final project = ProjectStore.instance.getById(projectReport.projectId!, includes: includes);
        projectReport.project = project;
        // setIncludedReferences(project, includes: includes);
        return project;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ProjectReport>> getAll$({bool useCache = true, ModelFilter<ProjectReport>? modelFilter, List<ProjectReportInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ProjectReportEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ProjectReport?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ProjectReport>? modelFilter,
        List<ProjectReportInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getProjectReportId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ProjectReportEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ProjectReport>> getByProjectId$(
        String projectId,
        {bool useCache = true,
        ModelFilter<ProjectReport>? modelFilter,
        List<ProjectReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectReportProjectId,
        value: projectId,
        modelFilter: modelFilter,
        endpoint: ProjectReportEndpoints.getManyByProjectId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectReport>> getByReportType$(
        String reportType,
        {bool useCache = true,
        ModelFilter<ProjectReport>? modelFilter,
        List<ProjectReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectReportReportType,
        value: reportType,
        modelFilter: modelFilter,
        endpoint: ProjectReportEndpoints.getManyByReportType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectReport>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<ProjectReport>? modelFilter,
        List<ProjectReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectReportTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: ProjectReportEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectReport>> getByContent$(
        String content,
        {bool useCache = true,
        ModelFilter<ProjectReport>? modelFilter,
        List<ProjectReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectReportContent,
        value: content,
        modelFilter: modelFilter,
        endpoint: ProjectReportEndpoints.getManyByContent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectReport>> getByData$(
        dynamic data,
        {bool useCache = true,
        ModelFilter<ProjectReport>? modelFilter,
        List<ProjectReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getProjectReportData,
        value: data,
        modelFilter: modelFilter,
        endpoint: ProjectReportEndpoints.getManyByData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectReport>> getByGeneratedBy$(
        String generatedBy,
        {bool useCache = true,
        ModelFilter<ProjectReport>? modelFilter,
        List<ProjectReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectReportGeneratedBy,
        value: generatedBy,
        modelFilter: modelFilter,
        endpoint: ProjectReportEndpoints.getManyByGeneratedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectReport>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ProjectReport>? modelFilter,
        List<ProjectReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectReportCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ProjectReportEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectReport>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ProjectReport>? modelFilter,
        List<ProjectReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectReportUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ProjectReportEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Project?> getProject$(
    ProjectReport projectReport, {bool useCache = true, ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    if (projectReport.projectId == null) {
        return Stream.value(null);
    } else {
        return ProjectStore.instance.getById$(
            projectReport.projectId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((project) {
            projectReport.project = project;
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
ProjectReport recursiveUpsert(ProjectReport projectReport, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ProjectReport'} 
        : const {};
    if (projectReport.project != null && (!preventCircularSerialization || !upsertedTypes.contains('Project'))) {
        projectReport.project = ProjectStore.instance.recursiveUpsert(projectReport.project!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(projectReport);
}

  List<ProjectReport> recursiveListUpsert(List<ProjectReport> projectReports, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedProjectReports = <ProjectReport>[];
    for (var projectReport in projectReports) {
        updatedProjectReports.add(recursiveUpsert(projectReport, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedProjectReports;
}

//   @override
//   ProjectReport upsert(ProjectReport item) {
//     return recursiveUpsert(item);
//   }

}


class ProjectReportInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ProjectReportInclude.project({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Project>? modelFilter,
    List<ProjectInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (projectReport) => ProjectReportStore.instance
            .getProject$(projectReport, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (projectReport) => ProjectReportStore.instance
            .getProject(projectReport, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ProjectReportEndpoints implements Endpoint {

    getAll('/projectReport', HttpMethod.post, List<ProjectReport>),
	getById('/projectReport/byId/:id', HttpMethod.post, ProjectReport),
	getManyByProjectId('/projectReport/byProjectId/:projectId', HttpMethod.post, List<ProjectReport>),
	getManyByReportType('/projectReport/byReportType/:reportType', HttpMethod.post, List<ProjectReport>),
	getManyByTitle('/projectReport/byTitle/:title', HttpMethod.post, List<ProjectReport>),
	getManyByContent('/projectReport/byContent/:content', HttpMethod.post, List<ProjectReport>),
	getManyByData('/projectReport/byData/:data', HttpMethod.post, List<ProjectReport>),
	getManyByGeneratedBy('/projectReport/byGeneratedBy/:generatedBy', HttpMethod.post, List<ProjectReport>),
	getManyByCreatedAt('/projectReport/byCreatedAt/:createdAt', HttpMethod.post, List<ProjectReport>),
	getManyByUpdatedAt('/projectReport/byUpdatedAt/:updatedAt', HttpMethod.post, List<ProjectReport>);

    const ProjectReportEndpoints(this.path, this.method, this.responseType);

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
