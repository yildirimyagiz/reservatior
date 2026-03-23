
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ProjectStore extends ModelStreamStore<String, Project> {

  static ProjectStore? _instance;

  static ProjectStore get instance {
    _instance ??= ProjectStore();
    return _instance!;
  }

  ProjectStore() : super(Project.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ProjectStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ProjectStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ProjectStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getProjectId(Project project) => project.id;

	String? getProjectOrgId(Project project) => project.orgId;

	String? getProjectName(Project project) => project.name;

	String? getProjectDescription(Project project) => project.description;

	String? getProjectProjectType(Project project) => project.projectType;

	String? getProjectPropertyId(Project project) => project.propertyId;

	String? getProjectAddress(Project project) => project.address;

	String? getProjectStatus(Project project) => project.status;

	DateTime? getProjectStartDate(Project project) => project.startDate;

	DateTime? getProjectEstimatedEndDate(Project project) => project.estimatedEndDate;

	DateTime? getProjectActualEndDate(Project project) => project.actualEndDate;

	double? getProjectBudget(Project project) => project.budget;

	String? getProjectCurrency(Project project) => project.currency;

	double? getProjectActualCost(Project project) => project.actualCost;

	String? getProjectManagerId(Project project) => project.managerId;

	String? getProjectContractorId(Project project) => project.contractorId;

	dynamic? getProjectMilestones(Project project) => project.milestones;

	dynamic? getProjectPhases(Project project) => project.phases;

	String? getProjectCreatedBy(Project project) => project.createdBy;

	DateTime? getProjectCreatedAt(Project project) => project.createdAt;

	DateTime? getProjectUpdatedAt(Project project) => project.updatedAt;

	DateTime? getProjectDeletedAt(Project project) => project.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Project> getByOrgId(
    String orgId,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Project> getByName(
    String name,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectName, name, modelFilter: modelFilter, includes: includes);

	
List<Project> getByDescription(
    String description,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Project> getByProjectType(
    String projectType,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectProjectType, projectType, modelFilter: modelFilter, includes: includes);

	
List<Project> getByPropertyId(
    String propertyId,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Project> getByAddress(
    String address,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectAddress, address, modelFilter: modelFilter, includes: includes);

	
List<Project> getByStatus(
    String status,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Project> getByStartDate(
    DateTime startDate,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<Project> getByEstimatedEndDate(
    DateTime estimatedEndDate,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectEstimatedEndDate, estimatedEndDate, modelFilter: modelFilter, includes: includes);

	
List<Project> getByActualEndDate(
    DateTime actualEndDate,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectActualEndDate, actualEndDate, modelFilter: modelFilter, includes: includes);

	
List<Project> getByBudget(
    double budget,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectBudget, budget, modelFilter: modelFilter, includes: includes);

	
List<Project> getByCurrency(
    String currency,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<Project> getByActualCost(
    double actualCost,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectActualCost, actualCost, modelFilter: modelFilter, includes: includes);

	
List<Project> getByManagerId(
    String managerId,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectManagerId, managerId, modelFilter: modelFilter, includes: includes);

	
List<Project> getByContractorId(
    String contractorId,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectContractorId, contractorId, modelFilter: modelFilter, includes: includes);

	
List<Project> getByMilestones(
    dynamic milestones,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectMilestones, milestones, modelFilter: modelFilter, includes: includes);

	
List<Project> getByPhases(
    dynamic phases,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectPhases, phases, modelFilter: modelFilter, includes: includes);

	
List<Project> getByCreatedBy(
    String createdBy,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Project> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Project> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Project> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}
    ) =>
    getManyIncluding(getProjectDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContractor(
    Project project, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (project.contractorId == null) {
        return null;
    } else {
        final contractor = ContactStore.instance.getById(project.contractorId!, includes: includes);
        project.contractor = contractor;
        // setIncludedReferences(contractor, includes: includes);
        return contractor;
    }
}

	User? getManager(
    Project project, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (project.managerId == null) {
        return null;
    } else {
        final manager = UserStore.instance.getById(project.managerId!, includes: includes);
        project.manager = manager;
        // setIncludedReferences(manager, includes: includes);
        return manager;
    }
}

	Organization? getOrg(
    Project project, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (project.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(project.orgId!, includes: includes);
        project.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    Project project, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (project.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(project.propertyId!, includes: includes);
        project.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  List<Task> getTasks(
    Project project, {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final tasks = TaskStore.instance.getByProjectId(project.$uid!, modelFilter: modelFilter, includes: includes);
    project.tasks = tasks;
    // setIncludedReferencesForList(tasks, includes: includes);
    return tasks;
}

	List<ProjectAlert> getProjectAlerts(
    Project project, {ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}) {
    final projectAlerts = ProjectAlertStore.instance.getByProjectId(project.$uid!, modelFilter: modelFilter, includes: includes);
    project.projectAlerts = projectAlerts;
    // setIncludedReferencesForList(projectAlerts, includes: includes);
    return projectAlerts;
}

	List<ProjectAnalytics> getProjectAnalytics(
    Project project, {ModelFilter<ProjectAnalytics>? modelFilter, List<ProjectAnalyticsInclude>? includes}) {
    final projectAnalytics = ProjectAnalyticsStore.instance.getByProjectId(project.$uid!, modelFilter: modelFilter, includes: includes);
    project.projectAnalytics = projectAnalytics;
    // setIncludedReferencesForList(projectAnalytics, includes: includes);
    return projectAnalytics;
}

	List<ProjectReport> getProjectReports(
    Project project, {ModelFilter<ProjectReport>? modelFilter, List<ProjectReportInclude>? includes}) {
    final projectReports = ProjectReportStore.instance.getByProjectId(project.$uid!, modelFilter: modelFilter, includes: includes);
    project.projectReports = projectReports;
    // setIncludedReferencesForList(projectReports, includes: includes);
    return projectReports;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Project>> getAll$({bool useCache = true, ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ProjectEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Project?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getProjectId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Project>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectName,
        value: name,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByProjectType$(
        String projectType,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectProjectType,
        value: projectType,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByProjectType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByAddress$(
        String address,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectAddress,
        value: address,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByAddress,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByEstimatedEndDate$(
        DateTime estimatedEndDate,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectEstimatedEndDate,
        value: estimatedEndDate,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByEstimatedEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByActualEndDate$(
        DateTime actualEndDate,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectActualEndDate,
        value: actualEndDate,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByActualEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByBudget$(
        double budget,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getProjectBudget,
        value: budget,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByBudget,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByActualCost$(
        double actualCost,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getProjectActualCost,
        value: actualCost,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByActualCost,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByManagerId$(
        String managerId,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectManagerId,
        value: managerId,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByManagerId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByContractorId$(
        String contractorId,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectContractorId,
        value: contractorId,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByContractorId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByMilestones$(
        dynamic milestones,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getProjectMilestones,
        value: milestones,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByMilestones,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByPhases$(
        dynamic phases,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getProjectPhases,
        value: phases,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByPhases,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getProjectCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Project>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Project>? modelFilter,
        List<ProjectInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getProjectDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ProjectEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContractor$(
    Project project, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (project.contractorId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            project.contractorId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contractor) {
            project.contractor = contractor;
        });
    }
}

	Stream<User?> getManager$(
    Project project, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (project.managerId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            project.managerId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((manager) {
            project.manager = manager;
        });
    }
}

	Stream<Organization?> getOrg$(
    Project project, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (project.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            project.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            project.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    Project project, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (project.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            project.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            project.property = property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Task>> getTasks$(
    Project project, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    return TaskStore.instance.getByProjectId$(
        project.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tasks) {
        project.tasks = tasks;
    });

}

	Stream<List<ProjectAlert>> getProjectAlerts$(
    Project project, {bool useCache = true, ModelFilter<ProjectAlert>? modelFilter, List<ProjectAlertInclude>? includes}) {
    return ProjectAlertStore.instance.getByProjectId$(
        project.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((projectAlerts) {
        project.projectAlerts = projectAlerts;
    });

}

	Stream<List<ProjectAnalytics>> getProjectAnalytics$(
    Project project, {bool useCache = true, ModelFilter<ProjectAnalytics>? modelFilter, List<ProjectAnalyticsInclude>? includes}) {
    return ProjectAnalyticsStore.instance.getByProjectId$(
        project.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((projectAnalytics) {
        project.projectAnalytics = projectAnalytics;
    });

}

	Stream<List<ProjectReport>> getProjectReports$(
    Project project, {bool useCache = true, ModelFilter<ProjectReport>? modelFilter, List<ProjectReportInclude>? includes}) {
    return ProjectReportStore.instance.getByProjectId$(
        project.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((projectReports) {
        project.projectReports = projectReports;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Project recursiveUpsert(Project project, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Project'} 
        : const {};
    if (project.contractor != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        project.contractor = ContactStore.instance.recursiveUpsert(project.contractor!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (project.manager != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        project.manager = UserStore.instance.recursiveUpsert(project.manager!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (project.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        project.org = OrganizationStore.instance.recursiveUpsert(project.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (project.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        project.property = PropertyStore.instance.recursiveUpsert(project.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (project.tasks != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        project.tasks = TaskStore.instance.recursiveListUpsert(project.tasks!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (project.projectAlerts != null && (!preventCircularSerialization || !upsertedTypes.contains('ProjectAlert'))) {
        project.projectAlerts = ProjectAlertStore.instance.recursiveListUpsert(project.projectAlerts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (project.projectAnalytics != null && (!preventCircularSerialization || !upsertedTypes.contains('ProjectAnalytics'))) {
        project.projectAnalytics = ProjectAnalyticsStore.instance.recursiveListUpsert(project.projectAnalytics!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (project.projectReports != null && (!preventCircularSerialization || !upsertedTypes.contains('ProjectReport'))) {
        project.projectReports = ProjectReportStore.instance.recursiveListUpsert(project.projectReports!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(project);
}

  List<Project> recursiveListUpsert(List<Project> projects, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedProjects = <Project>[];
    for (var project in projects) {
        updatedProjects.add(recursiveUpsert(project, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedProjects;
}

//   @override
//   Project upsert(Project item) {
//     return recursiveUpsert(item);
//   }

}


class ProjectInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ProjectInclude.contractor({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (project) => ProjectStore.instance
            .getContractor$(project, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (project) => ProjectStore.instance
            .getContractor(project, modelFilter: modelFilter, includes: includes);
      }
}

	ProjectInclude.manager({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (project) => ProjectStore.instance
            .getManager$(project, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (project) => ProjectStore.instance
            .getManager(project, modelFilter: modelFilter, includes: includes);
      }
}

	ProjectInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (project) => ProjectStore.instance
            .getOrg$(project, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (project) => ProjectStore.instance
            .getOrg(project, modelFilter: modelFilter, includes: includes);
      }
}

	ProjectInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (project) => ProjectStore.instance
            .getProperty$(project, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (project) => ProjectStore.instance
            .getProperty(project, modelFilter: modelFilter, includes: includes);
      }
}

	ProjectInclude.tasks({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (project) => ProjectStore.instance
            .getTasks$(project, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (project) => ProjectStore.instance
            .getTasks(project, modelFilter: modelFilter, includes: includes);
      }
}

	ProjectInclude.projectAlerts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ProjectAlert>? modelFilter,
    List<ProjectAlertInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (project) => ProjectStore.instance
            .getProjectAlerts$(project, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (project) => ProjectStore.instance
            .getProjectAlerts(project, modelFilter: modelFilter, includes: includes);
      }
}

	ProjectInclude.projectAnalytics({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ProjectAnalytics>? modelFilter,
    List<ProjectAnalyticsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (project) => ProjectStore.instance
            .getProjectAnalytics$(project, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (project) => ProjectStore.instance
            .getProjectAnalytics(project, modelFilter: modelFilter, includes: includes);
      }
}

	ProjectInclude.projectReports({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ProjectReport>? modelFilter,
    List<ProjectReportInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (project) => ProjectStore.instance
            .getProjectReports$(project, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (project) => ProjectStore.instance
            .getProjectReports(project, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ProjectEndpoints implements Endpoint {

    getAll('/project', HttpMethod.post, List<Project>),
	getById('/project/byId/:id', HttpMethod.post, Project),
	getManyByOrgId('/project/byOrgId/:orgId', HttpMethod.post, List<Project>),
	getManyByName('/project/byName/:name', HttpMethod.post, List<Project>),
	getManyByDescription('/project/byDescription/:description', HttpMethod.post, List<Project>),
	getManyByProjectType('/project/byProjectType/:projectType', HttpMethod.post, List<Project>),
	getManyByPropertyId('/project/byPropertyId/:propertyId', HttpMethod.post, List<Project>),
	getManyByAddress('/project/byAddress/:address', HttpMethod.post, List<Project>),
	getManyByStatus('/project/byStatus/:status', HttpMethod.post, List<Project>),
	getManyByStartDate('/project/byStartDate/:startDate', HttpMethod.post, List<Project>),
	getManyByEstimatedEndDate('/project/byEstimatedEndDate/:estimatedEndDate', HttpMethod.post, List<Project>),
	getManyByActualEndDate('/project/byActualEndDate/:actualEndDate', HttpMethod.post, List<Project>),
	getManyByBudget('/project/byBudget/:budget', HttpMethod.post, List<Project>),
	getManyByCurrency('/project/byCurrency/:currency', HttpMethod.post, List<Project>),
	getManyByActualCost('/project/byActualCost/:actualCost', HttpMethod.post, List<Project>),
	getManyByManagerId('/project/byManagerId/:managerId', HttpMethod.post, List<Project>),
	getManyByContractorId('/project/byContractorId/:contractorId', HttpMethod.post, List<Project>),
	getManyByMilestones('/project/byMilestones/:milestones', HttpMethod.post, List<Project>),
	getManyByPhases('/project/byPhases/:phases', HttpMethod.post, List<Project>),
	getManyByCreatedBy('/project/byCreatedBy/:createdBy', HttpMethod.post, List<Project>),
	getManyByCreatedAt('/project/byCreatedAt/:createdAt', HttpMethod.post, List<Project>),
	getManyByUpdatedAt('/project/byUpdatedAt/:updatedAt', HttpMethod.post, List<Project>),
	getManyByDeletedAt('/project/byDeletedAt/:deletedAt', HttpMethod.post, List<Project>);

    const ProjectEndpoints(this.path, this.method, this.responseType);

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
