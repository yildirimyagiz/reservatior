
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AccountStore extends ModelStreamStore<String, Account> {

  static AccountStore? _instance;

  static AccountStore get instance {
    _instance ??= AccountStore();
    return _instance!;
  }

  AccountStore() : super(Account.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AccountStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AccountStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AccountStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAccountId(Account account) => account.id;

	String? getAccountUserId(Account account) => account.userId;

	AccountType? getAccountType(Account account) => account.type;

	String? getAccountProviderId(Account account) => account.providerId;

	String? getAccountAccountId(Account account) => account.accountId;

	String? getAccountRefreshToken(Account account) => account.refreshToken;

	String? getAccountAccessToken(Account account) => account.accessToken;

	DateTime? getAccountAccessTokenExpiresAt(Account account) => account.accessTokenExpiresAt;

	String? getAccountTokenType(Account account) => account.tokenType;

	String? getAccountScope(Account account) => account.scope;

	String? getAccountIdToken(Account account) => account.idToken;

	String? getAccountSessionState(Account account) => account.sessionState;

	bool? getAccountIsActive(Account account) => account.isActive;

	DateTime? getAccountCreatedAt(Account account) => account.createdAt;

	DateTime? getAccountUpdatedAt(Account account) => account.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Account> getByUserId(
    String userId,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Account> getByType(
    AccountType type,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountType, type, modelFilter: modelFilter, includes: includes);

	
List<Account> getByProviderId(
    String providerId,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountProviderId, providerId, modelFilter: modelFilter, includes: includes);

	
List<Account> getByAccountId(
    String accountId,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountAccountId, accountId, modelFilter: modelFilter, includes: includes);

	
List<Account> getByRefreshToken(
    String refreshToken,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountRefreshToken, refreshToken, modelFilter: modelFilter, includes: includes);

	
List<Account> getByAccessToken(
    String accessToken,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountAccessToken, accessToken, modelFilter: modelFilter, includes: includes);

	
List<Account> getByAccessTokenExpiresAt(
    DateTime accessTokenExpiresAt,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountAccessTokenExpiresAt, accessTokenExpiresAt, modelFilter: modelFilter, includes: includes);

	
List<Account> getByTokenType(
    String tokenType,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountTokenType, tokenType, modelFilter: modelFilter, includes: includes);

	
List<Account> getByScope(
    String scope,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountScope, scope, modelFilter: modelFilter, includes: includes);

	
List<Account> getByIdToken(
    String idToken,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountIdToken, idToken, modelFilter: modelFilter, includes: includes);

	
List<Account> getBySessionState(
    String sessionState,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountSessionState, sessionState, modelFilter: modelFilter, includes: includes);

	
List<Account> getByIsActive(
    bool isActive,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Account> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Account> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}
    ) =>
    getManyIncluding(getAccountUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  User? getUser(
    Account account, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (account.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(account.userId!, includes: includes);
        account.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Account>> getAll$({bool useCache = true, ModelFilter<Account>? modelFilter, List<AccountInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AccountEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Account?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAccountId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Account>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAccountUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByType$(
        AccountType type,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<AccountType>(
        getPropVal: getAccountType,
        value: type,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByProviderId$(
        String providerId,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAccountProviderId,
        value: providerId,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByProviderId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByAccountId$(
        String accountId,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAccountAccountId,
        value: accountId,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByAccountId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByRefreshToken$(
        String refreshToken,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAccountRefreshToken,
        value: refreshToken,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByRefreshToken,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByAccessToken$(
        String accessToken,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAccountAccessToken,
        value: accessToken,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByAccessToken,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByAccessTokenExpiresAt$(
        DateTime accessTokenExpiresAt,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAccountAccessTokenExpiresAt,
        value: accessTokenExpiresAt,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByAccessTokenExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByTokenType$(
        String tokenType,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAccountTokenType,
        value: tokenType,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByTokenType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByScope$(
        String scope,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAccountScope,
        value: scope,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByScope,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByIdToken$(
        String idToken,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAccountIdToken,
        value: idToken,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByIdToken,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getBySessionState$(
        String sessionState,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAccountSessionState,
        value: sessionState,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyBySessionState,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getAccountIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAccountCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Account>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Account>? modelFilter,
        List<AccountInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAccountUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AccountEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<User?> getUser$(
    Account account, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (account.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            account.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            account.user = user;
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
Account recursiveUpsert(Account account, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Account'} 
        : const {};
    if (account.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        account.user = UserStore.instance.recursiveUpsert(account.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(account);
}

  List<Account> recursiveListUpsert(List<Account> accounts, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAccounts = <Account>[];
    for (var account in accounts) {
        updatedAccounts.add(recursiveUpsert(account, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAccounts;
}

//   @override
//   Account upsert(Account item) {
//     return recursiveUpsert(item);
//   }

}


class AccountInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AccountInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (account) => AccountStore.instance
            .getUser$(account, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (account) => AccountStore.instance
            .getUser(account, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AccountEndpoints implements Endpoint {

    getAll('/account', HttpMethod.post, List<Account>),
	getById('/account/byId/:id', HttpMethod.post, Account),
	getManyByUserId('/account/byUserId/:userId', HttpMethod.post, List<Account>),
	getManyByType('/account/byType/:type', HttpMethod.post, List<Account>),
	getManyByProviderId('/account/byProviderId/:providerId', HttpMethod.post, List<Account>),
	getManyByAccountId('/account/byAccountId/:accountId', HttpMethod.post, List<Account>),
	getManyByRefreshToken('/account/byRefreshToken/:refreshToken', HttpMethod.post, List<Account>),
	getManyByAccessToken('/account/byAccessToken/:accessToken', HttpMethod.post, List<Account>),
	getManyByAccessTokenExpiresAt('/account/byAccessTokenExpiresAt/:accessTokenExpiresAt', HttpMethod.post, List<Account>),
	getManyByTokenType('/account/byTokenType/:tokenType', HttpMethod.post, List<Account>),
	getManyByScope('/account/byScope/:scope', HttpMethod.post, List<Account>),
	getManyByIdToken('/account/byIdToken/:idToken', HttpMethod.post, List<Account>),
	getManyBySessionState('/account/bySessionState/:sessionState', HttpMethod.post, List<Account>),
	getManyByIsActive('/account/byIsActive/:isActive', HttpMethod.post, List<Account>),
	getManyByCreatedAt('/account/byCreatedAt/:createdAt', HttpMethod.post, List<Account>),
	getManyByUpdatedAt('/account/byUpdatedAt/:updatedAt', HttpMethod.post, List<Account>);

    const AccountEndpoints(this.path, this.method, this.responseType);

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
