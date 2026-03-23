
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class TenantApplicationStore extends ModelStreamStore<String, TenantApplication> {

  static TenantApplicationStore? _instance;

  static TenantApplicationStore get instance {
    _instance ??= TenantApplicationStore();
    return _instance!;
  }

  TenantApplicationStore() : super(TenantApplication.fromJson) {
    if (_instance != null) {
        throw Exception(
            'TenantApplicationStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending TenantApplicationStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use TenantApplicationStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getTenantApplicationId(TenantApplication tenantApplication) => tenantApplication.id;

	String? getTenantApplicationPropertyId(TenantApplication tenantApplication) => tenantApplication.propertyId;

	String? getTenantApplicationListingId(TenantApplication tenantApplication) => tenantApplication.listingId;

	String? getTenantApplicationApplicantId(TenantApplication tenantApplication) => tenantApplication.applicantId;

	ApplicationStatus? getTenantApplicationStatus(TenantApplication tenantApplication) => tenantApplication.status;

	DateTime? getTenantApplicationSubmittedAt(TenantApplication tenantApplication) => tenantApplication.submittedAt;

	DateTime? getTenantApplicationReviewedAt(TenantApplication tenantApplication) => tenantApplication.reviewedAt;

	String? getTenantApplicationReviewedBy(TenantApplication tenantApplication) => tenantApplication.reviewedBy;

	dynamic? getTenantApplicationApplicationData(TenantApplication tenantApplication) => tenantApplication.applicationData;

	int? getTenantApplicationCreditScore(TenantApplication tenantApplication) => tenantApplication.creditScore;

	bool? getTenantApplicationIncomeVerified(TenantApplication tenantApplication) => tenantApplication.incomeVerified;

	bool? getTenantApplicationBackgroundCheck(TenantApplication tenantApplication) => tenantApplication.backgroundCheck;

	String? getTenantApplicationOrganizationId(TenantApplication tenantApplication) => tenantApplication.organizationId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<TenantApplication> getByPropertyId(
    String propertyId,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<TenantApplication> getByListingId(
    String listingId,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<TenantApplication> getByApplicantId(
    String applicantId,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationApplicantId, applicantId, modelFilter: modelFilter, includes: includes);

	
List<TenantApplication> getByStatus(
    ApplicationStatus status,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationStatus, status, modelFilter: modelFilter, includes: includes);

	
List<TenantApplication> getBySubmittedAt(
    DateTime submittedAt,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationSubmittedAt, submittedAt, modelFilter: modelFilter, includes: includes);

	
List<TenantApplication> getByReviewedAt(
    DateTime reviewedAt,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationReviewedAt, reviewedAt, modelFilter: modelFilter, includes: includes);

	
List<TenantApplication> getByReviewedBy(
    String reviewedBy,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationReviewedBy, reviewedBy, modelFilter: modelFilter, includes: includes);

	
List<TenantApplication> getByApplicationData(
    dynamic applicationData,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationApplicationData, applicationData, modelFilter: modelFilter, includes: includes);

	
List<TenantApplication> getByCreditScore(
    int creditScore,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationCreditScore, creditScore, modelFilter: modelFilter, includes: includes);

	
List<TenantApplication> getByIncomeVerified(
    bool incomeVerified,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationIncomeVerified, incomeVerified, modelFilter: modelFilter, includes: includes);

	
List<TenantApplication> getByBackgroundCheck(
    bool backgroundCheck,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationBackgroundCheck, backgroundCheck, modelFilter: modelFilter, includes: includes);

	
List<TenantApplication> getByOrganizationId(
    String organizationId,
    {ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}
    ) =>
    getManyIncluding(getTenantApplicationOrganizationId, organizationId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getApplicant(
    TenantApplication tenantApplication, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (tenantApplication.applicantId == null) {
        return null;
    } else {
        final applicant = ContactStore.instance.getById(tenantApplication.applicantId!, includes: includes);
        tenantApplication.applicant = applicant;
        // setIncludedReferences(applicant, includes: includes);
        return applicant;
    }
}

	Listing? getListing(
    TenantApplication tenantApplication, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (tenantApplication.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(tenantApplication.listingId!, includes: includes);
        tenantApplication.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrganization(
    TenantApplication tenantApplication, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (tenantApplication.organizationId == null) {
        return null;
    } else {
        final organization = OrganizationStore.instance.getById(tenantApplication.organizationId!, includes: includes);
        tenantApplication.organization = organization;
        // setIncludedReferences(organization, includes: includes);
        return organization;
    }
}

	Property? getProperty(
    TenantApplication tenantApplication, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (tenantApplication.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(tenantApplication.propertyId!, includes: includes);
        tenantApplication.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<TenantApplication>> getAll$({bool useCache = true, ModelFilter<TenantApplication>? modelFilter, List<TenantApplicationInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: TenantApplicationEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<TenantApplication?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getTenantApplicationId,
        value: id,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<TenantApplication>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTenantApplicationPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TenantApplication>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTenantApplicationListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TenantApplication>> getByApplicantId$(
        String applicantId,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTenantApplicationApplicantId,
        value: applicantId,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyByApplicantId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TenantApplication>> getByStatus$(
        ApplicationStatus status,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<ApplicationStatus>(
        getPropVal: getTenantApplicationStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TenantApplication>> getBySubmittedAt$(
        DateTime submittedAt,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTenantApplicationSubmittedAt,
        value: submittedAt,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyBySubmittedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TenantApplication>> getByReviewedAt$(
        DateTime reviewedAt,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTenantApplicationReviewedAt,
        value: reviewedAt,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyByReviewedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TenantApplication>> getByReviewedBy$(
        String reviewedBy,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTenantApplicationReviewedBy,
        value: reviewedBy,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyByReviewedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TenantApplication>> getByApplicationData$(
        dynamic applicationData,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getTenantApplicationApplicationData,
        value: applicationData,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyByApplicationData,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TenantApplication>> getByCreditScore$(
        int creditScore,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getTenantApplicationCreditScore,
        value: creditScore,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyByCreditScore,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TenantApplication>> getByIncomeVerified$(
        bool incomeVerified,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getTenantApplicationIncomeVerified,
        value: incomeVerified,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyByIncomeVerified,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TenantApplication>> getByBackgroundCheck$(
        bool backgroundCheck,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getTenantApplicationBackgroundCheck,
        value: backgroundCheck,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyByBackgroundCheck,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<TenantApplication>> getByOrganizationId$(
        String organizationId,
        {bool useCache = true,
        ModelFilter<TenantApplication>? modelFilter,
        List<TenantApplicationInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTenantApplicationOrganizationId,
        value: organizationId,
        modelFilter: modelFilter,
        endpoint: TenantApplicationEndpoints.getManyByOrganizationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getApplicant$(
    TenantApplication tenantApplication, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (tenantApplication.applicantId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            tenantApplication.applicantId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((applicant) {
            tenantApplication.applicant = applicant;
        });
    }
}

	Stream<Listing?> getListing$(
    TenantApplication tenantApplication, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (tenantApplication.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            tenantApplication.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            tenantApplication.listing = listing;
        });
    }
}

	Stream<Organization?> getOrganization$(
    TenantApplication tenantApplication, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (tenantApplication.organizationId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            tenantApplication.organizationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((organization) {
            tenantApplication.organization = organization;
        });
    }
}

	Stream<Property?> getProperty$(
    TenantApplication tenantApplication, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (tenantApplication.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            tenantApplication.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            tenantApplication.property = property;
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
TenantApplication recursiveUpsert(TenantApplication tenantApplication, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'TenantApplication'} 
        : const {};
    if (tenantApplication.applicant != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        tenantApplication.applicant = ContactStore.instance.recursiveUpsert(tenantApplication.applicant!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenantApplication.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        tenantApplication.listing = ListingStore.instance.recursiveUpsert(tenantApplication.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenantApplication.organization != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        tenantApplication.organization = OrganizationStore.instance.recursiveUpsert(tenantApplication.organization!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tenantApplication.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        tenantApplication.property = PropertyStore.instance.recursiveUpsert(tenantApplication.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(tenantApplication);
}

  List<TenantApplication> recursiveListUpsert(List<TenantApplication> tenantApplications, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedTenantApplications = <TenantApplication>[];
    for (var tenantApplication in tenantApplications) {
        updatedTenantApplications.add(recursiveUpsert(tenantApplication, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedTenantApplications;
}

//   @override
//   TenantApplication upsert(TenantApplication item) {
//     return recursiveUpsert(item);
//   }

}


class TenantApplicationInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      TenantApplicationInclude.applicant({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenantApplication) => TenantApplicationStore.instance
            .getApplicant$(tenantApplication, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenantApplication) => TenantApplicationStore.instance
            .getApplicant(tenantApplication, modelFilter: modelFilter, includes: includes);
      }
}

	TenantApplicationInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenantApplication) => TenantApplicationStore.instance
            .getListing$(tenantApplication, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenantApplication) => TenantApplicationStore.instance
            .getListing(tenantApplication, modelFilter: modelFilter, includes: includes);
      }
}

	TenantApplicationInclude.organization({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenantApplication) => TenantApplicationStore.instance
            .getOrganization$(tenantApplication, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenantApplication) => TenantApplicationStore.instance
            .getOrganization(tenantApplication, modelFilter: modelFilter, includes: includes);
      }
}

	TenantApplicationInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tenantApplication) => TenantApplicationStore.instance
            .getProperty$(tenantApplication, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tenantApplication) => TenantApplicationStore.instance
            .getProperty(tenantApplication, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum TenantApplicationEndpoints implements Endpoint {

    getAll('/tenantApplication', HttpMethod.post, List<TenantApplication>),
	getById('/tenantApplication/byId/:id', HttpMethod.post, TenantApplication),
	getManyByPropertyId('/tenantApplication/byPropertyId/:propertyId', HttpMethod.post, List<TenantApplication>),
	getManyByListingId('/tenantApplication/byListingId/:listingId', HttpMethod.post, List<TenantApplication>),
	getManyByApplicantId('/tenantApplication/byApplicantId/:applicantId', HttpMethod.post, List<TenantApplication>),
	getManyByStatus('/tenantApplication/byStatus/:status', HttpMethod.post, List<TenantApplication>),
	getManyBySubmittedAt('/tenantApplication/bySubmittedAt/:submittedAt', HttpMethod.post, List<TenantApplication>),
	getManyByReviewedAt('/tenantApplication/byReviewedAt/:reviewedAt', HttpMethod.post, List<TenantApplication>),
	getManyByReviewedBy('/tenantApplication/byReviewedBy/:reviewedBy', HttpMethod.post, List<TenantApplication>),
	getManyByApplicationData('/tenantApplication/byApplicationData/:applicationData', HttpMethod.post, List<TenantApplication>),
	getManyByCreditScore('/tenantApplication/byCreditScore/:creditScore', HttpMethod.post, List<TenantApplication>),
	getManyByIncomeVerified('/tenantApplication/byIncomeVerified/:incomeVerified', HttpMethod.post, List<TenantApplication>),
	getManyByBackgroundCheck('/tenantApplication/byBackgroundCheck/:backgroundCheck', HttpMethod.post, List<TenantApplication>),
	getManyByOrganizationId('/tenantApplication/byOrganizationId/:organizationId', HttpMethod.post, List<TenantApplication>);

    const TenantApplicationEndpoints(this.path, this.method, this.responseType);

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
