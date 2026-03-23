
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PaymentNegotiationStore extends ModelStreamStore<String, PaymentNegotiation> {

  static PaymentNegotiationStore? _instance;

  static PaymentNegotiationStore get instance {
    _instance ??= PaymentNegotiationStore();
    return _instance!;
  }

  PaymentNegotiationStore() : super(PaymentNegotiation.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PaymentNegotiationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PaymentNegotiationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PaymentNegotiationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPaymentNegotiationId(PaymentNegotiation paymentNegotiation) => paymentNegotiation.id;

	String? getPaymentNegotiationOrgId(PaymentNegotiation paymentNegotiation) => paymentNegotiation.orgId;

	String? getPaymentNegotiationReservationId(PaymentNegotiation paymentNegotiation) => paymentNegotiation.reservationId;

	String? getPaymentNegotiationTenantContactId(PaymentNegotiation paymentNegotiation) => paymentNegotiation.tenantContactId;

	String? getPaymentNegotiationOwnerContactId(PaymentNegotiation paymentNegotiation) => paymentNegotiation.ownerContactId;

	String? getPaymentNegotiationOwnerUserId(PaymentNegotiation paymentNegotiation) => paymentNegotiation.ownerUserId;

	PaymentNegotiationStatus? getPaymentNegotiationStatus(PaymentNegotiation paymentNegotiation) => paymentNegotiation.status;

	int? getPaymentNegotiationMaxInstallments(PaymentNegotiation paymentNegotiation) => paymentNegotiation.maxInstallments;

	double? getPaymentNegotiationMinFirstPaymentPct(PaymentNegotiation paymentNegotiation) => paymentNegotiation.minFirstPaymentPct;

	bool? getPaymentNegotiationPlatformValidated(PaymentNegotiation paymentNegotiation) => paymentNegotiation.platformValidated;

	String? getPaymentNegotiationValidationNotes(PaymentNegotiation paymentNegotiation) => paymentNegotiation.validationNotes;

	String? getPaymentNegotiationAgreedOfferId(PaymentNegotiation paymentNegotiation) => paymentNegotiation.agreedOfferId;

	DateTime? getPaymentNegotiationAgreedAt(PaymentNegotiation paymentNegotiation) => paymentNegotiation.agreedAt;

	DateTime? getPaymentNegotiationExpiresAt(PaymentNegotiation paymentNegotiation) => paymentNegotiation.expiresAt;

	DateTime? getPaymentNegotiationReminderSentAt(PaymentNegotiation paymentNegotiation) => paymentNegotiation.reminderSentAt;

	DateTime? getPaymentNegotiationCreatedAt(PaymentNegotiation paymentNegotiation) => paymentNegotiation.createdAt;

	DateTime? getPaymentNegotiationUpdatedAt(PaymentNegotiation paymentNegotiation) => paymentNegotiation.updatedAt;

	DateTime? getPaymentNegotiationDeletedAt(PaymentNegotiation paymentNegotiation) => paymentNegotiation.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
PaymentNegotiation? getByReservationId(
    String reservationId,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getIncluding(getPaymentNegotiationReservationId, reservationId, modelFilter: modelFilter, includes: includes);

  
List<PaymentNegotiation> getByOrgId(
    String orgId,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByTenantContactId(
    String tenantContactId,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationTenantContactId, tenantContactId, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByOwnerContactId(
    String ownerContactId,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationOwnerContactId, ownerContactId, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByOwnerUserId(
    String ownerUserId,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationOwnerUserId, ownerUserId, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByStatus(
    PaymentNegotiationStatus status,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationStatus, status, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByMaxInstallments(
    int maxInstallments,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationMaxInstallments, maxInstallments, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByMinFirstPaymentPct(
    double minFirstPaymentPct,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationMinFirstPaymentPct, minFirstPaymentPct, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByPlatformValidated(
    bool platformValidated,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationPlatformValidated, platformValidated, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByValidationNotes(
    String validationNotes,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationValidationNotes, validationNotes, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByAgreedOfferId(
    String agreedOfferId,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationAgreedOfferId, agreedOfferId, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByAgreedAt(
    DateTime agreedAt,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationAgreedAt, agreedAt, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByExpiresAt(
    DateTime expiresAt,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationExpiresAt, expiresAt, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByReminderSentAt(
    DateTime reminderSentAt,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationReminderSentAt, reminderSentAt, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<PaymentNegotiation> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}
    ) =>
    getManyIncluding(getPaymentNegotiationDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    PaymentNegotiation paymentNegotiation, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (paymentNegotiation.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(paymentNegotiation.orgId!, includes: includes);
        paymentNegotiation.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Reservation? getReservation(
    PaymentNegotiation paymentNegotiation, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (paymentNegotiation.reservationId == null) {
        return null;
    } else {
        final reservation = ReservationStore.instance.getById(paymentNegotiation.reservationId!, includes: includes);
        paymentNegotiation.reservation = reservation;
        // setIncludedReferences(reservation, includes: includes);
        return reservation;
    }
}

  /// GET RELATED MODELS 

  List<NegotiationOffer> getOffers(
    PaymentNegotiation paymentNegotiation, {ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}) {
    final offers = NegotiationOfferStore.instance.getByNegotiationId(paymentNegotiation.$uid!, modelFilter: modelFilter, includes: includes);
    paymentNegotiation.offers = offers;
    // setIncludedReferencesForList(offers, includes: includes);
    return offers;
}

	List<PaymentInstallment> getInstallments(
    PaymentNegotiation paymentNegotiation, {ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}) {
    final installments = PaymentInstallmentStore.instance.getByNegotiationId(paymentNegotiation.$uid!, modelFilter: modelFilter, includes: includes);
    paymentNegotiation.installments = installments;
    // setIncludedReferencesForList(installments, includes: includes);
    return installments;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<PaymentNegotiation>> getAll$({bool useCache = true, ModelFilter<PaymentNegotiation>? modelFilter, List<PaymentNegotiationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PaymentNegotiationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<PaymentNegotiation?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPaymentNegotiationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<PaymentNegotiation?> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPaymentNegotiationReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<PaymentNegotiation>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentNegotiationOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByTenantContactId$(
        String tenantContactId,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentNegotiationTenantContactId,
        value: tenantContactId,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByTenantContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByOwnerContactId$(
        String ownerContactId,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentNegotiationOwnerContactId,
        value: ownerContactId,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByOwnerContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByOwnerUserId$(
        String ownerUserId,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentNegotiationOwnerUserId,
        value: ownerUserId,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByOwnerUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByStatus$(
        PaymentNegotiationStatus status,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<PaymentNegotiationStatus>(
        getPropVal: getPaymentNegotiationStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByMaxInstallments$(
        int maxInstallments,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPaymentNegotiationMaxInstallments,
        value: maxInstallments,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByMaxInstallments,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByMinFirstPaymentPct$(
        double minFirstPaymentPct,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPaymentNegotiationMinFirstPaymentPct,
        value: minFirstPaymentPct,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByMinFirstPaymentPct,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByPlatformValidated$(
        bool platformValidated,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPaymentNegotiationPlatformValidated,
        value: platformValidated,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByPlatformValidated,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByValidationNotes$(
        String validationNotes,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentNegotiationValidationNotes,
        value: validationNotes,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByValidationNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByAgreedOfferId$(
        String agreedOfferId,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPaymentNegotiationAgreedOfferId,
        value: agreedOfferId,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByAgreedOfferId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByAgreedAt$(
        DateTime agreedAt,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentNegotiationAgreedAt,
        value: agreedAt,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByAgreedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByExpiresAt$(
        DateTime expiresAt,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentNegotiationExpiresAt,
        value: expiresAt,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByExpiresAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByReminderSentAt$(
        DateTime reminderSentAt,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentNegotiationReminderSentAt,
        value: reminderSentAt,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByReminderSentAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentNegotiationCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentNegotiationUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<PaymentNegotiation>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<PaymentNegotiation>? modelFilter,
        List<PaymentNegotiationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPaymentNegotiationDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PaymentNegotiationEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    PaymentNegotiation paymentNegotiation, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (paymentNegotiation.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            paymentNegotiation.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            paymentNegotiation.org = org;
        });
    }
}

	Stream<Reservation?> getReservation$(
    PaymentNegotiation paymentNegotiation, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (paymentNegotiation.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            paymentNegotiation.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((reservation) {
            paymentNegotiation.reservation = reservation;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<NegotiationOffer>> getOffers$(
    PaymentNegotiation paymentNegotiation, {bool useCache = true, ModelFilter<NegotiationOffer>? modelFilter, List<NegotiationOfferInclude>? includes}) {
    return NegotiationOfferStore.instance.getByNegotiationId$(
        paymentNegotiation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((offers) {
        paymentNegotiation.offers = offers;
    });

}

	Stream<List<PaymentInstallment>> getInstallments$(
    PaymentNegotiation paymentNegotiation, {bool useCache = true, ModelFilter<PaymentInstallment>? modelFilter, List<PaymentInstallmentInclude>? includes}) {
    return PaymentInstallmentStore.instance.getByNegotiationId$(
        paymentNegotiation.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((installments) {
        paymentNegotiation.installments = installments;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
PaymentNegotiation recursiveUpsert(PaymentNegotiation paymentNegotiation, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'PaymentNegotiation'} 
        : const {};
    if (paymentNegotiation.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        paymentNegotiation.org = OrganizationStore.instance.recursiveUpsert(paymentNegotiation.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (paymentNegotiation.reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        paymentNegotiation.reservation = ReservationStore.instance.recursiveUpsert(paymentNegotiation.reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (paymentNegotiation.offers != null && (!preventCircularSerialization || !upsertedTypes.contains('NegotiationOffer'))) {
        paymentNegotiation.offers = NegotiationOfferStore.instance.recursiveListUpsert(paymentNegotiation.offers!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (paymentNegotiation.installments != null && (!preventCircularSerialization || !upsertedTypes.contains('PaymentInstallment'))) {
        paymentNegotiation.installments = PaymentInstallmentStore.instance.recursiveListUpsert(paymentNegotiation.installments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(paymentNegotiation);
}

  List<PaymentNegotiation> recursiveListUpsert(List<PaymentNegotiation> paymentNegotiations, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPaymentNegotiations = <PaymentNegotiation>[];
    for (var paymentNegotiation in paymentNegotiations) {
        updatedPaymentNegotiations.add(recursiveUpsert(paymentNegotiation, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPaymentNegotiations;
}

//   @override
//   PaymentNegotiation upsert(PaymentNegotiation item) {
//     return recursiveUpsert(item);
//   }

}


class PaymentNegotiationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PaymentNegotiationInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (paymentNegotiation) => PaymentNegotiationStore.instance
            .getOrg$(paymentNegotiation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (paymentNegotiation) => PaymentNegotiationStore.instance
            .getOrg(paymentNegotiation, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentNegotiationInclude.reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (paymentNegotiation) => PaymentNegotiationStore.instance
            .getReservation$(paymentNegotiation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (paymentNegotiation) => PaymentNegotiationStore.instance
            .getReservation(paymentNegotiation, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentNegotiationInclude.offers({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<NegotiationOffer>? modelFilter,
    List<NegotiationOfferInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (paymentNegotiation) => PaymentNegotiationStore.instance
            .getOffers$(paymentNegotiation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (paymentNegotiation) => PaymentNegotiationStore.instance
            .getOffers(paymentNegotiation, modelFilter: modelFilter, includes: includes);
      }
}

	PaymentNegotiationInclude.installments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PaymentInstallment>? modelFilter,
    List<PaymentInstallmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (paymentNegotiation) => PaymentNegotiationStore.instance
            .getInstallments$(paymentNegotiation, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (paymentNegotiation) => PaymentNegotiationStore.instance
            .getInstallments(paymentNegotiation, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PaymentNegotiationEndpoints implements Endpoint {

    getAll('/paymentNegotiation', HttpMethod.post, List<PaymentNegotiation>),
	getById('/paymentNegotiation/byId/:id', HttpMethod.post, PaymentNegotiation),
	getManyByOrgId('/paymentNegotiation/byOrgId/:orgId', HttpMethod.post, List<PaymentNegotiation>),
	getByReservationId('/paymentNegotiation/byReservationId/:reservationId', HttpMethod.post, PaymentNegotiation),
	getManyByTenantContactId('/paymentNegotiation/byTenantContactId/:tenantContactId', HttpMethod.post, List<PaymentNegotiation>),
	getManyByOwnerContactId('/paymentNegotiation/byOwnerContactId/:ownerContactId', HttpMethod.post, List<PaymentNegotiation>),
	getManyByOwnerUserId('/paymentNegotiation/byOwnerUserId/:ownerUserId', HttpMethod.post, List<PaymentNegotiation>),
	getManyByStatus('/paymentNegotiation/byStatus/:status', HttpMethod.post, List<PaymentNegotiation>),
	getManyByMaxInstallments('/paymentNegotiation/byMaxInstallments/:maxInstallments', HttpMethod.post, List<PaymentNegotiation>),
	getManyByMinFirstPaymentPct('/paymentNegotiation/byMinFirstPaymentPct/:minFirstPaymentPct', HttpMethod.post, List<PaymentNegotiation>),
	getManyByPlatformValidated('/paymentNegotiation/byPlatformValidated/:platformValidated', HttpMethod.post, List<PaymentNegotiation>),
	getManyByValidationNotes('/paymentNegotiation/byValidationNotes/:validationNotes', HttpMethod.post, List<PaymentNegotiation>),
	getManyByAgreedOfferId('/paymentNegotiation/byAgreedOfferId/:agreedOfferId', HttpMethod.post, List<PaymentNegotiation>),
	getManyByAgreedAt('/paymentNegotiation/byAgreedAt/:agreedAt', HttpMethod.post, List<PaymentNegotiation>),
	getManyByExpiresAt('/paymentNegotiation/byExpiresAt/:expiresAt', HttpMethod.post, List<PaymentNegotiation>),
	getManyByReminderSentAt('/paymentNegotiation/byReminderSentAt/:reminderSentAt', HttpMethod.post, List<PaymentNegotiation>),
	getManyByCreatedAt('/paymentNegotiation/byCreatedAt/:createdAt', HttpMethod.post, List<PaymentNegotiation>),
	getManyByUpdatedAt('/paymentNegotiation/byUpdatedAt/:updatedAt', HttpMethod.post, List<PaymentNegotiation>),
	getManyByDeletedAt('/paymentNegotiation/byDeletedAt/:deletedAt', HttpMethod.post, List<PaymentNegotiation>);

    const PaymentNegotiationEndpoints(this.path, this.method, this.responseType);

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
