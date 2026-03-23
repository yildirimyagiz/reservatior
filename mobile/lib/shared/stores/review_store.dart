
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ReviewStore extends ModelStreamStore<String, Review> {

  static ReviewStore? _instance;

  static ReviewStore get instance {
    _instance ??= ReviewStore();
    return _instance!;
  }

  ReviewStore() : super(Review.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ReviewStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ReviewStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ReviewStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getReviewId(Review review) => review.id;

	String? getReviewOrgId(Review review) => review.orgId;

	String? getReviewReviewerId(Review review) => review.reviewerId;

	String? getReviewTargetId(Review review) => review.targetId;

	String? getReviewTargetType(Review review) => review.targetType;

	int? getReviewRating(Review review) => review.rating;

	String? getReviewTitle(Review review) => review.title;

	String? getReviewComment(Review review) => review.comment;

	bool? getReviewIsVerified(Review review) => review.isVerified;

	dynamic? getReviewResponses(Review review) => review.responses;

	DateTime? getReviewCreatedAt(Review review) => review.createdAt;

	DateTime? getReviewUpdatedAt(Review review) => review.updatedAt;

	DateTime? getReviewDeletedAt(Review review) => review.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Review> getByOrgId(
    String orgId,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Review> getByReviewerId(
    String reviewerId,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewReviewerId, reviewerId, modelFilter: modelFilter, includes: includes);

	
List<Review> getByTargetId(
    String targetId,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewTargetId, targetId, modelFilter: modelFilter, includes: includes);

	
List<Review> getByTargetType(
    String targetType,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewTargetType, targetType, modelFilter: modelFilter, includes: includes);

	
List<Review> getByRating(
    int rating,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewRating, rating, modelFilter: modelFilter, includes: includes);

	
List<Review> getByTitle(
    String title,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewTitle, title, modelFilter: modelFilter, includes: includes);

	
List<Review> getByComment(
    String comment,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewComment, comment, modelFilter: modelFilter, includes: includes);

	
List<Review> getByIsVerified(
    bool isVerified,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewIsVerified, isVerified, modelFilter: modelFilter, includes: includes);

	
List<Review> getByResponses(
    dynamic responses,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewResponses, responses, modelFilter: modelFilter, includes: includes);

	
List<Review> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Review> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Review> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}
    ) =>
    getManyIncluding(getReviewDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Review review, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (review.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(review.orgId!, includes: includes);
        review.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<Attachment> getAttachments(
    Review review, {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    final attachments = AttachmentStore.instance.getByReviewId(review.$uid!, modelFilter: modelFilter, includes: includes);
    review.attachments = attachments;
    // setIncludedReferencesForList(attachments, includes: includes);
    return attachments;
}

	List<Agent> getAgents(
    Review review, {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    final agents = AgentStore.instance.getBy(review.$uid!, modelFilter: modelFilter, includes: includes);
    review.agents = agents;
    // setIncludedReferencesForList(agents, includes: includes);
    return agents;
}

	List<Agency> getAgencies(
    Review review, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getBy(review.$uid!, modelFilter: modelFilter, includes: includes);
    review.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Review>> getAll$({bool useCache = true, ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ReviewEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Review?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getReviewId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Review>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReviewOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Review>> getByReviewerId$(
        String reviewerId,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReviewReviewerId,
        value: reviewerId,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByReviewerId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Review>> getByTargetId$(
        String targetId,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReviewTargetId,
        value: targetId,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByTargetId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Review>> getByTargetType$(
        String targetType,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReviewTargetType,
        value: targetType,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByTargetType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Review>> getByRating$(
        int rating,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getReviewRating,
        value: rating,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByRating,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Review>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReviewTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Review>> getByComment$(
        String comment,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReviewComment,
        value: comment,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByComment,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Review>> getByIsVerified$(
        bool isVerified,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getReviewIsVerified,
        value: isVerified,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByIsVerified,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Review>> getByResponses$(
        dynamic responses,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getReviewResponses,
        value: responses,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByResponses,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Review>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReviewCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Review>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReviewUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Review>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Review>? modelFilter,
        List<ReviewInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReviewDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ReviewEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Review review, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (review.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            review.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            review.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Attachment>> getAttachments$(
    Review review, {bool useCache = true, ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    return AttachmentStore.instance.getByReviewId$(
        review.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((attachments) {
        review.attachments = attachments;
    });

}

	Stream<List<Agent>> getAgents$(
    Review review, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    return AgentStore.instance.getBy$(
        review.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agents) {
        review.agents = agents;
    });

}

	Stream<List<Agency>> getAgencies$(
    Review review, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        review.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        review.agencies = agencies;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Review recursiveUpsert(Review review, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Review'} 
        : const {};
    if (review.attachments != null && (!preventCircularSerialization || !upsertedTypes.contains('Attachment'))) {
        review.attachments = AttachmentStore.instance.recursiveListUpsert(review.attachments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (review.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        review.org = OrganizationStore.instance.recursiveUpsert(review.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (review.agents != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        review.agents = AgentStore.instance.recursiveListUpsert(review.agents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (review.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        review.agencies = AgencyStore.instance.recursiveListUpsert(review.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(review);
}

  List<Review> recursiveListUpsert(List<Review> reviews, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedReviews = <Review>[];
    for (var review in reviews) {
        updatedReviews.add(recursiveUpsert(review, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedReviews;
}

//   @override
//   Review upsert(Review item) {
//     return recursiveUpsert(item);
//   }

}


class ReviewInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ReviewInclude.attachments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Attachment>? modelFilter,
    List<AttachmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (review) => ReviewStore.instance
            .getAttachments$(review, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (review) => ReviewStore.instance
            .getAttachments(review, modelFilter: modelFilter, includes: includes);
      }
}

	ReviewInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (review) => ReviewStore.instance
            .getOrg$(review, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (review) => ReviewStore.instance
            .getOrg(review, modelFilter: modelFilter, includes: includes);
      }
}

	ReviewInclude.agents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (review) => ReviewStore.instance
            .getAgents$(review, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (review) => ReviewStore.instance
            .getAgents(review, modelFilter: modelFilter, includes: includes);
      }
}

	ReviewInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (review) => ReviewStore.instance
            .getAgencies$(review, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (review) => ReviewStore.instance
            .getAgencies(review, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ReviewEndpoints implements Endpoint {

    getAll('/review', HttpMethod.post, List<Review>),
	getById('/review/byId/:id', HttpMethod.post, Review),
	getManyByOrgId('/review/byOrgId/:orgId', HttpMethod.post, List<Review>),
	getManyByReviewerId('/review/byReviewerId/:reviewerId', HttpMethod.post, List<Review>),
	getManyByTargetId('/review/byTargetId/:targetId', HttpMethod.post, List<Review>),
	getManyByTargetType('/review/byTargetType/:targetType', HttpMethod.post, List<Review>),
	getManyByRating('/review/byRating/:rating', HttpMethod.post, List<Review>),
	getManyByTitle('/review/byTitle/:title', HttpMethod.post, List<Review>),
	getManyByComment('/review/byComment/:comment', HttpMethod.post, List<Review>),
	getManyByIsVerified('/review/byIsVerified/:isVerified', HttpMethod.post, List<Review>),
	getManyByResponses('/review/byResponses/:responses', HttpMethod.post, List<Review>),
	getManyByCreatedAt('/review/byCreatedAt/:createdAt', HttpMethod.post, List<Review>),
	getManyByUpdatedAt('/review/byUpdatedAt/:updatedAt', HttpMethod.post, List<Review>),
	getManyByDeletedAt('/review/byDeletedAt/:deletedAt', HttpMethod.post, List<Review>);

    const ReviewEndpoints(this.path, this.method, this.responseType);

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
