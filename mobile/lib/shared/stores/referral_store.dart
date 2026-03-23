
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ReferralStore extends ModelStreamStore<String, Referral> {

  static ReferralStore? _instance;

  static ReferralStore get instance {
    _instance ??= ReferralStore();
    return _instance!;
  }

  ReferralStore() : super(Referral.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ReferralStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ReferralStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ReferralStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getReferralId(Referral referral) => referral.id;

	String? getReferralUserId(Referral referral) => referral.userId;

	String? getReferralCode(Referral referral) => referral.code;

	double? getReferralCommissionRate(Referral referral) => referral.commissionRate;

	int? getReferralBonusPoints(Referral referral) => referral.bonusPoints;

	DateTime? getReferralExpiresAt(Referral referral) => referral.expiresAt;

	int? getReferralTotalReferrals(Referral referral) => referral.totalReferrals;

	int? getReferralSuccessfulReferrals(Referral referral) => referral.successfulReferrals;

	double? getReferralTotalEarnings(Referral referral) => referral.totalEarnings;

	dynamic? getReferralTrackingHistory(Referral referral) => referral.trackingHistory;

	DateTime? getReferralCreatedAt(Referral referral) => referral.createdAt;

	DateTime? getReferralUpdatedAt(Referral referral) => referral.updatedAt;

	String? getReferralOrganizationId(Referral referral) => referral.organizationId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Referral? getByCode(
    String code,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getIncluding(getReferralCode, code, modelFilter: modelFilter, includes: includes);

  
List<Referral> getByUserId(
    String userId,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getManyIncluding(getReferralUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Referral> getByCommissionRate(
    double commissionRate,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getManyIncluding(getReferralCommissionRate, commissionRate, modelFilter: modelFilter, includes: includes);

	
List<Referral> getByBonusPoints(
    int bonusPoints,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getManyIncluding(getReferralBonusPoints, bonusPoints, modelFilter: modelFilter, includes: includes);

	
List<Referral> getByExpiresAt(
    DateTime expiresAt,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getManyIncluding(getReferralExpiresAt, expiresAt, modelFilter: modelFilter, includes: includes);

	
List<Referral> getByTotalReferrals(
    int totalReferrals,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getManyIncluding(getReferralTotalReferrals, totalReferrals, modelFilter: modelFilter, includes: includes);

	
List<Referral> getBySuccessfulReferrals(
    int successfulReferrals,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getManyIncluding(getReferralSuccessfulReferrals, successfulReferrals, modelFilter: modelFilter, includes: includes);

	
List<Referral> getByTotalEarnings(
    double totalEarnings,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getManyIncluding(getReferralTotalEarnings, totalEarnings, modelFilter: modelFilter, includes: includes);

	
List<Referral> getByTrackingHistory(
    dynamic trackingHistory,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getManyIncluding(getReferralTrackingHistory, trackingHistory, modelFilter: modelFilter, includes: includes);

	
List<Referral> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getManyIncluding(getReferralCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Referral> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getManyIncluding(getReferralUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Referral> getByOrganizationId(
    String organizationId,
    {ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}
    ) =>
    getManyIncluding(getReferralOrganizationId, organizationId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrganization(
    Referral referral, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (referral.organizationId == null) {
        return null;
    } else {
        final organization = OrganizationStore.instance.getById(referral.organizationId!, includes: includes);
        referral.organization = organization;
        // setIncludedReferences(organization, includes: includes);
        return organization;
    }
}

	User? getUser(
    Referral referral, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (referral.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(referral.userId!, includes: includes);
        referral.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Referral>> getAll$({bool useCache = true, ModelFilter<Referral>? modelFilter, List<ReferralInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ReferralEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Referral?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getReferralId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Referral?> getByCode$(
        String code,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getReferralCode,
        value: code,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getByCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Referral>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReferralUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Referral>> getByCommissionRate$(
        double commissionRate,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getReferralCommissionRate,
        value: commissionRate,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getManyByCommissionRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Referral>> getByBonusPoints$(
        int bonusPoints,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getReferralBonusPoints,
        value: bonusPoints,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getManyByBonusPoints,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Referral>> getByExpiresAt$(
        DateTime expiresAt,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReferralExpiresAt,
        value: expiresAt,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getManyByExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Referral>> getByTotalReferrals$(
        int totalReferrals,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getReferralTotalReferrals,
        value: totalReferrals,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getManyByTotalReferrals,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Referral>> getBySuccessfulReferrals$(
        int successfulReferrals,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getReferralSuccessfulReferrals,
        value: successfulReferrals,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getManyBySuccessfulReferrals,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Referral>> getByTotalEarnings$(
        double totalEarnings,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getReferralTotalEarnings,
        value: totalEarnings,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getManyByTotalEarnings,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Referral>> getByTrackingHistory$(
        dynamic trackingHistory,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getReferralTrackingHistory,
        value: trackingHistory,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getManyByTrackingHistory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Referral>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReferralCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Referral>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getReferralUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Referral>> getByOrganizationId$(
        String organizationId,
        {bool useCache = true,
        ModelFilter<Referral>? modelFilter,
        List<ReferralInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getReferralOrganizationId,
        value: organizationId,
        modelFilter: modelFilter,
        endpoint: ReferralEndpoints.getManyByOrganizationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrganization$(
    Referral referral, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (referral.organizationId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            referral.organizationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((organization) {
            referral.organization = organization;
        });
    }
}

	Stream<User?> getUser$(
    Referral referral, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (referral.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            referral.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            referral.user = user;
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
Referral recursiveUpsert(Referral referral, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Referral'} 
        : const {};
    if (referral.organization != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        referral.organization = OrganizationStore.instance.recursiveUpsert(referral.organization!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (referral.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        referral.user = UserStore.instance.recursiveUpsert(referral.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(referral);
}

  List<Referral> recursiveListUpsert(List<Referral> referrals, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedReferrals = <Referral>[];
    for (var referral in referrals) {
        updatedReferrals.add(recursiveUpsert(referral, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedReferrals;
}

//   @override
//   Referral upsert(Referral item) {
//     return recursiveUpsert(item);
//   }

}


class ReferralInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ReferralInclude.organization({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (referral) => ReferralStore.instance
            .getOrganization$(referral, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (referral) => ReferralStore.instance
            .getOrganization(referral, modelFilter: modelFilter, includes: includes);
      }
}

	ReferralInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (referral) => ReferralStore.instance
            .getUser$(referral, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (referral) => ReferralStore.instance
            .getUser(referral, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ReferralEndpoints implements Endpoint {

    getAll('/referral', HttpMethod.post, List<Referral>),
	getById('/referral/byId/:id', HttpMethod.post, Referral),
	getManyByUserId('/referral/byUserId/:userId', HttpMethod.post, List<Referral>),
	getByCode('/referral/byCode/:code', HttpMethod.post, Referral),
	getManyByCommissionRate('/referral/byCommissionRate/:commissionRate', HttpMethod.post, List<Referral>),
	getManyByBonusPoints('/referral/byBonusPoints/:bonusPoints', HttpMethod.post, List<Referral>),
	getManyByExpiresAt('/referral/byExpiresAt/:expiresAt', HttpMethod.post, List<Referral>),
	getManyByTotalReferrals('/referral/byTotalReferrals/:totalReferrals', HttpMethod.post, List<Referral>),
	getManyBySuccessfulReferrals('/referral/bySuccessfulReferrals/:successfulReferrals', HttpMethod.post, List<Referral>),
	getManyByTotalEarnings('/referral/byTotalEarnings/:totalEarnings', HttpMethod.post, List<Referral>),
	getManyByTrackingHistory('/referral/byTrackingHistory/:trackingHistory', HttpMethod.post, List<Referral>),
	getManyByCreatedAt('/referral/byCreatedAt/:createdAt', HttpMethod.post, List<Referral>),
	getManyByUpdatedAt('/referral/byUpdatedAt/:updatedAt', HttpMethod.post, List<Referral>),
	getManyByOrganizationId('/referral/byOrganizationId/:organizationId', HttpMethod.post, List<Referral>);

    const ReferralEndpoints(this.path, this.method, this.responseType);

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
