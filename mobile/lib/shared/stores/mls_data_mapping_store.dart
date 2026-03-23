
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MlsDataMappingStore extends ModelStreamStore<String, MlsDataMapping> {

  static MlsDataMappingStore? _instance;

  static MlsDataMappingStore get instance {
    _instance ??= MlsDataMappingStore();
    return _instance!;
  }

  MlsDataMappingStore() : super(MlsDataMapping.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MlsDataMappingStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MlsDataMappingStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MlsDataMappingStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMlsDataMappingId(MlsDataMapping mlsDataMapping) => mlsDataMapping.id;

	String? getMlsDataMappingOrgId(MlsDataMapping mlsDataMapping) => mlsDataMapping.orgId;

	MLSProviderKey? getMlsDataMappingMlsProvider(MlsDataMapping mlsDataMapping) => mlsDataMapping.mlsProvider;

	String? getMlsDataMappingFieldName(MlsDataMapping mlsDataMapping) => mlsDataMapping.fieldName;

	String? getMlsDataMappingStandardField(MlsDataMapping mlsDataMapping) => mlsDataMapping.standardField;

	String? getMlsDataMappingDataType(MlsDataMapping mlsDataMapping) => mlsDataMapping.dataType;

	bool? getMlsDataMappingIsRequired(MlsDataMapping mlsDataMapping) => mlsDataMapping.isRequired;

	dynamic? getMlsDataMappingTransformRule(MlsDataMapping mlsDataMapping) => mlsDataMapping.transformRule;

	String? getMlsDataMappingCreatedBy(MlsDataMapping mlsDataMapping) => mlsDataMapping.createdBy;

	DateTime? getMlsDataMappingCreatedAt(MlsDataMapping mlsDataMapping) => mlsDataMapping.createdAt;

	DateTime? getMlsDataMappingUpdatedAt(MlsDataMapping mlsDataMapping) => mlsDataMapping.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MlsDataMapping> getByOrgId(
    String orgId,
    {ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}
    ) =>
    getManyIncluding(getMlsDataMappingOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<MlsDataMapping> getByMlsProvider(
    MLSProviderKey mlsProvider,
    {ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}
    ) =>
    getManyIncluding(getMlsDataMappingMlsProvider, mlsProvider, modelFilter: modelFilter, includes: includes);

	
List<MlsDataMapping> getByFieldName(
    String fieldName,
    {ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}
    ) =>
    getManyIncluding(getMlsDataMappingFieldName, fieldName, modelFilter: modelFilter, includes: includes);

	
List<MlsDataMapping> getByStandardField(
    String standardField,
    {ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}
    ) =>
    getManyIncluding(getMlsDataMappingStandardField, standardField, modelFilter: modelFilter, includes: includes);

	
List<MlsDataMapping> getByDataType(
    String dataType,
    {ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}
    ) =>
    getManyIncluding(getMlsDataMappingDataType, dataType, modelFilter: modelFilter, includes: includes);

	
List<MlsDataMapping> getByIsRequired(
    bool isRequired,
    {ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}
    ) =>
    getManyIncluding(getMlsDataMappingIsRequired, isRequired, modelFilter: modelFilter, includes: includes);

	
List<MlsDataMapping> getByTransformRule(
    dynamic transformRule,
    {ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}
    ) =>
    getManyIncluding(getMlsDataMappingTransformRule, transformRule, modelFilter: modelFilter, includes: includes);

	
List<MlsDataMapping> getByCreatedBy(
    String createdBy,
    {ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}
    ) =>
    getManyIncluding(getMlsDataMappingCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<MlsDataMapping> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}
    ) =>
    getManyIncluding(getMlsDataMappingCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MlsDataMapping> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}
    ) =>
    getManyIncluding(getMlsDataMappingUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    MlsDataMapping mlsDataMapping, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (mlsDataMapping.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(mlsDataMapping.orgId!, includes: includes);
        mlsDataMapping.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MlsDataMapping>> getAll$({bool useCache = true, ModelFilter<MlsDataMapping>? modelFilter, List<MlsDataMappingInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MlsDataMappingEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MlsDataMapping?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MlsDataMapping>? modelFilter,
        List<MlsDataMappingInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMlsDataMappingId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MlsDataMappingEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MlsDataMapping>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<MlsDataMapping>? modelFilter,
        List<MlsDataMappingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMlsDataMappingOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MlsDataMappingEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsDataMapping>> getByMlsProvider$(
        MLSProviderKey mlsProvider,
        {bool useCache = true,
        ModelFilter<MlsDataMapping>? modelFilter,
        List<MlsDataMappingInclude>? includes}) {
    final items$ = getManyByFieldValue$<MLSProviderKey>(
        getPropVal: getMlsDataMappingMlsProvider,
        value: mlsProvider,
        modelFilter: modelFilter,
        endpoint: MlsDataMappingEndpoints.getManyByMlsProvider,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsDataMapping>> getByFieldName$(
        String fieldName,
        {bool useCache = true,
        ModelFilter<MlsDataMapping>? modelFilter,
        List<MlsDataMappingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMlsDataMappingFieldName,
        value: fieldName,
        modelFilter: modelFilter,
        endpoint: MlsDataMappingEndpoints.getManyByFieldName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsDataMapping>> getByStandardField$(
        String standardField,
        {bool useCache = true,
        ModelFilter<MlsDataMapping>? modelFilter,
        List<MlsDataMappingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMlsDataMappingStandardField,
        value: standardField,
        modelFilter: modelFilter,
        endpoint: MlsDataMappingEndpoints.getManyByStandardField,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsDataMapping>> getByDataType$(
        String dataType,
        {bool useCache = true,
        ModelFilter<MlsDataMapping>? modelFilter,
        List<MlsDataMappingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMlsDataMappingDataType,
        value: dataType,
        modelFilter: modelFilter,
        endpoint: MlsDataMappingEndpoints.getManyByDataType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsDataMapping>> getByIsRequired$(
        bool isRequired,
        {bool useCache = true,
        ModelFilter<MlsDataMapping>? modelFilter,
        List<MlsDataMappingInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getMlsDataMappingIsRequired,
        value: isRequired,
        modelFilter: modelFilter,
        endpoint: MlsDataMappingEndpoints.getManyByIsRequired,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsDataMapping>> getByTransformRule$(
        dynamic transformRule,
        {bool useCache = true,
        ModelFilter<MlsDataMapping>? modelFilter,
        List<MlsDataMappingInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getMlsDataMappingTransformRule,
        value: transformRule,
        modelFilter: modelFilter,
        endpoint: MlsDataMappingEndpoints.getManyByTransformRule,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsDataMapping>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<MlsDataMapping>? modelFilter,
        List<MlsDataMappingInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMlsDataMappingCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: MlsDataMappingEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsDataMapping>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MlsDataMapping>? modelFilter,
        List<MlsDataMappingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMlsDataMappingCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MlsDataMappingEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MlsDataMapping>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MlsDataMapping>? modelFilter,
        List<MlsDataMappingInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMlsDataMappingUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MlsDataMappingEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    MlsDataMapping mlsDataMapping, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (mlsDataMapping.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            mlsDataMapping.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            mlsDataMapping.org = org;
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
MlsDataMapping recursiveUpsert(MlsDataMapping mlsDataMapping, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MlsDataMapping'} 
        : const {};
    if (mlsDataMapping.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        mlsDataMapping.org = OrganizationStore.instance.recursiveUpsert(mlsDataMapping.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(mlsDataMapping);
}

  List<MlsDataMapping> recursiveListUpsert(List<MlsDataMapping> mlsDataMappings, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMlsDataMappings = <MlsDataMapping>[];
    for (var mlsDataMapping in mlsDataMappings) {
        updatedMlsDataMappings.add(recursiveUpsert(mlsDataMapping, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMlsDataMappings;
}

//   @override
//   MlsDataMapping upsert(MlsDataMapping item) {
//     return recursiveUpsert(item);
//   }

}


class MlsDataMappingInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MlsDataMappingInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mlsDataMapping) => MlsDataMappingStore.instance
            .getOrg$(mlsDataMapping, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mlsDataMapping) => MlsDataMappingStore.instance
            .getOrg(mlsDataMapping, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MlsDataMappingEndpoints implements Endpoint {

    getAll('/mlsDataMapping', HttpMethod.post, List<MlsDataMapping>),
	getById('/mlsDataMapping/byId/:id', HttpMethod.post, MlsDataMapping),
	getManyByOrgId('/mlsDataMapping/byOrgId/:orgId', HttpMethod.post, List<MlsDataMapping>),
	getManyByMlsProvider('/mlsDataMapping/byMlsProvider/:mlsProvider', HttpMethod.post, List<MlsDataMapping>),
	getManyByFieldName('/mlsDataMapping/byFieldName/:fieldName', HttpMethod.post, List<MlsDataMapping>),
	getManyByStandardField('/mlsDataMapping/byStandardField/:standardField', HttpMethod.post, List<MlsDataMapping>),
	getManyByDataType('/mlsDataMapping/byDataType/:dataType', HttpMethod.post, List<MlsDataMapping>),
	getManyByIsRequired('/mlsDataMapping/byIsRequired/:isRequired', HttpMethod.post, List<MlsDataMapping>),
	getManyByTransformRule('/mlsDataMapping/byTransformRule/:transformRule', HttpMethod.post, List<MlsDataMapping>),
	getManyByCreatedBy('/mlsDataMapping/byCreatedBy/:createdBy', HttpMethod.post, List<MlsDataMapping>),
	getManyByCreatedAt('/mlsDataMapping/byCreatedAt/:createdAt', HttpMethod.post, List<MlsDataMapping>),
	getManyByUpdatedAt('/mlsDataMapping/byUpdatedAt/:updatedAt', HttpMethod.post, List<MlsDataMapping>);

    const MlsDataMappingEndpoints(this.path, this.method, this.responseType);

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
