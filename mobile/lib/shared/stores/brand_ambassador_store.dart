
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class BrandAmbassadorStore extends ModelStreamStore<String, BrandAmbassador> {

  static BrandAmbassadorStore? _instance;

  static BrandAmbassadorStore get instance {
    _instance ??= BrandAmbassadorStore();
    return _instance!;
  }

  BrandAmbassadorStore() : super(BrandAmbassador.fromJson) {
    if (_instance != null) {
        throw Exception(
            'BrandAmbassadorStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending BrandAmbassadorStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use BrandAmbassadorStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getBrandAmbassadorId(BrandAmbassador brandAmbassador) => brandAmbassador.id;

	String? getBrandAmbassadorOrgId(BrandAmbassador brandAmbassador) => brandAmbassador.orgId;

	String? getBrandAmbassadorFullName(BrandAmbassador brandAmbassador) => brandAmbassador.fullName;

	String? getBrandAmbassadorEmailCiphertext(BrandAmbassador brandAmbassador) => brandAmbassador.emailCiphertext;

	String? getBrandAmbassadorPhoneCiphertext(BrandAmbassador brandAmbassador) => brandAmbassador.phoneCiphertext;

	AmbassadorCategory? getBrandAmbassadorCategory(BrandAmbassador brandAmbassador) => brandAmbassador.category;

	List<String>? getBrandAmbassadorPlatform(BrandAmbassador brandAmbassador) => brandAmbassador.platform;

	int? getBrandAmbassadorFollowerCount(BrandAmbassador brandAmbassador) => brandAmbassador.followerCount;

	double? getBrandAmbassadorEngagementRate(BrandAmbassador brandAmbassador) => brandAmbassador.engagementRate;

	DateTime? getBrandAmbassadorContractStart(BrandAmbassador brandAmbassador) => brandAmbassador.contractStart;

	DateTime? getBrandAmbassadorContractEnd(BrandAmbassador brandAmbassador) => brandAmbassador.contractEnd;

	double? getBrandAmbassadorEquityPercent(BrandAmbassador brandAmbassador) => brandAmbassador.equityPercent;

	double? getBrandAmbassadorUpfrontFee(BrandAmbassador brandAmbassador) => brandAmbassador.upfrontFee;

	String? getBrandAmbassadorCurrency(BrandAmbassador brandAmbassador) => brandAmbassador.currency;

	String? getBrandAmbassadorTier(BrandAmbassador brandAmbassador) => brandAmbassador.tier;

	AmbassadorStatus? getBrandAmbassadorStatus(BrandAmbassador brandAmbassador) => brandAmbassador.status;

	String? getBrandAmbassadorAgencyName(BrandAmbassador brandAmbassador) => brandAmbassador.agencyName;

	String? getBrandAmbassadorAgencyContact(BrandAmbassador brandAmbassador) => brandAmbassador.agencyContact;

	bool? getBrandAmbassadorNdaSigned(BrandAmbassador brandAmbassador) => brandAmbassador.ndaSigned;

	DateTime? getBrandAmbassadorNdaSignedAt(BrandAmbassador brandAmbassador) => brandAmbassador.ndaSignedAt;

	String? getBrandAmbassadorNotes(BrandAmbassador brandAmbassador) => brandAmbassador.notes;

	DateTime? getBrandAmbassadorPitchSentAt(BrandAmbassador brandAmbassador) => brandAmbassador.pitchSentAt;

	DateTime? getBrandAmbassadorRespondedAt(BrandAmbassador brandAmbassador) => brandAmbassador.respondedAt;

	DateTime? getBrandAmbassadorSignedAt(BrandAmbassador brandAmbassador) => brandAmbassador.signedAt;

	int? getBrandAmbassadorActualReach(BrandAmbassador brandAmbassador) => brandAmbassador.actualReach;

	double? getBrandAmbassadorTotalRoi(BrandAmbassador brandAmbassador) => brandAmbassador.totalRoi;

	DateTime? getBrandAmbassadorCreatedAt(BrandAmbassador brandAmbassador) => brandAmbassador.createdAt;

	DateTime? getBrandAmbassadorUpdatedAt(BrandAmbassador brandAmbassador) => brandAmbassador.updatedAt;

	DateTime? getBrandAmbassadorDeletedAt(BrandAmbassador brandAmbassador) => brandAmbassador.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<BrandAmbassador> getByOrgId(
    String orgId,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByFullName(
    String fullName,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorFullName, fullName, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByEmailCiphertext(
    String emailCiphertext,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorEmailCiphertext, emailCiphertext, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByPhoneCiphertext(
    String phoneCiphertext,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorPhoneCiphertext, phoneCiphertext, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByCategory(
    AmbassadorCategory category,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorCategory, category, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByPlatform(
    String platform,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorPlatform, platform, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByFollowerCount(
    int followerCount,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorFollowerCount, followerCount, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByEngagementRate(
    double engagementRate,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorEngagementRate, engagementRate, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByContractStart(
    DateTime contractStart,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorContractStart, contractStart, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByContractEnd(
    DateTime contractEnd,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorContractEnd, contractEnd, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByEquityPercent(
    double equityPercent,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorEquityPercent, equityPercent, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByUpfrontFee(
    double upfrontFee,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorUpfrontFee, upfrontFee, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByCurrency(
    String currency,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorCurrency, currency, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByTier(
    String tier,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorTier, tier, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByStatus(
    AmbassadorStatus status,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorStatus, status, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByAgencyName(
    String agencyName,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorAgencyName, agencyName, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByAgencyContact(
    String agencyContact,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorAgencyContact, agencyContact, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByNdaSigned(
    bool ndaSigned,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorNdaSigned, ndaSigned, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByNdaSignedAt(
    DateTime ndaSignedAt,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorNdaSignedAt, ndaSignedAt, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByNotes(
    String notes,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorNotes, notes, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByPitchSentAt(
    DateTime pitchSentAt,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorPitchSentAt, pitchSentAt, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByRespondedAt(
    DateTime respondedAt,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorRespondedAt, respondedAt, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getBySignedAt(
    DateTime signedAt,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorSignedAt, signedAt, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByActualReach(
    int actualReach,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorActualReach, actualReach, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByTotalRoi(
    double totalRoi,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorTotalRoi, totalRoi, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<BrandAmbassador> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}
    ) =>
    getManyIncluding(getBrandAmbassadorDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    BrandAmbassador brandAmbassador, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (brandAmbassador.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(brandAmbassador.orgId!, includes: includes);
        brandAmbassador.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<AmbassadorCampaign> getCampaigns(
    BrandAmbassador brandAmbassador, {ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}) {
    final campaigns = AmbassadorCampaignStore.instance.getByAmbassadorId(brandAmbassador.$uid!, modelFilter: modelFilter, includes: includes);
    brandAmbassador.campaigns = campaigns;
    // setIncludedReferencesForList(campaigns, includes: includes);
    return campaigns;
}

	List<AmbassadorContract> getContracts(
    BrandAmbassador brandAmbassador, {ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}) {
    final contracts = AmbassadorContractStore.instance.getByAmbassadorId(brandAmbassador.$uid!, modelFilter: modelFilter, includes: includes);
    brandAmbassador.contracts = contracts;
    // setIncludedReferencesForList(contracts, includes: includes);
    return contracts;
}

	List<VideoContent> getVideoContents(
    BrandAmbassador brandAmbassador, {ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    final videoContents = VideoContentStore.instance.getByAmbassadorId(brandAmbassador.$uid!, modelFilter: modelFilter, includes: includes);
    brandAmbassador.videoContents = videoContents;
    // setIncludedReferencesForList(videoContents, includes: includes);
    return videoContents;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<BrandAmbassador>> getAll$({bool useCache = true, ModelFilter<BrandAmbassador>? modelFilter, List<BrandAmbassadorInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: BrandAmbassadorEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<BrandAmbassador?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getBrandAmbassadorId,
        value: id,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<BrandAmbassador>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBrandAmbassadorOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByFullName$(
        String fullName,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBrandAmbassadorFullName,
        value: fullName,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByFullName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByEmailCiphertext$(
        String emailCiphertext,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBrandAmbassadorEmailCiphertext,
        value: emailCiphertext,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByEmailCiphertext,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByPhoneCiphertext$(
        String phoneCiphertext,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBrandAmbassadorPhoneCiphertext,
        value: phoneCiphertext,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByPhoneCiphertext,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByCategory$(
        AmbassadorCategory category,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<AmbassadorCategory>(
        getPropVal: getBrandAmbassadorCategory,
        value: category,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByCategory,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByPlatform$(
        String platform,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBrandAmbassadorPlatform,
        value: platform,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByPlatform,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByFollowerCount$(
        int followerCount,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getBrandAmbassadorFollowerCount,
        value: followerCount,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByFollowerCount,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByEngagementRate$(
        double engagementRate,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getBrandAmbassadorEngagementRate,
        value: engagementRate,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByEngagementRate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByContractStart$(
        DateTime contractStart,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBrandAmbassadorContractStart,
        value: contractStart,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByContractStart,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByContractEnd$(
        DateTime contractEnd,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBrandAmbassadorContractEnd,
        value: contractEnd,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByContractEnd,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByEquityPercent$(
        double equityPercent,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getBrandAmbassadorEquityPercent,
        value: equityPercent,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByEquityPercent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByUpfrontFee$(
        double upfrontFee,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getBrandAmbassadorUpfrontFee,
        value: upfrontFee,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByUpfrontFee,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByCurrency$(
        String currency,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBrandAmbassadorCurrency,
        value: currency,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByCurrency,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByTier$(
        String tier,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBrandAmbassadorTier,
        value: tier,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByTier,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByStatus$(
        AmbassadorStatus status,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<AmbassadorStatus>(
        getPropVal: getBrandAmbassadorStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByAgencyName$(
        String agencyName,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBrandAmbassadorAgencyName,
        value: agencyName,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByAgencyName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByAgencyContact$(
        String agencyContact,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBrandAmbassadorAgencyContact,
        value: agencyContact,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByAgencyContact,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByNdaSigned$(
        bool ndaSigned,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getBrandAmbassadorNdaSigned,
        value: ndaSigned,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByNdaSigned,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByNdaSignedAt$(
        DateTime ndaSignedAt,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBrandAmbassadorNdaSignedAt,
        value: ndaSignedAt,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByNdaSignedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByNotes$(
        String notes,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getBrandAmbassadorNotes,
        value: notes,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByNotes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByPitchSentAt$(
        DateTime pitchSentAt,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBrandAmbassadorPitchSentAt,
        value: pitchSentAt,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByPitchSentAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByRespondedAt$(
        DateTime respondedAt,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBrandAmbassadorRespondedAt,
        value: respondedAt,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByRespondedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getBySignedAt$(
        DateTime signedAt,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBrandAmbassadorSignedAt,
        value: signedAt,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyBySignedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByActualReach$(
        int actualReach,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getBrandAmbassadorActualReach,
        value: actualReach,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByActualReach,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByTotalRoi$(
        double totalRoi,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getBrandAmbassadorTotalRoi,
        value: totalRoi,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByTotalRoi,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBrandAmbassadorCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBrandAmbassadorUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<BrandAmbassador>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<BrandAmbassador>? modelFilter,
        List<BrandAmbassadorInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getBrandAmbassadorDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: BrandAmbassadorEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    BrandAmbassador brandAmbassador, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (brandAmbassador.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            brandAmbassador.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            brandAmbassador.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<AmbassadorCampaign>> getCampaigns$(
    BrandAmbassador brandAmbassador, {bool useCache = true, ModelFilter<AmbassadorCampaign>? modelFilter, List<AmbassadorCampaignInclude>? includes}) {
    return AmbassadorCampaignStore.instance.getByAmbassadorId$(
        brandAmbassador.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((campaigns) {
        brandAmbassador.campaigns = campaigns;
    });

}

	Stream<List<AmbassadorContract>> getContracts$(
    BrandAmbassador brandAmbassador, {bool useCache = true, ModelFilter<AmbassadorContract>? modelFilter, List<AmbassadorContractInclude>? includes}) {
    return AmbassadorContractStore.instance.getByAmbassadorId$(
        brandAmbassador.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((contracts) {
        brandAmbassador.contracts = contracts;
    });

}

	Stream<List<VideoContent>> getVideoContents$(
    BrandAmbassador brandAmbassador, {bool useCache = true, ModelFilter<VideoContent>? modelFilter, List<VideoContentInclude>? includes}) {
    return VideoContentStore.instance.getByAmbassadorId$(
        brandAmbassador.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((videoContents) {
        brandAmbassador.videoContents = videoContents;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
BrandAmbassador recursiveUpsert(BrandAmbassador brandAmbassador, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'BrandAmbassador'} 
        : const {};
    if (brandAmbassador.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        brandAmbassador.org = OrganizationStore.instance.recursiveUpsert(brandAmbassador.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (brandAmbassador.campaigns != null && (!preventCircularSerialization || !upsertedTypes.contains('AmbassadorCampaign'))) {
        brandAmbassador.campaigns = AmbassadorCampaignStore.instance.recursiveListUpsert(brandAmbassador.campaigns!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (brandAmbassador.contracts != null && (!preventCircularSerialization || !upsertedTypes.contains('AmbassadorContract'))) {
        brandAmbassador.contracts = AmbassadorContractStore.instance.recursiveListUpsert(brandAmbassador.contracts!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (brandAmbassador.videoContents != null && (!preventCircularSerialization || !upsertedTypes.contains('VideoContent'))) {
        brandAmbassador.videoContents = VideoContentStore.instance.recursiveListUpsert(brandAmbassador.videoContents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(brandAmbassador);
}

  List<BrandAmbassador> recursiveListUpsert(List<BrandAmbassador> brandAmbassadors, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedBrandAmbassadors = <BrandAmbassador>[];
    for (var brandAmbassador in brandAmbassadors) {
        updatedBrandAmbassadors.add(recursiveUpsert(brandAmbassador, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedBrandAmbassadors;
}

//   @override
//   BrandAmbassador upsert(BrandAmbassador item) {
//     return recursiveUpsert(item);
//   }

}


class BrandAmbassadorInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      BrandAmbassadorInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (brandAmbassador) => BrandAmbassadorStore.instance
            .getOrg$(brandAmbassador, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (brandAmbassador) => BrandAmbassadorStore.instance
            .getOrg(brandAmbassador, modelFilter: modelFilter, includes: includes);
      }
}

	BrandAmbassadorInclude.campaigns({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AmbassadorCampaign>? modelFilter,
    List<AmbassadorCampaignInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (brandAmbassador) => BrandAmbassadorStore.instance
            .getCampaigns$(brandAmbassador, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (brandAmbassador) => BrandAmbassadorStore.instance
            .getCampaigns(brandAmbassador, modelFilter: modelFilter, includes: includes);
      }
}

	BrandAmbassadorInclude.contracts({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AmbassadorContract>? modelFilter,
    List<AmbassadorContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (brandAmbassador) => BrandAmbassadorStore.instance
            .getContracts$(brandAmbassador, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (brandAmbassador) => BrandAmbassadorStore.instance
            .getContracts(brandAmbassador, modelFilter: modelFilter, includes: includes);
      }
}

	BrandAmbassadorInclude.videoContents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<VideoContent>? modelFilter,
    List<VideoContentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (brandAmbassador) => BrandAmbassadorStore.instance
            .getVideoContents$(brandAmbassador, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (brandAmbassador) => BrandAmbassadorStore.instance
            .getVideoContents(brandAmbassador, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum BrandAmbassadorEndpoints implements Endpoint {

    getAll('/brandAmbassador', HttpMethod.post, List<BrandAmbassador>),
	getById('/brandAmbassador/byId/:id', HttpMethod.post, BrandAmbassador),
	getManyByOrgId('/brandAmbassador/byOrgId/:orgId', HttpMethod.post, List<BrandAmbassador>),
	getManyByFullName('/brandAmbassador/byFullName/:fullName', HttpMethod.post, List<BrandAmbassador>),
	getManyByEmailCiphertext('/brandAmbassador/byEmailCiphertext/:emailCiphertext', HttpMethod.post, List<BrandAmbassador>),
	getManyByPhoneCiphertext('/brandAmbassador/byPhoneCiphertext/:phoneCiphertext', HttpMethod.post, List<BrandAmbassador>),
	getManyByCategory('/brandAmbassador/byCategory/:category', HttpMethod.post, List<BrandAmbassador>),
	getManyByPlatform('/brandAmbassador/byPlatform/:platform', HttpMethod.post, List<BrandAmbassador>),
	getManyByFollowerCount('/brandAmbassador/byFollowerCount/:followerCount', HttpMethod.post, List<BrandAmbassador>),
	getManyByEngagementRate('/brandAmbassador/byEngagementRate/:engagementRate', HttpMethod.post, List<BrandAmbassador>),
	getManyByContractStart('/brandAmbassador/byContractStart/:contractStart', HttpMethod.post, List<BrandAmbassador>),
	getManyByContractEnd('/brandAmbassador/byContractEnd/:contractEnd', HttpMethod.post, List<BrandAmbassador>),
	getManyByEquityPercent('/brandAmbassador/byEquityPercent/:equityPercent', HttpMethod.post, List<BrandAmbassador>),
	getManyByUpfrontFee('/brandAmbassador/byUpfrontFee/:upfrontFee', HttpMethod.post, List<BrandAmbassador>),
	getManyByCurrency('/brandAmbassador/byCurrency/:currency', HttpMethod.post, List<BrandAmbassador>),
	getManyByTier('/brandAmbassador/byTier/:tier', HttpMethod.post, List<BrandAmbassador>),
	getManyByStatus('/brandAmbassador/byStatus/:status', HttpMethod.post, List<BrandAmbassador>),
	getManyByAgencyName('/brandAmbassador/byAgencyName/:agencyName', HttpMethod.post, List<BrandAmbassador>),
	getManyByAgencyContact('/brandAmbassador/byAgencyContact/:agencyContact', HttpMethod.post, List<BrandAmbassador>),
	getManyByNdaSigned('/brandAmbassador/byNdaSigned/:ndaSigned', HttpMethod.post, List<BrandAmbassador>),
	getManyByNdaSignedAt('/brandAmbassador/byNdaSignedAt/:ndaSignedAt', HttpMethod.post, List<BrandAmbassador>),
	getManyByNotes('/brandAmbassador/byNotes/:notes', HttpMethod.post, List<BrandAmbassador>),
	getManyByPitchSentAt('/brandAmbassador/byPitchSentAt/:pitchSentAt', HttpMethod.post, List<BrandAmbassador>),
	getManyByRespondedAt('/brandAmbassador/byRespondedAt/:respondedAt', HttpMethod.post, List<BrandAmbassador>),
	getManyBySignedAt('/brandAmbassador/bySignedAt/:signedAt', HttpMethod.post, List<BrandAmbassador>),
	getManyByActualReach('/brandAmbassador/byActualReach/:actualReach', HttpMethod.post, List<BrandAmbassador>),
	getManyByTotalRoi('/brandAmbassador/byTotalRoi/:totalRoi', HttpMethod.post, List<BrandAmbassador>),
	getManyByCreatedAt('/brandAmbassador/byCreatedAt/:createdAt', HttpMethod.post, List<BrandAmbassador>),
	getManyByUpdatedAt('/brandAmbassador/byUpdatedAt/:updatedAt', HttpMethod.post, List<BrandAmbassador>),
	getManyByDeletedAt('/brandAmbassador/byDeletedAt/:deletedAt', HttpMethod.post, List<BrandAmbassador>);

    const BrandAmbassadorEndpoints(this.path, this.method, this.responseType);

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
