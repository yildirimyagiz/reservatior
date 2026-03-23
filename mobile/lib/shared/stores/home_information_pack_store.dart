
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class HomeInformationPackStore extends ModelStreamStore<String, HomeInformationPack> {

  static HomeInformationPackStore? _instance;

  static HomeInformationPackStore get instance {
    _instance ??= HomeInformationPackStore();
    return _instance!;
  }

  HomeInformationPackStore() : super(HomeInformationPack.fromJson) {
    if (_instance != null) {
        throw Exception(
            'HomeInformationPackStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending HomeInformationPackStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use HomeInformationPackStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getHomeInformationPackId(HomeInformationPack homeInformationPack) => homeInformationPack.id;

	String? getHomeInformationPackOrgId(HomeInformationPack homeInformationPack) => homeInformationPack.orgId;

	String? getHomeInformationPackPropertyId(HomeInformationPack homeInformationPack) => homeInformationPack.propertyId;

	String? getHomeInformationPackTitle(HomeInformationPack homeInformationPack) => homeInformationPack.title;

	String? getHomeInformationPackDescription(HomeInformationPack homeInformationPack) => homeInformationPack.description;

	String? getHomeInformationPackFileUrl(HomeInformationPack homeInformationPack) => homeInformationPack.fileUrl;

	String? getHomeInformationPackFileName(HomeInformationPack homeInformationPack) => homeInformationPack.fileName;

	int? getHomeInformationPackFileSize(HomeInformationPack homeInformationPack) => homeInformationPack.fileSize;

	String? getHomeInformationPackMimeType(HomeInformationPack homeInformationPack) => homeInformationPack.mimeType;

	String? getHomeInformationPackChecksum(HomeInformationPack homeInformationPack) => homeInformationPack.checksum;

	int? getHomeInformationPackVersion(HomeInformationPack homeInformationPack) => homeInformationPack.version;

	bool? getHomeInformationPackIsActive(HomeInformationPack homeInformationPack) => homeInformationPack.isActive;

	String? getHomeInformationPackCreatedBy(HomeInformationPack homeInformationPack) => homeInformationPack.createdBy;

	DateTime? getHomeInformationPackCreatedAt(HomeInformationPack homeInformationPack) => homeInformationPack.createdAt;

	DateTime? getHomeInformationPackUpdatedAt(HomeInformationPack homeInformationPack) => homeInformationPack.updatedAt;

	DateTime? getHomeInformationPackDeletedAt(HomeInformationPack homeInformationPack) => homeInformationPack.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
HomeInformationPack? getByPropertyId(
    String propertyId,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getIncluding(getHomeInformationPackPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

  
List<HomeInformationPack> getByOrgId(
    String orgId,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByTitle(
    String title,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackTitle, title, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByDescription(
    String description,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackDescription, description, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByFileUrl(
    String fileUrl,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackFileUrl, fileUrl, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByFileName(
    String fileName,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackFileName, fileName, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByFileSize(
    int fileSize,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackFileSize, fileSize, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByMimeType(
    String mimeType,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackMimeType, mimeType, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByChecksum(
    String checksum,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackChecksum, checksum, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByVersion(
    int version,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackVersion, version, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByIsActive(
    bool isActive,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackIsActive, isActive, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByCreatedBy(
    String createdBy,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<HomeInformationPack> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}
    ) =>
    getManyIncluding(getHomeInformationPackDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    HomeInformationPack homeInformationPack, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (homeInformationPack.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(homeInformationPack.orgId!, includes: includes);
        homeInformationPack.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    HomeInformationPack homeInformationPack, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (homeInformationPack.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(homeInformationPack.propertyId!, includes: includes);
        homeInformationPack.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<HomeInformationPack>> getAll$({bool useCache = true, ModelFilter<HomeInformationPack>? modelFilter, List<HomeInformationPackInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: HomeInformationPackEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<HomeInformationPack?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getHomeInformationPackId,
        value: id,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<HomeInformationPack?> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getHomeInformationPackPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<HomeInformationPack>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHomeInformationPackOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHomeInformationPackTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHomeInformationPackDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByFileUrl$(
        String fileUrl,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHomeInformationPackFileUrl,
        value: fileUrl,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByFileUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByFileName$(
        String fileName,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHomeInformationPackFileName,
        value: fileName,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByFileName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByFileSize$(
        int fileSize,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getHomeInformationPackFileSize,
        value: fileSize,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByFileSize,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByMimeType$(
        String mimeType,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHomeInformationPackMimeType,
        value: mimeType,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByMimeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByChecksum$(
        String checksum,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHomeInformationPackChecksum,
        value: checksum,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByChecksum,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByVersion$(
        int version,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getHomeInformationPackVersion,
        value: version,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByIsActive$(
        bool isActive,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getHomeInformationPackIsActive,
        value: isActive,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByIsActive,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getHomeInformationPackCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getHomeInformationPackCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getHomeInformationPackUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<HomeInformationPack>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<HomeInformationPack>? modelFilter,
        List<HomeInformationPackInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getHomeInformationPackDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: HomeInformationPackEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    HomeInformationPack homeInformationPack, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (homeInformationPack.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            homeInformationPack.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            homeInformationPack.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    HomeInformationPack homeInformationPack, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (homeInformationPack.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            homeInformationPack.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            homeInformationPack.property = property;
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
HomeInformationPack recursiveUpsert(HomeInformationPack homeInformationPack, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'HomeInformationPack'} 
        : const {};
    if (homeInformationPack.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        homeInformationPack.org = OrganizationStore.instance.recursiveUpsert(homeInformationPack.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (homeInformationPack.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        homeInformationPack.property = PropertyStore.instance.recursiveUpsert(homeInformationPack.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(homeInformationPack);
}

  List<HomeInformationPack> recursiveListUpsert(List<HomeInformationPack> homeInformationPacks, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedHomeInformationPacks = <HomeInformationPack>[];
    for (var homeInformationPack in homeInformationPacks) {
        updatedHomeInformationPacks.add(recursiveUpsert(homeInformationPack, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedHomeInformationPacks;
}

//   @override
//   HomeInformationPack upsert(HomeInformationPack item) {
//     return recursiveUpsert(item);
//   }

}


class HomeInformationPackInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      HomeInformationPackInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (homeInformationPack) => HomeInformationPackStore.instance
            .getOrg$(homeInformationPack, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (homeInformationPack) => HomeInformationPackStore.instance
            .getOrg(homeInformationPack, modelFilter: modelFilter, includes: includes);
      }
}

	HomeInformationPackInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (homeInformationPack) => HomeInformationPackStore.instance
            .getProperty$(homeInformationPack, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (homeInformationPack) => HomeInformationPackStore.instance
            .getProperty(homeInformationPack, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum HomeInformationPackEndpoints implements Endpoint {

    getAll('/homeInformationPack', HttpMethod.post, List<HomeInformationPack>),
	getById('/homeInformationPack/byId/:id', HttpMethod.post, HomeInformationPack),
	getManyByOrgId('/homeInformationPack/byOrgId/:orgId', HttpMethod.post, List<HomeInformationPack>),
	getByPropertyId('/homeInformationPack/byPropertyId/:propertyId', HttpMethod.post, HomeInformationPack),
	getManyByTitle('/homeInformationPack/byTitle/:title', HttpMethod.post, List<HomeInformationPack>),
	getManyByDescription('/homeInformationPack/byDescription/:description', HttpMethod.post, List<HomeInformationPack>),
	getManyByFileUrl('/homeInformationPack/byFileUrl/:fileUrl', HttpMethod.post, List<HomeInformationPack>),
	getManyByFileName('/homeInformationPack/byFileName/:fileName', HttpMethod.post, List<HomeInformationPack>),
	getManyByFileSize('/homeInformationPack/byFileSize/:fileSize', HttpMethod.post, List<HomeInformationPack>),
	getManyByMimeType('/homeInformationPack/byMimeType/:mimeType', HttpMethod.post, List<HomeInformationPack>),
	getManyByChecksum('/homeInformationPack/byChecksum/:checksum', HttpMethod.post, List<HomeInformationPack>),
	getManyByVersion('/homeInformationPack/byVersion/:version', HttpMethod.post, List<HomeInformationPack>),
	getManyByIsActive('/homeInformationPack/byIsActive/:isActive', HttpMethod.post, List<HomeInformationPack>),
	getManyByCreatedBy('/homeInformationPack/byCreatedBy/:createdBy', HttpMethod.post, List<HomeInformationPack>),
	getManyByCreatedAt('/homeInformationPack/byCreatedAt/:createdAt', HttpMethod.post, List<HomeInformationPack>),
	getManyByUpdatedAt('/homeInformationPack/byUpdatedAt/:updatedAt', HttpMethod.post, List<HomeInformationPack>),
	getManyByDeletedAt('/homeInformationPack/byDeletedAt/:deletedAt', HttpMethod.post, List<HomeInformationPack>);

    const HomeInformationPackEndpoints(this.path, this.method, this.responseType);

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
