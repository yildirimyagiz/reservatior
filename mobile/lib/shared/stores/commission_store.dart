
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class CommissionStore extends ModelStreamStore<String, Commission> {

  static CommissionStore? _instance;

  static CommissionStore get instance {
    _instance ??= CommissionStore();
    return _instance!;
  }

  CommissionStore() : super(Commission.fromJson) {
    if (_instance != null) {
        throw Exception(
            'CommissionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending CommissionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use CommissionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getCommissionId(Commission commission) => commission.id;

	String? getCommissionOrgId(Commission commission) => commission.orgId;

	String? getCommissionListingId(Commission commission) => commission.listingId;

	String? getCommissionLeaseId(Commission commission) => commission.leaseId;

	String? getCommissionBookingId(Commission commission) => commission.bookingId;

	String? getCommissionTransactionId(Commission commission) => commission.transactionId;

	String? getCommissionBeneficiaryUserId(Commission commission) => commission.beneficiaryUserId;

	String? getCommissionBeneficiaryOrgId(Commission commission) => commission.beneficiaryOrgId;

	dynamic? getCommissionRuleData(Commission commission) => commission.ruleData;

	double? getCommissionAmountBase(Commission commission) => commission.amountBase;

	double? getCommissionCommissionAmount(Commission commission) => commission.commissionAmount;

	String? getCommissionCurrency(Commission commission) => commission.currency;

	dynamic? getCommissionRecords(Commission commission) => commission.records;

	DateTime? getCommissionCreatedAt(Commission commission) => commission.createdAt;

	DateTime? getCommissionUpdatedAt(Commission commission) => commission.updatedAt;

	DateTime? getCommissionDeletedAt(Commission commission) => commission.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Commission> getByOrgId(
    String orgId,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByListingId(
    String listingId,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByLeaseId(
    String leaseId,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByBookingId(
    String bookingId,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionBookingId, bookingId, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByTransactionId(
    String transactionId,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionTransactionId, transactionId, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByBeneficiaryUserId(
    String beneficiaryUserId,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionBeneficiaryUserId, beneficiaryUserId, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByBeneficiaryOrgId(
    String beneficiaryOrgId,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionBeneficiaryOrgId, beneficiaryOrgId, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByRuleData(
    dynamic ruleData,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRuleData, ruleData, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByAmountBase(
    double amountBase,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionAmountBase, amountBase, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByCommissionAmount(
    double commissionAmount,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionCommissionAmount, commissionAmount, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByCurrency(
    String currency,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByRecords(
    dynamic records,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionRecords, records, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Commission> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}
    ) =>
    getManyIncluding(getCommissionDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Commission commission, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (commission.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(commission.orgId!, includes: includes);
        commission.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<Payout> getPayouts(
    Commission commission, {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}) {
    final payouts = PayoutStore.instance.getByCommissionId(commission.$uid!, modelFilter: modelFilter, includes: includes);
    commission.payouts = payouts;
    // setIncludedReferencesForList(payouts, includes: includes);
    return payouts;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Commission>> getAll$({bool useCache = true, ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: CommissionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Commission?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getCommissionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Commission>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommissionOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommissionListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommissionLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByBookingId$(
        String bookingId,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommissionBookingId,
        value: bookingId,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByBookingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByTransactionId$(
        String transactionId,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommissionTransactionId,
        value: transactionId,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByTransactionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByBeneficiaryUserId$(
        String beneficiaryUserId,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommissionBeneficiaryUserId,
        value: beneficiaryUserId,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByBeneficiaryUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByBeneficiaryOrgId$(
        String beneficiaryOrgId,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommissionBeneficiaryOrgId,
        value: beneficiaryOrgId,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByBeneficiaryOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByRuleData$(
        dynamic ruleData,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getCommissionRuleData,
        value: ruleData,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByRuleData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByAmountBase$(
        double amountBase,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getCommissionAmountBase,
        value: amountBase,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByAmountBase,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByCommissionAmount$(
        double commissionAmount,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getCommissionCommissionAmount,
        value: commissionAmount,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByCommissionAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getCommissionCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByRecords$(
        dynamic records,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getCommissionRecords,
        value: records,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByRecords,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommissionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommissionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Commission>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Commission>? modelFilter,
        List<CommissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getCommissionDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: CommissionEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Commission commission, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (commission.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            commission.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            commission.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Payout>> getPayouts$(
    Commission commission, {bool useCache = true, ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}) {
    return PayoutStore.instance.getByCommissionId$(
        commission.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((payouts) {
        commission.payouts = payouts;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Commission recursiveUpsert(Commission commission, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Commission'} 
        : const {};
    if (commission.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        commission.org = OrganizationStore.instance.recursiveUpsert(commission.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (commission.payouts != null && (!preventCircularSerialization || !upsertedTypes.contains('Payout'))) {
        commission.payouts = PayoutStore.instance.recursiveListUpsert(commission.payouts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(commission);
}

  List<Commission> recursiveListUpsert(List<Commission> commissions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedCommissions = <Commission>[];
    for (var commission in commissions) {
        updatedCommissions.add(recursiveUpsert(commission, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedCommissions;
}

//   @override
//   Commission upsert(Commission item) {
//     return recursiveUpsert(item);
//   }

}


class CommissionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      CommissionInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (commission) => CommissionStore.instance
            .getOrg$(commission, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (commission) => CommissionStore.instance
            .getOrg(commission, modelFilter: modelFilter, includes: includes);
      }
}

	CommissionInclude.payouts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Payout>? modelFilter,
    List<PayoutInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (commission) => CommissionStore.instance
            .getPayouts$(commission, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (commission) => CommissionStore.instance
            .getPayouts(commission, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum CommissionEndpoints implements Endpoint {

    getAll('/commission', HttpMethod.post, List<Commission>),
	getById('/commission/byId/:id', HttpMethod.post, Commission),
	getManyByOrgId('/commission/byOrgId/:orgId', HttpMethod.post, List<Commission>),
	getManyByListingId('/commission/byListingId/:listingId', HttpMethod.post, List<Commission>),
	getManyByLeaseId('/commission/byLeaseId/:leaseId', HttpMethod.post, List<Commission>),
	getManyByBookingId('/commission/byBookingId/:bookingId', HttpMethod.post, List<Commission>),
	getManyByTransactionId('/commission/byTransactionId/:transactionId', HttpMethod.post, List<Commission>),
	getManyByBeneficiaryUserId('/commission/byBeneficiaryUserId/:beneficiaryUserId', HttpMethod.post, List<Commission>),
	getManyByBeneficiaryOrgId('/commission/byBeneficiaryOrgId/:beneficiaryOrgId', HttpMethod.post, List<Commission>),
	getManyByRuleData('/commission/byRuleData/:ruleData', HttpMethod.post, List<Commission>),
	getManyByAmountBase('/commission/byAmountBase/:amountBase', HttpMethod.post, List<Commission>),
	getManyByCommissionAmount('/commission/byCommissionAmount/:commissionAmount', HttpMethod.post, List<Commission>),
	getManyByCurrency('/commission/byCurrency/:currency', HttpMethod.post, List<Commission>),
	getManyByRecords('/commission/byRecords/:records', HttpMethod.post, List<Commission>),
	getManyByCreatedAt('/commission/byCreatedAt/:createdAt', HttpMethod.post, List<Commission>),
	getManyByUpdatedAt('/commission/byUpdatedAt/:updatedAt', HttpMethod.post, List<Commission>),
	getManyByDeletedAt('/commission/byDeletedAt/:deletedAt', HttpMethod.post, List<Commission>);

    const CommissionEndpoints(this.path, this.method, this.responseType);

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
