
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ChannelStore extends ModelStreamStore<String, Channel> {

  static ChannelStore? _instance;

  static ChannelStore get instance {
    _instance ??= ChannelStore();
    return _instance!;
  }

  ChannelStore() : super(Channel.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ChannelStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ChannelStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ChannelStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getChannelId(Channel channel) => channel.id;

	String? getChannelCuid(Channel channel) => channel.cuid;

	String? getChannelName(Channel channel) => channel.name;

	ChannelType? getChannelType(Channel channel) => channel.type;

	ChannelCategory? getChannelCategory(Channel channel) => channel.category;

	String? getChannelDescription(Channel channel) => channel.description;

	DateTime? getChannelCreatedAt(Channel channel) => channel.createdAt;

	DateTime? getChannelUpdatedAt(Channel channel) => channel.updatedAt;

	DateTime? getChannelDeletedAt(Channel channel) => channel.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Channel? getByCuid(
    String cuid,
    {ModelFilter<Channel>? modelFilter, List<ChannelInclude>? includes}
    ) =>
    getIncluding(getChannelCuid, cuid, modelFilter: modelFilter, includes: includes);

  
List<Channel> getByName(
    String name,
    {ModelFilter<Channel>? modelFilter, List<ChannelInclude>? includes}
    ) =>
    getManyIncluding(getChannelName, name, modelFilter: modelFilter, includes: includes);

	
List<Channel> getByType(
    ChannelType type,
    {ModelFilter<Channel>? modelFilter, List<ChannelInclude>? includes}
    ) =>
    getManyIncluding(getChannelType, type, modelFilter: modelFilter, includes: includes);

	
List<Channel> getByCategory(
    ChannelCategory category,
    {ModelFilter<Channel>? modelFilter, List<ChannelInclude>? includes}
    ) =>
    getManyIncluding(getChannelCategory, category, modelFilter: modelFilter, includes: includes);

	
List<Channel> getByDescription(
    String description,
    {ModelFilter<Channel>? modelFilter, List<ChannelInclude>? includes}
    ) =>
    getManyIncluding(getChannelDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Channel> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Channel>? modelFilter, List<ChannelInclude>? includes}
    ) =>
    getManyIncluding(getChannelCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Channel> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Channel>? modelFilter, List<ChannelInclude>? includes}
    ) =>
    getManyIncluding(getChannelUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Channel> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Channel>? modelFilter, List<ChannelInclude>? includes}
    ) =>
    getManyIncluding(getChannelDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  List<CommunicationLog> getCommunicationLogs(
    Channel channel, {ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    final CommunicationLogs = CommunicationLogStore.instance.getByChannelId(channel.$uid!, modelFilter: modelFilter, includes: includes);
    channel.CommunicationLogs = CommunicationLogs;
    // setIncludedReferencesForList(CommunicationLogs, includes: includes);
    return CommunicationLogs;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Channel>> getAll$({bool useCache = true, ModelFilter<Channel>? modelFilter, List<ChannelInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ChannelEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Channel?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Channel>? modelFilter,
        List<ChannelInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getChannelId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ChannelEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Channel?> getByCuid$(
        String cuid,
        {bool useCache = true,
        ModelFilter<Channel>? modelFilter,
        List<ChannelInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getChannelCuid,
        value: cuid,
        modelFilter: modelFilter,
        endpoint: ChannelEndpoints.getByCuid,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Channel>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Channel>? modelFilter,
        List<ChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getChannelName,
        value: name,
        modelFilter: modelFilter,
        endpoint: ChannelEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Channel>> getByType$(
        ChannelType type,
        {bool useCache = true,
        ModelFilter<Channel>? modelFilter,
        List<ChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<ChannelType>(
        getPropVal: getChannelType,
        value: type,
        modelFilter: modelFilter,
        endpoint: ChannelEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Channel>> getByCategory$(
        ChannelCategory category,
        {bool useCache = true,
        ModelFilter<Channel>? modelFilter,
        List<ChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<ChannelCategory>(
        getPropVal: getChannelCategory,
        value: category,
        modelFilter: modelFilter,
        endpoint: ChannelEndpoints.getManyByCategory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Channel>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Channel>? modelFilter,
        List<ChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getChannelDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: ChannelEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Channel>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Channel>? modelFilter,
        List<ChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getChannelCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ChannelEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Channel>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Channel>? modelFilter,
        List<ChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getChannelUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ChannelEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Channel>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Channel>? modelFilter,
        List<ChannelInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getChannelDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ChannelEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  

  /// GET RELATED MODELS as STREAM

  Stream<List<CommunicationLog>> getCommunicationLogs$(
    Channel channel, {bool useCache = true, ModelFilter<CommunicationLog>? modelFilter, List<CommunicationLogInclude>? includes}) {
    return CommunicationLogStore.instance.getByChannelId$(
        channel.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((CommunicationLogs) {
        channel.CommunicationLogs = CommunicationLogs;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Channel recursiveUpsert(Channel channel, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Channel'} 
        : const {};
    if (channel.CommunicationLogs != null && (!preventCircularSerialization || !upsertedTypes.contains('CommunicationLog'))) {
        channel.CommunicationLogs = CommunicationLogStore.instance.recursiveListUpsert(channel.CommunicationLogs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(channel);
}

  List<Channel> recursiveListUpsert(List<Channel> channels, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedChannels = <Channel>[];
    for (var channel in channels) {
        updatedChannels.add(recursiveUpsert(channel, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedChannels;
}

//   @override
//   Channel upsert(Channel item) {
//     return recursiveUpsert(item);
//   }

}


class ChannelInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ChannelInclude.CommunicationLogs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<CommunicationLog>? modelFilter,
    List<CommunicationLogInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (channel) => ChannelStore.instance
            .getCommunicationLogs$(channel, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (channel) => ChannelStore.instance
            .getCommunicationLogs(channel, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ChannelEndpoints implements Endpoint {

    getAll('/channel', HttpMethod.post, List<Channel>),
	getById('/channel/byId/:id', HttpMethod.post, Channel),
	getByCuid('/channel/byCuid/:cuid', HttpMethod.post, Channel),
	getManyByName('/channel/byName/:name', HttpMethod.post, List<Channel>),
	getManyByType('/channel/byType/:type', HttpMethod.post, List<Channel>),
	getManyByCategory('/channel/byCategory/:category', HttpMethod.post, List<Channel>),
	getManyByDescription('/channel/byDescription/:description', HttpMethod.post, List<Channel>),
	getManyByCreatedAt('/channel/byCreatedAt/:createdAt', HttpMethod.post, List<Channel>),
	getManyByUpdatedAt('/channel/byUpdatedAt/:updatedAt', HttpMethod.post, List<Channel>),
	getManyByDeletedAt('/channel/byDeletedAt/:deletedAt', HttpMethod.post, List<Channel>);

    const ChannelEndpoints(this.path, this.method, this.responseType);

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
