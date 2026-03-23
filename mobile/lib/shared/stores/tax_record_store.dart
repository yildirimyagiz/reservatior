
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class TaxRecordStore extends ModelStreamStore<String, TaxRecord> {

  static TaxRecordStore? _instance;

  static TaxRecordStore get instance {
    _instance ??= TaxRecordStore();
    return _instance!;
  }

  TaxRecordStore() : super(TaxRecord.fromJson) {
    if (_instance != null) {
        throw Exception(
            'TaxRecordStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending TaxRecordStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use TaxRecordStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getTaxRecordId(TaxRecord taxRecord) => taxRecord.id;

	String? getTaxRecordOrgId(TaxRecord taxRecord) => taxRecord.orgId;

	String? getTaxRecordProfileId(TaxRecord taxRecord) => taxRecord.profileId;

	String? getTaxRecordTransactionId(TaxRecord taxRecord) => taxRecord.transactionId;

	String? getTaxRecordPropertyId(TaxRecord taxRecord) => taxRecord.propertyId;

	String? getTaxRecordContactId(TaxRecord taxRecord) => taxRecord.contactId;

	String? getTaxRecordRecordType(TaxRecord taxRecord) => taxRecord.recordType;

	dynamic? getTaxRecordProfileData(TaxRecord taxRecord) => taxRecord.profileData;

	dynamic? getTaxRecordCategoryData(TaxRecord taxRecord) => taxRecord.categoryData;

	dynamic? getTaxRecordLineItemData(TaxRecord taxRecord) => taxRecord.lineItemData;

	dynamic? getTaxRecordAuditData(TaxRecord taxRecord) => taxRecord.auditData;

	dynamic? getTaxRecordRuleData(TaxRecord taxRecord) => taxRecord.ruleData;

	dynamic? getTaxRecordDepreciationData(TaxRecord taxRecord) => taxRecord.depreciationData;

	dynamic? getTaxRecordForm1099Data(TaxRecord taxRecord) => taxRecord.form1099Data;

	bool? getTaxRecordIsActive(TaxRecord taxRecord) => taxRecord.isActive;

	String? getTaxRecordCreatedBy(TaxRecord taxRecord) => taxRecord.createdBy;

	DateTime? getTaxRecordCreatedAt(TaxRecord taxRecord) => taxRecord.createdAt;

	DateTime? getTaxRecordUpdatedAt(TaxRecord taxRecord) => taxRecord.updatedAt;

	DateTime? getTaxRecordDeletedAt(TaxRecord taxRecord) => taxRecord.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<TaxRecord> getByOrgId(
    String orgId,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByProfileId(
    String profileId,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordProfileId, profileId, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByTransactionId(
    String transactionId,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordTransactionId, transactionId, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByPropertyId(
    String propertyId,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByContactId(
    String contactId,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordContactId, contactId, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByRecordType(
    String recordType,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordRecordType, recordType, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByProfileData(
    dynamic profileData,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordProfileData, profileData, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByCategoryData(
    dynamic categoryData,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordCategoryData, categoryData, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByLineItemData(
    dynamic lineItemData,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordLineItemData, lineItemData, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByAuditData(
    dynamic auditData,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordAuditData, auditData, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByRuleData(
    dynamic ruleData,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordRuleData, ruleData, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByDepreciationData(
    dynamic depreciationData,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordDepreciationData, depreciationData, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByForm1099Data(
    dynamic form1099Data,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordForm1099Data, form1099Data, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByIsActive(
    bool isActive,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByCreatedBy(
    String createdBy,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<TaxRecord> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}
    ) =>
    getManyIncluding(getTaxRecordDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    TaxRecord taxRecord, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (taxRecord.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(taxRecord.orgId!, includes: includes);
        taxRecord.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	TaxRecord? getProfile(
    TaxRecord taxRecord, {ModelFilter? modelFilter, List<TaxRecordInclude>? includes}) {
    if (taxRecord.profileId == null) {
        return null;
    } else {
        final profile = TaxRecordStore.instance.getById(taxRecord.profileId!, includes: includes);
        taxRecord.profile = profile;
        // setIncludedReferences(profile, includes: includes);
        return profile;
    }
}

  /// GET RELATED MODELS 

  List<TaxRecord> getProfiles(
    TaxRecord taxRecord, {ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}) {
    final profiles = TaxRecordStore.instance.getByProfileId(taxRecord.$uid!, modelFilter: modelFilter, includes: includes);
    taxRecord.profiles = profiles;
    // setIncludedReferencesForList(profiles, includes: includes);
    return profiles;
}

	List<Currency> getCurrencies(
    TaxRecord taxRecord, {ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    final currencies = CurrencyStore.instance.getBy(taxRecord.$uid!, modelFilter: modelFilter, includes: includes);
    taxRecord.currencies = currencies;
    // setIncludedReferencesForList(currencies, includes: includes);
    return currencies;
}

	List<Analytics> getAnalytics(
    TaxRecord taxRecord, {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    final analytics = AnalyticsStore.instance.getByTaxRecordId(taxRecord.$uid!, modelFilter: modelFilter, includes: includes);
    taxRecord.analytics = analytics;
    // setIncludedReferencesForList(analytics, includes: includes);
    return analytics;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<TaxRecord>> getAll$({bool useCache = true, ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: TaxRecordEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<TaxRecord?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getTaxRecordId,
        value: id,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<TaxRecord>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaxRecordOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByProfileId$(
        String profileId,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaxRecordProfileId,
        value: profileId,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByProfileId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByTransactionId$(
        String transactionId,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaxRecordTransactionId,
        value: transactionId,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByTransactionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaxRecordPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByContactId$(
        String contactId,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaxRecordContactId,
        value: contactId,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByRecordType$(
        String recordType,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaxRecordRecordType,
        value: recordType,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByRecordType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByProfileData$(
        dynamic profileData,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getTaxRecordProfileData,
        value: profileData,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByProfileData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByCategoryData$(
        dynamic categoryData,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getTaxRecordCategoryData,
        value: categoryData,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByCategoryData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByLineItemData$(
        dynamic lineItemData,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getTaxRecordLineItemData,
        value: lineItemData,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByLineItemData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByAuditData$(
        dynamic auditData,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getTaxRecordAuditData,
        value: auditData,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByAuditData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByRuleData$(
        dynamic ruleData,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getTaxRecordRuleData,
        value: ruleData,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByRuleData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByDepreciationData$(
        dynamic depreciationData,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getTaxRecordDepreciationData,
        value: depreciationData,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByDepreciationData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByForm1099Data$(
        dynamic form1099Data,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getTaxRecordForm1099Data,
        value: form1099Data,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByForm1099Data,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getTaxRecordIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaxRecordCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTaxRecordCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTaxRecordUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TaxRecord>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<TaxRecord>? modelFilter,
        List<TaxRecordInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTaxRecordDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: TaxRecordEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    TaxRecord taxRecord, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (taxRecord.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            taxRecord.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            taxRecord.org = org;
        });
    }
}

	Stream<TaxRecord?> getProfile$(
    TaxRecord taxRecord, {bool useCache = true, ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}) {
    if (taxRecord.profileId == null) {
        return Stream.value(null);
    } else {
        return TaxRecordStore.instance.getById$(
            taxRecord.profileId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((profile) {
            taxRecord.profile = profile;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<TaxRecord>> getProfiles$(
    TaxRecord taxRecord, {bool useCache = true, ModelFilter<TaxRecord>? modelFilter, List<TaxRecordInclude>? includes}) {
    return TaxRecordStore.instance.getByProfileId$(
        taxRecord.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((profiles) {
        taxRecord.profiles = profiles;
    });

}

	Stream<List<Currency>> getCurrencies$(
    TaxRecord taxRecord, {bool useCache = true, ModelFilter<Currency>? modelFilter, List<CurrencyInclude>? includes}) {
    return CurrencyStore.instance.getBy$(
        taxRecord.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((currencies) {
        taxRecord.currencies = currencies;
    });

}

	Stream<List<Analytics>> getAnalytics$(
    TaxRecord taxRecord, {bool useCache = true, ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    return AnalyticsStore.instance.getByTaxRecordId$(
        taxRecord.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((analytics) {
        taxRecord.analytics = analytics;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
TaxRecord recursiveUpsert(TaxRecord taxRecord, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'TaxRecord'} 
        : const {};
    if (taxRecord.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        taxRecord.org = OrganizationStore.instance.recursiveUpsert(taxRecord.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (taxRecord.profile != null && (!preventCircularSerialization || !upsertedTypes.contains('TaxRecord'))) {
        taxRecord.profile = TaxRecordStore.instance.recursiveUpsert(taxRecord.profile!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (taxRecord.profiles != null && (!preventCircularSerialization || !upsertedTypes.contains('TaxRecord'))) {
        taxRecord.profiles = TaxRecordStore.instance.recursiveListUpsert(taxRecord.profiles!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (taxRecord.currencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Currency'))) {
        taxRecord.currencies = CurrencyStore.instance.recursiveListUpsert(taxRecord.currencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (taxRecord.analytics != null && (!preventCircularSerialization || !upsertedTypes.contains('Analytics'))) {
        taxRecord.analytics = AnalyticsStore.instance.recursiveListUpsert(taxRecord.analytics!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(taxRecord);
}

  List<TaxRecord> recursiveListUpsert(List<TaxRecord> taxRecords, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedTaxRecords = <TaxRecord>[];
    for (var taxRecord in taxRecords) {
        updatedTaxRecords.add(recursiveUpsert(taxRecord, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedTaxRecords;
}

//   @override
//   TaxRecord upsert(TaxRecord item) {
//     return recursiveUpsert(item);
//   }

}


class TaxRecordInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      TaxRecordInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (taxRecord) => TaxRecordStore.instance
            .getOrg$(taxRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (taxRecord) => TaxRecordStore.instance
            .getOrg(taxRecord, modelFilter: modelFilter, includes: includes);
      }
}

	TaxRecordInclude.profile({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<TaxRecord>? modelFilter,
    List<TaxRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (taxRecord) => TaxRecordStore.instance
            .getProfile$(taxRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (taxRecord) => TaxRecordStore.instance
            .getProfile(taxRecord, modelFilter: modelFilter, includes: includes);
      }
}

	TaxRecordInclude.profiles({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<TaxRecord>? modelFilter,
    List<TaxRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (taxRecord) => TaxRecordStore.instance
            .getProfiles$(taxRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (taxRecord) => TaxRecordStore.instance
            .getProfiles(taxRecord, modelFilter: modelFilter, includes: includes);
      }
}

	TaxRecordInclude.currencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Currency>? modelFilter,
    List<CurrencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (taxRecord) => TaxRecordStore.instance
            .getCurrencies$(taxRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (taxRecord) => TaxRecordStore.instance
            .getCurrencies(taxRecord, modelFilter: modelFilter, includes: includes);
      }
}

	TaxRecordInclude.analytics({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Analytics>? modelFilter,
    List<AnalyticsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (taxRecord) => TaxRecordStore.instance
            .getAnalytics$(taxRecord, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (taxRecord) => TaxRecordStore.instance
            .getAnalytics(taxRecord, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum TaxRecordEndpoints implements Endpoint {

    getAll('/taxRecord', HttpMethod.post, List<TaxRecord>),
	getById('/taxRecord/byId/:id', HttpMethod.post, TaxRecord),
	getManyByOrgId('/taxRecord/byOrgId/:orgId', HttpMethod.post, List<TaxRecord>),
	getManyByProfileId('/taxRecord/byProfileId/:profileId', HttpMethod.post, List<TaxRecord>),
	getManyByTransactionId('/taxRecord/byTransactionId/:transactionId', HttpMethod.post, List<TaxRecord>),
	getManyByPropertyId('/taxRecord/byPropertyId/:propertyId', HttpMethod.post, List<TaxRecord>),
	getManyByContactId('/taxRecord/byContactId/:contactId', HttpMethod.post, List<TaxRecord>),
	getManyByRecordType('/taxRecord/byRecordType/:recordType', HttpMethod.post, List<TaxRecord>),
	getManyByProfileData('/taxRecord/byProfileData/:profileData', HttpMethod.post, List<TaxRecord>),
	getManyByCategoryData('/taxRecord/byCategoryData/:categoryData', HttpMethod.post, List<TaxRecord>),
	getManyByLineItemData('/taxRecord/byLineItemData/:lineItemData', HttpMethod.post, List<TaxRecord>),
	getManyByAuditData('/taxRecord/byAuditData/:auditData', HttpMethod.post, List<TaxRecord>),
	getManyByRuleData('/taxRecord/byRuleData/:ruleData', HttpMethod.post, List<TaxRecord>),
	getManyByDepreciationData('/taxRecord/byDepreciationData/:depreciationData', HttpMethod.post, List<TaxRecord>),
	getManyByForm1099Data('/taxRecord/byForm1099Data/:form1099Data', HttpMethod.post, List<TaxRecord>),
	getManyByIsActive('/taxRecord/byIsActive/:isActive', HttpMethod.post, List<TaxRecord>),
	getManyByCreatedBy('/taxRecord/byCreatedBy/:createdBy', HttpMethod.post, List<TaxRecord>),
	getManyByCreatedAt('/taxRecord/byCreatedAt/:createdAt', HttpMethod.post, List<TaxRecord>),
	getManyByUpdatedAt('/taxRecord/byUpdatedAt/:updatedAt', HttpMethod.post, List<TaxRecord>),
	getManyByDeletedAt('/taxRecord/byDeletedAt/:deletedAt', HttpMethod.post, List<TaxRecord>);

    const TaxRecordEndpoints(this.path, this.method, this.responseType);

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
