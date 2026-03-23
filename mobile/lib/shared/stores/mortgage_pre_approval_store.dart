
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class MortgagePreApprovalStore extends ModelStreamStore<String, MortgagePreApproval> {

  static MortgagePreApprovalStore? _instance;

  static MortgagePreApprovalStore get instance {
    _instance ??= MortgagePreApprovalStore();
    return _instance!;
  }

  MortgagePreApprovalStore() : super(MortgagePreApproval.fromJson) {
    if (_instance != null) {
        throw Exception(
            'MortgagePreApprovalStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending MortgagePreApprovalStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use MortgagePreApprovalStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getMortgagePreApprovalId(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.id;

	String? getMortgagePreApprovalOrgId(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.orgId;

	String? getMortgagePreApprovalDealId(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.dealId;

	String? getMortgagePreApprovalContactId(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.contactId;

	String? getMortgagePreApprovalLenderName(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.lenderName;

	String? getMortgagePreApprovalMortgageType(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.mortgageType;

	int? getMortgagePreApprovalMortgageTerm(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.mortgageTerm;

	double? getMortgagePreApprovalInterestRate(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.interestRate;

	double? getMortgagePreApprovalArrangementFee(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.arrangementFee;

	double? getMortgagePreApprovalValuationFee(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.valuationFee;

	double? getMortgagePreApprovalLoanAmount(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.loanAmount;

	double? getMortgagePreApprovalDepositAmount(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.depositAmount;

	double? getMortgagePreApprovalLoanToValue(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.loanToValue;

	double? getMortgagePreApprovalMonthlyPayment(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.monthlyPayment;

	double? getMortgagePreApprovalTotalPayable(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.totalPayable;

	String? getMortgagePreApprovalOfferStatus(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.offerStatus;

	DateTime? getMortgagePreApprovalOfferDate(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.offerDate;

	DateTime? getMortgagePreApprovalExpiryDate(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.expiryDate;

	DateTime? getMortgagePreApprovalAcceptedDate(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.acceptedDate;

	String? getMortgagePreApprovalSolicitorName(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.solicitorName;

	String? getMortgagePreApprovalSolicitorEmail(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.solicitorEmail;

	DateTime? getMortgagePreApprovalCreatedAt(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.createdAt;

	DateTime? getMortgagePreApprovalUpdatedAt(MortgagePreApproval mortgagePreApproval) => mortgagePreApproval.updatedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<MortgagePreApproval> getByOrgId(
    String orgId,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByDealId(
    String dealId,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalDealId, dealId, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByContactId(
    String contactId,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByLenderName(
    String lenderName,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalLenderName, lenderName, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByMortgageType(
    String mortgageType,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalMortgageType, mortgageType, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByMortgageTerm(
    int mortgageTerm,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalMortgageTerm, mortgageTerm, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByInterestRate(
    double interestRate,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalInterestRate, interestRate, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByArrangementFee(
    double arrangementFee,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalArrangementFee, arrangementFee, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByValuationFee(
    double valuationFee,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalValuationFee, valuationFee, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByLoanAmount(
    double loanAmount,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalLoanAmount, loanAmount, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByDepositAmount(
    double depositAmount,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalDepositAmount, depositAmount, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByLoanToValue(
    double loanToValue,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalLoanToValue, loanToValue, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByMonthlyPayment(
    double monthlyPayment,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalMonthlyPayment, monthlyPayment, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByTotalPayable(
    double totalPayable,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalTotalPayable, totalPayable, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByOfferStatus(
    String offerStatus,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalOfferStatus, offerStatus, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByOfferDate(
    DateTime offerDate,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalOfferDate, offerDate, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByExpiryDate(
    DateTime expiryDate,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalExpiryDate, expiryDate, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByAcceptedDate(
    DateTime acceptedDate,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalAcceptedDate, acceptedDate, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getBySolicitorName(
    String solicitorName,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalSolicitorName, solicitorName, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getBySolicitorEmail(
    String solicitorEmail,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalSolicitorEmail, solicitorEmail, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<MortgagePreApproval> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}
    ) =>
    getManyIncluding(getMortgagePreApprovalUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getContact(
    MortgagePreApproval mortgagePreApproval, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (mortgagePreApproval.contactId == null) {
        return null;
    } else {
        final contact = ContactStore.instance.getById(mortgagePreApproval.contactId!, includes: includes);
        mortgagePreApproval.contact = contact;
        // setIncludedReferences(contact, includes: includes);
        return contact;
    }
}

	Deal? getDeal(
    MortgagePreApproval mortgagePreApproval, {ModelFilter? modelFilter, List<DealInclude>? includes}) {
    if (mortgagePreApproval.dealId == null) {
        return null;
    } else {
        final deal = DealStore.instance.getById(mortgagePreApproval.dealId!, includes: includes);
        mortgagePreApproval.deal = deal;
        // setIncludedReferences(deal, includes: includes);
        return deal;
    }
}

	Organization? getOrg(
    MortgagePreApproval mortgagePreApproval, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (mortgagePreApproval.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(mortgagePreApproval.orgId!, includes: includes);
        mortgagePreApproval.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<MortgagePreApproval>> getAll$({bool useCache = true, ModelFilter<MortgagePreApproval>? modelFilter, List<MortgagePreApprovalInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: MortgagePreApprovalEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<MortgagePreApproval?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getMortgagePreApprovalId,
        value: id,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<MortgagePreApproval>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgagePreApprovalOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByDealId$(
        String dealId,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgagePreApprovalDealId,
        value: dealId,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByDealId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgagePreApprovalContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByLenderName$(
        String lenderName,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgagePreApprovalLenderName,
        value: lenderName,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByLenderName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByMortgageType$(
        String mortgageType,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgagePreApprovalMortgageType,
        value: mortgageType,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByMortgageType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByMortgageTerm$(
        int mortgageTerm,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getMortgagePreApprovalMortgageTerm,
        value: mortgageTerm,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByMortgageTerm,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByInterestRate$(
        double interestRate,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgagePreApprovalInterestRate,
        value: interestRate,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByInterestRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByArrangementFee$(
        double arrangementFee,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgagePreApprovalArrangementFee,
        value: arrangementFee,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByArrangementFee,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByValuationFee$(
        double valuationFee,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgagePreApprovalValuationFee,
        value: valuationFee,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByValuationFee,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByLoanAmount$(
        double loanAmount,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgagePreApprovalLoanAmount,
        value: loanAmount,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByLoanAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByDepositAmount$(
        double depositAmount,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgagePreApprovalDepositAmount,
        value: depositAmount,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByDepositAmount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByLoanToValue$(
        double loanToValue,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgagePreApprovalLoanToValue,
        value: loanToValue,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByLoanToValue,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByMonthlyPayment$(
        double monthlyPayment,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgagePreApprovalMonthlyPayment,
        value: monthlyPayment,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByMonthlyPayment,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByTotalPayable$(
        double totalPayable,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getMortgagePreApprovalTotalPayable,
        value: totalPayable,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByTotalPayable,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByOfferStatus$(
        String offerStatus,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgagePreApprovalOfferStatus,
        value: offerStatus,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByOfferStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByOfferDate$(
        DateTime offerDate,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgagePreApprovalOfferDate,
        value: offerDate,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByOfferDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByExpiryDate$(
        DateTime expiryDate,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgagePreApprovalExpiryDate,
        value: expiryDate,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByExpiryDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByAcceptedDate$(
        DateTime acceptedDate,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgagePreApprovalAcceptedDate,
        value: acceptedDate,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByAcceptedDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getBySolicitorName$(
        String solicitorName,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgagePreApprovalSolicitorName,
        value: solicitorName,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyBySolicitorName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getBySolicitorEmail$(
        String solicitorEmail,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getMortgagePreApprovalSolicitorEmail,
        value: solicitorEmail,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyBySolicitorEmail,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgagePreApprovalCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<MortgagePreApproval>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<MortgagePreApproval>? modelFilter,
        List<MortgagePreApprovalInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getMortgagePreApprovalUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: MortgagePreApprovalEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getContact$(
    MortgagePreApproval mortgagePreApproval, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (mortgagePreApproval.contactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            mortgagePreApproval.contactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contact) {
            mortgagePreApproval.contact = contact;
        });
    }
}

	Stream<Deal?> getDeal$(
    MortgagePreApproval mortgagePreApproval, {bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    if (mortgagePreApproval.dealId == null) {
        return Stream.value(null);
    } else {
        return DealStore.instance.getById$(
            mortgagePreApproval.dealId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((deal) {
            mortgagePreApproval.deal = deal;
        });
    }
}

	Stream<Organization?> getOrg$(
    MortgagePreApproval mortgagePreApproval, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (mortgagePreApproval.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            mortgagePreApproval.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            mortgagePreApproval.org = org;
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
MortgagePreApproval recursiveUpsert(MortgagePreApproval mortgagePreApproval, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'MortgagePreApproval'} 
        : const {};
    if (mortgagePreApproval.contact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        mortgagePreApproval.contact = ContactStore.instance.recursiveUpsert(mortgagePreApproval.contact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mortgagePreApproval.deal != null && (!preventCircularSerialization || !upsertedTypes.contains('Deal'))) {
        mortgagePreApproval.deal = DealStore.instance.recursiveUpsert(mortgagePreApproval.deal!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (mortgagePreApproval.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        mortgagePreApproval.org = OrganizationStore.instance.recursiveUpsert(mortgagePreApproval.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(mortgagePreApproval);
}

  List<MortgagePreApproval> recursiveListUpsert(List<MortgagePreApproval> mortgagePreApprovals, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedMortgagePreApprovals = <MortgagePreApproval>[];
    for (var mortgagePreApproval in mortgagePreApprovals) {
        updatedMortgagePreApprovals.add(recursiveUpsert(mortgagePreApproval, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedMortgagePreApprovals;
}

//   @override
//   MortgagePreApproval upsert(MortgagePreApproval item) {
//     return recursiveUpsert(item);
//   }

}


class MortgagePreApprovalInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      MortgagePreApprovalInclude.contact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mortgagePreApproval) => MortgagePreApprovalStore.instance
            .getContact$(mortgagePreApproval, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mortgagePreApproval) => MortgagePreApprovalStore.instance
            .getContact(mortgagePreApproval, modelFilter: modelFilter, includes: includes);
      }
}

	MortgagePreApprovalInclude.deal({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Deal>? modelFilter,
    List<DealInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mortgagePreApproval) => MortgagePreApprovalStore.instance
            .getDeal$(mortgagePreApproval, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mortgagePreApproval) => MortgagePreApprovalStore.instance
            .getDeal(mortgagePreApproval, modelFilter: modelFilter, includes: includes);
      }
}

	MortgagePreApprovalInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (mortgagePreApproval) => MortgagePreApprovalStore.instance
            .getOrg$(mortgagePreApproval, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (mortgagePreApproval) => MortgagePreApprovalStore.instance
            .getOrg(mortgagePreApproval, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum MortgagePreApprovalEndpoints implements Endpoint {

    getAll('/mortgagePreApproval', HttpMethod.post, List<MortgagePreApproval>),
	getById('/mortgagePreApproval/byId/:id', HttpMethod.post, MortgagePreApproval),
	getManyByOrgId('/mortgagePreApproval/byOrgId/:orgId', HttpMethod.post, List<MortgagePreApproval>),
	getManyByDealId('/mortgagePreApproval/byDealId/:dealId', HttpMethod.post, List<MortgagePreApproval>),
	getManyByContactId('/mortgagePreApproval/byContactId/:contactId', HttpMethod.post, List<MortgagePreApproval>),
	getManyByLenderName('/mortgagePreApproval/byLenderName/:lenderName', HttpMethod.post, List<MortgagePreApproval>),
	getManyByMortgageType('/mortgagePreApproval/byMortgageType/:mortgageType', HttpMethod.post, List<MortgagePreApproval>),
	getManyByMortgageTerm('/mortgagePreApproval/byMortgageTerm/:mortgageTerm', HttpMethod.post, List<MortgagePreApproval>),
	getManyByInterestRate('/mortgagePreApproval/byInterestRate/:interestRate', HttpMethod.post, List<MortgagePreApproval>),
	getManyByArrangementFee('/mortgagePreApproval/byArrangementFee/:arrangementFee', HttpMethod.post, List<MortgagePreApproval>),
	getManyByValuationFee('/mortgagePreApproval/byValuationFee/:valuationFee', HttpMethod.post, List<MortgagePreApproval>),
	getManyByLoanAmount('/mortgagePreApproval/byLoanAmount/:loanAmount', HttpMethod.post, List<MortgagePreApproval>),
	getManyByDepositAmount('/mortgagePreApproval/byDepositAmount/:depositAmount', HttpMethod.post, List<MortgagePreApproval>),
	getManyByLoanToValue('/mortgagePreApproval/byLoanToValue/:loanToValue', HttpMethod.post, List<MortgagePreApproval>),
	getManyByMonthlyPayment('/mortgagePreApproval/byMonthlyPayment/:monthlyPayment', HttpMethod.post, List<MortgagePreApproval>),
	getManyByTotalPayable('/mortgagePreApproval/byTotalPayable/:totalPayable', HttpMethod.post, List<MortgagePreApproval>),
	getManyByOfferStatus('/mortgagePreApproval/byOfferStatus/:offerStatus', HttpMethod.post, List<MortgagePreApproval>),
	getManyByOfferDate('/mortgagePreApproval/byOfferDate/:offerDate', HttpMethod.post, List<MortgagePreApproval>),
	getManyByExpiryDate('/mortgagePreApproval/byExpiryDate/:expiryDate', HttpMethod.post, List<MortgagePreApproval>),
	getManyByAcceptedDate('/mortgagePreApproval/byAcceptedDate/:acceptedDate', HttpMethod.post, List<MortgagePreApproval>),
	getManyBySolicitorName('/mortgagePreApproval/bySolicitorName/:solicitorName', HttpMethod.post, List<MortgagePreApproval>),
	getManyBySolicitorEmail('/mortgagePreApproval/bySolicitorEmail/:solicitorEmail', HttpMethod.post, List<MortgagePreApproval>),
	getManyByCreatedAt('/mortgagePreApproval/byCreatedAt/:createdAt', HttpMethod.post, List<MortgagePreApproval>),
	getManyByUpdatedAt('/mortgagePreApproval/byUpdatedAt/:updatedAt', HttpMethod.post, List<MortgagePreApproval>);

    const MortgagePreApprovalEndpoints(this.path, this.method, this.responseType);

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
