
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class KeyManagementStore extends ModelStreamStore<String, KeyManagement> {

  static KeyManagementStore? _instance;

  static KeyManagementStore get instance {
    _instance ??= KeyManagementStore();
    return _instance!;
  }

  KeyManagementStore() : super(KeyManagement.fromJson) {
    if (_instance != null) {
        throw Exception(
            'KeyManagementStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending KeyManagementStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use KeyManagementStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getKeyManagementId(KeyManagement keyManagement) => keyManagement.id;

	String? getKeyManagementOrgId(KeyManagement keyManagement) => keyManagement.orgId;

	String? getKeyManagementPropertyId(KeyManagement keyManagement) => keyManagement.propertyId;

	String? getKeyManagementKeyType(KeyManagement keyManagement) => keyManagement.keyType;

	String? getKeyManagementKeyNumber(KeyManagement keyManagement) => keyManagement.keyNumber;

	String? getKeyManagementKeyLocation(KeyManagement keyManagement) => keyManagement.keyLocation;

	String? getKeyManagementKeySafeCode(KeyManagement keyManagement) => keyManagement.keySafeCode;

	String? getKeyManagementKeyStatus(KeyManagement keyManagement) => keyManagement.keyStatus;

	DateTime? getKeyManagementCutDate(KeyManagement keyManagement) => keyManagement.cutDate;

	String? getKeyManagementCutBy(KeyManagement keyManagement) => keyManagement.cutBy;

	double? getKeyManagementReplacementCost(KeyManagement keyManagement) => keyManagement.replacementCost;

	String? getKeyManagementNotes(KeyManagement keyManagement) => keyManagement.notes;

	DateTime? getKeyManagementCreatedAt(KeyManagement keyManagement) => keyManagement.createdAt;

	DateTime? getKeyManagementUpdatedAt(KeyManagement keyManagement) => keyManagement.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<KeyManagement> getByOrgId(
    String orgId,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByPropertyId(
    String propertyId,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByKeyType(
    String keyType,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementKeyType, keyType, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByKeyNumber(
    String keyNumber,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementKeyNumber, keyNumber, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByKeyLocation(
    String keyLocation,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementKeyLocation, keyLocation, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByKeySafeCode(
    String keySafeCode,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementKeySafeCode, keySafeCode, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByKeyStatus(
    String keyStatus,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementKeyStatus, keyStatus, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByCutDate(
    DateTime cutDate,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementCutDate, cutDate, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByCutBy(
    String cutBy,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementCutBy, cutBy, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByReplacementCost(
    double replacementCost,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementReplacementCost, replacementCost, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByNotes(
    String notes,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<KeyManagement> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}
    ) =>
    getManyIncluding(getKeyManagementUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    KeyManagement keyManagement, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (keyManagement.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(keyManagement.orgId!, includes: includes);
        keyManagement.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    KeyManagement keyManagement, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (keyManagement.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(keyManagement.propertyId!, includes: includes);
        keyManagement.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<KeyManagement>> getAll$({bool useCache = true, ModelFilter<KeyManagement>? modelFilter, List<KeyManagementInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: KeyManagementEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<KeyManagement?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getKeyManagementId,
        value: id,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<KeyManagement>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getKeyManagementOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getKeyManagementPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByKeyType$(
        String keyType,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getKeyManagementKeyType,
        value: keyType,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByKeyType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByKeyNumber$(
        String keyNumber,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getKeyManagementKeyNumber,
        value: keyNumber,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByKeyNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByKeyLocation$(
        String keyLocation,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getKeyManagementKeyLocation,
        value: keyLocation,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByKeyLocation,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByKeySafeCode$(
        String keySafeCode,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getKeyManagementKeySafeCode,
        value: keySafeCode,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByKeySafeCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByKeyStatus$(
        String keyStatus,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getKeyManagementKeyStatus,
        value: keyStatus,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByKeyStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByCutDate$(
        DateTime cutDate,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getKeyManagementCutDate,
        value: cutDate,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByCutDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByCutBy$(
        String cutBy,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getKeyManagementCutBy,
        value: cutBy,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByCutBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByReplacementCost$(
        double replacementCost,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getKeyManagementReplacementCost,
        value: replacementCost,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByReplacementCost,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getKeyManagementNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getKeyManagementCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<KeyManagement>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<KeyManagement>? modelFilter,
        List<KeyManagementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getKeyManagementUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: KeyManagementEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    KeyManagement keyManagement, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (keyManagement.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            keyManagement.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            keyManagement.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    KeyManagement keyManagement, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (keyManagement.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            keyManagement.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            keyManagement.property = property;
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
KeyManagement recursiveUpsert(KeyManagement keyManagement, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'KeyManagement'} 
        : const {};
    if (keyManagement.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        keyManagement.org = OrganizationStore.instance.recursiveUpsert(keyManagement.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (keyManagement.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        keyManagement.property = PropertyStore.instance.recursiveUpsert(keyManagement.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(keyManagement);
}

  List<KeyManagement> recursiveListUpsert(List<KeyManagement> keyManagements, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedKeyManagements = <KeyManagement>[];
    for (var keyManagement in keyManagements) {
        updatedKeyManagements.add(recursiveUpsert(keyManagement, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedKeyManagements;
}

//   @override
//   KeyManagement upsert(KeyManagement item) {
//     return recursiveUpsert(item);
//   }

}


class KeyManagementInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      KeyManagementInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (keyManagement) => KeyManagementStore.instance
            .getOrg$(keyManagement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (keyManagement) => KeyManagementStore.instance
            .getOrg(keyManagement, modelFilter: modelFilter, includes: includes);
      }
}

	KeyManagementInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (keyManagement) => KeyManagementStore.instance
            .getProperty$(keyManagement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (keyManagement) => KeyManagementStore.instance
            .getProperty(keyManagement, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum KeyManagementEndpoints implements Endpoint {

    getAll('/keyManagement', HttpMethod.post, List<KeyManagement>),
	getById('/keyManagement/byId/:id', HttpMethod.post, KeyManagement),
	getManyByOrgId('/keyManagement/byOrgId/:orgId', HttpMethod.post, List<KeyManagement>),
	getManyByPropertyId('/keyManagement/byPropertyId/:propertyId', HttpMethod.post, List<KeyManagement>),
	getManyByKeyType('/keyManagement/byKeyType/:keyType', HttpMethod.post, List<KeyManagement>),
	getManyByKeyNumber('/keyManagement/byKeyNumber/:keyNumber', HttpMethod.post, List<KeyManagement>),
	getManyByKeyLocation('/keyManagement/byKeyLocation/:keyLocation', HttpMethod.post, List<KeyManagement>),
	getManyByKeySafeCode('/keyManagement/byKeySafeCode/:keySafeCode', HttpMethod.post, List<KeyManagement>),
	getManyByKeyStatus('/keyManagement/byKeyStatus/:keyStatus', HttpMethod.post, List<KeyManagement>),
	getManyByCutDate('/keyManagement/byCutDate/:cutDate', HttpMethod.post, List<KeyManagement>),
	getManyByCutBy('/keyManagement/byCutBy/:cutBy', HttpMethod.post, List<KeyManagement>),
	getManyByReplacementCost('/keyManagement/byReplacementCost/:replacementCost', HttpMethod.post, List<KeyManagement>),
	getManyByNotes('/keyManagement/byNotes/:notes', HttpMethod.post, List<KeyManagement>),
	getManyByCreatedAt('/keyManagement/byCreatedAt/:createdAt', HttpMethod.post, List<KeyManagement>),
	getManyByUpdatedAt('/keyManagement/byUpdatedAt/:updatedAt', HttpMethod.post, List<KeyManagement>);

    const KeyManagementEndpoints(this.path, this.method, this.responseType);

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
