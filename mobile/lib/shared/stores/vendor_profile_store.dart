
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class VendorProfileStore extends ModelStreamStore<String, VendorProfile> {

  static VendorProfileStore? _instance;

  static VendorProfileStore get instance {
    _instance ??= VendorProfileStore();
    return _instance!;
  }

  VendorProfileStore() : super(VendorProfile.fromJson) {
    if (_instance != null) {
        throw Exception(
            'VendorProfileStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending VendorProfileStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use VendorProfileStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getVendorProfileId(VendorProfile vendorProfile) => vendorProfile.id;

	String? getVendorProfileOrgId(VendorProfile vendorProfile) => vendorProfile.orgId;

	String? getVendorProfileLegalName(VendorProfile vendorProfile) => vendorProfile.legalName;

	String? getVendorProfileServiceAreas(VendorProfile vendorProfile) => vendorProfile.serviceAreas;

	int? getVendorProfileDefaultCommissionBps(VendorProfile vendorProfile) => vendorProfile.defaultCommissionBps;

	DateTime? getVendorProfileCreatedAt(VendorProfile vendorProfile) => vendorProfile.createdAt;

	DateTime? getVendorProfileUpdatedAt(VendorProfile vendorProfile) => vendorProfile.updatedAt;

	DateTime? getVendorProfileDeletedAt(VendorProfile vendorProfile) => vendorProfile.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<VendorProfile> getByOrgId(
    String orgId,
    {ModelFilter<VendorProfile>? modelFilter, List<VendorProfileInclude>? includes}
    ) =>
    getManyIncluding(getVendorProfileOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<VendorProfile> getByLegalName(
    String legalName,
    {ModelFilter<VendorProfile>? modelFilter, List<VendorProfileInclude>? includes}
    ) =>
    getManyIncluding(getVendorProfileLegalName, legalName, modelFilter: modelFilter, includes: includes);

	
List<VendorProfile> getByServiceAreas(
    String serviceAreas,
    {ModelFilter<VendorProfile>? modelFilter, List<VendorProfileInclude>? includes}
    ) =>
    getManyIncluding(getVendorProfileServiceAreas, serviceAreas, modelFilter: modelFilter, includes: includes);

	
List<VendorProfile> getByDefaultCommissionBps(
    int defaultCommissionBps,
    {ModelFilter<VendorProfile>? modelFilter, List<VendorProfileInclude>? includes}
    ) =>
    getManyIncluding(getVendorProfileDefaultCommissionBps, defaultCommissionBps, modelFilter: modelFilter, includes: includes);

	
List<VendorProfile> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<VendorProfile>? modelFilter, List<VendorProfileInclude>? includes}
    ) =>
    getManyIncluding(getVendorProfileCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<VendorProfile> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<VendorProfile>? modelFilter, List<VendorProfileInclude>? includes}
    ) =>
    getManyIncluding(getVendorProfileUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<VendorProfile> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<VendorProfile>? modelFilter, List<VendorProfileInclude>? includes}
    ) =>
    getManyIncluding(getVendorProfileDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    VendorProfile vendorProfile, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (vendorProfile.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(vendorProfile.orgId!, includes: includes);
        vendorProfile.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<VendorProfile>> getAll$({bool useCache = true, ModelFilter<VendorProfile>? modelFilter, List<VendorProfileInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: VendorProfileEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<VendorProfile?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<VendorProfile>? modelFilter,
        List<VendorProfileInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getVendorProfileId,
        value: id,
        modelFilter: modelFilter,
        endpoint: VendorProfileEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<VendorProfile>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<VendorProfile>? modelFilter,
        List<VendorProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVendorProfileOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: VendorProfileEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VendorProfile>> getByLegalName$(
        String legalName,
        {bool useCache = true,
        ModelFilter<VendorProfile>? modelFilter,
        List<VendorProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVendorProfileLegalName,
        value: legalName,
        modelFilter: modelFilter,
        endpoint: VendorProfileEndpoints.getManyByLegalName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VendorProfile>> getByServiceAreas$(
        String serviceAreas,
        {bool useCache = true,
        ModelFilter<VendorProfile>? modelFilter,
        List<VendorProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getVendorProfileServiceAreas,
        value: serviceAreas,
        modelFilter: modelFilter,
        endpoint: VendorProfileEndpoints.getManyByServiceAreas,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VendorProfile>> getByDefaultCommissionBps$(
        int defaultCommissionBps,
        {bool useCache = true,
        ModelFilter<VendorProfile>? modelFilter,
        List<VendorProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getVendorProfileDefaultCommissionBps,
        value: defaultCommissionBps,
        modelFilter: modelFilter,
        endpoint: VendorProfileEndpoints.getManyByDefaultCommissionBps,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VendorProfile>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<VendorProfile>? modelFilter,
        List<VendorProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVendorProfileCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: VendorProfileEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VendorProfile>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<VendorProfile>? modelFilter,
        List<VendorProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVendorProfileUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: VendorProfileEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<VendorProfile>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<VendorProfile>? modelFilter,
        List<VendorProfileInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getVendorProfileDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: VendorProfileEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    VendorProfile vendorProfile, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (vendorProfile.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            vendorProfile.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            vendorProfile.org = org;
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
VendorProfile recursiveUpsert(VendorProfile vendorProfile, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'VendorProfile'} 
        : const {};
    if (vendorProfile.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        vendorProfile.org = OrganizationStore.instance.recursiveUpsert(vendorProfile.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(vendorProfile);
}

  List<VendorProfile> recursiveListUpsert(List<VendorProfile> vendorProfiles, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedVendorProfiles = <VendorProfile>[];
    for (var vendorProfile in vendorProfiles) {
        updatedVendorProfiles.add(recursiveUpsert(vendorProfile, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedVendorProfiles;
}

//   @override
//   VendorProfile upsert(VendorProfile item) {
//     return recursiveUpsert(item);
//   }

}


class VendorProfileInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      VendorProfileInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (vendorProfile) => VendorProfileStore.instance
            .getOrg$(vendorProfile, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (vendorProfile) => VendorProfileStore.instance
            .getOrg(vendorProfile, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum VendorProfileEndpoints implements Endpoint {

    getAll('/vendorProfile', HttpMethod.post, List<VendorProfile>),
	getById('/vendorProfile/byId/:id', HttpMethod.post, VendorProfile),
	getManyByOrgId('/vendorProfile/byOrgId/:orgId', HttpMethod.post, List<VendorProfile>),
	getManyByLegalName('/vendorProfile/byLegalName/:legalName', HttpMethod.post, List<VendorProfile>),
	getManyByServiceAreas('/vendorProfile/byServiceAreas/:serviceAreas', HttpMethod.post, List<VendorProfile>),
	getManyByDefaultCommissionBps('/vendorProfile/byDefaultCommissionBps/:defaultCommissionBps', HttpMethod.post, List<VendorProfile>),
	getManyByCreatedAt('/vendorProfile/byCreatedAt/:createdAt', HttpMethod.post, List<VendorProfile>),
	getManyByUpdatedAt('/vendorProfile/byUpdatedAt/:updatedAt', HttpMethod.post, List<VendorProfile>),
	getManyByDeletedAt('/vendorProfile/byDeletedAt/:deletedAt', HttpMethod.post, List<VendorProfile>);

    const VendorProfileEndpoints(this.path, this.method, this.responseType);

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
