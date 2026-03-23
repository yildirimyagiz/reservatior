
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MobileDeviceStore extends ModelStreamStore<String, MobileDevice> {

  static MobileDeviceStore? _instance;

  static MobileDeviceStore get instance {
    _instance ??= MobileDeviceStore();
    return _instance!;
  }

  MobileDeviceStore() : super(MobileDevice.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MobileDeviceStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MobileDeviceStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MobileDeviceStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMobileDeviceId(MobileDevice mobileDevice) => mobileDevice.id;

	String? getMobileDeviceOrgId(MobileDevice mobileDevice) => mobileDevice.orgId;

	String? getMobileDeviceUserId(MobileDevice mobileDevice) => mobileDevice.userId;

	String? getMobileDeviceDeviceId(MobileDevice mobileDevice) => mobileDevice.deviceId;

	String? getMobileDeviceDeviceType(MobileDevice mobileDevice) => mobileDevice.deviceType;

	String? getMobileDeviceDeviceToken(MobileDevice mobileDevice) => mobileDevice.deviceToken;

	String? getMobileDeviceAppVersion(MobileDevice mobileDevice) => mobileDevice.appVersion;

	String? getMobileDeviceOsVersion(MobileDevice mobileDevice) => mobileDevice.osVersion;

	bool? getMobileDeviceIsActive(MobileDevice mobileDevice) => mobileDevice.isActive;

	DateTime? getMobileDeviceLastLoginAt(MobileDevice mobileDevice) => mobileDevice.lastLoginAt;

	dynamic? getMobileDeviceNotificationPreferences(MobileDevice mobileDevice) => mobileDevice.notificationPreferences;

	DateTime? getMobileDeviceCreatedAt(MobileDevice mobileDevice) => mobileDevice.createdAt;

	DateTime? getMobileDeviceUpdatedAt(MobileDevice mobileDevice) => mobileDevice.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
MobileDevice? getByDeviceId(
    String deviceId,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getIncluding(getMobileDeviceDeviceId, deviceId, modelFilter: modelFilter, includes: includes);

  
List<MobileDevice> getByOrgId(
    String orgId,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getManyIncluding(getMobileDeviceOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<MobileDevice> getByUserId(
    String userId,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getManyIncluding(getMobileDeviceUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<MobileDevice> getByDeviceType(
    String deviceType,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getManyIncluding(getMobileDeviceDeviceType, deviceType, modelFilter: modelFilter, includes: includes);

	
List<MobileDevice> getByDeviceToken(
    String deviceToken,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getManyIncluding(getMobileDeviceDeviceToken, deviceToken, modelFilter: modelFilter, includes: includes);

	
List<MobileDevice> getByAppVersion(
    String appVersion,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getManyIncluding(getMobileDeviceAppVersion, appVersion, modelFilter: modelFilter, includes: includes);

	
List<MobileDevice> getByOsVersion(
    String osVersion,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getManyIncluding(getMobileDeviceOsVersion, osVersion, modelFilter: modelFilter, includes: includes);

	
List<MobileDevice> getByIsActive(
    bool isActive,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getManyIncluding(getMobileDeviceIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<MobileDevice> getByLastLoginAt(
    DateTime lastLoginAt,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getManyIncluding(getMobileDeviceLastLoginAt, lastLoginAt, modelFilter: modelFilter, includes: includes);

	
List<MobileDevice> getByNotificationPreferences(
    dynamic notificationPreferences,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getManyIncluding(getMobileDeviceNotificationPreferences, notificationPreferences, modelFilter: modelFilter, includes: includes);

	
List<MobileDevice> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getManyIncluding(getMobileDeviceCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MobileDevice> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}
    ) =>
    getManyIncluding(getMobileDeviceUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    MobileDevice mobileDevice, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (mobileDevice.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(mobileDevice.orgId!, includes: includes);
        mobileDevice.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    MobileDevice mobileDevice, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (mobileDevice.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(mobileDevice.userId!, includes: includes);
        mobileDevice.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  List<OfflineSyncQueue> getOfflineSyncQueues(
    MobileDevice mobileDevice, {ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}) {
    final offlineSyncQueues = OfflineSyncQueueStore.instance.getByDeviceId(mobileDevice.$uid!, modelFilter: modelFilter, includes: includes);
    mobileDevice.offlineSyncQueues = offlineSyncQueues;
    // setIncludedReferencesForList(offlineSyncQueues, includes: includes);
    return offlineSyncQueues;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MobileDevice>> getAll$({bool useCache = true, ModelFilter<MobileDevice>? modelFilter, List<MobileDeviceInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MobileDeviceEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MobileDevice?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMobileDeviceId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<MobileDevice?> getByDeviceId$(
        String deviceId,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMobileDeviceDeviceId,
        value: deviceId,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getByDeviceId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MobileDevice>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMobileDeviceOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MobileDevice>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMobileDeviceUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MobileDevice>> getByDeviceType$(
        String deviceType,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMobileDeviceDeviceType,
        value: deviceType,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getManyByDeviceType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MobileDevice>> getByDeviceToken$(
        String deviceToken,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMobileDeviceDeviceToken,
        value: deviceToken,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getManyByDeviceToken,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MobileDevice>> getByAppVersion$(
        String appVersion,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMobileDeviceAppVersion,
        value: appVersion,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getManyByAppVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MobileDevice>> getByOsVersion$(
        String osVersion,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMobileDeviceOsVersion,
        value: osVersion,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getManyByOsVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MobileDevice>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getMobileDeviceIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MobileDevice>> getByLastLoginAt$(
        DateTime lastLoginAt,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMobileDeviceLastLoginAt,
        value: lastLoginAt,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getManyByLastLoginAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MobileDevice>> getByNotificationPreferences$(
        dynamic notificationPreferences,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMobileDeviceNotificationPreferences,
        value: notificationPreferences,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getManyByNotificationPreferences,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MobileDevice>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMobileDeviceCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MobileDevice>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MobileDevice>? modelFilter,
        List<MobileDeviceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMobileDeviceUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MobileDeviceEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    MobileDevice mobileDevice, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (mobileDevice.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            mobileDevice.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            mobileDevice.org = org;
        });
    }
}

	Stream<User?> getUser$(
    MobileDevice mobileDevice, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (mobileDevice.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            mobileDevice.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            mobileDevice.user = user;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<OfflineSyncQueue>> getOfflineSyncQueues$(
    MobileDevice mobileDevice, {bool useCache = true, ModelFilter<OfflineSyncQueue>? modelFilter, List<OfflineSyncQueueInclude>? includes}) {
    return OfflineSyncQueueStore.instance.getByDeviceId$(
        mobileDevice.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((offlineSyncQueues) {
        mobileDevice.offlineSyncQueues = offlineSyncQueues;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
MobileDevice recursiveUpsert(MobileDevice mobileDevice, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MobileDevice'} 
        : const {};
    if (mobileDevice.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        mobileDevice.org = OrganizationStore.instance.recursiveUpsert(mobileDevice.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mobileDevice.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        mobileDevice.user = UserStore.instance.recursiveUpsert(mobileDevice.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mobileDevice.offlineSyncQueues != null && (!preventCircularSerialization || !upsertedTypes.contains('OfflineSyncQueue'))) {
        mobileDevice.offlineSyncQueues = OfflineSyncQueueStore.instance.recursiveListUpsert(mobileDevice.offlineSyncQueues!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(mobileDevice);
}

  List<MobileDevice> recursiveListUpsert(List<MobileDevice> mobileDevices, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMobileDevices = <MobileDevice>[];
    for (var mobileDevice in mobileDevices) {
        updatedMobileDevices.add(recursiveUpsert(mobileDevice, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMobileDevices;
}

//   @override
//   MobileDevice upsert(MobileDevice item) {
//     return recursiveUpsert(item);
//   }

}


class MobileDeviceInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MobileDeviceInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mobileDevice) => MobileDeviceStore.instance
            .getOrg$(mobileDevice, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mobileDevice) => MobileDeviceStore.instance
            .getOrg(mobileDevice, modelFilter: modelFilter, includes: includes);
      }
}

	MobileDeviceInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mobileDevice) => MobileDeviceStore.instance
            .getUser$(mobileDevice, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mobileDevice) => MobileDeviceStore.instance
            .getUser(mobileDevice, modelFilter: modelFilter, includes: includes);
      }
}

	MobileDeviceInclude.offlineSyncQueues({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<OfflineSyncQueue>? modelFilter,
    List<OfflineSyncQueueInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mobileDevice) => MobileDeviceStore.instance
            .getOfflineSyncQueues$(mobileDevice, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mobileDevice) => MobileDeviceStore.instance
            .getOfflineSyncQueues(mobileDevice, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MobileDeviceEndpoints implements Endpoint {

    getAll('/mobileDevice', HttpMethod.post, List<MobileDevice>),
	getById('/mobileDevice/byId/:id', HttpMethod.post, MobileDevice),
	getManyByOrgId('/mobileDevice/byOrgId/:orgId', HttpMethod.post, List<MobileDevice>),
	getManyByUserId('/mobileDevice/byUserId/:userId', HttpMethod.post, List<MobileDevice>),
	getByDeviceId('/mobileDevice/byDeviceId/:deviceId', HttpMethod.post, MobileDevice),
	getManyByDeviceType('/mobileDevice/byDeviceType/:deviceType', HttpMethod.post, List<MobileDevice>),
	getManyByDeviceToken('/mobileDevice/byDeviceToken/:deviceToken', HttpMethod.post, List<MobileDevice>),
	getManyByAppVersion('/mobileDevice/byAppVersion/:appVersion', HttpMethod.post, List<MobileDevice>),
	getManyByOsVersion('/mobileDevice/byOsVersion/:osVersion', HttpMethod.post, List<MobileDevice>),
	getManyByIsActive('/mobileDevice/byIsActive/:isActive', HttpMethod.post, List<MobileDevice>),
	getManyByLastLoginAt('/mobileDevice/byLastLoginAt/:lastLoginAt', HttpMethod.post, List<MobileDevice>),
	getManyByNotificationPreferences('/mobileDevice/byNotificationPreferences/:notificationPreferences', HttpMethod.post, List<MobileDevice>),
	getManyByCreatedAt('/mobileDevice/byCreatedAt/:createdAt', HttpMethod.post, List<MobileDevice>),
	getManyByUpdatedAt('/mobileDevice/byUpdatedAt/:updatedAt', HttpMethod.post, List<MobileDevice>);

    const MobileDeviceEndpoints(this.path, this.method, this.responseType);

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
