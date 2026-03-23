
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class TaxDepreciationStore extends ModelStreamStore<String, TaxDepreciation> {

  static TaxDepreciationStore? _instance;

  static TaxDepreciationStore get instance {
    _instance ??= TaxDepreciationStore();
    return _instance!;
  }

  TaxDepreciationStore() : super(TaxDepreciation.fromJson) {
    if (_instance != null) {
        throw Exception(
            'TaxDepreciationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending TaxDepreciationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use TaxDepreciationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getTaxDepreciationId(TaxDepreciation taxDepreciation) => taxDepreciation.id;

	String? getTaxDepreciationPropertyId(TaxDepreciation taxDepreciation) => taxDepreciation.propertyId;

	AssetType? getTaxDepreciationAssetType(TaxDepreciation taxDepreciation) => taxDepreciation.assetType;

	double? getTaxDepreciationCostBasis(TaxDepreciation taxDepreciation) => taxDepreciation.costBasis;

	DepreciationMethod? getTaxDepreciationDepreciationMethod(TaxDepreciation taxDepreciation) => taxDepreciation.depreciationMethod;

	int? getTaxDepreciationUsefulLife(TaxDepreciation taxDepreciation) => taxDepreciation.usefulLife;

	double? getTaxDepreciationSalvageValue(TaxDepreciation taxDepreciation) => taxDepreciation.salvageValue;

	DateTime? getTaxDepreciationStartDate(TaxDepreciation taxDepreciation) => taxDepreciation.startDate;

	double? getTaxDepreciationAccumulatedDepreciation(TaxDepreciation taxDepreciation) => taxDepreciation.accumulatedDepreciation;

	String? getTaxDepreciationOrganizationId(TaxDepreciation taxDepreciation) => taxDepreciation.organizationId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<TaxDepreciation> getByPropertyId(
    String propertyId,
    {ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}
    ) =>
    getManyIncluding(getTaxDepreciationPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<TaxDepreciation> getByAssetType(
    AssetType assetType,
    {ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}
    ) =>
    getManyIncluding(getTaxDepreciationAssetType, assetType, modelFilter: modelFilter, includes: includes);

	
List<TaxDepreciation> getByCostBasis(
    double costBasis,
    {ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}
    ) =>
    getManyIncluding(getTaxDepreciationCostBasis, costBasis, modelFilter: modelFilter, includes: includes);

	
List<TaxDepreciation> getByDepreciationMethod(
    DepreciationMethod depreciationMethod,
    {ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}
    ) =>
    getManyIncluding(getTaxDepreciationDepreciationMethod, depreciationMethod, modelFilter: modelFilter, includes: includes);

	
List<TaxDepreciation> getByUsefulLife(
    int usefulLife,
    {ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}
    ) =>
    getManyIncluding(getTaxDepreciationUsefulLife, usefulLife, modelFilter: modelFilter, includes: includes);

	
List<TaxDepreciation> getBySalvageValue(
    double salvageValue,
    {ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}
    ) =>
    getManyIncluding(getTaxDepreciationSalvageValue, salvageValue, modelFilter: modelFilter, includes: includes);

	
List<TaxDepreciation> getByStartDate(
    DateTime startDate,
    {ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}
    ) =>
    getManyIncluding(getTaxDepreciationStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<TaxDepreciation> getByAccumulatedDepreciation(
    double accumulatedDepreciation,
    {ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}
    ) =>
    getManyIncluding(getTaxDepreciationAccumulatedDepreciation, accumulatedDepreciation, modelFilter: modelFilter, includes: includes);

	
List<TaxDepreciation> getByOrganizationId(
    String organizationId,
    {ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}
    ) =>
    getManyIncluding(getTaxDepreciationOrganizationId, organizationId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrganization(
    TaxDepreciation taxDepreciation, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (taxDepreciation.organizationId == null) {
        return null;
    } else {
        final organization = OrganizationStore.instance.getById(taxDepreciation.organizationId!, includes: includes);
        taxDepreciation.organization = organization;
        // setIncludedReferences(organization, includes: includes);
        return organization;
    }
}

	Property? getProperty(
    TaxDepreciation taxDepreciation, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (taxDepreciation.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(taxDepreciation.propertyId!, includes: includes);
        taxDepreciation.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<TaxDepreciation>> getAll$({bool useCache = true, ModelFilter<TaxDepreciation>? modelFilter, List<TaxDepreciationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: TaxDepreciationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<TaxDepreciation?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<TaxDepreciation>? modelFilter,
        List<TaxDepreciationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getTaxDepreciationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: TaxDepreciationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<TaxDepreciation>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<TaxDepreciation>? modelFilter,
        List<TaxDepreciationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaxDepreciationPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: TaxDepreciationEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxDepreciation>> getByAssetType$(
        AssetType assetType,
        {bool useCache = true,
        ModelFilter<TaxDepreciation>? modelFilter,
        List<TaxDepreciationInclude>? includes}) {
    final items$ = getManyByFieldValue$<AssetType>(
        getPropVal: getTaxDepreciationAssetType,
        value: assetType,
        modelFilter: modelFilter,
        endpoint: TaxDepreciationEndpoints.getManyByAssetType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxDepreciation>> getByCostBasis$(
        double costBasis,
        {bool useCache = true,
        ModelFilter<TaxDepreciation>? modelFilter,
        List<TaxDepreciationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getTaxDepreciationCostBasis,
        value: costBasis,
        modelFilter: modelFilter,
        endpoint: TaxDepreciationEndpoints.getManyByCostBasis,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxDepreciation>> getByDepreciationMethod$(
        DepreciationMethod depreciationMethod,
        {bool useCache = true,
        ModelFilter<TaxDepreciation>? modelFilter,
        List<TaxDepreciationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DepreciationMethod>(
        getPropVal: getTaxDepreciationDepreciationMethod,
        value: depreciationMethod,
        modelFilter: modelFilter,
        endpoint: TaxDepreciationEndpoints.getManyByDepreciationMethod,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxDepreciation>> getByUsefulLife$(
        int usefulLife,
        {bool useCache = true,
        ModelFilter<TaxDepreciation>? modelFilter,
        List<TaxDepreciationInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getTaxDepreciationUsefulLife,
        value: usefulLife,
        modelFilter: modelFilter,
        endpoint: TaxDepreciationEndpoints.getManyByUsefulLife,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxDepreciation>> getBySalvageValue$(
        double salvageValue,
        {bool useCache = true,
        ModelFilter<TaxDepreciation>? modelFilter,
        List<TaxDepreciationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getTaxDepreciationSalvageValue,
        value: salvageValue,
        modelFilter: modelFilter,
        endpoint: TaxDepreciationEndpoints.getManyBySalvageValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxDepreciation>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<TaxDepreciation>? modelFilter,
        List<TaxDepreciationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTaxDepreciationStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: TaxDepreciationEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxDepreciation>> getByAccumulatedDepreciation$(
        double accumulatedDepreciation,
        {bool useCache = true,
        ModelFilter<TaxDepreciation>? modelFilter,
        List<TaxDepreciationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getTaxDepreciationAccumulatedDepreciation,
        value: accumulatedDepreciation,
        modelFilter: modelFilter,
        endpoint: TaxDepreciationEndpoints.getManyByAccumulatedDepreciation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxDepreciation>> getByOrganizationId$(
        String organizationId,
        {bool useCache = true,
        ModelFilter<TaxDepreciation>? modelFilter,
        List<TaxDepreciationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaxDepreciationOrganizationId,
        value: organizationId,
        modelFilter: modelFilter,
        endpoint: TaxDepreciationEndpoints.getManyByOrganizationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrganization$(
    TaxDepreciation taxDepreciation, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (taxDepreciation.organizationId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            taxDepreciation.organizationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((organization) {
            taxDepreciation.organization = organization;
        });
    }
}

	Stream<Property?> getProperty$(
    TaxDepreciation taxDepreciation, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (taxDepreciation.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            taxDepreciation.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            taxDepreciation.property = property;
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
TaxDepreciation recursiveUpsert(TaxDepreciation taxDepreciation, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'TaxDepreciation'} 
        : const {};
    if (taxDepreciation.organization != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        taxDepreciation.organization = OrganizationStore.instance.recursiveUpsert(taxDepreciation.organization!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (taxDepreciation.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        taxDepreciation.property = PropertyStore.instance.recursiveUpsert(taxDepreciation.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(taxDepreciation);
}

  List<TaxDepreciation> recursiveListUpsert(List<TaxDepreciation> taxDepreciations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedTaxDepreciations = <TaxDepreciation>[];
    for (var taxDepreciation in taxDepreciations) {
        updatedTaxDepreciations.add(recursiveUpsert(taxDepreciation, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedTaxDepreciations;
}

//   @override
//   TaxDepreciation upsert(TaxDepreciation item) {
//     return recursiveUpsert(item);
//   }

}


class TaxDepreciationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      TaxDepreciationInclude.organization({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (taxDepreciation) => TaxDepreciationStore.instance
            .getOrganization$(taxDepreciation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (taxDepreciation) => TaxDepreciationStore.instance
            .getOrganization(taxDepreciation, modelFilter: modelFilter, includes: includes);
      }
}

	TaxDepreciationInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (taxDepreciation) => TaxDepreciationStore.instance
            .getProperty$(taxDepreciation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (taxDepreciation) => TaxDepreciationStore.instance
            .getProperty(taxDepreciation, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum TaxDepreciationEndpoints implements Endpoint {

    getAll('/taxDepreciation', HttpMethod.post, List<TaxDepreciation>),
	getById('/taxDepreciation/byId/:id', HttpMethod.post, TaxDepreciation),
	getManyByPropertyId('/taxDepreciation/byPropertyId/:propertyId', HttpMethod.post, List<TaxDepreciation>),
	getManyByAssetType('/taxDepreciation/byAssetType/:assetType', HttpMethod.post, List<TaxDepreciation>),
	getManyByCostBasis('/taxDepreciation/byCostBasis/:costBasis', HttpMethod.post, List<TaxDepreciation>),
	getManyByDepreciationMethod('/taxDepreciation/byDepreciationMethod/:depreciationMethod', HttpMethod.post, List<TaxDepreciation>),
	getManyByUsefulLife('/taxDepreciation/byUsefulLife/:usefulLife', HttpMethod.post, List<TaxDepreciation>),
	getManyBySalvageValue('/taxDepreciation/bySalvageValue/:salvageValue', HttpMethod.post, List<TaxDepreciation>),
	getManyByStartDate('/taxDepreciation/byStartDate/:startDate', HttpMethod.post, List<TaxDepreciation>),
	getManyByAccumulatedDepreciation('/taxDepreciation/byAccumulatedDepreciation/:accumulatedDepreciation', HttpMethod.post, List<TaxDepreciation>),
	getManyByOrganizationId('/taxDepreciation/byOrganizationId/:organizationId', HttpMethod.post, List<TaxDepreciation>);

    const TaxDepreciationEndpoints(this.path, this.method, this.responseType);

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
