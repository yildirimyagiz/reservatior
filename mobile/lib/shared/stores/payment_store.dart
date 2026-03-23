
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PaymentStore extends ModelStreamStore<String, Payment> {

  static PaymentStore? _instance;

  static PaymentStore get instance {
    _instance ??= PaymentStore();
    return _instance!;
  }

  PaymentStore() : super(Payment.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PaymentStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PaymentStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PaymentStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPaymentId(Payment payment) => payment.id;

	String? getPaymentTenantId(Payment payment) => payment.tenantId;

	String? getPaymentLeaseId(Payment payment) => payment.leaseId;

	double? getPaymentAmount(Payment payment) => payment.amount;

	String? getPaymentType(Payment payment) => payment.type;

	String? getPaymentCurrencyId(Payment payment) => payment.currencyId;

	DateTime? getPaymentPaymentDate(Payment payment) => payment.paymentDate;

	DateTime? getPaymentDueDate(Payment payment) => payment.dueDate;

	PaymentStatus? getPaymentStatus(Payment payment) => payment.status;

	String? getPaymentPaymentMethod(Payment payment) => payment.paymentMethod;

	String? getPaymentReference(Payment payment) => payment.reference;

	String? getPaymentNotes(Payment payment) => payment.notes;

	DateTime? getPaymentCreatedAt(Payment payment) => payment.createdAt;

	DateTime? getPaymentUpdatedAt(Payment payment) => payment.updatedAt;

	DateTime? getPaymentDeletedAt(Payment payment) => payment.deletedAt;

	String? getPaymentStripePaymentIntentId(Payment payment) => payment.stripePaymentIntentId;

	String? getPaymentStripePaymentMethodId(Payment payment) => payment.stripePaymentMethodId;

	String? getPaymentStripeClientSecret(Payment payment) => payment.stripeClientSecret;

	String? getPaymentStripeStatus(Payment payment) => payment.stripeStatus;

	String? getPaymentStripeError(Payment payment) => payment.stripeError;

	String? getPaymentPropertyId(Payment payment) => payment.propertyId;

	String? getPaymentExpenseId(Payment payment) => payment.expenseId;

	String? getPaymentReservationId(Payment payment) => payment.reservationId;

	String? getPaymentSubscriptionId(Payment payment) => payment.subscriptionId;

	String? getPaymentCommissionRuleId(Payment payment) => payment.commissionRuleId;

	String? getPaymentIncludedServiceId(Payment payment) => payment.includedServiceId;

	String? getPaymentExtraChargeId(Payment payment) => payment.extraChargeId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Payment? getByStripePaymentIntentId(
    String stripePaymentIntentId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getIncluding(getPaymentStripePaymentIntentId, stripePaymentIntentId, modelFilter: modelFilter, includes: includes);

  
List<Payment> getByTenantId(
    String tenantId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentTenantId, tenantId, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByLeaseId(
    String leaseId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByAmount(
    double amount,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByType(
    String type,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentType, type, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByCurrencyId(
    String currencyId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentCurrencyId, currencyId, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByPaymentDate(
    DateTime paymentDate,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentPaymentDate, paymentDate, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByDueDate(
    DateTime dueDate,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentDueDate, dueDate, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByStatus(
    PaymentStatus status,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByPaymentMethod(
    String paymentMethod,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentPaymentMethod, paymentMethod, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByReference(
    String reference,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentReference, reference, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByNotes(
    String notes,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByStripePaymentMethodId(
    String stripePaymentMethodId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentStripePaymentMethodId, stripePaymentMethodId, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByStripeClientSecret(
    String stripeClientSecret,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentStripeClientSecret, stripeClientSecret, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByStripeStatus(
    String stripeStatus,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentStripeStatus, stripeStatus, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByStripeError(
    String stripeError,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentStripeError, stripeError, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByPropertyId(
    String propertyId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByExpenseId(
    String expenseId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentExpenseId, expenseId, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByReservationId(
    String reservationId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentReservationId, reservationId, modelFilter: modelFilter, includes: includes);

	
List<Payment> getBySubscriptionId(
    String subscriptionId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentSubscriptionId, subscriptionId, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByCommissionRuleId(
    String commissionRuleId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentCommissionRuleId, commissionRuleId, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByIncludedServiceId(
    String includedServiceId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentIncludedServiceId, includedServiceId, modelFilter: modelFilter, includes: includes);

	
List<Payment> getByExtraChargeId(
    String extraChargeId,
    {ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}
    ) =>
    getManyIncluding(getPaymentExtraChargeId, extraChargeId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  CommissionRule? getCommissionRule(
    Payment payment, {ModelFilter? modelFilter, List<CommissionRuleInclude>? includes}) {
    if (payment.commissionRuleId == null) {
        return null;
    } else {
        final CommissionRule = CommissionRuleStore.instance.getById(payment.commissionRuleId!, includes: includes);
        payment.CommissionRule = CommissionRule;
        // setIncludedReferences(CommissionRule, includes: includes);
        return CommissionRule;
    }
}

	Currency? getCurrency(
    Payment payment, {ModelFilter? modelFilter, List<CurrencyInclude>? includes}) {
    if (payment.currencyId == null) {
        return null;
    } else {
        final Currency = CurrencyStore.instance.getById(payment.currencyId!, includes: includes);
        payment.Currency = Currency;
        // setIncludedReferences(Currency, includes: includes);
        return Currency;
    }
}

	Expense? getExpense(
    Payment payment, {ModelFilter? modelFilter, List<ExpenseInclude>? includes}) {
    if (payment.expenseId == null) {
        return null;
    } else {
        final Expense = ExpenseStore.instance.getById(payment.expenseId!, includes: includes);
        payment.Expense = Expense;
        // setIncludedReferences(Expense, includes: includes);
        return Expense;
    }
}

	ExtraCharge? getExtraCharge(
    Payment payment, {ModelFilter? modelFilter, List<ExtraChargeInclude>? includes}) {
    if (payment.extraChargeId == null) {
        return null;
    } else {
        final ExtraCharge = ExtraChargeStore.instance.getById(payment.extraChargeId!, includes: includes);
        payment.ExtraCharge = ExtraCharge;
        // setIncludedReferences(ExtraCharge, includes: includes);
        return ExtraCharge;
    }
}

	IncludedService? getIncludedService(
    Payment payment, {ModelFilter? modelFilter, List<IncludedServiceInclude>? includes}) {
    if (payment.includedServiceId == null) {
        return null;
    } else {
        final IncludedService = IncludedServiceStore.instance.getById(payment.includedServiceId!, includes: includes);
        payment.IncludedService = IncludedService;
        // setIncludedReferences(IncludedService, includes: includes);
        return IncludedService;
    }
}

	Lease? getLease(
    Payment payment, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (payment.leaseId == null) {
        return null;
    } else {
        final Lease = LeaseStore.instance.getById(payment.leaseId!, includes: includes);
        payment.Lease = Lease;
        // setIncludedReferences(Lease, includes: includes);
        return Lease;
    }
}

	Property? getProperty(
    Payment payment, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (payment.propertyId == null) {
        return null;
    } else {
        final Property = PropertyStore.instance.getById(payment.propertyId!, includes: includes);
        payment.Property = Property;
        // setIncludedReferences(Property, includes: includes);
        return Property;
    }
}

	Reservation? getReservation(
    Payment payment, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (payment.reservationId == null) {
        return null;
    } else {
        final Reservation = ReservationStore.instance.getById(payment.reservationId!, includes: includes);
        payment.Reservation = Reservation;
        // setIncludedReferences(Reservation, includes: includes);
        return Reservation;
    }
}

	Subscription? getSubscription(
    Payment payment, {ModelFilter? modelFilter, List<SubscriptionInclude>? includes}) {
    if (payment.subscriptionId == null) {
        return null;
    } else {
        final Subscription = SubscriptionStore.instance.getById(payment.subscriptionId!, includes: includes);
        payment.Subscription = Subscription;
        // setIncludedReferences(Subscription, includes: includes);
        return Subscription;
    }
}

	Tenant? getTenant(
    Payment payment, {ModelFilter? modelFilter, List<TenantInclude>? includes}) {
    if (payment.tenantId == null) {
        return null;
    } else {
        final Tenant = TenantStore.instance.getById(payment.tenantId!, includes: includes);
        payment.Tenant = Tenant;
        // setIncludedReferences(Tenant, includes: includes);
        return Tenant;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Payment>> getAll$({bool useCache = true, ModelFilter<Payment>? modelFilter, List<PaymentInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PaymentEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Payment?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPaymentId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Payment?> getByStripePaymentIntentId$(
        String stripePaymentIntentId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPaymentStripePaymentIntentId,
        value: stripePaymentIntentId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getByStripePaymentIntentId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Payment>> getByTenantId$(
        String tenantId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentTenantId,
        value: tenantId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByTenantId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPaymentAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByType$(
        String type,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentType,
        value: type,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByCurrencyId$(
        String currencyId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentCurrencyId,
        value: currencyId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByCurrencyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByPaymentDate$(
        DateTime paymentDate,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentPaymentDate,
        value: paymentDate,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByPaymentDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByDueDate$(
        DateTime dueDate,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentDueDate,
        value: dueDate,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByDueDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByStatus$(
        PaymentStatus status,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<PaymentStatus>(
        getPropVal: getPaymentStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByPaymentMethod$(
        String paymentMethod,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentPaymentMethod,
        value: paymentMethod,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByPaymentMethod,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByReference$(
        String reference,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentReference,
        value: reference,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByReference,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByStripePaymentMethodId$(
        String stripePaymentMethodId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentStripePaymentMethodId,
        value: stripePaymentMethodId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByStripePaymentMethodId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByStripeClientSecret$(
        String stripeClientSecret,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentStripeClientSecret,
        value: stripeClientSecret,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByStripeClientSecret,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByStripeStatus$(
        String stripeStatus,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentStripeStatus,
        value: stripeStatus,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByStripeStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByStripeError$(
        String stripeError,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentStripeError,
        value: stripeError,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByStripeError,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByExpenseId$(
        String expenseId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentExpenseId,
        value: expenseId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByExpenseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getBySubscriptionId$(
        String subscriptionId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentSubscriptionId,
        value: subscriptionId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyBySubscriptionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByCommissionRuleId$(
        String commissionRuleId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentCommissionRuleId,
        value: commissionRuleId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByCommissionRuleId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByIncludedServiceId$(
        String includedServiceId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentIncludedServiceId,
        value: includedServiceId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByIncludedServiceId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payment>> getByExtraChargeId$(
        String extraChargeId,
        {bool useCache = true,
        ModelFilter<Payment>? modelFilter,
        List<PaymentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentExtraChargeId,
        value: extraChargeId,
        modelFilter: modelFilter,
        endpoint: PaymentEndpoints.getManyByExtraChargeId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<CommissionRule?> getCommissionRule$(
    Payment payment, {bool useCache = true, ModelFilter<CommissionRule>? modelFilter, List<CommissionRuleInclude>? includes}) {
    if (payment.commissionRuleId == null) {
        return Stream.value(null);
    } else {
        return CommissionRuleStore.instance.getById$(
            payment.commissionRuleId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((CommissionRule) {
            payment.CommissionRule = CommissionRule;
        });
    }
}

	Stream<Currency?> getCurrency$(
    Payment payment, {bool useCache = true, ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    if (payment.currencyId == null) {
        return Stream.value(null);
    } else {
        return CurrencyStore.instance.getById$(
            payment.currencyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Currency) {
            payment.Currency = Currency;
        });
    }
}

	Stream<Expense?> getExpense$(
    Payment payment, {bool useCache = true, ModelFilter<Expense>? modelFilter, List<ExpenseInclude>? includes}) {
    if (payment.expenseId == null) {
        return Stream.value(null);
    } else {
        return ExpenseStore.instance.getById$(
            payment.expenseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Expense) {
            payment.Expense = Expense;
        });
    }
}

	Stream<ExtraCharge?> getExtraCharge$(
    Payment payment, {bool useCache = true, ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    if (payment.extraChargeId == null) {
        return Stream.value(null);
    } else {
        return ExtraChargeStore.instance.getById$(
            payment.extraChargeId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((ExtraCharge) {
            payment.ExtraCharge = ExtraCharge;
        });
    }
}

	Stream<IncludedService?> getIncludedService$(
    Payment payment, {bool useCache = true, ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    if (payment.includedServiceId == null) {
        return Stream.value(null);
    } else {
        return IncludedServiceStore.instance.getById$(
            payment.includedServiceId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((IncludedService) {
            payment.IncludedService = IncludedService;
        });
    }
}

	Stream<Lease?> getLease$(
    Payment payment, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (payment.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            payment.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Lease) {
            payment.Lease = Lease;
        });
    }
}

	Stream<Property?> getProperty$(
    Payment payment, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (payment.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            payment.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Property) {
            payment.Property = Property;
        });
    }
}

	Stream<Reservation?> getReservation$(
    Payment payment, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (payment.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            payment.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Reservation) {
            payment.Reservation = Reservation;
        });
    }
}

	Stream<Subscription?> getSubscription$(
    Payment payment, {bool useCache = true, ModelFilter<Subscription>? modelFilter, List<SubscriptionInclude>? includes}) {
    if (payment.subscriptionId == null) {
        return Stream.value(null);
    } else {
        return SubscriptionStore.instance.getById$(
            payment.subscriptionId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Subscription) {
            payment.Subscription = Subscription;
        });
    }
}

	Stream<Tenant?> getTenant$(
    Payment payment, {bool useCache = true, ModelFilter<Tenant>? modelFilter, List<TenantInclude>? includes}) {
    if (payment.tenantId == null) {
        return Stream.value(null);
    } else {
        return TenantStore.instance.getById$(
            payment.tenantId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((Tenant) {
            payment.Tenant = Tenant;
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
Payment recursiveUpsert(Payment payment, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Payment'} 
        : const {};
    if (payment.CommissionRule != null && (!preventCircularSerialization || !upsertedTypes.contains('CommissionRule'))) {
        payment.CommissionRule = CommissionRuleStore.instance.recursiveUpsert(payment.CommissionRule!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payment.Currency != null && (!preventCircularSerialization || !upsertedTypes.contains('Currency'))) {
        payment.Currency = CurrencyStore.instance.recursiveUpsert(payment.Currency!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payment.Expense != null && (!preventCircularSerialization || !upsertedTypes.contains('Expense'))) {
        payment.Expense = ExpenseStore.instance.recursiveUpsert(payment.Expense!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payment.ExtraCharge != null && (!preventCircularSerialization || !upsertedTypes.contains('ExtraCharge'))) {
        payment.ExtraCharge = ExtraChargeStore.instance.recursiveUpsert(payment.ExtraCharge!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payment.IncludedService != null && (!preventCircularSerialization || !upsertedTypes.contains('IncludedService'))) {
        payment.IncludedService = IncludedServiceStore.instance.recursiveUpsert(payment.IncludedService!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payment.Lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        payment.Lease = LeaseStore.instance.recursiveUpsert(payment.Lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payment.Property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        payment.Property = PropertyStore.instance.recursiveUpsert(payment.Property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payment.Reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        payment.Reservation = ReservationStore.instance.recursiveUpsert(payment.Reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payment.Subscription != null && (!preventCircularSerialization || !upsertedTypes.contains('Subscription'))) {
        payment.Subscription = SubscriptionStore.instance.recursiveUpsert(payment.Subscription!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payment.Tenant != null && (!preventCircularSerialization || !upsertedTypes.contains('Tenant'))) {
        payment.Tenant = TenantStore.instance.recursiveUpsert(payment.Tenant!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(payment);
}

  List<Payment> recursiveListUpsert(List<Payment> payments, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPayments = <Payment>[];
    for (var payment in payments) {
        updatedPayments.add(recursiveUpsert(payment, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPayments;
}

//   @override
//   Payment upsert(Payment item) {
//     return recursiveUpsert(item);
//   }

}


class PaymentInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PaymentInclude.CommissionRule({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<CommissionRule>? modelFilter,
    List<CommissionRuleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payment) => PaymentStore.instance
            .getCommissionRule$(payment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payment) => PaymentStore.instance
            .getCommissionRule(payment, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentInclude.Currency({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Currency>? modelFilter,
    List<CurrencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payment) => PaymentStore.instance
            .getCurrency$(payment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payment) => PaymentStore.instance
            .getCurrency(payment, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentInclude.Expense({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Expense>? modelFilter,
    List<ExpenseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payment) => PaymentStore.instance
            .getExpense$(payment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payment) => PaymentStore.instance
            .getExpense(payment, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentInclude.ExtraCharge({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExtraCharge>? modelFilter,
    List<ExtraChargeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payment) => PaymentStore.instance
            .getExtraCharge$(payment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payment) => PaymentStore.instance
            .getExtraCharge(payment, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentInclude.IncludedService({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<IncludedService>? modelFilter,
    List<IncludedServiceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payment) => PaymentStore.instance
            .getIncludedService$(payment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payment) => PaymentStore.instance
            .getIncludedService(payment, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentInclude.Lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payment) => PaymentStore.instance
            .getLease$(payment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payment) => PaymentStore.instance
            .getLease(payment, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentInclude.Property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payment) => PaymentStore.instance
            .getProperty$(payment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payment) => PaymentStore.instance
            .getProperty(payment, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentInclude.Reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payment) => PaymentStore.instance
            .getReservation$(payment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payment) => PaymentStore.instance
            .getReservation(payment, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentInclude.Subscription({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Subscription>? modelFilter,
    List<SubscriptionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payment) => PaymentStore.instance
            .getSubscription$(payment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payment) => PaymentStore.instance
            .getSubscription(payment, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentInclude.Tenant({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tenant>? modelFilter,
    List<TenantInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payment) => PaymentStore.instance
            .getTenant$(payment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payment) => PaymentStore.instance
            .getTenant(payment, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PaymentEndpoints implements Endpoint {

    getAll('/payment', HttpMethod.post, List<Payment>),
	getById('/payment/byId/:id', HttpMethod.post, Payment),
	getManyByTenantId('/payment/byTenantId/:tenantId', HttpMethod.post, List<Payment>),
	getManyByLeaseId('/payment/byLeaseId/:leaseId', HttpMethod.post, List<Payment>),
	getManyByAmount('/payment/byAmount/:amount', HttpMethod.post, List<Payment>),
	getManyByType('/payment/byType/:type', HttpMethod.post, List<Payment>),
	getManyByCurrencyId('/payment/byCurrencyId/:currencyId', HttpMethod.post, List<Payment>),
	getManyByPaymentDate('/payment/byPaymentDate/:paymentDate', HttpMethod.post, List<Payment>),
	getManyByDueDate('/payment/byDueDate/:dueDate', HttpMethod.post, List<Payment>),
	getManyByStatus('/payment/byStatus/:status', HttpMethod.post, List<Payment>),
	getManyByPaymentMethod('/payment/byPaymentMethod/:paymentMethod', HttpMethod.post, List<Payment>),
	getManyByReference('/payment/byReference/:reference', HttpMethod.post, List<Payment>),
	getManyByNotes('/payment/byNotes/:notes', HttpMethod.post, List<Payment>),
	getManyByCreatedAt('/payment/byCreatedAt/:createdAt', HttpMethod.post, List<Payment>),
	getManyByUpdatedAt('/payment/byUpdatedAt/:updatedAt', HttpMethod.post, List<Payment>),
	getManyByDeletedAt('/payment/byDeletedAt/:deletedAt', HttpMethod.post, List<Payment>),
	getByStripePaymentIntentId('/payment/byStripePaymentIntentId/:stripePaymentIntentId', HttpMethod.post, Payment),
	getManyByStripePaymentMethodId('/payment/byStripePaymentMethodId/:stripePaymentMethodId', HttpMethod.post, List<Payment>),
	getManyByStripeClientSecret('/payment/byStripeClientSecret/:stripeClientSecret', HttpMethod.post, List<Payment>),
	getManyByStripeStatus('/payment/byStripeStatus/:stripeStatus', HttpMethod.post, List<Payment>),
	getManyByStripeError('/payment/byStripeError/:stripeError', HttpMethod.post, List<Payment>),
	getManyByPropertyId('/payment/byPropertyId/:propertyId', HttpMethod.post, List<Payment>),
	getManyByExpenseId('/payment/byExpenseId/:expenseId', HttpMethod.post, List<Payment>),
	getManyByReservationId('/payment/byReservationId/:reservationId', HttpMethod.post, List<Payment>),
	getManyBySubscriptionId('/payment/bySubscriptionId/:subscriptionId', HttpMethod.post, List<Payment>),
	getManyByCommissionRuleId('/payment/byCommissionRuleId/:commissionRuleId', HttpMethod.post, List<Payment>),
	getManyByIncludedServiceId('/payment/byIncludedServiceId/:includedServiceId', HttpMethod.post, List<Payment>),
	getManyByExtraChargeId('/payment/byExtraChargeId/:extraChargeId', HttpMethod.post, List<Payment>);

    const PaymentEndpoints(this.path, this.method, this.responseType);

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
