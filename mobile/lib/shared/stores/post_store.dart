
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PostStore extends ModelStreamStore<String, Post> {

  static PostStore? _instance;

  static PostStore get instance {
    _instance ??= PostStore();
    return _instance!;
  }

  PostStore() : super(Post.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PostStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PostStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PostStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  DateTime? getPostDeletedAt(Post post) => post.deletedAt;

	String? getPostId(Post post) => post.id;

	String? getPostTitle(Post post) => post.title;

	String? getPostContent(Post post) => post.content;

	String? getPostSlug(Post post) => post.slug;

	DateTime? getPostCreatedAt(Post post) => post.createdAt;

	DateTime? getPostUpdatedAt(Post post) => post.updatedAt;

	String? getPostUserId(Post post) => post.userId;

	String? getPostAgencyId(Post post) => post.agencyId;

	String? getPostHashtagId(Post post) => post.hashtagId;

	String? getPostAgentId(Post post) => post.agentId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Post> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}
    ) =>
    getManyIncluding(getPostDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Post> getByTitle(
    String title,
    {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}
    ) =>
    getManyIncluding(getPostTitle, title, modelFilter: modelFilter, includes: includes);

	
List<Post> getByContent(
    String content,
    {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}
    ) =>
    getManyIncluding(getPostContent, content, modelFilter: modelFilter, includes: includes);

	
List<Post> getBySlug(
    String slug,
    {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}
    ) =>
    getManyIncluding(getPostSlug, slug, modelFilter: modelFilter, includes: includes);

	
List<Post> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}
    ) =>
    getManyIncluding(getPostCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Post> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}
    ) =>
    getManyIncluding(getPostUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Post> getByUserId(
    String userId,
    {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}
    ) =>
    getManyIncluding(getPostUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Post> getByAgencyId(
    String agencyId,
    {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}
    ) =>
    getManyIncluding(getPostAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<Post> getByHashtagId(
    String hashtagId,
    {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}
    ) =>
    getManyIncluding(getPostHashtagId, hashtagId, modelFilter: modelFilter, includes: includes);

	
List<Post> getByAgentId(
    String agentId,
    {ModelFilter<Post>? modelFilter, List<PostInclude>? includes}
    ) =>
    getManyIncluding(getPostAgentId, agentId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Agency? getAgency(
    Post post, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (post.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(post.agencyId!, includes: includes);
        post.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

	Agent? getAgent(
    Post post, {ModelFilter? modelFilter, List<AgentInclude>? includes}) {
    if (post.agentId == null) {
        return null;
    } else {
        final Agent = AgentStore.instance.getById(post.agentId!, includes: includes);
        post.Agent = Agent;
        // setIncludedReferences(Agent, includes: includes);
        return Agent;
    }
}

	Hashtag? getHashtag(
    Post post, {ModelFilter? modelFilter, List<HashtagInclude>? includes}) {
    if (post.hashtagId == null) {
        return null;
    } else {
        final Hashtag = HashtagStore.instance.getById(post.hashtagId!, includes: includes);
        post.Hashtag = Hashtag;
        // setIncludedReferences(Hashtag, includes: includes);
        return Hashtag;
    }
}

	User? getUser(
    Post post, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (post.userId == null) {
        return null;
    } else {
        final User = UserStore.instance.getById(post.userId!, includes: includes);
        post.User = User;
        // setIncludedReferences(User, includes: includes);
        return User;
    }
}

  /// GET RELATED MODELS 

  List<Photo> getPhoto(
    Post post, {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}) {
    final Photo = PhotoStore.instance.getByPostId(post.$uid!, modelFilter: modelFilter, includes: includes);
    post.Photo = Photo;
    // setIncludedReferencesForList(Photo, includes: includes);
    return Photo;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Post>> getAll$({bool useCache = true, ModelFilter<Post>? modelFilter, List<PostInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PostEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Post?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Post>? modelFilter,
        List<PostInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPostId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PostEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Post>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Post>? modelFilter,
        List<PostInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPostDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PostEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Post>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<Post>? modelFilter,
        List<PostInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPostTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: PostEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Post>> getByContent$(
        String content,
        {bool useCache = true,
        ModelFilter<Post>? modelFilter,
        List<PostInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPostContent,
        value: content,
        modelFilter: modelFilter,
        endpoint: PostEndpoints.getManyByContent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Post>> getBySlug$(
        String slug,
        {bool useCache = true,
        ModelFilter<Post>? modelFilter,
        List<PostInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPostSlug,
        value: slug,
        modelFilter: modelFilter,
        endpoint: PostEndpoints.getManyBySlug,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Post>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Post>? modelFilter,
        List<PostInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPostCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PostEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Post>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Post>? modelFilter,
        List<PostInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPostUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PostEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Post>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Post>? modelFilter,
        List<PostInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPostUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: PostEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Post>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<Post>? modelFilter,
        List<PostInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPostAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: PostEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Post>> getByHashtagId$(
        String hashtagId,
        {bool useCache = true,
        ModelFilter<Post>? modelFilter,
        List<PostInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPostHashtagId,
        value: hashtagId,
        modelFilter: modelFilter,
        endpoint: PostEndpoints.getManyByHashtagId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Post>> getByAgentId$(
        String agentId,
        {bool useCache = true,
        ModelFilter<Post>? modelFilter,
        List<PostInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPostAgentId,
        value: agentId,
        modelFilter: modelFilter,
        endpoint: PostEndpoints.getManyByAgentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Agency?> getAgency$(
    Post post, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (post.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            post.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            post.Agency = Agency;
        });
    }
}

	Stream<Agent?> getAgent$(
    Post post, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    if (post.agentId == null) {
        return Stream.value(null);
    } else {
        return AgentStore.instance.getById$(
            post.agentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agent) {
            post.Agent = Agent;
        });
    }
}

	Stream<Hashtag?> getHashtag$(
    Post post, {bool useCache = true, ModelFilter<Hashtag>? modelFilter, List<HashtagInclude>? includes}) {
    if (post.hashtagId == null) {
        return Stream.value(null);
    } else {
        return HashtagStore.instance.getById$(
            post.hashtagId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Hashtag) {
            post.Hashtag = Hashtag;
        });
    }
}

	Stream<User?> getUser$(
    Post post, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (post.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            post.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((User) {
            post.User = User;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Photo>> getPhoto$(
    Post post, {bool useCache = true, ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}) {
    return PhotoStore.instance.getByPostId$(
        post.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Photo) {
        post.Photo = Photo;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Post recursiveUpsert(Post post, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Post'} 
        : const {};
    if (post.Photo != null && (!preventCircularSerialization || !upsertedTypes.contains('Photo'))) {
        post.Photo = PhotoStore.instance.recursiveListUpsert(post.Photo!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (post.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        post.Agency = AgencyStore.instance.recursiveUpsert(post.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (post.Agent != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        post.Agent = AgentStore.instance.recursiveUpsert(post.Agent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (post.Hashtag != null && (!preventCircularSerialization || !upsertedTypes.contains('Hashtag'))) {
        post.Hashtag = HashtagStore.instance.recursiveUpsert(post.Hashtag!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (post.User != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        post.User = UserStore.instance.recursiveUpsert(post.User!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(post);
}

  List<Post> recursiveListUpsert(List<Post> posts, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPosts = <Post>[];
    for (var post in posts) {
        updatedPosts.add(recursiveUpsert(post, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPosts;
}

//   @override
//   Post upsert(Post item) {
//     return recursiveUpsert(item);
//   }

}


class PostInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PostInclude.Photo({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Photo>? modelFilter,
    List<PhotoInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (post) => PostStore.instance
            .getPhoto$(post, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (post) => PostStore.instance
            .getPhoto(post, modelFilter: modelFilter, includes: includes);
      }
}

	PostInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (post) => PostStore.instance
            .getAgency$(post, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (post) => PostStore.instance
            .getAgency(post, modelFilter: modelFilter, includes: includes);
      }
}

	PostInclude.Agent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (post) => PostStore.instance
            .getAgent$(post, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (post) => PostStore.instance
            .getAgent(post, modelFilter: modelFilter, includes: includes);
      }
}

	PostInclude.Hashtag({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Hashtag>? modelFilter,
    List<HashtagInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (post) => PostStore.instance
            .getHashtag$(post, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (post) => PostStore.instance
            .getHashtag(post, modelFilter: modelFilter, includes: includes);
      }
}

	PostInclude.User({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (post) => PostStore.instance
            .getUser$(post, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (post) => PostStore.instance
            .getUser(post, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PostEndpoints implements Endpoint {

    getAll('/post', HttpMethod.post, List<Post>),
	getManyByDeletedAt('/post/byDeletedAt/:deletedAt', HttpMethod.post, List<Post>),
	getById('/post/byId/:id', HttpMethod.post, Post),
	getManyByTitle('/post/byTitle/:title', HttpMethod.post, List<Post>),
	getManyByContent('/post/byContent/:content', HttpMethod.post, List<Post>),
	getManyBySlug('/post/bySlug/:slug', HttpMethod.post, List<Post>),
	getManyByCreatedAt('/post/byCreatedAt/:createdAt', HttpMethod.post, List<Post>),
	getManyByUpdatedAt('/post/byUpdatedAt/:updatedAt', HttpMethod.post, List<Post>),
	getManyByUserId('/post/byUserId/:userId', HttpMethod.post, List<Post>),
	getManyByAgencyId('/post/byAgencyId/:agencyId', HttpMethod.post, List<Post>),
	getManyByHashtagId('/post/byHashtagId/:hashtagId', HttpMethod.post, List<Post>),
	getManyByAgentId('/post/byAgentId/:agentId', HttpMethod.post, List<Post>);

    const PostEndpoints(this.path, this.method, this.responseType);

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
