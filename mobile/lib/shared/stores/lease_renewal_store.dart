
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class LeaseRenewalStore extends ModelStreamStore<String, LeaseRenewal> {

  static LeaseRenewalStore? _instance;

  static LeaseRenewalStore get instance {
    _instance ??= LeaseRenewalStore();
    return _instance!;
  }

  LeaseRenewalStore() : super(LeaseRenewal.fromJson) {
    if (_instance != null) {
        throw Exception(
            'LeaseRenewalStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending LeaseRenewalStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use LeaseRenewalStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getLeaseRenewalId(LeaseRenewal leaseRenewal) => leaseRenewal.id;

	String? getLeaseRenewalLeaseId(LeaseRenewal leaseRenewal) => leaseRenewal.leaseId;

	RenewalStatus? getLeaseRenewalStatus(LeaseRenewal leaseRenewal) => leaseRenewal.status;

	double? getLeaseRenewalProposedRent(LeaseRenewal leaseRenewal) => leaseRenewal.proposedRent;

	dynamic? getLeaseRenewalProposedTerms(LeaseRenewal leaseRenewal) => leaseRenewal.proposedTerms;

	DateTime? getLeaseRenewalRenewalDate(LeaseRenewal leaseRenewal) => leaseRenewal.renewalDate;

	DateTime? getLeaseRenewalResponseDeadline(LeaseRenewal leaseRenewal) => leaseRenewal.responseDeadline;

	String? getLeaseRenewalOrganizationId(LeaseRenewal leaseRenewal) => leaseRenewal.organizationId;

	String? getLeaseRenewalListingId(LeaseRenewal leaseRenewal) => leaseRenewal.listingId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<LeaseRenewal> getByLeaseId(
    String leaseId,
    {ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}
    ) =>
    getManyIncluding(getLeaseRenewalLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
List<LeaseRenewal> getByStatus(
    RenewalStatus status,
    {ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}
    ) =>
    getManyIncluding(getLeaseRenewalStatus, status, modelFilter: modelFilter, includes: includes);

	
List<LeaseRenewal> getByProposedRent(
    double proposedRent,
    {ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}
    ) =>
    getManyIncluding(getLeaseRenewalProposedRent, proposedRent, modelFilter: modelFilter, includes: includes);

	
List<LeaseRenewal> getByProposedTerms(
    dynamic proposedTerms,
    {ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}
    ) =>
    getManyIncluding(getLeaseRenewalProposedTerms, proposedTerms, modelFilter: modelFilter, includes: includes);

	
List<LeaseRenewal> getByRenewalDate(
    DateTime renewalDate,
    {ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}
    ) =>
    getManyIncluding(getLeaseRenewalRenewalDate, renewalDate, modelFilter: modelFilter, includes: includes);

	
List<LeaseRenewal> getByResponseDeadline(
    DateTime responseDeadline,
    {ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}
    ) =>
    getManyIncluding(getLeaseRenewalResponseDeadline, responseDeadline, modelFilter: modelFilter, includes: includes);

	
List<LeaseRenewal> getByOrganizationId(
    String organizationId,
    {ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}
    ) =>
    getManyIncluding(getLeaseRenewalOrganizationId, organizationId, modelFilter: modelFilter, includes: includes);

	
List<LeaseRenewal> getByListingId(
    String listingId,
    {ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}
    ) =>
    getManyIncluding(getLeaseRenewalListingId, listingId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Lease? getLease(
    LeaseRenewal leaseRenewal, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (leaseRenewal.leaseId == null) {
        return null;
    } else {
        final lease = LeaseStore.instance.getById(leaseRenewal.leaseId!, includes: includes);
        leaseRenewal.lease = lease;
        // setIncludedReferences(lease, includes: includes);
        return lease;
    }
}

	Listing? getListing(
    LeaseRenewal leaseRenewal, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (leaseRenewal.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(leaseRenewal.listingId!, includes: includes);
        leaseRenewal.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrganization(
    LeaseRenewal leaseRenewal, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (leaseRenewal.organizationId == null) {
        return null;
    } else {
        final organization = OrganizationStore.instance.getById(leaseRenewal.organizationId!, includes: includes);
        leaseRenewal.organization = organization;
        // setIncludedReferences(organization, includes: includes);
        return organization;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<LeaseRenewal>> getAll$({bool useCache = true, ModelFilter<LeaseRenewal>? modelFilter, List<LeaseRenewalInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: LeaseRenewalEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<LeaseRenewal?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<LeaseRenewal>? modelFilter,
        List<LeaseRenewalInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getLeaseRenewalId,
        value: id,
        modelFilter: modelFilter,
        endpoint: LeaseRenewalEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<LeaseRenewal>> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<LeaseRenewal>? modelFilter,
        List<LeaseRenewalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeaseRenewalLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: LeaseRenewalEndpoints.getManyByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeaseRenewal>> getByStatus$(
        RenewalStatus status,
        {bool useCache = true,
        ModelFilter<LeaseRenewal>? modelFilter,
        List<LeaseRenewalInclude>? includes}) {
    final items$ = getManyByFieldValue$<RenewalStatus>(
        getPropVal: getLeaseRenewalStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: LeaseRenewalEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeaseRenewal>> getByProposedRent$(
        double proposedRent,
        {bool useCache = true,
        ModelFilter<LeaseRenewal>? modelFilter,
        List<LeaseRenewalInclude>? includes}) {
    final items$ = getManyByFieldValue$<double>(
        getPropVal: getLeaseRenewalProposedRent,
        value: proposedRent,
        modelFilter: modelFilter,
        endpoint: LeaseRenewalEndpoints.getManyByProposedRent,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeaseRenewal>> getByProposedTerms$(
        dynamic proposedTerms,
        {bool useCache = true,
        ModelFilter<LeaseRenewal>? modelFilter,
        List<LeaseRenewalInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getLeaseRenewalProposedTerms,
        value: proposedTerms,
        modelFilter: modelFilter,
        endpoint: LeaseRenewalEndpoints.getManyByProposedTerms,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeaseRenewal>> getByRenewalDate$(
        DateTime renewalDate,
        {bool useCache = true,
        ModelFilter<LeaseRenewal>? modelFilter,
        List<LeaseRenewalInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeaseRenewalRenewalDate,
        value: renewalDate,
        modelFilter: modelFilter,
        endpoint: LeaseRenewalEndpoints.getManyByRenewalDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeaseRenewal>> getByResponseDeadline$(
        DateTime responseDeadline,
        {bool useCache = true,
        ModelFilter<LeaseRenewal>? modelFilter,
        List<LeaseRenewalInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getLeaseRenewalResponseDeadline,
        value: responseDeadline,
        modelFilter: modelFilter,
        endpoint: LeaseRenewalEndpoints.getManyByResponseDeadline,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeaseRenewal>> getByOrganizationId$(
        String organizationId,
        {bool useCache = true,
        ModelFilter<LeaseRenewal>? modelFilter,
        List<LeaseRenewalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeaseRenewalOrganizationId,
        value: organizationId,
        modelFilter: modelFilter,
        endpoint: LeaseRenewalEndpoints.getManyByOrganizationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<LeaseRenewal>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<LeaseRenewal>? modelFilter,
        List<LeaseRenewalInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getLeaseRenewalListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: LeaseRenewalEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Lease?> getLease$(
    LeaseRenewal leaseRenewal, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (leaseRenewal.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            leaseRenewal.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lease) {
            leaseRenewal.lease = lease;
        });
    }
}

	Stream<Listing?> getListing$(
    LeaseRenewal leaseRenewal, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (leaseRenewal.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            leaseRenewal.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            leaseRenewal.listing = listing;
        });
    }
}

	Stream<Organization?> getOrganization$(
    LeaseRenewal leaseRenewal, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (leaseRenewal.organizationId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            leaseRenewal.organizationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((organization) {
            leaseRenewal.organization = organization;
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
LeaseRenewal recursiveUpsert(LeaseRenewal leaseRenewal, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'LeaseRenewal'} 
        : const {};
    if (leaseRenewal.lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        leaseRenewal.lease = LeaseStore.instance.recursiveUpsert(leaseRenewal.lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (leaseRenewal.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        leaseRenewal.listing = ListingStore.instance.recursiveUpsert(leaseRenewal.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (leaseRenewal.organization != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        leaseRenewal.organization = OrganizationStore.instance.recursiveUpsert(leaseRenewal.organization!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(leaseRenewal);
}

  List<LeaseRenewal> recursiveListUpsert(List<LeaseRenewal> leaseRenewals, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedLeaseRenewals = <LeaseRenewal>[];
    for (var leaseRenewal in leaseRenewals) {
        updatedLeaseRenewals.add(recursiveUpsert(leaseRenewal, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedLeaseRenewals;
}

//   @override
//   LeaseRenewal upsert(LeaseRenewal item) {
//     return recursiveUpsert(item);
//   }

}


class LeaseRenewalInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      LeaseRenewalInclude.lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (leaseRenewal) => LeaseRenewalStore.instance
            .getLease$(leaseRenewal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (leaseRenewal) => LeaseRenewalStore.instance
            .getLease(leaseRenewal, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseRenewalInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (leaseRenewal) => LeaseRenewalStore.instance
            .getListing$(leaseRenewal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (leaseRenewal) => LeaseRenewalStore.instance
            .getListing(leaseRenewal, modelFilter: modelFilter, includes: includes);
      }
}

	LeaseRenewalInclude.organization({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (leaseRenewal) => LeaseRenewalStore.instance
            .getOrganization$(leaseRenewal, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (leaseRenewal) => LeaseRenewalStore.instance
            .getOrganization(leaseRenewal, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum LeaseRenewalEndpoints implements Endpoint {

    getAll('/leaseRenewal', HttpMethod.post, List<LeaseRenewal>),
	getById('/leaseRenewal/byId/:id', HttpMethod.post, LeaseRenewal),
	getManyByLeaseId('/leaseRenewal/byLeaseId/:leaseId', HttpMethod.post, List<LeaseRenewal>),
	getManyByStatus('/leaseRenewal/byStatus/:status', HttpMethod.post, List<LeaseRenewal>),
	getManyByProposedRent('/leaseRenewal/byProposedRent/:proposedRent', HttpMethod.post, List<LeaseRenewal>),
	getManyByProposedTerms('/leaseRenewal/byProposedTerms/:proposedTerms', HttpMethod.post, List<LeaseRenewal>),
	getManyByRenewalDate('/leaseRenewal/byRenewalDate/:renewalDate', HttpMethod.post, List<LeaseRenewal>),
	getManyByResponseDeadline('/leaseRenewal/byResponseDeadline/:responseDeadline', HttpMethod.post, List<LeaseRenewal>),
	getManyByOrganizationId('/leaseRenewal/byOrganizationId/:organizationId', HttpMethod.post, List<LeaseRenewal>),
	getManyByListingId('/leaseRenewal/byListingId/:listingId', HttpMethod.post, List<LeaseRenewal>);

    const LeaseRenewalEndpoints(this.path, this.method, this.responseType);

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
