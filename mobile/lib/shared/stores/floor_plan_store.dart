
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class FloorPlanStore extends ModelStreamStore<String, FloorPlan> {

  static FloorPlanStore? _instance;

  static FloorPlanStore get instance {
    _instance ??= FloorPlanStore();
    return _instance!;
  }

  FloorPlanStore() : super(FloorPlan.fromJson) {
    if (_instance != null) {
        throw Exception(
            'FloorPlanStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending FloorPlanStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use FloorPlanStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getFloorPlanId(FloorPlan floorPlan) => floorPlan.id;

	String? getFloorPlanOrgId(FloorPlan floorPlan) => floorPlan.orgId;

	String? getFloorPlanPropertyId(FloorPlan floorPlan) => floorPlan.propertyId;

	String? getFloorPlanName(FloorPlan floorPlan) => floorPlan.name;

	String? getFloorPlanDescription(FloorPlan floorPlan) => floorPlan.description;

	int? getFloorPlanFloorLevel(FloorPlan floorPlan) => floorPlan.floorLevel;

	String? getFloorPlanImageUrl(FloorPlan floorPlan) => floorPlan.imageUrl;

	int? getFloorPlanImageWidth(FloorPlan floorPlan) => floorPlan.imageWidth;

	int? getFloorPlanImageHeight(FloorPlan floorPlan) => floorPlan.imageHeight;

	dynamic? getFloorPlanRooms(FloorPlan floorPlan) => floorPlan.rooms;

	bool? getFloorPlanIsActive(FloorPlan floorPlan) => floorPlan.isActive;

	String? getFloorPlanCreatedBy(FloorPlan floorPlan) => floorPlan.createdBy;

	DateTime? getFloorPlanCreatedAt(FloorPlan floorPlan) => floorPlan.createdAt;

	DateTime? getFloorPlanUpdatedAt(FloorPlan floorPlan) => floorPlan.updatedAt;

	DateTime? getFloorPlanDeletedAt(FloorPlan floorPlan) => floorPlan.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<FloorPlan> getByOrgId(
    String orgId,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByPropertyId(
    String propertyId,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByName(
    String name,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanName, name, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByDescription(
    String description,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanDescription, description, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByFloorLevel(
    int floorLevel,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanFloorLevel, floorLevel, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByImageUrl(
    String imageUrl,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanImageUrl, imageUrl, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByImageWidth(
    int imageWidth,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanImageWidth, imageWidth, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByImageHeight(
    int imageHeight,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanImageHeight, imageHeight, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByRooms(
    dynamic rooms,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanRooms, rooms, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByIsActive(
    bool isActive,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByCreatedBy(
    String createdBy,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<FloorPlan> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}
    ) =>
    getManyIncluding(getFloorPlanDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    FloorPlan floorPlan, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (floorPlan.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(floorPlan.orgId!, includes: includes);
        floorPlan.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    FloorPlan floorPlan, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (floorPlan.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(floorPlan.propertyId!, includes: includes);
        floorPlan.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<FloorPlan>> getAll$({bool useCache = true, ModelFilter<FloorPlan>? modelFilter, List<FloorPlanInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: FloorPlanEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<FloorPlan?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getFloorPlanId,
        value: id,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<FloorPlan>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFloorPlanOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFloorPlanPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFloorPlanName,
        value: name,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFloorPlanDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByFloorLevel$(
        int floorLevel,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getFloorPlanFloorLevel,
        value: floorLevel,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByFloorLevel,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByImageUrl$(
        String imageUrl,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFloorPlanImageUrl,
        value: imageUrl,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByImageUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByImageWidth$(
        int imageWidth,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getFloorPlanImageWidth,
        value: imageWidth,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByImageWidth,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByImageHeight$(
        int imageHeight,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getFloorPlanImageHeight,
        value: imageHeight,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByImageHeight,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByRooms$(
        dynamic rooms,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getFloorPlanRooms,
        value: rooms,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByRooms,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getFloorPlanIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFloorPlanCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFloorPlanCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFloorPlanUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FloorPlan>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<FloorPlan>? modelFilter,
        List<FloorPlanInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getFloorPlanDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: FloorPlanEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    FloorPlan floorPlan, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (floorPlan.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            floorPlan.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            floorPlan.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    FloorPlan floorPlan, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (floorPlan.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            floorPlan.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            floorPlan.property = property;
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
FloorPlan recursiveUpsert(FloorPlan floorPlan, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'FloorPlan'} 
        : const {};
    if (floorPlan.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        floorPlan.org = OrganizationStore.instance.recursiveUpsert(floorPlan.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (floorPlan.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        floorPlan.property = PropertyStore.instance.recursiveUpsert(floorPlan.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(floorPlan);
}

  List<FloorPlan> recursiveListUpsert(List<FloorPlan> floorPlans, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedFloorPlans = <FloorPlan>[];
    for (var floorPlan in floorPlans) {
        updatedFloorPlans.add(recursiveUpsert(floorPlan, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedFloorPlans;
}

//   @override
//   FloorPlan upsert(FloorPlan item) {
//     return recursiveUpsert(item);
//   }

}


class FloorPlanInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      FloorPlanInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (floorPlan) => FloorPlanStore.instance
            .getOrg$(floorPlan, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (floorPlan) => FloorPlanStore.instance
            .getOrg(floorPlan, modelFilter: modelFilter, includes: includes);
      }
}

	FloorPlanInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (floorPlan) => FloorPlanStore.instance
            .getProperty$(floorPlan, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (floorPlan) => FloorPlanStore.instance
            .getProperty(floorPlan, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum FloorPlanEndpoints implements Endpoint {

    getAll('/floorPlan', HttpMethod.post, List<FloorPlan>),
	getById('/floorPlan/byId/:id', HttpMethod.post, FloorPlan),
	getManyByOrgId('/floorPlan/byOrgId/:orgId', HttpMethod.post, List<FloorPlan>),
	getManyByPropertyId('/floorPlan/byPropertyId/:propertyId', HttpMethod.post, List<FloorPlan>),
	getManyByName('/floorPlan/byName/:name', HttpMethod.post, List<FloorPlan>),
	getManyByDescription('/floorPlan/byDescription/:description', HttpMethod.post, List<FloorPlan>),
	getManyByFloorLevel('/floorPlan/byFloorLevel/:floorLevel', HttpMethod.post, List<FloorPlan>),
	getManyByImageUrl('/floorPlan/byImageUrl/:imageUrl', HttpMethod.post, List<FloorPlan>),
	getManyByImageWidth('/floorPlan/byImageWidth/:imageWidth', HttpMethod.post, List<FloorPlan>),
	getManyByImageHeight('/floorPlan/byImageHeight/:imageHeight', HttpMethod.post, List<FloorPlan>),
	getManyByRooms('/floorPlan/byRooms/:rooms', HttpMethod.post, List<FloorPlan>),
	getManyByIsActive('/floorPlan/byIsActive/:isActive', HttpMethod.post, List<FloorPlan>),
	getManyByCreatedBy('/floorPlan/byCreatedBy/:createdBy', HttpMethod.post, List<FloorPlan>),
	getManyByCreatedAt('/floorPlan/byCreatedAt/:createdAt', HttpMethod.post, List<FloorPlan>),
	getManyByUpdatedAt('/floorPlan/byUpdatedAt/:updatedAt', HttpMethod.post, List<FloorPlan>),
	getManyByDeletedAt('/floorPlan/byDeletedAt/:deletedAt', HttpMethod.post, List<FloorPlan>);

    const FloorPlanEndpoints(this.path, this.method, this.responseType);

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
