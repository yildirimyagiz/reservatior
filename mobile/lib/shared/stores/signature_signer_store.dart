
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class SignatureSignerStore extends ModelStreamStore<String, SignatureSigner> {

  static SignatureSignerStore? _instance;

  static SignatureSignerStore get instance {
    _instance ??= SignatureSignerStore();
    return _instance!;
  }

  SignatureSignerStore() : super(SignatureSigner.fromJson) {
    if (_instance != null) {
        throw Exception(
            'SignatureSignerStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending SignatureSignerStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use SignatureSignerStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getSignatureSignerId(SignatureSigner signatureSigner) => signatureSigner.id;

	String? getSignatureSignerOrgId(SignatureSigner signatureSigner) => signatureSigner.orgId;

	String? getSignatureSignerSignatureRequestId(SignatureSigner signatureSigner) => signatureSigner.signatureRequestId;

	MessageParticipantType? getSignatureSignerParticipantType(SignatureSigner signatureSigner) => signatureSigner.participantType;

	String? getSignatureSignerUserId(SignatureSigner signatureSigner) => signatureSigner.userId;

	String? getSignatureSignerContactId(SignatureSigner signatureSigner) => signatureSigner.contactId;

	String? getSignatureSignerFullName(SignatureSigner signatureSigner) => signatureSigner.fullName;

	String? getSignatureSignerEmail(SignatureSigner signatureSigner) => signatureSigner.email;

	SignatureStatus? getSignatureSignerStatus(SignatureSigner signatureSigner) => signatureSigner.status;

	DateTime? getSignatureSignerSignedAt(SignatureSigner signatureSigner) => signatureSigner.signedAt;

	DateTime? getSignatureSignerCreatedAt(SignatureSigner signatureSigner) => signatureSigner.createdAt;

	DateTime? getSignatureSignerUpdatedAt(SignatureSigner signatureSigner) => signatureSigner.updatedAt;

	DateTime? getSignatureSignerDeletedAt(SignatureSigner signatureSigner) => signatureSigner.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<SignatureSigner> getByOrgId(
    String orgId,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<SignatureSigner> getBySignatureRequestId(
    String signatureRequestId,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerSignatureRequestId, signatureRequestId, modelFilter: modelFilter, includes: includes);

	
List<SignatureSigner> getByParticipantType(
    MessageParticipantType participantType,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerParticipantType, participantType, modelFilter: modelFilter, includes: includes);

	
List<SignatureSigner> getByUserId(
    String userId,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<SignatureSigner> getByContactId(
    String contactId,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<SignatureSigner> getByFullName(
    String fullName,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerFullName, fullName, modelFilter: modelFilter, includes: includes);

	
List<SignatureSigner> getByEmail(
    String email,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerEmail, email, modelFilter: modelFilter, includes: includes);

	
List<SignatureSigner> getByStatus(
    SignatureStatus status,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerStatus, status, modelFilter: modelFilter, includes: includes);

	
List<SignatureSigner> getBySignedAt(
    DateTime signedAt,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerSignedAt, signedAt, modelFilter: modelFilter, includes: includes);

	
List<SignatureSigner> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<SignatureSigner> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<SignatureSigner> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}
    ) =>
    getManyIncluding(getSignatureSignerDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    SignatureSigner signatureSigner, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (signatureSigner.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(signatureSigner.contactId!, includes: includes);
        signatureSigner.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Organization? getOrg(
    SignatureSigner signatureSigner, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (signatureSigner.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(signatureSigner.orgId!, includes: includes);
        signatureSigner.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	SignatureRequest? getRequest(
    SignatureSigner signatureSigner, {ModelFilter? modelFilter, List<SignatureRequestInclude>? includes}) {
    if (signatureSigner.signatureRequestId == null) {
        return null;
    } else {
        final request = SignatureRequestStore.instance.getById(signatureSigner.signatureRequestId!, includes: includes);
        signatureSigner.request = request;
        // setIncludedReferences(request, includes: includes);
        return request;
    }
}

	User? getUser(
    SignatureSigner signatureSigner, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (signatureSigner.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(signatureSigner.userId!, includes: includes);
        signatureSigner.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<SignatureSigner>> getAll$({bool useCache = true, ModelFilter<SignatureSigner>? modelFilter, List<SignatureSignerInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: SignatureSignerEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<SignatureSigner?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSignatureSignerId,
        value: id,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<SignatureSigner>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureSignerOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureSigner>> getBySignatureRequestId$(
        String signatureRequestId,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureSignerSignatureRequestId,
        value: signatureRequestId,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyBySignatureRequestId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureSigner>> getByParticipantType$(
        MessageParticipantType participantType,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<MessageParticipantType>(
        getPropVal: getSignatureSignerParticipantType,
        value: participantType,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyByParticipantType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureSigner>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureSignerUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureSigner>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureSignerContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureSigner>> getByFullName$(
        String fullName,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureSignerFullName,
        value: fullName,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyByFullName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureSigner>> getByEmail$(
        String email,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSignatureSignerEmail,
        value: email,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyByEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureSigner>> getByStatus$(
        SignatureStatus status,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<SignatureStatus>(
        getPropVal: getSignatureSignerStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureSigner>> getBySignedAt$(
        DateTime signedAt,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSignatureSignerSignedAt,
        value: signedAt,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyBySignedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureSigner>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSignatureSignerCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureSigner>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSignatureSignerUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SignatureSigner>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<SignatureSigner>? modelFilter,
        List<SignatureSignerInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSignatureSignerDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: SignatureSignerEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    SignatureSigner signatureSigner, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (signatureSigner.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            signatureSigner.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            signatureSigner.contact = contact;
        });
    }
}

	Stream<Organization?> getOrg$(
    SignatureSigner signatureSigner, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (signatureSigner.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            signatureSigner.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            signatureSigner.org = org;
        });
    }
}

	Stream<SignatureRequest?> getRequest$(
    SignatureSigner signatureSigner, {bool useCache = true, ModelFilter<SignatureRequest>? modelFilter, List<SignatureRequestInclude>? includes}) {
    if (signatureSigner.signatureRequestId == null) {
        return Stream.value(null);
    } else {
        return SignatureRequestStore.instance.getById$(
            signatureSigner.signatureRequestId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((request) {
            signatureSigner.request = request;
        });
    }
}

	Stream<User?> getUser$(
    SignatureSigner signatureSigner, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (signatureSigner.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            signatureSigner.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            signatureSigner.user = user;
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
SignatureSigner recursiveUpsert(SignatureSigner signatureSigner, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'SignatureSigner'} 
        : const {};
    if (signatureSigner.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        signatureSigner.contact = ContactStore.instance.recursiveUpsert(signatureSigner.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (signatureSigner.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        signatureSigner.org = OrganizationStore.instance.recursiveUpsert(signatureSigner.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (signatureSigner.request != null && (!preventCircularSerialization || !upsertedTypes.contains('SignatureRequest'))) {
        signatureSigner.request = SignatureRequestStore.instance.recursiveUpsert(signatureSigner.request!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (signatureSigner.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        signatureSigner.user = UserStore.instance.recursiveUpsert(signatureSigner.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(signatureSigner);
}

  List<SignatureSigner> recursiveListUpsert(List<SignatureSigner> signatureSigners, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedSignatureSigners = <SignatureSigner>[];
    for (var signatureSigner in signatureSigners) {
        updatedSignatureSigners.add(recursiveUpsert(signatureSigner, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedSignatureSigners;
}

//   @override
//   SignatureSigner upsert(SignatureSigner item) {
//     return recursiveUpsert(item);
//   }

}


class SignatureSignerInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      SignatureSignerInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (signatureSigner) => SignatureSignerStore.instance
            .getContact$(signatureSigner, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (signatureSigner) => SignatureSignerStore.instance
            .getContact(signatureSigner, modelFilter: modelFilter, includes: includes);
      }
}

	SignatureSignerInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (signatureSigner) => SignatureSignerStore.instance
            .getOrg$(signatureSigner, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (signatureSigner) => SignatureSignerStore.instance
            .getOrg(signatureSigner, modelFilter: modelFilter, includes: includes);
      }
}

	SignatureSignerInclude.request({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SignatureRequest>? modelFilter,
    List<SignatureRequestInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (signatureSigner) => SignatureSignerStore.instance
            .getRequest$(signatureSigner, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (signatureSigner) => SignatureSignerStore.instance
            .getRequest(signatureSigner, modelFilter: modelFilter, includes: includes);
      }
}

	SignatureSignerInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (signatureSigner) => SignatureSignerStore.instance
            .getUser$(signatureSigner, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (signatureSigner) => SignatureSignerStore.instance
            .getUser(signatureSigner, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum SignatureSignerEndpoints implements Endpoint {

    getAll('/signatureSigner', HttpMethod.post, List<SignatureSigner>),
	getById('/signatureSigner/byId/:id', HttpMethod.post, SignatureSigner),
	getManyByOrgId('/signatureSigner/byOrgId/:orgId', HttpMethod.post, List<SignatureSigner>),
	getManyBySignatureRequestId('/signatureSigner/bySignatureRequestId/:signatureRequestId', HttpMethod.post, List<SignatureSigner>),
	getManyByParticipantType('/signatureSigner/byParticipantType/:participantType', HttpMethod.post, List<SignatureSigner>),
	getManyByUserId('/signatureSigner/byUserId/:userId', HttpMethod.post, List<SignatureSigner>),
	getManyByContactId('/signatureSigner/byContactId/:contactId', HttpMethod.post, List<SignatureSigner>),
	getManyByFullName('/signatureSigner/byFullName/:fullName', HttpMethod.post, List<SignatureSigner>),
	getManyByEmail('/signatureSigner/byEmail/:email', HttpMethod.post, List<SignatureSigner>),
	getManyByStatus('/signatureSigner/byStatus/:status', HttpMethod.post, List<SignatureSigner>),
	getManyBySignedAt('/signatureSigner/bySignedAt/:signedAt', HttpMethod.post, List<SignatureSigner>),
	getManyByCreatedAt('/signatureSigner/byCreatedAt/:createdAt', HttpMethod.post, List<SignatureSigner>),
	getManyByUpdatedAt('/signatureSigner/byUpdatedAt/:updatedAt', HttpMethod.post, List<SignatureSigner>),
	getManyByDeletedAt('/signatureSigner/byDeletedAt/:deletedAt', HttpMethod.post, List<SignatureSigner>);

    const SignatureSignerEndpoints(this.path, this.method, this.responseType);

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
