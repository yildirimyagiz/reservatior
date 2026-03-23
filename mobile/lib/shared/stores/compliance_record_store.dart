
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ComplianceRecordStore extends ModelStreamStore<String, ComplianceRecord> {

  static ComplianceRecordStore? _instance;

  static ComplianceRecordStore get instance {
    _instance ??= ComplianceRecordStore();
    return _instance!;
  }

  ComplianceRecordStore() : super(ComplianceRecord.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ComplianceRecordStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ComplianceRecordStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ComplianceRecordStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getComplianceRecordId(ComplianceRecord complianceRecord) => complianceRecord.id;

	String? getComplianceRecordEntityId(ComplianceRecord complianceRecord) => complianceRecord.entityId;

	String? getComplianceRecordEntityType(ComplianceRecord complianceRecord) => complianceRecord.entityType;

	ComplianceType? getComplianceRecordType(ComplianceRecord complianceRecord) => complianceRecord.type;

	ComplianceStatus? getComplianceRecordStatus(ComplianceRecord complianceRecord) => complianceRecord.status;

	String? getComplianceRecordDocumentUrl(ComplianceRecord complianceRecord) => complianceRecord.documentUrl;

	DateTime? getComplianceRecordExpiryDate(ComplianceRecord complianceRecord) => complianceRecord.expiryDate;

	String? getComplianceRecordNotes(ComplianceRecord complianceRecord) => complianceRecord.notes;

	bool? getComplianceRecordIsVerified(ComplianceRecord complianceRecord) => complianceRecord.isVerified;

	String? getComplianceRecordPropertyId(ComplianceRecord complianceRecord) => complianceRecord.propertyId;

	String? getComplianceRecordAgentId(ComplianceRecord complianceRecord) => complianceRecord.agentId;

	String? getComplianceRecordAgencyId(ComplianceRecord complianceRecord) => complianceRecord.agencyId;

	String? getComplianceRecordReservationId(ComplianceRecord complianceRecord) => complianceRecord.reservationId;

	DateTime? getComplianceRecordCreatedAt(ComplianceRecord complianceRecord) => complianceRecord.createdAt;

	DateTime? getComplianceRecordUpdatedAt(ComplianceRecord complianceRecord) => complianceRecord.updatedAt;

	DateTime? getComplianceRecordDeletedAt(ComplianceRecord complianceRecord) => complianceRecord.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ComplianceRecord> getByEntityId(
    String entityId,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordEntityId, entityId, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByEntityType(
    String entityType,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordEntityType, entityType, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByType(
    ComplianceType type,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordType, type, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByStatus(
    ComplianceStatus status,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordStatus, status, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByDocumentUrl(
    String documentUrl,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordDocumentUrl, documentUrl, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByExpiryDate(
    DateTime expiryDate,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordExpiryDate, expiryDate, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByNotes(
    String notes,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByIsVerified(
    bool isVerified,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordIsVerified, isVerified, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByPropertyId(
    String propertyId,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByAgentId(
    String agentId,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordAgentId, agentId, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByAgencyId(
    String agencyId,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByReservationId(
    String reservationId,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordReservationId, reservationId, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ComplianceRecord> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}
    ) =>
    getManyIncluding(getComplianceRecordDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Agency? getAgency(
    ComplianceRecord complianceRecord, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (complianceRecord.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(complianceRecord.agencyId!, includes: includes);
        complianceRecord.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

	Agent? getAgent(
    ComplianceRecord complianceRecord, {ModelFilter? modelFilter, List<AgentInclude>? includes}) {
    if (complianceRecord.agentId == null) {
        return null;
    } else {
        final Agent = AgentStore.instance.getById(complianceRecord.agentId!, includes: includes);
        complianceRecord.Agent = Agent;
        // setIncludedReferences(Agent, includes: includes);
        return Agent;
    }
}

	Property? getProperty(
    ComplianceRecord complianceRecord, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (complianceRecord.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(complianceRecord.propertyId!, includes: includes);
        complianceRecord.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

	Reservation? getReservation(
    ComplianceRecord complianceRecord, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (complianceRecord.reservationId == null) {
        return null;
    } else {
        final Reservation = ReservationStore.instance.getById(complianceRecord.reservationId!, includes: includes);
        complianceRecord.Reservation = Reservation;
        // setIncludedReferences(Reservation, includes: includes);
        return Reservation;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ComplianceRecord>> getAll$({bool useCache = true, ModelFilter<ComplianceRecord>? modelFilter, List<ComplianceRecordInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ComplianceRecordEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ComplianceRecord?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getComplianceRecordId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ComplianceRecord>> getByEntityId$(
        String entityId,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getComplianceRecordEntityId,
        value: entityId,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByEntityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByEntityType$(
        String entityType,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getComplianceRecordEntityType,
        value: entityType,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByEntityType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByType$(
        ComplianceType type,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<ComplianceType>(
        getPropVal: getComplianceRecordType,
        value: type,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByStatus$(
        ComplianceStatus status,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<ComplianceStatus>(
        getPropVal: getComplianceRecordStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByDocumentUrl$(
        String documentUrl,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getComplianceRecordDocumentUrl,
        value: documentUrl,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByDocumentUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByExpiryDate$(
        DateTime expiryDate,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getComplianceRecordExpiryDate,
        value: expiryDate,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByExpiryDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getComplianceRecordNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByIsVerified$(
        bool isVerified,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getComplianceRecordIsVerified,
        value: isVerified,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByIsVerified,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getComplianceRecordPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByAgentId$(
        String agentId,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getComplianceRecordAgentId,
        value: agentId,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByAgentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getComplianceRecordAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getComplianceRecordReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getComplianceRecordCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getComplianceRecordUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ComplianceRecord>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ComplianceRecord>? modelFilter,
        List<ComplianceRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getComplianceRecordDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ComplianceRecordEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Agency?> getAgency$(
    ComplianceRecord complianceRecord, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (complianceRecord.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            complianceRecord.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            complianceRecord.Agency = Agency;
        });
    }
}

	Stream<Agent?> getAgent$(
    ComplianceRecord complianceRecord, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    if (complianceRecord.agentId == null) {
        return Stream.value(null);
    } else {
        return AgentStore.instance.getById$(
            complianceRecord.agentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agent) {
            complianceRecord.Agent = Agent;
        });
    }
}

	Stream<Property?> getProperty$(
    ComplianceRecord complianceRecord, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (complianceRecord.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            complianceRecord.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            complianceRecord.Property = Property;
        });
    }
}

	Stream<Reservation?> getReservation$(
    ComplianceRecord complianceRecord, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (complianceRecord.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            complianceRecord.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Reservation) {
            complianceRecord.Reservation = Reservation;
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
ComplianceRecord recursiveUpsert(ComplianceRecord complianceRecord, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ComplianceRecord'} 
        : const {};
    if (complianceRecord.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        complianceRecord.Agency = AgencyStore.instance.recursiveUpsert(complianceRecord.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (complianceRecord.Agent != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        complianceRecord.Agent = AgentStore.instance.recursiveUpsert(complianceRecord.Agent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (complianceRecord.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        complianceRecord.Property = PropertyStore.instance.recursiveUpsert(complianceRecord.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (complianceRecord.Reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        complianceRecord.Reservation = ReservationStore.instance.recursiveUpsert(complianceRecord.Reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(complianceRecord);
}

  List<ComplianceRecord> recursiveListUpsert(List<ComplianceRecord> complianceRecords, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedComplianceRecords = <ComplianceRecord>[];
    for (var complianceRecord in complianceRecords) {
        updatedComplianceRecords.add(recursiveUpsert(complianceRecord, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedComplianceRecords;
}

//   @override
//   ComplianceRecord upsert(ComplianceRecord item) {
//     return recursiveUpsert(item);
//   }

}


class ComplianceRecordInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ComplianceRecordInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (complianceRecord) => ComplianceRecordStore.instance
            .getAgency$(complianceRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (complianceRecord) => ComplianceRecordStore.instance
            .getAgency(complianceRecord, modelFilter: modelFilter, includes: includes);
      }
}

	ComplianceRecordInclude.Agent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (complianceRecord) => ComplianceRecordStore.instance
            .getAgent$(complianceRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (complianceRecord) => ComplianceRecordStore.instance
            .getAgent(complianceRecord, modelFilter: modelFilter, includes: includes);
      }
}

	ComplianceRecordInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (complianceRecord) => ComplianceRecordStore.instance
            .getProperty$(complianceRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (complianceRecord) => ComplianceRecordStore.instance
            .getProperty(complianceRecord, modelFilter: modelFilter, includes: includes);
      }
}

	ComplianceRecordInclude.Reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (complianceRecord) => ComplianceRecordStore.instance
            .getReservation$(complianceRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (complianceRecord) => ComplianceRecordStore.instance
            .getReservation(complianceRecord, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ComplianceRecordEndpoints implements Endpoint {

    getAll('/complianceRecord', HttpMethod.post, List<ComplianceRecord>),
	getById('/complianceRecord/byId/:id', HttpMethod.post, ComplianceRecord),
	getManyByEntityId('/complianceRecord/byEntityId/:entityId', HttpMethod.post, List<ComplianceRecord>),
	getManyByEntityType('/complianceRecord/byEntityType/:entityType', HttpMethod.post, List<ComplianceRecord>),
	getManyByType('/complianceRecord/byType/:type', HttpMethod.post, List<ComplianceRecord>),
	getManyByStatus('/complianceRecord/byStatus/:status', HttpMethod.post, List<ComplianceRecord>),
	getManyByDocumentUrl('/complianceRecord/byDocumentUrl/:documentUrl', HttpMethod.post, List<ComplianceRecord>),
	getManyByExpiryDate('/complianceRecord/byExpiryDate/:expiryDate', HttpMethod.post, List<ComplianceRecord>),
	getManyByNotes('/complianceRecord/byNotes/:notes', HttpMethod.post, List<ComplianceRecord>),
	getManyByIsVerified('/complianceRecord/byIsVerified/:isVerified', HttpMethod.post, List<ComplianceRecord>),
	getManyByPropertyId('/complianceRecord/byPropertyId/:propertyId', HttpMethod.post, List<ComplianceRecord>),
	getManyByAgentId('/complianceRecord/byAgentId/:agentId', HttpMethod.post, List<ComplianceRecord>),
	getManyByAgencyId('/complianceRecord/byAgencyId/:agencyId', HttpMethod.post, List<ComplianceRecord>),
	getManyByReservationId('/complianceRecord/byReservationId/:reservationId', HttpMethod.post, List<ComplianceRecord>),
	getManyByCreatedAt('/complianceRecord/byCreatedAt/:createdAt', HttpMethod.post, List<ComplianceRecord>),
	getManyByUpdatedAt('/complianceRecord/byUpdatedAt/:updatedAt', HttpMethod.post, List<ComplianceRecord>),
	getManyByDeletedAt('/complianceRecord/byDeletedAt/:deletedAt', HttpMethod.post, List<ComplianceRecord>);

    const ComplianceRecordEndpoints(this.path, this.method, this.responseType);

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
