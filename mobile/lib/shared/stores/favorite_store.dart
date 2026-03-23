
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class FavoriteStore extends ModelStreamStore<String, Favorite> {

  static FavoriteStore? _instance;

  static FavoriteStore get instance {
    _instance ??= FavoriteStore();
    return _instance!;
  }

  FavoriteStore() : super(Favorite.fromJson) {
    if (_instance != null) {
        throw Exception(
            'FavoriteStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending FavoriteStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use FavoriteStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getFavoriteId(Favorite favorite) => favorite.id;

	String? getFavoriteUserId(Favorite favorite) => favorite.userId;

	String? getFavoritePropertyId(Favorite favorite) => favorite.propertyId;

	DateTime? getFavoriteCreatedAt(Favorite favorite) => favorite.createdAt;

	DateTime? getFavoriteUpdatedAt(Favorite favorite) => favorite.updatedAt;

	DateTime? getFavoriteDeletedAt(Favorite favorite) => favorite.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Favorite> getByUserId(
    String userId,
    {ModelFilter<Favorite>? modelFilter, List<FavoriteInclude>? includes}
    ) =>
    getManyIncluding(getFavoriteUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Favorite> getByPropertyId(
    String propertyId,
    {ModelFilter<Favorite>? modelFilter, List<FavoriteInclude>? includes}
    ) =>
    getManyIncluding(getFavoritePropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Favorite> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Favorite>? modelFilter, List<FavoriteInclude>? includes}
    ) =>
    getManyIncluding(getFavoriteCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Favorite> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Favorite>? modelFilter, List<FavoriteInclude>? includes}
    ) =>
    getManyIncluding(getFavoriteUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Favorite> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Favorite>? modelFilter, List<FavoriteInclude>? includes}
    ) =>
    getManyIncluding(getFavoriteDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Property? getProperty(
    Favorite favorite, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (favorite.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(favorite.propertyId!, includes: includes);
        favorite.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

	User? getUser(
    Favorite favorite, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (favorite.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(favorite.userId!, includes: includes);
        favorite.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Favorite>> getAll$({bool useCache = true, ModelFilter<Favorite>? modelFilter, List<FavoriteInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: FavoriteEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Favorite?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Favorite>? modelFilter,
        List<FavoriteInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getFavoriteId,
        value: id,
        modelFilter: modelFilter,
        endpoint: FavoriteEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Favorite>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Favorite>? modelFilter,
        List<FavoriteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFavoriteUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: FavoriteEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Favorite>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Favorite>? modelFilter,
        List<FavoriteInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFavoritePropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: FavoriteEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Favorite>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Favorite>? modelFilter,
        List<FavoriteInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFavoriteCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: FavoriteEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Favorite>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Favorite>? modelFilter,
        List<FavoriteInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFavoriteUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: FavoriteEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Favorite>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Favorite>? modelFilter,
        List<FavoriteInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFavoriteDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: FavoriteEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Property?> getProperty$(
    Favorite favorite, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (favorite.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            favorite.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            favorite.property = property;
        });
    }
}

	Stream<User?> getUser$(
    Favorite favorite, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (favorite.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            favorite.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            favorite.user = user;
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
Favorite recursiveUpsert(Favorite favorite, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Favorite'} 
        : const {};
    if (favorite.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        favorite.property = PropertyStore.instance.recursiveUpsert(favorite.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (favorite.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        favorite.user = UserStore.instance.recursiveUpsert(favorite.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(favorite);
}

  List<Favorite> recursiveListUpsert(List<Favorite> favorites, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedFavorites = <Favorite>[];
    for (var favorite in favorites) {
        updatedFavorites.add(recursiveUpsert(favorite, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedFavorites;
}

//   @override
//   Favorite upsert(Favorite item) {
//     return recursiveUpsert(item);
//   }

}


class FavoriteInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      FavoriteInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (favorite) => FavoriteStore.instance
            .getProperty$(favorite, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (favorite) => FavoriteStore.instance
            .getProperty(favorite, modelFilter: modelFilter, includes: includes);
      }
}

	FavoriteInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (favorite) => FavoriteStore.instance
            .getUser$(favorite, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (favorite) => FavoriteStore.instance
            .getUser(favorite, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum FavoriteEndpoints implements Endpoint {

    getAll('/favorite', HttpMethod.post, List<Favorite>),
	getById('/favorite/byId/:id', HttpMethod.post, Favorite),
	getManyByUserId('/favorite/byUserId/:userId', HttpMethod.post, List<Favorite>),
	getManyByPropertyId('/favorite/byPropertyId/:propertyId', HttpMethod.post, List<Favorite>),
	getManyByCreatedAt('/favorite/byCreatedAt/:createdAt', HttpMethod.post, List<Favorite>),
	getManyByUpdatedAt('/favorite/byUpdatedAt/:updatedAt', HttpMethod.post, List<Favorite>),
	getManyByDeletedAt('/favorite/byDeletedAt/:deletedAt', HttpMethod.post, List<Favorite>);

    const FavoriteEndpoints(this.path, this.method, this.responseType);

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
