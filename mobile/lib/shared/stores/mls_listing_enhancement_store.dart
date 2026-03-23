
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MlsListingEnhancementStore extends ModelStreamStore<String, MlsListingEnhancement> {

  static MlsListingEnhancementStore? _instance;

  static MlsListingEnhancementStore get instance {
    _instance ??= MlsListingEnhancementStore();
    return _instance!;
  }

  MlsListingEnhancementStore() : super(MlsListingEnhancement.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MlsListingEnhancementStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MlsListingEnhancementStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MlsListingEnhancementStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMlsListingEnhancementId(MlsListingEnhancement mlsListingEnhancement) => mlsListingEnhancement.id;

	String? getMlsListingEnhancementOrgId(MlsListingEnhancement mlsListingEnhancement) => mlsListingEnhancement.orgId;

	String? getMlsListingEnhancementListingId(MlsListingEnhancement mlsListingEnhancement) => mlsListingEnhancement.listingId;

	String? getMlsListingEnhancementMlsNumber(MlsListingEnhancement mlsListingEnhancement) => mlsListingEnhancement.mlsNumber;

	String? getMlsListingEnhancementMlsStatus(MlsListingEnhancement mlsListingEnhancement) => mlsListingEnhancement.mlsStatus;

	dynamic? getMlsListingEnhancementMlsPhotos(MlsListingEnhancement mlsListingEnhancement) => mlsListingEnhancement.mlsPhotos;

	dynamic? getMlsListingEnhancementMlsDocuments(MlsListingEnhancement mlsListingEnhancement) => mlsListingEnhancement.mlsDocuments;

	dynamic? getMlsListingEnhancementMlsHistory(MlsListingEnhancement mlsListingEnhancement) => mlsListingEnhancement.mlsHistory;

	DateTime? getMlsListingEnhancementLastMlsUpdate(MlsListingEnhancement mlsListingEnhancement) => mlsListingEnhancement.lastMlsUpdate;

	DateTime? getMlsListingEnhancementCreatedAt(MlsListingEnhancement mlsListingEnhancement) => mlsListingEnhancement.createdAt;

	DateTime? getMlsListingEnhancementUpdatedAt(MlsListingEnhancement mlsListingEnhancement) => mlsListingEnhancement.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
MlsListingEnhancement? getByListingId(
    String listingId,
    {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}
    ) =>
    getIncluding(getMlsListingEnhancementListingId, listingId, modelFilter: modelFilter, includes: includes);

  
List<MlsListingEnhancement> getByOrgId(
    String orgId,
    {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}
    ) =>
    getManyIncluding(getMlsListingEnhancementOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<MlsListingEnhancement> getByMlsNumber(
    String mlsNumber,
    {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}
    ) =>
    getManyIncluding(getMlsListingEnhancementMlsNumber, mlsNumber, modelFilter: modelFilter, includes: includes);

	
List<MlsListingEnhancement> getByMlsStatus(
    String mlsStatus,
    {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}
    ) =>
    getManyIncluding(getMlsListingEnhancementMlsStatus, mlsStatus, modelFilter: modelFilter, includes: includes);

	
List<MlsListingEnhancement> getByMlsPhotos(
    dynamic mlsPhotos,
    {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}
    ) =>
    getManyIncluding(getMlsListingEnhancementMlsPhotos, mlsPhotos, modelFilter: modelFilter, includes: includes);

	
List<MlsListingEnhancement> getByMlsDocuments(
    dynamic mlsDocuments,
    {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}
    ) =>
    getManyIncluding(getMlsListingEnhancementMlsDocuments, mlsDocuments, modelFilter: modelFilter, includes: includes);

	
List<MlsListingEnhancement> getByMlsHistory(
    dynamic mlsHistory,
    {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}
    ) =>
    getManyIncluding(getMlsListingEnhancementMlsHistory, mlsHistory, modelFilter: modelFilter, includes: includes);

	
List<MlsListingEnhancement> getByLastMlsUpdate(
    DateTime lastMlsUpdate,
    {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}
    ) =>
    getManyIncluding(getMlsListingEnhancementLastMlsUpdate, lastMlsUpdate, modelFilter: modelFilter, includes: includes);

	
List<MlsListingEnhancement> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}
    ) =>
    getManyIncluding(getMlsListingEnhancementCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MlsListingEnhancement> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}
    ) =>
    getManyIncluding(getMlsListingEnhancementUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Listing? getListing(
    MlsListingEnhancement mlsListingEnhancement, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (mlsListingEnhancement.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(mlsListingEnhancement.listingId!, includes: includes);
        mlsListingEnhancement.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    MlsListingEnhancement mlsListingEnhancement, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (mlsListingEnhancement.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(mlsListingEnhancement.orgId!, includes: includes);
        mlsListingEnhancement.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MlsListingEnhancement>> getAll$({bool useCache = true, ModelFilter<MlsListingEnhancement>? modelFilter, List<MlsListingEnhancementInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MlsListingEnhancementEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MlsListingEnhancement?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MlsListingEnhancement>? modelFilter,
        List<MlsListingEnhancementInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMlsListingEnhancementId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MlsListingEnhancementEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<MlsListingEnhancement?> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<MlsListingEnhancement>? modelFilter,
        List<MlsListingEnhancementInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMlsListingEnhancementListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: MlsListingEnhancementEndpoints.getByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MlsListingEnhancement>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<MlsListingEnhancement>? modelFilter,
        List<MlsListingEnhancementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMlsListingEnhancementOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MlsListingEnhancementEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsListingEnhancement>> getByMlsNumber$(
        String mlsNumber,
        {bool useCache = true,
        ModelFilter<MlsListingEnhancement>? modelFilter,
        List<MlsListingEnhancementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMlsListingEnhancementMlsNumber,
        value: mlsNumber,
        modelFilter: modelFilter,
        endpoint: MlsListingEnhancementEndpoints.getManyByMlsNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsListingEnhancement>> getByMlsStatus$(
        String mlsStatus,
        {bool useCache = true,
        ModelFilter<MlsListingEnhancement>? modelFilter,
        List<MlsListingEnhancementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMlsListingEnhancementMlsStatus,
        value: mlsStatus,
        modelFilter: modelFilter,
        endpoint: MlsListingEnhancementEndpoints.getManyByMlsStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsListingEnhancement>> getByMlsPhotos$(
        dynamic mlsPhotos,
        {bool useCache = true,
        ModelFilter<MlsListingEnhancement>? modelFilter,
        List<MlsListingEnhancementInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMlsListingEnhancementMlsPhotos,
        value: mlsPhotos,
        modelFilter: modelFilter,
        endpoint: MlsListingEnhancementEndpoints.getManyByMlsPhotos,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsListingEnhancement>> getByMlsDocuments$(
        dynamic mlsDocuments,
        {bool useCache = true,
        ModelFilter<MlsListingEnhancement>? modelFilter,
        List<MlsListingEnhancementInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMlsListingEnhancementMlsDocuments,
        value: mlsDocuments,
        modelFilter: modelFilter,
        endpoint: MlsListingEnhancementEndpoints.getManyByMlsDocuments,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsListingEnhancement>> getByMlsHistory$(
        dynamic mlsHistory,
        {bool useCache = true,
        ModelFilter<MlsListingEnhancement>? modelFilter,
        List<MlsListingEnhancementInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMlsListingEnhancementMlsHistory,
        value: mlsHistory,
        modelFilter: modelFilter,
        endpoint: MlsListingEnhancementEndpoints.getManyByMlsHistory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsListingEnhancement>> getByLastMlsUpdate$(
        DateTime lastMlsUpdate,
        {bool useCache = true,
        ModelFilter<MlsListingEnhancement>? modelFilter,
        List<MlsListingEnhancementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMlsListingEnhancementLastMlsUpdate,
        value: lastMlsUpdate,
        modelFilter: modelFilter,
        endpoint: MlsListingEnhancementEndpoints.getManyByLastMlsUpdate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsListingEnhancement>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MlsListingEnhancement>? modelFilter,
        List<MlsListingEnhancementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMlsListingEnhancementCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MlsListingEnhancementEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsListingEnhancement>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MlsListingEnhancement>? modelFilter,
        List<MlsListingEnhancementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMlsListingEnhancementUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MlsListingEnhancementEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Listing?> getListing$(
    MlsListingEnhancement mlsListingEnhancement, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (mlsListingEnhancement.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            mlsListingEnhancement.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            mlsListingEnhancement.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    MlsListingEnhancement mlsListingEnhancement, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (mlsListingEnhancement.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            mlsListingEnhancement.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            mlsListingEnhancement.org = org;
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
MlsListingEnhancement recursiveUpsert(MlsListingEnhancement mlsListingEnhancement, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MlsListingEnhancement'} 
        : const {};
    if (mlsListingEnhancement.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        mlsListingEnhancement.listing = ListingStore.instance.recursiveUpsert(mlsListingEnhancement.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mlsListingEnhancement.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        mlsListingEnhancement.org = OrganizationStore.instance.recursiveUpsert(mlsListingEnhancement.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(mlsListingEnhancement);
}

  List<MlsListingEnhancement> recursiveListUpsert(List<MlsListingEnhancement> mlsListingEnhancements, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMlsListingEnhancements = <MlsListingEnhancement>[];
    for (var mlsListingEnhancement in mlsListingEnhancements) {
        updatedMlsListingEnhancements.add(recursiveUpsert(mlsListingEnhancement, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMlsListingEnhancements;
}

//   @override
//   MlsListingEnhancement upsert(MlsListingEnhancement item) {
//     return recursiveUpsert(item);
//   }

}


class MlsListingEnhancementInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MlsListingEnhancementInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mlsListingEnhancement) => MlsListingEnhancementStore.instance
            .getListing$(mlsListingEnhancement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mlsListingEnhancement) => MlsListingEnhancementStore.instance
            .getListing(mlsListingEnhancement, modelFilter: modelFilter, includes: includes);
      }
}

	MlsListingEnhancementInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mlsListingEnhancement) => MlsListingEnhancementStore.instance
            .getOrg$(mlsListingEnhancement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mlsListingEnhancement) => MlsListingEnhancementStore.instance
            .getOrg(mlsListingEnhancement, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MlsListingEnhancementEndpoints implements Endpoint {

    getAll('/mlsListingEnhancement', HttpMethod.post, List<MlsListingEnhancement>),
	getById('/mlsListingEnhancement/byId/:id', HttpMethod.post, MlsListingEnhancement),
	getManyByOrgId('/mlsListingEnhancement/byOrgId/:orgId', HttpMethod.post, List<MlsListingEnhancement>),
	getByListingId('/mlsListingEnhancement/byListingId/:listingId', HttpMethod.post, MlsListingEnhancement),
	getManyByMlsNumber('/mlsListingEnhancement/byMlsNumber/:mlsNumber', HttpMethod.post, List<MlsListingEnhancement>),
	getManyByMlsStatus('/mlsListingEnhancement/byMlsStatus/:mlsStatus', HttpMethod.post, List<MlsListingEnhancement>),
	getManyByMlsPhotos('/mlsListingEnhancement/byMlsPhotos/:mlsPhotos', HttpMethod.post, List<MlsListingEnhancement>),
	getManyByMlsDocuments('/mlsListingEnhancement/byMlsDocuments/:mlsDocuments', HttpMethod.post, List<MlsListingEnhancement>),
	getManyByMlsHistory('/mlsListingEnhancement/byMlsHistory/:mlsHistory', HttpMethod.post, List<MlsListingEnhancement>),
	getManyByLastMlsUpdate('/mlsListingEnhancement/byLastMlsUpdate/:lastMlsUpdate', HttpMethod.post, List<MlsListingEnhancement>),
	getManyByCreatedAt('/mlsListingEnhancement/byCreatedAt/:createdAt', HttpMethod.post, List<MlsListingEnhancement>),
	getManyByUpdatedAt('/mlsListingEnhancement/byUpdatedAt/:updatedAt', HttpMethod.post, List<MlsListingEnhancement>);

    const MlsListingEnhancementEndpoints(this.path, this.method, this.responseType);

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
