
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PropertyPhotoStore extends ModelStreamStore<String, PropertyPhoto> {

  static PropertyPhotoStore? _instance;

  static PropertyPhotoStore get instance {
    _instance ??= PropertyPhotoStore();
    return _instance!;
  }

  PropertyPhotoStore() : super(PropertyPhoto.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PropertyPhotoStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PropertyPhotoStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PropertyPhotoStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPropertyPhotoId(PropertyPhoto propertyPhoto) => propertyPhoto.id;

	String? getPropertyPhotoOrgId(PropertyPhoto propertyPhoto) => propertyPhoto.orgId;

	String? getPropertyPhotoPropertyId(PropertyPhoto propertyPhoto) => propertyPhoto.propertyId;

	String? getPropertyPhotoUrl(PropertyPhoto propertyPhoto) => propertyPhoto.url;

	String? getPropertyPhotoCaption(PropertyPhoto propertyPhoto) => propertyPhoto.caption;

	bool? getPropertyPhotoIsPrimary(PropertyPhoto propertyPhoto) => propertyPhoto.isPrimary;

	int? getPropertyPhotoSortOrder(PropertyPhoto propertyPhoto) => propertyPhoto.sortOrder;

	DateTime? getPropertyPhotoCreatedAt(PropertyPhoto propertyPhoto) => propertyPhoto.createdAt;

	DateTime? getPropertyPhotoUpdatedAt(PropertyPhoto propertyPhoto) => propertyPhoto.updatedAt;

	DateTime? getPropertyPhotoDeletedAt(PropertyPhoto propertyPhoto) => propertyPhoto.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PropertyPhoto> getByOrgId(
    String orgId,
    {ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPhotoOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PropertyPhoto> getByPropertyId(
    String propertyId,
    {ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPhotoPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<PropertyPhoto> getByUrl(
    String url,
    {ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPhotoUrl, url, modelFilter: modelFilter, includes: includes);

	
List<PropertyPhoto> getByCaption(
    String caption,
    {ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPhotoCaption, caption, modelFilter: modelFilter, includes: includes);

	
List<PropertyPhoto> getByIsPrimary(
    bool isPrimary,
    {ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPhotoIsPrimary, isPrimary, modelFilter: modelFilter, includes: includes);

	
List<PropertyPhoto> getBySortOrder(
    int sortOrder,
    {ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPhotoSortOrder, sortOrder, modelFilter: modelFilter, includes: includes);

	
List<PropertyPhoto> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPhotoCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyPhoto> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPhotoUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyPhoto> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPhotoDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    PropertyPhoto propertyPhoto, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyPhoto.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(propertyPhoto.orgId!, includes: includes);
        propertyPhoto.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    PropertyPhoto propertyPhoto, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyPhoto.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(propertyPhoto.propertyId!, includes: includes);
        propertyPhoto.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  List<AIImageAnalysis> getAiAnalyses(
    PropertyPhoto propertyPhoto, {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}) {
    final aiAnalyses = AIImageAnalysisStore.instance.getByPhotoId(propertyPhoto.$uid!, modelFilter: modelFilter, includes: includes);
    propertyPhoto.aiAnalyses = aiAnalyses;
    // setIncludedReferencesForList(aiAnalyses, includes: includes);
    return aiAnalyses;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PropertyPhoto>> getAll$({bool useCache = true, ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PropertyPhotoEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PropertyPhoto?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PropertyPhoto>? modelFilter,
        List<PropertyPhotoInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyPhotoId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PropertyPhotoEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PropertyPhoto>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PropertyPhoto>? modelFilter,
        List<PropertyPhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPhotoOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PropertyPhotoEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPhoto>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<PropertyPhoto>? modelFilter,
        List<PropertyPhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPhotoPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PropertyPhotoEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPhoto>> getByUrl$(
        String url,
        {bool useCache = true,
        ModelFilter<PropertyPhoto>? modelFilter,
        List<PropertyPhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPhotoUrl,
        value: url,
        modelFilter: modelFilter,
        endpoint: PropertyPhotoEndpoints.getManyByUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPhoto>> getByCaption$(
        String caption,
        {bool useCache = true,
        ModelFilter<PropertyPhoto>? modelFilter,
        List<PropertyPhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPhotoCaption,
        value: caption,
        modelFilter: modelFilter,
        endpoint: PropertyPhotoEndpoints.getManyByCaption,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPhoto>> getByIsPrimary$(
        bool isPrimary,
        {bool useCache = true,
        ModelFilter<PropertyPhoto>? modelFilter,
        List<PropertyPhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPropertyPhotoIsPrimary,
        value: isPrimary,
        modelFilter: modelFilter,
        endpoint: PropertyPhotoEndpoints.getManyByIsPrimary,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPhoto>> getBySortOrder$(
        int sortOrder,
        {bool useCache = true,
        ModelFilter<PropertyPhoto>? modelFilter,
        List<PropertyPhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyPhotoSortOrder,
        value: sortOrder,
        modelFilter: modelFilter,
        endpoint: PropertyPhotoEndpoints.getManyBySortOrder,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPhoto>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PropertyPhoto>? modelFilter,
        List<PropertyPhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyPhotoCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PropertyPhotoEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPhoto>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PropertyPhoto>? modelFilter,
        List<PropertyPhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyPhotoUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PropertyPhotoEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPhoto>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<PropertyPhoto>? modelFilter,
        List<PropertyPhotoInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyPhotoDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PropertyPhotoEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    PropertyPhoto propertyPhoto, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyPhoto.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            propertyPhoto.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            propertyPhoto.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    PropertyPhoto propertyPhoto, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyPhoto.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            propertyPhoto.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            propertyPhoto.property = property;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<AIImageAnalysis>> getAiAnalyses$(
    PropertyPhoto propertyPhoto, {bool useCache = true, ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}) {
    return AIImageAnalysisStore.instance.getByPhotoId$(
        propertyPhoto.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((aiAnalyses) {
        propertyPhoto.aiAnalyses = aiAnalyses;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
PropertyPhoto recursiveUpsert(PropertyPhoto propertyPhoto, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PropertyPhoto'} 
        : const {};
    if (propertyPhoto.aiAnalyses != null && (!preventCircularSerialization || !upsertedTypes.contains('AIImageAnalysis'))) {
        propertyPhoto.aiAnalyses = AIImageAnalysisStore.instance.recursiveListUpsert(propertyPhoto.aiAnalyses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyPhoto.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        propertyPhoto.org = OrganizationStore.instance.recursiveUpsert(propertyPhoto.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyPhoto.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        propertyPhoto.property = PropertyStore.instance.recursiveUpsert(propertyPhoto.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(propertyPhoto);
}

  List<PropertyPhoto> recursiveListUpsert(List<PropertyPhoto> propertyPhotos, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPropertyPhotos = <PropertyPhoto>[];
    for (var propertyPhoto in propertyPhotos) {
        updatedPropertyPhotos.add(recursiveUpsert(propertyPhoto, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPropertyPhotos;
}

//   @override
//   PropertyPhoto upsert(PropertyPhoto item) {
//     return recursiveUpsert(item);
//   }

}


class PropertyPhotoInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PropertyPhotoInclude.aiAnalyses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIImageAnalysis>? modelFilter,
    List<AIImageAnalysisInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyPhoto) => PropertyPhotoStore.instance
            .getAiAnalyses$(propertyPhoto, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyPhoto) => PropertyPhotoStore.instance
            .getAiAnalyses(propertyPhoto, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyPhotoInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyPhoto) => PropertyPhotoStore.instance
            .getOrg$(propertyPhoto, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyPhoto) => PropertyPhotoStore.instance
            .getOrg(propertyPhoto, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyPhotoInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyPhoto) => PropertyPhotoStore.instance
            .getProperty$(propertyPhoto, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyPhoto) => PropertyPhotoStore.instance
            .getProperty(propertyPhoto, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PropertyPhotoEndpoints implements Endpoint {

    getAll('/propertyPhoto', HttpMethod.post, List<PropertyPhoto>),
	getById('/propertyPhoto/byId/:id', HttpMethod.post, PropertyPhoto),
	getManyByOrgId('/propertyPhoto/byOrgId/:orgId', HttpMethod.post, List<PropertyPhoto>),
	getManyByPropertyId('/propertyPhoto/byPropertyId/:propertyId', HttpMethod.post, List<PropertyPhoto>),
	getManyByUrl('/propertyPhoto/byUrl/:url', HttpMethod.post, List<PropertyPhoto>),
	getManyByCaption('/propertyPhoto/byCaption/:caption', HttpMethod.post, List<PropertyPhoto>),
	getManyByIsPrimary('/propertyPhoto/byIsPrimary/:isPrimary', HttpMethod.post, List<PropertyPhoto>),
	getManyBySortOrder('/propertyPhoto/bySortOrder/:sortOrder', HttpMethod.post, List<PropertyPhoto>),
	getManyByCreatedAt('/propertyPhoto/byCreatedAt/:createdAt', HttpMethod.post, List<PropertyPhoto>),
	getManyByUpdatedAt('/propertyPhoto/byUpdatedAt/:updatedAt', HttpMethod.post, List<PropertyPhoto>),
	getManyByDeletedAt('/propertyPhoto/byDeletedAt/:deletedAt', HttpMethod.post, List<PropertyPhoto>);

    const PropertyPhotoEndpoints(this.path, this.method, this.responseType);

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
