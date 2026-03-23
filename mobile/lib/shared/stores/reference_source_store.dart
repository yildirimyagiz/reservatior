
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ReferenceSourceStore extends ModelStreamStore<String, ReferenceSource> {

  static ReferenceSourceStore? _instance;

  static ReferenceSourceStore get instance {
    _instance ??= ReferenceSourceStore();
    return _instance!;
  }

  ReferenceSourceStore() : super(ReferenceSource.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ReferenceSourceStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ReferenceSourceStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ReferenceSourceStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getReferenceSourceId(ReferenceSource referenceSource) => referenceSource.id;

	String? getReferenceSourceName(ReferenceSource referenceSource) => referenceSource.name;

	String? getReferenceSourceLogo(ReferenceSource referenceSource) => referenceSource.logo;

	String? getReferenceSourceApiKey(ReferenceSource referenceSource) => referenceSource.apiKey;

	String? getReferenceSourceApiSecret(ReferenceSource referenceSource) => referenceSource.apiSecret;

	String? getReferenceSourceBaseUrl(ReferenceSource referenceSource) => referenceSource.baseUrl;

	bool? getReferenceSourceIsActive(ReferenceSource referenceSource) => referenceSource.isActive;

	double? getReferenceSourceCommission(ReferenceSource referenceSource) => referenceSource.commission;

	DateTime? getReferenceSourceCreatedAt(ReferenceSource referenceSource) => referenceSource.createdAt;

	DateTime? getReferenceSourceUpdatedAt(ReferenceSource referenceSource) => referenceSource.updatedAt;

	DateTime? getReferenceSourceDeletedAt(ReferenceSource referenceSource) => referenceSource.deletedAt;

	BookingSource? getReferenceSourceSource(ReferenceSource referenceSource) => referenceSource.source;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ReferenceSource> getByName(
    String name,
    {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}
    ) =>
    getManyIncluding(getReferenceSourceName, name, modelFilter: modelFilter, includes: includes);

	
List<ReferenceSource> getByLogo(
    String logo,
    {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}
    ) =>
    getManyIncluding(getReferenceSourceLogo, logo, modelFilter: modelFilter, includes: includes);

	
List<ReferenceSource> getByApiKey(
    String apiKey,
    {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}
    ) =>
    getManyIncluding(getReferenceSourceApiKey, apiKey, modelFilter: modelFilter, includes: includes);

	
List<ReferenceSource> getByApiSecret(
    String apiSecret,
    {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}
    ) =>
    getManyIncluding(getReferenceSourceApiSecret, apiSecret, modelFilter: modelFilter, includes: includes);

	
List<ReferenceSource> getByBaseUrl(
    String baseUrl,
    {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}
    ) =>
    getManyIncluding(getReferenceSourceBaseUrl, baseUrl, modelFilter: modelFilter, includes: includes);

	
List<ReferenceSource> getByIsActive(
    bool isActive,
    {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}
    ) =>
    getManyIncluding(getReferenceSourceIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<ReferenceSource> getByCommission(
    double commission,
    {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}
    ) =>
    getManyIncluding(getReferenceSourceCommission, commission, modelFilter: modelFilter, includes: includes);

	
List<ReferenceSource> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}
    ) =>
    getManyIncluding(getReferenceSourceCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ReferenceSource> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}
    ) =>
    getManyIncluding(getReferenceSourceUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ReferenceSource> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}
    ) =>
    getManyIncluding(getReferenceSourceDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<ReferenceSource> getBySource(
    BookingSource source,
    {ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}
    ) =>
    getManyIncluding(getReferenceSourceSource, source, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  List<CommissionRule> getCommissionRule(
    ReferenceSource referenceSource, {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}) {
    final commissionRule = CommissionRuleStore.instance.getByProviderId(referenceSource.$uid!, modelFilter: modelFilter, includes: includes);
    referenceSource.commissionRule = commissionRule;
    // setIncludedReferencesForList(commissionRule, includes: includes);
    return commissionRule;
}

	List<Report> getReport(
    ReferenceSource referenceSource, {ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    final report = ReportStore.instance.getBy(referenceSource.$uid!, modelFilter: modelFilter, includes: includes);
    referenceSource.report = report;
    // setIncludedReferencesForList(report, includes: includes);
    return report;
}

	List<Reservation> getReservations(
    ReferenceSource referenceSource, {ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    final reservations = ReservationStore.instance.getBy(referenceSource.$uid!, modelFilter: modelFilter, includes: includes);
    referenceSource.reservations = reservations;
    // setIncludedReferencesForList(reservations, includes: includes);
    return reservations;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ReferenceSource>> getAll$({bool useCache = true, ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ReferenceSourceEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ReferenceSource?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getReferenceSourceId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ReferenceSource>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReferenceSourceName,
        value: name,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReferenceSource>> getByLogo$(
        String logo,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReferenceSourceLogo,
        value: logo,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getManyByLogo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReferenceSource>> getByApiKey$(
        String apiKey,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReferenceSourceApiKey,
        value: apiKey,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getManyByApiKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReferenceSource>> getByApiSecret$(
        String apiSecret,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReferenceSourceApiSecret,
        value: apiSecret,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getManyByApiSecret,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReferenceSource>> getByBaseUrl$(
        String baseUrl,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReferenceSourceBaseUrl,
        value: baseUrl,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getManyByBaseUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReferenceSource>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getReferenceSourceIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReferenceSource>> getByCommission$(
        double commission,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getReferenceSourceCommission,
        value: commission,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getManyByCommission,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReferenceSource>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReferenceSourceCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReferenceSource>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReferenceSourceUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReferenceSource>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReferenceSourceDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ReferenceSource>> getBySource$(
        BookingSource source,
        {bool useCache = true,
        ModelFilter<ReferenceSource>? modelFilter,
        List<ReferenceSourceInclude>? includes}) {
    final items$ = getManyByFieldValue$<BookingSource>(
        getPropVal: getReferenceSourceSource,
        value: source,
        modelFilter: modelFilter,
        endpoint: ReferenceSourceEndpoints.getManyBySource,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  

  /// GET RELATED MODELS as STREAM

  Stream<List<CommissionRule>> getCommissionRule$(
    ReferenceSource referenceSource, {bool useCache = true, ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}) {
    return CommissionRuleStore.instance.getByProviderId$(
        referenceSource.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((commissionRule) {
        referenceSource.commissionRule = commissionRule;
    });

}

	Stream<List<Report>> getReport$(
    ReferenceSource referenceSource, {bool useCache = true, ModelFilter<Report>? modelFilter, List<ReportInclude>? includes}) {
    return ReportStore.instance.getBy$(
        referenceSource.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((report) {
        referenceSource.report = report;
    });

}

	Stream<List<Reservation>> getReservations$(
    ReferenceSource referenceSource, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    return ReservationStore.instance.getBy$(
        referenceSource.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((reservations) {
        referenceSource.reservations = reservations;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
ReferenceSource recursiveUpsert(ReferenceSource referenceSource, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ReferenceSource'} 
        : const {};
    if (referenceSource.commissionRule != null && (!preventCircularSerialization || !upsertedTypes.contains('CommissionRule'))) {
        referenceSource.commissionRule = CommissionRuleStore.instance.recursiveListUpsert(referenceSource.commissionRule!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (referenceSource.report != null && (!preventCircularSerialization || !upsertedTypes.contains('Report'))) {
        referenceSource.report = ReportStore.instance.recursiveListUpsert(referenceSource.report!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (referenceSource.reservations != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        referenceSource.reservations = ReservationStore.instance.recursiveListUpsert(referenceSource.reservations!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(referenceSource);
}

  List<ReferenceSource> recursiveListUpsert(List<ReferenceSource> referenceSources, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedReferenceSources = <ReferenceSource>[];
    for (var referenceSource in referenceSources) {
        updatedReferenceSources.add(recursiveUpsert(referenceSource, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedReferenceSources;
}

//   @override
//   ReferenceSource upsert(ReferenceSource item) {
//     return recursiveUpsert(item);
//   }

}


class ReferenceSourceInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ReferenceSourceInclude.commissionRule({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<CommissionRule>? modelFilter,
    List<CommissionRuleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (referenceSource) => ReferenceSourceStore.instance
            .getCommissionRule$(referenceSource, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (referenceSource) => ReferenceSourceStore.instance
            .getCommissionRule(referenceSource, modelFilter: modelFilter, includes: includes);
      }
}

	ReferenceSourceInclude.report({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Report>? modelFilter,
    List<ReportInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (referenceSource) => ReferenceSourceStore.instance
            .getReport$(referenceSource, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (referenceSource) => ReferenceSourceStore.instance
            .getReport(referenceSource, modelFilter: modelFilter, includes: includes);
      }
}

	ReferenceSourceInclude.reservations({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (referenceSource) => ReferenceSourceStore.instance
            .getReservations$(referenceSource, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (referenceSource) => ReferenceSourceStore.instance
            .getReservations(referenceSource, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ReferenceSourceEndpoints implements Endpoint {

    getAll('/referenceSource', HttpMethod.post, List<ReferenceSource>),
	getById('/referenceSource/byId/:id', HttpMethod.post, ReferenceSource),
	getManyByName('/referenceSource/byName/:name', HttpMethod.post, List<ReferenceSource>),
	getManyByLogo('/referenceSource/byLogo/:logo', HttpMethod.post, List<ReferenceSource>),
	getManyByApiKey('/referenceSource/byApiKey/:apiKey', HttpMethod.post, List<ReferenceSource>),
	getManyByApiSecret('/referenceSource/byApiSecret/:apiSecret', HttpMethod.post, List<ReferenceSource>),
	getManyByBaseUrl('/referenceSource/byBaseUrl/:baseUrl', HttpMethod.post, List<ReferenceSource>),
	getManyByIsActive('/referenceSource/byIsActive/:isActive', HttpMethod.post, List<ReferenceSource>),
	getManyByCommission('/referenceSource/byCommission/:commission', HttpMethod.post, List<ReferenceSource>),
	getManyByCreatedAt('/referenceSource/byCreatedAt/:createdAt', HttpMethod.post, List<ReferenceSource>),
	getManyByUpdatedAt('/referenceSource/byUpdatedAt/:updatedAt', HttpMethod.post, List<ReferenceSource>),
	getManyByDeletedAt('/referenceSource/byDeletedAt/:deletedAt', HttpMethod.post, List<ReferenceSource>),
	getManyBySource('/referenceSource/bySource/:source', HttpMethod.post, List<ReferenceSource>);

    const ReferenceSourceEndpoints(this.path, this.method, this.responseType);

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
