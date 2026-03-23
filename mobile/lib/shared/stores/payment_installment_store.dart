
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PaymentInstallmentStore extends ModelStreamStore<String, PaymentInstallment> {

  static PaymentInstallmentStore? _instance;

  static PaymentInstallmentStore get instance {
    _instance ??= PaymentInstallmentStore();
    return _instance!;
  }

  PaymentInstallmentStore() : super(PaymentInstallment.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PaymentInstallmentStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PaymentInstallmentStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PaymentInstallmentStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPaymentInstallmentId(PaymentInstallment paymentInstallment) => paymentInstallment.id;

	String? getPaymentInstallmentOrgId(PaymentInstallment paymentInstallment) => paymentInstallment.orgId;

	String? getPaymentInstallmentNegotiationId(PaymentInstallment paymentInstallment) => paymentInstallment.negotiationId;

	int? getPaymentInstallmentInstallmentNo(PaymentInstallment paymentInstallment) => paymentInstallment.installmentNo;

	double? getPaymentInstallmentAmount(PaymentInstallment paymentInstallment) => paymentInstallment.amount;

	String? getPaymentInstallmentCurrency(PaymentInstallment paymentInstallment) => paymentInstallment.currency;

	DateTime? getPaymentInstallmentDueDate(PaymentInstallment paymentInstallment) => paymentInstallment.dueDate;

	PaymentStatus? getPaymentInstallmentStatus(PaymentInstallment paymentInstallment) => paymentInstallment.status;

	DateTime? getPaymentInstallmentPaidAt(PaymentInstallment paymentInstallment) => paymentInstallment.paidAt;

	PaymentMethodUS? getPaymentInstallmentPaymentMethod(PaymentInstallment paymentInstallment) => paymentInstallment.paymentMethod;

	String? getPaymentInstallmentReferenceNo(PaymentInstallment paymentInstallment) => paymentInstallment.referenceNo;

	String? getPaymentInstallmentNotes(PaymentInstallment paymentInstallment) => paymentInstallment.notes;

	DateTime? getPaymentInstallmentDeletedAt(PaymentInstallment paymentInstallment) => paymentInstallment.deletedAt;

	DateTime? getPaymentInstallmentCreatedAt(PaymentInstallment paymentInstallment) => paymentInstallment.createdAt;

	DateTime? getPaymentInstallmentUpdatedAt(PaymentInstallment paymentInstallment) => paymentInstallment.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<PaymentInstallment> getByOrgId(
    String orgId,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByNegotiationId(
    String negotiationId,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentNegotiationId, negotiationId, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByInstallmentNo(
    int installmentNo,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentInstallmentNo, installmentNo, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByAmount(
    double amount,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByCurrency(
    String currency,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByDueDate(
    DateTime dueDate,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentDueDate, dueDate, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByStatus(
    PaymentStatus status,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentStatus, status, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByPaidAt(
    DateTime paidAt,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentPaidAt, paidAt, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByPaymentMethod(
    PaymentMethodUS paymentMethod,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentPaymentMethod, paymentMethod, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByReferenceNo(
    String referenceNo,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentReferenceNo, referenceNo, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByNotes(
    String notes,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PaymentInstallment> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentInstallmentUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  PaymentNegotiation? getNegotiation(
    PaymentInstallment paymentInstallment, {ModelFilter? modelFilter, List<PaymentNegotiationInclude>? includes}) {
    if (paymentInstallment.negotiationId == null) {
        return null;
    } else {
        final negotiation = PaymentNegotiationStore.instance.getById(paymentInstallment.negotiationId!, includes: includes);
        paymentInstallment.negotiation = negotiation;
        // setIncludedReferences(negotiation, includes: includes);
        return negotiation;
    }
}

	Organization? getOrg(
    PaymentInstallment paymentInstallment, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (paymentInstallment.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(paymentInstallment.orgId!, includes: includes);
        paymentInstallment.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PaymentInstallment>> getAll$({bool useCache = true, ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PaymentInstallmentEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PaymentInstallment?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPaymentInstallmentId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PaymentInstallment>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentInstallmentOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByNegotiationId$(
        String negotiationId,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentInstallmentNegotiationId,
        value: negotiationId,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByNegotiationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByInstallmentNo$(
        int installmentNo,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPaymentInstallmentInstallmentNo,
        value: installmentNo,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByInstallmentNo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPaymentInstallmentAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentInstallmentCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByDueDate$(
        DateTime dueDate,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentInstallmentDueDate,
        value: dueDate,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByDueDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByStatus$(
        PaymentStatus status,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<PaymentStatus>(
        getPropVal: getPaymentInstallmentStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByPaidAt$(
        DateTime paidAt,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentInstallmentPaidAt,
        value: paidAt,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByPaidAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByPaymentMethod$(
        PaymentMethodUS paymentMethod,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<PaymentMethodUS>(
        getPropVal: getPaymentInstallmentPaymentMethod,
        value: paymentMethod,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByPaymentMethod,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByReferenceNo$(
        String referenceNo,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentInstallmentReferenceNo,
        value: referenceNo,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByReferenceNo,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentInstallmentNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentInstallmentDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentInstallmentCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentInstallment>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PaymentInstallment>? modelFilter,
        List<PaymentInstallmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentInstallmentUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PaymentInstallmentEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<PaymentNegotiation?> getNegotiation$(
    PaymentInstallment paymentInstallment, {bool useCache = true, ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}) {
    if (paymentInstallment.negotiationId == null) {
        return Stream.value(null);
    } else {
        return PaymentNegotiationStore.instance.getById$(
            paymentInstallment.negotiationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((negotiation) {
            paymentInstallment.negotiation = negotiation;
        });
    }
}

	Stream<Organization?> getOrg$(
    PaymentInstallment paymentInstallment, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (paymentInstallment.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            paymentInstallment.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            paymentInstallment.org = org;
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
PaymentInstallment recursiveUpsert(PaymentInstallment paymentInstallment, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PaymentInstallment'} 
        : const {};
    if (paymentInstallment.negotiation != null && (!preventCircularSerialization || !upsertedTypes.contains('PaymentNegotiation'))) {
        paymentInstallment.negotiation = PaymentNegotiationStore.instance.recursiveUpsert(paymentInstallment.negotiation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (paymentInstallment.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        paymentInstallment.org = OrganizationStore.instance.recursiveUpsert(paymentInstallment.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(paymentInstallment);
}

  List<PaymentInstallment> recursiveListUpsert(List<PaymentInstallment> paymentInstallments, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPaymentInstallments = <PaymentInstallment>[];
    for (var paymentInstallment in paymentInstallments) {
        updatedPaymentInstallments.add(recursiveUpsert(paymentInstallment, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPaymentInstallments;
}

//   @override
//   PaymentInstallment upsert(PaymentInstallment item) {
//     return recursiveUpsert(item);
//   }

}


class PaymentInstallmentInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PaymentInstallmentInclude.negotiation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PaymentNegotiation>? modelFilter,
    List<PaymentNegotiationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (paymentInstallment) => PaymentInstallmentStore.instance
            .getNegotiation$(paymentInstallment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (paymentInstallment) => PaymentInstallmentStore.instance
            .getNegotiation(paymentInstallment, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentInstallmentInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (paymentInstallment) => PaymentInstallmentStore.instance
            .getOrg$(paymentInstallment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (paymentInstallment) => PaymentInstallmentStore.instance
            .getOrg(paymentInstallment, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PaymentInstallmentEndpoints implements Endpoint {

    getAll('/paymentInstallment', HttpMethod.post, List<PaymentInstallment>),
	getById('/paymentInstallment/byId/:id', HttpMethod.post, PaymentInstallment),
	getManyByOrgId('/paymentInstallment/byOrgId/:orgId', HttpMethod.post, List<PaymentInstallment>),
	getManyByNegotiationId('/paymentInstallment/byNegotiationId/:negotiationId', HttpMethod.post, List<PaymentInstallment>),
	getManyByInstallmentNo('/paymentInstallment/byInstallmentNo/:installmentNo', HttpMethod.post, List<PaymentInstallment>),
	getManyByAmount('/paymentInstallment/byAmount/:amount', HttpMethod.post, List<PaymentInstallment>),
	getManyByCurrency('/paymentInstallment/byCurrency/:currency', HttpMethod.post, List<PaymentInstallment>),
	getManyByDueDate('/paymentInstallment/byDueDate/:dueDate', HttpMethod.post, List<PaymentInstallment>),
	getManyByStatus('/paymentInstallment/byStatus/:status', HttpMethod.post, List<PaymentInstallment>),
	getManyByPaidAt('/paymentInstallment/byPaidAt/:paidAt', HttpMethod.post, List<PaymentInstallment>),
	getManyByPaymentMethod('/paymentInstallment/byPaymentMethod/:paymentMethod', HttpMethod.post, List<PaymentInstallment>),
	getManyByReferenceNo('/paymentInstallment/byReferenceNo/:referenceNo', HttpMethod.post, List<PaymentInstallment>),
	getManyByNotes('/paymentInstallment/byNotes/:notes', HttpMethod.post, List<PaymentInstallment>),
	getManyByDeletedAt('/paymentInstallment/byDeletedAt/:deletedAt', HttpMethod.post, List<PaymentInstallment>),
	getManyByCreatedAt('/paymentInstallment/byCreatedAt/:createdAt', HttpMethod.post, List<PaymentInstallment>),
	getManyByUpdatedAt('/paymentInstallment/byUpdatedAt/:updatedAt', HttpMethod.post, List<PaymentInstallment>);

    const PaymentInstallmentEndpoints(this.path, this.method, this.responseType);

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
