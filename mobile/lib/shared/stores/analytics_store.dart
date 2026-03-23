
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AnalyticsStore extends ModelStreamStore<String, Analytics> {

  static AnalyticsStore? _instance;

  static AnalyticsStore get instance {
    _instance ??= AnalyticsStore();
    return _instance!;
  }

  AnalyticsStore() : super(Analytics.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AnalyticsStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AnalyticsStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AnalyticsStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAnalyticsId(Analytics analytics) => analytics.id;

	String? getAnalyticsEntityId(Analytics analytics) => analytics.entityId;

	String? getAnalyticsEntityType(Analytics analytics) => analytics.entityType;

	AnalyticsType? getAnalyticsType(Analytics analytics) => analytics.type;

	dynamic? getAnalyticsData(Analytics analytics) => analytics.data;

	DateTime? getAnalyticsTimestamp(Analytics analytics) => analytics.timestamp;

	DateTime? getAnalyticsDeletedAt(Analytics analytics) => analytics.deletedAt;

	String? getAnalyticsPropertyId(Analytics analytics) => analytics.propertyId;

	String? getAnalyticsUserId(Analytics analytics) => analytics.userId;

	String? getAnalyticsAgentId(Analytics analytics) => analytics.agentId;

	String? getAnalyticsAgencyId(Analytics analytics) => analytics.agencyId;

	String? getAnalyticsReservationId(Analytics analytics) => analytics.reservationId;

	String? getAnalyticsTaskId(Analytics analytics) => analytics.taskId;

	String? getAnalyticsTaxRecordId(Analytics analytics) => analytics.taxRecordId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Analytics> getByEntityId(
    String entityId,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsEntityId, entityId, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByEntityType(
    String entityType,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsEntityType, entityType, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByType(
    AnalyticsType type,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsType, type, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByData(
    dynamic data,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsData, data, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByTimestamp(
    DateTime timestamp,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsTimestamp, timestamp, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByPropertyId(
    String propertyId,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByUserId(
    String userId,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByAgentId(
    String agentId,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsAgentId, agentId, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByAgencyId(
    String agencyId,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByReservationId(
    String reservationId,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsReservationId, reservationId, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByTaskId(
    String taskId,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsTaskId, taskId, modelFilter: modelFilter, includes: includes);

	
List<Analytics> getByTaxRecordId(
    String taxRecordId,
    {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}
    ) =>
    getManyIncluding(getAnalyticsTaxRecordId, taxRecordId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Agency? getAgency(
    Analytics analytics, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (analytics.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(analytics.agencyId!, includes: includes);
        analytics.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

	Agent? getAgent(
    Analytics analytics, {ModelFilter? modelFilter, List<AgentInclude>? includes}) {
    if (analytics.agentId == null) {
        return null;
    } else {
        final Agent = AgentStore.instance.getById(analytics.agentId!, includes: includes);
        analytics.Agent = Agent;
        // setIncludedReferences(Agent, includes: includes);
        return Agent;
    }
}

	Property? getProperty(
    Analytics analytics, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (analytics.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(analytics.propertyId!, includes: includes);
        analytics.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

	Reservation? getReservation(
    Analytics analytics, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (analytics.reservationId == null) {
        return null;
    } else {
        final Reservation = ReservationStore.instance.getById(analytics.reservationId!, includes: includes);
        analytics.Reservation = Reservation;
        // setIncludedReferences(Reservation, includes: includes);
        return Reservation;
    }
}

	Task? getTask(
    Analytics analytics, {ModelFilter? modelFilter, List<TaskInclude>? includes}) {
    if (analytics.taskId == null) {
        return null;
    } else {
        final Task = TaskStore.instance.getById(analytics.taskId!, includes: includes);
        analytics.Task = Task;
        // setIncludedReferences(Task, includes: includes);
        return Task;
    }
}

	TaxRecord? getTaxRecord(
    Analytics analytics, {ModelFilter? modelFilter, List<TaxRecordInclude>? includes}) {
    if (analytics.taxRecordId == null) {
        return null;
    } else {
        final TaxRecord = TaxRecordStore.instance.getById(analytics.taxRecordId!, includes: includes);
        analytics.TaxRecord = TaxRecord;
        // setIncludedReferences(TaxRecord, includes: includes);
        return TaxRecord;
    }
}

	User? getUser(
    Analytics analytics, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (analytics.userId == null) {
        return null;
    } else {
        final User = UserStore.instance.getById(analytics.userId!, includes: includes);
        analytics.User = User;
        // setIncludedReferences(User, includes: includes);
        return User;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Analytics>> getAll$({bool useCache = true, ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AnalyticsEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Analytics?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAnalyticsId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Analytics>> getByEntityId$(
        String entityId,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalyticsEntityId,
        value: entityId,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByEntityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByEntityType$(
        String entityType,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalyticsEntityType,
        value: entityType,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByEntityType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByType$(
        AnalyticsType type,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<AnalyticsType>(
        getPropVal: getAnalyticsType,
        value: type,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByData$(
        dynamic data,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAnalyticsData,
        value: data,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByTimestamp$(
        DateTime timestamp,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAnalyticsTimestamp,
        value: timestamp,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByTimestamp,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAnalyticsDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalyticsPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalyticsUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByAgentId$(
        String agentId,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalyticsAgentId,
        value: agentId,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByAgentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalyticsAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalyticsReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByTaskId$(
        String taskId,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalyticsTaskId,
        value: taskId,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByTaskId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Analytics>> getByTaxRecordId$(
        String taxRecordId,
        {bool useCache = true,
        ModelFilter<Analytics>? modelFilter,
        List<AnalyticsInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAnalyticsTaxRecordId,
        value: taxRecordId,
        modelFilter: modelFilter,
        endpoint: AnalyticsEndpoints.getManyByTaxRecordId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Agency?> getAgency$(
    Analytics analytics, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (analytics.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            analytics.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            analytics.Agency = Agency;
        });
    }
}

	Stream<Agent?> getAgent$(
    Analytics analytics, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    if (analytics.agentId == null) {
        return Stream.value(null);
    } else {
        return AgentStore.instance.getById$(
            analytics.agentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agent) {
            analytics.Agent = Agent;
        });
    }
}

	Stream<Property?> getProperty$(
    Analytics analytics, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (analytics.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            analytics.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            analytics.Property = Property;
        });
    }
}

	Stream<Reservation?> getReservation$(
    Analytics analytics, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (analytics.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            analytics.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Reservation) {
            analytics.Reservation = Reservation;
        });
    }
}

	Stream<Task?> getTask$(
    Analytics analytics, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    if (analytics.taskId == null) {
        return Stream.value(null);
    } else {
        return TaskStore.instance.getById$(
            analytics.taskId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Task) {
            analytics.Task = Task;
        });
    }
}

	Stream<TaxRecord?> getTaxRecord$(
    Analytics analytics, {bool useCache = true, ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}) {
    if (analytics.taxRecordId == null) {
        return Stream.value(null);
    } else {
        return TaxRecordStore.instance.getById$(
            analytics.taxRecordId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((TaxRecord) {
            analytics.TaxRecord = TaxRecord;
        });
    }
}

	Stream<User?> getUser$(
    Analytics analytics, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (analytics.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            analytics.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((User) {
            analytics.User = User;
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
Analytics recursiveUpsert(Analytics analytics, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Analytics'} 
        : const {};
    if (analytics.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        analytics.Agency = AgencyStore.instance.recursiveUpsert(analytics.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (analytics.Agent != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        analytics.Agent = AgentStore.instance.recursiveUpsert(analytics.Agent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (analytics.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        analytics.Property = PropertyStore.instance.recursiveUpsert(analytics.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (analytics.Reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        analytics.Reservation = ReservationStore.instance.recursiveUpsert(analytics.Reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (analytics.Task != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        analytics.Task = TaskStore.instance.recursiveUpsert(analytics.Task!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (analytics.TaxRecord != null && (!preventCircularSerialization || !upsertedTypes.contains('TaxRecord'))) {
        analytics.TaxRecord = TaxRecordStore.instance.recursiveUpsert(analytics.TaxRecord!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (analytics.User != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        analytics.User = UserStore.instance.recursiveUpsert(analytics.User!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(analytics);
}

  List<Analytics> recursiveListUpsert(List<Analytics> analyticss, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAnalyticss = <Analytics>[];
    for (var analytics in analyticss) {
        updatedAnalyticss.add(recursiveUpsert(analytics, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAnalyticss;
}

//   @override
//   Analytics upsert(Analytics item) {
//     return recursiveUpsert(item);
//   }

}


class AnalyticsInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AnalyticsInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (analytics) => AnalyticsStore.instance
            .getAgency$(analytics, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (analytics) => AnalyticsStore.instance
            .getAgency(analytics, modelFilter: modelFilter, includes: includes);
      }
}

	AnalyticsInclude.Agent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (analytics) => AnalyticsStore.instance
            .getAgent$(analytics, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (analytics) => AnalyticsStore.instance
            .getAgent(analytics, modelFilter: modelFilter, includes: includes);
      }
}

	AnalyticsInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (analytics) => AnalyticsStore.instance
            .getProperty$(analytics, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (analytics) => AnalyticsStore.instance
            .getProperty(analytics, modelFilter: modelFilter, includes: includes);
      }
}

	AnalyticsInclude.Reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (analytics) => AnalyticsStore.instance
            .getReservation$(analytics, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (analytics) => AnalyticsStore.instance
            .getReservation(analytics, modelFilter: modelFilter, includes: includes);
      }
}

	AnalyticsInclude.Task({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (analytics) => AnalyticsStore.instance
            .getTask$(analytics, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (analytics) => AnalyticsStore.instance
            .getTask(analytics, modelFilter: modelFilter, includes: includes);
      }
}

	AnalyticsInclude.TaxRecord({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<TaxRecord>? modelFilter,
    List<TaxRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (analytics) => AnalyticsStore.instance
            .getTaxRecord$(analytics, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (analytics) => AnalyticsStore.instance
            .getTaxRecord(analytics, modelFilter: modelFilter, includes: includes);
      }
}

	AnalyticsInclude.User({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (analytics) => AnalyticsStore.instance
            .getUser$(analytics, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (analytics) => AnalyticsStore.instance
            .getUser(analytics, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AnalyticsEndpoints implements Endpoint {

    getAll('/analytics', HttpMethod.post, List<Analytics>),
	getById('/analytics/byId/:id', HttpMethod.post, Analytics),
	getManyByEntityId('/analytics/byEntityId/:entityId', HttpMethod.post, List<Analytics>),
	getManyByEntityType('/analytics/byEntityType/:entityType', HttpMethod.post, List<Analytics>),
	getManyByType('/analytics/byType/:type', HttpMethod.post, List<Analytics>),
	getManyByData('/analytics/byData/:data', HttpMethod.post, List<Analytics>),
	getManyByTimestamp('/analytics/byTimestamp/:timestamp', HttpMethod.post, List<Analytics>),
	getManyByDeletedAt('/analytics/byDeletedAt/:deletedAt', HttpMethod.post, List<Analytics>),
	getManyByPropertyId('/analytics/byPropertyId/:propertyId', HttpMethod.post, List<Analytics>),
	getManyByUserId('/analytics/byUserId/:userId', HttpMethod.post, List<Analytics>),
	getManyByAgentId('/analytics/byAgentId/:agentId', HttpMethod.post, List<Analytics>),
	getManyByAgencyId('/analytics/byAgencyId/:agencyId', HttpMethod.post, List<Analytics>),
	getManyByReservationId('/analytics/byReservationId/:reservationId', HttpMethod.post, List<Analytics>),
	getManyByTaskId('/analytics/byTaskId/:taskId', HttpMethod.post, List<Analytics>),
	getManyByTaxRecordId('/analytics/byTaxRecordId/:taxRecordId', HttpMethod.post, List<Analytics>);

    const AnalyticsEndpoints(this.path, this.method, this.responseType);

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
