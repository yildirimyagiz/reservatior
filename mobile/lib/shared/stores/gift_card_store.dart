
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class GiftCardStore extends ModelStreamStore<String, GiftCard> {

  static GiftCardStore? _instance;

  static GiftCardStore get instance {
    _instance ??= GiftCardStore();
    return _instance!;
  }

  GiftCardStore() : super(GiftCard.fromJson) {
    if (_instance != null) {
        throw Exception(
            'GiftCardStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending GiftCardStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use GiftCardStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getGiftCardId(GiftCard giftCard) => giftCard.id;

	String? getGiftCardCode(GiftCard giftCard) => giftCard.code;

	String? getGiftCardOrgId(GiftCard giftCard) => giftCard.orgId;

	double? getGiftCardAmount(GiftCard giftCard) => giftCard.amount;

	double? getGiftCardBalance(GiftCard giftCard) => giftCard.balance;

	String? getGiftCardCurrency(GiftCard giftCard) => giftCard.currency;

	DateTime? getGiftCardExpiresAt(GiftCard giftCard) => giftCard.expiresAt;

	bool? getGiftCardIsActive(GiftCard giftCard) => giftCard.isActive;

	String? getGiftCardIssuedTo(GiftCard giftCard) => giftCard.issuedTo;

	String? getGiftCardIssuedBy(GiftCard giftCard) => giftCard.issuedBy;

	String? getGiftCardIssuedFor(GiftCard giftCard) => giftCard.issuedFor;

	DateTime? getGiftCardCreatedAt(GiftCard giftCard) => giftCard.createdAt;

	DateTime? getGiftCardUpdatedAt(GiftCard giftCard) => giftCard.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
GiftCard? getByCode(
    String code,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getIncluding(getGiftCardCode, code, modelFilter: modelFilter, includes: includes);

  
List<GiftCard> getByOrgId(
    String orgId,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getManyIncluding(getGiftCardOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<GiftCard> getByAmount(
    double amount,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getManyIncluding(getGiftCardAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<GiftCard> getByBalance(
    double balance,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getManyIncluding(getGiftCardBalance, balance, modelFilter: modelFilter, includes: includes);

	
List<GiftCard> getByCurrency(
    String currency,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getManyIncluding(getGiftCardCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<GiftCard> getByExpiresAt(
    DateTime expiresAt,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getManyIncluding(getGiftCardExpiresAt, expiresAt, modelFilter: modelFilter, includes: includes);

	
List<GiftCard> getByIsActive(
    bool isActive,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getManyIncluding(getGiftCardIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<GiftCard> getByIssuedTo(
    String issuedTo,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getManyIncluding(getGiftCardIssuedTo, issuedTo, modelFilter: modelFilter, includes: includes);

	
List<GiftCard> getByIssuedBy(
    String issuedBy,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getManyIncluding(getGiftCardIssuedBy, issuedBy, modelFilter: modelFilter, includes: includes);

	
List<GiftCard> getByIssuedFor(
    String issuedFor,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getManyIncluding(getGiftCardIssuedFor, issuedFor, modelFilter: modelFilter, includes: includes);

	
List<GiftCard> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getManyIncluding(getGiftCardCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<GiftCard> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}
    ) =>
    getManyIncluding(getGiftCardUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    GiftCard giftCard, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (giftCard.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(giftCard.orgId!, includes: includes);
        giftCard.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<GiftCard>> getAll$({bool useCache = true, ModelFilter<GiftCard>? modelFilter, List<GiftCardInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: GiftCardEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<GiftCard?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getGiftCardId,
        value: id,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<GiftCard?> getByCode$(
        String code,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getGiftCardCode,
        value: code,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getByCode,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<GiftCard>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGiftCardOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GiftCard>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getGiftCardAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GiftCard>> getByBalance$(
        double balance,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getGiftCardBalance,
        value: balance,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getManyByBalance,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GiftCard>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGiftCardCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GiftCard>> getByExpiresAt$(
        DateTime expiresAt,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getGiftCardExpiresAt,
        value: expiresAt,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getManyByExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GiftCard>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getGiftCardIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GiftCard>> getByIssuedTo$(
        String issuedTo,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGiftCardIssuedTo,
        value: issuedTo,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getManyByIssuedTo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GiftCard>> getByIssuedBy$(
        String issuedBy,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGiftCardIssuedBy,
        value: issuedBy,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getManyByIssuedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GiftCard>> getByIssuedFor$(
        String issuedFor,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getGiftCardIssuedFor,
        value: issuedFor,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getManyByIssuedFor,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GiftCard>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getGiftCardCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<GiftCard>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<GiftCard>? modelFilter,
        List<GiftCardInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getGiftCardUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: GiftCardEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    GiftCard giftCard, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (giftCard.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            giftCard.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            giftCard.org = org;
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
GiftCard recursiveUpsert(GiftCard giftCard, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'GiftCard'} 
        : const {};
    if (giftCard.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        giftCard.org = OrganizationStore.instance.recursiveUpsert(giftCard.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(giftCard);
}

  List<GiftCard> recursiveListUpsert(List<GiftCard> giftCards, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedGiftCards = <GiftCard>[];
    for (var giftCard in giftCards) {
        updatedGiftCards.add(recursiveUpsert(giftCard, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedGiftCards;
}

//   @override
//   GiftCard upsert(GiftCard item) {
//     return recursiveUpsert(item);
//   }

}


class GiftCardInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      GiftCardInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (giftCard) => GiftCardStore.instance
            .getOrg$(giftCard, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (giftCard) => GiftCardStore.instance
            .getOrg(giftCard, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum GiftCardEndpoints implements Endpoint {

    getAll('/giftCard', HttpMethod.post, List<GiftCard>),
	getById('/giftCard/byId/:id', HttpMethod.post, GiftCard),
	getByCode('/giftCard/byCode/:code', HttpMethod.post, GiftCard),
	getManyByOrgId('/giftCard/byOrgId/:orgId', HttpMethod.post, List<GiftCard>),
	getManyByAmount('/giftCard/byAmount/:amount', HttpMethod.post, List<GiftCard>),
	getManyByBalance('/giftCard/byBalance/:balance', HttpMethod.post, List<GiftCard>),
	getManyByCurrency('/giftCard/byCurrency/:currency', HttpMethod.post, List<GiftCard>),
	getManyByExpiresAt('/giftCard/byExpiresAt/:expiresAt', HttpMethod.post, List<GiftCard>),
	getManyByIsActive('/giftCard/byIsActive/:isActive', HttpMethod.post, List<GiftCard>),
	getManyByIssuedTo('/giftCard/byIssuedTo/:issuedTo', HttpMethod.post, List<GiftCard>),
	getManyByIssuedBy('/giftCard/byIssuedBy/:issuedBy', HttpMethod.post, List<GiftCard>),
	getManyByIssuedFor('/giftCard/byIssuedFor/:issuedFor', HttpMethod.post, List<GiftCard>),
	getManyByCreatedAt('/giftCard/byCreatedAt/:createdAt', HttpMethod.post, List<GiftCard>),
	getManyByUpdatedAt('/giftCard/byUpdatedAt/:updatedAt', HttpMethod.post, List<GiftCard>);

    const GiftCardEndpoints(this.path, this.method, this.responseType);

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
