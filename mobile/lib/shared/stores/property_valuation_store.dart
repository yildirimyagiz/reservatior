
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PropertyValuationStore extends ModelStreamStore<String, PropertyValuation> {

  static PropertyValuationStore? _instance;

  static PropertyValuationStore get instance {
    _instance ??= PropertyValuationStore();
    return _instance!;
  }

  PropertyValuationStore() : super(PropertyValuation.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PropertyValuationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PropertyValuationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PropertyValuationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPropertyValuationId(PropertyValuation propertyValuation) => propertyValuation.id;

	String? getPropertyValuationPropertyId(PropertyValuation propertyValuation) => propertyValuation.propertyId;

	DateTime? getPropertyValuationValuationDate(PropertyValuation propertyValuation) => propertyValuation.valuationDate;

	double? getPropertyValuationValue(PropertyValuation propertyValuation) => propertyValuation.value;

	String? getPropertyValuationSource(PropertyValuation propertyValuation) => propertyValuation.source;

	double? getPropertyValuationConfidence(PropertyValuation propertyValuation) => propertyValuation.confidence;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PropertyValuation> getByPropertyId(
    String propertyId,
    {ModelFilter<PropertyValuation>? modelFilter, List<PropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getPropertyValuationPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<PropertyValuation> getByValuationDate(
    DateTime valuationDate,
    {ModelFilter<PropertyValuation>? modelFilter, List<PropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getPropertyValuationValuationDate, valuationDate, modelFilter: modelFilter, includes: includes);

	
List<PropertyValuation> getByValue(
    double value,
    {ModelFilter<PropertyValuation>? modelFilter, List<PropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getPropertyValuationValue, value, modelFilter: modelFilter, includes: includes);

	
List<PropertyValuation> getBySource(
    String source,
    {ModelFilter<PropertyValuation>? modelFilter, List<PropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getPropertyValuationSource, source, modelFilter: modelFilter, includes: includes);

	
List<PropertyValuation> getByConfidence(
    double confidence,
    {ModelFilter<PropertyValuation>? modelFilter, List<PropertyValuationInclude>? includes}
    ) =>
    getManyIncluding(getPropertyValuationConfidence, confidence, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Property? getProperty(
    PropertyValuation propertyValuation, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyValuation.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(propertyValuation.propertyId!, includes: includes);
        propertyValuation.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PropertyValuation>> getAll$({bool useCache = true, ModelFilter<PropertyValuation>? modelFilter, List<PropertyValuationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PropertyValuationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PropertyValuation?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PropertyValuation>? modelFilter,
        List<PropertyValuationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyValuationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PropertyValuationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PropertyValuation>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<PropertyValuation>? modelFilter,
        List<PropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyValuationPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PropertyValuationEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyValuation>> getByValuationDate$(
        DateTime valuationDate,
        {bool useCache = true,
        ModelFilter<PropertyValuation>? modelFilter,
        List<PropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyValuationValuationDate,
        value: valuationDate,
        modelFilter: modelFilter,
        endpoint: PropertyValuationEndpoints.getManyByValuationDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyValuation>> getByValue$(
        double value,
        {bool useCache = true,
        ModelFilter<PropertyValuation>? modelFilter,
        List<PropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyValuationValue,
        value: value,
        modelFilter: modelFilter,
        endpoint: PropertyValuationEndpoints.getManyByValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyValuation>> getBySource$(
        String source,
        {bool useCache = true,
        ModelFilter<PropertyValuation>? modelFilter,
        List<PropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyValuationSource,
        value: source,
        modelFilter: modelFilter,
        endpoint: PropertyValuationEndpoints.getManyBySource,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyValuation>> getByConfidence$(
        double confidence,
        {bool useCache = true,
        ModelFilter<PropertyValuation>? modelFilter,
        List<PropertyValuationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyValuationConfidence,
        value: confidence,
        modelFilter: modelFilter,
        endpoint: PropertyValuationEndpoints.getManyByConfidence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Property?> getProperty$(
    PropertyValuation propertyValuation, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyValuation.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            propertyValuation.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            propertyValuation.property = property;
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
PropertyValuation recursiveUpsert(PropertyValuation propertyValuation, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PropertyValuation'} 
        : const {};
    if (propertyValuation.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        propertyValuation.property = PropertyStore.instance.recursiveUpsert(propertyValuation.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(propertyValuation);
}

  List<PropertyValuation> recursiveListUpsert(List<PropertyValuation> propertyValuations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPropertyValuations = <PropertyValuation>[];
    for (var propertyValuation in propertyValuations) {
        updatedPropertyValuations.add(recursiveUpsert(propertyValuation, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPropertyValuations;
}

//   @override
//   PropertyValuation upsert(PropertyValuation item) {
//     return recursiveUpsert(item);
//   }

}


class PropertyValuationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PropertyValuationInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyValuation) => PropertyValuationStore.instance
            .getProperty$(propertyValuation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyValuation) => PropertyValuationStore.instance
            .getProperty(propertyValuation, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PropertyValuationEndpoints implements Endpoint {

    getAll('/propertyValuation', HttpMethod.post, List<PropertyValuation>),
	getById('/propertyValuation/byId/:id', HttpMethod.post, PropertyValuation),
	getManyByPropertyId('/propertyValuation/byPropertyId/:propertyId', HttpMethod.post, List<PropertyValuation>),
	getManyByValuationDate('/propertyValuation/byValuationDate/:valuationDate', HttpMethod.post, List<PropertyValuation>),
	getManyByValue('/propertyValuation/byValue/:value', HttpMethod.post, List<PropertyValuation>),
	getManyBySource('/propertyValuation/bySource/:source', HttpMethod.post, List<PropertyValuation>),
	getManyByConfidence('/propertyValuation/byConfidence/:confidence', HttpMethod.post, List<PropertyValuation>);

    const PropertyValuationEndpoints(this.path, this.method, this.responseType);

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
