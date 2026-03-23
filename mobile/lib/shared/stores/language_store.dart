
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class LanguageStore extends ModelStreamStore<String, Language> {

  static LanguageStore? _instance;

  static LanguageStore get instance {
    _instance ??= LanguageStore();
    return _instance!;
  }

  LanguageStore() : super(Language.fromJson) {
    if (_instance != null) {
        throw Exception(
            'LanguageStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending LanguageStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use LanguageStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getLanguageId(Language language) => language.id;

	String? getLanguageCode(Language language) => language.code;

	String? getLanguageName(Language language) => language.name;

	String? getLanguageNativeName(Language language) => language.nativeName;

	bool? getLanguageIsRTL(Language language) => language.isRTL;

	bool? getLanguageIsActive(Language language) => language.isActive;

	DateTime? getLanguageCreatedAt(Language language) => language.createdAt;

	DateTime? getLanguageUpdatedAt(Language language) => language.updatedAt;

	DateTime? getLanguageDeletedAt(Language language) => language.deletedAt;

	String? getLanguageAgencyId(Language language) => language.agencyId;

	String? getLanguageAgentId(Language language) => language.agentId;

	String? getLanguageUserId(Language language) => language.userId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Language? getByCode(
    String code,
    {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}
    ) =>
    getIncluding(getLanguageCode, code, modelFilter: modelFilter, includes: includes);

  
List<Language> getByName(
    String name,
    {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}
    ) =>
    getManyIncluding(getLanguageName, name, modelFilter: modelFilter, includes: includes);

	
List<Language> getByNativeName(
    String nativeName,
    {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}
    ) =>
    getManyIncluding(getLanguageNativeName, nativeName, modelFilter: modelFilter, includes: includes);

	
List<Language> getByIsRTL(
    bool isRTL,
    {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}
    ) =>
    getManyIncluding(getLanguageIsRTL, isRTL, modelFilter: modelFilter, includes: includes);

	
List<Language> getByIsActive(
    bool isActive,
    {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}
    ) =>
    getManyIncluding(getLanguageIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<Language> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}
    ) =>
    getManyIncluding(getLanguageCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Language> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}
    ) =>
    getManyIncluding(getLanguageUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Language> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}
    ) =>
    getManyIncluding(getLanguageDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Language> getByAgencyId(
    String agencyId,
    {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}
    ) =>
    getManyIncluding(getLanguageAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<Language> getByAgentId(
    String agentId,
    {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}
    ) =>
    getManyIncluding(getLanguageAgentId, agentId, modelFilter: modelFilter, includes: includes);

	
List<Language> getByUserId(
    String userId,
    {ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}
    ) =>
    getManyIncluding(getLanguageUserId, userId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Agency? getAgency(
    Language language, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (language.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(language.agencyId!, includes: includes);
        language.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

	Agent? getAgent(
    Language language, {ModelFilter? modelFilter, List<AgentInclude>? includes}) {
    if (language.agentId == null) {
        return null;
    } else {
        final Agent = AgentStore.instance.getById(language.agentId!, includes: includes);
        language.Agent = Agent;
        // setIncludedReferences(Agent, includes: includes);
        return Agent;
    }
}

	User? getUser(
    Language language, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (language.userId == null) {
        return null;
    } else {
        final User = UserStore.instance.getById(language.userId!, includes: includes);
        language.User = User;
        // setIncludedReferences(User, includes: includes);
        return User;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Language>> getAll$({bool useCache = true, ModelFilter<Language>? modelFilter, List<LanguageInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: LanguageEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Language?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getLanguageId,
        value: id,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Language?> getByCode$(
        String code,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getLanguageCode,
        value: code,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getByCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Language>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLanguageName,
        value: name,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Language>> getByNativeName$(
        String nativeName,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLanguageNativeName,
        value: nativeName,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getManyByNativeName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Language>> getByIsRTL$(
        bool isRTL,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLanguageIsRTL,
        value: isRTL,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getManyByIsRTL,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Language>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getLanguageIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Language>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLanguageCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Language>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLanguageUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Language>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLanguageDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Language>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLanguageAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Language>> getByAgentId$(
        String agentId,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLanguageAgentId,
        value: agentId,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getManyByAgentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Language>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Language>? modelFilter,
        List<LanguageInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLanguageUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: LanguageEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Agency?> getAgency$(
    Language language, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (language.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            language.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            language.Agency = Agency;
        });
    }
}

	Stream<Agent?> getAgent$(
    Language language, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    if (language.agentId == null) {
        return Stream.value(null);
    } else {
        return AgentStore.instance.getById$(
            language.agentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agent) {
            language.Agent = Agent;
        });
    }
}

	Stream<User?> getUser$(
    Language language, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (language.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            language.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((User) {
            language.User = User;
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
Language recursiveUpsert(Language language, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Language'} 
        : const {};
    if (language.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        language.Agency = AgencyStore.instance.recursiveUpsert(language.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (language.Agent != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        language.Agent = AgentStore.instance.recursiveUpsert(language.Agent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (language.User != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        language.User = UserStore.instance.recursiveUpsert(language.User!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(language);
}

  List<Language> recursiveListUpsert(List<Language> languages, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedLanguages = <Language>[];
    for (var language in languages) {
        updatedLanguages.add(recursiveUpsert(language, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedLanguages;
}

//   @override
//   Language upsert(Language item) {
//     return recursiveUpsert(item);
//   }

}


class LanguageInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      LanguageInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (language) => LanguageStore.instance
            .getAgency$(language, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (language) => LanguageStore.instance
            .getAgency(language, modelFilter: modelFilter, includes: includes);
      }
}

	LanguageInclude.Agent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (language) => LanguageStore.instance
            .getAgent$(language, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (language) => LanguageStore.instance
            .getAgent(language, modelFilter: modelFilter, includes: includes);
      }
}

	LanguageInclude.User({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (language) => LanguageStore.instance
            .getUser$(language, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (language) => LanguageStore.instance
            .getUser(language, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum LanguageEndpoints implements Endpoint {

    getAll('/language', HttpMethod.post, List<Language>),
	getById('/language/byId/:id', HttpMethod.post, Language),
	getByCode('/language/byCode/:code', HttpMethod.post, Language),
	getManyByName('/language/byName/:name', HttpMethod.post, List<Language>),
	getManyByNativeName('/language/byNativeName/:nativeName', HttpMethod.post, List<Language>),
	getManyByIsRTL('/language/byIsRTL/:isRTL', HttpMethod.post, List<Language>),
	getManyByIsActive('/language/byIsActive/:isActive', HttpMethod.post, List<Language>),
	getManyByCreatedAt('/language/byCreatedAt/:createdAt', HttpMethod.post, List<Language>),
	getManyByUpdatedAt('/language/byUpdatedAt/:updatedAt', HttpMethod.post, List<Language>),
	getManyByDeletedAt('/language/byDeletedAt/:deletedAt', HttpMethod.post, List<Language>),
	getManyByAgencyId('/language/byAgencyId/:agencyId', HttpMethod.post, List<Language>),
	getManyByAgentId('/language/byAgentId/:agentId', HttpMethod.post, List<Language>),
	getManyByUserId('/language/byUserId/:userId', HttpMethod.post, List<Language>);

    const LanguageEndpoints(this.path, this.method, this.responseType);

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
