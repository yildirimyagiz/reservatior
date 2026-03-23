
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AIImageAnalysisStore extends ModelStreamStore<String, AIImageAnalysis> {

  static AIImageAnalysisStore? _instance;

  static AIImageAnalysisStore get instance {
    _instance ??= AIImageAnalysisStore();
    return _instance!;
  }

  AIImageAnalysisStore() : super(AIImageAnalysis.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AIImageAnalysisStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AIImageAnalysisStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AIImageAnalysisStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAIImageAnalysisId(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.id;

	String? getAIImageAnalysisOrgId(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.orgId;

	String? getAIImageAnalysisPropertyId(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.propertyId;

	String? getAIImageAnalysisPhotoId(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.photoId;

	String? getAIImageAnalysisAnalysisType(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.analysisType;

	dynamic? getAIImageAnalysisDetectedRooms(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.detectedRooms;

	double? getAIImageAnalysisQualityScore(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.qualityScore;

	dynamic? getAIImageAnalysisStyleTags(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.styleTags;

	dynamic? getAIImageAnalysisColorPalette(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.colorPalette;

	double? getAIImageAnalysisLightingQuality(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.lightingQuality;

	dynamic? getAIImageAnalysisRecommendations(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.recommendations;

	DateTime? getAIImageAnalysisAnalyzedAt(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.analyzedAt;

	double? getAIImageAnalysisConfidence(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.confidence;

	DateTime? getAIImageAnalysisCreatedAt(AIImageAnalysis aIImageAnalysis) => aIImageAnalysis.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AIImageAnalysis> getByOrgId(
    String orgId,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByPropertyId(
    String propertyId,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByPhotoId(
    String photoId,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisPhotoId, photoId, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByAnalysisType(
    String analysisType,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisAnalysisType, analysisType, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByDetectedRooms(
    dynamic detectedRooms,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisDetectedRooms, detectedRooms, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByQualityScore(
    double qualityScore,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisQualityScore, qualityScore, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByStyleTags(
    dynamic styleTags,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisStyleTags, styleTags, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByColorPalette(
    dynamic colorPalette,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisColorPalette, colorPalette, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByLightingQuality(
    double lightingQuality,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisLightingQuality, lightingQuality, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByRecommendations(
    dynamic recommendations,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisRecommendations, recommendations, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByAnalyzedAt(
    DateTime analyzedAt,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisAnalyzedAt, analyzedAt, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByConfidence(
    double confidence,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisConfidence, confidence, modelFilter: modelFilter, includes: includes);

	
List<AIImageAnalysis> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAIImageAnalysisCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AIImageAnalysis aIImageAnalysis, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIImageAnalysis.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aIImageAnalysis.orgId!, includes: includes);
        aIImageAnalysis.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	PropertyPhoto? getPhoto(
    AIImageAnalysis aIImageAnalysis, {ModelFilter? modelFilter, List<PropertyPhotoInclude>? includes}) {
    if (aIImageAnalysis.photoId == null) {
        return null;
    } else {
        final photo = PropertyPhotoStore.instance.getById(aIImageAnalysis.photoId!, includes: includes);
        aIImageAnalysis.photo = photo;
        // setIncludedReferences(photo, includes: includes);
        return photo;
    }
}

	Property? getProperty(
    AIImageAnalysis aIImageAnalysis, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (aIImageAnalysis.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(aIImageAnalysis.propertyId!, includes: includes);
        aIImageAnalysis.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AIImageAnalysis>> getAll$({bool useCache = true, ModelFilter<AIImageAnalysis>? modelFilter, List<AIImageAnalysisInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AIImageAnalysisEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AIImageAnalysis?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAIImageAnalysisId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AIImageAnalysis>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIImageAnalysisOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIImageAnalysisPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByPhotoId$(
        String photoId,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIImageAnalysisPhotoId,
        value: photoId,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByPhotoId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByAnalysisType$(
        String analysisType,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAIImageAnalysisAnalysisType,
        value: analysisType,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByAnalysisType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByDetectedRooms$(
        dynamic detectedRooms,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIImageAnalysisDetectedRooms,
        value: detectedRooms,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByDetectedRooms,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByQualityScore$(
        double qualityScore,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIImageAnalysisQualityScore,
        value: qualityScore,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByQualityScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByStyleTags$(
        dynamic styleTags,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIImageAnalysisStyleTags,
        value: styleTags,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByStyleTags,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByColorPalette$(
        dynamic colorPalette,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIImageAnalysisColorPalette,
        value: colorPalette,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByColorPalette,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByLightingQuality$(
        double lightingQuality,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIImageAnalysisLightingQuality,
        value: lightingQuality,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByLightingQuality,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByRecommendations$(
        dynamic recommendations,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAIImageAnalysisRecommendations,
        value: recommendations,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByRecommendations,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByAnalyzedAt$(
        DateTime analyzedAt,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIImageAnalysisAnalyzedAt,
        value: analyzedAt,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByAnalyzedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByConfidence$(
        double confidence,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAIImageAnalysisConfidence,
        value: confidence,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByConfidence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AIImageAnalysis>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AIImageAnalysis>? modelFilter,
        List<AIImageAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAIImageAnalysisCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AIImageAnalysisEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AIImageAnalysis aIImageAnalysis, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aIImageAnalysis.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aIImageAnalysis.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aIImageAnalysis.org = org;
        });
    }
}

	Stream<PropertyPhoto?> getPhoto$(
    AIImageAnalysis aIImageAnalysis, {bool useCache = true, ModelFilter<PropertyPhoto>? modelFilter, List<PropertyPhotoInclude>? includes}) {
    if (aIImageAnalysis.photoId == null) {
        return Stream.value(null);
    } else {
        return PropertyPhotoStore.instance.getById$(
            aIImageAnalysis.photoId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((photo) {
            aIImageAnalysis.photo = photo;
        });
    }
}

	Stream<Property?> getProperty$(
    AIImageAnalysis aIImageAnalysis, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (aIImageAnalysis.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            aIImageAnalysis.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            aIImageAnalysis.property = property;
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
AIImageAnalysis recursiveUpsert(AIImageAnalysis aIImageAnalysis, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AIImageAnalysis'} 
        : const {};
    if (aIImageAnalysis.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aIImageAnalysis.org = OrganizationStore.instance.recursiveUpsert(aIImageAnalysis.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIImageAnalysis.photo != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyPhoto'))) {
        aIImageAnalysis.photo = PropertyPhotoStore.instance.recursiveUpsert(aIImageAnalysis.photo!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (aIImageAnalysis.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        aIImageAnalysis.property = PropertyStore.instance.recursiveUpsert(aIImageAnalysis.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aIImageAnalysis);
}

  List<AIImageAnalysis> recursiveListUpsert(List<AIImageAnalysis> aIImageAnalysiss, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAIImageAnalysiss = <AIImageAnalysis>[];
    for (var aIImageAnalysis in aIImageAnalysiss) {
        updatedAIImageAnalysiss.add(recursiveUpsert(aIImageAnalysis, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAIImageAnalysiss;
}

//   @override
//   AIImageAnalysis upsert(AIImageAnalysis item) {
//     return recursiveUpsert(item);
//   }

}


class AIImageAnalysisInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AIImageAnalysisInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIImageAnalysis) => AIImageAnalysisStore.instance
            .getOrg$(aIImageAnalysis, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIImageAnalysis) => AIImageAnalysisStore.instance
            .getOrg(aIImageAnalysis, modelFilter: modelFilter, includes: includes);
      }
}

	AIImageAnalysisInclude.photo({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyPhoto>? modelFilter,
    List<PropertyPhotoInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIImageAnalysis) => AIImageAnalysisStore.instance
            .getPhoto$(aIImageAnalysis, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIImageAnalysis) => AIImageAnalysisStore.instance
            .getPhoto(aIImageAnalysis, modelFilter: modelFilter, includes: includes);
      }
}

	AIImageAnalysisInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aIImageAnalysis) => AIImageAnalysisStore.instance
            .getProperty$(aIImageAnalysis, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aIImageAnalysis) => AIImageAnalysisStore.instance
            .getProperty(aIImageAnalysis, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AIImageAnalysisEndpoints implements Endpoint {

    getAll('/aIImageAnalysis', HttpMethod.post, List<AIImageAnalysis>),
	getById('/aIImageAnalysis/byId/:id', HttpMethod.post, AIImageAnalysis),
	getManyByOrgId('/aIImageAnalysis/byOrgId/:orgId', HttpMethod.post, List<AIImageAnalysis>),
	getManyByPropertyId('/aIImageAnalysis/byPropertyId/:propertyId', HttpMethod.post, List<AIImageAnalysis>),
	getManyByPhotoId('/aIImageAnalysis/byPhotoId/:photoId', HttpMethod.post, List<AIImageAnalysis>),
	getManyByAnalysisType('/aIImageAnalysis/byAnalysisType/:analysisType', HttpMethod.post, List<AIImageAnalysis>),
	getManyByDetectedRooms('/aIImageAnalysis/byDetectedRooms/:detectedRooms', HttpMethod.post, List<AIImageAnalysis>),
	getManyByQualityScore('/aIImageAnalysis/byQualityScore/:qualityScore', HttpMethod.post, List<AIImageAnalysis>),
	getManyByStyleTags('/aIImageAnalysis/byStyleTags/:styleTags', HttpMethod.post, List<AIImageAnalysis>),
	getManyByColorPalette('/aIImageAnalysis/byColorPalette/:colorPalette', HttpMethod.post, List<AIImageAnalysis>),
	getManyByLightingQuality('/aIImageAnalysis/byLightingQuality/:lightingQuality', HttpMethod.post, List<AIImageAnalysis>),
	getManyByRecommendations('/aIImageAnalysis/byRecommendations/:recommendations', HttpMethod.post, List<AIImageAnalysis>),
	getManyByAnalyzedAt('/aIImageAnalysis/byAnalyzedAt/:analyzedAt', HttpMethod.post, List<AIImageAnalysis>),
	getManyByConfidence('/aIImageAnalysis/byConfidence/:confidence', HttpMethod.post, List<AIImageAnalysis>),
	getManyByCreatedAt('/aIImageAnalysis/byCreatedAt/:createdAt', HttpMethod.post, List<AIImageAnalysis>);

    const AIImageAnalysisEndpoints(this.path, this.method, this.responseType);

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
