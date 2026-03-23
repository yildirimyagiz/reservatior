
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ReportStore extends ModelStreamStore<String, Report> {

  static ReportStore? _instance;

  static ReportStore get instance {
    _instance ??= ReportStore();
    return _instance!;
  }

  ReportStore() : super(Report.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ReportStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ReportStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ReportStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getReportId(Report report) => report.id;

	String? getReportOrgId(Report report) => report.orgId;

	String? getReportUserId(Report report) => report.userId;

	String? getReportName(Report report) => report.name;

	String? getReportDescription(Report report) => report.description;

	String? getReportReportType(Report report) => report.reportType;

	dynamic? getReportConfig(Report report) => report.config;

	dynamic? getReportSchedule(Report report) => report.schedule;

	dynamic? getReportRecipients(Report report) => report.recipients;

	DateTime? getReportLastRunAt(Report report) => report.lastRunAt;

	bool? getReportIsActive(Report report) => report.isActive;

	DateTime? getReportCreatedAt(Report report) => report.createdAt;

	DateTime? getReportUpdatedAt(Report report) => report.updatedAt;

	DateTime? getReportDeletedAt(Report report) => report.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Report> getByOrgId(
    String orgId,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Report> getByUserId(
    String userId,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Report> getByName(
    String name,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportName, name, modelFilter: modelFilter, includes: includes);

	
List<Report> getByDescription(
    String description,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Report> getByReportType(
    String reportType,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportReportType, reportType, modelFilter: modelFilter, includes: includes);

	
List<Report> getByConfig(
    dynamic config,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportConfig, config, modelFilter: modelFilter, includes: includes);

	
List<Report> getBySchedule(
    dynamic schedule,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportSchedule, schedule, modelFilter: modelFilter, includes: includes);

	
List<Report> getByRecipients(
    dynamic recipients,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportRecipients, recipients, modelFilter: modelFilter, includes: includes);

	
List<Report> getByLastRunAt(
    DateTime lastRunAt,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportLastRunAt, lastRunAt, modelFilter: modelFilter, includes: includes);

	
List<Report> getByIsActive(
    bool isActive,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Report> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Report> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Report> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}
    ) =>
    getManyIncluding(getReportDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Report report, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (report.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(report.orgId!, includes: includes);
        report.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    Report report, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (report.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(report.userId!, includes: includes);
        report.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  List<ReportExecution> getExecutions(
    Report report, {ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}) {
    final executions = ReportExecutionStore.instance.getByReportId(report.$uid!, modelFilter: modelFilter, includes: includes);
    report.executions = executions;
    // setIncludedReferencesForList(executions, includes: includes);
    return executions;
}

	List<Agent> getAgents(
    Report report, {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    final agents = AgentStore.instance.getBy(report.$uid!, modelFilter: modelFilter, includes: includes);
    report.agents = agents;
    // setIncludedReferencesForList(agents, includes: includes);
    return agents;
}

	List<ExtraCharge> getExtraCharges(
    Report report, {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    final extraCharges = ExtraChargeStore.instance.getBy(report.$uid!, modelFilter: modelFilter, includes: includes);
    report.extraCharges = extraCharges;
    // setIncludedReferencesForList(extraCharges, includes: includes);
    return extraCharges;
}

	List<Agency> getAgencies(
    Report report, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getBy(report.$uid!, modelFilter: modelFilter, includes: includes);
    report.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<ReferenceSource> getReferenceSources(
    Report report, {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}) {
    final referenceSources = ReferenceSourceStore.instance.getBy(report.$uid!, modelFilter: modelFilter, includes: includes);
    report.referenceSources = referenceSources;
    // setIncludedReferencesForList(referenceSources, includes: includes);
    return referenceSources;
}

	List<Tenant> getTenants(
    Report report, {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    final tenants = TenantStore.instance.getBy(report.$uid!, modelFilter: modelFilter, includes: includes);
    report.tenants = tenants;
    // setIncludedReferencesForList(tenants, includes: includes);
    return tenants;
}

	List<IncludedService> getIncludedServices(
    Report report, {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    final includedServices = IncludedServiceStore.instance.getBy(report.$uid!, modelFilter: modelFilter, includes: includes);
    report.includedServices = includedServices;
    // setIncludedReferencesForList(includedServices, includes: includes);
    return includedServices;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Report>> getAll$({bool useCache = true, ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ReportEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Report?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getReportId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Report>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReportOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReportUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReportName,
        value: name,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReportDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getByReportType$(
        String reportType,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReportReportType,
        value: reportType,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByReportType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getByConfig$(
        dynamic config,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getReportConfig,
        value: config,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByConfig,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getBySchedule$(
        dynamic schedule,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getReportSchedule,
        value: schedule,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyBySchedule,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getByRecipients$(
        dynamic recipients,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getReportRecipients,
        value: recipients,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByRecipients,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getByLastRunAt$(
        DateTime lastRunAt,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReportLastRunAt,
        value: lastRunAt,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByLastRunAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getReportIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReportCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReportUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Report>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Report>? modelFilter,
        List<ReportInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReportDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ReportEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Report report, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (report.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            report.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            report.org = org;
        });
    }
}

	Stream<User?> getUser$(
    Report report, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (report.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            report.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            report.user = user;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<ReportExecution>> getExecutions$(
    Report report, {bool useCache = true, ModelFilter<ReportExecution>? modelFilter, List<ReportExecutionInclude>? includes}) {
    return ReportExecutionStore.instance.getByReportId$(
        report.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((executions) {
        report.executions = executions;
    });

}

	Stream<List<Agent>> getAgents$(
    Report report, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    return AgentStore.instance.getBy$(
        report.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agents) {
        report.agents = agents;
    });

}

	Stream<List<ExtraCharge>> getExtraCharges$(
    Report report, {bool useCache = true, ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    return ExtraChargeStore.instance.getBy$(
        report.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((extraCharges) {
        report.extraCharges = extraCharges;
    });

}

	Stream<List<Agency>> getAgencies$(
    Report report, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        report.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        report.agencies = agencies;
    });

}

	Stream<List<ReferenceSource>> getReferenceSources$(
    Report report, {bool useCache = true, ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}) {
    return ReferenceSourceStore.instance.getBy$(
        report.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((referenceSources) {
        report.referenceSources = referenceSources;
    });

}

	Stream<List<Tenant>> getTenants$(
    Report report, {bool useCache = true, ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    return TenantStore.instance.getBy$(
        report.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tenants) {
        report.tenants = tenants;
    });

}

	Stream<List<IncludedService>> getIncludedServices$(
    Report report, {bool useCache = true, ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    return IncludedServiceStore.instance.getBy$(
        report.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((includedServices) {
        report.includedServices = includedServices;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Report recursiveUpsert(Report report, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Report'} 
        : const {};
    if (report.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        report.org = OrganizationStore.instance.recursiveUpsert(report.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (report.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        report.user = UserStore.instance.recursiveUpsert(report.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (report.executions != null && (!preventCircularSerialization || !upsertedTypes.contains('ReportExecution'))) {
        report.executions = ReportExecutionStore.instance.recursiveListUpsert(report.executions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (report.agents != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        report.agents = AgentStore.instance.recursiveListUpsert(report.agents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (report.extraCharges != null && (!preventCircularSerialization || !upsertedTypes.contains('ExtraCharge'))) {
        report.extraCharges = ExtraChargeStore.instance.recursiveListUpsert(report.extraCharges!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (report.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        report.agencies = AgencyStore.instance.recursiveListUpsert(report.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (report.referenceSources != null && (!preventCircularSerialization || !upsertedTypes.contains('ReferenceSource'))) {
        report.referenceSources = ReferenceSourceStore.instance.recursiveListUpsert(report.referenceSources!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (report.tenants != null && (!preventCircularSerialization || !upsertedTypes.contains('Tenant'))) {
        report.tenants = TenantStore.instance.recursiveListUpsert(report.tenants!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (report.includedServices != null && (!preventCircularSerialization || !upsertedTypes.contains('IncludedService'))) {
        report.includedServices = IncludedServiceStore.instance.recursiveListUpsert(report.includedServices!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(report);
}

  List<Report> recursiveListUpsert(List<Report> reports, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedReports = <Report>[];
    for (var report in reports) {
        updatedReports.add(recursiveUpsert(report, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedReports;
}

//   @override
//   Report upsert(Report item) {
//     return recursiveUpsert(item);
//   }

}


class ReportInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ReportInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (report) => ReportStore.instance
            .getOrg$(report, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (report) => ReportStore.instance
            .getOrg(report, modelFilter: modelFilter, includes: includes);
      }
}

	ReportInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (report) => ReportStore.instance
            .getUser$(report, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (report) => ReportStore.instance
            .getUser(report, modelFilter: modelFilter, includes: includes);
      }
}

	ReportInclude.executions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ReportExecution>? modelFilter,
    List<ReportExecutionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (report) => ReportStore.instance
            .getExecutions$(report, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (report) => ReportStore.instance
            .getExecutions(report, modelFilter: modelFilter, includes: includes);
      }
}

	ReportInclude.agents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (report) => ReportStore.instance
            .getAgents$(report, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (report) => ReportStore.instance
            .getAgents(report, modelFilter: modelFilter, includes: includes);
      }
}

	ReportInclude.extraCharges({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExtraCharge>? modelFilter,
    List<ExtraChargeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (report) => ReportStore.instance
            .getExtraCharges$(report, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (report) => ReportStore.instance
            .getExtraCharges(report, modelFilter: modelFilter, includes: includes);
      }
}

	ReportInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (report) => ReportStore.instance
            .getAgencies$(report, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (report) => ReportStore.instance
            .getAgencies(report, modelFilter: modelFilter, includes: includes);
      }
}

	ReportInclude.referenceSources({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ReferenceSource>? modelFilter,
    List<ReferenceSourceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (report) => ReportStore.instance
            .getReferenceSources$(report, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (report) => ReportStore.instance
            .getReferenceSources(report, modelFilter: modelFilter, includes: includes);
      }
}

	ReportInclude.tenants({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tenant>? modelFilter,
    List<TenantInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (report) => ReportStore.instance
            .getTenants$(report, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (report) => ReportStore.instance
            .getTenants(report, modelFilter: modelFilter, includes: includes);
      }
}

	ReportInclude.includedServices({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<IncludedService>? modelFilter,
    List<IncludedServiceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (report) => ReportStore.instance
            .getIncludedServices$(report, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (report) => ReportStore.instance
            .getIncludedServices(report, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ReportEndpoints implements Endpoint {

    getAll('/report', HttpMethod.post, List<Report>),
	getById('/report/byId/:id', HttpMethod.post, Report),
	getManyByOrgId('/report/byOrgId/:orgId', HttpMethod.post, List<Report>),
	getManyByUserId('/report/byUserId/:userId', HttpMethod.post, List<Report>),
	getManyByName('/report/byName/:name', HttpMethod.post, List<Report>),
	getManyByDescription('/report/byDescription/:description', HttpMethod.post, List<Report>),
	getManyByReportType('/report/byReportType/:reportType', HttpMethod.post, List<Report>),
	getManyByConfig('/report/byConfig/:config', HttpMethod.post, List<Report>),
	getManyBySchedule('/report/bySchedule/:schedule', HttpMethod.post, List<Report>),
	getManyByRecipients('/report/byRecipients/:recipients', HttpMethod.post, List<Report>),
	getManyByLastRunAt('/report/byLastRunAt/:lastRunAt', HttpMethod.post, List<Report>),
	getManyByIsActive('/report/byIsActive/:isActive', HttpMethod.post, List<Report>),
	getManyByCreatedAt('/report/byCreatedAt/:createdAt', HttpMethod.post, List<Report>),
	getManyByUpdatedAt('/report/byUpdatedAt/:updatedAt', HttpMethod.post, List<Report>),
	getManyByDeletedAt('/report/byDeletedAt/:deletedAt', HttpMethod.post, List<Report>);

    const ReportEndpoints(this.path, this.method, this.responseType);

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
