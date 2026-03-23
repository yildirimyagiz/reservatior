
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ContractVersionStore extends ModelStreamStore<String, ContractVersion> {

  static ContractVersionStore? _instance;

  static ContractVersionStore get instance {
    _instance ??= ContractVersionStore();
    return _instance!;
  }

  ContractVersionStore() : super(ContractVersion.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ContractVersionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ContractVersionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ContractVersionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getContractVersionId(ContractVersion contractVersion) => contractVersion.id;

	String? getContractVersionOrgId(ContractVersion contractVersion) => contractVersion.orgId;

	String? getContractVersionContractId(ContractVersion contractVersion) => contractVersion.contractId;

	int? getContractVersionVersion(ContractVersion contractVersion) => contractVersion.version;

	String? getContractVersionDocumentUrl(ContractVersion contractVersion) => contractVersion.documentUrl;

	String? getContractVersionChecksum(ContractVersion contractVersion) => contractVersion.checksum;

	String? getContractVersionCreatedBy(ContractVersion contractVersion) => contractVersion.createdBy;

	DateTime? getContractVersionCreatedAt(ContractVersion contractVersion) => contractVersion.createdAt;

	DateTime? getContractVersionUpdatedAt(ContractVersion contractVersion) => contractVersion.updatedAt;

	DateTime? getContractVersionDeletedAt(ContractVersion contractVersion) => contractVersion.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ContractVersion> getByOrgId(
    String orgId,
    {ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}
    ) =>
    getManyIncluding(getContractVersionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ContractVersion> getByContractId(
    String contractId,
    {ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}
    ) =>
    getManyIncluding(getContractVersionContractId, contractId, modelFilter: modelFilter, includes: includes);

	
List<ContractVersion> getByVersion(
    int version,
    {ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}
    ) =>
    getManyIncluding(getContractVersionVersion, version, modelFilter: modelFilter, includes: includes);

	
List<ContractVersion> getByDocumentUrl(
    String documentUrl,
    {ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}
    ) =>
    getManyIncluding(getContractVersionDocumentUrl, documentUrl, modelFilter: modelFilter, includes: includes);

	
List<ContractVersion> getByChecksum(
    String checksum,
    {ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}
    ) =>
    getManyIncluding(getContractVersionChecksum, checksum, modelFilter: modelFilter, includes: includes);

	
List<ContractVersion> getByCreatedBy(
    String createdBy,
    {ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}
    ) =>
    getManyIncluding(getContractVersionCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<ContractVersion> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}
    ) =>
    getManyIncluding(getContractVersionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ContractVersion> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}
    ) =>
    getManyIncluding(getContractVersionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ContractVersion> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}
    ) =>
    getManyIncluding(getContractVersionDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contract? getContract(
    ContractVersion contractVersion, {ModelFilter? modelFilter, List<ContractInclude>? includes}) {
    if (contractVersion.contractId == null) {
        return null;
    } else {
        final contract = ContractStore.instance.getById(contractVersion.contractId!, includes: includes);
        contractVersion.contract = contract;
        // setIncludedReferences(contract, includes: includes);
        return contract;
    }
}

	Organization? getOrg(
    ContractVersion contractVersion, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (contractVersion.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(contractVersion.orgId!, includes: includes);
        contractVersion.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ContractVersion>> getAll$({bool useCache = true, ModelFilter<ContractVersion>? modelFilter, List<ContractVersionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ContractVersionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ContractVersion?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ContractVersion>? modelFilter,
        List<ContractVersionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getContractVersionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ContractVersionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ContractVersion>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ContractVersion>? modelFilter,
        List<ContractVersionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractVersionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ContractVersionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ContractVersion>> getByContractId$(
        String contractId,
        {bool useCache = true,
        ModelFilter<ContractVersion>? modelFilter,
        List<ContractVersionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractVersionContractId,
        value: contractId,
        modelFilter: modelFilter,
        endpoint: ContractVersionEndpoints.getManyByContractId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ContractVersion>> getByVersion$(
        int version,
        {bool useCache = true,
        ModelFilter<ContractVersion>? modelFilter,
        List<ContractVersionInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getContractVersionVersion,
        value: version,
        modelFilter: modelFilter,
        endpoint: ContractVersionEndpoints.getManyByVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ContractVersion>> getByDocumentUrl$(
        String documentUrl,
        {bool useCache = true,
        ModelFilter<ContractVersion>? modelFilter,
        List<ContractVersionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractVersionDocumentUrl,
        value: documentUrl,
        modelFilter: modelFilter,
        endpoint: ContractVersionEndpoints.getManyByDocumentUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ContractVersion>> getByChecksum$(
        String checksum,
        {bool useCache = true,
        ModelFilter<ContractVersion>? modelFilter,
        List<ContractVersionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractVersionChecksum,
        value: checksum,
        modelFilter: modelFilter,
        endpoint: ContractVersionEndpoints.getManyByChecksum,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ContractVersion>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<ContractVersion>? modelFilter,
        List<ContractVersionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getContractVersionCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: ContractVersionEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ContractVersion>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ContractVersion>? modelFilter,
        List<ContractVersionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContractVersionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ContractVersionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ContractVersion>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ContractVersion>? modelFilter,
        List<ContractVersionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContractVersionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ContractVersionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ContractVersion>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ContractVersion>? modelFilter,
        List<ContractVersionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getContractVersionDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ContractVersionEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contract?> getContract$(
    ContractVersion contractVersion, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    if (contractVersion.contractId == null) {
        return Stream.value(null);
    } else {
        return ContractStore.instance.getById$(
            contractVersion.contractId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contract) {
            contractVersion.contract = contract;
        });
    }
}

	Stream<Organization?> getOrg$(
    ContractVersion contractVersion, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (contractVersion.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            contractVersion.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            contractVersion.org = org;
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
ContractVersion recursiveUpsert(ContractVersion contractVersion, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ContractVersion'} 
        : const {};
    if (contractVersion.contract != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        contractVersion.contract = ContractStore.instance.recursiveUpsert(contractVersion.contract!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (contractVersion.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        contractVersion.org = OrganizationStore.instance.recursiveUpsert(contractVersion.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(contractVersion);
}

  List<ContractVersion> recursiveListUpsert(List<ContractVersion> contractVersions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedContractVersions = <ContractVersion>[];
    for (var contractVersion in contractVersions) {
        updatedContractVersions.add(recursiveUpsert(contractVersion, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedContractVersions;
}

//   @override
//   ContractVersion upsert(ContractVersion item) {
//     return recursiveUpsert(item);
//   }

}


class ContractVersionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ContractVersionInclude.contract({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contractVersion) => ContractVersionStore.instance
            .getContract$(contractVersion, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contractVersion) => ContractVersionStore.instance
            .getContract(contractVersion, modelFilter: modelFilter, includes: includes);
      }
}

	ContractVersionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (contractVersion) => ContractVersionStore.instance
            .getOrg$(contractVersion, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (contractVersion) => ContractVersionStore.instance
            .getOrg(contractVersion, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ContractVersionEndpoints implements Endpoint {

    getAll('/contractVersion', HttpMethod.post, List<ContractVersion>),
	getById('/contractVersion/byId/:id', HttpMethod.post, ContractVersion),
	getManyByOrgId('/contractVersion/byOrgId/:orgId', HttpMethod.post, List<ContractVersion>),
	getManyByContractId('/contractVersion/byContractId/:contractId', HttpMethod.post, List<ContractVersion>),
	getManyByVersion('/contractVersion/byVersion/:version', HttpMethod.post, List<ContractVersion>),
	getManyByDocumentUrl('/contractVersion/byDocumentUrl/:documentUrl', HttpMethod.post, List<ContractVersion>),
	getManyByChecksum('/contractVersion/byChecksum/:checksum', HttpMethod.post, List<ContractVersion>),
	getManyByCreatedBy('/contractVersion/byCreatedBy/:createdBy', HttpMethod.post, List<ContractVersion>),
	getManyByCreatedAt('/contractVersion/byCreatedAt/:createdAt', HttpMethod.post, List<ContractVersion>),
	getManyByUpdatedAt('/contractVersion/byUpdatedAt/:updatedAt', HttpMethod.post, List<ContractVersion>),
	getManyByDeletedAt('/contractVersion/byDeletedAt/:deletedAt', HttpMethod.post, List<ContractVersion>);

    const ContractVersionEndpoints(this.path, this.method, this.responseType);

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
