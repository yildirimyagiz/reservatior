//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIChatHandoffStore extends ModelStreamStore<String, AIChatHandoff> {

  static AIChatHandoffStore? _instance;

  static AIChatHandoffStore get instance {
    _instance ??= AIChatHandoffStore();
    return _instance!;
  }

  AIChatHandoffStore() : super(AIChatHandoff.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIChatHandoffStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIChatHandoffStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIChatHandoffStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIChatHandoffId(AIChatHandoff aIChatHandoff) => aIChatHandoff.id;

	String? getAIChatHandoffOrgId(AIChatHandoff aIChatHandoff) => aIChatHandoff.orgId;

	String? getAIChatHandoffSessionId(AIChatHandoff aIChatHandoff) => aIChatHandoff.sessionId;

	String? getAIChatHandoffHandoffReason(AIChatHandoff aIChatHandoff) => aIChatHandoff.handoffReason;

	String? getAIChatHandoffHandoffTo(AIChatHandoff aIChatHandoff) => aIChatHandoff.handoffTo;

	DateTime? getAIChatHandoffHandoffAt(AIChatHandoff aIChatHandoff) => aIChatHandoff.handoffAt;

	DateTime? getAIChatHandoffResolvedAt(AIChatHandoff aIChatHandoff) => aIChatHandoff.resolvedAt;

	String? getAIChatHandoffResolvedBy(AIChatHandoff aIChatHandoff) => aIChatHandoff.resolvedBy;

	String? getAIChatHandoffNotes(AIChatHandoff aIChatHandoff) => aIChatHandoff.notes;

	DateTime? getAIChatHandoffDeletedAt(AIChatHandoff aIChatHandoff) => aIChatHandoff.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  Future<AIChatHandoff?> getAIChatHandoffById(String id) async {
    try {
      final aIChatHandoffs = await getAllAIChatHandoffs();
      return aIChatHandoffs.firstWhere(
        (aIChatHandoff) => aIChatHandoff.id == id,
      );
    } catch (e) {
      throw Exception('Failed to get AIChatHandoff by ID: $e');
    }
  }

  Future<List<AIChatHandoff>> getAIChatHandoffsBySessionId(String sessionId) async {
    try {
      final aIChatHandoffs = await getAllAIChatHandoffs();
      return aIChatHandoffs
          .where((aIChatHandoff) => aIChatHandoff.sessionId == sessionId)
          .toList();
    } catch (e) {
      throw Exception('Failed to get AIChatHandoffs by session ID: $e');
    }
  }
    String orgId,
    {ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}
    ) =>
    getManyIncluding(getAIChatHandoffOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIChatHandoff> getBySessionId(
    String sessionId,
    {ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}
    ) =>
    getManyIncluding(getAIChatHandoffSessionId, sessionId, modelFilter: modelFilter, includes: includes);

	
List<AIChatHandoff> getByHandoffReason(
    String handoffReason,
    {ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}
    ) =>
    getManyIncluding(getAIChatHandoffHandoffReason, handoffReason, modelFilter: modelFilter, includes: includes);

	
List<AIChatHandoff> getByHandoffTo(
    String handoffTo,
    {ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}
    ) =>
    getManyIncluding(getAIChatHandoffHandoffTo, handoffTo, modelFilter: modelFilter, includes: includes);

	
List<AIChatHandoff> getByHandoffAt(
    DateTime handoffAt,
    {ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}
    ) =>
    getManyIncluding(getAIChatHandoffHandoffAt, handoffAt, modelFilter: modelFilter, includes: includes);

	
List<AIChatHandoff> getByResolvedAt(
    DateTime resolvedAt,
    {ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}
    ) =>
    getManyIncluding(getAIChatHandoffResolvedAt, resolvedAt, modelFilter: modelFilter, includes: includes);

	
List<AIChatHandoff> getByResolvedBy(
    String resolvedBy,
    {ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}
    ) =>
    getManyIncluding(getAIChatHandoffResolvedBy, resolvedBy, modelFilter: modelFilter, includes: includes);

	
List<AIChatHandoff> getByNotes(
    String notes,
    {ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}
    ) =>
    getManyIncluding(getAIChatHandoffNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<AIChatHandoff> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}
    ) =>
    getManyIncluding(getAIChatHandoffDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  AIChatbotSession? getSession(
    AIChatHandoff aIChatHandoff, {ModelFilter? modelFilter, List<AIChatbotSessionInclude>? includes}) {
    if (aIChatHandoff.sessionId == null) {
        return null;
    } else {
        final session = AIChatbotSessionStore.instance.getById(aIChatHandoff.sessionId!, includes: includes);
        aIChatHandoff.session = session;
        // setIncludedReferences(session, includes: includes);
        return session;
    }
}

	Organization? getOrg(
    AIChatHandoff aIChatHandoff, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIChatHandoff.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIChatHandoff.orgId!, includes: includes);
        aIChatHandoff.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIChatHandoff>> getAll$({bool useCache = true, ModelFilter<AIChatHandoff>? modelFilter, List<AIChatHandoffInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIChatHandoffEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIChatHandoff?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIChatHandoff>? modelFilter,
        List<AIChatHandoffInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIChatHandoffId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIChatHandoffEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIChatHandoff>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIChatHandoff>? modelFilter,
        List<AIChatHandoffInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatHandoffOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIChatHandoffEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatHandoff>> getBySessionId$(
        String sessionId,
        {bool useCache = true,
        ModelFilter<AIChatHandoff>? modelFilter,
        List<AIChatHandoffInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatHandoffSessionId,
        value: sessionId,
        modelFilter: modelFilter,
        endpoint: AIChatHandoffEndpoints.getManyBySessionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatHandoff>> getByHandoffReason$(
        String handoffReason,
        {bool useCache = true,
        ModelFilter<AIChatHandoff>? modelFilter,
        List<AIChatHandoffInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatHandoffHandoffReason,
        value: handoffReason,
        modelFilter: modelFilter,
        endpoint: AIChatHandoffEndpoints.getManyByHandoffReason,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatHandoff>> getByHandoffTo$(
        String handoffTo,
        {bool useCache = true,
        ModelFilter<AIChatHandoff>? modelFilter,
        List<AIChatHandoffInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatHandoffHandoffTo,
        value: handoffTo,
        modelFilter: modelFilter,
        endpoint: AIChatHandoffEndpoints.getManyByHandoffTo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatHandoff>> getByHandoffAt$(
        DateTime handoffAt,
        {bool useCache = true,
        ModelFilter<AIChatHandoff>? modelFilter,
        List<AIChatHandoffInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIChatHandoffHandoffAt,
        value: handoffAt,
        modelFilter: modelFilter,
        endpoint: AIChatHandoffEndpoints.getManyByHandoffAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatHandoff>> getByResolvedAt$(
        DateTime resolvedAt,
        {bool useCache = true,
        ModelFilter<AIChatHandoff>? modelFilter,
        List<AIChatHandoffInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIChatHandoffResolvedAt,
        value: resolvedAt,
        modelFilter: modelFilter,
        endpoint: AIChatHandoffEndpoints.getManyByResolvedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatHandoff>> getByResolvedBy$(
        String resolvedBy,
        {bool useCache = true,
        ModelFilter<AIChatHandoff>? modelFilter,
        List<AIChatHandoffInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatHandoffResolvedBy,
        value: resolvedBy,
        modelFilter: modelFilter,
        endpoint: AIChatHandoffEndpoints.getManyByResolvedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatHandoff>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<AIChatHandoff>? modelFilter,
        List<AIChatHandoffInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIChatHandoffNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: AIChatHandoffEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIChatHandoff>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<AIChatHandoff>? modelFilter,
        List<AIChatHandoffInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIChatHandoffDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: AIChatHandoffEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<AIChatbotSession?> getSession$(
    AIChatHandoff aIChatHandoff, {bool useCache = true, ModelFilter<AIChatbotSession>? modelFilter, List<AIChatbotSessionInclude>? includes}) {
    if (aIChatHandoff.sessionId == null) {
        return Stream.value(null);
    } else {
        return AIChatbotSessionStore.instance.getBySessionId$(
            aIChatHandoff.sessionId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((session) {
            aIChatHandoff.session = session;
        });
    }
}

	Stream<Organization?> getOrg$(
    AIChatHandoff aIChatHandoff, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIChatHandoff.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIChatHandoff.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIChatHandoff.org = org;
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
AIChatHandoff recursiveUpsert(AIChatHandoff aIChatHandoff, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIChatHandoff'} 
        : const {};
    if (aIChatHandoff.session != null && (!preventCircularSerialization || !upsertedTypes.contains('AIChatbotSession'))) {
        aIChatHandoff.session = AIChatbotSessionStore.instance.recursiveUpsert(aIChatHandoff.session!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIChatHandoff.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIChatHandoff.org = OrganizationStore.instance.recursiveUpsert(aIChatHandoff.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIChatHandoff);
}

  List<AIChatHandoff> recursiveListUpsert(List<AIChatHandoff> aIChatHandoffs, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIChatHandoffs = <AIChatHandoff>[];
    for (var aIChatHandoff in aIChatHandoffs) {
        updatedAIChatHandoffs.add(recursiveUpsert(aIChatHandoff, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIChatHandoffs;
}

//   @override
//   AIChatHandoff upsert(AIChatHandoff item) {
//     return recursiveUpsert(item);
//   }

}


class AIChatHandoffInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIChatHandoffInclude.session({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AIChatbotSession>? modelFilter,
    List<AIChatbotSessionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIChatHandoff) => AIChatHandoffStore.instance
            .getSession$(aIChatHandoff, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIChatHandoff) => AIChatHandoffStore.instance
            .getSession(aIChatHandoff, modelFilter: modelFilter, includes: includes);
      }
}

	AIChatHandoffInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIChatHandoff) => AIChatHandoffStore.instance
            .getOrg$(aIChatHandoff, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIChatHandoff) => AIChatHandoffStore.instance
            .getOrg(aIChatHandoff, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIChatHandoffEndpoints implements Endpoint {

    getAll('/aIChatHandoff', HttpMethod.post, List<AIChatHandoff>),
	getById('/aIChatHandoff/byId/:id', HttpMethod.post, AIChatHandoff),
	getManyByOrgId('/aIChatHandoff/byOrgId/:orgId', HttpMethod.post, List<AIChatHandoff>),
	getManyBySessionId('/aIChatHandoff/bySessionId/:sessionId', HttpMethod.post, List<AIChatHandoff>),
	getManyByHandoffReason('/aIChatHandoff/byHandoffReason/:handoffReason', HttpMethod.post, List<AIChatHandoff>),
	getManyByHandoffTo('/aIChatHandoff/byHandoffTo/:handoffTo', HttpMethod.post, List<AIChatHandoff>),
	getManyByHandoffAt('/aIChatHandoff/byHandoffAt/:handoffAt', HttpMethod.post, List<AIChatHandoff>),
	getManyByResolvedAt('/aIChatHandoff/byResolvedAt/:resolvedAt', HttpMethod.post, List<AIChatHandoff>),
	getManyByResolvedBy('/aIChatHandoff/byResolvedBy/:resolvedBy', HttpMethod.post, List<AIChatHandoff>),
	getManyByNotes('/aIChatHandoff/byNotes/:notes', HttpMethod.post, List<AIChatHandoff>),
	getManyByDeletedAt('/aIChatHandoff/byDeletedAt/:deletedAt', HttpMethod.post, List<AIChatHandoff>);

    const AIChatHandoffEndpoints(this.path, this.method, this.responseType);

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
