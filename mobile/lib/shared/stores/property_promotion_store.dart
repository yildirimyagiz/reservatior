
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PropertyPromotionStore extends ModelStreamStore<String, PropertyPromotion> {

  static PropertyPromotionStore? _instance;

  static PropertyPromotionStore get instance {
    _instance ??= PropertyPromotionStore();
    return _instance!;
  }

  PropertyPromotionStore() : super(PropertyPromotion.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PropertyPromotionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PropertyPromotionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PropertyPromotionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPropertyPromotionId(PropertyPromotion propertyPromotion) => propertyPromotion.id;

	String? getPropertyPromotionPropertyId(PropertyPromotion propertyPromotion) => propertyPromotion.propertyId;

	String? getPropertyPromotionAgencyId(PropertyPromotion propertyPromotion) => propertyPromotion.agencyId;

	String? getPropertyPromotionAgentId(PropertyPromotion propertyPromotion) => propertyPromotion.agentId;

	PropertyPromotionType? getPropertyPromotionPromotionType(PropertyPromotion propertyPromotion) => propertyPromotion.promotionType;

	PropertyPromotionStatus? getPropertyPromotionStatus(PropertyPromotion propertyPromotion) => propertyPromotion.status;

	DateTime? getPropertyPromotionStartDate(PropertyPromotion propertyPromotion) => propertyPromotion.startDate;

	DateTime? getPropertyPromotionEndDate(PropertyPromotion propertyPromotion) => propertyPromotion.endDate;

	double? getPropertyPromotionPrice(PropertyPromotion propertyPromotion) => propertyPromotion.price;

	String? getPropertyPromotionCurrency(PropertyPromotion propertyPromotion) => propertyPromotion.currency;

	bool? getPropertyPromotionIsAutoRenew(PropertyPromotion propertyPromotion) => propertyPromotion.isAutoRenew;

	List<String>? getPropertyPromotionFeatures(PropertyPromotion propertyPromotion) => propertyPromotion.features;

	String? getPropertyPromotionPaymentHistoryId(PropertyPromotion propertyPromotion) => propertyPromotion.paymentHistoryId;

	String? getPropertyPromotionUserId(PropertyPromotion propertyPromotion) => propertyPromotion.userId;

	DateTime? getPropertyPromotionCreatedAt(PropertyPromotion propertyPromotion) => propertyPromotion.createdAt;

	DateTime? getPropertyPromotionUpdatedAt(PropertyPromotion propertyPromotion) => propertyPromotion.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PropertyPromotion> getByPropertyId(
    String propertyId,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByAgencyId(
    String agencyId,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionAgencyId, agencyId, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByAgentId(
    String agentId,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionAgentId, agentId, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByPromotionType(
    PropertyPromotionType promotionType,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionPromotionType, promotionType, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByStatus(
    PropertyPromotionStatus status,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionStatus, status, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByStartDate(
    DateTime startDate,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByEndDate(
    DateTime endDate,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByPrice(
    double price,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionPrice, price, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByCurrency(
    String currency,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByIsAutoRenew(
    bool isAutoRenew,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionIsAutoRenew, isAutoRenew, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByFeatures(
    String features,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionFeatures, features, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByPaymentHistoryId(
    String paymentHistoryId,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionPaymentHistoryId, paymentHistoryId, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByUserId(
    String userId,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PropertyPromotion> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}
    ) =>
    getManyIncluding(getPropertyPromotionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Property? getProperty(
    PropertyPromotion propertyPromotion, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyPromotion.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(propertyPromotion.propertyId!, includes: includes);
        propertyPromotion.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

	Agency? getAgency(
    PropertyPromotion propertyPromotion, {ModelFilter? modelFilter, List<AgencyInclude>? includes}) {
    if (propertyPromotion.agencyId == null) {
        return null;
    } else {
        final Agency = AgencyStore.instance.getById(propertyPromotion.agencyId!, includes: includes);
        propertyPromotion.Agency = Agency;
        // setIncludedReferences(Agency, includes: includes);
        return Agency;
    }
}

	Agent? getAgent(
    PropertyPromotion propertyPromotion, {ModelFilter? modelFilter, List<AgentInclude>? includes}) {
    if (propertyPromotion.agentId == null) {
        return null;
    } else {
        final Agent = AgentStore.instance.getById(propertyPromotion.agentId!, includes: includes);
        propertyPromotion.Agent = Agent;
        // setIncludedReferences(Agent, includes: includes);
        return Agent;
    }
}

	User? getUser(
    PropertyPromotion propertyPromotion, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (propertyPromotion.userId == null) {
        return null;
    } else {
        final User = UserStore.instance.getById(propertyPromotion.userId!, includes: includes);
        propertyPromotion.User = User;
        // setIncludedReferences(User, includes: includes);
        return User;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PropertyPromotion>> getAll$({bool useCache = true, ModelFilter<PropertyPromotion>? modelFilter, List<PropertyPromotionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PropertyPromotionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PropertyPromotion?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPropertyPromotionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PropertyPromotion>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPromotionPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByAgencyId$(
        String agencyId,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPromotionAgencyId,
        value: agencyId,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByAgencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByAgentId$(
        String agentId,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPromotionAgentId,
        value: agentId,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByAgentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByPromotionType$(
        PropertyPromotionType promotionType,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<PropertyPromotionType>(
        getPropVal: getPropertyPromotionPromotionType,
        value: promotionType,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByPromotionType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByStatus$(
        PropertyPromotionStatus status,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<PropertyPromotionStatus>(
        getPropVal: getPropertyPromotionStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyPromotionStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyPromotionEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByPrice$(
        double price,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPropertyPromotionPrice,
        value: price,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByPrice,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPromotionCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByIsAutoRenew$(
        bool isAutoRenew,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPropertyPromotionIsAutoRenew,
        value: isAutoRenew,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByIsAutoRenew,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByFeatures$(
        String features,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPromotionFeatures,
        value: features,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByFeatures,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByPaymentHistoryId$(
        String paymentHistoryId,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPromotionPaymentHistoryId,
        value: paymentHistoryId,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByPaymentHistoryId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPropertyPromotionUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyPromotionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PropertyPromotion>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PropertyPromotion>? modelFilter,
        List<PropertyPromotionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPropertyPromotionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PropertyPromotionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Property?> getProperty$(
    PropertyPromotion propertyPromotion, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (propertyPromotion.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            propertyPromotion.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            propertyPromotion.Property = Property;
        });
    }
}

	Stream<Agency?> getAgency$(
    PropertyPromotion propertyPromotion, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    if (propertyPromotion.agencyId == null) {
        return Stream.value(null);
    } else {
        return AgencyStore.instance.getById$(
            propertyPromotion.agencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agency) {
            propertyPromotion.Agency = Agency;
        });
    }
}

	Stream<Agent?> getAgent$(
    PropertyPromotion propertyPromotion, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    if (propertyPromotion.agentId == null) {
        return Stream.value(null);
    } else {
        return AgentStore.instance.getById$(
            propertyPromotion.agentId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Agent) {
            propertyPromotion.Agent = Agent;
        });
    }
}

	Stream<User?> getUser$(
    PropertyPromotion propertyPromotion, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (propertyPromotion.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            propertyPromotion.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((User) {
            propertyPromotion.User = User;
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
PropertyPromotion recursiveUpsert(PropertyPromotion propertyPromotion, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PropertyPromotion'} 
        : const {};
    if (propertyPromotion.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        propertyPromotion.Property = PropertyStore.instance.recursiveUpsert(propertyPromotion.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyPromotion.Agency != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        propertyPromotion.Agency = AgencyStore.instance.recursiveUpsert(propertyPromotion.Agency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyPromotion.Agent != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        propertyPromotion.Agent = AgentStore.instance.recursiveUpsert(propertyPromotion.Agent!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (propertyPromotion.User != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        propertyPromotion.User = UserStore.instance.recursiveUpsert(propertyPromotion.User!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(propertyPromotion);
}

  List<PropertyPromotion> recursiveListUpsert(List<PropertyPromotion> propertyPromotions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPropertyPromotions = <PropertyPromotion>[];
    for (var propertyPromotion in propertyPromotions) {
        updatedPropertyPromotions.add(recursiveUpsert(propertyPromotion, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPropertyPromotions;
}

//   @override
//   PropertyPromotion upsert(PropertyPromotion item) {
//     return recursiveUpsert(item);
//   }

}


class PropertyPromotionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PropertyPromotionInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyPromotion) => PropertyPromotionStore.instance
            .getProperty$(propertyPromotion, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyPromotion) => PropertyPromotionStore.instance
            .getProperty(propertyPromotion, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyPromotionInclude.Agency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyPromotion) => PropertyPromotionStore.instance
            .getAgency$(propertyPromotion, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyPromotion) => PropertyPromotionStore.instance
            .getAgency(propertyPromotion, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyPromotionInclude.Agent({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyPromotion) => PropertyPromotionStore.instance
            .getAgent$(propertyPromotion, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyPromotion) => PropertyPromotionStore.instance
            .getAgent(propertyPromotion, modelFilter: modelFilter, includes: includes);
      }
}

	PropertyPromotionInclude.User({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (propertyPromotion) => PropertyPromotionStore.instance
            .getUser$(propertyPromotion, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (propertyPromotion) => PropertyPromotionStore.instance
            .getUser(propertyPromotion, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PropertyPromotionEndpoints implements Endpoint {

    getAll('/propertyPromotion', HttpMethod.post, List<PropertyPromotion>),
	getById('/propertyPromotion/byId/:id', HttpMethod.post, PropertyPromotion),
	getManyByPropertyId('/propertyPromotion/byPropertyId/:propertyId', HttpMethod.post, List<PropertyPromotion>),
	getManyByAgencyId('/propertyPromotion/byAgencyId/:agencyId', HttpMethod.post, List<PropertyPromotion>),
	getManyByAgentId('/propertyPromotion/byAgentId/:agentId', HttpMethod.post, List<PropertyPromotion>),
	getManyByPromotionType('/propertyPromotion/byPromotionType/:promotionType', HttpMethod.post, List<PropertyPromotion>),
	getManyByStatus('/propertyPromotion/byStatus/:status', HttpMethod.post, List<PropertyPromotion>),
	getManyByStartDate('/propertyPromotion/byStartDate/:startDate', HttpMethod.post, List<PropertyPromotion>),
	getManyByEndDate('/propertyPromotion/byEndDate/:endDate', HttpMethod.post, List<PropertyPromotion>),
	getManyByPrice('/propertyPromotion/byPrice/:price', HttpMethod.post, List<PropertyPromotion>),
	getManyByCurrency('/propertyPromotion/byCurrency/:currency', HttpMethod.post, List<PropertyPromotion>),
	getManyByIsAutoRenew('/propertyPromotion/byIsAutoRenew/:isAutoRenew', HttpMethod.post, List<PropertyPromotion>),
	getManyByFeatures('/propertyPromotion/byFeatures/:features', HttpMethod.post, List<PropertyPromotion>),
	getManyByPaymentHistoryId('/propertyPromotion/byPaymentHistoryId/:paymentHistoryId', HttpMethod.post, List<PropertyPromotion>),
	getManyByUserId('/propertyPromotion/byUserId/:userId', HttpMethod.post, List<PropertyPromotion>),
	getManyByCreatedAt('/propertyPromotion/byCreatedAt/:createdAt', HttpMethod.post, List<PropertyPromotion>),
	getManyByUpdatedAt('/propertyPromotion/byUpdatedAt/:updatedAt', HttpMethod.post, List<PropertyPromotion>);

    const PropertyPromotionEndpoints(this.path, this.method, this.responseType);

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
