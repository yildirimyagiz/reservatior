
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class VerificationStore extends ModelStreamStore<String, Verification> {

  static VerificationStore? _instance;

  static VerificationStore get instance {
    _instance ??= VerificationStore();
    return _instance!;
  }

  VerificationStore() : super(Verification.fromJson) {
    if (_instance != null) {
        throw Exception(
            'VerificationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending VerificationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use VerificationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getVerificationId(Verification verification) => verification.id;

	String? getVerificationIdentifier(Verification verification) => verification.identifier;

	String? getVerificationValue(Verification verification) => verification.value;

	DateTime? getVerificationExpiresAt(Verification verification) => verification.expiresAt;

	DateTime? getVerificationCreatedAt(Verification verification) => verification.createdAt;

	DateTime? getVerificationUpdatedAt(Verification verification) => verification.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Verification> getByIdentifier(
    String identifier,
    {ModelFilter<Verification>? modelFilter, List<VerificationInclude>? includes}
    ) =>
    getManyIncluding(getVerificationIdentifier, identifier, modelFilter: modelFilter, includes: includes);

	
List<Verification> getByValue(
    String value,
    {ModelFilter<Verification>? modelFilter, List<VerificationInclude>? includes}
    ) =>
    getManyIncluding(getVerificationValue, value, modelFilter: modelFilter, includes: includes);

	
List<Verification> getByExpiresAt(
    DateTime expiresAt,
    {ModelFilter<Verification>? modelFilter, List<VerificationInclude>? includes}
    ) =>
    getManyIncluding(getVerificationExpiresAt, expiresAt, modelFilter: modelFilter, includes: includes);

	
List<Verification> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Verification>? modelFilter, List<VerificationInclude>? includes}
    ) =>
    getManyIncluding(getVerificationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Verification> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Verification>? modelFilter, List<VerificationInclude>? includes}
    ) =>
    getManyIncluding(getVerificationUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Verification>> getAll$({bool useCache = true, ModelFilter<Verification>? modelFilter, List<VerificationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: VerificationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Verification?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Verification>? modelFilter,
        List<VerificationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getVerificationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: VerificationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Verification>> getByIdentifier$(
        String identifier,
        {bool useCache = true,
        ModelFilter<Verification>? modelFilter,
        List<VerificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVerificationIdentifier,
        value: identifier,
        modelFilter: modelFilter,
        endpoint: VerificationEndpoints.getManyByIdentifier,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Verification>> getByValue$(
        String value,
        {bool useCache = true,
        ModelFilter<Verification>? modelFilter,
        List<VerificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVerificationValue,
        value: value,
        modelFilter: modelFilter,
        endpoint: VerificationEndpoints.getManyByValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Verification>> getByExpiresAt$(
        DateTime expiresAt,
        {bool useCache = true,
        ModelFilter<Verification>? modelFilter,
        List<VerificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVerificationExpiresAt,
        value: expiresAt,
        modelFilter: modelFilter,
        endpoint: VerificationEndpoints.getManyByExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Verification>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Verification>? modelFilter,
        List<VerificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVerificationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: VerificationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Verification>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Verification>? modelFilter,
        List<VerificationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVerificationUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: VerificationEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  

  /// GET RELATED MODELS as STREAM

  

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Verification recursiveUpsert(Verification verification, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Verification'} 
        : const {};
    
    return super.upsert(verification);
}

  List<Verification> recursiveListUpsert(List<Verification> verifications, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedVerifications = <Verification>[];
    for (var verification in verifications) {
        updatedVerifications.add(recursiveUpsert(verification, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedVerifications;
}

//   @override
//   Verification upsert(Verification item) {
//     return recursiveUpsert(item);
//   }

}


class VerificationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      VerificationInclude.empty({this.useCache = true, this.useAsync = true});
  }


enum VerificationEndpoints implements Endpoint {

    getAll('/verification', HttpMethod.post, List<Verification>),
	getById('/verification/byId/:id', HttpMethod.post, Verification),
	getManyByIdentifier('/verification/byIdentifier/:identifier', HttpMethod.post, List<Verification>),
	getManyByValue('/verification/byValue/:value', HttpMethod.post, List<Verification>),
	getManyByExpiresAt('/verification/byExpiresAt/:expiresAt', HttpMethod.post, List<Verification>),
	getManyByCreatedAt('/verification/byCreatedAt/:createdAt', HttpMethod.post, List<Verification>),
	getManyByUpdatedAt('/verification/byUpdatedAt/:updatedAt', HttpMethod.post, List<Verification>);

    const VerificationEndpoints(this.path, this.method, this.responseType);

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
