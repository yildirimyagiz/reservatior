
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ListingChannelStore extends ModelStreamStore<String, ListingChannel> {

  static ListingChannelStore? _instance;

  static ListingChannelStore get instance {
    _instance ??= ListingChannelStore();
    return _instance!;
  }

  ListingChannelStore() : super(ListingChannel.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ListingChannelStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ListingChannelStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ListingChannelStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getListingChannelId(ListingChannel listingChannel) => listingChannel.id;

	String? getListingChannelOrgId(ListingChannel listingChannel) => listingChannel.orgId;

	String? getListingChannelListingId(ListingChannel listingChannel) => listingChannel.listingId;

	ListingChannelType? getListingChannelChannel(ListingChannel listingChannel) => listingChannel.channel;

	String? getListingChannelChannelId(ListingChannel listingChannel) => listingChannel.channelId;

	String? getListingChannelStatus(ListingChannel listingChannel) => listingChannel.status;

	DateTime? getListingChannelLastSync(ListingChannel listingChannel) => listingChannel.lastSync;

	DateTime? getListingChannelCreatedAt(ListingChannel listingChannel) => listingChannel.createdAt;

	DateTime? getListingChannelUpdatedAt(ListingChannel listingChannel) => listingChannel.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ListingChannel> getByOrgId(
    String orgId,
    {ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}
    ) =>
    getManyIncluding(getListingChannelOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ListingChannel> getByListingId(
    String listingId,
    {ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}
    ) =>
    getManyIncluding(getListingChannelListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<ListingChannel> getByChannel(
    ListingChannelType channel,
    {ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}
    ) =>
    getManyIncluding(getListingChannelChannel, channel, modelFilter: modelFilter, includes: includes);

	
List<ListingChannel> getByChannelId(
    String channelId,
    {ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}
    ) =>
    getManyIncluding(getListingChannelChannelId, channelId, modelFilter: modelFilter, includes: includes);

	
List<ListingChannel> getByStatus(
    String status,
    {ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}
    ) =>
    getManyIncluding(getListingChannelStatus, status, modelFilter: modelFilter, includes: includes);

	
List<ListingChannel> getByLastSync(
    DateTime lastSync,
    {ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}
    ) =>
    getManyIncluding(getListingChannelLastSync, lastSync, modelFilter: modelFilter, includes: includes);

	
List<ListingChannel> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}
    ) =>
    getManyIncluding(getListingChannelCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ListingChannel> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}
    ) =>
    getManyIncluding(getListingChannelUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Listing? getListing(
    ListingChannel listingChannel, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (listingChannel.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(listingChannel.listingId!, includes: includes);
        listingChannel.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    ListingChannel listingChannel, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (listingChannel.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(listingChannel.orgId!, includes: includes);
        listingChannel.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ListingChannel>> getAll$({bool useCache = true, ModelFilter<ListingChannel>? modelFilter, List<ListingChannelInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ListingChannelEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ListingChannel?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ListingChannel>? modelFilter,
        List<ListingChannelInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getListingChannelId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ListingChannelEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ListingChannel>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ListingChannel>? modelFilter,
        List<ListingChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingChannelOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ListingChannelEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingChannel>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<ListingChannel>? modelFilter,
        List<ListingChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingChannelListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: ListingChannelEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingChannel>> getByChannel$(
        ListingChannelType channel,
        {bool useCache = true,
        ModelFilter<ListingChannel>? modelFilter,
        List<ListingChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<ListingChannelType>(
        getPropVal: getListingChannelChannel,
        value: channel,
        modelFilter: modelFilter,
        endpoint: ListingChannelEndpoints.getManyByChannel,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingChannel>> getByChannelId$(
        String channelId,
        {bool useCache = true,
        ModelFilter<ListingChannel>? modelFilter,
        List<ListingChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingChannelChannelId,
        value: channelId,
        modelFilter: modelFilter,
        endpoint: ListingChannelEndpoints.getManyByChannelId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingChannel>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<ListingChannel>? modelFilter,
        List<ListingChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingChannelStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ListingChannelEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingChannel>> getByLastSync$(
        DateTime lastSync,
        {bool useCache = true,
        ModelFilter<ListingChannel>? modelFilter,
        List<ListingChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingChannelLastSync,
        value: lastSync,
        modelFilter: modelFilter,
        endpoint: ListingChannelEndpoints.getManyByLastSync,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingChannel>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ListingChannel>? modelFilter,
        List<ListingChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingChannelCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ListingChannelEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingChannel>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ListingChannel>? modelFilter,
        List<ListingChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingChannelUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ListingChannelEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Listing?> getListing$(
    ListingChannel listingChannel, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (listingChannel.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            listingChannel.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            listingChannel.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    ListingChannel listingChannel, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (listingChannel.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            listingChannel.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            listingChannel.org = org;
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
ListingChannel recursiveUpsert(ListingChannel listingChannel, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ListingChannel'} 
        : const {};
    if (listingChannel.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        listingChannel.listing = ListingStore.instance.recursiveUpsert(listingChannel.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listingChannel.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        listingChannel.org = OrganizationStore.instance.recursiveUpsert(listingChannel.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(listingChannel);
}

  List<ListingChannel> recursiveListUpsert(List<ListingChannel> listingChannels, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedListingChannels = <ListingChannel>[];
    for (var listingChannel in listingChannels) {
        updatedListingChannels.add(recursiveUpsert(listingChannel, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedListingChannels;
}

//   @override
//   ListingChannel upsert(ListingChannel item) {
//     return recursiveUpsert(item);
//   }

}


class ListingChannelInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ListingChannelInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listingChannel) => ListingChannelStore.instance
            .getListing$(listingChannel, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listingChannel) => ListingChannelStore.instance
            .getListing(listingChannel, modelFilter: modelFilter, includes: includes);
      }
}

	ListingChannelInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listingChannel) => ListingChannelStore.instance
            .getOrg$(listingChannel, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listingChannel) => ListingChannelStore.instance
            .getOrg(listingChannel, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ListingChannelEndpoints implements Endpoint {

    getAll('/listingChannel', HttpMethod.post, List<ListingChannel>),
	getById('/listingChannel/byId/:id', HttpMethod.post, ListingChannel),
	getManyByOrgId('/listingChannel/byOrgId/:orgId', HttpMethod.post, List<ListingChannel>),
	getManyByListingId('/listingChannel/byListingId/:listingId', HttpMethod.post, List<ListingChannel>),
	getManyByChannel('/listingChannel/byChannel/:channel', HttpMethod.post, List<ListingChannel>),
	getManyByChannelId('/listingChannel/byChannelId/:channelId', HttpMethod.post, List<ListingChannel>),
	getManyByStatus('/listingChannel/byStatus/:status', HttpMethod.post, List<ListingChannel>),
	getManyByLastSync('/listingChannel/byLastSync/:lastSync', HttpMethod.post, List<ListingChannel>),
	getManyByCreatedAt('/listingChannel/byCreatedAt/:createdAt', HttpMethod.post, List<ListingChannel>),
	getManyByUpdatedAt('/listingChannel/byUpdatedAt/:updatedAt', HttpMethod.post, List<ListingChannel>);

    const ListingChannelEndpoints(this.path, this.method, this.responseType);

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
