
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AttorneyManagementStore extends ModelStreamStore<String, AttorneyManagement> {

  static AttorneyManagementStore? _instance;

  static AttorneyManagementStore get instance {
    _instance ??= AttorneyManagementStore();
    return _instance!;
  }

  AttorneyManagementStore() : super(AttorneyManagement.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AttorneyManagementStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AttorneyManagementStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AttorneyManagementStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAttorneyManagementId(AttorneyManagement attorneyManagement) => attorneyManagement.id;

	String? getAttorneyManagementOrgId(AttorneyManagement attorneyManagement) => attorneyManagement.orgId;

	String? getAttorneyManagementDealId(AttorneyManagement attorneyManagement) => attorneyManagement.dealId;

	String? getAttorneyManagementContactId(AttorneyManagement attorneyManagement) => attorneyManagement.contactId;

	String? getAttorneyManagementSolicitorFirm(AttorneyManagement attorneyManagement) => attorneyManagement.solicitorFirm;

	String? getAttorneyManagementSolicitorName(AttorneyManagement attorneyManagement) => attorneyManagement.solicitorName;

	String? getAttorneyManagementSolicitorEmail(AttorneyManagement attorneyManagement) => attorneyManagement.solicitorEmail;

	String? getAttorneyManagementSolicitorPhone(AttorneyManagement attorneyManagement) => attorneyManagement.solicitorPhone;

	String? getAttorneyManagementAppointmentType(AttorneyManagement attorneyManagement) => attorneyManagement.appointmentType;

	DateTime? getAttorneyManagementAppointmentDate(AttorneyManagement attorneyManagement) => attorneyManagement.appointmentDate;

	String? getAttorneyManagementAppointmentNotes(AttorneyManagement attorneyManagement) => attorneyManagement.appointmentNotes;

	String? getAttorneyManagementStatus(AttorneyManagement attorneyManagement) => attorneyManagement.status;

	DateTime? getAttorneyManagementSearchDate(AttorneyManagement attorneyManagement) => attorneyManagement.searchDate;

	DateTime? getAttorneyManagementDraftContractDate(AttorneyManagement attorneyManagement) => attorneyManagement.draftContractDate;

	DateTime? getAttorneyManagementFinalContractDate(AttorneyManagement attorneyManagement) => attorneyManagement.finalContractDate;

	DateTime? getAttorneyManagementCompletionDate(AttorneyManagement attorneyManagement) => attorneyManagement.completionDate;

	String? getAttorneyManagementCompletionNotes(AttorneyManagement attorneyManagement) => attorneyManagement.completionNotes;

	dynamic? getAttorneyManagementFees(AttorneyManagement attorneyManagement) => attorneyManagement.fees;

	DateTime? getAttorneyManagementCreatedAt(AttorneyManagement attorneyManagement) => attorneyManagement.createdAt;

	DateTime? getAttorneyManagementUpdatedAt(AttorneyManagement attorneyManagement) => attorneyManagement.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
AttorneyManagement? getByDealId(
    String dealId,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getIncluding(getAttorneyManagementDealId, dealId, modelFilter: modelFilter, includes: includes);

  
List<AttorneyManagement> getByOrgId(
    String orgId,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByContactId(
    String contactId,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getBySolicitorFirm(
    String solicitorFirm,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementSolicitorFirm, solicitorFirm, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getBySolicitorName(
    String solicitorName,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementSolicitorName, solicitorName, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getBySolicitorEmail(
    String solicitorEmail,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementSolicitorEmail, solicitorEmail, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getBySolicitorPhone(
    String solicitorPhone,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementSolicitorPhone, solicitorPhone, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByAppointmentType(
    String appointmentType,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementAppointmentType, appointmentType, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByAppointmentDate(
    DateTime appointmentDate,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementAppointmentDate, appointmentDate, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByAppointmentNotes(
    String appointmentNotes,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementAppointmentNotes, appointmentNotes, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByStatus(
    String status,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementStatus, status, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getBySearchDate(
    DateTime searchDate,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementSearchDate, searchDate, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByDraftContractDate(
    DateTime draftContractDate,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementDraftContractDate, draftContractDate, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByFinalContractDate(
    DateTime finalContractDate,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementFinalContractDate, finalContractDate, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByCompletionDate(
    DateTime completionDate,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementCompletionDate, completionDate, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByCompletionNotes(
    String completionNotes,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementCompletionNotes, completionNotes, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByFees(
    dynamic fees,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementFees, fees, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AttorneyManagement> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}
    ) =>
    getManyIncluding(getAttorneyManagementUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    AttorneyManagement attorneyManagement, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (attorneyManagement.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(attorneyManagement.contactId!, includes: includes);
        attorneyManagement.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Deal? getDeal(
    AttorneyManagement attorneyManagement, {ModelFilter? modelFilter, List<DealInclude>? includes}) {
    if (attorneyManagement.dealId == null) {
        return null;
    } else {
        final deal = DealStore.instance.getById(attorneyManagement.dealId!, includes: includes);
        attorneyManagement.deal = deal;
        // setIncludedReferences(deal, includes: includes);
        return deal;
    }
}

	Organization? getOrg(
    AttorneyManagement attorneyManagement, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (attorneyManagement.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(attorneyManagement.orgId!, includes: includes);
        attorneyManagement.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AttorneyManagement>> getAll$({bool useCache = true, ModelFilter<AttorneyManagement>? modelFilter, List<AttorneyManagementInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AttorneyManagementEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AttorneyManagement?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAttorneyManagementId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<AttorneyManagement?> getByDealId$(
        String dealId,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAttorneyManagementDealId,
        value: dealId,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getByDealId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AttorneyManagement>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttorneyManagementOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttorneyManagementContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getBySolicitorFirm$(
        String solicitorFirm,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttorneyManagementSolicitorFirm,
        value: solicitorFirm,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyBySolicitorFirm,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getBySolicitorName$(
        String solicitorName,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttorneyManagementSolicitorName,
        value: solicitorName,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyBySolicitorName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getBySolicitorEmail$(
        String solicitorEmail,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttorneyManagementSolicitorEmail,
        value: solicitorEmail,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyBySolicitorEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getBySolicitorPhone$(
        String solicitorPhone,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttorneyManagementSolicitorPhone,
        value: solicitorPhone,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyBySolicitorPhone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByAppointmentType$(
        String appointmentType,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttorneyManagementAppointmentType,
        value: appointmentType,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByAppointmentType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByAppointmentDate$(
        DateTime appointmentDate,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAttorneyManagementAppointmentDate,
        value: appointmentDate,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByAppointmentDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByAppointmentNotes$(
        String appointmentNotes,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttorneyManagementAppointmentNotes,
        value: appointmentNotes,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByAppointmentNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByStatus$(
        String status,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttorneyManagementStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getBySearchDate$(
        DateTime searchDate,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAttorneyManagementSearchDate,
        value: searchDate,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyBySearchDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByDraftContractDate$(
        DateTime draftContractDate,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAttorneyManagementDraftContractDate,
        value: draftContractDate,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByDraftContractDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByFinalContractDate$(
        DateTime finalContractDate,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAttorneyManagementFinalContractDate,
        value: finalContractDate,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByFinalContractDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByCompletionDate$(
        DateTime completionDate,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAttorneyManagementCompletionDate,
        value: completionDate,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByCompletionDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByCompletionNotes$(
        String completionNotes,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttorneyManagementCompletionNotes,
        value: completionNotes,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByCompletionNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByFees$(
        dynamic fees,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAttorneyManagementFees,
        value: fees,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByFees,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAttorneyManagementCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AttorneyManagement>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AttorneyManagement>? modelFilter,
        List<AttorneyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAttorneyManagementUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AttorneyManagementEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    AttorneyManagement attorneyManagement, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (attorneyManagement.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            attorneyManagement.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            attorneyManagement.contact = contact;
        });
    }
}

	Stream<Deal?> getDeal$(
    AttorneyManagement attorneyManagement, {bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    if (attorneyManagement.dealId == null) {
        return Stream.value(null);
    } else {
        return DealStore.instance.getById$(
            attorneyManagement.dealId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((deal) {
            attorneyManagement.deal = deal;
        });
    }
}

	Stream<Organization?> getOrg$(
    AttorneyManagement attorneyManagement, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (attorneyManagement.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            attorneyManagement.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            attorneyManagement.org = org;
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
AttorneyManagement recursiveUpsert(AttorneyManagement attorneyManagement, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AttorneyManagement'} 
        : const {};
    if (attorneyManagement.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        attorneyManagement.contact = ContactStore.instance.recursiveUpsert(attorneyManagement.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (attorneyManagement.deal != null && (!preventCircularSerialization || !upsertedTypes.contains('Deal'))) {
        attorneyManagement.deal = DealStore.instance.recursiveUpsert(attorneyManagement.deal!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (attorneyManagement.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        attorneyManagement.org = OrganizationStore.instance.recursiveUpsert(attorneyManagement.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(attorneyManagement);
}

  List<AttorneyManagement> recursiveListUpsert(List<AttorneyManagement> attorneyManagements, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAttorneyManagements = <AttorneyManagement>[];
    for (var attorneyManagement in attorneyManagements) {
        updatedAttorneyManagements.add(recursiveUpsert(attorneyManagement, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAttorneyManagements;
}

//   @override
//   AttorneyManagement upsert(AttorneyManagement item) {
//     return recursiveUpsert(item);
//   }

}


class AttorneyManagementInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AttorneyManagementInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (attorneyManagement) => AttorneyManagementStore.instance
            .getContact$(attorneyManagement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (attorneyManagement) => AttorneyManagementStore.instance
            .getContact(attorneyManagement, modelFilter: modelFilter, includes: includes);
      }
}

	AttorneyManagementInclude.deal({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Deal>? modelFilter,
    List<DealInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (attorneyManagement) => AttorneyManagementStore.instance
            .getDeal$(attorneyManagement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (attorneyManagement) => AttorneyManagementStore.instance
            .getDeal(attorneyManagement, modelFilter: modelFilter, includes: includes);
      }
}

	AttorneyManagementInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (attorneyManagement) => AttorneyManagementStore.instance
            .getOrg$(attorneyManagement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (attorneyManagement) => AttorneyManagementStore.instance
            .getOrg(attorneyManagement, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AttorneyManagementEndpoints implements Endpoint {

    getAll('/attorneyManagement', HttpMethod.post, List<AttorneyManagement>),
	getById('/attorneyManagement/byId/:id', HttpMethod.post, AttorneyManagement),
	getManyByOrgId('/attorneyManagement/byOrgId/:orgId', HttpMethod.post, List<AttorneyManagement>),
	getByDealId('/attorneyManagement/byDealId/:dealId', HttpMethod.post, AttorneyManagement),
	getManyByContactId('/attorneyManagement/byContactId/:contactId', HttpMethod.post, List<AttorneyManagement>),
	getManyBySolicitorFirm('/attorneyManagement/bySolicitorFirm/:solicitorFirm', HttpMethod.post, List<AttorneyManagement>),
	getManyBySolicitorName('/attorneyManagement/bySolicitorName/:solicitorName', HttpMethod.post, List<AttorneyManagement>),
	getManyBySolicitorEmail('/attorneyManagement/bySolicitorEmail/:solicitorEmail', HttpMethod.post, List<AttorneyManagement>),
	getManyBySolicitorPhone('/attorneyManagement/bySolicitorPhone/:solicitorPhone', HttpMethod.post, List<AttorneyManagement>),
	getManyByAppointmentType('/attorneyManagement/byAppointmentType/:appointmentType', HttpMethod.post, List<AttorneyManagement>),
	getManyByAppointmentDate('/attorneyManagement/byAppointmentDate/:appointmentDate', HttpMethod.post, List<AttorneyManagement>),
	getManyByAppointmentNotes('/attorneyManagement/byAppointmentNotes/:appointmentNotes', HttpMethod.post, List<AttorneyManagement>),
	getManyByStatus('/attorneyManagement/byStatus/:status', HttpMethod.post, List<AttorneyManagement>),
	getManyBySearchDate('/attorneyManagement/bySearchDate/:searchDate', HttpMethod.post, List<AttorneyManagement>),
	getManyByDraftContractDate('/attorneyManagement/byDraftContractDate/:draftContractDate', HttpMethod.post, List<AttorneyManagement>),
	getManyByFinalContractDate('/attorneyManagement/byFinalContractDate/:finalContractDate', HttpMethod.post, List<AttorneyManagement>),
	getManyByCompletionDate('/attorneyManagement/byCompletionDate/:completionDate', HttpMethod.post, List<AttorneyManagement>),
	getManyByCompletionNotes('/attorneyManagement/byCompletionNotes/:completionNotes', HttpMethod.post, List<AttorneyManagement>),
	getManyByFees('/attorneyManagement/byFees/:fees', HttpMethod.post, List<AttorneyManagement>),
	getManyByCreatedAt('/attorneyManagement/byCreatedAt/:createdAt', HttpMethod.post, List<AttorneyManagement>),
	getManyByUpdatedAt('/attorneyManagement/byUpdatedAt/:updatedAt', HttpMethod.post, List<AttorneyManagement>);

    const AttorneyManagementEndpoints(this.path, this.method, this.responseType);

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
