
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class VirtualTourStore extends ModelStreamStore<String, VirtualTour> {

  static VirtualTourStore? _instance;

  static VirtualTourStore get instance {
    _instance ??= VirtualTourStore();
    return _instance!;
  }

  VirtualTourStore() : super(VirtualTour.fromJson) {
    if (_instance != null) {
        throw Exception(
            'VirtualTourStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending VirtualTourStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use VirtualTourStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getVirtualTourId(VirtualTour virtualTour) => virtualTour.id;

	String? getVirtualTourOrgId(VirtualTour virtualTour) => virtualTour.orgId;

	String? getVirtualTourPropertyId(VirtualTour virtualTour) => virtualTour.propertyId;

	String? getVirtualTourName(VirtualTour virtualTour) => virtualTour.name;

	String? getVirtualTourDescription(VirtualTour virtualTour) => virtualTour.description;

	String? getVirtualTourTourType(VirtualTour virtualTour) => virtualTour.tourType;

	String? getVirtualTourVideoUrl(VirtualTour virtualTour) => virtualTour.videoUrl;

	String? getVirtualTourEmbedCode(VirtualTour virtualTour) => virtualTour.embedCode;

	String? getVirtualTourThumbnailUrl(VirtualTour virtualTour) => virtualTour.thumbnailUrl;

	int? getVirtualTourDuration(VirtualTour virtualTour) => virtualTour.duration;

	dynamic? getVirtualTourHotspots(VirtualTour virtualTour) => virtualTour.hotspots;

	bool? getVirtualTourIsActive(VirtualTour virtualTour) => virtualTour.isActive;

	String? getVirtualTourCreatedBy(VirtualTour virtualTour) => virtualTour.createdBy;

	DateTime? getVirtualTourCreatedAt(VirtualTour virtualTour) => virtualTour.createdAt;

	DateTime? getVirtualTourUpdatedAt(VirtualTour virtualTour) => virtualTour.updatedAt;

	DateTime? getVirtualTourDeletedAt(VirtualTour virtualTour) => virtualTour.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<VirtualTour> getByOrgId(
    String orgId,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByPropertyId(
    String propertyId,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByName(
    String name,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourName, name, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByDescription(
    String description,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourDescription, description, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByTourType(
    String tourType,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourTourType, tourType, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByVideoUrl(
    String videoUrl,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourVideoUrl, videoUrl, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByEmbedCode(
    String embedCode,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourEmbedCode, embedCode, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByThumbnailUrl(
    String thumbnailUrl,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourThumbnailUrl, thumbnailUrl, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByDuration(
    int duration,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourDuration, duration, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByHotspots(
    dynamic hotspots,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourHotspots, hotspots, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByIsActive(
    bool isActive,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByCreatedBy(
    String createdBy,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<VirtualTour> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}
    ) =>
    getManyIncluding(getVirtualTourDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    VirtualTour virtualTour, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (virtualTour.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(virtualTour.orgId!, includes: includes);
        virtualTour.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    VirtualTour virtualTour, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (virtualTour.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(virtualTour.propertyId!, includes: includes);
        virtualTour.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<VirtualTour>> getAll$({bool useCache = true, ModelFilter<VirtualTour>? modelFilter, List<VirtualTourInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: VirtualTourEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<VirtualTour?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getVirtualTourId,
        value: id,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<VirtualTour>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVirtualTourOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVirtualTourPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVirtualTourName,
        value: name,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVirtualTourDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByTourType$(
        String tourType,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVirtualTourTourType,
        value: tourType,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByTourType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByVideoUrl$(
        String videoUrl,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVirtualTourVideoUrl,
        value: videoUrl,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByVideoUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByEmbedCode$(
        String embedCode,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVirtualTourEmbedCode,
        value: embedCode,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByEmbedCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByThumbnailUrl$(
        String thumbnailUrl,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVirtualTourThumbnailUrl,
        value: thumbnailUrl,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByThumbnailUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByDuration$(
        int duration,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getVirtualTourDuration,
        value: duration,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByDuration,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByHotspots$(
        dynamic hotspots,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getVirtualTourHotspots,
        value: hotspots,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByHotspots,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getVirtualTourIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVirtualTourCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVirtualTourCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVirtualTourUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VirtualTour>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<VirtualTour>? modelFilter,
        List<VirtualTourInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVirtualTourDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: VirtualTourEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    VirtualTour virtualTour, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (virtualTour.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            virtualTour.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            virtualTour.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    VirtualTour virtualTour, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (virtualTour.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            virtualTour.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            virtualTour.property = property;
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
VirtualTour recursiveUpsert(VirtualTour virtualTour, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'VirtualTour'} 
        : const {};
    if (virtualTour.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        virtualTour.org = OrganizationStore.instance.recursiveUpsert(virtualTour.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (virtualTour.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        virtualTour.property = PropertyStore.instance.recursiveUpsert(virtualTour.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(virtualTour);
}

  List<VirtualTour> recursiveListUpsert(List<VirtualTour> virtualTours, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedVirtualTours = <VirtualTour>[];
    for (var virtualTour in virtualTours) {
        updatedVirtualTours.add(recursiveUpsert(virtualTour, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedVirtualTours;
}

//   @override
//   VirtualTour upsert(VirtualTour item) {
//     return recursiveUpsert(item);
//   }

}


class VirtualTourInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      VirtualTourInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (virtualTour) => VirtualTourStore.instance
            .getOrg$(virtualTour, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (virtualTour) => VirtualTourStore.instance
            .getOrg(virtualTour, modelFilter: modelFilter, includes: includes);
      }
}

	VirtualTourInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (virtualTour) => VirtualTourStore.instance
            .getProperty$(virtualTour, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (virtualTour) => VirtualTourStore.instance
            .getProperty(virtualTour, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum VirtualTourEndpoints implements Endpoint {

    getAll('/virtualTour', HttpMethod.post, List<VirtualTour>),
	getById('/virtualTour/byId/:id', HttpMethod.post, VirtualTour),
	getManyByOrgId('/virtualTour/byOrgId/:orgId', HttpMethod.post, List<VirtualTour>),
	getManyByPropertyId('/virtualTour/byPropertyId/:propertyId', HttpMethod.post, List<VirtualTour>),
	getManyByName('/virtualTour/byName/:name', HttpMethod.post, List<VirtualTour>),
	getManyByDescription('/virtualTour/byDescription/:description', HttpMethod.post, List<VirtualTour>),
	getManyByTourType('/virtualTour/byTourType/:tourType', HttpMethod.post, List<VirtualTour>),
	getManyByVideoUrl('/virtualTour/byVideoUrl/:videoUrl', HttpMethod.post, List<VirtualTour>),
	getManyByEmbedCode('/virtualTour/byEmbedCode/:embedCode', HttpMethod.post, List<VirtualTour>),
	getManyByThumbnailUrl('/virtualTour/byThumbnailUrl/:thumbnailUrl', HttpMethod.post, List<VirtualTour>),
	getManyByDuration('/virtualTour/byDuration/:duration', HttpMethod.post, List<VirtualTour>),
	getManyByHotspots('/virtualTour/byHotspots/:hotspots', HttpMethod.post, List<VirtualTour>),
	getManyByIsActive('/virtualTour/byIsActive/:isActive', HttpMethod.post, List<VirtualTour>),
	getManyByCreatedBy('/virtualTour/byCreatedBy/:createdBy', HttpMethod.post, List<VirtualTour>),
	getManyByCreatedAt('/virtualTour/byCreatedAt/:createdAt', HttpMethod.post, List<VirtualTour>),
	getManyByUpdatedAt('/virtualTour/byUpdatedAt/:updatedAt', HttpMethod.post, List<VirtualTour>),
	getManyByDeletedAt('/virtualTour/byDeletedAt/:deletedAt', HttpMethod.post, List<VirtualTour>);

    const VirtualTourEndpoints(this.path, this.method, this.responseType);

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
