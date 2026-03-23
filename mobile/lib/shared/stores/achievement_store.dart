
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AchievementStore extends ModelStreamStore<String, Achievement> {

  static AchievementStore? _instance;

  static AchievementStore get instance {
    _instance ??= AchievementStore();
    return _instance!;
  }

  AchievementStore() : super(Achievement.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AchievementStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AchievementStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AchievementStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAchievementId(Achievement achievement) => achievement.id;

	String? getAchievementUserId(Achievement achievement) => achievement.userId;

	GoalType? getAchievementGoalType(Achievement achievement) => achievement.goalType;

	int? getAchievementGoalValue(Achievement achievement) => achievement.goalValue;

	int? getAchievementCurrentValue(Achievement achievement) => achievement.currentValue;

	bool? getAchievementIsCompleted(Achievement achievement) => achievement.isCompleted;

	DateTime? getAchievementCompletedAt(Achievement achievement) => achievement.completedAt;

	int? getAchievementPointsReward(Achievement achievement) => achievement.pointsReward;

	String? getAchievementBonusReward(Achievement achievement) => achievement.bonusReward;

	DateTime? getAchievementCreatedAt(Achievement achievement) => achievement.createdAt;

	DateTime? getAchievementUpdatedAt(Achievement achievement) => achievement.updatedAt;

	String? getAchievementOrganizationId(Achievement achievement) => achievement.organizationId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Achievement> getByUserId(
    String userId,
    {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}
    ) =>
    getManyIncluding(getAchievementUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Achievement> getByGoalType(
    GoalType goalType,
    {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}
    ) =>
    getManyIncluding(getAchievementGoalType, goalType, modelFilter: modelFilter, includes: includes);

	
List<Achievement> getByGoalValue(
    int goalValue,
    {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}
    ) =>
    getManyIncluding(getAchievementGoalValue, goalValue, modelFilter: modelFilter, includes: includes);

	
List<Achievement> getByCurrentValue(
    int currentValue,
    {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}
    ) =>
    getManyIncluding(getAchievementCurrentValue, currentValue, modelFilter: modelFilter, includes: includes);

	
List<Achievement> getByIsCompleted(
    bool isCompleted,
    {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}
    ) =>
    getManyIncluding(getAchievementIsCompleted, isCompleted, modelFilter: modelFilter, includes: includes);

	
List<Achievement> getByCompletedAt(
    DateTime completedAt,
    {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}
    ) =>
    getManyIncluding(getAchievementCompletedAt, completedAt, modelFilter: modelFilter, includes: includes);

	
List<Achievement> getByPointsReward(
    int pointsReward,
    {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}
    ) =>
    getManyIncluding(getAchievementPointsReward, pointsReward, modelFilter: modelFilter, includes: includes);

	
List<Achievement> getByBonusReward(
    String bonusReward,
    {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}
    ) =>
    getManyIncluding(getAchievementBonusReward, bonusReward, modelFilter: modelFilter, includes: includes);

	
List<Achievement> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}
    ) =>
    getManyIncluding(getAchievementCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Achievement> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}
    ) =>
    getManyIncluding(getAchievementUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Achievement> getByOrganizationId(
    String organizationId,
    {ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}
    ) =>
    getManyIncluding(getAchievementOrganizationId, organizationId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrganization(
    Achievement achievement, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (achievement.organizationId == null) {
        return null;
    } else {
        final organization = OrganizationStore.instance.getById(achievement.organizationId!, includes: includes);
        achievement.organization = organization;
        // setIncludedReferences(organization, includes: includes);
        return organization;
    }
}

	User? getUser(
    Achievement achievement, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (achievement.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(achievement.userId!, includes: includes);
        achievement.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Achievement>> getAll$({bool useCache = true, ModelFilter<Achievement>? modelFilter, List<AchievementInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AchievementEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Achievement?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAchievementId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Achievement>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAchievementUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Achievement>> getByGoalType$(
        GoalType goalType,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final items$ = getManyByFieldValue$<GoalType>(
        getPropVal: getAchievementGoalType,
        value: goalType,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getManyByGoalType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Achievement>> getByGoalValue$(
        int goalValue,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAchievementGoalValue,
        value: goalValue,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getManyByGoalValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Achievement>> getByCurrentValue$(
        int currentValue,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAchievementCurrentValue,
        value: currentValue,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getManyByCurrentValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Achievement>> getByIsCompleted$(
        bool isCompleted,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAchievementIsCompleted,
        value: isCompleted,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getManyByIsCompleted,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Achievement>> getByCompletedAt$(
        DateTime completedAt,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAchievementCompletedAt,
        value: completedAt,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getManyByCompletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Achievement>> getByPointsReward$(
        int pointsReward,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAchievementPointsReward,
        value: pointsReward,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getManyByPointsReward,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Achievement>> getByBonusReward$(
        String bonusReward,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAchievementBonusReward,
        value: bonusReward,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getManyByBonusReward,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Achievement>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAchievementCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Achievement>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAchievementUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Achievement>> getByOrganizationId$(
        String organizationId,
        {bool useCache = true,
        ModelFilter<Achievement>? modelFilter,
        List<AchievementInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAchievementOrganizationId,
        value: organizationId,
        modelFilter: modelFilter,
        endpoint: AchievementEndpoints.getManyByOrganizationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrganization$(
    Achievement achievement, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (achievement.organizationId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            achievement.organizationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((organization) {
            achievement.organization = organization;
        });
    }
}

	Stream<User?> getUser$(
    Achievement achievement, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (achievement.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            achievement.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            achievement.user = user;
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
Achievement recursiveUpsert(Achievement achievement, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Achievement'} 
        : const {};
    if (achievement.organization != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        achievement.organization = OrganizationStore.instance.recursiveUpsert(achievement.organization!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (achievement.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        achievement.user = UserStore.instance.recursiveUpsert(achievement.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(achievement);
}

  List<Achievement> recursiveListUpsert(List<Achievement> achievements, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAchievements = <Achievement>[];
    for (var achievement in achievements) {
        updatedAchievements.add(recursiveUpsert(achievement, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAchievements;
}

//   @override
//   Achievement upsert(Achievement item) {
//     return recursiveUpsert(item);
//   }

}


class AchievementInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AchievementInclude.organization({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (achievement) => AchievementStore.instance
            .getOrganization$(achievement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (achievement) => AchievementStore.instance
            .getOrganization(achievement, modelFilter: modelFilter, includes: includes);
      }
}

	AchievementInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (achievement) => AchievementStore.instance
            .getUser$(achievement, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (achievement) => AchievementStore.instance
            .getUser(achievement, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AchievementEndpoints implements Endpoint {

    getAll('/achievement', HttpMethod.post, List<Achievement>),
	getById('/achievement/byId/:id', HttpMethod.post, Achievement),
	getManyByUserId('/achievement/byUserId/:userId', HttpMethod.post, List<Achievement>),
	getManyByGoalType('/achievement/byGoalType/:goalType', HttpMethod.post, List<Achievement>),
	getManyByGoalValue('/achievement/byGoalValue/:goalValue', HttpMethod.post, List<Achievement>),
	getManyByCurrentValue('/achievement/byCurrentValue/:currentValue', HttpMethod.post, List<Achievement>),
	getManyByIsCompleted('/achievement/byIsCompleted/:isCompleted', HttpMethod.post, List<Achievement>),
	getManyByCompletedAt('/achievement/byCompletedAt/:completedAt', HttpMethod.post, List<Achievement>),
	getManyByPointsReward('/achievement/byPointsReward/:pointsReward', HttpMethod.post, List<Achievement>),
	getManyByBonusReward('/achievement/byBonusReward/:bonusReward', HttpMethod.post, List<Achievement>),
	getManyByCreatedAt('/achievement/byCreatedAt/:createdAt', HttpMethod.post, List<Achievement>),
	getManyByUpdatedAt('/achievement/byUpdatedAt/:updatedAt', HttpMethod.post, List<Achievement>),
	getManyByOrganizationId('/achievement/byOrganizationId/:organizationId', HttpMethod.post, List<Achievement>);

    const AchievementEndpoints(this.path, this.method, this.responseType);

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
