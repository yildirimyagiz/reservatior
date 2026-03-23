
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ReportExecutionStore extends ModelStreamStore<String, ReportExecution> {

  static ReportExecutionStore? _instance;

  static ReportExecutionStore get instance {
    _instance ??= ReportExecutionStore();
    return _instance!;
  }

  ReportExecutionStore() : super(ReportExecution.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ReportExecutionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ReportExecutionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ReportExecutionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getReportExecutionId(ReportExecution reportExecution) => reportExecution.id;

	String? getReportExecutionOrgId(ReportExecution reportExecution) => reportExecution.orgId;

	String? getReportExecutionReportId(ReportExecution reportExecution) => reportExecution.reportId;

	DateTime? getReportExecutionExecutedAt(ReportExecution reportExecution) => reportExecution.executedAt;

	String? getReportExecutionExecutedBy(ReportExecution reportExecution) => reportExecution.executedBy;

	String? getReportExecutionStatus(ReportExecution reportExecution) => reportExecution.status;

	String? getReportExecutionResultUrl(ReportExecution reportExecution) => reportExecution.resultUrl;

	String? getReportExecutionErrorMessage(ReportExecution reportExecution) => reportExecution.errorMessage;

	dynamic? getReportExecutionParameters(ReportExecution reportExecution) => reportExecution.parameters;

	DateTime? getReportExecutionCreatedAt(ReportExecution reportExecution) => reportExecution.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ReportExecution> getByOrgId(
    String orgId,
    {ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}
    ) =>
    getManyIncluding(getReportExecutionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ReportExecution> getByReportId(
    String reportId,
    {ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}
    ) =>
    getManyIncluding(getReportExecutionReportId, reportId, modelFilter: modelFilter, includes: includes);

	
List<ReportExecution> getByExecutedAt(
    DateTime executedAt,
    {ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}
    ) =>
    getManyIncluding(getReportExecutionExecutedAt, executedAt, modelFilter: modelFilter, includes: includes);

	
List<ReportExecution> getByExecutedBy(
    String executedBy,
    {ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}
    ) =>
    getManyIncluding(getReportExecutionExecutedBy, executedBy, modelFilter: modelFilter, includes: includes);

	
List<ReportExecution> getByStatus(
    String status,
    {ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}
    ) =>
    getManyIncluding(getReportExecutionStatus, status, modelFilter: modelFilter, includes: includes);

	
List<ReportExecution> getByResultUrl(
    String resultUrl,
    {ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}
    ) =>
    getManyIncluding(getReportExecutionResultUrl, resultUrl, modelFilter: modelFilter, includes: includes);

	
List<ReportExecution> getByErrorMessage(
    String errorMessage,
    {ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}
    ) =>
    getManyIncluding(getReportExecutionErrorMessage, errorMessage, modelFilter: modelFilter, includes: includes);

	
List<ReportExecution> getByParameters(
    dynamic parameters,
    {ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}
    ) =>
    getManyIncluding(getReportExecutionParameters, parameters, modelFilter: modelFilter, includes: includes);

	
List<ReportExecution> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}
    ) =>
    getManyIncluding(getReportExecutionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    ReportExecution reportExecution, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (reportExecution.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(reportExecution.orgId!, includes: includes);
        reportExecution.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Report? getReport(
    ReportExecution reportExecution, {ModelFilter? modelFilter, List<ReportInclude>? includes}) {
    if (reportExecution.reportId == null) {
        return null;
    } else {
        final report = ReportStore.instance.getById(reportExecution.reportId!, includes: includes);
        reportExecution.report = report;
        // setIncludedReferences(report, includes: includes);
        return report;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ReportExecution>> getAll$({bool useCache = true, ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ReportExecutionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ReportExecution?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ReportExecution>? modelFilter,
        List<ReportExecutionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getReportExecutionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ReportExecutionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ReportExecution>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ReportExecution>? modelFilter,
        List<ReportExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReportExecutionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ReportExecutionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReportExecution>> getByReportId$(
        String reportId,
        {bool useCache = true,
        ModelFilter<ReportExecution>? modelFilter,
        List<ReportExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReportExecutionReportId,
        value: reportId,
        modelFilter: modelFilter,
        endpoint: ReportExecutionEndpoints.getManyByReportId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReportExecution>> getByExecutedAt$(
        DateTime executedAt,
        {bool useCache = true,
        ModelFilter<ReportExecution>? modelFilter,
        List<ReportExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReportExecutionExecutedAt,
        value: executedAt,
        modelFilter: modelFilter,
        endpoint: ReportExecutionEndpoints.getManyByExecutedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReportExecution>> getByExecutedBy$(
        String executedBy,
        {bool useCache = true,
        ModelFilter<ReportExecution>? modelFilter,
        List<ReportExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReportExecutionExecutedBy,
        value: executedBy,
        modelFilter: modelFilter,
        endpoint: ReportExecutionEndpoints.getManyByExecutedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReportExecution>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<ReportExecution>? modelFilter,
        List<ReportExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReportExecutionStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ReportExecutionEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReportExecution>> getByResultUrl$(
        String resultUrl,
        {bool useCache = true,
        ModelFilter<ReportExecution>? modelFilter,
        List<ReportExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReportExecutionResultUrl,
        value: resultUrl,
        modelFilter: modelFilter,
        endpoint: ReportExecutionEndpoints.getManyByResultUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReportExecution>> getByErrorMessage$(
        String errorMessage,
        {bool useCache = true,
        ModelFilter<ReportExecution>? modelFilter,
        List<ReportExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReportExecutionErrorMessage,
        value: errorMessage,
        modelFilter: modelFilter,
        endpoint: ReportExecutionEndpoints.getManyByErrorMessage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReportExecution>> getByParameters$(
        dynamic parameters,
        {bool useCache = true,
        ModelFilter<ReportExecution>? modelFilter,
        List<ReportExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getReportExecutionParameters,
        value: parameters,
        modelFilter: modelFilter,
        endpoint: ReportExecutionEndpoints.getManyByParameters,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReportExecution>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ReportExecution>? modelFilter,
        List<ReportExecutionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReportExecutionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ReportExecutionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    ReportExecution reportExecution, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (reportExecution.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            reportExecution.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            reportExecution.org = org;
        });
    }
}

	Stream<Report?> getReport$(
    ReportExecution reportExecution, {bool useCache = true, ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    if (reportExecution.reportId == null) {
        return Stream.value(null);
    } else {
        return ReportStore.instance.getById$(
            reportExecution.reportId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((report) {
            reportExecution.report = report;
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
ReportExecution recursiveUpsert(ReportExecution reportExecution, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ReportExecution'} 
        : const {};
    if (reportExecution.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        reportExecution.org = OrganizationStore.instance.recursiveUpsert(reportExecution.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (reportExecution.report != null && (!preventCircularSerialization || !upsertedTypes.contains('Report'))) {
        reportExecution.report = ReportStore.instance.recursiveUpsert(reportExecution.report!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(reportExecution);
}

  List<ReportExecution> recursiveListUpsert(List<ReportExecution> reportExecutions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedReportExecutions = <ReportExecution>[];
    for (var reportExecution in reportExecutions) {
        updatedReportExecutions.add(recursiveUpsert(reportExecution, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedReportExecutions;
}

//   @override
//   ReportExecution upsert(ReportExecution item) {
//     return recursiveUpsert(item);
//   }

}


class ReportExecutionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ReportExecutionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reportExecution) => ReportExecutionStore.instance
            .getOrg$(reportExecution, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reportExecution) => ReportExecutionStore.instance
            .getOrg(reportExecution, modelFilter: modelFilter, includes: includes);
      }
}

	ReportExecutionInclude.report({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Report>? modelFilter,
    List<ReportInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (reportExecution) => ReportExecutionStore.instance
            .getReport$(reportExecution, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (reportExecution) => ReportExecutionStore.instance
            .getReport(reportExecution, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ReportExecutionEndpoints implements Endpoint {

    getAll('/reportExecution', HttpMethod.post, List<ReportExecution>),
	getById('/reportExecution/byId/:id', HttpMethod.post, ReportExecution),
	getManyByOrgId('/reportExecution/byOrgId/:orgId', HttpMethod.post, List<ReportExecution>),
	getManyByReportId('/reportExecution/byReportId/:reportId', HttpMethod.post, List<ReportExecution>),
	getManyByExecutedAt('/reportExecution/byExecutedAt/:executedAt', HttpMethod.post, List<ReportExecution>),
	getManyByExecutedBy('/reportExecution/byExecutedBy/:executedBy', HttpMethod.post, List<ReportExecution>),
	getManyByStatus('/reportExecution/byStatus/:status', HttpMethod.post, List<ReportExecution>),
	getManyByResultUrl('/reportExecution/byResultUrl/:resultUrl', HttpMethod.post, List<ReportExecution>),
	getManyByErrorMessage('/reportExecution/byErrorMessage/:errorMessage', HttpMethod.post, List<ReportExecution>),
	getManyByParameters('/reportExecution/byParameters/:parameters', HttpMethod.post, List<ReportExecution>),
	getManyByCreatedAt('/reportExecution/byCreatedAt/:createdAt', HttpMethod.post, List<ReportExecution>);

    const ReportExecutionEndpoints(this.path, this.method, this.responseType);

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
