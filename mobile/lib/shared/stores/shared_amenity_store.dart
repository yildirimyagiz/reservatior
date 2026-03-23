
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class SharedAmenityStore extends ModelStreamStore<String, SharedAmenity> {

  static SharedAmenityStore? _instance;

  static SharedAmenityStore get instance {
    _instance ??= SharedAmenityStore();
    return _instance!;
  }

  SharedAmenityStore() : super(SharedAmenity.fromJson) {
    if (_instance != null) {
        throw Exception(
            'SharedAmenityStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending SharedAmenityStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use SharedAmenityStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getSharedAmenityId(SharedAmenity sharedAmenity) => sharedAmenity.id;

	String? getSharedAmenityFacilityId(SharedAmenity sharedAmenity) => sharedAmenity.facilityId;

	String? getSharedAmenityName(SharedAmenity sharedAmenity) => sharedAmenity.name;

	SharedAmenityType? getSharedAmenityType(SharedAmenity sharedAmenity) => sharedAmenity.type;

	String? getSharedAmenityDescription(SharedAmenity sharedAmenity) => sharedAmenity.description;

	String? getSharedAmenityLocation(SharedAmenity sharedAmenity) => sharedAmenity.location;

	int? getSharedAmenityCapacity(SharedAmenity sharedAmenity) => sharedAmenity.capacity;

	bool? getSharedAmenityIsAvailable(SharedAmenity sharedAmenity) => sharedAmenity.isAvailable;

	String? getSharedAmenityOperatingHours(SharedAmenity sharedAmenity) => sharedAmenity.operatingHours;

	AmenityAccessType? getSharedAmenityAccessType(SharedAmenity sharedAmenity) => sharedAmenity.accessType;

	double? getSharedAmenityPrice(SharedAmenity sharedAmenity) => sharedAmenity.price;

	List<String>? getSharedAmenityImages(SharedAmenity sharedAmenity) => sharedAmenity.images;

	DateTime? getSharedAmenityCreatedAt(SharedAmenity sharedAmenity) => sharedAmenity.createdAt;

	DateTime? getSharedAmenityUpdatedAt(SharedAmenity sharedAmenity) => sharedAmenity.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<SharedAmenity> getByFacilityId(
    String facilityId,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityFacilityId, facilityId, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByName(
    String name,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityName, name, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByType(
    SharedAmenityType type,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityType, type, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByDescription(
    String description,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityDescription, description, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByLocation(
    String location,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityLocation, location, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByCapacity(
    int capacity,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityCapacity, capacity, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByIsAvailable(
    bool isAvailable,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityIsAvailable, isAvailable, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByOperatingHours(
    String operatingHours,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityOperatingHours, operatingHours, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByAccessType(
    AmenityAccessType accessType,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityAccessType, accessType, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByPrice(
    double price,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityPrice, price, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByImages(
    String images,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityImages, images, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<SharedAmenity> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}
    ) =>
    getManyIncluding(getSharedAmenityUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Facility? getFacility(
    SharedAmenity sharedAmenity, {ModelFilter? modelFilter, List<FacilityInclude>? includes}) {
    if (sharedAmenity.facilityId == null) {
        return null;
    } else {
        final facility = FacilityStore.instance.getById(sharedAmenity.facilityId!, includes: includes);
        sharedAmenity.facility = facility;
        // setIncludedReferences(facility, includes: includes);
        return facility;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<SharedAmenity>> getAll$({bool useCache = true, ModelFilter<SharedAmenity>? modelFilter, List<SharedAmenityInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: SharedAmenityEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<SharedAmenity?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSharedAmenityId,
        value: id,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<SharedAmenity>> getByFacilityId$(
        String facilityId,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSharedAmenityFacilityId,
        value: facilityId,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByFacilityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSharedAmenityName,
        value: name,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByType$(
        SharedAmenityType type,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<SharedAmenityType>(
        getPropVal: getSharedAmenityType,
        value: type,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSharedAmenityDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByLocation$(
        String location,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSharedAmenityLocation,
        value: location,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByLocation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByCapacity$(
        int capacity,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getSharedAmenityCapacity,
        value: capacity,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByCapacity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByIsAvailable$(
        bool isAvailable,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getSharedAmenityIsAvailable,
        value: isAvailable,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByIsAvailable,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByOperatingHours$(
        String operatingHours,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSharedAmenityOperatingHours,
        value: operatingHours,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByOperatingHours,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByAccessType$(
        AmenityAccessType accessType,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<AmenityAccessType>(
        getPropVal: getSharedAmenityAccessType,
        value: accessType,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByAccessType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByPrice$(
        double price,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getSharedAmenityPrice,
        value: price,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByImages$(
        String images,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSharedAmenityImages,
        value: images,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByImages,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSharedAmenityCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SharedAmenity>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<SharedAmenity>? modelFilter,
        List<SharedAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSharedAmenityUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: SharedAmenityEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Facility?> getFacility$(
    SharedAmenity sharedAmenity, {bool useCache = true, ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}) {
    if (sharedAmenity.facilityId == null) {
        return Stream.value(null);
    } else {
        return FacilityStore.instance.getById$(
            sharedAmenity.facilityId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((facility) {
            sharedAmenity.facility = facility;
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
SharedAmenity recursiveUpsert(SharedAmenity sharedAmenity, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'SharedAmenity'} 
        : const {};
    if (sharedAmenity.facility != null && (!preventCircularSerialization || !upsertedTypes.contains('Facility'))) {
        sharedAmenity.facility = FacilityStore.instance.recursiveUpsert(sharedAmenity.facility!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(sharedAmenity);
}

  List<SharedAmenity> recursiveListUpsert(List<SharedAmenity> sharedAmenitys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedSharedAmenitys = <SharedAmenity>[];
    for (var sharedAmenity in sharedAmenitys) {
        updatedSharedAmenitys.add(recursiveUpsert(sharedAmenity, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedSharedAmenitys;
}

//   @override
//   SharedAmenity upsert(SharedAmenity item) {
//     return recursiveUpsert(item);
//   }

}


class SharedAmenityInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      SharedAmenityInclude.facility({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Facility>? modelFilter,
    List<FacilityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (sharedAmenity) => SharedAmenityStore.instance
            .getFacility$(sharedAmenity, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (sharedAmenity) => SharedAmenityStore.instance
            .getFacility(sharedAmenity, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum SharedAmenityEndpoints implements Endpoint {

    getAll('/sharedAmenity', HttpMethod.post, List<SharedAmenity>),
	getById('/sharedAmenity/byId/:id', HttpMethod.post, SharedAmenity),
	getManyByFacilityId('/sharedAmenity/byFacilityId/:facilityId', HttpMethod.post, List<SharedAmenity>),
	getManyByName('/sharedAmenity/byName/:name', HttpMethod.post, List<SharedAmenity>),
	getManyByType('/sharedAmenity/byType/:type', HttpMethod.post, List<SharedAmenity>),
	getManyByDescription('/sharedAmenity/byDescription/:description', HttpMethod.post, List<SharedAmenity>),
	getManyByLocation('/sharedAmenity/byLocation/:location', HttpMethod.post, List<SharedAmenity>),
	getManyByCapacity('/sharedAmenity/byCapacity/:capacity', HttpMethod.post, List<SharedAmenity>),
	getManyByIsAvailable('/sharedAmenity/byIsAvailable/:isAvailable', HttpMethod.post, List<SharedAmenity>),
	getManyByOperatingHours('/sharedAmenity/byOperatingHours/:operatingHours', HttpMethod.post, List<SharedAmenity>),
	getManyByAccessType('/sharedAmenity/byAccessType/:accessType', HttpMethod.post, List<SharedAmenity>),
	getManyByPrice('/sharedAmenity/byPrice/:price', HttpMethod.post, List<SharedAmenity>),
	getManyByImages('/sharedAmenity/byImages/:images', HttpMethod.post, List<SharedAmenity>),
	getManyByCreatedAt('/sharedAmenity/byCreatedAt/:createdAt', HttpMethod.post, List<SharedAmenity>),
	getManyByUpdatedAt('/sharedAmenity/byUpdatedAt/:updatedAt', HttpMethod.post, List<SharedAmenity>);

    const SharedAmenityEndpoints(this.path, this.method, this.responseType);

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
