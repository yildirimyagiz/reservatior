
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class HashtagStore extends ModelStreamStore<String, Hashtag> {

  static HashtagStore? _instance;

  static HashtagStore get instance {
    _instance ??= HashtagStore();
    return _instance!;
  }

  HashtagStore() : super(Hashtag.fromJson) {
    if (_instance != null) {
        throw Exception(
            'HashtagStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending HashtagStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use HashtagStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  DateTime? getHashtagDeletedAt(Hashtag hashtag) => hashtag.deletedAt;

	String? getHashtagId(Hashtag hashtag) => hashtag.id;

	String? getHashtagName(Hashtag hashtag) => hashtag.name;

	HashtagType? getHashtagType(Hashtag hashtag) => hashtag.type;

	String? getHashtagDescription(Hashtag hashtag) => hashtag.description;

	int? getHashtagUsageCount(Hashtag hashtag) => hashtag.usageCount;

	List<String>? getHashtagRelatedTags(Hashtag hashtag) => hashtag.relatedTags;

	String? getHashtagCreatedById(Hashtag hashtag) => hashtag.createdById;

	String? getHashtagAgencyId(Hashtag hashtag) => hashtag.agencyId;

	DateTime? getHashtagCreatedAt(Hashtag hashtag) => hashtag.createdAt;

	DateTime? getHashtagUpdatedAt(Hashtag hashtag) => hashtag.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Hashtag? getByName(
    String name,
    {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}
    ) =>
    getIncluding(getHashtagName, name, modelFilter: modelFilter, includes: includes);

  
List<Hashtag> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}
    ) =>
    getManyIncluding(getHashtagDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Hashtag> getByType(
    HashtagType type,
    {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}
    ) =>
    getManyIncluding(getHashtagType, type, modelFilter: modelFilter, includes: includes);

	
List<Hashtag> getByDescription(
    String description,
    {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}
    ) =>
    getManyIncluding(getHashtagDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Hashtag> getByUsageCount(
    int usageCount,
    {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}
    ) =>
    getManyIncluding(getHashtagUsageCount, usageCount, modelFilter: modelFilter, includes: includes);

	
List<Hashtag> getByRelatedTags(
    String relatedTags,
    {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}
    ) =>
    getManyIncluding(getHashtagRelatedTags, relatedTags, modelFilter: modelFilter, includes: includes);

	
List<Hashtag> getByCreatedById(
    String createdById,
    {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}
    ) =>
    getManyIncluding(getHashtagCreatedById, createdById, modelFilter: modelFilter, includes: includes);

	
List<Hashtag> getByAgencyId(
    String agencyId,
    {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}
    ) =>
    getManyIncluding(getHashtagAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<Hashtag> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}
    ) =>
    getManyIncluding(getHashtagCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Hashtag> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}
    ) =>
    getManyIncluding(getHashtagUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Agency? getAgency(
    Hashtag hashtag, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (hashtag.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(hashtag.agencyId!, includes: includes);
        hashtag.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

	User? getUser(
    Hashtag hashtag, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (hashtag.createdById == null) {
        return null;
    } else {
        final User = UserStore.instance.getById(hashtag.createdById!, includes: includes);
        hashtag.User = User;
        // setIncludedReferences(User, includes: includes);
        return User;
    }
}

  /// GET RELATED MODELS 

  List<Post> getPost(
    Hashtag hashtag, {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}) {
    final Post = PostStore.instance.getByHashtagId(hashtag.$uid!, modelFilter: modelFilter, includes: includes);
    hashtag.Post = Post;
    // setIncludedReferencesForList(Post, includes: includes);
    return Post;
}

	List<Property> getProperty(
    Hashtag hashtag, {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    final Property = PropertyStore.instance.getBy(hashtag.$uid!, modelFilter: modelFilter, includes: includes);
    hashtag.Property = Property;
    // setIncludedReferencesForList(Property, includes: includes);
    return Property;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Hashtag>> getAll$({bool useCache = true, ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: HashtagEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Hashtag?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Hashtag>? modelFilter,
        List<HashtagInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getHashtagId,
        value: id,
        modelFilter: modelFilter,
        endpoint: HashtagEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Hashtag?> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Hashtag>? modelFilter,
        List<HashtagInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getHashtagName,
        value: name,
        modelFilter: modelFilter,
        endpoint: HashtagEndpoints.getByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Hashtag>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Hashtag>? modelFilter,
        List<HashtagInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getHashtagDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: HashtagEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Hashtag>> getByType$(
        HashtagType type,
        {bool useCache = true,
        ModelFilter<Hashtag>? modelFilter,
        List<HashtagInclude>? includes}) {
    final items$ = getManyByFieldValue$<HashtagType>(
        getPropVal: getHashtagType,
        value: type,
        modelFilter: modelFilter,
        endpoint: HashtagEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Hashtag>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Hashtag>? modelFilter,
        List<HashtagInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHashtagDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: HashtagEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Hashtag>> getByUsageCount$(
        int usageCount,
        {bool useCache = true,
        ModelFilter<Hashtag>? modelFilter,
        List<HashtagInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getHashtagUsageCount,
        value: usageCount,
        modelFilter: modelFilter,
        endpoint: HashtagEndpoints.getManyByUsageCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Hashtag>> getByRelatedTags$(
        String relatedTags,
        {bool useCache = true,
        ModelFilter<Hashtag>? modelFilter,
        List<HashtagInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHashtagRelatedTags,
        value: relatedTags,
        modelFilter: modelFilter,
        endpoint: HashtagEndpoints.getManyByRelatedTags,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Hashtag>> getByCreatedById$(
        String createdById,
        {bool useCache = true,
        ModelFilter<Hashtag>? modelFilter,
        List<HashtagInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHashtagCreatedById,
        value: createdById,
        modelFilter: modelFilter,
        endpoint: HashtagEndpoints.getManyByCreatedById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Hashtag>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<Hashtag>? modelFilter,
        List<HashtagInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHashtagAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: HashtagEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Hashtag>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Hashtag>? modelFilter,
        List<HashtagInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getHashtagCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: HashtagEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Hashtag>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Hashtag>? modelFilter,
        List<HashtagInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getHashtagUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: HashtagEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Agency?> getAgency$(
    Hashtag hashtag, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (hashtag.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            hashtag.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            hashtag.Agency = Agency;
        });
    }
}

	Stream<User?> getUser$(
    Hashtag hashtag, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (hashtag.createdById == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            hashtag.createdById!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((User) {
            hashtag.User = User;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Post>> getPost$(
    Hashtag hashtag, {bool useCache = true, ModelFilter<Post>? modelFilter, List<PostInclude>? includes}) {
    return PostStore.instance.getByHashtagId$(
        hashtag.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Post) {
        hashtag.Post = Post;
    });

}

	Stream<List<Property>> getProperty$(
    Hashtag hashtag, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    return PropertyStore.instance.getBy$(
        hashtag.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Property) {
        hashtag.Property = Property;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Hashtag recursiveUpsert(Hashtag hashtag, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Hashtag'} 
        : const {};
    if (hashtag.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        hashtag.Agency = AgencyStore.instance.recursiveUpsert(hashtag.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (hashtag.User != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        hashtag.User = UserStore.instance.recursiveUpsert(hashtag.User!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (hashtag.Post != null && (!preventCircularSerialization || !upsertedTypes.contains('Post'))) {
        hashtag.Post = PostStore.instance.recursiveListUpsert(hashtag.Post!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (hashtag.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        hashtag.Property = PropertyStore.instance.recursiveListUpsert(hashtag.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(hashtag);
}

  List<Hashtag> recursiveListUpsert(List<Hashtag> hashtags, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedHashtags = <Hashtag>[];
    for (var hashtag in hashtags) {
        updatedHashtags.add(recursiveUpsert(hashtag, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedHashtags;
}

//   @override
//   Hashtag upsert(Hashtag item) {
//     return recursiveUpsert(item);
//   }

}


class HashtagInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      HashtagInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (hashtag) => HashtagStore.instance
            .getAgency$(hashtag, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (hashtag) => HashtagStore.instance
            .getAgency(hashtag, modelFilter: modelFilter, includes: includes);
      }
}

	HashtagInclude.User({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (hashtag) => HashtagStore.instance
            .getUser$(hashtag, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (hashtag) => HashtagStore.instance
            .getUser(hashtag, modelFilter: modelFilter, includes: includes);
      }
}

	HashtagInclude.Post({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Post>? modelFilter,
    List<PostInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (hashtag) => HashtagStore.instance
            .getPost$(hashtag, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (hashtag) => HashtagStore.instance
            .getPost(hashtag, modelFilter: modelFilter, includes: includes);
      }
}

	HashtagInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (hashtag) => HashtagStore.instance
            .getProperty$(hashtag, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (hashtag) => HashtagStore.instance
            .getProperty(hashtag, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum HashtagEndpoints implements Endpoint {

    getAll('/hashtag', HttpMethod.post, List<Hashtag>),
	getManyByDeletedAt('/hashtag/byDeletedAt/:deletedAt', HttpMethod.post, List<Hashtag>),
	getById('/hashtag/byId/:id', HttpMethod.post, Hashtag),
	getByName('/hashtag/byName/:name', HttpMethod.post, Hashtag),
	getManyByType('/hashtag/byType/:type', HttpMethod.post, List<Hashtag>),
	getManyByDescription('/hashtag/byDescription/:description', HttpMethod.post, List<Hashtag>),
	getManyByUsageCount('/hashtag/byUsageCount/:usageCount', HttpMethod.post, List<Hashtag>),
	getManyByRelatedTags('/hashtag/byRelatedTags/:relatedTags', HttpMethod.post, List<Hashtag>),
	getManyByCreatedById('/hashtag/byCreatedById/:createdById', HttpMethod.post, List<Hashtag>),
	getManyByAgencyId('/hashtag/byAgencyId/:agencyId', HttpMethod.post, List<Hashtag>),
	getManyByCreatedAt('/hashtag/byCreatedAt/:createdAt', HttpMethod.post, List<Hashtag>),
	getManyByUpdatedAt('/hashtag/byUpdatedAt/:updatedAt', HttpMethod.post, List<Hashtag>);

    const HashtagEndpoints(this.path, this.method, this.responseType);

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
