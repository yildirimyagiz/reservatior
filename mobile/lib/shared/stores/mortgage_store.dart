
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MortgageStore extends ModelStreamStore<String, Mortgage> {

  static MortgageStore? _instance;

  static MortgageStore get instance {
    _instance ??= MortgageStore();
    return _instance!;
  }

  MortgageStore() : super(Mortgage.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MortgageStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MortgageStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MortgageStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMortgageId(Mortgage mortgage) => mortgage.id;

	String? getMortgagePropertyId(Mortgage mortgage) => mortgage.propertyId;

	String? getMortgageLender(Mortgage mortgage) => mortgage.lender;

	double? getMortgagePrincipal(Mortgage mortgage) => mortgage.principal;

	double? getMortgageInterestRate(Mortgage mortgage) => mortgage.interestRate;

	DateTime? getMortgageStartDate(Mortgage mortgage) => mortgage.startDate;

	DateTime? getMortgageEndDate(Mortgage mortgage) => mortgage.endDate;

	MortgageStatus? getMortgageStatus(Mortgage mortgage) => mortgage.status;

	String? getMortgageNotes(Mortgage mortgage) => mortgage.notes;

	DateTime? getMortgageCreatedAt(Mortgage mortgage) => mortgage.createdAt;

	DateTime? getMortgageUpdatedAt(Mortgage mortgage) => mortgage.updatedAt;

	DateTime? getMortgageDeletedAt(Mortgage mortgage) => mortgage.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Mortgage> getByPropertyId(
    String propertyId,
    {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Mortgage> getByLender(
    String lender,
    {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}
    ) =>
    getManyIncluding(getMortgageLender, lender, modelFilter: modelFilter, includes: includes);

	
List<Mortgage> getByPrincipal(
    double principal,
    {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePrincipal, principal, modelFilter: modelFilter, includes: includes);

	
List<Mortgage> getByInterestRate(
    double interestRate,
    {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}
    ) =>
    getManyIncluding(getMortgageInterestRate, interestRate, modelFilter: modelFilter, includes: includes);

	
List<Mortgage> getByStartDate(
    DateTime startDate,
    {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}
    ) =>
    getManyIncluding(getMortgageStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<Mortgage> getByEndDate(
    DateTime endDate,
    {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}
    ) =>
    getManyIncluding(getMortgageEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<Mortgage> getByStatus(
    MortgageStatus status,
    {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}
    ) =>
    getManyIncluding(getMortgageStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Mortgage> getByNotes(
    String notes,
    {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}
    ) =>
    getManyIncluding(getMortgageNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Mortgage> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}
    ) =>
    getManyIncluding(getMortgageCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Mortgage> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}
    ) =>
    getManyIncluding(getMortgageUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Mortgage> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}
    ) =>
    getManyIncluding(getMortgageDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Property? getProperty(
    Mortgage mortgage, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (mortgage.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(mortgage.propertyId!, includes: includes);
        mortgage.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Mortgage>> getAll$({bool useCache = true, ModelFilter<Mortgage>? modelFilter, List<MortgageInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MortgageEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Mortgage?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMortgageId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Mortgage>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgagePropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mortgage>> getByLender$(
        String lender,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgageLender,
        value: lender,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getManyByLender,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mortgage>> getByPrincipal$(
        double principal,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgagePrincipal,
        value: principal,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getManyByPrincipal,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mortgage>> getByInterestRate$(
        double interestRate,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgageInterestRate,
        value: interestRate,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getManyByInterestRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mortgage>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgageStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mortgage>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgageEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mortgage>> getByStatus$(
        MortgageStatus status,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final items$ = getManyByFieldValue$<MortgageStatus>(
        getPropVal: getMortgageStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mortgage>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgageNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mortgage>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgageCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mortgage>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgageUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Mortgage>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Mortgage>? modelFilter,
        List<MortgageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgageDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: MortgageEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Property?> getProperty$(
    Mortgage mortgage, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (mortgage.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            mortgage.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            mortgage.Property = Property;
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
Mortgage recursiveUpsert(Mortgage mortgage, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Mortgage'} 
        : const {};
    if (mortgage.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        mortgage.Property = PropertyStore.instance.recursiveUpsert(mortgage.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(mortgage);
}

  List<Mortgage> recursiveListUpsert(List<Mortgage> mortgages, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMortgages = <Mortgage>[];
    for (var mortgage in mortgages) {
        updatedMortgages.add(recursiveUpsert(mortgage, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMortgages;
}

//   @override
//   Mortgage upsert(Mortgage item) {
//     return recursiveUpsert(item);
//   }

}


class MortgageInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MortgageInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mortgage) => MortgageStore.instance
            .getProperty$(mortgage, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mortgage) => MortgageStore.instance
            .getProperty(mortgage, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MortgageEndpoints implements Endpoint {

    getAll('/mortgage', HttpMethod.post, List<Mortgage>),
	getById('/mortgage/byId/:id', HttpMethod.post, Mortgage),
	getManyByPropertyId('/mortgage/byPropertyId/:propertyId', HttpMethod.post, List<Mortgage>),
	getManyByLender('/mortgage/byLender/:lender', HttpMethod.post, List<Mortgage>),
	getManyByPrincipal('/mortgage/byPrincipal/:principal', HttpMethod.post, List<Mortgage>),
	getManyByInterestRate('/mortgage/byInterestRate/:interestRate', HttpMethod.post, List<Mortgage>),
	getManyByStartDate('/mortgage/byStartDate/:startDate', HttpMethod.post, List<Mortgage>),
	getManyByEndDate('/mortgage/byEndDate/:endDate', HttpMethod.post, List<Mortgage>),
	getManyByStatus('/mortgage/byStatus/:status', HttpMethod.post, List<Mortgage>),
	getManyByNotes('/mortgage/byNotes/:notes', HttpMethod.post, List<Mortgage>),
	getManyByCreatedAt('/mortgage/byCreatedAt/:createdAt', HttpMethod.post, List<Mortgage>),
	getManyByUpdatedAt('/mortgage/byUpdatedAt/:updatedAt', HttpMethod.post, List<Mortgage>),
	getManyByDeletedAt('/mortgage/byDeletedAt/:deletedAt', HttpMethod.post, List<Mortgage>);

    const MortgageEndpoints(this.path, this.method, this.responseType);

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
