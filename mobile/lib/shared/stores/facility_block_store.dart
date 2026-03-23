
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class FacilityBlockStore extends ModelStreamStore<String, FacilityBlock> {

  static FacilityBlockStore? _instance;

  static FacilityBlockStore get instance {
    _instance ??= FacilityBlockStore();
    return _instance!;
  }

  FacilityBlockStore() : super(FacilityBlock.fromJson) {
    if (_instance != null) {
        throw Exception(
            'FacilityBlockStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending FacilityBlockStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use FacilityBlockStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getFacilityBlockId(FacilityBlock facilityBlock) => facilityBlock.id;

	String? getFacilityBlockFacilityId(FacilityBlock facilityBlock) => facilityBlock.facilityId;

	String? getFacilityBlockName(FacilityBlock facilityBlock) => facilityBlock.name;

	int? getFacilityBlockFloors(FacilityBlock facilityBlock) => facilityBlock.floors;

	int? getFacilityBlockUnitsPerFloor(FacilityBlock facilityBlock) => facilityBlock.unitsPerFloor;

	int? getFacilityBlockTotalUnits(FacilityBlock facilityBlock) => facilityBlock.totalUnits;

	int? getFacilityBlockYearBuilt(FacilityBlock facilityBlock) => facilityBlock.yearBuilt;

	String? getFacilityBlockArchitect(FacilityBlock facilityBlock) => facilityBlock.architect;

	List<String>? getFacilityBlockFeatures(FacilityBlock facilityBlock) => facilityBlock.features;

	List<String>? getFacilityBlockImages(FacilityBlock facilityBlock) => facilityBlock.images;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<FacilityBlock> getByFacilityId(
    String facilityId,
    {ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}
    ) =>
    getManyIncluding(getFacilityBlockFacilityId, facilityId, modelFilter: modelFilter, includes: includes);

	
List<FacilityBlock> getByName(
    String name,
    {ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}
    ) =>
    getManyIncluding(getFacilityBlockName, name, modelFilter: modelFilter, includes: includes);

	
List<FacilityBlock> getByFloors(
    int floors,
    {ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}
    ) =>
    getManyIncluding(getFacilityBlockFloors, floors, modelFilter: modelFilter, includes: includes);

	
List<FacilityBlock> getByUnitsPerFloor(
    int unitsPerFloor,
    {ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}
    ) =>
    getManyIncluding(getFacilityBlockUnitsPerFloor, unitsPerFloor, modelFilter: modelFilter, includes: includes);

	
List<FacilityBlock> getByTotalUnits(
    int totalUnits,
    {ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}
    ) =>
    getManyIncluding(getFacilityBlockTotalUnits, totalUnits, modelFilter: modelFilter, includes: includes);

	
List<FacilityBlock> getByYearBuilt(
    int yearBuilt,
    {ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}
    ) =>
    getManyIncluding(getFacilityBlockYearBuilt, yearBuilt, modelFilter: modelFilter, includes: includes);

	
List<FacilityBlock> getByArchitect(
    String architect,
    {ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}
    ) =>
    getManyIncluding(getFacilityBlockArchitect, architect, modelFilter: modelFilter, includes: includes);

	
List<FacilityBlock> getByFeatures(
    String features,
    {ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}
    ) =>
    getManyIncluding(getFacilityBlockFeatures, features, modelFilter: modelFilter, includes: includes);

	
List<FacilityBlock> getByImages(
    String images,
    {ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}
    ) =>
    getManyIncluding(getFacilityBlockImages, images, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Facility? getFacility(
    FacilityBlock facilityBlock, {ModelFilter? modelFilter, List<FacilityInclude>? includes}) {
    if (facilityBlock.facilityId == null) {
        return null;
    } else {
        final facility = FacilityStore.instance.getById(facilityBlock.facilityId!, includes: includes);
        facilityBlock.facility = facility;
        // setIncludedReferences(facility, includes: includes);
        return facility;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<FacilityBlock>> getAll$({bool useCache = true, ModelFilter<FacilityBlock>? modelFilter, List<FacilityBlockInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: FacilityBlockEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<FacilityBlock?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<FacilityBlock>? modelFilter,
        List<FacilityBlockInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getFacilityBlockId,
        value: id,
        modelFilter: modelFilter,
        endpoint: FacilityBlockEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<FacilityBlock>> getByFacilityId$(
        String facilityId,
        {bool useCache = true,
        ModelFilter<FacilityBlock>? modelFilter,
        List<FacilityBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFacilityBlockFacilityId,
        value: facilityId,
        modelFilter: modelFilter,
        endpoint: FacilityBlockEndpoints.getManyByFacilityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FacilityBlock>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<FacilityBlock>? modelFilter,
        List<FacilityBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFacilityBlockName,
        value: name,
        modelFilter: modelFilter,
        endpoint: FacilityBlockEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FacilityBlock>> getByFloors$(
        int floors,
        {bool useCache = true,
        ModelFilter<FacilityBlock>? modelFilter,
        List<FacilityBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getFacilityBlockFloors,
        value: floors,
        modelFilter: modelFilter,
        endpoint: FacilityBlockEndpoints.getManyByFloors,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FacilityBlock>> getByUnitsPerFloor$(
        int unitsPerFloor,
        {bool useCache = true,
        ModelFilter<FacilityBlock>? modelFilter,
        List<FacilityBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getFacilityBlockUnitsPerFloor,
        value: unitsPerFloor,
        modelFilter: modelFilter,
        endpoint: FacilityBlockEndpoints.getManyByUnitsPerFloor,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FacilityBlock>> getByTotalUnits$(
        int totalUnits,
        {bool useCache = true,
        ModelFilter<FacilityBlock>? modelFilter,
        List<FacilityBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getFacilityBlockTotalUnits,
        value: totalUnits,
        modelFilter: modelFilter,
        endpoint: FacilityBlockEndpoints.getManyByTotalUnits,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FacilityBlock>> getByYearBuilt$(
        int yearBuilt,
        {bool useCache = true,
        ModelFilter<FacilityBlock>? modelFilter,
        List<FacilityBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getFacilityBlockYearBuilt,
        value: yearBuilt,
        modelFilter: modelFilter,
        endpoint: FacilityBlockEndpoints.getManyByYearBuilt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FacilityBlock>> getByArchitect$(
        String architect,
        {bool useCache = true,
        ModelFilter<FacilityBlock>? modelFilter,
        List<FacilityBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFacilityBlockArchitect,
        value: architect,
        modelFilter: modelFilter,
        endpoint: FacilityBlockEndpoints.getManyByArchitect,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FacilityBlock>> getByFeatures$(
        String features,
        {bool useCache = true,
        ModelFilter<FacilityBlock>? modelFilter,
        List<FacilityBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFacilityBlockFeatures,
        value: features,
        modelFilter: modelFilter,
        endpoint: FacilityBlockEndpoints.getManyByFeatures,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<FacilityBlock>> getByImages$(
        String images,
        {bool useCache = true,
        ModelFilter<FacilityBlock>? modelFilter,
        List<FacilityBlockInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getFacilityBlockImages,
        value: images,
        modelFilter: modelFilter,
        endpoint: FacilityBlockEndpoints.getManyByImages,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Facility?> getFacility$(
    FacilityBlock facilityBlock, {bool useCache = true, ModelFilter<Facility>? modelFilter, List<FacilityInclude>? includes}) {
    if (facilityBlock.facilityId == null) {
        return Stream.value(null);
    } else {
        return FacilityStore.instance.getById$(
            facilityBlock.facilityId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((facility) {
            facilityBlock.facility = facility;
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
FacilityBlock recursiveUpsert(FacilityBlock facilityBlock, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'FacilityBlock'} 
        : const {};
    if (facilityBlock.facility != null && (!preventCircularSerialization || !upsertedTypes.contains('Facility'))) {
        facilityBlock.facility = FacilityStore.instance.recursiveUpsert(facilityBlock.facility!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(facilityBlock);
}

  List<FacilityBlock> recursiveListUpsert(List<FacilityBlock> facilityBlocks, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedFacilityBlocks = <FacilityBlock>[];
    for (var facilityBlock in facilityBlocks) {
        updatedFacilityBlocks.add(recursiveUpsert(facilityBlock, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedFacilityBlocks;
}

//   @override
//   FacilityBlock upsert(FacilityBlock item) {
//     return recursiveUpsert(item);
//   }

}


class FacilityBlockInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      FacilityBlockInclude.facility({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Facility>? modelFilter,
    List<FacilityInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (facilityBlock) => FacilityBlockStore.instance
            .getFacility$(facilityBlock, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (facilityBlock) => FacilityBlockStore.instance
            .getFacility(facilityBlock, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum FacilityBlockEndpoints implements Endpoint {

    getAll('/facilityBlock', HttpMethod.post, List<FacilityBlock>),
	getById('/facilityBlock/byId/:id', HttpMethod.post, FacilityBlock),
	getManyByFacilityId('/facilityBlock/byFacilityId/:facilityId', HttpMethod.post, List<FacilityBlock>),
	getManyByName('/facilityBlock/byName/:name', HttpMethod.post, List<FacilityBlock>),
	getManyByFloors('/facilityBlock/byFloors/:floors', HttpMethod.post, List<FacilityBlock>),
	getManyByUnitsPerFloor('/facilityBlock/byUnitsPerFloor/:unitsPerFloor', HttpMethod.post, List<FacilityBlock>),
	getManyByTotalUnits('/facilityBlock/byTotalUnits/:totalUnits', HttpMethod.post, List<FacilityBlock>),
	getManyByYearBuilt('/facilityBlock/byYearBuilt/:yearBuilt', HttpMethod.post, List<FacilityBlock>),
	getManyByArchitect('/facilityBlock/byArchitect/:architect', HttpMethod.post, List<FacilityBlock>),
	getManyByFeatures('/facilityBlock/byFeatures/:features', HttpMethod.post, List<FacilityBlock>),
	getManyByImages('/facilityBlock/byImages/:images', HttpMethod.post, List<FacilityBlock>);

    const FacilityBlockEndpoints(this.path, this.method, this.responseType);

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
