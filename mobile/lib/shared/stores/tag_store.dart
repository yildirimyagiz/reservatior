
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class TagStore extends ModelStreamStore<String, Tag> {

  static TagStore? _instance;

  static TagStore get instance {
    _instance ??= TagStore();
    return _instance!;
  }

  TagStore() : super(Tag.fromJson) {
    if (_instance != null) {
        throw Exception(
            'TagStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending TagStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use TagStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getTagId(Tag tag) => tag.id;

	String? getTagOrgId(Tag tag) => tag.orgId;

	String? getTagName(Tag tag) => tag.name;

	String? getTagColor(Tag tag) => tag.color;

	DateTime? getTagCreatedAt(Tag tag) => tag.createdAt;

	DateTime? getTagUpdatedAt(Tag tag) => tag.updatedAt;

	DateTime? getTagDeletedAt(Tag tag) => tag.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Tag> getByOrgId(
    String orgId,
    {ModelFilter<Tag>? modelFilter, List<TagInclude>? includes}
    ) =>
    getManyIncluding(getTagOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Tag> getByName(
    String name,
    {ModelFilter<Tag>? modelFilter, List<TagInclude>? includes}
    ) =>
    getManyIncluding(getTagName, name, modelFilter: modelFilter, includes: includes);

	
List<Tag> getByColor(
    String color,
    {ModelFilter<Tag>? modelFilter, List<TagInclude>? includes}
    ) =>
    getManyIncluding(getTagColor, color, modelFilter: modelFilter, includes: includes);

	
List<Tag> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Tag>? modelFilter, List<TagInclude>? includes}
    ) =>
    getManyIncluding(getTagCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Tag> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Tag>? modelFilter, List<TagInclude>? includes}
    ) =>
    getManyIncluding(getTagUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Tag> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Tag>? modelFilter, List<TagInclude>? includes}
    ) =>
    getManyIncluding(getTagDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Tag tag, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (tag.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(tag.orgId!, includes: includes);
        tag.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<ListingTag> getListingTags(
    Tag tag, {ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}) {
    final listingTags = ListingTagStore.instance.getByTagId(tag.$uid!, modelFilter: modelFilter, includes: includes);
    tag.listingTags = listingTags;
    // setIncludedReferencesForList(listingTags, includes: includes);
    return listingTags;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Tag>> getAll$({bool useCache = true, ModelFilter<Tag>? modelFilter, List<TagInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: TagEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Tag?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Tag>? modelFilter,
        List<TagInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getTagId,
        value: id,
        modelFilter: modelFilter,
        endpoint: TagEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Tag>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Tag>? modelFilter,
        List<TagInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTagOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: TagEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tag>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Tag>? modelFilter,
        List<TagInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTagName,
        value: name,
        modelFilter: modelFilter,
        endpoint: TagEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tag>> getByColor$(
        String color,
        {bool useCache = true,
        ModelFilter<Tag>? modelFilter,
        List<TagInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTagColor,
        value: color,
        modelFilter: modelFilter,
        endpoint: TagEndpoints.getManyByColor,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tag>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Tag>? modelFilter,
        List<TagInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTagCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: TagEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tag>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Tag>? modelFilter,
        List<TagInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTagUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: TagEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Tag>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Tag>? modelFilter,
        List<TagInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTagDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: TagEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Tag tag, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (tag.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            tag.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            tag.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<ListingTag>> getListingTags$(
    Tag tag, {bool useCache = true, ModelFilter<ListingTag>? modelFilter, List<ListingTagInclude>? includes}) {
    return ListingTagStore.instance.getByTagId$(
        tag.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((listingTags) {
        tag.listingTags = listingTags;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Tag recursiveUpsert(Tag tag, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Tag'} 
        : const {};
    if (tag.listingTags != null && (!preventCircularSerialization || !upsertedTypes.contains('ListingTag'))) {
        tag.listingTags = ListingTagStore.instance.recursiveListUpsert(tag.listingTags!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (tag.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        tag.org = OrganizationStore.instance.recursiveUpsert(tag.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(tag);
}

  List<Tag> recursiveListUpsert(List<Tag> tags, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedTags = <Tag>[];
    for (var tag in tags) {
        updatedTags.add(recursiveUpsert(tag, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedTags;
}

//   @override
//   Tag upsert(Tag item) {
//     return recursiveUpsert(item);
//   }

}


class TagInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      TagInclude.listingTags({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ListingTag>? modelFilter,
    List<ListingTagInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tag) => TagStore.instance
            .getListingTags$(tag, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tag) => TagStore.instance
            .getListingTags(tag, modelFilter: modelFilter, includes: includes);
      }
}

	TagInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (tag) => TagStore.instance
            .getOrg$(tag, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (tag) => TagStore.instance
            .getOrg(tag, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum TagEndpoints implements Endpoint {

    getAll('/tag', HttpMethod.post, List<Tag>),
	getById('/tag/byId/:id', HttpMethod.post, Tag),
	getManyByOrgId('/tag/byOrgId/:orgId', HttpMethod.post, List<Tag>),
	getManyByName('/tag/byName/:name', HttpMethod.post, List<Tag>),
	getManyByColor('/tag/byColor/:color', HttpMethod.post, List<Tag>),
	getManyByCreatedAt('/tag/byCreatedAt/:createdAt', HttpMethod.post, List<Tag>),
	getManyByUpdatedAt('/tag/byUpdatedAt/:updatedAt', HttpMethod.post, List<Tag>),
	getManyByDeletedAt('/tag/byDeletedAt/:deletedAt', HttpMethod.post, List<Tag>);

    const TagEndpoints(this.path, this.method, this.responseType);

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
