
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class SolicitorManagementStore extends ModelStreamStore<String, SolicitorManagement> {

  static SolicitorManagementStore? _instance;

  static SolicitorManagementStore get instance {
    _instance ??= SolicitorManagementStore();
    return _instance!;
  }

  SolicitorManagementStore() : super(SolicitorManagement.fromJson) {
    if (_instance != null) {
        throw Exception(
            'SolicitorManagementStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending SolicitorManagementStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use SolicitorManagementStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getSolicitorManagementId(SolicitorManagement solicitorManagement) => solicitorManagement.id;

	String? getSolicitorManagementOrgId(SolicitorManagement solicitorManagement) => solicitorManagement.orgId;

	String? getSolicitorManagementDealId(SolicitorManagement solicitorManagement) => solicitorManagement.dealId;

	String? getSolicitorManagementContactId(SolicitorManagement solicitorManagement) => solicitorManagement.contactId;

	String? getSolicitorManagementSolicitorType(SolicitorManagement solicitorManagement) => solicitorManagement.solicitorType;

	String? getSolicitorManagementStatus(SolicitorManagement solicitorManagement) => solicitorManagement.status;

	DateTime? getSolicitorManagementEngagedAt(SolicitorManagement solicitorManagement) => solicitorManagement.engagedAt;

	DateTime? getSolicitorManagementCompletedAt(SolicitorManagement solicitorManagement) => solicitorManagement.completedAt;

	double? getSolicitorManagementFee(SolicitorManagement solicitorManagement) => solicitorManagement.fee;

	String? getSolicitorManagementCurrency(SolicitorManagement solicitorManagement) => solicitorManagement.currency;

	String? getSolicitorManagementNotes(SolicitorManagement solicitorManagement) => solicitorManagement.notes;

	String? getSolicitorManagementCreatedBy(SolicitorManagement solicitorManagement) => solicitorManagement.createdBy;

	DateTime? getSolicitorManagementCreatedAt(SolicitorManagement solicitorManagement) => solicitorManagement.createdAt;

	DateTime? getSolicitorManagementUpdatedAt(SolicitorManagement solicitorManagement) => solicitorManagement.updatedAt;

	DateTime? getSolicitorManagementDeletedAt(SolicitorManagement solicitorManagement) => solicitorManagement.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<SolicitorManagement> getByOrgId(
    String orgId,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByDealId(
    String dealId,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementDealId, dealId, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByContactId(
    String contactId,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getBySolicitorType(
    String solicitorType,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementSolicitorType, solicitorType, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByStatus(
    String status,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementStatus, status, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByEngagedAt(
    DateTime engagedAt,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementEngagedAt, engagedAt, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByCompletedAt(
    DateTime completedAt,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementCompletedAt, completedAt, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByFee(
    double fee,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementFee, fee, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByCurrency(
    String currency,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByNotes(
    String notes,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByCreatedBy(
    String createdBy,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<SolicitorManagement> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}
    ) =>
    getManyIncluding(getSolicitorManagementDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    SolicitorManagement solicitorManagement, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (solicitorManagement.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(solicitorManagement.contactId!, includes: includes);
        solicitorManagement.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Deal? getDeal(
    SolicitorManagement solicitorManagement, {ModelFilter? modelFilter, List<DealInclude>? includes}) {
    if (solicitorManagement.dealId == null) {
        return null;
    } else {
        final deal = DealStore.instance.getById(solicitorManagement.dealId!, includes: includes);
        solicitorManagement.deal = deal;
        // setIncludedReferences(deal, includes: includes);
        return deal;
    }
}

	Organization? getOrg(
    SolicitorManagement solicitorManagement, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (solicitorManagement.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(solicitorManagement.orgId!, includes: includes);
        solicitorManagement.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<SolicitorManagement>> getAll$({bool useCache = true, ModelFilter<SolicitorManagement>? modelFilter, List<SolicitorManagementInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: SolicitorManagementEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<SolicitorManagement?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getSolicitorManagementId,
        value: id,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<SolicitorManagement>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSolicitorManagementOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByDealId$(
        String dealId,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSolicitorManagementDealId,
        value: dealId,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByDealId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSolicitorManagementContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getBySolicitorType$(
        String solicitorType,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSolicitorManagementSolicitorType,
        value: solicitorType,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyBySolicitorType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSolicitorManagementStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByEngagedAt$(
        DateTime engagedAt,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSolicitorManagementEngagedAt,
        value: engagedAt,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByEngagedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByCompletedAt$(
        DateTime completedAt,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSolicitorManagementCompletedAt,
        value: completedAt,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByCompletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByFee$(
        double fee,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getSolicitorManagementFee,
        value: fee,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByFee,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSolicitorManagementCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSolicitorManagementNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getSolicitorManagementCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSolicitorManagementCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSolicitorManagementUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<SolicitorManagement>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<SolicitorManagement>? modelFilter,
        List<SolicitorManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getSolicitorManagementDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: SolicitorManagementEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    SolicitorManagement solicitorManagement, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (solicitorManagement.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            solicitorManagement.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            solicitorManagement.contact = contact;
        });
    }
}

	Stream<Deal?> getDeal$(
    SolicitorManagement solicitorManagement, {bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    if (solicitorManagement.dealId == null) {
        return Stream.value(null);
    } else {
        return DealStore.instance.getById$(
            solicitorManagement.dealId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((deal) {
            solicitorManagement.deal = deal;
        });
    }
}

	Stream<Organization?> getOrg$(
    SolicitorManagement solicitorManagement, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (solicitorManagement.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            solicitorManagement.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            solicitorManagement.org = org;
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
SolicitorManagement recursiveUpsert(SolicitorManagement solicitorManagement, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'SolicitorManagement'} 
        : const {};
    if (solicitorManagement.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        solicitorManagement.contact = ContactStore.instance.recursiveUpsert(solicitorManagement.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (solicitorManagement.deal != null && (!preventCircularSerialization || !upsertedTypes.contains('Deal'))) {
        solicitorManagement.deal = DealStore.instance.recursiveUpsert(solicitorManagement.deal!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (solicitorManagement.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        solicitorManagement.org = OrganizationStore.instance.recursiveUpsert(solicitorManagement.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(solicitorManagement);
}

  List<SolicitorManagement> recursiveListUpsert(List<SolicitorManagement> solicitorManagements, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedSolicitorManagements = <SolicitorManagement>[];
    for (var solicitorManagement in solicitorManagements) {
        updatedSolicitorManagements.add(recursiveUpsert(solicitorManagement, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedSolicitorManagements;
}

//   @override
//   SolicitorManagement upsert(SolicitorManagement item) {
//     return recursiveUpsert(item);
//   }

}


class SolicitorManagementInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      SolicitorManagementInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (solicitorManagement) => SolicitorManagementStore.instance
            .getContact$(solicitorManagement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (solicitorManagement) => SolicitorManagementStore.instance
            .getContact(solicitorManagement, modelFilter: modelFilter, includes: includes);
      }
}

	SolicitorManagementInclude.deal({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Deal>? modelFilter,
    List<DealInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (solicitorManagement) => SolicitorManagementStore.instance
            .getDeal$(solicitorManagement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (solicitorManagement) => SolicitorManagementStore.instance
            .getDeal(solicitorManagement, modelFilter: modelFilter, includes: includes);
      }
}

	SolicitorManagementInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (solicitorManagement) => SolicitorManagementStore.instance
            .getOrg$(solicitorManagement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (solicitorManagement) => SolicitorManagementStore.instance
            .getOrg(solicitorManagement, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum SolicitorManagementEndpoints implements Endpoint {

    getAll('/solicitorManagement', HttpMethod.post, List<SolicitorManagement>),
	getById('/solicitorManagement/byId/:id', HttpMethod.post, SolicitorManagement),
	getManyByOrgId('/solicitorManagement/byOrgId/:orgId', HttpMethod.post, List<SolicitorManagement>),
	getManyByDealId('/solicitorManagement/byDealId/:dealId', HttpMethod.post, List<SolicitorManagement>),
	getManyByContactId('/solicitorManagement/byContactId/:contactId', HttpMethod.post, List<SolicitorManagement>),
	getManyBySolicitorType('/solicitorManagement/bySolicitorType/:solicitorType', HttpMethod.post, List<SolicitorManagement>),
	getManyByStatus('/solicitorManagement/byStatus/:status', HttpMethod.post, List<SolicitorManagement>),
	getManyByEngagedAt('/solicitorManagement/byEngagedAt/:engagedAt', HttpMethod.post, List<SolicitorManagement>),
	getManyByCompletedAt('/solicitorManagement/byCompletedAt/:completedAt', HttpMethod.post, List<SolicitorManagement>),
	getManyByFee('/solicitorManagement/byFee/:fee', HttpMethod.post, List<SolicitorManagement>),
	getManyByCurrency('/solicitorManagement/byCurrency/:currency', HttpMethod.post, List<SolicitorManagement>),
	getManyByNotes('/solicitorManagement/byNotes/:notes', HttpMethod.post, List<SolicitorManagement>),
	getManyByCreatedBy('/solicitorManagement/byCreatedBy/:createdBy', HttpMethod.post, List<SolicitorManagement>),
	getManyByCreatedAt('/solicitorManagement/byCreatedAt/:createdAt', HttpMethod.post, List<SolicitorManagement>),
	getManyByUpdatedAt('/solicitorManagement/byUpdatedAt/:updatedAt', HttpMethod.post, List<SolicitorManagement>),
	getManyByDeletedAt('/solicitorManagement/byDeletedAt/:deletedAt', HttpMethod.post, List<SolicitorManagement>);

    const SolicitorManagementEndpoints(this.path, this.method, this.responseType);

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
