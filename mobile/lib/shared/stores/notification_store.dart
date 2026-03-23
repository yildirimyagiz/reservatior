
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class NotificationStore extends ModelStreamStore<String, Notification> {

  static NotificationStore? _instance;

  static NotificationStore get instance {
    _instance ??= NotificationStore();
    return _instance!;
  }

  NotificationStore() : super(Notification.fromJson) {
    if (_instance != null) {
        throw Exception(
            'NotificationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending NotificationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use NotificationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getNotificationId(Notification notification) => notification.id;

	String? getNotificationOrgId(Notification notification) => notification.orgId;

	String? getNotificationUserId(Notification notification) => notification.userId;

	String? getNotificationTitle(Notification notification) => notification.title;

	String? getNotificationBody(Notification notification) => notification.body;

	dynamic? getNotificationData(Notification notification) => notification.data;

	NotificationStatus? getNotificationStatus(Notification notification) => notification.status;

	DateTime? getNotificationSentAt(Notification notification) => notification.sentAt;

	DateTime? getNotificationReadAt(Notification notification) => notification.readAt;

	dynamic? getNotificationUserPreferences(Notification notification) => notification.userPreferences;

	dynamic? getNotificationDeliveries(Notification notification) => notification.deliveries;

	String? getNotificationRuleKey(Notification notification) => notification.ruleKey;

	dynamic? getNotificationRuleConfig(Notification notification) => notification.ruleConfig;

	DateTime? getNotificationCreatedAt(Notification notification) => notification.createdAt;

	DateTime? getNotificationUpdatedAt(Notification notification) => notification.updatedAt;

	DateTime? getNotificationDeletedAt(Notification notification) => notification.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Notification> getByOrgId(
    String orgId,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByUserId(
    String userId,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByTitle(
    String title,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationTitle, title, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByBody(
    String body,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationBody, body, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByData(
    dynamic data,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationData, data, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByStatus(
    NotificationStatus status,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Notification> getBySentAt(
    DateTime sentAt,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationSentAt, sentAt, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByReadAt(
    DateTime readAt,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationReadAt, readAt, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByUserPreferences(
    dynamic userPreferences,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationUserPreferences, userPreferences, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByDeliveries(
    dynamic deliveries,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationDeliveries, deliveries, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByRuleKey(
    String ruleKey,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationRuleKey, ruleKey, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByRuleConfig(
    dynamic ruleConfig,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationRuleConfig, ruleConfig, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Notification> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}
    ) =>
    getManyIncluding(getNotificationDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Notification notification, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (notification.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(notification.orgId!, includes: includes);
        notification.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    Notification notification, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (notification.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(notification.userId!, includes: includes);
        notification.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  List<Agent> getAgents(
    Notification notification, {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    final agents = AgentStore.instance.getBy(notification.$uid!, modelFilter: modelFilter, includes: includes);
    notification.agents = agents;
    // setIncludedReferencesForList(agents, includes: includes);
    return agents;
}

	List<Agency> getAgencies(
    Notification notification, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getBy(notification.$uid!, modelFilter: modelFilter, includes: includes);
    notification.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<Tenant> getTenants(
    Notification notification, {ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    final tenants = TenantStore.instance.getBy(notification.$uid!, modelFilter: modelFilter, includes: includes);
    notification.tenants = tenants;
    // setIncludedReferencesForList(tenants, includes: includes);
    return tenants;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Notification>> getAll$({bool useCache = true, ModelFilter<Notification>? modelFilter, List<NotificationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: NotificationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Notification?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getNotificationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Notification>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNotificationOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNotificationUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNotificationTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByBody$(
        String body,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNotificationBody,
        value: body,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByBody,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByData$(
        dynamic data,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getNotificationData,
        value: data,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByStatus$(
        NotificationStatus status,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<NotificationStatus>(
        getPropVal: getNotificationStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getBySentAt$(
        DateTime sentAt,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getNotificationSentAt,
        value: sentAt,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyBySentAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByReadAt$(
        DateTime readAt,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getNotificationReadAt,
        value: readAt,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByReadAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByUserPreferences$(
        dynamic userPreferences,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getNotificationUserPreferences,
        value: userPreferences,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByUserPreferences,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByDeliveries$(
        dynamic deliveries,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getNotificationDeliveries,
        value: deliveries,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByDeliveries,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByRuleKey$(
        String ruleKey,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNotificationRuleKey,
        value: ruleKey,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByRuleKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByRuleConfig$(
        dynamic ruleConfig,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getNotificationRuleConfig,
        value: ruleConfig,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByRuleConfig,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getNotificationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getNotificationUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Notification>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Notification>? modelFilter,
        List<NotificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getNotificationDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: NotificationEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Notification notification, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (notification.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            notification.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            notification.org = org;
        });
    }
}

	Stream<User?> getUser$(
    Notification notification, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (notification.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            notification.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            notification.user = user;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Agent>> getAgents$(
    Notification notification, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    return AgentStore.instance.getBy$(
        notification.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agents) {
        notification.agents = agents;
    });

}

	Stream<List<Agency>> getAgencies$(
    Notification notification, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        notification.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        notification.agencies = agencies;
    });

}

	Stream<List<Tenant>> getTenants$(
    Notification notification, {bool useCache = true, ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    return TenantStore.instance.getBy$(
        notification.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((tenants) {
        notification.tenants = tenants;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Notification recursiveUpsert(Notification notification, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Notification'} 
        : const {};
    if (notification.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        notification.org = OrganizationStore.instance.recursiveUpsert(notification.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (notification.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        notification.user = UserStore.instance.recursiveUpsert(notification.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (notification.agents != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        notification.agents = AgentStore.instance.recursiveListUpsert(notification.agents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (notification.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        notification.agencies = AgencyStore.instance.recursiveListUpsert(notification.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (notification.tenants != null && (!preventCircularSerialization || !upsertedTypes.contains('Tenant'))) {
        notification.tenants = TenantStore.instance.recursiveListUpsert(notification.tenants!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(notification);
}

  List<Notification> recursiveListUpsert(List<Notification> notifications, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedNotifications = <Notification>[];
    for (var notification in notifications) {
        updatedNotifications.add(recursiveUpsert(notification, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedNotifications;
}

//   @override
//   Notification upsert(Notification item) {
//     return recursiveUpsert(item);
//   }

}


class NotificationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      NotificationInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (notification) => NotificationStore.instance
            .getOrg$(notification, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (notification) => NotificationStore.instance
            .getOrg(notification, modelFilter: modelFilter, includes: includes);
      }
}

	NotificationInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (notification) => NotificationStore.instance
            .getUser$(notification, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (notification) => NotificationStore.instance
            .getUser(notification, modelFilter: modelFilter, includes: includes);
      }
}

	NotificationInclude.agents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (notification) => NotificationStore.instance
            .getAgents$(notification, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (notification) => NotificationStore.instance
            .getAgents(notification, modelFilter: modelFilter, includes: includes);
      }
}

	NotificationInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (notification) => NotificationStore.instance
            .getAgencies$(notification, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (notification) => NotificationStore.instance
            .getAgencies(notification, modelFilter: modelFilter, includes: includes);
      }
}

	NotificationInclude.tenants({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tenant>? modelFilter,
    List<TenantInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (notification) => NotificationStore.instance
            .getTenants$(notification, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (notification) => NotificationStore.instance
            .getTenants(notification, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum NotificationEndpoints implements Endpoint {

    getAll('/notification', HttpMethod.post, List<Notification>),
	getById('/notification/byId/:id', HttpMethod.post, Notification),
	getManyByOrgId('/notification/byOrgId/:orgId', HttpMethod.post, List<Notification>),
	getManyByUserId('/notification/byUserId/:userId', HttpMethod.post, List<Notification>),
	getManyByTitle('/notification/byTitle/:title', HttpMethod.post, List<Notification>),
	getManyByBody('/notification/byBody/:body', HttpMethod.post, List<Notification>),
	getManyByData('/notification/byData/:data', HttpMethod.post, List<Notification>),
	getManyByStatus('/notification/byStatus/:status', HttpMethod.post, List<Notification>),
	getManyBySentAt('/notification/bySentAt/:sentAt', HttpMethod.post, List<Notification>),
	getManyByReadAt('/notification/byReadAt/:readAt', HttpMethod.post, List<Notification>),
	getManyByUserPreferences('/notification/byUserPreferences/:userPreferences', HttpMethod.post, List<Notification>),
	getManyByDeliveries('/notification/byDeliveries/:deliveries', HttpMethod.post, List<Notification>),
	getManyByRuleKey('/notification/byRuleKey/:ruleKey', HttpMethod.post, List<Notification>),
	getManyByRuleConfig('/notification/byRuleConfig/:ruleConfig', HttpMethod.post, List<Notification>),
	getManyByCreatedAt('/notification/byCreatedAt/:createdAt', HttpMethod.post, List<Notification>),
	getManyByUpdatedAt('/notification/byUpdatedAt/:updatedAt', HttpMethod.post, List<Notification>),
	getManyByDeletedAt('/notification/byDeletedAt/:deletedAt', HttpMethod.post, List<Notification>);

    const NotificationEndpoints(this.path, this.method, this.responseType);

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
