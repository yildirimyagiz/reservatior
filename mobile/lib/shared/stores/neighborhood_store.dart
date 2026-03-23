
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class NeighborhoodStore extends ModelStreamStore<String, Neighborhood> {

  static NeighborhoodStore? _instance;

  static NeighborhoodStore get instance {
    _instance ??= NeighborhoodStore();
    return _instance!;
  }

  NeighborhoodStore() : super(Neighborhood.fromJson) {
    if (_instance != null) {
        throw Exception(
            'NeighborhoodStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending NeighborhoodStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use NeighborhoodStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getNeighborhoodId(Neighborhood neighborhood) => neighborhood.id;

	String? getNeighborhoodOrgId(Neighborhood neighborhood) => neighborhood.orgId;

	String? getNeighborhoodName(Neighborhood neighborhood) => neighborhood.name;

	String? getNeighborhoodCity(Neighborhood neighborhood) => neighborhood.city;

	String? getNeighborhoodState(Neighborhood neighborhood) => neighborhood.state;

	String? getNeighborhoodZip(Neighborhood neighborhood) => neighborhood.zip;

	double? getNeighborhoodLat(Neighborhood neighborhood) => neighborhood.lat;

	double? getNeighborhoodLng(Neighborhood neighborhood) => neighborhood.lng;

	double? getNeighborhoodAvgPrice(Neighborhood neighborhood) => neighborhood.avgPrice;

	double? getNeighborhoodMedianPrice(Neighborhood neighborhood) => neighborhood.medianPrice;

	int? getNeighborhoodPropertyCount(Neighborhood neighborhood) => neighborhood.propertyCount;

	DateTime? getNeighborhoodCreatedAt(Neighborhood neighborhood) => neighborhood.createdAt;

	DateTime? getNeighborhoodUpdatedAt(Neighborhood neighborhood) => neighborhood.updatedAt;

	DateTime? getNeighborhoodDeletedAt(Neighborhood neighborhood) => neighborhood.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Neighborhood> getByOrgId(
    String orgId,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByName(
    String name,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodName, name, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByCity(
    String city,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodCity, city, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByState(
    String state,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodState, state, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByZip(
    String zip,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodZip, zip, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByLat(
    double lat,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodLat, lat, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByLng(
    double lng,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodLng, lng, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByAvgPrice(
    double avgPrice,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodAvgPrice, avgPrice, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByMedianPrice(
    double medianPrice,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodMedianPrice, medianPrice, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByPropertyCount(
    int propertyCount,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodPropertyCount, propertyCount, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Neighborhood> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}
    ) =>
    getManyIncluding(getNeighborhoodDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Neighborhood neighborhood, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (neighborhood.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(neighborhood.orgId!, includes: includes);
        neighborhood.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<Property> getProperties(
    Neighborhood neighborhood, {ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    final properties = PropertyStore.instance.getByNeighborhoodId(neighborhood.$uid!, modelFilter: modelFilter, includes: includes);
    neighborhood.properties = properties;
    // setIncludedReferencesForList(properties, includes: includes);
    return properties;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Neighborhood>> getAll$({bool useCache = true, ModelFilter<Neighborhood>? modelFilter, List<NeighborhoodInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: NeighborhoodEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Neighborhood?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getNeighborhoodId,
        value: id,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Neighborhood>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNeighborhoodOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNeighborhoodName,
        value: name,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByCity$(
        String city,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNeighborhoodCity,
        value: city,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByCity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByState$(
        String state,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNeighborhoodState,
        value: state,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByState,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByZip$(
        String zip,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getNeighborhoodZip,
        value: zip,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByZip,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByLat$(
        double lat,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getNeighborhoodLat,
        value: lat,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByLat,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByLng$(
        double lng,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getNeighborhoodLng,
        value: lng,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByLng,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByAvgPrice$(
        double avgPrice,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getNeighborhoodAvgPrice,
        value: avgPrice,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByAvgPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByMedianPrice$(
        double medianPrice,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getNeighborhoodMedianPrice,
        value: medianPrice,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByMedianPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByPropertyCount$(
        int propertyCount,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getNeighborhoodPropertyCount,
        value: propertyCount,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByPropertyCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getNeighborhoodCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getNeighborhoodUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Neighborhood>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Neighborhood>? modelFilter,
        List<NeighborhoodInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getNeighborhoodDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: NeighborhoodEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Neighborhood neighborhood, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (neighborhood.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            neighborhood.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            neighborhood.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Property>> getProperties$(
    Neighborhood neighborhood, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    return PropertyStore.instance.getByNeighborhoodId$(
        neighborhood.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((properties) {
        neighborhood.properties = properties;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Neighborhood recursiveUpsert(Neighborhood neighborhood, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Neighborhood'} 
        : const {};
    if (neighborhood.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        neighborhood.org = OrganizationStore.instance.recursiveUpsert(neighborhood.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (neighborhood.properties != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        neighborhood.properties = PropertyStore.instance.recursiveListUpsert(neighborhood.properties!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(neighborhood);
}

  List<Neighborhood> recursiveListUpsert(List<Neighborhood> neighborhoods, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedNeighborhoods = <Neighborhood>[];
    for (var neighborhood in neighborhoods) {
        updatedNeighborhoods.add(recursiveUpsert(neighborhood, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedNeighborhoods;
}

//   @override
//   Neighborhood upsert(Neighborhood item) {
//     return recursiveUpsert(item);
//   }

}


class NeighborhoodInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      NeighborhoodInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (neighborhood) => NeighborhoodStore.instance
            .getOrg$(neighborhood, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (neighborhood) => NeighborhoodStore.instance
            .getOrg(neighborhood, modelFilter: modelFilter, includes: includes);
      }
}

	NeighborhoodInclude.properties({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (neighborhood) => NeighborhoodStore.instance
            .getProperties$(neighborhood, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (neighborhood) => NeighborhoodStore.instance
            .getProperties(neighborhood, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum NeighborhoodEndpoints implements Endpoint {

    getAll('/neighborhood', HttpMethod.post, List<Neighborhood>),
	getById('/neighborhood/byId/:id', HttpMethod.post, Neighborhood),
	getManyByOrgId('/neighborhood/byOrgId/:orgId', HttpMethod.post, List<Neighborhood>),
	getManyByName('/neighborhood/byName/:name', HttpMethod.post, List<Neighborhood>),
	getManyByCity('/neighborhood/byCity/:city', HttpMethod.post, List<Neighborhood>),
	getManyByState('/neighborhood/byState/:state', HttpMethod.post, List<Neighborhood>),
	getManyByZip('/neighborhood/byZip/:zip', HttpMethod.post, List<Neighborhood>),
	getManyByLat('/neighborhood/byLat/:lat', HttpMethod.post, List<Neighborhood>),
	getManyByLng('/neighborhood/byLng/:lng', HttpMethod.post, List<Neighborhood>),
	getManyByAvgPrice('/neighborhood/byAvgPrice/:avgPrice', HttpMethod.post, List<Neighborhood>),
	getManyByMedianPrice('/neighborhood/byMedianPrice/:medianPrice', HttpMethod.post, List<Neighborhood>),
	getManyByPropertyCount('/neighborhood/byPropertyCount/:propertyCount', HttpMethod.post, List<Neighborhood>),
	getManyByCreatedAt('/neighborhood/byCreatedAt/:createdAt', HttpMethod.post, List<Neighborhood>),
	getManyByUpdatedAt('/neighborhood/byUpdatedAt/:updatedAt', HttpMethod.post, List<Neighborhood>),
	getManyByDeletedAt('/neighborhood/byDeletedAt/:deletedAt', HttpMethod.post, List<Neighborhood>);

    const NeighborhoodEndpoints(this.path, this.method, this.responseType);

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
