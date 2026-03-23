
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AISentimentAnalysisStore extends ModelStreamStore<String, AISentimentAnalysis> {

  static AISentimentAnalysisStore? _instance;

  static AISentimentAnalysisStore get instance {
    _instance ??= AISentimentAnalysisStore();
    return _instance!;
  }

  AISentimentAnalysisStore() : super(AISentimentAnalysis.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AISentimentAnalysisStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AISentimentAnalysisStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AISentimentAnalysisStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAISentimentAnalysisId(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.id;

	String? getAISentimentAnalysisOrgId(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.orgId;

	String? getAISentimentAnalysisContentType(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.contentType;

	String? getAISentimentAnalysisContentId(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.contentId;

	String? getAISentimentAnalysisContentText(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.contentText;

	String? getAISentimentAnalysisSentiment(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.sentiment;

	double? getAISentimentAnalysisSentimentScore(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.sentimentScore;

	double? getAISentimentAnalysisConfidence(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.confidence;

	dynamic? getAISentimentAnalysisKeyPhrases(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.keyPhrases;

	dynamic? getAISentimentAnalysisEmotions(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.emotions;

	DateTime? getAISentimentAnalysisAnalyzedAt(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.analyzedAt;

	DateTime? getAISentimentAnalysisCreatedAt(AISentimentAnalysis aISentimentAnalysis) => aISentimentAnalysis.createdAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<AISentimentAnalysis> getByOrgId(
    String orgId,
    {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAISentimentAnalysisOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<AISentimentAnalysis> getByContentType(
    String contentType,
    {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAISentimentAnalysisContentType, contentType, modelFilter: modelFilter, includes: includes);

	
List<AISentimentAnalysis> getByContentId(
    String contentId,
    {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAISentimentAnalysisContentId, contentId, modelFilter: modelFilter, includes: includes);

	
List<AISentimentAnalysis> getByContentText(
    String contentText,
    {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAISentimentAnalysisContentText, contentText, modelFilter: modelFilter, includes: includes);

	
List<AISentimentAnalysis> getBySentiment(
    String sentiment,
    {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAISentimentAnalysisSentiment, sentiment, modelFilter: modelFilter, includes: includes);

	
List<AISentimentAnalysis> getBySentimentScore(
    double sentimentScore,
    {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAISentimentAnalysisSentimentScore, sentimentScore, modelFilter: modelFilter, includes: includes);

	
List<AISentimentAnalysis> getByConfidence(
    double confidence,
    {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAISentimentAnalysisConfidence, confidence, modelFilter: modelFilter, includes: includes);

	
List<AISentimentAnalysis> getByKeyPhrases(
    dynamic keyPhrases,
    {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAISentimentAnalysisKeyPhrases, keyPhrases, modelFilter: modelFilter, includes: includes);

	
List<AISentimentAnalysis> getByEmotions(
    dynamic emotions,
    {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAISentimentAnalysisEmotions, emotions, modelFilter: modelFilter, includes: includes);

	
List<AISentimentAnalysis> getByAnalyzedAt(
    DateTime analyzedAt,
    {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAISentimentAnalysisAnalyzedAt, analyzedAt, modelFilter: modelFilter, includes: includes);

	
List<AISentimentAnalysis> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}
    ) =>
    getManyIncluding(getAISentimentAnalysisCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    AISentimentAnalysis aISentimentAnalysis, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (aISentimentAnalysis.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(aISentimentAnalysis.orgId!, includes: includes);
        aISentimentAnalysis.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<AISentimentAnalysis>> getAll$({bool useCache = true, ModelFilter<AISentimentAnalysis>? modelFilter, List<AISentimentAnalysisInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AISentimentAnalysisEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<AISentimentAnalysis?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAISentimentAnalysisId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<AISentimentAnalysis>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAISentimentAnalysisOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AISentimentAnalysis>> getByContentType$(
        String contentType,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAISentimentAnalysisContentType,
        value: contentType,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getManyByContentType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AISentimentAnalysis>> getByContentId$(
        String contentId,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAISentimentAnalysisContentId,
        value: contentId,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getManyByContentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AISentimentAnalysis>> getByContentText$(
        String contentText,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAISentimentAnalysisContentText,
        value: contentText,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getManyByContentText,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AISentimentAnalysis>> getBySentiment$(
        String sentiment,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAISentimentAnalysisSentiment,
        value: sentiment,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getManyBySentiment,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AISentimentAnalysis>> getBySentimentScore$(
        double sentimentScore,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAISentimentAnalysisSentimentScore,
        value: sentimentScore,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getManyBySentimentScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AISentimentAnalysis>> getByConfidence$(
        double confidence,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getAISentimentAnalysisConfidence,
        value: confidence,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getManyByConfidence,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AISentimentAnalysis>> getByKeyPhrases$(
        dynamic keyPhrases,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAISentimentAnalysisKeyPhrases,
        value: keyPhrases,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getManyByKeyPhrases,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AISentimentAnalysis>> getByEmotions$(
        dynamic emotions,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getAISentimentAnalysisEmotions,
        value: emotions,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getManyByEmotions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AISentimentAnalysis>> getByAnalyzedAt$(
        DateTime analyzedAt,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAISentimentAnalysisAnalyzedAt,
        value: analyzedAt,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getManyByAnalyzedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<AISentimentAnalysis>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<AISentimentAnalysis>? modelFilter,
        List<AISentimentAnalysisInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAISentimentAnalysisCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AISentimentAnalysisEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    AISentimentAnalysis aISentimentAnalysis, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (aISentimentAnalysis.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            aISentimentAnalysis.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            aISentimentAnalysis.org = org;
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
AISentimentAnalysis recursiveUpsert(AISentimentAnalysis aISentimentAnalysis, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'AISentimentAnalysis'} 
        : const {};
    if (aISentimentAnalysis.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        aISentimentAnalysis.org = OrganizationStore.instance.recursiveUpsert(aISentimentAnalysis.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(aISentimentAnalysis);
}

  List<AISentimentAnalysis> recursiveListUpsert(List<AISentimentAnalysis> aISentimentAnalysiss, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAISentimentAnalysiss = <AISentimentAnalysis>[];
    for (var aISentimentAnalysis in aISentimentAnalysiss) {
        updatedAISentimentAnalysiss.add(recursiveUpsert(aISentimentAnalysis, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAISentimentAnalysiss;
}

//   @override
//   AISentimentAnalysis upsert(AISentimentAnalysis item) {
//     return recursiveUpsert(item);
//   }

}


class AISentimentAnalysisInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AISentimentAnalysisInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (aISentimentAnalysis) => AISentimentAnalysisStore.instance
            .getOrg$(aISentimentAnalysis, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (aISentimentAnalysis) => AISentimentAnalysisStore.instance
            .getOrg(aISentimentAnalysis, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AISentimentAnalysisEndpoints implements Endpoint {

    getAll('/aISentimentAnalysis', HttpMethod.post, List<AISentimentAnalysis>),
	getById('/aISentimentAnalysis/byId/:id', HttpMethod.post, AISentimentAnalysis),
	getManyByOrgId('/aISentimentAnalysis/byOrgId/:orgId', HttpMethod.post, List<AISentimentAnalysis>),
	getManyByContentType('/aISentimentAnalysis/byContentType/:contentType', HttpMethod.post, List<AISentimentAnalysis>),
	getManyByContentId('/aISentimentAnalysis/byContentId/:contentId', HttpMethod.post, List<AISentimentAnalysis>),
	getManyByContentText('/aISentimentAnalysis/byContentText/:contentText', HttpMethod.post, List<AISentimentAnalysis>),
	getManyBySentiment('/aISentimentAnalysis/bySentiment/:sentiment', HttpMethod.post, List<AISentimentAnalysis>),
	getManyBySentimentScore('/aISentimentAnalysis/bySentimentScore/:sentimentScore', HttpMethod.post, List<AISentimentAnalysis>),
	getManyByConfidence('/aISentimentAnalysis/byConfidence/:confidence', HttpMethod.post, List<AISentimentAnalysis>),
	getManyByKeyPhrases('/aISentimentAnalysis/byKeyPhrases/:keyPhrases', HttpMethod.post, List<AISentimentAnalysis>),
	getManyByEmotions('/aISentimentAnalysis/byEmotions/:emotions', HttpMethod.post, List<AISentimentAnalysis>),
	getManyByAnalyzedAt('/aISentimentAnalysis/byAnalyzedAt/:analyzedAt', HttpMethod.post, List<AISentimentAnalysis>),
	getManyByCreatedAt('/aISentimentAnalysis/byCreatedAt/:createdAt', HttpMethod.post, List<AISentimentAnalysis>);

    const AISentimentAnalysisEndpoints(this.path, this.method, this.responseType);

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
