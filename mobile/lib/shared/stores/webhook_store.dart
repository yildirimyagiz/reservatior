
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class WebhookStore extends ModelStreamStore<String, Webhook> {

  static WebhookStore? _instance;

  static WebhookStore get instance {
    _instance ??= WebhookStore();
    return _instance!;
  }

  WebhookStore() : super(Webhook.fromJson) {
    if (_instance != null) {
        throw Exception(
            'WebhookStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending WebhookStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use WebhookStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getWebhookId(Webhook webhook) => webhook.id;

	String? getWebhookOrgId(Webhook webhook) => webhook.orgId;

	String? getWebhookName(Webhook webhook) => webhook.name;

	String? getWebhookDescription(Webhook webhook) => webhook.description;

	String? getWebhookUrl(Webhook webhook) => webhook.url;

	String? getWebhookSecret(Webhook webhook) => webhook.secret;

	List<String>? getWebhookEvents(Webhook webhook) => webhook.events;

	dynamic? getWebhookHeaders(Webhook webhook) => webhook.headers;

	bool? getWebhookIsActive(Webhook webhook) => webhook.isActive;

	DateTime? getWebhookLastTriggeredAt(Webhook webhook) => webhook.lastTriggeredAt;

	int? getWebhookFailureCount(Webhook webhook) => webhook.failureCount;

	DateTime? getWebhookCreatedAt(Webhook webhook) => webhook.createdAt;

	DateTime? getWebhookUpdatedAt(Webhook webhook) => webhook.updatedAt;

	DateTime? getWebhookDeletedAt(Webhook webhook) => webhook.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Webhook> getByOrgId(
    String orgId,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getByName(
    String name,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookName, name, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getByDescription(
    String description,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getByUrl(
    String url,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookUrl, url, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getBySecret(
    String secret,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookSecret, secret, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getByEvents(
    String events,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookEvents, events, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getByHeaders(
    dynamic headers,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookHeaders, headers, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getByIsActive(
    bool isActive,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getByLastTriggeredAt(
    DateTime lastTriggeredAt,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookLastTriggeredAt, lastTriggeredAt, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getByFailureCount(
    int failureCount,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookFailureCount, failureCount, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Webhook> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}
    ) =>
    getManyIncluding(getWebhookDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Webhook webhook, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (webhook.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(webhook.orgId!, includes: includes);
        webhook.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<WebhookDelivery> getDeliveries(
    Webhook webhook, {ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}) {
    final deliveries = WebhookDeliveryStore.instance.getByWebhookId(webhook.$uid!, modelFilter: modelFilter, includes: includes);
    webhook.deliveries = deliveries;
    // setIncludedReferencesForList(deliveries, includes: includes);
    return deliveries;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Webhook>> getAll$({bool useCache = true, ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: WebhookEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Webhook?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getWebhookId,
        value: id,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Webhook>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getWebhookOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getWebhookName,
        value: name,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getWebhookDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getByUrl$(
        String url,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getWebhookUrl,
        value: url,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getBySecret$(
        String secret,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getWebhookSecret,
        value: secret,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyBySecret,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getByEvents$(
        String events,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getWebhookEvents,
        value: events,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByEvents,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getByHeaders$(
        dynamic headers,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getWebhookHeaders,
        value: headers,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByHeaders,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getWebhookIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getByLastTriggeredAt$(
        DateTime lastTriggeredAt,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getWebhookLastTriggeredAt,
        value: lastTriggeredAt,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByLastTriggeredAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getByFailureCount$(
        int failureCount,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getWebhookFailureCount,
        value: failureCount,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByFailureCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getWebhookCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getWebhookUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Webhook>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Webhook>? modelFilter,
        List<WebhookInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getWebhookDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: WebhookEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Webhook webhook, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (webhook.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            webhook.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            webhook.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<WebhookDelivery>> getDeliveries$(
    Webhook webhook, {bool useCache = true, ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}) {
    return WebhookDeliveryStore.instance.getByWebhookId$(
        webhook.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((deliveries) {
        webhook.deliveries = deliveries;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Webhook recursiveUpsert(Webhook webhook, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Webhook'} 
        : const {};
    if (webhook.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        webhook.org = OrganizationStore.instance.recursiveUpsert(webhook.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (webhook.deliveries != null && (!preventCircularSerialization || !upsertedTypes.contains('WebhookDelivery'))) {
        webhook.deliveries = WebhookDeliveryStore.instance.recursiveListUpsert(webhook.deliveries!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(webhook);
}

  List<Webhook> recursiveListUpsert(List<Webhook> webhooks, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedWebhooks = <Webhook>[];
    for (var webhook in webhooks) {
        updatedWebhooks.add(recursiveUpsert(webhook, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedWebhooks;
}

//   @override
//   Webhook upsert(Webhook item) {
//     return recursiveUpsert(item);
//   }

}


class WebhookInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      WebhookInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (webhook) => WebhookStore.instance
            .getOrg$(webhook, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (webhook) => WebhookStore.instance
            .getOrg(webhook, modelFilter: modelFilter, includes: includes);
      }
}

	WebhookInclude.deliveries({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<WebhookDelivery>? modelFilter,
    List<WebhookDeliveryInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (webhook) => WebhookStore.instance
            .getDeliveries$(webhook, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (webhook) => WebhookStore.instance
            .getDeliveries(webhook, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum WebhookEndpoints implements Endpoint {

    getAll('/webhook', HttpMethod.post, List<Webhook>),
	getById('/webhook/byId/:id', HttpMethod.post, Webhook),
	getManyByOrgId('/webhook/byOrgId/:orgId', HttpMethod.post, List<Webhook>),
	getManyByName('/webhook/byName/:name', HttpMethod.post, List<Webhook>),
	getManyByDescription('/webhook/byDescription/:description', HttpMethod.post, List<Webhook>),
	getManyByUrl('/webhook/byUrl/:url', HttpMethod.post, List<Webhook>),
	getManyBySecret('/webhook/bySecret/:secret', HttpMethod.post, List<Webhook>),
	getManyByEvents('/webhook/byEvents/:events', HttpMethod.post, List<Webhook>),
	getManyByHeaders('/webhook/byHeaders/:headers', HttpMethod.post, List<Webhook>),
	getManyByIsActive('/webhook/byIsActive/:isActive', HttpMethod.post, List<Webhook>),
	getManyByLastTriggeredAt('/webhook/byLastTriggeredAt/:lastTriggeredAt', HttpMethod.post, List<Webhook>),
	getManyByFailureCount('/webhook/byFailureCount/:failureCount', HttpMethod.post, List<Webhook>),
	getManyByCreatedAt('/webhook/byCreatedAt/:createdAt', HttpMethod.post, List<Webhook>),
	getManyByUpdatedAt('/webhook/byUpdatedAt/:updatedAt', HttpMethod.post, List<Webhook>),
	getManyByDeletedAt('/webhook/byDeletedAt/:deletedAt', HttpMethod.post, List<Webhook>);

    const WebhookEndpoints(this.path, this.method, this.responseType);

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
