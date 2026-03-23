
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class LoyaltyAccountStore extends ModelStreamStore<String, LoyaltyAccount> {

  static LoyaltyAccountStore? _instance;

  static LoyaltyAccountStore get instance {
    _instance ??= LoyaltyAccountStore();
    return _instance!;
  }

  LoyaltyAccountStore() : super(LoyaltyAccount.fromJson) {
    if (_instance != null) {
        throw Exception(
            'LoyaltyAccountStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending LoyaltyAccountStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use LoyaltyAccountStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getLoyaltyAccountId(LoyaltyAccount loyaltyAccount) => loyaltyAccount.id;

	String? getLoyaltyAccountOrgId(LoyaltyAccount loyaltyAccount) => loyaltyAccount.orgId;

	String? getLoyaltyAccountUserId(LoyaltyAccount loyaltyAccount) => loyaltyAccount.userId;

	String? getLoyaltyAccountName(LoyaltyAccount loyaltyAccount) => loyaltyAccount.name;

	String? getLoyaltyAccountDescription(LoyaltyAccount loyaltyAccount) => loyaltyAccount.description;

	double? getLoyaltyAccountPointsPerDollar(LoyaltyAccount loyaltyAccount) => loyaltyAccount.pointsPerDollar;

	int? getLoyaltyAccountPointsExpiryDays(LoyaltyAccount loyaltyAccount) => loyaltyAccount.pointsExpiryDays;

	bool? getLoyaltyAccountTiersEnabled(LoyaltyAccount loyaltyAccount) => loyaltyAccount.tiersEnabled;

	int? getLoyaltyAccountBronzeThreshold(LoyaltyAccount loyaltyAccount) => loyaltyAccount.bronzeThreshold;

	int? getLoyaltyAccountSilverThreshold(LoyaltyAccount loyaltyAccount) => loyaltyAccount.silverThreshold;

	int? getLoyaltyAccountGoldThreshold(LoyaltyAccount loyaltyAccount) => loyaltyAccount.goldThreshold;

	int? getLoyaltyAccountPlatinumThreshold(LoyaltyAccount loyaltyAccount) => loyaltyAccount.platinumThreshold;

	int? getLoyaltyAccountDiamondThreshold(LoyaltyAccount loyaltyAccount) => loyaltyAccount.diamondThreshold;

	int? getLoyaltyAccountCurrentPoints(LoyaltyAccount loyaltyAccount) => loyaltyAccount.currentPoints;

	LoyaltyTier? getLoyaltyAccountCurrentTier(LoyaltyAccount loyaltyAccount) => loyaltyAccount.currentTier;

	int? getLoyaltyAccountTotalEarned(LoyaltyAccount loyaltyAccount) => loyaltyAccount.totalEarned;

	dynamic? getLoyaltyAccountPointsHistory(LoyaltyAccount loyaltyAccount) => loyaltyAccount.pointsHistory;

	dynamic? getLoyaltyAccountRewards(LoyaltyAccount loyaltyAccount) => loyaltyAccount.rewards;

	bool? getLoyaltyAccountIsActive(LoyaltyAccount loyaltyAccount) => loyaltyAccount.isActive;

	String? getLoyaltyAccountCreatedBy(LoyaltyAccount loyaltyAccount) => loyaltyAccount.createdBy;

	DateTime? getLoyaltyAccountCreatedAt(LoyaltyAccount loyaltyAccount) => loyaltyAccount.createdAt;

	DateTime? getLoyaltyAccountUpdatedAt(LoyaltyAccount loyaltyAccount) => loyaltyAccount.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<LoyaltyAccount> getByOrgId(
    String orgId,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByUserId(
    String userId,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByName(
    String name,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountName, name, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByDescription(
    String description,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountDescription, description, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByPointsPerDollar(
    double pointsPerDollar,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountPointsPerDollar, pointsPerDollar, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByPointsExpiryDays(
    int pointsExpiryDays,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountPointsExpiryDays, pointsExpiryDays, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByTiersEnabled(
    bool tiersEnabled,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountTiersEnabled, tiersEnabled, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByBronzeThreshold(
    int bronzeThreshold,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountBronzeThreshold, bronzeThreshold, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getBySilverThreshold(
    int silverThreshold,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountSilverThreshold, silverThreshold, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByGoldThreshold(
    int goldThreshold,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountGoldThreshold, goldThreshold, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByPlatinumThreshold(
    int platinumThreshold,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountPlatinumThreshold, platinumThreshold, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByDiamondThreshold(
    int diamondThreshold,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountDiamondThreshold, diamondThreshold, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByCurrentPoints(
    int currentPoints,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountCurrentPoints, currentPoints, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByCurrentTier(
    LoyaltyTier currentTier,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountCurrentTier, currentTier, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByTotalEarned(
    int totalEarned,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountTotalEarned, totalEarned, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByPointsHistory(
    dynamic pointsHistory,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountPointsHistory, pointsHistory, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByRewards(
    dynamic rewards,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountRewards, rewards, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByIsActive(
    bool isActive,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByCreatedBy(
    String createdBy,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<LoyaltyAccount> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}
    ) =>
    getManyIncluding(getLoyaltyAccountUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    LoyaltyAccount loyaltyAccount, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (loyaltyAccount.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(loyaltyAccount.orgId!, includes: includes);
        loyaltyAccount.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    LoyaltyAccount loyaltyAccount, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (loyaltyAccount.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(loyaltyAccount.userId!, includes: includes);
        loyaltyAccount.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<LoyaltyAccount>> getAll$({bool useCache = true, ModelFilter<LoyaltyAccount>? modelFilter, List<LoyaltyAccountInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: LoyaltyAccountEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<LoyaltyAccount?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getLoyaltyAccountId,
        value: id,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<LoyaltyAccount>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLoyaltyAccountOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLoyaltyAccountUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLoyaltyAccountName,
        value: name,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLoyaltyAccountDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByPointsPerDollar$(
        double pointsPerDollar,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLoyaltyAccountPointsPerDollar,
        value: pointsPerDollar,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByPointsPerDollar,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByPointsExpiryDays$(
        int pointsExpiryDays,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getLoyaltyAccountPointsExpiryDays,
        value: pointsExpiryDays,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByPointsExpiryDays,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByTiersEnabled$(
        bool tiersEnabled,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLoyaltyAccountTiersEnabled,
        value: tiersEnabled,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByTiersEnabled,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByBronzeThreshold$(
        int bronzeThreshold,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getLoyaltyAccountBronzeThreshold,
        value: bronzeThreshold,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByBronzeThreshold,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getBySilverThreshold$(
        int silverThreshold,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getLoyaltyAccountSilverThreshold,
        value: silverThreshold,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyBySilverThreshold,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByGoldThreshold$(
        int goldThreshold,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getLoyaltyAccountGoldThreshold,
        value: goldThreshold,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByGoldThreshold,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByPlatinumThreshold$(
        int platinumThreshold,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getLoyaltyAccountPlatinumThreshold,
        value: platinumThreshold,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByPlatinumThreshold,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByDiamondThreshold$(
        int diamondThreshold,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getLoyaltyAccountDiamondThreshold,
        value: diamondThreshold,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByDiamondThreshold,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByCurrentPoints$(
        int currentPoints,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getLoyaltyAccountCurrentPoints,
        value: currentPoints,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByCurrentPoints,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByCurrentTier$(
        LoyaltyTier currentTier,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<LoyaltyTier>(
        getPropVal: getLoyaltyAccountCurrentTier,
        value: currentTier,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByCurrentTier,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByTotalEarned$(
        int totalEarned,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getLoyaltyAccountTotalEarned,
        value: totalEarned,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByTotalEarned,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByPointsHistory$(
        dynamic pointsHistory,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getLoyaltyAccountPointsHistory,
        value: pointsHistory,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByPointsHistory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByRewards$(
        dynamic rewards,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getLoyaltyAccountRewards,
        value: rewards,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByRewards,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLoyaltyAccountIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLoyaltyAccountCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLoyaltyAccountCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LoyaltyAccount>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<LoyaltyAccount>? modelFilter,
        List<LoyaltyAccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLoyaltyAccountUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: LoyaltyAccountEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    LoyaltyAccount loyaltyAccount, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (loyaltyAccount.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            loyaltyAccount.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            loyaltyAccount.org = org;
        });
    }
}

	Stream<User?> getUser$(
    LoyaltyAccount loyaltyAccount, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (loyaltyAccount.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            loyaltyAccount.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            loyaltyAccount.user = user;
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
LoyaltyAccount recursiveUpsert(LoyaltyAccount loyaltyAccount, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'LoyaltyAccount'} 
        : const {};
    if (loyaltyAccount.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        loyaltyAccount.org = OrganizationStore.instance.recursiveUpsert(loyaltyAccount.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (loyaltyAccount.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        loyaltyAccount.user = UserStore.instance.recursiveUpsert(loyaltyAccount.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(loyaltyAccount);
}

  List<LoyaltyAccount> recursiveListUpsert(List<LoyaltyAccount> loyaltyAccounts, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedLoyaltyAccounts = <LoyaltyAccount>[];
    for (var loyaltyAccount in loyaltyAccounts) {
        updatedLoyaltyAccounts.add(recursiveUpsert(loyaltyAccount, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedLoyaltyAccounts;
}

//   @override
//   LoyaltyAccount upsert(LoyaltyAccount item) {
//     return recursiveUpsert(item);
//   }

}


class LoyaltyAccountInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      LoyaltyAccountInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (loyaltyAccount) => LoyaltyAccountStore.instance
            .getOrg$(loyaltyAccount, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (loyaltyAccount) => LoyaltyAccountStore.instance
            .getOrg(loyaltyAccount, modelFilter: modelFilter, includes: includes);
      }
}

	LoyaltyAccountInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (loyaltyAccount) => LoyaltyAccountStore.instance
            .getUser$(loyaltyAccount, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (loyaltyAccount) => LoyaltyAccountStore.instance
            .getUser(loyaltyAccount, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum LoyaltyAccountEndpoints implements Endpoint {

    getAll('/loyaltyAccount', HttpMethod.post, List<LoyaltyAccount>),
	getById('/loyaltyAccount/byId/:id', HttpMethod.post, LoyaltyAccount),
	getManyByOrgId('/loyaltyAccount/byOrgId/:orgId', HttpMethod.post, List<LoyaltyAccount>),
	getManyByUserId('/loyaltyAccount/byUserId/:userId', HttpMethod.post, List<LoyaltyAccount>),
	getManyByName('/loyaltyAccount/byName/:name', HttpMethod.post, List<LoyaltyAccount>),
	getManyByDescription('/loyaltyAccount/byDescription/:description', HttpMethod.post, List<LoyaltyAccount>),
	getManyByPointsPerDollar('/loyaltyAccount/byPointsPerDollar/:pointsPerDollar', HttpMethod.post, List<LoyaltyAccount>),
	getManyByPointsExpiryDays('/loyaltyAccount/byPointsExpiryDays/:pointsExpiryDays', HttpMethod.post, List<LoyaltyAccount>),
	getManyByTiersEnabled('/loyaltyAccount/byTiersEnabled/:tiersEnabled', HttpMethod.post, List<LoyaltyAccount>),
	getManyByBronzeThreshold('/loyaltyAccount/byBronzeThreshold/:bronzeThreshold', HttpMethod.post, List<LoyaltyAccount>),
	getManyBySilverThreshold('/loyaltyAccount/bySilverThreshold/:silverThreshold', HttpMethod.post, List<LoyaltyAccount>),
	getManyByGoldThreshold('/loyaltyAccount/byGoldThreshold/:goldThreshold', HttpMethod.post, List<LoyaltyAccount>),
	getManyByPlatinumThreshold('/loyaltyAccount/byPlatinumThreshold/:platinumThreshold', HttpMethod.post, List<LoyaltyAccount>),
	getManyByDiamondThreshold('/loyaltyAccount/byDiamondThreshold/:diamondThreshold', HttpMethod.post, List<LoyaltyAccount>),
	getManyByCurrentPoints('/loyaltyAccount/byCurrentPoints/:currentPoints', HttpMethod.post, List<LoyaltyAccount>),
	getManyByCurrentTier('/loyaltyAccount/byCurrentTier/:currentTier', HttpMethod.post, List<LoyaltyAccount>),
	getManyByTotalEarned('/loyaltyAccount/byTotalEarned/:totalEarned', HttpMethod.post, List<LoyaltyAccount>),
	getManyByPointsHistory('/loyaltyAccount/byPointsHistory/:pointsHistory', HttpMethod.post, List<LoyaltyAccount>),
	getManyByRewards('/loyaltyAccount/byRewards/:rewards', HttpMethod.post, List<LoyaltyAccount>),
	getManyByIsActive('/loyaltyAccount/byIsActive/:isActive', HttpMethod.post, List<LoyaltyAccount>),
	getManyByCreatedBy('/loyaltyAccount/byCreatedBy/:createdBy', HttpMethod.post, List<LoyaltyAccount>),
	getManyByCreatedAt('/loyaltyAccount/byCreatedAt/:createdAt', HttpMethod.post, List<LoyaltyAccount>),
	getManyByUpdatedAt('/loyaltyAccount/byUpdatedAt/:updatedAt', HttpMethod.post, List<LoyaltyAccount>);

    const LoyaltyAccountEndpoints(this.path, this.method, this.responseType);

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
