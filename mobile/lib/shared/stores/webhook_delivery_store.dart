
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class WebhookDeliveryStore extends ModelStreamStore<String, WebhookDelivery> {

  static WebhookDeliveryStore? _instance;

  static WebhookDeliveryStore get instance {
    _instance ??= WebhookDeliveryStore();
    return _instance!;
  }

  WebhookDeliveryStore() : super(WebhookDelivery.fromJson) {
    if (_instance != null) {
        throw Exception(
            'WebhookDeliveryStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending WebhookDeliveryStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use WebhookDeliveryStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getWebhookDeliveryId(WebhookDelivery webhookDelivery) => webhookDelivery.id;

	String? getWebhookDeliveryOrgId(WebhookDelivery webhookDelivery) => webhookDelivery.orgId;

	String? getWebhookDeliveryWebhookId(WebhookDelivery webhookDelivery) => webhookDelivery.webhookId;

	String? getWebhookDeliveryEventType(WebhookDelivery webhookDelivery) => webhookDelivery.eventType;

	dynamic? getWebhookDeliveryPayload(WebhookDelivery webhookDelivery) => webhookDelivery.payload;

	dynamic? getWebhookDeliveryResponse(WebhookDelivery webhookDelivery) => webhookDelivery.response;

	int? getWebhookDeliveryStatusCode(WebhookDelivery webhookDelivery) => webhookDelivery.statusCode;

	DateTime? getWebhookDeliveryDeliveredAt(WebhookDelivery webhookDelivery) => webhookDelivery.deliveredAt;

	String? getWebhookDeliveryError(WebhookDelivery webhookDelivery) => webhookDelivery.error;

	DateTime? getWebhookDeliveryCreatedAt(WebhookDelivery webhookDelivery) => webhookDelivery.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<WebhookDelivery> getByOrgId(
    String orgId,
    {ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}
    ) =>
    getManyIncluding(getWebhookDeliveryOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<WebhookDelivery> getByWebhookId(
    String webhookId,
    {ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}
    ) =>
    getManyIncluding(getWebhookDeliveryWebhookId, webhookId, modelFilter: modelFilter, includes: includes);

	
List<WebhookDelivery> getByEventType(
    String eventType,
    {ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}
    ) =>
    getManyIncluding(getWebhookDeliveryEventType, eventType, modelFilter: modelFilter, includes: includes);

	
List<WebhookDelivery> getByPayload(
    dynamic payload,
    {ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}
    ) =>
    getManyIncluding(getWebhookDeliveryPayload, payload, modelFilter: modelFilter, includes: includes);

	
List<WebhookDelivery> getByResponse(
    dynamic response,
    {ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}
    ) =>
    getManyIncluding(getWebhookDeliveryResponse, response, modelFilter: modelFilter, includes: includes);

	
List<WebhookDelivery> getByStatusCode(
    int statusCode,
    {ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}
    ) =>
    getManyIncluding(getWebhookDeliveryStatusCode, statusCode, modelFilter: modelFilter, includes: includes);

	
List<WebhookDelivery> getByDeliveredAt(
    DateTime deliveredAt,
    {ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}
    ) =>
    getManyIncluding(getWebhookDeliveryDeliveredAt, deliveredAt, modelFilter: modelFilter, includes: includes);

	
List<WebhookDelivery> getByError(
    String error,
    {ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}
    ) =>
    getManyIncluding(getWebhookDeliveryError, error, modelFilter: modelFilter, includes: includes);

	
List<WebhookDelivery> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}
    ) =>
    getManyIncluding(getWebhookDeliveryCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    WebhookDelivery webhookDelivery, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (webhookDelivery.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(webhookDelivery.orgId!, includes: includes);
        webhookDelivery.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Webhook? getWebhook(
    WebhookDelivery webhookDelivery, {ModelFilter? modelFilter, List<WebhookInclude>? includes}) {
    if (webhookDelivery.webhookId == null) {
        return null;
    } else {
        final webhook = WebhookStore.instance.getById(webhookDelivery.webhookId!, includes: includes);
        webhookDelivery.webhook = webhook;
        // setIncludedReferences(webhook, includes: includes);
        return webhook;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<WebhookDelivery>> getAll$({bool useCache = true, ModelFilter<WebhookDelivery>? modelFilter, List<WebhookDeliveryInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: WebhookDeliveryEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<WebhookDelivery?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<WebhookDelivery>? modelFilter,
        List<WebhookDeliveryInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getWebhookDeliveryId,
        value: id,
        modelFilter: modelFilter,
        endpoint: WebhookDeliveryEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<WebhookDelivery>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<WebhookDelivery>? modelFilter,
        List<WebhookDeliveryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getWebhookDeliveryOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: WebhookDeliveryEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<WebhookDelivery>> getByWebhookId$(
        String webhookId,
        {bool useCache = true,
        ModelFilter<WebhookDelivery>? modelFilter,
        List<WebhookDeliveryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getWebhookDeliveryWebhookId,
        value: webhookId,
        modelFilter: modelFilter,
        endpoint: WebhookDeliveryEndpoints.getManyByWebhookId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<WebhookDelivery>> getByEventType$(
        String eventType,
        {bool useCache = true,
        ModelFilter<WebhookDelivery>? modelFilter,
        List<WebhookDeliveryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getWebhookDeliveryEventType,
        value: eventType,
        modelFilter: modelFilter,
        endpoint: WebhookDeliveryEndpoints.getManyByEventType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<WebhookDelivery>> getByPayload$(
        dynamic payload,
        {bool useCache = true,
        ModelFilter<WebhookDelivery>? modelFilter,
        List<WebhookDeliveryInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getWebhookDeliveryPayload,
        value: payload,
        modelFilter: modelFilter,
        endpoint: WebhookDeliveryEndpoints.getManyByPayload,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<WebhookDelivery>> getByResponse$(
        dynamic response,
        {bool useCache = true,
        ModelFilter<WebhookDelivery>? modelFilter,
        List<WebhookDeliveryInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getWebhookDeliveryResponse,
        value: response,
        modelFilter: modelFilter,
        endpoint: WebhookDeliveryEndpoints.getManyByResponse,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<WebhookDelivery>> getByStatusCode$(
        int statusCode,
        {bool useCache = true,
        ModelFilter<WebhookDelivery>? modelFilter,
        List<WebhookDeliveryInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getWebhookDeliveryStatusCode,
        value: statusCode,
        modelFilter: modelFilter,
        endpoint: WebhookDeliveryEndpoints.getManyByStatusCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<WebhookDelivery>> getByDeliveredAt$(
        DateTime deliveredAt,
        {bool useCache = true,
        ModelFilter<WebhookDelivery>? modelFilter,
        List<WebhookDeliveryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getWebhookDeliveryDeliveredAt,
        value: deliveredAt,
        modelFilter: modelFilter,
        endpoint: WebhookDeliveryEndpoints.getManyByDeliveredAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<WebhookDelivery>> getByError$(
        String error,
        {bool useCache = true,
        ModelFilter<WebhookDelivery>? modelFilter,
        List<WebhookDeliveryInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getWebhookDeliveryError,
        value: error,
        modelFilter: modelFilter,
        endpoint: WebhookDeliveryEndpoints.getManyByError,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<WebhookDelivery>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<WebhookDelivery>? modelFilter,
        List<WebhookDeliveryInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getWebhookDeliveryCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: WebhookDeliveryEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    WebhookDelivery webhookDelivery, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (webhookDelivery.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            webhookDelivery.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            webhookDelivery.org = org;
        });
    }
}

	Stream<Webhook?> getWebhook$(
    WebhookDelivery webhookDelivery, {bool useCache = true, ModelFilter<Webhook>? modelFilter, List<WebhookInclude>? includes}) {
    if (webhookDelivery.webhookId == null) {
        return Stream.value(null);
    } else {
        return WebhookStore.instance.getById$(
            webhookDelivery.webhookId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((webhook) {
            webhookDelivery.webhook = webhook;
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
WebhookDelivery recursiveUpsert(WebhookDelivery webhookDelivery, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'WebhookDelivery'} 
        : const {};
    if (webhookDelivery.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        webhookDelivery.org = OrganizationStore.instance.recursiveUpsert(webhookDelivery.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (webhookDelivery.webhook != null && (!preventCircularSerialization || !upsertedTypes.contains('Webhook'))) {
        webhookDelivery.webhook = WebhookStore.instance.recursiveUpsert(webhookDelivery.webhook!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(webhookDelivery);
}

  List<WebhookDelivery> recursiveListUpsert(List<WebhookDelivery> webhookDeliverys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedWebhookDeliverys = <WebhookDelivery>[];
    for (var webhookDelivery in webhookDeliverys) {
        updatedWebhookDeliverys.add(recursiveUpsert(webhookDelivery, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedWebhookDeliverys;
}

//   @override
//   WebhookDelivery upsert(WebhookDelivery item) {
//     return recursiveUpsert(item);
//   }

}


class WebhookDeliveryInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      WebhookDeliveryInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (webhookDelivery) => WebhookDeliveryStore.instance
            .getOrg$(webhookDelivery, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (webhookDelivery) => WebhookDeliveryStore.instance
            .getOrg(webhookDelivery, modelFilter: modelFilter, includes: includes);
      }
}

	WebhookDeliveryInclude.webhook({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Webhook>? modelFilter,
    List<WebhookInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (webhookDelivery) => WebhookDeliveryStore.instance
            .getWebhook$(webhookDelivery, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (webhookDelivery) => WebhookDeliveryStore.instance
            .getWebhook(webhookDelivery, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum WebhookDeliveryEndpoints implements Endpoint {

    getAll('/webhookDelivery', HttpMethod.post, List<WebhookDelivery>),
	getById('/webhookDelivery/byId/:id', HttpMethod.post, WebhookDelivery),
	getManyByOrgId('/webhookDelivery/byOrgId/:orgId', HttpMethod.post, List<WebhookDelivery>),
	getManyByWebhookId('/webhookDelivery/byWebhookId/:webhookId', HttpMethod.post, List<WebhookDelivery>),
	getManyByEventType('/webhookDelivery/byEventType/:eventType', HttpMethod.post, List<WebhookDelivery>),
	getManyByPayload('/webhookDelivery/byPayload/:payload', HttpMethod.post, List<WebhookDelivery>),
	getManyByResponse('/webhookDelivery/byResponse/:response', HttpMethod.post, List<WebhookDelivery>),
	getManyByStatusCode('/webhookDelivery/byStatusCode/:statusCode', HttpMethod.post, List<WebhookDelivery>),
	getManyByDeliveredAt('/webhookDelivery/byDeliveredAt/:deliveredAt', HttpMethod.post, List<WebhookDelivery>),
	getManyByError('/webhookDelivery/byError/:error', HttpMethod.post, List<WebhookDelivery>),
	getManyByCreatedAt('/webhookDelivery/byCreatedAt/:createdAt', HttpMethod.post, List<WebhookDelivery>);

    const WebhookDeliveryEndpoints(this.path, this.method, this.responseType);

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
