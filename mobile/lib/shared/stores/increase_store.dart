
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class IncreaseStore extends ModelStreamStore<String, Increase> {

  static IncreaseStore? _instance;

  static IncreaseStore get instance {
    _instance ??= IncreaseStore();
    return _instance!;
  }

  IncreaseStore() : super(Increase.fromJson) {
    if (_instance != null) {
        throw Exception(
            'IncreaseStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending IncreaseStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use IncreaseStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getIncreaseId(Increase increase) => increase.id;

	String? getIncreasePropertyId(Increase increase) => increase.propertyId;

	String? getIncreaseTenantId(Increase increase) => increase.tenantId;

	String? getIncreaseProposedBy(Increase increase) => increase.proposedBy;

	double? getIncreaseOldRent(Increase increase) => increase.oldRent;

	double? getIncreaseNewRent(Increase increase) => increase.newRent;

	DateTime? getIncreaseEffectiveDate(Increase increase) => increase.effectiveDate;

	IncreaseStatus? getIncreaseStatus(Increase increase) => increase.status;

	DateTime? getIncreaseCreatedAt(Increase increase) => increase.createdAt;

	DateTime? getIncreaseUpdatedAt(Increase increase) => increase.updatedAt;

	DateTime? getIncreaseDeletedAt(Increase increase) => increase.deletedAt;

	String? getIncreaseContractId(Increase increase) => increase.contractId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Increase> getByPropertyId(
    String propertyId,
    {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}
    ) =>
    getManyIncluding(getIncreasePropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Increase> getByTenantId(
    String tenantId,
    {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}
    ) =>
    getManyIncluding(getIncreaseTenantId, tenantId, modelFilter: modelFilter, includes: includes);

	
List<Increase> getByProposedBy(
    String proposedBy,
    {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}
    ) =>
    getManyIncluding(getIncreaseProposedBy, proposedBy, modelFilter: modelFilter, includes: includes);

	
List<Increase> getByOldRent(
    double oldRent,
    {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}
    ) =>
    getManyIncluding(getIncreaseOldRent, oldRent, modelFilter: modelFilter, includes: includes);

	
List<Increase> getByNewRent(
    double newRent,
    {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}
    ) =>
    getManyIncluding(getIncreaseNewRent, newRent, modelFilter: modelFilter, includes: includes);

	
List<Increase> getByEffectiveDate(
    DateTime effectiveDate,
    {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}
    ) =>
    getManyIncluding(getIncreaseEffectiveDate, effectiveDate, modelFilter: modelFilter, includes: includes);

	
List<Increase> getByStatus(
    IncreaseStatus status,
    {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}
    ) =>
    getManyIncluding(getIncreaseStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Increase> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}
    ) =>
    getManyIncluding(getIncreaseCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Increase> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}
    ) =>
    getManyIncluding(getIncreaseUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Increase> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}
    ) =>
    getManyIncluding(getIncreaseDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Increase> getByContractId(
    String contractId,
    {ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}
    ) =>
    getManyIncluding(getIncreaseContractId, contractId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contract? getContract(
    Increase increase, {ModelFilter? modelFilter, List<ContractInclude>? includes}) {
    if (increase.contractId == null) {
        return null;
    } else {
        final Contract = ContractStore.instance.getById(increase.contractId!, includes: includes);
        increase.Contract = Contract;
        // setIncludedReferences(Contract, includes: includes);
        return Contract;
    }
}

	Property? getProperty(
    Increase increase, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (increase.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(increase.propertyId!, includes: includes);
        increase.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

	Tenant? getTenant(
    Increase increase, {ModelFilter? modelFilter, List<TenantInclude>? includes}) {
    if (increase.tenantId == null) {
        return null;
    } else {
        final Tenant = TenantStore.instance.getById(increase.tenantId!, includes: includes);
        increase.Tenant = Tenant;
        // setIncludedReferences(Tenant, includes: includes);
        return Tenant;
    }
}

  /// GET RELATED MODELS 

  Offer? getOffer(
    Increase increase, {ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}) {
    final Offer = OfferStore.instance.getByIncreaseId(increase.$uid!, modelFilter: modelFilter, includes: includes);
    increase.Offer = Offer;
    // setIncludedReferences(Offer, includes: includes);
    return Offer;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Increase>> getAll$({bool useCache = true, ModelFilter<Increase>? modelFilter, List<IncreaseInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: IncreaseEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Increase?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getIncreaseId,
        value: id,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Increase>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIncreasePropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Increase>> getByTenantId$(
        String tenantId,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIncreaseTenantId,
        value: tenantId,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getManyByTenantId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Increase>> getByProposedBy$(
        String proposedBy,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIncreaseProposedBy,
        value: proposedBy,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getManyByProposedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Increase>> getByOldRent$(
        double oldRent,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getIncreaseOldRent,
        value: oldRent,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getManyByOldRent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Increase>> getByNewRent$(
        double newRent,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getIncreaseNewRent,
        value: newRent,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getManyByNewRent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Increase>> getByEffectiveDate$(
        DateTime effectiveDate,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getIncreaseEffectiveDate,
        value: effectiveDate,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getManyByEffectiveDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Increase>> getByStatus$(
        IncreaseStatus status,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<IncreaseStatus>(
        getPropVal: getIncreaseStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Increase>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getIncreaseCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Increase>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getIncreaseUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Increase>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getIncreaseDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Increase>> getByContractId$(
        String contractId,
        {bool useCache = true,
        ModelFilter<Increase>? modelFilter,
        List<IncreaseInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getIncreaseContractId,
        value: contractId,
        modelFilter: modelFilter,
        endpoint: IncreaseEndpoints.getManyByContractId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contract?> getContract$(
    Increase increase, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    if (increase.contractId == null) {
        return Stream.value(null);
    } else {
        return ContractStore.instance.getById$(
            increase.contractId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Contract) {
            increase.Contract = Contract;
        });
    }
}

	Stream<Property?> getProperty$(
    Increase increase, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (increase.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            increase.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            increase.Property = Property;
        });
    }
}

	Stream<Tenant?> getTenant$(
    Increase increase, {bool useCache = true, ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    if (increase.tenantId == null) {
        return Stream.value(null);
    } else {
        return TenantStore.instance.getById$(
            increase.tenantId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Tenant) {
            increase.Tenant = Tenant;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<Offer?> getOffer$(
    Increase increase, {bool useCache = true, ModelFilter<Offer>? modelFilter, List<OfferInclude>? includes}) {
    return OfferStore.instance.getByIncreaseId$(
        increase.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Offer) {
        increase.Offer = Offer;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Increase recursiveUpsert(Increase increase, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Increase'} 
        : const {};
    if (increase.Contract != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        increase.Contract = ContractStore.instance.recursiveUpsert(increase.Contract!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (increase.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        increase.Property = PropertyStore.instance.recursiveUpsert(increase.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (increase.Tenant != null && (!preventCircularSerialization || !upsertedTypes.contains('Tenant'))) {
        increase.Tenant = TenantStore.instance.recursiveUpsert(increase.Tenant!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (increase.Offer != null && (!preventCircularSerialization || !upsertedTypes.contains('Offer'))) {
        increase.Offer = OfferStore.instance.recursiveUpsert(increase.Offer!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(increase);
}

  List<Increase> recursiveListUpsert(List<Increase> increases, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedIncreases = <Increase>[];
    for (var increase in increases) {
        updatedIncreases.add(recursiveUpsert(increase, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedIncreases;
}

//   @override
//   Increase upsert(Increase item) {
//     return recursiveUpsert(item);
//   }

}


class IncreaseInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      IncreaseInclude.Contract({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (increase) => IncreaseStore.instance
            .getContract$(increase, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (increase) => IncreaseStore.instance
            .getContract(increase, modelFilter: modelFilter, includes: includes);
      }
}

	IncreaseInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (increase) => IncreaseStore.instance
            .getProperty$(increase, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (increase) => IncreaseStore.instance
            .getProperty(increase, modelFilter: modelFilter, includes: includes);
      }
}

	IncreaseInclude.Tenant({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tenant>? modelFilter,
    List<TenantInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (increase) => IncreaseStore.instance
            .getTenant$(increase, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (increase) => IncreaseStore.instance
            .getTenant(increase, modelFilter: modelFilter, includes: includes);
      }
}

	IncreaseInclude.Offer({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Offer>? modelFilter,
    List<OfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (increase) => IncreaseStore.instance
            .getOffer$(increase, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (increase) => IncreaseStore.instance
            .getOffer(increase, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum IncreaseEndpoints implements Endpoint {

    getAll('/increase', HttpMethod.post, List<Increase>),
	getById('/increase/byId/:id', HttpMethod.post, Increase),
	getManyByPropertyId('/increase/byPropertyId/:propertyId', HttpMethod.post, List<Increase>),
	getManyByTenantId('/increase/byTenantId/:tenantId', HttpMethod.post, List<Increase>),
	getManyByProposedBy('/increase/byProposedBy/:proposedBy', HttpMethod.post, List<Increase>),
	getManyByOldRent('/increase/byOldRent/:oldRent', HttpMethod.post, List<Increase>),
	getManyByNewRent('/increase/byNewRent/:newRent', HttpMethod.post, List<Increase>),
	getManyByEffectiveDate('/increase/byEffectiveDate/:effectiveDate', HttpMethod.post, List<Increase>),
	getManyByStatus('/increase/byStatus/:status', HttpMethod.post, List<Increase>),
	getManyByCreatedAt('/increase/byCreatedAt/:createdAt', HttpMethod.post, List<Increase>),
	getManyByUpdatedAt('/increase/byUpdatedAt/:updatedAt', HttpMethod.post, List<Increase>),
	getManyByDeletedAt('/increase/byDeletedAt/:deletedAt', HttpMethod.post, List<Increase>),
	getManyByContractId('/increase/byContractId/:contractId', HttpMethod.post, List<Increase>);

    const IncreaseEndpoints(this.path, this.method, this.responseType);

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
