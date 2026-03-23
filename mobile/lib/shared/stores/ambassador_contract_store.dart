
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AmbassadorContractStore extends ModelStreamStore<String, AmbassadorContract> {

  static AmbassadorContractStore? _instance;

  static AmbassadorContractStore get instance {
    _instance ??= AmbassadorContractStore();
    return _instance!;
  }

  AmbassadorContractStore() : super(AmbassadorContract.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AmbassadorContractStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AmbassadorContractStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AmbassadorContractStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAmbassadorContractId(AmbassadorContract ambassadorContract) => ambassadorContract.id;

	String? getAmbassadorContractOrgId(AmbassadorContract ambassadorContract) => ambassadorContract.orgId;

	String? getAmbassadorContractAmbassadorId(AmbassadorContract ambassadorContract) => ambassadorContract.ambassadorId;

	int? getAmbassadorContractVersion(AmbassadorContract ambassadorContract) => ambassadorContract.version;

	double? getAmbassadorContractEquityPercent(AmbassadorContract ambassadorContract) => ambassadorContract.equityPercent;

	double? getAmbassadorContractUpfrontFee(AmbassadorContract ambassadorContract) => ambassadorContract.upfrontFee;

	String? getAmbassadorContractCurrency(AmbassadorContract ambassadorContract) => ambassadorContract.currency;

	DateTime? getAmbassadorContractStartDate(AmbassadorContract ambassadorContract) => ambassadorContract.startDate;

	DateTime? getAmbassadorContractEndDate(AmbassadorContract ambassadorContract) => ambassadorContract.endDate;

	DateTime? getAmbassadorContractSignedAt(AmbassadorContract ambassadorContract) => ambassadorContract.signedAt;

	String? getAmbassadorContractDocumentUrl(AmbassadorContract ambassadorContract) => ambassadorContract.documentUrl;

	ContractStatus? getAmbassadorContractStatus(AmbassadorContract ambassadorContract) => ambassadorContract.status;

	String? getAmbassadorContractNotes(AmbassadorContract ambassadorContract) => ambassadorContract.notes;

	DateTime? getAmbassadorContractCreatedAt(AmbassadorContract ambassadorContract) => ambassadorContract.createdAt;

	DateTime? getAmbassadorContractUpdatedAt(AmbassadorContract ambassadorContract) => ambassadorContract.updatedAt;

	DateTime? getAmbassadorContractDeletedAt(AmbassadorContract ambassadorContract) => ambassadorContract.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AmbassadorContract> getByOrgId(
    String orgId,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByAmbassadorId(
    String ambassadorId,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractAmbassadorId, ambassadorId, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByVersion(
    int version,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractVersion, version, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByEquityPercent(
    double equityPercent,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractEquityPercent, equityPercent, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByUpfrontFee(
    double upfrontFee,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractUpfrontFee, upfrontFee, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByCurrency(
    String currency,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByStartDate(
    DateTime startDate,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByEndDate(
    DateTime endDate,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getBySignedAt(
    DateTime signedAt,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractSignedAt, signedAt, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByDocumentUrl(
    String documentUrl,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractDocumentUrl, documentUrl, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByStatus(
    ContractStatus status,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByNotes(
    String notes,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<AmbassadorContract> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}
    ) =>
    getManyIncluding(getAmbassadorContractDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  BrandAmbassador? getAmbassador(
    AmbassadorContract ambassadorContract, {ModelFilter? modelFilter, List<BrandAmbassadorInclude>? includes}) {
    if (ambassadorContract.ambassadorId == null) {
        return null;
    } else {
        final ambassador = BrandAmbassadorStore.instance.getById(ambassadorContract.ambassadorId!, includes: includes);
        ambassadorContract.ambassador = ambassador;
        // setIncludedReferences(ambassador, includes: includes);
        return ambassador;
    }
}

	Organization? getOrg(
    AmbassadorContract ambassadorContract, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (ambassadorContract.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(ambassadorContract.orgId!, includes: includes);
        ambassadorContract.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AmbassadorContract>> getAll$({bool useCache = true, ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AmbassadorContractEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AmbassadorContract?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAmbassadorContractId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AmbassadorContract>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmbassadorContractOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByAmbassadorId$(
        String ambassadorId,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmbassadorContractAmbassadorId,
        value: ambassadorId,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByAmbassadorId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByVersion$(
        int version,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAmbassadorContractVersion,
        value: version,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByEquityPercent$(
        double equityPercent,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAmbassadorContractEquityPercent,
        value: equityPercent,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByEquityPercent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByUpfrontFee$(
        double upfrontFee,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAmbassadorContractUpfrontFee,
        value: upfrontFee,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByUpfrontFee,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmbassadorContractCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmbassadorContractStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmbassadorContractEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getBySignedAt$(
        DateTime signedAt,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmbassadorContractSignedAt,
        value: signedAt,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyBySignedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByDocumentUrl$(
        String documentUrl,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmbassadorContractDocumentUrl,
        value: documentUrl,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByDocumentUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByStatus$(
        ContractStatus status,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<ContractStatus>(
        getPropVal: getAmbassadorContractStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAmbassadorContractNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmbassadorContractCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmbassadorContractUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AmbassadorContract>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<AmbassadorContract>? modelFilter,
        List<AmbassadorContractInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAmbassadorContractDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: AmbassadorContractEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<BrandAmbassador?> getAmbassador$(
    AmbassadorContract ambassadorContract, {bool useCache = true, ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}) {
    if (ambassadorContract.ambassadorId == null) {
        return Stream.value(null);
    } else {
        return BrandAmbassadorStore.instance.getById$(
            ambassadorContract.ambassadorId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((ambassador) {
            ambassadorContract.ambassador = ambassador;
        });
    }
}

	Stream<Organization?> getOrg$(
    AmbassadorContract ambassadorContract, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (ambassadorContract.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            ambassadorContract.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            ambassadorContract.org = org;
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
AmbassadorContract recursiveUpsert(AmbassadorContract ambassadorContract, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AmbassadorContract'} 
        : const {};
    if (ambassadorContract.ambassador != null && (!preventCircularSerialization || !upsertedTypes.contains('BrandAmbassador'))) {
        ambassadorContract.ambassador = BrandAmbassadorStore.instance.recursiveUpsert(ambassadorContract.ambassador!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (ambassadorContract.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        ambassadorContract.org = OrganizationStore.instance.recursiveUpsert(ambassadorContract.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(ambassadorContract);
}

  List<AmbassadorContract> recursiveListUpsert(List<AmbassadorContract> ambassadorContracts, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAmbassadorContracts = <AmbassadorContract>[];
    for (var ambassadorContract in ambassadorContracts) {
        updatedAmbassadorContracts.add(recursiveUpsert(ambassadorContract, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAmbassadorContracts;
}

//   @override
//   AmbassadorContract upsert(AmbassadorContract item) {
//     return recursiveUpsert(item);
//   }

}


class AmbassadorContractInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AmbassadorContractInclude.ambassador({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<BrandAmbassador>? modelFilter,
    List<BrandAmbassadorInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (ambassadorContract) => AmbassadorContractStore.instance
            .getAmbassador$(ambassadorContract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (ambassadorContract) => AmbassadorContractStore.instance
            .getAmbassador(ambassadorContract, modelFilter: modelFilter, includes: includes);
      }
}

	AmbassadorContractInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (ambassadorContract) => AmbassadorContractStore.instance
            .getOrg$(ambassadorContract, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (ambassadorContract) => AmbassadorContractStore.instance
            .getOrg(ambassadorContract, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AmbassadorContractEndpoints implements Endpoint {

    getAll('/ambassadorContract', HttpMethod.post, List<AmbassadorContract>),
	getById('/ambassadorContract/byId/:id', HttpMethod.post, AmbassadorContract),
	getManyByOrgId('/ambassadorContract/byOrgId/:orgId', HttpMethod.post, List<AmbassadorContract>),
	getManyByAmbassadorId('/ambassadorContract/byAmbassadorId/:ambassadorId', HttpMethod.post, List<AmbassadorContract>),
	getManyByVersion('/ambassadorContract/byVersion/:version', HttpMethod.post, List<AmbassadorContract>),
	getManyByEquityPercent('/ambassadorContract/byEquityPercent/:equityPercent', HttpMethod.post, List<AmbassadorContract>),
	getManyByUpfrontFee('/ambassadorContract/byUpfrontFee/:upfrontFee', HttpMethod.post, List<AmbassadorContract>),
	getManyByCurrency('/ambassadorContract/byCurrency/:currency', HttpMethod.post, List<AmbassadorContract>),
	getManyByStartDate('/ambassadorContract/byStartDate/:startDate', HttpMethod.post, List<AmbassadorContract>),
	getManyByEndDate('/ambassadorContract/byEndDate/:endDate', HttpMethod.post, List<AmbassadorContract>),
	getManyBySignedAt('/ambassadorContract/bySignedAt/:signedAt', HttpMethod.post, List<AmbassadorContract>),
	getManyByDocumentUrl('/ambassadorContract/byDocumentUrl/:documentUrl', HttpMethod.post, List<AmbassadorContract>),
	getManyByStatus('/ambassadorContract/byStatus/:status', HttpMethod.post, List<AmbassadorContract>),
	getManyByNotes('/ambassadorContract/byNotes/:notes', HttpMethod.post, List<AmbassadorContract>),
	getManyByCreatedAt('/ambassadorContract/byCreatedAt/:createdAt', HttpMethod.post, List<AmbassadorContract>),
	getManyByUpdatedAt('/ambassadorContract/byUpdatedAt/:updatedAt', HttpMethod.post, List<AmbassadorContract>),
	getManyByDeletedAt('/ambassadorContract/byDeletedAt/:deletedAt', HttpMethod.post, List<AmbassadorContract>);

    const AmbassadorContractEndpoints(this.path, this.method, this.responseType);

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
