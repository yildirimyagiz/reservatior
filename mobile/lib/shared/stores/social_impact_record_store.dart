
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class SocialImpactRecordStore extends ModelStreamStore<String, SocialImpactRecord> {

  static SocialImpactRecordStore? _instance;

  static SocialImpactRecordStore get instance {
    _instance ??= SocialImpactRecordStore();
    return _instance!;
  }

  SocialImpactRecordStore() : super(SocialImpactRecord.fromJson) {
    if (_instance != null) {
        throw Exception(
            'SocialImpactRecordStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending SocialImpactRecordStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use SocialImpactRecordStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getSocialImpactRecordId(SocialImpactRecord socialImpactRecord) => socialImpactRecord.id;

	String? getSocialImpactRecordOrgId(SocialImpactRecord socialImpactRecord) => socialImpactRecord.orgId;

	String? getSocialImpactRecordCounterId(SocialImpactRecord socialImpactRecord) => socialImpactRecord.counterId;

	String? getSocialImpactRecordReservationId(SocialImpactRecord socialImpactRecord) => socialImpactRecord.reservationId;

	SocialImpactType? getSocialImpactRecordImpactType(SocialImpactRecord socialImpactRecord) => socialImpactRecord.impactType;

	int? getSocialImpactRecordQuantity(SocialImpactRecord socialImpactRecord) => socialImpactRecord.quantity;

	double? getSocialImpactRecordAmount(SocialImpactRecord socialImpactRecord) => socialImpactRecord.amount;

	String? getSocialImpactRecordCurrency(SocialImpactRecord socialImpactRecord) => socialImpactRecord.currency;

	String? getSocialImpactRecordDescription(SocialImpactRecord socialImpactRecord) => socialImpactRecord.description;

	DateTime? getSocialImpactRecordVerifiedAt(SocialImpactRecord socialImpactRecord) => socialImpactRecord.verifiedAt;

	String? getSocialImpactRecordVerifiedBy(SocialImpactRecord socialImpactRecord) => socialImpactRecord.verifiedBy;

	String? getSocialImpactRecordProofUrl(SocialImpactRecord socialImpactRecord) => socialImpactRecord.proofUrl;

	DateTime? getSocialImpactRecordDeletedAt(SocialImpactRecord socialImpactRecord) => socialImpactRecord.deletedAt;

	DateTime? getSocialImpactRecordCreatedAt(SocialImpactRecord socialImpactRecord) => socialImpactRecord.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<SocialImpactRecord> getByOrgId(
    String orgId,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByCounterId(
    String counterId,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordCounterId, counterId, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByReservationId(
    String reservationId,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordReservationId, reservationId, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByImpactType(
    SocialImpactType impactType,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordImpactType, impactType, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByQuantity(
    int quantity,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordQuantity, quantity, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByAmount(
    double amount,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByCurrency(
    String currency,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByDescription(
    String description,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordDescription, description, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByVerifiedAt(
    DateTime verifiedAt,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordVerifiedAt, verifiedAt, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByVerifiedBy(
    String verifiedBy,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordVerifiedBy, verifiedBy, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByProofUrl(
    String proofUrl,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordProofUrl, proofUrl, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<SocialImpactRecord> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}
    ) =>
    getManyIncluding(getSocialImpactRecordCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  SocialImpactCounter? getCounter(
    SocialImpactRecord socialImpactRecord, {ModelFilter? modelFilter, List<SocialImpactCounterInclude>? includes}) {
    if (socialImpactRecord.counterId == null) {
        return null;
    } else {
        final counter = SocialImpactCounterStore.instance.getById(socialImpactRecord.counterId!, includes: includes);
        socialImpactRecord.counter = counter;
        // setIncludedReferences(counter, includes: includes);
        return counter;
    }
}

	Organization? getOrg(
    SocialImpactRecord socialImpactRecord, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (socialImpactRecord.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(socialImpactRecord.orgId!, includes: includes);
        socialImpactRecord.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<SocialImpactRecord>> getAll$({bool useCache = true, ModelFilter<SocialImpactRecord>? modelFilter, List<SocialImpactRecordInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: SocialImpactRecordEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<SocialImpactRecord?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSocialImpactRecordId,
        value: id,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<SocialImpactRecord>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactRecordOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByCounterId$(
        String counterId,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactRecordCounterId,
        value: counterId,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByCounterId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactRecordReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByImpactType$(
        SocialImpactType impactType,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<SocialImpactType>(
        getPropVal: getSocialImpactRecordImpactType,
        value: impactType,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByImpactType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByQuantity$(
        int quantity,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getSocialImpactRecordQuantity,
        value: quantity,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByQuantity,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getSocialImpactRecordAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactRecordCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactRecordDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByVerifiedAt$(
        DateTime verifiedAt,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSocialImpactRecordVerifiedAt,
        value: verifiedAt,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByVerifiedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByVerifiedBy$(
        String verifiedBy,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactRecordVerifiedBy,
        value: verifiedBy,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByVerifiedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByProofUrl$(
        String proofUrl,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSocialImpactRecordProofUrl,
        value: proofUrl,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByProofUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSocialImpactRecordDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SocialImpactRecord>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<SocialImpactRecord>? modelFilter,
        List<SocialImpactRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSocialImpactRecordCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: SocialImpactRecordEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<SocialImpactCounter?> getCounter$(
    SocialImpactRecord socialImpactRecord, {bool useCache = true, ModelFilter<SocialImpactCounter>? modelFilter, List<SocialImpactCounterInclude>? includes}) {
    if (socialImpactRecord.counterId == null) {
        return Stream.value(null);
    } else {
        return SocialImpactCounterStore.instance.getById$(
            socialImpactRecord.counterId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((counter) {
            socialImpactRecord.counter = counter;
        });
    }
}

	Stream<Organization?> getOrg$(
    SocialImpactRecord socialImpactRecord, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (socialImpactRecord.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            socialImpactRecord.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            socialImpactRecord.org = org;
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
SocialImpactRecord recursiveUpsert(SocialImpactRecord socialImpactRecord, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'SocialImpactRecord'} 
        : const {};
    if (socialImpactRecord.counter != null && (!preventCircularSerialization || !upsertedTypes.contains('SocialImpactCounter'))) {
        socialImpactRecord.counter = SocialImpactCounterStore.instance.recursiveUpsert(socialImpactRecord.counter!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (socialImpactRecord.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        socialImpactRecord.org = OrganizationStore.instance.recursiveUpsert(socialImpactRecord.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(socialImpactRecord);
}

  List<SocialImpactRecord> recursiveListUpsert(List<SocialImpactRecord> socialImpactRecords, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedSocialImpactRecords = <SocialImpactRecord>[];
    for (var socialImpactRecord in socialImpactRecords) {
        updatedSocialImpactRecords.add(recursiveUpsert(socialImpactRecord, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedSocialImpactRecords;
}

//   @override
//   SocialImpactRecord upsert(SocialImpactRecord item) {
//     return recursiveUpsert(item);
//   }

}


class SocialImpactRecordInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      SocialImpactRecordInclude.counter({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<SocialImpactCounter>? modelFilter,
    List<SocialImpactCounterInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (socialImpactRecord) => SocialImpactRecordStore.instance
            .getCounter$(socialImpactRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (socialImpactRecord) => SocialImpactRecordStore.instance
            .getCounter(socialImpactRecord, modelFilter: modelFilter, includes: includes);
      }
}

	SocialImpactRecordInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (socialImpactRecord) => SocialImpactRecordStore.instance
            .getOrg$(socialImpactRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (socialImpactRecord) => SocialImpactRecordStore.instance
            .getOrg(socialImpactRecord, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum SocialImpactRecordEndpoints implements Endpoint {

    getAll('/socialImpactRecord', HttpMethod.post, List<SocialImpactRecord>),
	getById('/socialImpactRecord/byId/:id', HttpMethod.post, SocialImpactRecord),
	getManyByOrgId('/socialImpactRecord/byOrgId/:orgId', HttpMethod.post, List<SocialImpactRecord>),
	getManyByCounterId('/socialImpactRecord/byCounterId/:counterId', HttpMethod.post, List<SocialImpactRecord>),
	getManyByReservationId('/socialImpactRecord/byReservationId/:reservationId', HttpMethod.post, List<SocialImpactRecord>),
	getManyByImpactType('/socialImpactRecord/byImpactType/:impactType', HttpMethod.post, List<SocialImpactRecord>),
	getManyByQuantity('/socialImpactRecord/byQuantity/:quantity', HttpMethod.post, List<SocialImpactRecord>),
	getManyByAmount('/socialImpactRecord/byAmount/:amount', HttpMethod.post, List<SocialImpactRecord>),
	getManyByCurrency('/socialImpactRecord/byCurrency/:currency', HttpMethod.post, List<SocialImpactRecord>),
	getManyByDescription('/socialImpactRecord/byDescription/:description', HttpMethod.post, List<SocialImpactRecord>),
	getManyByVerifiedAt('/socialImpactRecord/byVerifiedAt/:verifiedAt', HttpMethod.post, List<SocialImpactRecord>),
	getManyByVerifiedBy('/socialImpactRecord/byVerifiedBy/:verifiedBy', HttpMethod.post, List<SocialImpactRecord>),
	getManyByProofUrl('/socialImpactRecord/byProofUrl/:proofUrl', HttpMethod.post, List<SocialImpactRecord>),
	getManyByDeletedAt('/socialImpactRecord/byDeletedAt/:deletedAt', HttpMethod.post, List<SocialImpactRecord>),
	getManyByCreatedAt('/socialImpactRecord/byCreatedAt/:createdAt', HttpMethod.post, List<SocialImpactRecord>);

    const SocialImpactRecordEndpoints(this.path, this.method, this.responseType);

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
