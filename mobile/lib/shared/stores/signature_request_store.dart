
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class SignatureRequestStore extends ModelStreamStore<String, SignatureRequest> {

  static SignatureRequestStore? _instance;

  static SignatureRequestStore get instance {
    _instance ??= SignatureRequestStore();
    return _instance!;
  }

  SignatureRequestStore() : super(SignatureRequest.fromJson) {
    if (_instance != null) {
        throw Exception(
            'SignatureRequestStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending SignatureRequestStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use SignatureRequestStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getSignatureRequestId(SignatureRequest signatureRequest) => signatureRequest.id;

	String? getSignatureRequestOrgId(SignatureRequest signatureRequest) => signatureRequest.orgId;

	String? getSignatureRequestContractId(SignatureRequest signatureRequest) => signatureRequest.contractId;

	String? getSignatureRequestProvider(SignatureRequest signatureRequest) => signatureRequest.provider;

	SignatureStatus? getSignatureRequestStatus(SignatureRequest signatureRequest) => signatureRequest.status;

	String? getSignatureRequestSignUrl(SignatureRequest signatureRequest) => signatureRequest.signUrl;

	String? getSignatureRequestSignedDocumentUrl(SignatureRequest signatureRequest) => signatureRequest.signedDocumentUrl;

	DateTime? getSignatureRequestExpiresAt(SignatureRequest signatureRequest) => signatureRequest.expiresAt;

	String? getSignatureRequestCreatedBy(SignatureRequest signatureRequest) => signatureRequest.createdBy;

	DateTime? getSignatureRequestCreatedAt(SignatureRequest signatureRequest) => signatureRequest.createdAt;

	DateTime? getSignatureRequestUpdatedAt(SignatureRequest signatureRequest) => signatureRequest.updatedAt;

	DateTime? getSignatureRequestDeletedAt(SignatureRequest signatureRequest) => signatureRequest.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<SignatureRequest> getByOrgId(
    String orgId,
    {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}
    ) =>
    getManyIncluding(getSignatureRequestOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<SignatureRequest> getByContractId(
    String contractId,
    {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}
    ) =>
    getManyIncluding(getSignatureRequestContractId, contractId, modelFilter: modelFilter, includes: includes);

	
List<SignatureRequest> getByProvider(
    String provider,
    {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}
    ) =>
    getManyIncluding(getSignatureRequestProvider, provider, modelFilter: modelFilter, includes: includes);

	
List<SignatureRequest> getByStatus(
    SignatureStatus status,
    {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}
    ) =>
    getManyIncluding(getSignatureRequestStatus, status, modelFilter: modelFilter, includes: includes);

	
List<SignatureRequest> getBySignUrl(
    String signUrl,
    {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}
    ) =>
    getManyIncluding(getSignatureRequestSignUrl, signUrl, modelFilter: modelFilter, includes: includes);

	
List<SignatureRequest> getBySignedDocumentUrl(
    String signedDocumentUrl,
    {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}
    ) =>
    getManyIncluding(getSignatureRequestSignedDocumentUrl, signedDocumentUrl, modelFilter: modelFilter, includes: includes);

	
List<SignatureRequest> getByExpiresAt(
    DateTime expiresAt,
    {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}
    ) =>
    getManyIncluding(getSignatureRequestExpiresAt, expiresAt, modelFilter: modelFilter, includes: includes);

	
List<SignatureRequest> getByCreatedBy(
    String createdBy,
    {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}
    ) =>
    getManyIncluding(getSignatureRequestCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<SignatureRequest> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}
    ) =>
    getManyIncluding(getSignatureRequestCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<SignatureRequest> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}
    ) =>
    getManyIncluding(getSignatureRequestUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<SignatureRequest> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}
    ) =>
    getManyIncluding(getSignatureRequestDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contract? getContract(
    SignatureRequest signatureRequest, {ModelFilter? modelFilter, List<ContractInclude>? includes}) {
    if (signatureRequest.contractId == null) {
        return null;
    } else {
        final contract = ContractStore.instance.getById(signatureRequest.contractId!, includes: includes);
        signatureRequest.contract = contract;
        // setIncludedReferences(contract, includes: includes);
        return contract;
    }
}

	Organization? getOrg(
    SignatureRequest signatureRequest, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (signatureRequest.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(signatureRequest.orgId!, includes: includes);
        signatureRequest.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<SignatureSigner> getSigners(
    SignatureRequest signatureRequest, {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}) {
    final signers = SignatureSignerStore.instance.getBySignatureRequestId(signatureRequest.$uid!, modelFilter: modelFilter, includes: includes);
    signatureRequest.signers = signers;
    // setIncludedReferencesForList(signers, includes: includes);
    return signers;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<SignatureRequest>> getAll$({bool useCache = true, ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: SignatureRequestEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<SignatureRequest?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSignatureRequestId,
        value: id,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<SignatureRequest>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureRequestOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureRequest>> getByContractId$(
        String contractId,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureRequestContractId,
        value: contractId,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getManyByContractId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureRequest>> getByProvider$(
        String provider,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureRequestProvider,
        value: provider,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getManyByProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureRequest>> getByStatus$(
        SignatureStatus status,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final items$ = getManyByFieldValue$<SignatureStatus>(
        getPropVal: getSignatureRequestStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureRequest>> getBySignUrl$(
        String signUrl,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureRequestSignUrl,
        value: signUrl,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getManyBySignUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureRequest>> getBySignedDocumentUrl$(
        String signedDocumentUrl,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureRequestSignedDocumentUrl,
        value: signedDocumentUrl,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getManyBySignedDocumentUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureRequest>> getByExpiresAt$(
        DateTime expiresAt,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSignatureRequestExpiresAt,
        value: expiresAt,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getManyByExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureRequest>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureRequestCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureRequest>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSignatureRequestCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureRequest>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSignatureRequestUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureRequest>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<SignatureRequest>? modelFilter,
        List<SignatureRequestInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSignatureRequestDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: SignatureRequestEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contract?> getContract$(
    SignatureRequest signatureRequest, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    if (signatureRequest.contractId == null) {
        return Stream.value(null);
    } else {
        return ContractStore.instance.getById$(
            signatureRequest.contractId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contract) {
            signatureRequest.contract = contract;
        });
    }
}

	Stream<Organization?> getOrg$(
    SignatureRequest signatureRequest, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (signatureRequest.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            signatureRequest.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            signatureRequest.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<SignatureSigner>> getSigners$(
    SignatureRequest signatureRequest, {bool useCache = true, ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}) {
    return SignatureSignerStore.instance.getBySignatureRequestId$(
        signatureRequest.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((signers) {
        signatureRequest.signers = signers;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
SignatureRequest recursiveUpsert(SignatureRequest signatureRequest, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'SignatureRequest'} 
        : const {};
    if (signatureRequest.contract != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        signatureRequest.contract = ContractStore.instance.recursiveUpsert(signatureRequest.contract!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (signatureRequest.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        signatureRequest.org = OrganizationStore.instance.recursiveUpsert(signatureRequest.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (signatureRequest.signers != null && (!preventCircularSerialization || !upsertedTypes.contains('SignatureSigner'))) {
        signatureRequest.signers = SignatureSignerStore.instance.recursiveListUpsert(signatureRequest.signers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(signatureRequest);
}

  List<SignatureRequest> recursiveListUpsert(List<SignatureRequest> signatureRequests, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedSignatureRequests = <SignatureRequest>[];
    for (var signatureRequest in signatureRequests) {
        updatedSignatureRequests.add(recursiveUpsert(signatureRequest, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedSignatureRequests;
}

//   @override
//   SignatureRequest upsert(SignatureRequest item) {
//     return recursiveUpsert(item);
//   }

}


class SignatureRequestInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      SignatureRequestInclude.contract({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (signatureRequest) => SignatureRequestStore.instance
            .getContract$(signatureRequest, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (signatureRequest) => SignatureRequestStore.instance
            .getContract(signatureRequest, modelFilter: modelFilter, includes: includes);
      }
}

	SignatureRequestInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (signatureRequest) => SignatureRequestStore.instance
            .getOrg$(signatureRequest, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (signatureRequest) => SignatureRequestStore.instance
            .getOrg(signatureRequest, modelFilter: modelFilter, includes: includes);
      }
}

	SignatureRequestInclude.signers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SignatureSigner>? modelFilter,
    List<SignatureSignerInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (signatureRequest) => SignatureRequestStore.instance
            .getSigners$(signatureRequest, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (signatureRequest) => SignatureRequestStore.instance
            .getSigners(signatureRequest, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum SignatureRequestEndpoints implements Endpoint {

    getAll('/signatureRequest', HttpMethod.post, List<SignatureRequest>),
	getById('/signatureRequest/byId/:id', HttpMethod.post, SignatureRequest),
	getManyByOrgId('/signatureRequest/byOrgId/:orgId', HttpMethod.post, List<SignatureRequest>),
	getManyByContractId('/signatureRequest/byContractId/:contractId', HttpMethod.post, List<SignatureRequest>),
	getManyByProvider('/signatureRequest/byProvider/:provider', HttpMethod.post, List<SignatureRequest>),
	getManyByStatus('/signatureRequest/byStatus/:status', HttpMethod.post, List<SignatureRequest>),
	getManyBySignUrl('/signatureRequest/bySignUrl/:signUrl', HttpMethod.post, List<SignatureRequest>),
	getManyBySignedDocumentUrl('/signatureRequest/bySignedDocumentUrl/:signedDocumentUrl', HttpMethod.post, List<SignatureRequest>),
	getManyByExpiresAt('/signatureRequest/byExpiresAt/:expiresAt', HttpMethod.post, List<SignatureRequest>),
	getManyByCreatedBy('/signatureRequest/byCreatedBy/:createdBy', HttpMethod.post, List<SignatureRequest>),
	getManyByCreatedAt('/signatureRequest/byCreatedAt/:createdAt', HttpMethod.post, List<SignatureRequest>),
	getManyByUpdatedAt('/signatureRequest/byUpdatedAt/:updatedAt', HttpMethod.post, List<SignatureRequest>),
	getManyByDeletedAt('/signatureRequest/byDeletedAt/:deletedAt', HttpMethod.post, List<SignatureRequest>);

    const SignatureRequestEndpoints(this.path, this.method, this.responseType);

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
