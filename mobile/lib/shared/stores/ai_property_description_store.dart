
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIPropertyDescriptionStore extends ModelStreamStore<String, AIPropertyDescription> {

  static AIPropertyDescriptionStore? _instance;

  static AIPropertyDescriptionStore get instance {
    _instance ??= AIPropertyDescriptionStore();
    return _instance!;
  }

  AIPropertyDescriptionStore() : super(AIPropertyDescription.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIPropertyDescriptionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIPropertyDescriptionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIPropertyDescriptionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIPropertyDescriptionId(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.id;

	String? getAIPropertyDescriptionOrgId(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.orgId;

	String? getAIPropertyDescriptionPropertyId(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.propertyId;

	String? getAIPropertyDescriptionGeneratedDescription(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.generatedDescription;

	String? getAIPropertyDescriptionOriginalDescription(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.originalDescription;

	String? getAIPropertyDescriptionTone(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.tone;

	String? getAIPropertyDescriptionTargetAudience(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.targetAudience;

	dynamic? getAIPropertyDescriptionKeyFeatures(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.keyFeatures;

	dynamic? getAIPropertyDescriptionSeoKeywords(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.seoKeywords;

	double? getAIPropertyDescriptionQualityScore(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.qualityScore;

	DateTime? getAIPropertyDescriptionGeneratedAt(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.generatedAt;

	bool? getAIPropertyDescriptionIsApproved(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.isApproved;

	String? getAIPropertyDescriptionApprovedBy(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.approvedBy;

	DateTime? getAIPropertyDescriptionApprovedAt(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.approvedAt;

	DateTime? getAIPropertyDescriptionCreatedAt(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.createdAt;

	DateTime? getAIPropertyDescriptionUpdatedAt(AIPropertyDescription aIPropertyDescription) => aIPropertyDescription.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIPropertyDescription> getByOrgId(
    String orgId,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByPropertyId(
    String propertyId,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByGeneratedDescription(
    String generatedDescription,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionGeneratedDescription, generatedDescription, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByOriginalDescription(
    String originalDescription,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionOriginalDescription, originalDescription, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByTone(
    String tone,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionTone, tone, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByTargetAudience(
    String targetAudience,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionTargetAudience, targetAudience, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByKeyFeatures(
    dynamic keyFeatures,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionKeyFeatures, keyFeatures, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getBySeoKeywords(
    dynamic seoKeywords,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionSeoKeywords, seoKeywords, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByQualityScore(
    double qualityScore,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionQualityScore, qualityScore, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByGeneratedAt(
    DateTime generatedAt,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionGeneratedAt, generatedAt, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByIsApproved(
    bool isApproved,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionIsApproved, isApproved, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByApprovedBy(
    String approvedBy,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionApprovedBy, approvedBy, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByApprovedAt(
    DateTime approvedAt,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionApprovedAt, approvedAt, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<AIPropertyDescription> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}
    ) =>
    getManyIncluding(getAIPropertyDescriptionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AIPropertyDescription aIPropertyDescription, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIPropertyDescription.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIPropertyDescription.orgId!, includes: includes);
        aIPropertyDescription.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    AIPropertyDescription aIPropertyDescription, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (aIPropertyDescription.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(aIPropertyDescription.propertyId!, includes: includes);
        aIPropertyDescription.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIPropertyDescription>> getAll$({bool useCache = true, ModelFilter<AIPropertyDescription>? modelFilter, List<AIPropertyDescriptionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIPropertyDescriptionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIPropertyDescription?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIPropertyDescriptionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIPropertyDescription>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPropertyDescriptionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPropertyDescriptionPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByGeneratedDescription$(
        String generatedDescription,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPropertyDescriptionGeneratedDescription,
        value: generatedDescription,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByGeneratedDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByOriginalDescription$(
        String originalDescription,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPropertyDescriptionOriginalDescription,
        value: originalDescription,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByOriginalDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByTone$(
        String tone,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPropertyDescriptionTone,
        value: tone,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByTone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByTargetAudience$(
        String targetAudience,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPropertyDescriptionTargetAudience,
        value: targetAudience,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByTargetAudience,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByKeyFeatures$(
        dynamic keyFeatures,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPropertyDescriptionKeyFeatures,
        value: keyFeatures,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByKeyFeatures,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getBySeoKeywords$(
        dynamic seoKeywords,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIPropertyDescriptionSeoKeywords,
        value: seoKeywords,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyBySeoKeywords,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByQualityScore$(
        double qualityScore,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIPropertyDescriptionQualityScore,
        value: qualityScore,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByQualityScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByGeneratedAt$(
        DateTime generatedAt,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPropertyDescriptionGeneratedAt,
        value: generatedAt,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByGeneratedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByIsApproved$(
        bool isApproved,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAIPropertyDescriptionIsApproved,
        value: isApproved,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByIsApproved,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByApprovedBy$(
        String approvedBy,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIPropertyDescriptionApprovedBy,
        value: approvedBy,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByApprovedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByApprovedAt$(
        DateTime approvedAt,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPropertyDescriptionApprovedAt,
        value: approvedAt,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByApprovedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPropertyDescriptionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIPropertyDescription>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<AIPropertyDescription>? modelFilter,
        List<AIPropertyDescriptionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIPropertyDescriptionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AIPropertyDescriptionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AIPropertyDescription aIPropertyDescription, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIPropertyDescription.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIPropertyDescription.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIPropertyDescription.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    AIPropertyDescription aIPropertyDescription, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (aIPropertyDescription.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            aIPropertyDescription.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            aIPropertyDescription.property = property;
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
AIPropertyDescription recursiveUpsert(AIPropertyDescription aIPropertyDescription, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIPropertyDescription'} 
        : const {};
    if (aIPropertyDescription.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIPropertyDescription.org = OrganizationStore.instance.recursiveUpsert(aIPropertyDescription.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIPropertyDescription.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        aIPropertyDescription.property = PropertyStore.instance.recursiveUpsert(aIPropertyDescription.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIPropertyDescription);
}

  List<AIPropertyDescription> recursiveListUpsert(List<AIPropertyDescription> aIPropertyDescriptions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIPropertyDescriptions = <AIPropertyDescription>[];
    for (var aIPropertyDescription in aIPropertyDescriptions) {
        updatedAIPropertyDescriptions.add(recursiveUpsert(aIPropertyDescription, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIPropertyDescriptions;
}

//   @override
//   AIPropertyDescription upsert(AIPropertyDescription item) {
//     return recursiveUpsert(item);
//   }

}


class AIPropertyDescriptionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIPropertyDescriptionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIPropertyDescription) => AIPropertyDescriptionStore.instance
            .getOrg$(aIPropertyDescription, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIPropertyDescription) => AIPropertyDescriptionStore.instance
            .getOrg(aIPropertyDescription, modelFilter: modelFilter, includes: includes);
      }
}

	AIPropertyDescriptionInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIPropertyDescription) => AIPropertyDescriptionStore.instance
            .getProperty$(aIPropertyDescription, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIPropertyDescription) => AIPropertyDescriptionStore.instance
            .getProperty(aIPropertyDescription, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIPropertyDescriptionEndpoints implements Endpoint {

    getAll('/aIPropertyDescription', HttpMethod.post, List<AIPropertyDescription>),
	getById('/aIPropertyDescription/byId/:id', HttpMethod.post, AIPropertyDescription),
	getManyByOrgId('/aIPropertyDescription/byOrgId/:orgId', HttpMethod.post, List<AIPropertyDescription>),
	getManyByPropertyId('/aIPropertyDescription/byPropertyId/:propertyId', HttpMethod.post, List<AIPropertyDescription>),
	getManyByGeneratedDescription('/aIPropertyDescription/byGeneratedDescription/:generatedDescription', HttpMethod.post, List<AIPropertyDescription>),
	getManyByOriginalDescription('/aIPropertyDescription/byOriginalDescription/:originalDescription', HttpMethod.post, List<AIPropertyDescription>),
	getManyByTone('/aIPropertyDescription/byTone/:tone', HttpMethod.post, List<AIPropertyDescription>),
	getManyByTargetAudience('/aIPropertyDescription/byTargetAudience/:targetAudience', HttpMethod.post, List<AIPropertyDescription>),
	getManyByKeyFeatures('/aIPropertyDescription/byKeyFeatures/:keyFeatures', HttpMethod.post, List<AIPropertyDescription>),
	getManyBySeoKeywords('/aIPropertyDescription/bySeoKeywords/:seoKeywords', HttpMethod.post, List<AIPropertyDescription>),
	getManyByQualityScore('/aIPropertyDescription/byQualityScore/:qualityScore', HttpMethod.post, List<AIPropertyDescription>),
	getManyByGeneratedAt('/aIPropertyDescription/byGeneratedAt/:generatedAt', HttpMethod.post, List<AIPropertyDescription>),
	getManyByIsApproved('/aIPropertyDescription/byIsApproved/:isApproved', HttpMethod.post, List<AIPropertyDescription>),
	getManyByApprovedBy('/aIPropertyDescription/byApprovedBy/:approvedBy', HttpMethod.post, List<AIPropertyDescription>),
	getManyByApprovedAt('/aIPropertyDescription/byApprovedAt/:approvedAt', HttpMethod.post, List<AIPropertyDescription>),
	getManyByCreatedAt('/aIPropertyDescription/byCreatedAt/:createdAt', HttpMethod.post, List<AIPropertyDescription>),
	getManyByUpdatedAt('/aIPropertyDescription/byUpdatedAt/:updatedAt', HttpMethod.post, List<AIPropertyDescription>);

    const AIPropertyDescriptionEndpoints(this.path, this.method, this.responseType);

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
