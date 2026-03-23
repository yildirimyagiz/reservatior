
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PerformanceAlertStore extends ModelStreamStore<String, PerformanceAlert> {

  static PerformanceAlertStore? _instance;

  static PerformanceAlertStore get instance {
    _instance ??= PerformanceAlertStore();
    return _instance!;
  }

  PerformanceAlertStore() : super(PerformanceAlert.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PerformanceAlertStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PerformanceAlertStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PerformanceAlertStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPerformanceAlertId(PerformanceAlert performanceAlert) => performanceAlert.id;

	String? getPerformanceAlertOrgId(PerformanceAlert performanceAlert) => performanceAlert.orgId;

	String? getPerformanceAlertAlertType(PerformanceAlert performanceAlert) => performanceAlert.alertType;

	String? getPerformanceAlertSeverity(PerformanceAlert performanceAlert) => performanceAlert.severity;

	String? getPerformanceAlertMetricName(PerformanceAlert performanceAlert) => performanceAlert.metricName;

	double? getPerformanceAlertThreshold(PerformanceAlert performanceAlert) => performanceAlert.threshold;

	double? getPerformanceAlertActualValue(PerformanceAlert performanceAlert) => performanceAlert.actualValue;

	String? getPerformanceAlertDescription(PerformanceAlert performanceAlert) => performanceAlert.description;

	dynamic? getPerformanceAlertAffectedServices(PerformanceAlert performanceAlert) => performanceAlert.affectedServices;

	String? getPerformanceAlertStatus(PerformanceAlert performanceAlert) => performanceAlert.status;

	DateTime? getPerformanceAlertAcknowledgedAt(PerformanceAlert performanceAlert) => performanceAlert.acknowledgedAt;

	String? getPerformanceAlertAcknowledgedBy(PerformanceAlert performanceAlert) => performanceAlert.acknowledgedBy;

	DateTime? getPerformanceAlertResolvedAt(PerformanceAlert performanceAlert) => performanceAlert.resolvedAt;

	DateTime? getPerformanceAlertCreatedAt(PerformanceAlert performanceAlert) => performanceAlert.createdAt;

	DateTime? getPerformanceAlertUpdatedAt(PerformanceAlert performanceAlert) => performanceAlert.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PerformanceAlert> getByOrgId(
    String orgId,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByAlertType(
    String alertType,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertAlertType, alertType, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getBySeverity(
    String severity,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertSeverity, severity, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByMetricName(
    String metricName,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertMetricName, metricName, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByThreshold(
    double threshold,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertThreshold, threshold, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByActualValue(
    double actualValue,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertActualValue, actualValue, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByDescription(
    String description,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertDescription, description, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByAffectedServices(
    dynamic affectedServices,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertAffectedServices, affectedServices, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByStatus(
    String status,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertStatus, status, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByAcknowledgedAt(
    DateTime acknowledgedAt,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertAcknowledgedAt, acknowledgedAt, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByAcknowledgedBy(
    String acknowledgedBy,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertAcknowledgedBy, acknowledgedBy, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByResolvedAt(
    DateTime resolvedAt,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertResolvedAt, resolvedAt, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PerformanceAlert> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}
    ) =>
    getManyIncluding(getPerformanceAlertUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    PerformanceAlert performanceAlert, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (performanceAlert.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(performanceAlert.orgId!, includes: includes);
        performanceAlert.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PerformanceAlert>> getAll$({bool useCache = true, ModelFilter<PerformanceAlert>? modelFilter, List<PerformanceAlertInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PerformanceAlertEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PerformanceAlert?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPerformanceAlertId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PerformanceAlert>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPerformanceAlertOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByAlertType$(
        String alertType,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPerformanceAlertAlertType,
        value: alertType,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByAlertType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getBySeverity$(
        String severity,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPerformanceAlertSeverity,
        value: severity,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyBySeverity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByMetricName$(
        String metricName,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPerformanceAlertMetricName,
        value: metricName,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByMetricName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByThreshold$(
        double threshold,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPerformanceAlertThreshold,
        value: threshold,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByThreshold,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByActualValue$(
        double actualValue,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPerformanceAlertActualValue,
        value: actualValue,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByActualValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPerformanceAlertDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByAffectedServices$(
        dynamic affectedServices,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPerformanceAlertAffectedServices,
        value: affectedServices,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByAffectedServices,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPerformanceAlertStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByAcknowledgedAt$(
        DateTime acknowledgedAt,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPerformanceAlertAcknowledgedAt,
        value: acknowledgedAt,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByAcknowledgedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByAcknowledgedBy$(
        String acknowledgedBy,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPerformanceAlertAcknowledgedBy,
        value: acknowledgedBy,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByAcknowledgedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByResolvedAt$(
        DateTime resolvedAt,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPerformanceAlertResolvedAt,
        value: resolvedAt,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByResolvedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPerformanceAlertCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PerformanceAlert>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PerformanceAlert>? modelFilter,
        List<PerformanceAlertInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPerformanceAlertUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PerformanceAlertEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    PerformanceAlert performanceAlert, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (performanceAlert.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            performanceAlert.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            performanceAlert.org = org;
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
PerformanceAlert recursiveUpsert(PerformanceAlert performanceAlert, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PerformanceAlert'} 
        : const {};
    if (performanceAlert.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        performanceAlert.org = OrganizationStore.instance.recursiveUpsert(performanceAlert.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(performanceAlert);
}

  List<PerformanceAlert> recursiveListUpsert(List<PerformanceAlert> performanceAlerts, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPerformanceAlerts = <PerformanceAlert>[];
    for (var performanceAlert in performanceAlerts) {
        updatedPerformanceAlerts.add(recursiveUpsert(performanceAlert, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPerformanceAlerts;
}

//   @override
//   PerformanceAlert upsert(PerformanceAlert item) {
//     return recursiveUpsert(item);
//   }

}


class PerformanceAlertInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PerformanceAlertInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (performanceAlert) => PerformanceAlertStore.instance
            .getOrg$(performanceAlert, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (performanceAlert) => PerformanceAlertStore.instance
            .getOrg(performanceAlert, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PerformanceAlertEndpoints implements Endpoint {

    getAll('/performanceAlert', HttpMethod.post, List<PerformanceAlert>),
	getById('/performanceAlert/byId/:id', HttpMethod.post, PerformanceAlert),
	getManyByOrgId('/performanceAlert/byOrgId/:orgId', HttpMethod.post, List<PerformanceAlert>),
	getManyByAlertType('/performanceAlert/byAlertType/:alertType', HttpMethod.post, List<PerformanceAlert>),
	getManyBySeverity('/performanceAlert/bySeverity/:severity', HttpMethod.post, List<PerformanceAlert>),
	getManyByMetricName('/performanceAlert/byMetricName/:metricName', HttpMethod.post, List<PerformanceAlert>),
	getManyByThreshold('/performanceAlert/byThreshold/:threshold', HttpMethod.post, List<PerformanceAlert>),
	getManyByActualValue('/performanceAlert/byActualValue/:actualValue', HttpMethod.post, List<PerformanceAlert>),
	getManyByDescription('/performanceAlert/byDescription/:description', HttpMethod.post, List<PerformanceAlert>),
	getManyByAffectedServices('/performanceAlert/byAffectedServices/:affectedServices', HttpMethod.post, List<PerformanceAlert>),
	getManyByStatus('/performanceAlert/byStatus/:status', HttpMethod.post, List<PerformanceAlert>),
	getManyByAcknowledgedAt('/performanceAlert/byAcknowledgedAt/:acknowledgedAt', HttpMethod.post, List<PerformanceAlert>),
	getManyByAcknowledgedBy('/performanceAlert/byAcknowledgedBy/:acknowledgedBy', HttpMethod.post, List<PerformanceAlert>),
	getManyByResolvedAt('/performanceAlert/byResolvedAt/:resolvedAt', HttpMethod.post, List<PerformanceAlert>),
	getManyByCreatedAt('/performanceAlert/byCreatedAt/:createdAt', HttpMethod.post, List<PerformanceAlert>),
	getManyByUpdatedAt('/performanceAlert/byUpdatedAt/:updatedAt', HttpMethod.post, List<PerformanceAlert>);

    const PerformanceAlertEndpoints(this.path, this.method, this.responseType);

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
