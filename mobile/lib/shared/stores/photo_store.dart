
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PhotoStore extends ModelStreamStore<String, Photo> {

  static PhotoStore? _instance;

  static PhotoStore get instance {
    _instance ??= PhotoStore();
    return _instance!;
  }

  PhotoStore() : super(Photo.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PhotoStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PhotoStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PhotoStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPhotoId(Photo photo) => photo.id;

	String? getPhotoUrl(Photo photo) => photo.url;

	String? getPhotoOriginalName(Photo photo) => photo.originalName;

	String? getPhotoFilename(Photo photo) => photo.filename;

	PhotoType? getPhotoType(Photo photo) => photo.type;

	String? getPhotoCaption(Photo photo) => photo.caption;

	String? getPhotoAlt(Photo photo) => photo.alt;

	String? getPhotoSrc(Photo photo) => photo.src;

	bool? getPhotoFeatured(Photo photo) => photo.featured;

	int? getPhotoWidth(Photo photo) => photo.width;

	int? getPhotoHeight(Photo photo) => photo.height;

	int? getPhotoFileSize(Photo photo) => photo.fileSize;

	String? getPhotoMimeType(Photo photo) => photo.mimeType;

	String? getPhotoDominantColor(Photo photo) => photo.dominantColor;

	dynamic? getPhotoMlMetadata(Photo photo) => photo.mlMetadata;

	DateTime? getPhotoCreatedAt(Photo photo) => photo.createdAt;

	DateTime? getPhotoUpdatedAt(Photo photo) => photo.updatedAt;

	DateTime? getPhotoDeletedAt(Photo photo) => photo.deletedAt;

	String? getPhotoUserId(Photo photo) => photo.userId;

	String? getPhotoAgencyId(Photo photo) => photo.agencyId;

	String? getPhotoPropertyId(Photo photo) => photo.propertyId;

	String? getPhotoAgentId(Photo photo) => photo.agentId;

	String? getPhotoPostId(Photo photo) => photo.postId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Photo? getByUrl(
    String url,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getIncluding(getPhotoUrl, url, modelFilter: modelFilter, includes: includes);

  
List<Photo> getByOriginalName(
    String originalName,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoOriginalName, originalName, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByFilename(
    String filename,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoFilename, filename, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByType(
    PhotoType type,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoType, type, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByCaption(
    String caption,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoCaption, caption, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByAlt(
    String alt,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoAlt, alt, modelFilter: modelFilter, includes: includes);

	
List<Photo> getBySrc(
    String src,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoSrc, src, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByFeatured(
    bool featured,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoFeatured, featured, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByWidth(
    int width,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoWidth, width, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByHeight(
    int height,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoHeight, height, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByFileSize(
    int fileSize,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoFileSize, fileSize, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByMimeType(
    String mimeType,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoMimeType, mimeType, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByDominantColor(
    String dominantColor,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoDominantColor, dominantColor, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByMlMetadata(
    dynamic mlMetadata,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoMlMetadata, mlMetadata, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByUserId(
    String userId,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByAgencyId(
    String agencyId,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByPropertyId(
    String propertyId,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByAgentId(
    String agentId,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoAgentId, agentId, modelFilter: modelFilter, includes: includes);

	
List<Photo> getByPostId(
    String postId,
    {ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}
    ) =>
    getManyIncluding(getPhotoPostId, postId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Agency? getAgency(
    Photo photo, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (photo.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(photo.agencyId!, includes: includes);
        photo.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

	Agent? getAgent(
    Photo photo, {ModelFilter? modelFilter, List<AgentInclude>? includes}) {
    if (photo.agentId == null) {
        return null;
    } else {
        final Agent = AgentStore.instance.getById(photo.agentId!, includes: includes);
        photo.Agent = Agent;
        // setIncludedReferences(Agent, includes: includes);
        return Agent;
    }
}

	Post? getPost(
    Photo photo, {ModelFilter? modelFilter, List<PostInclude>? includes}) {
    if (photo.postId == null) {
        return null;
    } else {
        final Post = PostStore.instance.getById(photo.postId!, includes: includes);
        photo.Post = Post;
        // setIncludedReferences(Post, includes: includes);
        return Post;
    }
}

	Property? getProperty(
    Photo photo, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (photo.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(photo.propertyId!, includes: includes);
        photo.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

	User? getUser(
    Photo photo, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (photo.userId == null) {
        return null;
    } else {
        final User = UserStore.instance.getById(photo.userId!, includes: includes);
        photo.User = User;
        // setIncludedReferences(User, includes: includes);
        return User;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Photo>> getAll$({bool useCache = true, ModelFilter<Photo>? modelFilter, List<PhotoInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PhotoEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Photo?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPhotoId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Photo?> getByUrl$(
        String url,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPhotoUrl,
        value: url,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getByUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Photo>> getByOriginalName$(
        String originalName,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoOriginalName,
        value: originalName,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByOriginalName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByFilename$(
        String filename,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoFilename,
        value: filename,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByFilename,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByType$(
        PhotoType type,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<PhotoType>(
        getPropVal: getPhotoType,
        value: type,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByCaption$(
        String caption,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoCaption,
        value: caption,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByCaption,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByAlt$(
        String alt,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoAlt,
        value: alt,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByAlt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getBySrc$(
        String src,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoSrc,
        value: src,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyBySrc,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByFeatured$(
        bool featured,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPhotoFeatured,
        value: featured,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByFeatured,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByWidth$(
        int width,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPhotoWidth,
        value: width,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByWidth,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByHeight$(
        int height,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPhotoHeight,
        value: height,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByHeight,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByFileSize$(
        int fileSize,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPhotoFileSize,
        value: fileSize,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByFileSize,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByMimeType$(
        String mimeType,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoMimeType,
        value: mimeType,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByMimeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByDominantColor$(
        String dominantColor,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoDominantColor,
        value: dominantColor,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByDominantColor,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByMlMetadata$(
        dynamic mlMetadata,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPhotoMlMetadata,
        value: mlMetadata,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByMlMetadata,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPhotoCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPhotoUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPhotoDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByAgentId$(
        String agentId,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoAgentId,
        value: agentId,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByAgentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Photo>> getByPostId$(
        String postId,
        {bool useCache = true,
        ModelFilter<Photo>? modelFilter,
        List<PhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPhotoPostId,
        value: postId,
        modelFilter: modelFilter,
        endpoint: PhotoEndpoints.getManyByPostId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Agency?> getAgency$(
    Photo photo, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (photo.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            photo.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            photo.Agency = Agency;
        });
    }
}

	Stream<Agent?> getAgent$(
    Photo photo, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    if (photo.agentId == null) {
        return Stream.value(null);
    } else {
        return AgentStore.instance.getById$(
            photo.agentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agent) {
            photo.Agent = Agent;
        });
    }
}

	Stream<Post?> getPost$(
    Photo photo, {bool useCache = true, ModelFilter<Post>? modelFilter, List<PostInclude>? includes}) {
    if (photo.postId == null) {
        return Stream.value(null);
    } else {
        return PostStore.instance.getById$(
            photo.postId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Post) {
            photo.Post = Post;
        });
    }
}

	Stream<Property?> getProperty$(
    Photo photo, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (photo.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            photo.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            photo.Property = Property;
        });
    }
}

	Stream<User?> getUser$(
    Photo photo, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (photo.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            photo.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((User) {
            photo.User = User;
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
Photo recursiveUpsert(Photo photo, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Photo'} 
        : const {};
    if (photo.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        photo.Agency = AgencyStore.instance.recursiveUpsert(photo.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (photo.Agent != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        photo.Agent = AgentStore.instance.recursiveUpsert(photo.Agent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (photo.Post != null && (!preventCircularSerialization || !upsertedTypes.contains('Post'))) {
        photo.Post = PostStore.instance.recursiveUpsert(photo.Post!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (photo.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        photo.Property = PropertyStore.instance.recursiveUpsert(photo.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (photo.User != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        photo.User = UserStore.instance.recursiveUpsert(photo.User!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(photo);
}

  List<Photo> recursiveListUpsert(List<Photo> photos, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPhotos = <Photo>[];
    for (var photo in photos) {
        updatedPhotos.add(recursiveUpsert(photo, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPhotos;
}

//   @override
//   Photo upsert(Photo item) {
//     return recursiveUpsert(item);
//   }

}


class PhotoInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PhotoInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (photo) => PhotoStore.instance
            .getAgency$(photo, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (photo) => PhotoStore.instance
            .getAgency(photo, modelFilter: modelFilter, includes: includes);
      }
}

	PhotoInclude.Agent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (photo) => PhotoStore.instance
            .getAgent$(photo, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (photo) => PhotoStore.instance
            .getAgent(photo, modelFilter: modelFilter, includes: includes);
      }
}

	PhotoInclude.Post({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Post>? modelFilter,
    List<PostInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (photo) => PhotoStore.instance
            .getPost$(photo, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (photo) => PhotoStore.instance
            .getPost(photo, modelFilter: modelFilter, includes: includes);
      }
}

	PhotoInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (photo) => PhotoStore.instance
            .getProperty$(photo, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (photo) => PhotoStore.instance
            .getProperty(photo, modelFilter: modelFilter, includes: includes);
      }
}

	PhotoInclude.User({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (photo) => PhotoStore.instance
            .getUser$(photo, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (photo) => PhotoStore.instance
            .getUser(photo, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PhotoEndpoints implements Endpoint {

    getAll('/photo', HttpMethod.post, List<Photo>),
	getById('/photo/byId/:id', HttpMethod.post, Photo),
	getByUrl('/photo/byUrl/:url', HttpMethod.post, Photo),
	getManyByOriginalName('/photo/byOriginalName/:originalName', HttpMethod.post, List<Photo>),
	getManyByFilename('/photo/byFilename/:filename', HttpMethod.post, List<Photo>),
	getManyByType('/photo/byType/:type', HttpMethod.post, List<Photo>),
	getManyByCaption('/photo/byCaption/:caption', HttpMethod.post, List<Photo>),
	getManyByAlt('/photo/byAlt/:alt', HttpMethod.post, List<Photo>),
	getManyBySrc('/photo/bySrc/:src', HttpMethod.post, List<Photo>),
	getManyByFeatured('/photo/byFeatured/:featured', HttpMethod.post, List<Photo>),
	getManyByWidth('/photo/byWidth/:width', HttpMethod.post, List<Photo>),
	getManyByHeight('/photo/byHeight/:height', HttpMethod.post, List<Photo>),
	getManyByFileSize('/photo/byFileSize/:fileSize', HttpMethod.post, List<Photo>),
	getManyByMimeType('/photo/byMimeType/:mimeType', HttpMethod.post, List<Photo>),
	getManyByDominantColor('/photo/byDominantColor/:dominantColor', HttpMethod.post, List<Photo>),
	getManyByMlMetadata('/photo/byMlMetadata/:mlMetadata', HttpMethod.post, List<Photo>),
	getManyByCreatedAt('/photo/byCreatedAt/:createdAt', HttpMethod.post, List<Photo>),
	getManyByUpdatedAt('/photo/byUpdatedAt/:updatedAt', HttpMethod.post, List<Photo>),
	getManyByDeletedAt('/photo/byDeletedAt/:deletedAt', HttpMethod.post, List<Photo>),
	getManyByUserId('/photo/byUserId/:userId', HttpMethod.post, List<Photo>),
	getManyByAgencyId('/photo/byAgencyId/:agencyId', HttpMethod.post, List<Photo>),
	getManyByPropertyId('/photo/byPropertyId/:propertyId', HttpMethod.post, List<Photo>),
	getManyByAgentId('/photo/byAgentId/:agentId', HttpMethod.post, List<Photo>),
	getManyByPostId('/photo/byPostId/:postId', HttpMethod.post, List<Photo>);

    const PhotoEndpoints(this.path, this.method, this.responseType);

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
