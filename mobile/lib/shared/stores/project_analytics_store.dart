
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ProjectAnalyticsStore extends ModelStreamStore<String, ProjectAnalytics> {

  static ProjectAnalyticsStore? _instance;

  static ProjectAnalyticsStore get instance {
    _instance ??= ProjectAnalyticsStore();
    return _instance!;
  }

  ProjectAnalyticsStore() : super(ProjectAnalytics.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ProjectAnalyticsStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ProjectAnalyticsStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ProjectAnalyticsStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getProjectAnalyticsId(ProjectAnalytics projectAnalytics) => projectAnalytics.id;

	String? getProjectAnalyticsProjectId(ProjectAnalytics projectAnalytics) => projectAnalytics.projectId;

	String? getProjectAnalyticsAnalysisType(ProjectAnalytics projectAnalytics) => projectAnalytics.analysisType;

	dynamic? getProjectAnalyticsAnalysisData(ProjectAnalytics projectAnalytics) => projectAnalytics.analysisData;

	List<String>? getProjectAnalyticsInsights(ProjectAnalytics projectAnalytics) => projectAnalytics.insights;

	List<String>? getProjectAnalyticsRecommendations(ProjectAnalytics projectAnalytics) => projectAnalytics.recommendations;

	double? getProjectAnalyticsScore(ProjectAnalytics projectAnalytics) => projectAnalytics.score;

	DateTime? getProjectAnalyticsCreatedAt(ProjectAnalytics projectAnalytics) => projectAnalytics.createdAt;

	DateTime? getProjectAnalyticsUpdatedAt(ProjectAnalytics projectAnalytics) => projectAnalytics.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ProjectAnalytics> getByProjectId(
    String projectId,
    {ModelFilter<ProjectAnalytics>? modelFilter, List<ProjectAnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getProjectAnalyticsProjectId, projectId, modelFilter: modelFilter, includes: includes);

	
List<ProjectAnalytics> getByAnalysisType(
    String analysisType,
    {ModelFilter<ProjectAnalytics>? modelFilter, List<ProjectAnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getProjectAnalyticsAnalysisType, analysisType, modelFilter: modelFilter, includes: includes);

	
List<ProjectAnalytics> getByAnalysisData(
    dynamic analysisData,
    {ModelFilter<ProjectAnalytics>? modelFilter, List<ProjectAnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getProjectAnalyticsAnalysisData, analysisData, modelFilter: modelFilter, includes: includes);

	
List<ProjectAnalytics> getByInsights(
    String insights,
    {ModelFilter<ProjectAnalytics>? modelFilter, List<ProjectAnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getProjectAnalyticsInsights, insights, modelFilter: modelFilter, includes: includes);

	
List<ProjectAnalytics> getByRecommendations(
    String recommendations,
    {ModelFilter<ProjectAnalytics>? modelFilter, List<ProjectAnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getProjectAnalyticsRecommendations, recommendations, modelFilter: modelFilter, includes: includes);

	
List<ProjectAnalytics> getByScore(
    double score,
    {ModelFilter<ProjectAnalytics>? modelFilter, List<ProjectAnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getProjectAnalyticsScore, score, modelFilter: modelFilter, includes: includes);

	
List<ProjectAnalytics> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ProjectAnalytics>? modelFilter, List<ProjectAnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getProjectAnalyticsCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ProjectAnalytics> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ProjectAnalytics>? modelFilter, List<ProjectAnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getProjectAnalyticsUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Project? getProject(
    ProjectAnalytics projectAnalytics, {ModelFilter? modelFilter, List<ProjectInclude>? includes}) {
    if (projectAnalytics.projectId == null) {
        return null;
    } else {
        final project = ProjectStore.instance.getById(projectAnalytics.projectId!, includes: includes);
        projectAnalytics.project = project;
        // setIncludedReferences(project, includes: includes);
        return project;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ProjectAnalytics>> getAll$({bool useCache = true, ModelFilter<ProjectAnalytics>? modelFilter, List<ProjectAnalyticsInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ProjectAnalyticsEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ProjectAnalytics?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ProjectAnalytics>? modelFilter,
        List<ProjectAnalyticsInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getProjectAnalyticsId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ProjectAnalyticsEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ProjectAnalytics>> getByProjectId$(
        String projectId,
        {bool useCache = true,
        ModelFilter<ProjectAnalytics>? modelFilter,
        List<ProjectAnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectAnalyticsProjectId,
        value: projectId,
        modelFilter: modelFilter,
        endpoint: ProjectAnalyticsEndpoints.getManyByProjectId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAnalytics>> getByAnalysisType$(
        String analysisType,
        {bool useCache = true,
        ModelFilter<ProjectAnalytics>? modelFilter,
        List<ProjectAnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectAnalyticsAnalysisType,
        value: analysisType,
        modelFilter: modelFilter,
        endpoint: ProjectAnalyticsEndpoints.getManyByAnalysisType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAnalytics>> getByAnalysisData$(
        dynamic analysisData,
        {bool useCache = true,
        ModelFilter<ProjectAnalytics>? modelFilter,
        List<ProjectAnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getProjectAnalyticsAnalysisData,
        value: analysisData,
        modelFilter: modelFilter,
        endpoint: ProjectAnalyticsEndpoints.getManyByAnalysisData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAnalytics>> getByInsights$(
        String insights,
        {bool useCache = true,
        ModelFilter<ProjectAnalytics>? modelFilter,
        List<ProjectAnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectAnalyticsInsights,
        value: insights,
        modelFilter: modelFilter,
        endpoint: ProjectAnalyticsEndpoints.getManyByInsights,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAnalytics>> getByRecommendations$(
        String recommendations,
        {bool useCache = true,
        ModelFilter<ProjectAnalytics>? modelFilter,
        List<ProjectAnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectAnalyticsRecommendations,
        value: recommendations,
        modelFilter: modelFilter,
        endpoint: ProjectAnalyticsEndpoints.getManyByRecommendations,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAnalytics>> getByScore$(
        double score,
        {bool useCache = true,
        ModelFilter<ProjectAnalytics>? modelFilter,
        List<ProjectAnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getProjectAnalyticsScore,
        value: score,
        modelFilter: modelFilter,
        endpoint: ProjectAnalyticsEndpoints.getManyByScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAnalytics>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ProjectAnalytics>? modelFilter,
        List<ProjectAnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectAnalyticsCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ProjectAnalyticsEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ProjectAnalytics>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ProjectAnalytics>? modelFilter,
        List<ProjectAnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectAnalyticsUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ProjectAnalyticsEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Project?> getProject$(
    ProjectAnalytics projectAnalytics, {bool useCache = true, ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    if (projectAnalytics.projectId == null) {
        return Stream.value(null);
    } else {
        return ProjectStore.instance.getById$(
            projectAnalytics.projectId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((project) {
            projectAnalytics.project = project;
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
ProjectAnalytics recursiveUpsert(ProjectAnalytics projectAnalytics, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ProjectAnalytics'} 
        : const {};
    if (projectAnalytics.project != null && (!preventCircularSerialization || !upsertedTypes.contains('Project'))) {
        projectAnalytics.project = ProjectStore.instance.recursiveUpsert(projectAnalytics.project!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(projectAnalytics);
}

  List<ProjectAnalytics> recursiveListUpsert(List<ProjectAnalytics> projectAnalyticss, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedProjectAnalyticss = <ProjectAnalytics>[];
    for (var projectAnalytics in projectAnalyticss) {
        updatedProjectAnalyticss.add(recursiveUpsert(projectAnalytics, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedProjectAnalyticss;
}

//   @override
//   ProjectAnalytics upsert(ProjectAnalytics item) {
//     return recursiveUpsert(item);
//   }

}


class ProjectAnalyticsInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ProjectAnalyticsInclude.project({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Project>? modelFilter,
    List<ProjectInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (projectAnalytics) => ProjectAnalyticsStore.instance
            .getProject$(projectAnalytics, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (projectAnalytics) => ProjectAnalyticsStore.instance
            .getProject(projectAnalytics, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ProjectAnalyticsEndpoints implements Endpoint {

    getAll('/projectAnalytics', HttpMethod.post, List<ProjectAnalytics>),
	getById('/projectAnalytics/byId/:id', HttpMethod.post, ProjectAnalytics),
	getManyByProjectId('/projectAnalytics/byProjectId/:projectId', HttpMethod.post, List<ProjectAnalytics>),
	getManyByAnalysisType('/projectAnalytics/byAnalysisType/:analysisType', HttpMethod.post, List<ProjectAnalytics>),
	getManyByAnalysisData('/projectAnalytics/byAnalysisData/:analysisData', HttpMethod.post, List<ProjectAnalytics>),
	getManyByInsights('/projectAnalytics/byInsights/:insights', HttpMethod.post, List<ProjectAnalytics>),
	getManyByRecommendations('/projectAnalytics/byRecommendations/:recommendations', HttpMethod.post, List<ProjectAnalytics>),
	getManyByScore('/projectAnalytics/byScore/:score', HttpMethod.post, List<ProjectAnalytics>),
	getManyByCreatedAt('/projectAnalytics/byCreatedAt/:createdAt', HttpMethod.post, List<ProjectAnalytics>),
	getManyByUpdatedAt('/projectAnalytics/byUpdatedAt/:updatedAt', HttpMethod.post, List<ProjectAnalytics>);

    const ProjectAnalyticsEndpoints(this.path, this.method, this.responseType);

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
