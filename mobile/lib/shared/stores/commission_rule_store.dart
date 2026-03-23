
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class CommissionRuleStore extends ModelStreamStore<String, CommissionRule> {

  static CommissionRuleStore? _instance;

  static CommissionRuleStore get instance {
    _instance ??= CommissionRuleStore();
    return _instance!;
  }

  CommissionRuleStore() : super(CommissionRule.fromJson) {
    if (_instance != null) {
        throw Exception(
            'CommissionRuleStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending CommissionRuleStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use CommissionRuleStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getCommissionRuleId(CommissionRule commissionRule) => commissionRule.id;

	String? getCommissionRuleProviderId(CommissionRule commissionRule) => commissionRule.providerId;

	CommissionRuleType? getCommissionRuleRuleType(CommissionRule commissionRule) => commissionRule.ruleType;

	DateTime? getCommissionRuleStartDate(CommissionRule commissionRule) => commissionRule.startDate;

	DateTime? getCommissionRuleEndDate(CommissionRule commissionRule) => commissionRule.endDate;

	double? getCommissionRuleCommission(CommissionRule commissionRule) => commissionRule.commission;

	int? getCommissionRuleMinVolume(CommissionRule commissionRule) => commissionRule.minVolume;

	int? getCommissionRuleMaxVolume(CommissionRule commissionRule) => commissionRule.maxVolume;

	dynamic? getCommissionRuleConditions(CommissionRule commissionRule) => commissionRule.conditions;

	DateTime? getCommissionRuleCreatedAt(CommissionRule commissionRule) => commissionRule.createdAt;

	DateTime? getCommissionRuleUpdatedAt(CommissionRule commissionRule) => commissionRule.updatedAt;

	DateTime? getCommissionRuleDeletedAt(CommissionRule commissionRule) => commissionRule.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<CommissionRule> getByProviderId(
    String providerId,
    {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleProviderId, providerId, modelFilter: modelFilter, includes: includes);

	
List<CommissionRule> getByRuleType(
    CommissionRuleType ruleType,
    {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleRuleType, ruleType, modelFilter: modelFilter, includes: includes);

	
List<CommissionRule> getByStartDate(
    DateTime startDate,
    {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleStartDate, startDate, modelFilter: modelFilter, includes: includes);

	
List<CommissionRule> getByEndDate(
    DateTime endDate,
    {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleEndDate, endDate, modelFilter: modelFilter, includes: includes);

	
List<CommissionRule> getByCommission(
    double commission,
    {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleCommission, commission, modelFilter: modelFilter, includes: includes);

	
List<CommissionRule> getByMinVolume(
    int minVolume,
    {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleMinVolume, minVolume, modelFilter: modelFilter, includes: includes);

	
List<CommissionRule> getByMaxVolume(
    int maxVolume,
    {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleMaxVolume, maxVolume, modelFilter: modelFilter, includes: includes);

	
List<CommissionRule> getByConditions(
    dynamic conditions,
    {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleConditions, conditions, modelFilter: modelFilter, includes: includes);

	
List<CommissionRule> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<CommissionRule> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<CommissionRule> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  ReferenceSource? getProvider(
    CommissionRule commissionRule, {ModelFilter? modelFilter, List<ReferenceSourceInclude>? includes}) {
    if (commissionRule.providerId == null) {
        return null;
    } else {
        final provider = ReferenceSourceStore.instance.getById(commissionRule.providerId!, includes: includes);
        commissionRule.provider = provider;
        // setIncludedReferences(provider, includes: includes);
        return provider;
    }
}

  /// GET RELATED MODELS 

  List<Payment> getPayment(
    CommissionRule commissionRule, {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    final Payment = PaymentStore.instance.getByCommissionRuleId(commissionRule.$uid!, modelFilter: modelFilter, includes: includes);
    commissionRule.Payment = Payment;
    // setIncludedReferencesForList(Payment, includes: includes);
    return Payment;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<CommissionRule>> getAll$({bool useCache = true, ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: CommissionRuleEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<CommissionRule?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getCommissionRuleId,
        value: id,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<CommissionRule>> getByProviderId$(
        String providerId,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommissionRuleProviderId,
        value: providerId,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getManyByProviderId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommissionRule>> getByRuleType$(
        CommissionRuleType ruleType,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<CommissionRuleType>(
        getPropVal: getCommissionRuleRuleType,
        value: ruleType,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getManyByRuleType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommissionRule>> getByStartDate$(
        DateTime startDate,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommissionRuleStartDate,
        value: startDate,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getManyByStartDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommissionRule>> getByEndDate$(
        DateTime endDate,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommissionRuleEndDate,
        value: endDate,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getManyByEndDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommissionRule>> getByCommission$(
        double commission,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getCommissionRuleCommission,
        value: commission,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getManyByCommission,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommissionRule>> getByMinVolume$(
        int minVolume,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getCommissionRuleMinVolume,
        value: minVolume,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getManyByMinVolume,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommissionRule>> getByMaxVolume$(
        int maxVolume,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getCommissionRuleMaxVolume,
        value: maxVolume,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getManyByMaxVolume,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommissionRule>> getByConditions$(
        dynamic conditions,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getCommissionRuleConditions,
        value: conditions,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getManyByConditions,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommissionRule>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommissionRuleCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommissionRule>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommissionRuleUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<CommissionRule>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<CommissionRule>? modelFilter,
        List<CommissionRuleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommissionRuleDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: CommissionRuleEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<ReferenceSource?> getProvider$(
    CommissionRule commissionRule, {bool useCache = true, ModelFilter<ReferenceSource>? modelFilter, List<ReferenceSourceInclude>? includes}) {
    if (commissionRule.providerId == null) {
        return Stream.value(null);
    } else {
        return ReferenceSourceStore.instance.getById$(
            commissionRule.providerId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((provider) {
            commissionRule.provider = provider;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Payment>> getPayment$(
    CommissionRule commissionRule, {bool useCache = true, ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    return PaymentStore.instance.getByCommissionRuleId$(
        commissionRule.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((Payment) {
        commissionRule.Payment = Payment;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
CommissionRule recursiveUpsert(CommissionRule commissionRule, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'CommissionRule'} 
        : const {};
    if (commissionRule.provider != null && (!preventCircularSerialization || !upsertedTypes.contains('ReferenceSource'))) {
        commissionRule.provider = ReferenceSourceStore.instance.recursiveUpsert(commissionRule.provider!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (commissionRule.Payment != null && (!preventCircularSerialization || !upsertedTypes.contains('Payment'))) {
        commissionRule.Payment = PaymentStore.instance.recursiveListUpsert(commissionRule.Payment!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(commissionRule);
}

  List<CommissionRule> recursiveListUpsert(List<CommissionRule> commissionRules, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedCommissionRules = <CommissionRule>[];
    for (var commissionRule in commissionRules) {
        updatedCommissionRules.add(recursiveUpsert(commissionRule, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedCommissionRules;
}

//   @override
//   CommissionRule upsert(CommissionRule item) {
//     return recursiveUpsert(item);
//   }

}


class CommissionRuleInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      CommissionRuleInclude.provider({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ReferenceSource>? modelFilter,
    List<ReferenceSourceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (commissionRule) => CommissionRuleStore.instance
            .getProvider$(commissionRule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (commissionRule) => CommissionRuleStore.instance
            .getProvider(commissionRule, modelFilter: modelFilter, includes: includes);
      }
}

	CommissionRuleInclude.Payment({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payment>? modelFilter,
    List<PaymentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (commissionRule) => CommissionRuleStore.instance
            .getPayment$(commissionRule, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (commissionRule) => CommissionRuleStore.instance
            .getPayment(commissionRule, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum CommissionRuleEndpoints implements Endpoint {

    getAll('/commissionRule', HttpMethod.post, List<CommissionRule>),
	getById('/commissionRule/byId/:id', HttpMethod.post, CommissionRule),
	getManyByProviderId('/commissionRule/byProviderId/:providerId', HttpMethod.post, List<CommissionRule>),
	getManyByRuleType('/commissionRule/byRuleType/:ruleType', HttpMethod.post, List<CommissionRule>),
	getManyByStartDate('/commissionRule/byStartDate/:startDate', HttpMethod.post, List<CommissionRule>),
	getManyByEndDate('/commissionRule/byEndDate/:endDate', HttpMethod.post, List<CommissionRule>),
	getManyByCommission('/commissionRule/byCommission/:commission', HttpMethod.post, List<CommissionRule>),
	getManyByMinVolume('/commissionRule/byMinVolume/:minVolume', HttpMethod.post, List<CommissionRule>),
	getManyByMaxVolume('/commissionRule/byMaxVolume/:maxVolume', HttpMethod.post, List<CommissionRule>),
	getManyByConditions('/commissionRule/byConditions/:conditions', HttpMethod.post, List<CommissionRule>),
	getManyByCreatedAt('/commissionRule/byCreatedAt/:createdAt', HttpMethod.post, List<CommissionRule>),
	getManyByUpdatedAt('/commissionRule/byUpdatedAt/:updatedAt', HttpMethod.post, List<CommissionRule>),
	getManyByDeletedAt('/commissionRule/byDeletedAt/:deletedAt', HttpMethod.post, List<CommissionRule>);

    const CommissionRuleEndpoints(this.path, this.method, this.responseType);

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
