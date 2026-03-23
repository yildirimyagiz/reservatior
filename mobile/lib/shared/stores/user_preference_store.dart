
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class UserPreferenceStore extends ModelStreamStore<String, UserPreference> {

  static UserPreferenceStore? _instance;

  static UserPreferenceStore get instance {
    _instance ??= UserPreferenceStore();
    return _instance!;
  }

  UserPreferenceStore() : super(UserPreference.fromJson) {
    if (_instance != null) {
        throw Exception(
            'UserPreferenceStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending UserPreferenceStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use UserPreferenceStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getUserPreferenceId(UserPreference userPreference) => userPreference.id;

	String? getUserPreferenceUserId(UserPreference userPreference) => userPreference.userId;

	String? getUserPreferenceOrgId(UserPreference userPreference) => userPreference.orgId;

	String? getUserPreferenceTheme(UserPreference userPreference) => userPreference.theme;

	String? getUserPreferenceLanguage(UserPreference userPreference) => userPreference.language;

	String? getUserPreferenceTimezone(UserPreference userPreference) => userPreference.timezone;

	String? getUserPreferenceDateFormat(UserPreference userPreference) => userPreference.dateFormat;

	String? getUserPreferenceCurrency(UserPreference userPreference) => userPreference.currency;

	bool? getUserPreferenceEmailNotifications(UserPreference userPreference) => userPreference.emailNotifications;

	bool? getUserPreferencePushNotifications(UserPreference userPreference) => userPreference.pushNotifications;

	bool? getUserPreferenceMarketingEmails(UserPreference userPreference) => userPreference.marketingEmails;

	dynamic? getUserPreferenceDashboardLayout(UserPreference userPreference) => userPreference.dashboardLayout;

	DateTime? getUserPreferenceCreatedAt(UserPreference userPreference) => userPreference.createdAt;

	DateTime? getUserPreferenceUpdatedAt(UserPreference userPreference) => userPreference.updatedAt;

	DateTime? getUserPreferenceDeletedAt(UserPreference userPreference) => userPreference.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
UserPreference? getByUserId(
    String userId,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getIncluding(getUserPreferenceUserId, userId, modelFilter: modelFilter, includes: includes);

  
List<UserPreference> getByOrgId(
    String orgId,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByTheme(
    String theme,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceTheme, theme, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByLanguage(
    String language,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceLanguage, language, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByTimezone(
    String timezone,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceTimezone, timezone, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByDateFormat(
    String dateFormat,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceDateFormat, dateFormat, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByCurrency(
    String currency,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByEmailNotifications(
    bool emailNotifications,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceEmailNotifications, emailNotifications, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByPushNotifications(
    bool pushNotifications,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferencePushNotifications, pushNotifications, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByMarketingEmails(
    bool marketingEmails,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceMarketingEmails, marketingEmails, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByDashboardLayout(
    dynamic dashboardLayout,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceDashboardLayout, dashboardLayout, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<UserPreference> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}
    ) =>
    getManyIncluding(getUserPreferenceDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    UserPreference userPreference, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (userPreference.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(userPreference.orgId!, includes: includes);
        userPreference.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	User? getUser(
    UserPreference userPreference, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (userPreference.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(userPreference.userId!, includes: includes);
        userPreference.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<UserPreference>> getAll$({bool useCache = true, ModelFilter<UserPreference>? modelFilter, List<UserPreferenceInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: UserPreferenceEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<UserPreference?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getUserPreferenceId,
        value: id,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<UserPreference?> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getUserPreferenceUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<UserPreference>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserPreferenceOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByTheme$(
        String theme,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserPreferenceTheme,
        value: theme,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByTheme,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByLanguage$(
        String language,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserPreferenceLanguage,
        value: language,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByLanguage,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByTimezone$(
        String timezone,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserPreferenceTimezone,
        value: timezone,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByTimezone,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByDateFormat$(
        String dateFormat,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserPreferenceDateFormat,
        value: dateFormat,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByDateFormat,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getUserPreferenceCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByEmailNotifications$(
        bool emailNotifications,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getUserPreferenceEmailNotifications,
        value: emailNotifications,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByEmailNotifications,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByPushNotifications$(
        bool pushNotifications,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getUserPreferencePushNotifications,
        value: pushNotifications,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByPushNotifications,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByMarketingEmails$(
        bool marketingEmails,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getUserPreferenceMarketingEmails,
        value: marketingEmails,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByMarketingEmails,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByDashboardLayout$(
        dynamic dashboardLayout,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getUserPreferenceDashboardLayout,
        value: dashboardLayout,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByDashboardLayout,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserPreferenceCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserPreferenceUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<UserPreference>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<UserPreference>? modelFilter,
        List<UserPreferenceInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getUserPreferenceDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: UserPreferenceEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    UserPreference userPreference, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (userPreference.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            userPreference.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            userPreference.org = org;
        });
    }
}

	Stream<User?> getUser$(
    UserPreference userPreference, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (userPreference.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            userPreference.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            userPreference.user = user;
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
UserPreference recursiveUpsert(UserPreference userPreference, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'UserPreference'} 
        : const {};
    if (userPreference.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        userPreference.org = OrganizationStore.instance.recursiveUpsert(userPreference.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (userPreference.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        userPreference.user = UserStore.instance.recursiveUpsert(userPreference.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(userPreference);
}

  List<UserPreference> recursiveListUpsert(List<UserPreference> userPreferences, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedUserPreferences = <UserPreference>[];
    for (var userPreference in userPreferences) {
        updatedUserPreferences.add(recursiveUpsert(userPreference, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedUserPreferences;
}

//   @override
//   UserPreference upsert(UserPreference item) {
//     return recursiveUpsert(item);
//   }

}


class UserPreferenceInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      UserPreferenceInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (userPreference) => UserPreferenceStore.instance
            .getOrg$(userPreference, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (userPreference) => UserPreferenceStore.instance
            .getOrg(userPreference, modelFilter: modelFilter, includes: includes);
      }
}

	UserPreferenceInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (userPreference) => UserPreferenceStore.instance
            .getUser$(userPreference, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (userPreference) => UserPreferenceStore.instance
            .getUser(userPreference, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum UserPreferenceEndpoints implements Endpoint {

    getAll('/userPreference', HttpMethod.post, List<UserPreference>),
	getById('/userPreference/byId/:id', HttpMethod.post, UserPreference),
	getByUserId('/userPreference/byUserId/:userId', HttpMethod.post, UserPreference),
	getManyByOrgId('/userPreference/byOrgId/:orgId', HttpMethod.post, List<UserPreference>),
	getManyByTheme('/userPreference/byTheme/:theme', HttpMethod.post, List<UserPreference>),
	getManyByLanguage('/userPreference/byLanguage/:language', HttpMethod.post, List<UserPreference>),
	getManyByTimezone('/userPreference/byTimezone/:timezone', HttpMethod.post, List<UserPreference>),
	getManyByDateFormat('/userPreference/byDateFormat/:dateFormat', HttpMethod.post, List<UserPreference>),
	getManyByCurrency('/userPreference/byCurrency/:currency', HttpMethod.post, List<UserPreference>),
	getManyByEmailNotifications('/userPreference/byEmailNotifications/:emailNotifications', HttpMethod.post, List<UserPreference>),
	getManyByPushNotifications('/userPreference/byPushNotifications/:pushNotifications', HttpMethod.post, List<UserPreference>),
	getManyByMarketingEmails('/userPreference/byMarketingEmails/:marketingEmails', HttpMethod.post, List<UserPreference>),
	getManyByDashboardLayout('/userPreference/byDashboardLayout/:dashboardLayout', HttpMethod.post, List<UserPreference>),
	getManyByCreatedAt('/userPreference/byCreatedAt/:createdAt', HttpMethod.post, List<UserPreference>),
	getManyByUpdatedAt('/userPreference/byUpdatedAt/:updatedAt', HttpMethod.post, List<UserPreference>),
	getManyByDeletedAt('/userPreference/byDeletedAt/:deletedAt', HttpMethod.post, List<UserPreference>);

    const UserPreferenceEndpoints(this.path, this.method, this.responseType);

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
