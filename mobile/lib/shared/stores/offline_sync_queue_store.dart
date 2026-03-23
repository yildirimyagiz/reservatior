
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class OfflineSyncQueueStore extends ModelStreamStore<String, OfflineSyncQueue> {

  static OfflineSyncQueueStore? _instance;

  static OfflineSyncQueueStore get instance {
    _instance ??= OfflineSyncQueueStore();
    return _instance!;
  }

  OfflineSyncQueueStore() : super(OfflineSyncQueue.fromJson) {
    if (_instance != null) {
        throw Exception(
            'OfflineSyncQueueStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending OfflineSyncQueueStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use OfflineSyncQueueStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getOfflineSyncQueueId(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.id;

	String? getOfflineSyncQueueOrgId(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.orgId;

	String? getOfflineSyncQueueUserId(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.userId;

	String? getOfflineSyncQueueDeviceId(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.deviceId;

	String? getOfflineSyncQueueEntityType(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.entityType;

	String? getOfflineSyncQueueEntityId(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.entityId;

	String? getOfflineSyncQueueOperation(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.operation;

	dynamic? getOfflineSyncQueueData(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.data;

	int? getOfflineSyncQueueVersion(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.version;

	String? getOfflineSyncQueueSyncStatus(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.syncStatus;

	DateTime? getOfflineSyncQueueCreatedAt(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.createdAt;

	DateTime? getOfflineSyncQueueSyncedAt(OfflineSyncQueue offlineSyncQueue) => offlineSyncQueue.syncedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<OfflineSyncQueue> getByOrgId(
    String orgId,
    {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}
    ) =>
    getManyIncluding(getOfflineSyncQueueOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<OfflineSyncQueue> getByUserId(
    String userId,
    {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}
    ) =>
    getManyIncluding(getOfflineSyncQueueUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<OfflineSyncQueue> getByDeviceId(
    String deviceId,
    {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}
    ) =>
    getManyIncluding(getOfflineSyncQueueDeviceId, deviceId, modelFilter: modelFilter, includes: includes);

	
List<OfflineSyncQueue> getByEntityType(
    String entityType,
    {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}
    ) =>
    getManyIncluding(getOfflineSyncQueueEntityType, entityType, modelFilter: modelFilter, includes: includes);

	
List<OfflineSyncQueue> getByEntityId(
    String entityId,
    {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}
    ) =>
    getManyIncluding(getOfflineSyncQueueEntityId, entityId, modelFilter: modelFilter, includes: includes);

	
List<OfflineSyncQueue> getByOperation(
    String operation,
    {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}
    ) =>
    getManyIncluding(getOfflineSyncQueueOperation, operation, modelFilter: modelFilter, includes: includes);

	
List<OfflineSyncQueue> getByData(
    dynamic data,
    {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}
    ) =>
    getManyIncluding(getOfflineSyncQueueData, data, modelFilter: modelFilter, includes: includes);

	
List<OfflineSyncQueue> getByVersion(
    int version,
    {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}
    ) =>
    getManyIncluding(getOfflineSyncQueueVersion, version, modelFilter: modelFilter, includes: includes);

	
List<OfflineSyncQueue> getBySyncStatus(
    String syncStatus,
    {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}
    ) =>
    getManyIncluding(getOfflineSyncQueueSyncStatus, syncStatus, modelFilter: modelFilter, includes: includes);

	
List<OfflineSyncQueue> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}
    ) =>
    getManyIncluding(getOfflineSyncQueueCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<OfflineSyncQueue> getBySyncedAt(
    DateTime syncedAt,
    {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}
    ) =>
    getManyIncluding(getOfflineSyncQueueSyncedAt, syncedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  MobileDevice? getDevice(
    OfflineSyncQueue offlineSyncQueue, {ModelFilter? modelFilter, List<MobileDeviceInclude>? includes}) {
    if (offlineSyncQueue.deviceId == null) {
        return null;
    } else {
        final device = MobileDeviceStore.instance.getById(offlineSyncQueue.deviceId!, includes: includes);
        offlineSyncQueue.device = device;
        // setIncludedReferences(device, includes: includes);
        return device;
    }
}

	Organization? getOrg(
    OfflineSyncQueue offlineSyncQueue, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (offlineSyncQueue.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(offlineSyncQueue.orgId!, includes: includes);
        offlineSyncQueue.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    OfflineSyncQueue offlineSyncQueue, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (offlineSyncQueue.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(offlineSyncQueue.userId!, includes: includes);
        offlineSyncQueue.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<OfflineSyncQueue>> getAll$({bool useCache = true, ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: OfflineSyncQueueEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<OfflineSyncQueue?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getOfflineSyncQueueId,
        value: id,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<OfflineSyncQueue>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOfflineSyncQueueOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OfflineSyncQueue>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOfflineSyncQueueUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OfflineSyncQueue>> getByDeviceId$(
        String deviceId,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOfflineSyncQueueDeviceId,
        value: deviceId,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getManyByDeviceId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OfflineSyncQueue>> getByEntityType$(
        String entityType,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOfflineSyncQueueEntityType,
        value: entityType,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getManyByEntityType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OfflineSyncQueue>> getByEntityId$(
        String entityId,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOfflineSyncQueueEntityId,
        value: entityId,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getManyByEntityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OfflineSyncQueue>> getByOperation$(
        String operation,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOfflineSyncQueueOperation,
        value: operation,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getManyByOperation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OfflineSyncQueue>> getByData$(
        dynamic data,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getOfflineSyncQueueData,
        value: data,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getManyByData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OfflineSyncQueue>> getByVersion$(
        int version,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getOfflineSyncQueueVersion,
        value: version,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getManyByVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OfflineSyncQueue>> getBySyncStatus$(
        String syncStatus,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getOfflineSyncQueueSyncStatus,
        value: syncStatus,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getManyBySyncStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OfflineSyncQueue>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOfflineSyncQueueCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<OfflineSyncQueue>> getBySyncedAt$(
        DateTime syncedAt,
        {bool useCache = true,
        ModelFilter<OfflineSyncQueue>? modelFilter,
        List<OfflineSyncQueueInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getOfflineSyncQueueSyncedAt,
        value: syncedAt,
        modelFilter: modelFilter,
        endpoint: OfflineSyncQueueEndpoints.getManyBySyncedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<MobileDevice?> getDevice$(
    OfflineSyncQueue offlineSyncQueue, {bool useCache = true, ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}) {
    if (offlineSyncQueue.deviceId == null) {
        return Stream.value(null);
    } else {
        return MobileDeviceStore.instance.getById$(
            offlineSyncQueue.deviceId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((device) {
            offlineSyncQueue.device = device;
        });
    }
}

	Stream<Organization?> getOrg$(
    OfflineSyncQueue offlineSyncQueue, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (offlineSyncQueue.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            offlineSyncQueue.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            offlineSyncQueue.org = org;
        });
    }
}

	Stream<User?> getUser$(
    OfflineSyncQueue offlineSyncQueue, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (offlineSyncQueue.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            offlineSyncQueue.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            offlineSyncQueue.user = user;
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
OfflineSyncQueue recursiveUpsert(OfflineSyncQueue offlineSyncQueue, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'OfflineSyncQueue'} 
        : const {};
    if (offlineSyncQueue.device != null && (!preventCircularSerialization || !upsertedTypes.contains('MobileDevice'))) {
        offlineSyncQueue.device = MobileDeviceStore.instance.recursiveUpsert(offlineSyncQueue.device!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (offlineSyncQueue.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        offlineSyncQueue.org = OrganizationStore.instance.recursiveUpsert(offlineSyncQueue.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (offlineSyncQueue.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        offlineSyncQueue.user = UserStore.instance.recursiveUpsert(offlineSyncQueue.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(offlineSyncQueue);
}

  List<OfflineSyncQueue> recursiveListUpsert(List<OfflineSyncQueue> offlineSyncQueues, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedOfflineSyncQueues = <OfflineSyncQueue>[];
    for (var offlineSyncQueue in offlineSyncQueues) {
        updatedOfflineSyncQueues.add(recursiveUpsert(offlineSyncQueue, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedOfflineSyncQueues;
}

//   @override
//   OfflineSyncQueue upsert(OfflineSyncQueue item) {
//     return recursiveUpsert(item);
//   }

}


class OfflineSyncQueueInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      OfflineSyncQueueInclude.device({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<MobileDevice>? modelFilter,
    List<MobileDeviceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (offlineSyncQueue) => OfflineSyncQueueStore.instance
            .getDevice$(offlineSyncQueue, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (offlineSyncQueue) => OfflineSyncQueueStore.instance
            .getDevice(offlineSyncQueue, modelFilter: modelFilter, includes: includes);
      }
}

	OfflineSyncQueueInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (offlineSyncQueue) => OfflineSyncQueueStore.instance
            .getOrg$(offlineSyncQueue, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (offlineSyncQueue) => OfflineSyncQueueStore.instance
            .getOrg(offlineSyncQueue, modelFilter: modelFilter, includes: includes);
      }
}

	OfflineSyncQueueInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (offlineSyncQueue) => OfflineSyncQueueStore.instance
            .getUser$(offlineSyncQueue, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (offlineSyncQueue) => OfflineSyncQueueStore.instance
            .getUser(offlineSyncQueue, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum OfflineSyncQueueEndpoints implements Endpoint {

    getAll('/offlineSyncQueue', HttpMethod.post, List<OfflineSyncQueue>),
	getById('/offlineSyncQueue/byId/:id', HttpMethod.post, OfflineSyncQueue),
	getManyByOrgId('/offlineSyncQueue/byOrgId/:orgId', HttpMethod.post, List<OfflineSyncQueue>),
	getManyByUserId('/offlineSyncQueue/byUserId/:userId', HttpMethod.post, List<OfflineSyncQueue>),
	getManyByDeviceId('/offlineSyncQueue/byDeviceId/:deviceId', HttpMethod.post, List<OfflineSyncQueue>),
	getManyByEntityType('/offlineSyncQueue/byEntityType/:entityType', HttpMethod.post, List<OfflineSyncQueue>),
	getManyByEntityId('/offlineSyncQueue/byEntityId/:entityId', HttpMethod.post, List<OfflineSyncQueue>),
	getManyByOperation('/offlineSyncQueue/byOperation/:operation', HttpMethod.post, List<OfflineSyncQueue>),
	getManyByData('/offlineSyncQueue/byData/:data', HttpMethod.post, List<OfflineSyncQueue>),
	getManyByVersion('/offlineSyncQueue/byVersion/:version', HttpMethod.post, List<OfflineSyncQueue>),
	getManyBySyncStatus('/offlineSyncQueue/bySyncStatus/:syncStatus', HttpMethod.post, List<OfflineSyncQueue>),
	getManyByCreatedAt('/offlineSyncQueue/byCreatedAt/:createdAt', HttpMethod.post, List<OfflineSyncQueue>),
	getManyBySyncedAt('/offlineSyncQueue/bySyncedAt/:syncedAt', HttpMethod.post, List<OfflineSyncQueue>);

    const OfflineSyncQueueEndpoints(this.path, this.method, this.responseType);

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
