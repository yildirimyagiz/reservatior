
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MentionStore extends ModelStreamStore<String, Mention> {

  static MentionStore? _instance;

  static MentionStore get instance {
    _instance ??= MentionStore();
    return _instance!;
  }

  MentionStore() : super(Mention.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MentionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MentionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MentionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMentionId(Mention mention) => mention.id;

	String? getMentionMentionedById(Mention mention) => mention.mentionedById;

	String? getMentionMentionedToId(Mention mention) => mention.mentionedToId;

	MentionType? getMentionType(Mention mention) => mention.type;

	String? getMentionTaskId(Mention mention) => mention.taskId;

	String? getMentionPropertyId(Mention mention) => mention.propertyId;

	String? getMentionContent(Mention mention) => mention.content;

	bool? getMentionIsRead(Mention mention) => mention.isRead;

	String? getMentionAgencyId(Mention mention) => mention.agencyId;

	DateTime? getMentionCreatedAt(Mention mention) => mention.createdAt;

	DateTime? getMentionUpdatedAt(Mention mention) => mention.updatedAt;

	DateTime? getMentionDeletedAt(Mention mention) => mention.deletedAt;

	String? getMentionUserId(Mention mention) => mention.userId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Mention> getByMentionedById(
    String mentionedById,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionMentionedById, mentionedById, modelFilter: modelFilter, includes: includes);

	
List<Mention> getByMentionedToId(
    String mentionedToId,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionMentionedToId, mentionedToId, modelFilter: modelFilter, includes: includes);

	
List<Mention> getByType(
    MentionType type,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionType, type, modelFilter: modelFilter, includes: includes);

	
List<Mention> getByTaskId(
    String taskId,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionTaskId, taskId, modelFilter: modelFilter, includes: includes);

	
List<Mention> getByPropertyId(
    String propertyId,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Mention> getByContent(
    String content,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionContent, content, modelFilter: modelFilter, includes: includes);

	
List<Mention> getByIsRead(
    bool isRead,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionIsRead, isRead, modelFilter: modelFilter, includes: includes);

	
List<Mention> getByAgencyId(
    String agencyId,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<Mention> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Mention> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Mention> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Mention> getByUserId(
    String userId,
    {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}
    ) =>
    getManyIncluding(getMentionUserId, userId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Agency? getAgency(
    Mention mention, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (mention.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(mention.agencyId!, includes: includes);
        mention.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

	User? getMentionedBy(
    Mention mention, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (mention.mentionedById == null) {
        return null;
    } else {
        final mentionedBy = UserStore.instance.getById(mention.mentionedById!, includes: includes);
        mention.mentionedBy = mentionedBy;
        // setIncludedReferences(mentionedBy, includes: includes);
        return mentionedBy;
    }
}

	User? getMentionedTo(
    Mention mention, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (mention.mentionedToId == null) {
        return null;
    } else {
        final mentionedTo = UserStore.instance.getById(mention.mentionedToId!, includes: includes);
        mention.mentionedTo = mentionedTo;
        // setIncludedReferences(mentionedTo, includes: includes);
        return mentionedTo;
    }
}

	Property? getProperty(
    Mention mention, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (mention.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(mention.propertyId!, includes: includes);
        mention.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

	Task? getTask(
    Mention mention, {ModelFilter? modelFilter, List<TaskInclude>? includes}) {
    if (mention.taskId == null) {
        return null;
    } else {
        final Task = TaskStore.instance.getById(mention.taskId!, includes: includes);
        mention.Task = Task;
        // setIncludedReferences(Task, includes: includes);
        return Task;
    }
}

	User? getUser(
    Mention mention, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (mention.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(mention.userId!, includes: includes);
        mention.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Mention>> getAll$({bool useCache = true, ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MentionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Mention?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMentionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Mention>> getByMentionedById$(
        String mentionedById,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMentionMentionedById,
        value: mentionedById,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByMentionedById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mention>> getByMentionedToId$(
        String mentionedToId,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMentionMentionedToId,
        value: mentionedToId,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByMentionedToId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mention>> getByType$(
        MentionType type,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<MentionType>(
        getPropVal: getMentionType,
        value: type,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mention>> getByTaskId$(
        String taskId,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMentionTaskId,
        value: taskId,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByTaskId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mention>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMentionPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mention>> getByContent$(
        String content,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMentionContent,
        value: content,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByContent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mention>> getByIsRead$(
        bool isRead,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getMentionIsRead,
        value: isRead,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByIsRead,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mention>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMentionAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mention>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMentionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mention>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMentionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mention>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMentionDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mention>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Mention>? modelFilter,
        List<MentionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMentionUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: MentionEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Agency?> getAgency$(
    Mention mention, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (mention.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            mention.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            mention.Agency = Agency;
        });
    }
}

	Stream<User?> getMentionedBy$(
    Mention mention, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (mention.mentionedById == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            mention.mentionedById!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((mentionedBy) {
            mention.mentionedBy = mentionedBy;
        });
    }
}

	Stream<User?> getMentionedTo$(
    Mention mention, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (mention.mentionedToId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            mention.mentionedToId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((mentionedTo) {
            mention.mentionedTo = mentionedTo;
        });
    }
}

	Stream<Property?> getProperty$(
    Mention mention, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (mention.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            mention.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            mention.Property = Property;
        });
    }
}

	Stream<Task?> getTask$(
    Mention mention, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    if (mention.taskId == null) {
        return Stream.value(null);
    } else {
        return TaskStore.instance.getById$(
            mention.taskId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Task) {
            mention.Task = Task;
        });
    }
}

	Stream<User?> getUser$(
    Mention mention, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (mention.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            mention.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            mention.user = user;
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
Mention recursiveUpsert(Mention mention, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Mention'} 
        : const {};
    if (mention.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        mention.Agency = AgencyStore.instance.recursiveUpsert(mention.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mention.mentionedBy != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        mention.mentionedBy = UserStore.instance.recursiveUpsert(mention.mentionedBy!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mention.mentionedTo != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        mention.mentionedTo = UserStore.instance.recursiveUpsert(mention.mentionedTo!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mention.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        mention.Property = PropertyStore.instance.recursiveUpsert(mention.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mention.Task != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        mention.Task = TaskStore.instance.recursiveUpsert(mention.Task!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mention.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        mention.user = UserStore.instance.recursiveUpsert(mention.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(mention);
}

  List<Mention> recursiveListUpsert(List<Mention> mentions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMentions = <Mention>[];
    for (var mention in mentions) {
        updatedMentions.add(recursiveUpsert(mention, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMentions;
}

//   @override
//   Mention upsert(Mention item) {
//     return recursiveUpsert(item);
//   }

}


class MentionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MentionInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mention) => MentionStore.instance
            .getAgency$(mention, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mention) => MentionStore.instance
            .getAgency(mention, modelFilter: modelFilter, includes: includes);
      }
}

	MentionInclude.mentionedBy({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mention) => MentionStore.instance
            .getMentionedBy$(mention, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mention) => MentionStore.instance
            .getMentionedBy(mention, modelFilter: modelFilter, includes: includes);
      }
}

	MentionInclude.mentionedTo({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mention) => MentionStore.instance
            .getMentionedTo$(mention, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mention) => MentionStore.instance
            .getMentionedTo(mention, modelFilter: modelFilter, includes: includes);
      }
}

	MentionInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mention) => MentionStore.instance
            .getProperty$(mention, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mention) => MentionStore.instance
            .getProperty(mention, modelFilter: modelFilter, includes: includes);
      }
}

	MentionInclude.Task({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mention) => MentionStore.instance
            .getTask$(mention, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mention) => MentionStore.instance
            .getTask(mention, modelFilter: modelFilter, includes: includes);
      }
}

	MentionInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mention) => MentionStore.instance
            .getUser$(mention, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mention) => MentionStore.instance
            .getUser(mention, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MentionEndpoints implements Endpoint {

    getAll('/mention', HttpMethod.post, List<Mention>),
	getById('/mention/byId/:id', HttpMethod.post, Mention),
	getManyByMentionedById('/mention/byMentionedById/:mentionedById', HttpMethod.post, List<Mention>),
	getManyByMentionedToId('/mention/byMentionedToId/:mentionedToId', HttpMethod.post, List<Mention>),
	getManyByType('/mention/byType/:type', HttpMethod.post, List<Mention>),
	getManyByTaskId('/mention/byTaskId/:taskId', HttpMethod.post, List<Mention>),
	getManyByPropertyId('/mention/byPropertyId/:propertyId', HttpMethod.post, List<Mention>),
	getManyByContent('/mention/byContent/:content', HttpMethod.post, List<Mention>),
	getManyByIsRead('/mention/byIsRead/:isRead', HttpMethod.post, List<Mention>),
	getManyByAgencyId('/mention/byAgencyId/:agencyId', HttpMethod.post, List<Mention>),
	getManyByCreatedAt('/mention/byCreatedAt/:createdAt', HttpMethod.post, List<Mention>),
	getManyByUpdatedAt('/mention/byUpdatedAt/:updatedAt', HttpMethod.post, List<Mention>),
	getManyByDeletedAt('/mention/byDeletedAt/:deletedAt', HttpMethod.post, List<Mention>),
	getManyByUserId('/mention/byUserId/:userId', HttpMethod.post, List<Mention>);

    const MentionEndpoints(this.path, this.method, this.responseType);

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
