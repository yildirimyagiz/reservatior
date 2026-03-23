
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class ListingTagStore extends ModelStreamStore<String, ListingTag> {

  static ListingTagStore? _instance;

  static ListingTagStore get instance {
    _instance ??= ListingTagStore();
    return _instance!;
  }

  ListingTagStore() : super(ListingTag.fromJson) {
    if (_instance != null) {
        throw Exception(
            'ListingTagStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending ListingTagStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use ListingTagStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getListingTagId(ListingTag listingTag) => listingTag.id;

	String? getListingTagListingId(ListingTag listingTag) => listingTag.listingId;

	String? getListingTagTagId(ListingTag listingTag) => listingTag.tagId;

	String? getListingTagOrgId(ListingTag listingTag) => listingTag.orgId;

	DateTime? getListingTagCreatedAt(ListingTag listingTag) => listingTag.createdAt;

	DateTime? getListingTagUpdatedAt(ListingTag listingTag) => listingTag.updatedAt;

	DateTime? getListingTagDeletedAt(ListingTag listingTag) => listingTag.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<ListingTag> getByListingId(
    String listingId,
    {ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}
    ) =>
    getManyIncluding(getListingTagListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<ListingTag> getByTagId(
    String tagId,
    {ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}
    ) =>
    getManyIncluding(getListingTagTagId, tagId, modelFilter: modelFilter, includes: includes);

	
List<ListingTag> getByOrgId(
    String orgId,
    {ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}
    ) =>
    getManyIncluding(getListingTagOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<ListingTag> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}
    ) =>
    getManyIncluding(getListingTagCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<ListingTag> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}
    ) =>
    getManyIncluding(getListingTagUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<ListingTag> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}
    ) =>
    getManyIncluding(getListingTagDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Listing? getListing(
    ListingTag listingTag, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (listingTag.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(listingTag.listingId!, includes: includes);
        listingTag.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    ListingTag listingTag, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (listingTag.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(listingTag.orgId!, includes: includes);
        listingTag.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Tag? getTag(
    ListingTag listingTag, {ModelFilter? modelFilter, List<TagInclude>? includes}) {
    if (listingTag.tagId == null) {
        return null;
    } else {
        final tag = TagStore.instance.getById(listingTag.tagId!, includes: includes);
        listingTag.tag = tag;
        // setIncludedReferences(tag, includes: includes);
        return tag;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<ListingTag>> getAll$({bool useCache = true, ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: ListingTagEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<ListingTag?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<ListingTag>? modelFilter,
        List<ListingTagInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getListingTagId,
        value: id,
        modelFilter: modelFilter,
        endpoint: ListingTagEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<ListingTag>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<ListingTag>? modelFilter,
        List<ListingTagInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingTagListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: ListingTagEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingTag>> getByTagId$(
        String tagId,
        {bool useCache = true,
        ModelFilter<ListingTag>? modelFilter,
        List<ListingTagInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingTagTagId,
        value: tagId,
        modelFilter: modelFilter,
        endpoint: ListingTagEndpoints.getManyByTagId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingTag>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<ListingTag>? modelFilter,
        List<ListingTagInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getListingTagOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: ListingTagEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingTag>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<ListingTag>? modelFilter,
        List<ListingTagInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingTagCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: ListingTagEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingTag>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<ListingTag>? modelFilter,
        List<ListingTagInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingTagUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: ListingTagEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<ListingTag>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<ListingTag>? modelFilter,
        List<ListingTagInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getListingTagDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: ListingTagEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Listing?> getListing$(
    ListingTag listingTag, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (listingTag.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            listingTag.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            listingTag.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    ListingTag listingTag, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (listingTag.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            listingTag.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            listingTag.org = org;
        });
    }
}

	Stream<Tag?> getTag$(
    ListingTag listingTag, {bool useCache = true, ModelFilter<Tag>? modelFilter, List<TagInclude>? includes}) {
    if (listingTag.tagId == null) {
        return Stream.value(null);
    } else {
        return TagStore.instance.getById$(
            listingTag.tagId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((tag) {
            listingTag.tag = tag;
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
ListingTag recursiveUpsert(ListingTag listingTag, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'ListingTag'} 
        : const {};
    if (listingTag.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        listingTag.listing = ListingStore.instance.recursiveUpsert(listingTag.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listingTag.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        listingTag.org = OrganizationStore.instance.recursiveUpsert(listingTag.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (listingTag.tag != null && (!preventCircularSerialization || !upsertedTypes.contains('Tag'))) {
        listingTag.tag = TagStore.instance.recursiveUpsert(listingTag.tag!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(listingTag);
}

  List<ListingTag> recursiveListUpsert(List<ListingTag> listingTags, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedListingTags = <ListingTag>[];
    for (var listingTag in listingTags) {
        updatedListingTags.add(recursiveUpsert(listingTag, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedListingTags;
}

//   @override
//   ListingTag upsert(ListingTag item) {
//     return recursiveUpsert(item);
//   }

}


class ListingTagInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      ListingTagInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listingTag) => ListingTagStore.instance
            .getListing$(listingTag, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listingTag) => ListingTagStore.instance
            .getListing(listingTag, modelFilter: modelFilter, includes: includes);
      }
}

	ListingTagInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listingTag) => ListingTagStore.instance
            .getOrg$(listingTag, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listingTag) => ListingTagStore.instance
            .getOrg(listingTag, modelFilter: modelFilter, includes: includes);
      }
}

	ListingTagInclude.tag({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Tag>? modelFilter,
    List<TagInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (listingTag) => ListingTagStore.instance
            .getTag$(listingTag, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (listingTag) => ListingTagStore.instance
            .getTag(listingTag, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum ListingTagEndpoints implements Endpoint {

    getAll('/listingTag', HttpMethod.post, List<ListingTag>),
	getById('/listingTag/byId/:id', HttpMethod.post, ListingTag),
	getManyByListingId('/listingTag/byListingId/:listingId', HttpMethod.post, List<ListingTag>),
	getManyByTagId('/listingTag/byTagId/:tagId', HttpMethod.post, List<ListingTag>),
	getManyByOrgId('/listingTag/byOrgId/:orgId', HttpMethod.post, List<ListingTag>),
	getManyByCreatedAt('/listingTag/byCreatedAt/:createdAt', HttpMethod.post, List<ListingTag>),
	getManyByUpdatedAt('/listingTag/byUpdatedAt/:updatedAt', HttpMethod.post, List<ListingTag>),
	getManyByDeletedAt('/listingTag/byDeletedAt/:deletedAt', HttpMethod.post, List<ListingTag>);

    const ListingTagEndpoints(this.path, this.method, this.responseType);

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
