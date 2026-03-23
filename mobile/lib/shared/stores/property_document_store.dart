
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PropertyDocumentStore extends ModelStreamStore<String, PropertyDocument> {

  static PropertyDocumentStore? _instance;

  static PropertyDocumentStore get instance {
    _instance ??= PropertyDocumentStore();
    return _instance!;
  }

  PropertyDocumentStore() : super(PropertyDocument.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PropertyDocumentStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PropertyDocumentStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PropertyDocumentStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPropertyDocumentId(PropertyDocument propertyDocument) => propertyDocument.id;

	String? getPropertyDocumentOrgId(PropertyDocument propertyDocument) => propertyDocument.orgId;

	String? getPropertyDocumentPropertyId(PropertyDocument propertyDocument) => propertyDocument.propertyId;

	String? getPropertyDocumentTitle(PropertyDocument propertyDocument) => propertyDocument.title;

	String? getPropertyDocumentFileName(PropertyDocument propertyDocument) => propertyDocument.fileName;

	String? getPropertyDocumentMimeType(PropertyDocument propertyDocument) => propertyDocument.mimeType;

	int? getPropertyDocumentSizeBytes(PropertyDocument propertyDocument) => propertyDocument.sizeBytes;

	String? getPropertyDocumentStorageKey(PropertyDocument propertyDocument) => propertyDocument.storageKey;

	String? getPropertyDocumentCategory(PropertyDocument propertyDocument) => propertyDocument.category;

	DateTime? getPropertyDocumentCreatedAt(PropertyDocument propertyDocument) => propertyDocument.createdAt;

	DateTime? getPropertyDocumentUpdatedAt(PropertyDocument propertyDocument) => propertyDocument.updatedAt;

	DateTime? getPropertyDocumentDeletedAt(PropertyDocument propertyDocument) => propertyDocument.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PropertyDocument> getByOrgId(
    String orgId,
    {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDocumentOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PropertyDocument> getByPropertyId(
    String propertyId,
    {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDocumentPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<PropertyDocument> getByTitle(
    String title,
    {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDocumentTitle, title, modelFilter: modelFilter, includes: includes);

	
List<PropertyDocument> getByFileName(
    String fileName,
    {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDocumentFileName, fileName, modelFilter: modelFilter, includes: includes);

	
List<PropertyDocument> getByMimeType(
    String mimeType,
    {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDocumentMimeType, mimeType, modelFilter: modelFilter, includes: includes);

	
List<PropertyDocument> getBySizeBytes(
    int sizeBytes,
    {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDocumentSizeBytes, sizeBytes, modelFilter: modelFilter, includes: includes);

	
List<PropertyDocument> getByStorageKey(
    String storageKey,
    {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDocumentStorageKey, storageKey, modelFilter: modelFilter, includes: includes);

	
List<PropertyDocument> getByCategory(
    String category,
    {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDocumentCategory, category, modelFilter: modelFilter, includes: includes);

	
List<PropertyDocument> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDocumentCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyDocument> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDocumentUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyDocument> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}
    ) =>
    getManyIncluding(getPropertyDocumentDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    PropertyDocument propertyDocument, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyDocument.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(propertyDocument.orgId!, includes: includes);
        propertyDocument.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    PropertyDocument propertyDocument, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyDocument.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(propertyDocument.propertyId!, includes: includes);
        propertyDocument.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PropertyDocument>> getAll$({bool useCache = true, ModelFilter<PropertyDocument>? modelFilter, List<PropertyDocumentInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PropertyDocumentEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PropertyDocument?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyDocumentId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PropertyDocument>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyDocumentOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDocument>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyDocumentPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDocument>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyDocumentTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDocument>> getByFileName$(
        String fileName,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyDocumentFileName,
        value: fileName,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getManyByFileName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDocument>> getByMimeType$(
        String mimeType,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyDocumentMimeType,
        value: mimeType,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getManyByMimeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDocument>> getBySizeBytes$(
        int sizeBytes,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPropertyDocumentSizeBytes,
        value: sizeBytes,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getManyBySizeBytes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDocument>> getByStorageKey$(
        String storageKey,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyDocumentStorageKey,
        value: storageKey,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getManyByStorageKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDocument>> getByCategory$(
        String category,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyDocumentCategory,
        value: category,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getManyByCategory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDocument>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyDocumentCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDocument>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyDocumentUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyDocument>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<PropertyDocument>? modelFilter,
        List<PropertyDocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyDocumentDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PropertyDocumentEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    PropertyDocument propertyDocument, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (propertyDocument.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            propertyDocument.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            propertyDocument.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    PropertyDocument propertyDocument, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyDocument.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            propertyDocument.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            propertyDocument.property = property;
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
PropertyDocument recursiveUpsert(PropertyDocument propertyDocument, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PropertyDocument'} 
        : const {};
    if (propertyDocument.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        propertyDocument.org = OrganizationStore.instance.recursiveUpsert(propertyDocument.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyDocument.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        propertyDocument.property = PropertyStore.instance.recursiveUpsert(propertyDocument.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(propertyDocument);
}

  List<PropertyDocument> recursiveListUpsert(List<PropertyDocument> propertyDocuments, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPropertyDocuments = <PropertyDocument>[];
    for (var propertyDocument in propertyDocuments) {
        updatedPropertyDocuments.add(recursiveUpsert(propertyDocument, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPropertyDocuments;
}

//   @override
//   PropertyDocument upsert(PropertyDocument item) {
//     return recursiveUpsert(item);
//   }

}


class PropertyDocumentInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PropertyDocumentInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyDocument) => PropertyDocumentStore.instance
            .getOrg$(propertyDocument, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyDocument) => PropertyDocumentStore.instance
            .getOrg(propertyDocument, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyDocumentInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyDocument) => PropertyDocumentStore.instance
            .getProperty$(propertyDocument, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyDocument) => PropertyDocumentStore.instance
            .getProperty(propertyDocument, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PropertyDocumentEndpoints implements Endpoint {

    getAll('/propertyDocument', HttpMethod.post, List<PropertyDocument>),
	getById('/propertyDocument/byId/:id', HttpMethod.post, PropertyDocument),
	getManyByOrgId('/propertyDocument/byOrgId/:orgId', HttpMethod.post, List<PropertyDocument>),
	getManyByPropertyId('/propertyDocument/byPropertyId/:propertyId', HttpMethod.post, List<PropertyDocument>),
	getManyByTitle('/propertyDocument/byTitle/:title', HttpMethod.post, List<PropertyDocument>),
	getManyByFileName('/propertyDocument/byFileName/:fileName', HttpMethod.post, List<PropertyDocument>),
	getManyByMimeType('/propertyDocument/byMimeType/:mimeType', HttpMethod.post, List<PropertyDocument>),
	getManyBySizeBytes('/propertyDocument/bySizeBytes/:sizeBytes', HttpMethod.post, List<PropertyDocument>),
	getManyByStorageKey('/propertyDocument/byStorageKey/:storageKey', HttpMethod.post, List<PropertyDocument>),
	getManyByCategory('/propertyDocument/byCategory/:category', HttpMethod.post, List<PropertyDocument>),
	getManyByCreatedAt('/propertyDocument/byCreatedAt/:createdAt', HttpMethod.post, List<PropertyDocument>),
	getManyByUpdatedAt('/propertyDocument/byUpdatedAt/:updatedAt', HttpMethod.post, List<PropertyDocument>),
	getManyByDeletedAt('/propertyDocument/byDeletedAt/:deletedAt', HttpMethod.post, List<PropertyDocument>);

    const PropertyDocumentEndpoints(this.path, this.method, this.responseType);

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
