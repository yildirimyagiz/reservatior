
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AmenityStore extends ModelStreamStore<String, Amenity> {

  static AmenityStore? _instance;

  static AmenityStore get instance {
    _instance ??= AmenityStore();
    return _instance!;
  }

  AmenityStore() : super(Amenity.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AmenityStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AmenityStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AmenityStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAmenityId(Amenity amenity) => amenity.id;

	String? getAmenityOrgId(Amenity amenity) => amenity.orgId;

	String? getAmenityName(Amenity amenity) => amenity.name;

	AmenityCategory? getAmenityCategory(Amenity amenity) => amenity.category;

	String? getAmenityIcon(Amenity amenity) => amenity.icon;

	DateTime? getAmenityCreatedAt(Amenity amenity) => amenity.createdAt;

	DateTime? getAmenityUpdatedAt(Amenity amenity) => amenity.updatedAt;

	DateTime? getAmenityDeletedAt(Amenity amenity) => amenity.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Amenity> getByOrgId(
    String orgId,
    {ModelFilter<Amenity>? modelFilter, List<AmenityInclude>? includes}
    ) =>
    getManyIncluding(getAmenityOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Amenity> getByName(
    String name,
    {ModelFilter<Amenity>? modelFilter, List<AmenityInclude>? includes}
    ) =>
    getManyIncluding(getAmenityName, name, modelFilter: modelFilter, includes: includes);

	
List<Amenity> getByCategory(
    AmenityCategory category,
    {ModelFilter<Amenity>? modelFilter, List<AmenityInclude>? includes}
    ) =>
    getManyIncluding(getAmenityCategory, category, modelFilter: modelFilter, includes: includes);

	
List<Amenity> getByIcon(
    String icon,
    {ModelFilter<Amenity>? modelFilter, List<AmenityInclude>? includes}
    ) =>
    getManyIncluding(getAmenityIcon, icon, modelFilter: modelFilter, includes: includes);

	
List<Amenity> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Amenity>? modelFilter, List<AmenityInclude>? includes}
    ) =>
    getManyIncluding(getAmenityCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Amenity> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Amenity>? modelFilter, List<AmenityInclude>? includes}
    ) =>
    getManyIncluding(getAmenityUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Amenity> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Amenity>? modelFilter, List<AmenityInclude>? includes}
    ) =>
    getManyIncluding(getAmenityDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Amenity amenity, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (amenity.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(amenity.orgId!, includes: includes);
        amenity.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<PropertyAmenity> getPropertyAmenities(
    Amenity amenity, {ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}) {
    final propertyAmenities = PropertyAmenityStore.instance.getByAmenityId(amenity.$uid!, modelFilter: modelFilter, includes: includes);
    amenity.propertyAmenities = propertyAmenities;
    // setIncludedReferencesForList(propertyAmenities, includes: includes);
    return propertyAmenities;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Amenity>> getAll$({bool useCache = true, ModelFilter<Amenity>? modelFilter, List<AmenityInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AmenityEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Amenity?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Amenity>? modelFilter,
        List<AmenityInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAmenityId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AmenityEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Amenity>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Amenity>? modelFilter,
        List<AmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmenityOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AmenityEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Amenity>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Amenity>? modelFilter,
        List<AmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmenityName,
        value: name,
        modelFilter: modelFilter,
        endpoint: AmenityEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Amenity>> getByCategory$(
        AmenityCategory category,
        {bool useCache = true,
        ModelFilter<Amenity>? modelFilter,
        List<AmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<AmenityCategory>(
        getPropVal: getAmenityCategory,
        value: category,
        modelFilter: modelFilter,
        endpoint: AmenityEndpoints.getManyByCategory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Amenity>> getByIcon$(
        String icon,
        {bool useCache = true,
        ModelFilter<Amenity>? modelFilter,
        List<AmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmenityIcon,
        value: icon,
        modelFilter: modelFilter,
        endpoint: AmenityEndpoints.getManyByIcon,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Amenity>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Amenity>? modelFilter,
        List<AmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmenityCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AmenityEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Amenity>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Amenity>? modelFilter,
        List<AmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmenityUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AmenityEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Amenity>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Amenity>? modelFilter,
        List<AmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmenityDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: AmenityEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Amenity amenity, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (amenity.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            amenity.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            amenity.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<PropertyAmenity>> getPropertyAmenities$(
    Amenity amenity, {bool useCache = true, ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}) {
    return PropertyAmenityStore.instance.getByAmenityId$(
        amenity.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((propertyAmenities) {
        amenity.propertyAmenities = propertyAmenities;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Amenity recursiveUpsert(Amenity amenity, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Amenity'} 
        : const {};
    if (amenity.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        amenity.org = OrganizationStore.instance.recursiveUpsert(amenity.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (amenity.propertyAmenities != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyAmenity'))) {
        amenity.propertyAmenities = PropertyAmenityStore.instance.recursiveListUpsert(amenity.propertyAmenities!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(amenity);
}

  List<Amenity> recursiveListUpsert(List<Amenity> amenitys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAmenitys = <Amenity>[];
    for (var amenity in amenitys) {
        updatedAmenitys.add(recursiveUpsert(amenity, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAmenitys;
}

//   @override
//   Amenity upsert(Amenity item) {
//     return recursiveUpsert(item);
//   }

}


class AmenityInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AmenityInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (amenity) => AmenityStore.instance
            .getOrg$(amenity, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (amenity) => AmenityStore.instance
            .getOrg(amenity, modelFilter: modelFilter, includes: includes);
      }
}

	AmenityInclude.propertyAmenities({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyAmenity>? modelFilter,
    List<PropertyAmenityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (amenity) => AmenityStore.instance
            .getPropertyAmenities$(amenity, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (amenity) => AmenityStore.instance
            .getPropertyAmenities(amenity, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AmenityEndpoints implements Endpoint {

    getAll('/amenity', HttpMethod.post, List<Amenity>),
	getById('/amenity/byId/:id', HttpMethod.post, Amenity),
	getManyByOrgId('/amenity/byOrgId/:orgId', HttpMethod.post, List<Amenity>),
	getManyByName('/amenity/byName/:name', HttpMethod.post, List<Amenity>),
	getManyByCategory('/amenity/byCategory/:category', HttpMethod.post, List<Amenity>),
	getManyByIcon('/amenity/byIcon/:icon', HttpMethod.post, List<Amenity>),
	getManyByCreatedAt('/amenity/byCreatedAt/:createdAt', HttpMethod.post, List<Amenity>),
	getManyByUpdatedAt('/amenity/byUpdatedAt/:updatedAt', HttpMethod.post, List<Amenity>),
	getManyByDeletedAt('/amenity/byDeletedAt/:deletedAt', HttpMethod.post, List<Amenity>);

    const AmenityEndpoints(this.path, this.method, this.responseType);

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
