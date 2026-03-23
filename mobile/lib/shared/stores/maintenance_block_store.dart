
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MaintenanceBlockStore extends ModelStreamStore<String, MaintenanceBlock> {

  static MaintenanceBlockStore? _instance;

  static MaintenanceBlockStore get instance {
    _instance ??= MaintenanceBlockStore();
    return _instance!;
  }

  MaintenanceBlockStore() : super(MaintenanceBlock.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MaintenanceBlockStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MaintenanceBlockStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MaintenanceBlockStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMaintenanceBlockId(MaintenanceBlock maintenanceBlock) => maintenanceBlock.id;

	String? getMaintenanceBlockOrgId(MaintenanceBlock maintenanceBlock) => maintenanceBlock.orgId;

	String? getMaintenanceBlockPropertyId(MaintenanceBlock maintenanceBlock) => maintenanceBlock.propertyId;

	String? getMaintenanceBlockListingId(MaintenanceBlock maintenanceBlock) => maintenanceBlock.listingId;

	MaintenanceBlockType? getMaintenanceBlockType(MaintenanceBlock maintenanceBlock) => maintenanceBlock.type;

	DateTime? getMaintenanceBlockStartDate(MaintenanceBlock maintenanceBlock) => maintenanceBlock.startDate;

	DateTime? getMaintenanceBlockEndDate(MaintenanceBlock maintenanceBlock) => maintenanceBlock.endDate;

	String? getMaintenanceBlockReason(MaintenanceBlock maintenanceBlock) => maintenanceBlock.reason;

	String? getMaintenanceBlockCreatedBy(MaintenanceBlock maintenanceBlock) => maintenanceBlock.createdBy;

	DateTime? getMaintenanceBlockCreatedAt(MaintenanceBlock maintenanceBlock) => maintenanceBlock.createdAt;

	DateTime? getMaintenanceBlockUpdatedAt(MaintenanceBlock maintenanceBlock) => maintenanceBlock.updatedAt;

	DateTime? getMaintenanceBlockDeletedAt(MaintenanceBlock maintenanceBlock) => maintenanceBlock.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MaintenanceBlock> getByOrgId(
    String orgId,
    {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceBlockOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceBlock> getByPropertyId(
    String propertyId,
    {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceBlockPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceBlock> getByListingId(
    String listingId,
    {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceBlockListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceBlock> getByType(
    MaintenanceBlockType type,
    {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceBlockType, type, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceBlock> getByStartDate(
    DateTime startDate,
    {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceBlockStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceBlock> getByEndDate(
    DateTime endDate,
    {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceBlockEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceBlock> getByReason(
    String reason,
    {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceBlockReason, reason, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceBlock> getByCreatedBy(
    String createdBy,
    {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceBlockCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceBlock> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceBlockCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceBlock> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceBlockUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<MaintenanceBlock> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}
    ) =>
    getManyIncluding(getMaintenanceBlockDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Listing? getListing(
    MaintenanceBlock maintenanceBlock, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (maintenanceBlock.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(maintenanceBlock.listingId!, includes: includes);
        maintenanceBlock.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    MaintenanceBlock maintenanceBlock, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (maintenanceBlock.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(maintenanceBlock.orgId!, includes: includes);
        maintenanceBlock.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    MaintenanceBlock maintenanceBlock, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (maintenanceBlock.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(maintenanceBlock.propertyId!, includes: includes);
        maintenanceBlock.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MaintenanceBlock>> getAll$({bool useCache = true, ModelFilter<MaintenanceBlock>? modelFilter, List<MaintenanceBlockInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MaintenanceBlockEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MaintenanceBlock?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMaintenanceBlockId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MaintenanceBlock>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceBlockOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceBlock>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceBlockPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceBlock>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceBlockListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceBlock>> getByType$(
        MaintenanceBlockType type,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<MaintenanceBlockType>(
        getPropVal: getMaintenanceBlockType,
        value: type,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceBlock>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMaintenanceBlockStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceBlock>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMaintenanceBlockEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceBlock>> getByReason$(
        String reason,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceBlockReason,
        value: reason,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getManyByReason,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceBlock>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMaintenanceBlockCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceBlock>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMaintenanceBlockCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceBlock>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMaintenanceBlockUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MaintenanceBlock>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<MaintenanceBlock>? modelFilter,
        List<MaintenanceBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMaintenanceBlockDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: MaintenanceBlockEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Listing?> getListing$(
    MaintenanceBlock maintenanceBlock, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (maintenanceBlock.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            maintenanceBlock.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            maintenanceBlock.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    MaintenanceBlock maintenanceBlock, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (maintenanceBlock.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            maintenanceBlock.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            maintenanceBlock.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    MaintenanceBlock maintenanceBlock, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (maintenanceBlock.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            maintenanceBlock.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            maintenanceBlock.property = property;
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
MaintenanceBlock recursiveUpsert(MaintenanceBlock maintenanceBlock, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MaintenanceBlock'} 
        : const {};
    if (maintenanceBlock.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        maintenanceBlock.listing = ListingStore.instance.recursiveUpsert(maintenanceBlock.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (maintenanceBlock.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        maintenanceBlock.org = OrganizationStore.instance.recursiveUpsert(maintenanceBlock.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (maintenanceBlock.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        maintenanceBlock.property = PropertyStore.instance.recursiveUpsert(maintenanceBlock.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(maintenanceBlock);
}

  List<MaintenanceBlock> recursiveListUpsert(List<MaintenanceBlock> maintenanceBlocks, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMaintenanceBlocks = <MaintenanceBlock>[];
    for (var maintenanceBlock in maintenanceBlocks) {
        updatedMaintenanceBlocks.add(recursiveUpsert(maintenanceBlock, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMaintenanceBlocks;
}

//   @override
//   MaintenanceBlock upsert(MaintenanceBlock item) {
//     return recursiveUpsert(item);
//   }

}


class MaintenanceBlockInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MaintenanceBlockInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (maintenanceBlock) => MaintenanceBlockStore.instance
            .getListing$(maintenanceBlock, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (maintenanceBlock) => MaintenanceBlockStore.instance
            .getListing(maintenanceBlock, modelFilter: modelFilter, includes: includes);
      }
}

	MaintenanceBlockInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (maintenanceBlock) => MaintenanceBlockStore.instance
            .getOrg$(maintenanceBlock, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (maintenanceBlock) => MaintenanceBlockStore.instance
            .getOrg(maintenanceBlock, modelFilter: modelFilter, includes: includes);
      }
}

	MaintenanceBlockInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (maintenanceBlock) => MaintenanceBlockStore.instance
            .getProperty$(maintenanceBlock, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (maintenanceBlock) => MaintenanceBlockStore.instance
            .getProperty(maintenanceBlock, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MaintenanceBlockEndpoints implements Endpoint {

    getAll('/maintenanceBlock', HttpMethod.post, List<MaintenanceBlock>),
	getById('/maintenanceBlock/byId/:id', HttpMethod.post, MaintenanceBlock),
	getManyByOrgId('/maintenanceBlock/byOrgId/:orgId', HttpMethod.post, List<MaintenanceBlock>),
	getManyByPropertyId('/maintenanceBlock/byPropertyId/:propertyId', HttpMethod.post, List<MaintenanceBlock>),
	getManyByListingId('/maintenanceBlock/byListingId/:listingId', HttpMethod.post, List<MaintenanceBlock>),
	getManyByType('/maintenanceBlock/byType/:type', HttpMethod.post, List<MaintenanceBlock>),
	getManyByStartDate('/maintenanceBlock/byStartDate/:startDate', HttpMethod.post, List<MaintenanceBlock>),
	getManyByEndDate('/maintenanceBlock/byEndDate/:endDate', HttpMethod.post, List<MaintenanceBlock>),
	getManyByReason('/maintenanceBlock/byReason/:reason', HttpMethod.post, List<MaintenanceBlock>),
	getManyByCreatedBy('/maintenanceBlock/byCreatedBy/:createdBy', HttpMethod.post, List<MaintenanceBlock>),
	getManyByCreatedAt('/maintenanceBlock/byCreatedAt/:createdAt', HttpMethod.post, List<MaintenanceBlock>),
	getManyByUpdatedAt('/maintenanceBlock/byUpdatedAt/:updatedAt', HttpMethod.post, List<MaintenanceBlock>),
	getManyByDeletedAt('/maintenanceBlock/byDeletedAt/:deletedAt', HttpMethod.post, List<MaintenanceBlock>);

    const MaintenanceBlockEndpoints(this.path, this.method, this.responseType);

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
