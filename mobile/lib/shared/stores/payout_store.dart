
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PayoutStore extends ModelStreamStore<String, Payout> {

  static PayoutStore? _instance;

  static PayoutStore get instance {
    _instance ??= PayoutStore();
    return _instance!;
  }

  PayoutStore() : super(Payout.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PayoutStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PayoutStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PayoutStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPayoutId(Payout payout) => payout.id;

	String? getPayoutOrgId(Payout payout) => payout.orgId;

	String? getPayoutDealId(Payout payout) => payout.dealId;

	String? getPayoutCommissionId(Payout payout) => payout.commissionId;

	String? getPayoutRecipientId(Payout payout) => payout.recipientId;

	String? getPayoutProcessorId(Payout payout) => payout.processorId;

	PayoutStatusUSA? getPayoutPayoutStatus(Payout payout) => payout.payoutStatus;

	CommissionTypeUS? getPayoutPayoutType(Payout payout) => payout.payoutType;

	double? getPayoutAmount(Payout payout) => payout.amount;

	double? getPayoutGrossAmount(Payout payout) => payout.grossAmount;

	double? getPayoutNetAmount(Payout payout) => payout.netAmount;

	double? getPayoutTaxWithheld(Payout payout) => payout.taxWithheld;

	double? getPayoutFees(Payout payout) => payout.fees;

	PaymentMethodUS? getPayoutPaymentMethod(Payout payout) => payout.paymentMethod;

	DateTime? getPayoutScheduledDate(Payout payout) => payout.scheduledDate;

	DateTime? getPayoutProcessedDate(Payout payout) => payout.processedDate;

	DateTime? getPayoutCompletedDate(Payout payout) => payout.completedDate;

	String? getPayoutReferenceNumber(Payout payout) => payout.referenceNumber;

	String? getPayoutTrackingNumber(Payout payout) => payout.trackingNumber;

	dynamic? getPayoutBankAccount(Payout payout) => payout.bankAccount;

	String? getPayoutCheckNumber(Payout payout) => payout.checkNumber;

	String? getPayoutWireReference(Payout payout) => payout.wireReference;

	String? getPayoutAchRouting(Payout payout) => payout.achRouting;

	DateTime? getPayoutEscrowReleaseDate(Payout payout) => payout.escrowReleaseDate;

	String? getPayoutHoldReason(Payout payout) => payout.holdReason;

	String? getPayoutFailureReason(Payout payout) => payout.failureReason;

	int? getPayoutRetryCount(Payout payout) => payout.retryCount;

	int? getPayoutMaxRetries(Payout payout) => payout.maxRetries;

	DateTime? getPayoutNextRetryDate(Payout payout) => payout.nextRetryDate;

	String? getPayoutPriority(Payout payout) => payout.priority;

	bool? getPayoutApprovalRequired(Payout payout) => payout.approvalRequired;

	String? getPayoutApprovedBy(Payout payout) => payout.approvedBy;

	DateTime? getPayoutApprovedAt(Payout payout) => payout.approvedAt;

	String? getPayoutNotes(Payout payout) => payout.notes;

	bool? getPayoutTaxFormGenerated(Payout payout) => payout.taxFormGenerated;

	bool? getPayoutTaxFormSent(Payout payout) => payout.taxFormSent;

	bool? getPayoutYearEndReport(Payout payout) => payout.yearEndReport;

	String? getPayoutCreatedBy(Payout payout) => payout.createdBy;

	DateTime? getPayoutCreatedAt(Payout payout) => payout.createdAt;

	DateTime? getPayoutUpdatedAt(Payout payout) => payout.updatedAt;

	DateTime? getPayoutDeletedAt(Payout payout) => payout.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Payout> getByOrgId(
    String orgId,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByDealId(
    String dealId,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutDealId, dealId, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByCommissionId(
    String commissionId,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutCommissionId, commissionId, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByRecipientId(
    String recipientId,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutRecipientId, recipientId, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByProcessorId(
    String processorId,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutProcessorId, processorId, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByPayoutStatus(
    PayoutStatusUSA payoutStatus,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutPayoutStatus, payoutStatus, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByPayoutType(
    CommissionTypeUS payoutType,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutPayoutType, payoutType, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByAmount(
    double amount,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutAmount, amount, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByGrossAmount(
    double grossAmount,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutGrossAmount, grossAmount, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByNetAmount(
    double netAmount,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutNetAmount, netAmount, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByTaxWithheld(
    double taxWithheld,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutTaxWithheld, taxWithheld, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByFees(
    double fees,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutFees, fees, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByPaymentMethod(
    PaymentMethodUS paymentMethod,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutPaymentMethod, paymentMethod, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByScheduledDate(
    DateTime scheduledDate,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutScheduledDate, scheduledDate, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByProcessedDate(
    DateTime processedDate,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutProcessedDate, processedDate, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByCompletedDate(
    DateTime completedDate,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutCompletedDate, completedDate, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByReferenceNumber(
    String referenceNumber,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutReferenceNumber, referenceNumber, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByTrackingNumber(
    String trackingNumber,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutTrackingNumber, trackingNumber, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByBankAccount(
    dynamic bankAccount,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutBankAccount, bankAccount, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByCheckNumber(
    String checkNumber,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutCheckNumber, checkNumber, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByWireReference(
    String wireReference,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutWireReference, wireReference, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByAchRouting(
    String achRouting,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutAchRouting, achRouting, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByEscrowReleaseDate(
    DateTime escrowReleaseDate,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutEscrowReleaseDate, escrowReleaseDate, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByHoldReason(
    String holdReason,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutHoldReason, holdReason, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByFailureReason(
    String failureReason,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutFailureReason, failureReason, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByRetryCount(
    int retryCount,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutRetryCount, retryCount, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByMaxRetries(
    int maxRetries,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutMaxRetries, maxRetries, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByNextRetryDate(
    DateTime nextRetryDate,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutNextRetryDate, nextRetryDate, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByPriority(
    String priority,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutPriority, priority, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByApprovalRequired(
    bool approvalRequired,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutApprovalRequired, approvalRequired, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByApprovedBy(
    String approvedBy,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutApprovedBy, approvedBy, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByApprovedAt(
    DateTime approvedAt,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutApprovedAt, approvedAt, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByNotes(
    String notes,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByTaxFormGenerated(
    bool taxFormGenerated,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutTaxFormGenerated, taxFormGenerated, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByTaxFormSent(
    bool taxFormSent,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutTaxFormSent, taxFormSent, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByYearEndReport(
    bool yearEndReport,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutYearEndReport, yearEndReport, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByCreatedBy(
    String createdBy,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Payout> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}
    ) =>
    getManyIncluding(getPayoutDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Commission? getCommission(
    Payout payout, {ModelFilter? modelFilter, List<CommissionInclude>? includes}) {
    if (payout.commissionId == null) {
        return null;
    } else {
        final commission = CommissionStore.instance.getById(payout.commissionId!, includes: includes);
        payout.commission = commission;
        // setIncludedReferences(commission, includes: includes);
        return commission;
    }
}

	Deal? getDeal(
    Payout payout, {ModelFilter? modelFilter, List<DealInclude>? includes}) {
    if (payout.dealId == null) {
        return null;
    } else {
        final deal = DealStore.instance.getById(payout.dealId!, includes: includes);
        payout.deal = deal;
        // setIncludedReferences(deal, includes: includes);
        return deal;
    }
}

	Organization? getOrg(
    Payout payout, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (payout.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(payout.orgId!, includes: includes);
        payout.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Contact? getProcessor(
    Payout payout, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (payout.processorId == null) {
        return null;
    } else {
        final processor = ContactStore.instance.getById(payout.processorId!, includes: includes);
        payout.processor = processor;
        // setIncludedReferences(processor, includes: includes);
        return processor;
    }
}

	Contact? getRecipient(
    Payout payout, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (payout.recipientId == null) {
        return null;
    } else {
        final recipient = ContactStore.instance.getById(payout.recipientId!, includes: includes);
        payout.recipient = recipient;
        // setIncludedReferences(recipient, includes: includes);
        return recipient;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Payout>> getAll$({bool useCache = true, ModelFilter<Payout>? modelFilter, List<PayoutInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PayoutEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Payout?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPayoutId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Payout>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByDealId$(
        String dealId,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutDealId,
        value: dealId,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByDealId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByCommissionId$(
        String commissionId,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutCommissionId,
        value: commissionId,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByCommissionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByRecipientId$(
        String recipientId,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutRecipientId,
        value: recipientId,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByRecipientId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByProcessorId$(
        String processorId,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutProcessorId,
        value: processorId,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByProcessorId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByPayoutStatus$(
        PayoutStatusUSA payoutStatus,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<PayoutStatusUSA>(
        getPropVal: getPayoutPayoutStatus,
        value: payoutStatus,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByPayoutStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByPayoutType$(
        CommissionTypeUS payoutType,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<CommissionTypeUS>(
        getPropVal: getPayoutPayoutType,
        value: payoutType,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByPayoutType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByAmount$(
        double amount,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPayoutAmount,
        value: amount,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByGrossAmount$(
        double grossAmount,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPayoutGrossAmount,
        value: grossAmount,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByGrossAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByNetAmount$(
        double netAmount,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPayoutNetAmount,
        value: netAmount,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByNetAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByTaxWithheld$(
        double taxWithheld,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPayoutTaxWithheld,
        value: taxWithheld,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByTaxWithheld,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByFees$(
        double fees,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getPayoutFees,
        value: fees,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByFees,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByPaymentMethod$(
        PaymentMethodUS paymentMethod,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<PaymentMethodUS>(
        getPropVal: getPayoutPaymentMethod,
        value: paymentMethod,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByPaymentMethod,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByScheduledDate$(
        DateTime scheduledDate,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPayoutScheduledDate,
        value: scheduledDate,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByScheduledDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByProcessedDate$(
        DateTime processedDate,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPayoutProcessedDate,
        value: processedDate,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByProcessedDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByCompletedDate$(
        DateTime completedDate,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPayoutCompletedDate,
        value: completedDate,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByCompletedDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByReferenceNumber$(
        String referenceNumber,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutReferenceNumber,
        value: referenceNumber,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByReferenceNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByTrackingNumber$(
        String trackingNumber,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutTrackingNumber,
        value: trackingNumber,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByTrackingNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByBankAccount$(
        dynamic bankAccount,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getPayoutBankAccount,
        value: bankAccount,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByBankAccount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByCheckNumber$(
        String checkNumber,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutCheckNumber,
        value: checkNumber,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByCheckNumber,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByWireReference$(
        String wireReference,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutWireReference,
        value: wireReference,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByWireReference,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByAchRouting$(
        String achRouting,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutAchRouting,
        value: achRouting,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByAchRouting,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByEscrowReleaseDate$(
        DateTime escrowReleaseDate,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPayoutEscrowReleaseDate,
        value: escrowReleaseDate,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByEscrowReleaseDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByHoldReason$(
        String holdReason,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutHoldReason,
        value: holdReason,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByHoldReason,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByFailureReason$(
        String failureReason,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutFailureReason,
        value: failureReason,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByFailureReason,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByRetryCount$(
        int retryCount,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPayoutRetryCount,
        value: retryCount,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByRetryCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByMaxRetries$(
        int maxRetries,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getPayoutMaxRetries,
        value: maxRetries,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByMaxRetries,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByNextRetryDate$(
        DateTime nextRetryDate,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPayoutNextRetryDate,
        value: nextRetryDate,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByNextRetryDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByPriority$(
        String priority,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutPriority,
        value: priority,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByPriority,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByApprovalRequired$(
        bool approvalRequired,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPayoutApprovalRequired,
        value: approvalRequired,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByApprovalRequired,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByApprovedBy$(
        String approvedBy,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutApprovedBy,
        value: approvedBy,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByApprovedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByApprovedAt$(
        DateTime approvedAt,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPayoutApprovedAt,
        value: approvedAt,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByApprovedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByTaxFormGenerated$(
        bool taxFormGenerated,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPayoutTaxFormGenerated,
        value: taxFormGenerated,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByTaxFormGenerated,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByTaxFormSent$(
        bool taxFormSent,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPayoutTaxFormSent,
        value: taxFormSent,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByTaxFormSent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByYearEndReport$(
        bool yearEndReport,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getPayoutYearEndReport,
        value: yearEndReport,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByYearEndReport,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPayoutCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPayoutCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPayoutUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Payout>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Payout>? modelFilter,
        List<PayoutInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPayoutDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PayoutEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Commission?> getCommission$(
    Payout payout, {bool useCache = true, ModelFilter<Commission>? modelFilter, List<CommissionInclude>? includes}) {
    if (payout.commissionId == null) {
        return Stream.value(null);
    } else {
        return CommissionStore.instance.getById$(
            payout.commissionId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((commission) {
            payout.commission = commission;
        });
    }
}

	Stream<Deal?> getDeal$(
    Payout payout, {bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    if (payout.dealId == null) {
        return Stream.value(null);
    } else {
        return DealStore.instance.getById$(
            payout.dealId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((deal) {
            payout.deal = deal;
        });
    }
}

	Stream<Organization?> getOrg$(
    Payout payout, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (payout.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            payout.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            payout.org = org;
        });
    }
}

	Stream<Contact?> getProcessor$(
    Payout payout, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (payout.processorId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            payout.processorId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((processor) {
            payout.processor = processor;
        });
    }
}

	Stream<Contact?> getRecipient$(
    Payout payout, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (payout.recipientId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            payout.recipientId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((recipient) {
            payout.recipient = recipient;
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
Payout recursiveUpsert(Payout payout, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Payout'} 
        : const {};
    if (payout.commission != null && (!preventCircularSerialization || !upsertedTypes.contains('Commission'))) {
        payout.commission = CommissionStore.instance.recursiveUpsert(payout.commission!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payout.deal != null && (!preventCircularSerialization || !upsertedTypes.contains('Deal'))) {
        payout.deal = DealStore.instance.recursiveUpsert(payout.deal!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payout.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        payout.org = OrganizationStore.instance.recursiveUpsert(payout.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payout.processor != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        payout.processor = ContactStore.instance.recursiveUpsert(payout.processor!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (payout.recipient != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        payout.recipient = ContactStore.instance.recursiveUpsert(payout.recipient!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(payout);
}

  List<Payout> recursiveListUpsert(List<Payout> payouts, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPayouts = <Payout>[];
    for (var payout in payouts) {
        updatedPayouts.add(recursiveUpsert(payout, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPayouts;
}

//   @override
//   Payout upsert(Payout item) {
//     return recursiveUpsert(item);
//   }

}


class PayoutInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PayoutInclude.commission({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Commission>? modelFilter,
    List<CommissionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payout) => PayoutStore.instance
            .getCommission$(payout, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payout) => PayoutStore.instance
            .getCommission(payout, modelFilter: modelFilter, includes: includes);
      }
}

	PayoutInclude.deal({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Deal>? modelFilter,
    List<DealInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payout) => PayoutStore.instance
            .getDeal$(payout, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payout) => PayoutStore.instance
            .getDeal(payout, modelFilter: modelFilter, includes: includes);
      }
}

	PayoutInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payout) => PayoutStore.instance
            .getOrg$(payout, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payout) => PayoutStore.instance
            .getOrg(payout, modelFilter: modelFilter, includes: includes);
      }
}

	PayoutInclude.processor({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payout) => PayoutStore.instance
            .getProcessor$(payout, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payout) => PayoutStore.instance
            .getProcessor(payout, modelFilter: modelFilter, includes: includes);
      }
}

	PayoutInclude.recipient({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (payout) => PayoutStore.instance
            .getRecipient$(payout, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (payout) => PayoutStore.instance
            .getRecipient(payout, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PayoutEndpoints implements Endpoint {

    getAll('/payout', HttpMethod.post, List<Payout>),
	getById('/payout/byId/:id', HttpMethod.post, Payout),
	getManyByOrgId('/payout/byOrgId/:orgId', HttpMethod.post, List<Payout>),
	getManyByDealId('/payout/byDealId/:dealId', HttpMethod.post, List<Payout>),
	getManyByCommissionId('/payout/byCommissionId/:commissionId', HttpMethod.post, List<Payout>),
	getManyByRecipientId('/payout/byRecipientId/:recipientId', HttpMethod.post, List<Payout>),
	getManyByProcessorId('/payout/byProcessorId/:processorId', HttpMethod.post, List<Payout>),
	getManyByPayoutStatus('/payout/byPayoutStatus/:payoutStatus', HttpMethod.post, List<Payout>),
	getManyByPayoutType('/payout/byPayoutType/:payoutType', HttpMethod.post, List<Payout>),
	getManyByAmount('/payout/byAmount/:amount', HttpMethod.post, List<Payout>),
	getManyByGrossAmount('/payout/byGrossAmount/:grossAmount', HttpMethod.post, List<Payout>),
	getManyByNetAmount('/payout/byNetAmount/:netAmount', HttpMethod.post, List<Payout>),
	getManyByTaxWithheld('/payout/byTaxWithheld/:taxWithheld', HttpMethod.post, List<Payout>),
	getManyByFees('/payout/byFees/:fees', HttpMethod.post, List<Payout>),
	getManyByPaymentMethod('/payout/byPaymentMethod/:paymentMethod', HttpMethod.post, List<Payout>),
	getManyByScheduledDate('/payout/byScheduledDate/:scheduledDate', HttpMethod.post, List<Payout>),
	getManyByProcessedDate('/payout/byProcessedDate/:processedDate', HttpMethod.post, List<Payout>),
	getManyByCompletedDate('/payout/byCompletedDate/:completedDate', HttpMethod.post, List<Payout>),
	getManyByReferenceNumber('/payout/byReferenceNumber/:referenceNumber', HttpMethod.post, List<Payout>),
	getManyByTrackingNumber('/payout/byTrackingNumber/:trackingNumber', HttpMethod.post, List<Payout>),
	getManyByBankAccount('/payout/byBankAccount/:bankAccount', HttpMethod.post, List<Payout>),
	getManyByCheckNumber('/payout/byCheckNumber/:checkNumber', HttpMethod.post, List<Payout>),
	getManyByWireReference('/payout/byWireReference/:wireReference', HttpMethod.post, List<Payout>),
	getManyByAchRouting('/payout/byAchRouting/:achRouting', HttpMethod.post, List<Payout>),
	getManyByEscrowReleaseDate('/payout/byEscrowReleaseDate/:escrowReleaseDate', HttpMethod.post, List<Payout>),
	getManyByHoldReason('/payout/byHoldReason/:holdReason', HttpMethod.post, List<Payout>),
	getManyByFailureReason('/payout/byFailureReason/:failureReason', HttpMethod.post, List<Payout>),
	getManyByRetryCount('/payout/byRetryCount/:retryCount', HttpMethod.post, List<Payout>),
	getManyByMaxRetries('/payout/byMaxRetries/:maxRetries', HttpMethod.post, List<Payout>),
	getManyByNextRetryDate('/payout/byNextRetryDate/:nextRetryDate', HttpMethod.post, List<Payout>),
	getManyByPriority('/payout/byPriority/:priority', HttpMethod.post, List<Payout>),
	getManyByApprovalRequired('/payout/byApprovalRequired/:approvalRequired', HttpMethod.post, List<Payout>),
	getManyByApprovedBy('/payout/byApprovedBy/:approvedBy', HttpMethod.post, List<Payout>),
	getManyByApprovedAt('/payout/byApprovedAt/:approvedAt', HttpMethod.post, List<Payout>),
	getManyByNotes('/payout/byNotes/:notes', HttpMethod.post, List<Payout>),
	getManyByTaxFormGenerated('/payout/byTaxFormGenerated/:taxFormGenerated', HttpMethod.post, List<Payout>),
	getManyByTaxFormSent('/payout/byTaxFormSent/:taxFormSent', HttpMethod.post, List<Payout>),
	getManyByYearEndReport('/payout/byYearEndReport/:yearEndReport', HttpMethod.post, List<Payout>),
	getManyByCreatedBy('/payout/byCreatedBy/:createdBy', HttpMethod.post, List<Payout>),
	getManyByCreatedAt('/payout/byCreatedAt/:createdAt', HttpMethod.post, List<Payout>),
	getManyByUpdatedAt('/payout/byUpdatedAt/:updatedAt', HttpMethod.post, List<Payout>),
	getManyByDeletedAt('/payout/byDeletedAt/:deletedAt', HttpMethod.post, List<Payout>);

    const PayoutEndpoints(this.path, this.method, this.responseType);

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
