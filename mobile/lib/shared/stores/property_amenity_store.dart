
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PropertyAmenityStore extends ModelStreamStore<String, PropertyAmenity> {

  static PropertyAmenityStore? _instance;

  static PropertyAmenityStore get instance {
    _instance ??= PropertyAmenityStore();
    return _instance!;
  }

  PropertyAmenityStore() : super(PropertyAmenity.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PropertyAmenityStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PropertyAmenityStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PropertyAmenityStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPropertyAmenityId(PropertyAmenity propertyAmenity) => propertyAmenity.id;

	String? getPropertyAmenityPropertyId(PropertyAmenity propertyAmenity) => propertyAmenity.propertyId;

	String? getPropertyAmenityAmenityId(PropertyAmenity propertyAmenity) => propertyAmenity.amenityId;

	String? getPropertyAmenityOrgId(PropertyAmenity propertyAmenity) => propertyAmenity.orgId;

	DateTime? getPropertyAmenityCreatedAt(PropertyAmenity propertyAmenity) => propertyAmenity.createdAt;

	DateTime? getPropertyAmenityUpdatedAt(PropertyAmenity propertyAmenity) => propertyAmenity.updatedAt;

	DateTime? getPropertyAmenityDeletedAt(PropertyAmenity propertyAmenity) => propertyAmenity.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PropertyAmenity> getByPropertyId(
    String propertyId,
    {ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAmenityPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<PropertyAmenity> getByAmenityId(
    String amenityId,
    {ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAmenityAmenityId, amenityId, modelFilter: modelFilter, includes: includes);

	
List<PropertyAmenity> getByOrgId(
    String orgId,
    {ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAmenityOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PropertyAmenity> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAmenityCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyAmenity> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAmenityUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyAmenity> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}
    ) =>
    getManyIncluding(getPropertyAmenityDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Amenity? getAmenity(
    PropertyAmenity propertyAmenity, {ModelFilter? modelFilter, List<AmenityInclude>? includes}) {
    if (propertyAmenity.amenityId == null) {
        return null;
    } else {
        final amenity = AmenityStore.instance.getById(propertyAmenity.amenityId!, includes: includes);
        propertyAmenity.amenity = amenity;
        // setIncludedReferences(amenity, includes: includes);
        return amenity;
    }
}

	Organization? getOrg(
    PropertyAmenity propertyAmenity, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyAmenity.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(propertyAmenity.orgId!, includes: includes);
        propertyAmenity.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    PropertyAmenity propertyAmenity, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyAmenity.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(propertyAmenity.propertyId!, includes: includes);
        propertyAmenity.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PropertyAmenity>> getAll$({bool useCache = true, ModelFilter<PropertyAmenity>? modelFilter, List<PropertyAmenityInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PropertyAmenityEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PropertyAmenity?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PropertyAmenity>? modelFilter,
        List<PropertyAmenityInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyAmenityId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PropertyAmenityEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PropertyAmenity>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<PropertyAmenity>? modelFilter,
        List<PropertyAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyAmenityPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PropertyAmenityEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyAmenity>> getByAmenityId$(
        String amenityId,
        {bool useCache = true,
        ModelFilter<PropertyAmenity>? modelFilter,
        List<PropertyAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyAmenityAmenityId,
        value: amenityId,
        modelFilter: modelFilter,
        endpoint: PropertyAmenityEndpoints.getManyByAmenityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyAmenity>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PropertyAmenity>? modelFilter,
        List<PropertyAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyAmenityOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PropertyAmenityEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyAmenity>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PropertyAmenity>? modelFilter,
        List<PropertyAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyAmenityCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PropertyAmenityEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyAmenity>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PropertyAmenity>? modelFilter,
        List<PropertyAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyAmenityUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PropertyAmenityEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyAmenity>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<PropertyAmenity>? modelFilter,
        List<PropertyAmenityInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyAmenityDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PropertyAmenityEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Amenity?> getAmenity$(
    PropertyAmenity propertyAmenity, {bool useCache = true, ModelFilter<Amenity>? modelFilter, List<AmenityInclude>? includes}) {
    if (propertyAmenity.amenityId == null) {
        return Stream.value(null);
    } else {
        return AmenityStore.instance.getById$(
            propertyAmenity.amenityId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((amenity) {
            propertyAmenity.amenity = amenity;
        });
    }
}

	Stream<Organization?> getOrg$(
    PropertyAmenity propertyAmenity, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyAmenity.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            propertyAmenity.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            propertyAmenity.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    PropertyAmenity propertyAmenity, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyAmenity.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            propertyAmenity.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            propertyAmenity.property = property;
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
PropertyAmenity recursiveUpsert(PropertyAmenity propertyAmenity, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PropertyAmenity'} 
        : const {};
    if (propertyAmenity.amenity != null && (!preventCircularSerialization || !upsertedTypes.contains('Amenity'))) {
        propertyAmenity.amenity = AmenityStore.instance.recursiveUpsert(propertyAmenity.amenity!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyAmenity.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        propertyAmenity.org = OrganizationStore.instance.recursiveUpsert(propertyAmenity.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyAmenity.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        propertyAmenity.property = PropertyStore.instance.recursiveUpsert(propertyAmenity.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(propertyAmenity);
}

  List<PropertyAmenity> recursiveListUpsert(List<PropertyAmenity> propertyAmenitys, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPropertyAmenitys = <PropertyAmenity>[];
    for (var propertyAmenity in propertyAmenitys) {
        updatedPropertyAmenitys.add(recursiveUpsert(propertyAmenity, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPropertyAmenitys;
}

//   @override
//   PropertyAmenity upsert(PropertyAmenity item) {
//     return recursiveUpsert(item);
//   }

}


class PropertyAmenityInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PropertyAmenityInclude.amenity({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Amenity>? modelFilter,
    List<AmenityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyAmenity) => PropertyAmenityStore.instance
            .getAmenity$(propertyAmenity, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyAmenity) => PropertyAmenityStore.instance
            .getAmenity(propertyAmenity, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyAmenityInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyAmenity) => PropertyAmenityStore.instance
            .getOrg$(propertyAmenity, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyAmenity) => PropertyAmenityStore.instance
            .getOrg(propertyAmenity, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyAmenityInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyAmenity) => PropertyAmenityStore.instance
            .getProperty$(propertyAmenity, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyAmenity) => PropertyAmenityStore.instance
            .getProperty(propertyAmenity, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PropertyAmenityEndpoints implements Endpoint {

    getAll('/propertyAmenity', HttpMethod.post, List<PropertyAmenity>),
	getById('/propertyAmenity/byId/:id', HttpMethod.post, PropertyAmenity),
	getManyByPropertyId('/propertyAmenity/byPropertyId/:propertyId', HttpMethod.post, List<PropertyAmenity>),
	getManyByAmenityId('/propertyAmenity/byAmenityId/:amenityId', HttpMethod.post, List<PropertyAmenity>),
	getManyByOrgId('/propertyAmenity/byOrgId/:orgId', HttpMethod.post, List<PropertyAmenity>),
	getManyByCreatedAt('/propertyAmenity/byCreatedAt/:createdAt', HttpMethod.post, List<PropertyAmenity>),
	getManyByUpdatedAt('/propertyAmenity/byUpdatedAt/:updatedAt', HttpMethod.post, List<PropertyAmenity>),
	getManyByDeletedAt('/propertyAmenity/byDeletedAt/:deletedAt', HttpMethod.post, List<PropertyAmenity>);

    const PropertyAmenityEndpoints(this.path, this.method, this.responseType);

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
