
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class VacationRentalPlatformStore extends ModelStreamStore<String, VacationRentalPlatform> {

  static VacationRentalPlatformStore? _instance;

  static VacationRentalPlatformStore get instance {
    _instance ??= VacationRentalPlatformStore();
    return _instance!;
  }

  VacationRentalPlatformStore() : super(VacationRentalPlatform.fromJson) {
    if (_instance != null) {
        throw Exception(
            'VacationRentalPlatformStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending VacationRentalPlatformStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use VacationRentalPlatformStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getVacationRentalPlatformId(VacationRentalPlatform vacationRentalPlatform) => vacationRentalPlatform.id;

	String? getVacationRentalPlatformRentalId(VacationRentalPlatform vacationRentalPlatform) => vacationRentalPlatform.rentalId;

	RentalPlatform? getVacationRentalPlatformPlatform(VacationRentalPlatform vacationRentalPlatform) => vacationRentalPlatform.platform;

	String? getVacationRentalPlatformExternalId(VacationRentalPlatform vacationRentalPlatform) => vacationRentalPlatform.externalId;

	String? getVacationRentalPlatformExternalUrl(VacationRentalPlatform vacationRentalPlatform) => vacationRentalPlatform.externalUrl;

	RentalStatus? getVacationRentalPlatformStatus(VacationRentalPlatform vacationRentalPlatform) => vacationRentalPlatform.status;

	DateTime? getVacationRentalPlatformLastSyncedAt(VacationRentalPlatform vacationRentalPlatform) => vacationRentalPlatform.lastSyncedAt;

	bool? getVacationRentalPlatformSyncEnabled(VacationRentalPlatform vacationRentalPlatform) => vacationRentalPlatform.syncEnabled;

	DateTime? getVacationRentalPlatformCreatedAt(VacationRentalPlatform vacationRentalPlatform) => vacationRentalPlatform.createdAt;

	DateTime? getVacationRentalPlatformUpdatedAt(VacationRentalPlatform vacationRentalPlatform) => vacationRentalPlatform.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<VacationRentalPlatform> getByRentalId(
    String rentalId,
    {ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalPlatformRentalId, rentalId, modelFilter: modelFilter, includes: includes);

	
List<VacationRentalPlatform> getByPlatform(
    RentalPlatform platform,
    {ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalPlatformPlatform, platform, modelFilter: modelFilter, includes: includes);

	
List<VacationRentalPlatform> getByExternalId(
    String externalId,
    {ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalPlatformExternalId, externalId, modelFilter: modelFilter, includes: includes);

	
List<VacationRentalPlatform> getByExternalUrl(
    String externalUrl,
    {ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalPlatformExternalUrl, externalUrl, modelFilter: modelFilter, includes: includes);

	
List<VacationRentalPlatform> getByStatus(
    RentalStatus status,
    {ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalPlatformStatus, status, modelFilter: modelFilter, includes: includes);

	
List<VacationRentalPlatform> getByLastSyncedAt(
    DateTime lastSyncedAt,
    {ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalPlatformLastSyncedAt, lastSyncedAt, modelFilter: modelFilter, includes: includes);

	
List<VacationRentalPlatform> getBySyncEnabled(
    bool syncEnabled,
    {ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalPlatformSyncEnabled, syncEnabled, modelFilter: modelFilter, includes: includes);

	
List<VacationRentalPlatform> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalPlatformCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<VacationRentalPlatform> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}
    ) =>
    getManyIncluding(getVacationRentalPlatformUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  VacationRental? getRental(
    VacationRentalPlatform vacationRentalPlatform, {ModelFilter? modelFilter, List<VacationRentalInclude>? includes}) {
    if (vacationRentalPlatform.rentalId == null) {
        return null;
    } else {
        final rental = VacationRentalStore.instance.getById(vacationRentalPlatform.rentalId!, includes: includes);
        vacationRentalPlatform.rental = rental;
        // setIncludedReferences(rental, includes: includes);
        return rental;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<VacationRentalPlatform>> getAll$({bool useCache = true, ModelFilter<VacationRentalPlatform>? modelFilter, List<VacationRentalPlatformInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: VacationRentalPlatformEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<VacationRentalPlatform?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<VacationRentalPlatform>? modelFilter,
        List<VacationRentalPlatformInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getVacationRentalPlatformId,
        value: id,
        modelFilter: modelFilter,
        endpoint: VacationRentalPlatformEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<VacationRentalPlatform>> getByRentalId$(
        String rentalId,
        {bool useCache = true,
        ModelFilter<VacationRentalPlatform>? modelFilter,
        List<VacationRentalPlatformInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVacationRentalPlatformRentalId,
        value: rentalId,
        modelFilter: modelFilter,
        endpoint: VacationRentalPlatformEndpoints.getManyByRentalId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRentalPlatform>> getByPlatform$(
        RentalPlatform platform,
        {bool useCache = true,
        ModelFilter<VacationRentalPlatform>? modelFilter,
        List<VacationRentalPlatformInclude>? includes}) {
    final items$ = getManyByFieldValue$<RentalPlatform>(
        getPropVal: getVacationRentalPlatformPlatform,
        value: platform,
        modelFilter: modelFilter,
        endpoint: VacationRentalPlatformEndpoints.getManyByPlatform,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRentalPlatform>> getByExternalId$(
        String externalId,
        {bool useCache = true,
        ModelFilter<VacationRentalPlatform>? modelFilter,
        List<VacationRentalPlatformInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVacationRentalPlatformExternalId,
        value: externalId,
        modelFilter: modelFilter,
        endpoint: VacationRentalPlatformEndpoints.getManyByExternalId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRentalPlatform>> getByExternalUrl$(
        String externalUrl,
        {bool useCache = true,
        ModelFilter<VacationRentalPlatform>? modelFilter,
        List<VacationRentalPlatformInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVacationRentalPlatformExternalUrl,
        value: externalUrl,
        modelFilter: modelFilter,
        endpoint: VacationRentalPlatformEndpoints.getManyByExternalUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRentalPlatform>> getByStatus$(
        RentalStatus status,
        {bool useCache = true,
        ModelFilter<VacationRentalPlatform>? modelFilter,
        List<VacationRentalPlatformInclude>? includes}) {
    final items$ = getManyByFieldValue$<RentalStatus>(
        getPropVal: getVacationRentalPlatformStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: VacationRentalPlatformEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRentalPlatform>> getByLastSyncedAt$(
        DateTime lastSyncedAt,
        {bool useCache = true,
        ModelFilter<VacationRentalPlatform>? modelFilter,
        List<VacationRentalPlatformInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVacationRentalPlatformLastSyncedAt,
        value: lastSyncedAt,
        modelFilter: modelFilter,
        endpoint: VacationRentalPlatformEndpoints.getManyByLastSyncedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRentalPlatform>> getBySyncEnabled$(
        bool syncEnabled,
        {bool useCache = true,
        ModelFilter<VacationRentalPlatform>? modelFilter,
        List<VacationRentalPlatformInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getVacationRentalPlatformSyncEnabled,
        value: syncEnabled,
        modelFilter: modelFilter,
        endpoint: VacationRentalPlatformEndpoints.getManyBySyncEnabled,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRentalPlatform>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<VacationRentalPlatform>? modelFilter,
        List<VacationRentalPlatformInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVacationRentalPlatformCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: VacationRentalPlatformEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VacationRentalPlatform>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<VacationRentalPlatform>? modelFilter,
        List<VacationRentalPlatformInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVacationRentalPlatformUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: VacationRentalPlatformEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<VacationRental?> getRental$(
    VacationRentalPlatform vacationRentalPlatform, {bool useCache = true, ModelFilter<VacationRental>? modelFilter, List<VacationRentalInclude>? includes}) {
    if (vacationRentalPlatform.rentalId == null) {
        return Stream.value(null);
    } else {
        return VacationRentalStore.instance.getById$(
            vacationRentalPlatform.rentalId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((rental) {
            vacationRentalPlatform.rental = rental;
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
VacationRentalPlatform recursiveUpsert(VacationRentalPlatform vacationRentalPlatform, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'VacationRentalPlatform'} 
        : const {};
    if (vacationRentalPlatform.rental != null && (!preventCircularSerialization || !upsertedTypes.contains('VacationRental'))) {
        vacationRentalPlatform.rental = VacationRentalStore.instance.recursiveUpsert(vacationRentalPlatform.rental!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(vacationRentalPlatform);
}

  List<VacationRentalPlatform> recursiveListUpsert(List<VacationRentalPlatform> vacationRentalPlatforms, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedVacationRentalPlatforms = <VacationRentalPlatform>[];
    for (var vacationRentalPlatform in vacationRentalPlatforms) {
        updatedVacationRentalPlatforms.add(recursiveUpsert(vacationRentalPlatform, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedVacationRentalPlatforms;
}

//   @override
//   VacationRentalPlatform upsert(VacationRentalPlatform item) {
//     return recursiveUpsert(item);
//   }

}


class VacationRentalPlatformInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      VacationRentalPlatformInclude.rental({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VacationRental>? modelFilter,
    List<VacationRentalInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (vacationRentalPlatform) => VacationRentalPlatformStore.instance
            .getRental$(vacationRentalPlatform, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (vacationRentalPlatform) => VacationRentalPlatformStore.instance
            .getRental(vacationRentalPlatform, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum VacationRentalPlatformEndpoints implements Endpoint {

    getAll('/vacationRentalPlatform', HttpMethod.post, List<VacationRentalPlatform>),
	getById('/vacationRentalPlatform/byId/:id', HttpMethod.post, VacationRentalPlatform),
	getManyByRentalId('/vacationRentalPlatform/byRentalId/:rentalId', HttpMethod.post, List<VacationRentalPlatform>),
	getManyByPlatform('/vacationRentalPlatform/byPlatform/:platform', HttpMethod.post, List<VacationRentalPlatform>),
	getManyByExternalId('/vacationRentalPlatform/byExternalId/:externalId', HttpMethod.post, List<VacationRentalPlatform>),
	getManyByExternalUrl('/vacationRentalPlatform/byExternalUrl/:externalUrl', HttpMethod.post, List<VacationRentalPlatform>),
	getManyByStatus('/vacationRentalPlatform/byStatus/:status', HttpMethod.post, List<VacationRentalPlatform>),
	getManyByLastSyncedAt('/vacationRentalPlatform/byLastSyncedAt/:lastSyncedAt', HttpMethod.post, List<VacationRentalPlatform>),
	getManyBySyncEnabled('/vacationRentalPlatform/bySyncEnabled/:syncEnabled', HttpMethod.post, List<VacationRentalPlatform>),
	getManyByCreatedAt('/vacationRentalPlatform/byCreatedAt/:createdAt', HttpMethod.post, List<VacationRentalPlatform>),
	getManyByUpdatedAt('/vacationRentalPlatform/byUpdatedAt/:updatedAt', HttpMethod.post, List<VacationRentalPlatform>);

    const VacationRentalPlatformEndpoints(this.path, this.method, this.responseType);

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
