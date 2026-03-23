
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class RoleStore extends ModelStreamStore<String, Role> {

  static RoleStore? _instance;

  static RoleStore get instance {
    _instance ??= RoleStore();
    return _instance!;
  }

  RoleStore() : super(Role.fromJson) {
    if (_instance != null) {
        throw Exception(
            'RoleStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending RoleStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use RoleStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getRoleId(Role role) => role.id;

	String? getRoleOrgId(Role role) => role.orgId;

	MemberRoleKey? getRoleKey(Role role) => role.key;

	String? getRoleName(Role role) => role.name;

	DateTime? getRoleCreatedAt(Role role) => role.createdAt;

	DateTime? getRoleUpdatedAt(Role role) => role.updatedAt;

	DateTime? getRoleDeletedAt(Role role) => role.deletedAt;

	String? getRoleLocationId(Role role) => role.locationId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Role> getByOrgId(
    String orgId,
    {ModelFilter<Role>? modelFilter, List<RoleInclude>? includes}
    ) =>
    getManyIncluding(getRoleOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Role> getByKeyField(
    MemberRoleKey key,
    {ModelFilter<Role>? modelFilter, List<RoleInclude>? includes}
    ) =>
    getManyIncluding(getRoleKey, key, modelFilter: modelFilter, includes: includes);

	
List<Role> getByName(
    String name,
    {ModelFilter<Role>? modelFilter, List<RoleInclude>? includes}
    ) =>
    getManyIncluding(getRoleName, name, modelFilter: modelFilter, includes: includes);

	
List<Role> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Role>? modelFilter, List<RoleInclude>? includes}
    ) =>
    getManyIncluding(getRoleCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Role> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Role>? modelFilter, List<RoleInclude>? includes}
    ) =>
    getManyIncluding(getRoleUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Role> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Role>? modelFilter, List<RoleInclude>? includes}
    ) =>
    getManyIncluding(getRoleDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Role> getByLocationId(
    String locationId,
    {ModelFilter<Role>? modelFilter, List<RoleInclude>? includes}
    ) =>
    getManyIncluding(getRoleLocationId, locationId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Organization? getOrg(
    Role role, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (role.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(role.orgId!, includes: includes);
        role.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

  /// GET RELATED MODELS 

  List<RolePermission> getPermissions(
    Role role, {ModelFilter<RolePermission>? modelFilter, List<RolePermissionInclude>? includes}) {
    final permissions = RolePermissionStore.instance.getByRoleId(role.$uid!, modelFilter: modelFilter, includes: includes);
    role.permissions = permissions;
    // setIncludedReferencesForList(permissions, includes: includes);
    return permissions;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Role>> getAll$({bool useCache = true, ModelFilter<Role>? modelFilter, List<RoleInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: RoleEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Role?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Role>? modelFilter,
        List<RoleInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getRoleId,
        value: id,
        modelFilter: modelFilter,
        endpoint: RoleEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Role>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Role>? modelFilter,
        List<RoleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRoleOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: RoleEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Role>> getByKeyField$(
        MemberRoleKey key,
        {bool useCache = true,
        ModelFilter<Role>? modelFilter,
        List<RoleInclude>? includes}) {
    final items$ = getManyByFieldValue$<MemberRoleKey>(
        getPropVal: getRoleKey,
        value: key,
        modelFilter: modelFilter,
        endpoint: RoleEndpoints.getManyByKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Role>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Role>? modelFilter,
        List<RoleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRoleName,
        value: name,
        modelFilter: modelFilter,
        endpoint: RoleEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Role>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Role>? modelFilter,
        List<RoleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRoleCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: RoleEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Role>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Role>? modelFilter,
        List<RoleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRoleUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: RoleEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Role>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Role>? modelFilter,
        List<RoleInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRoleDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: RoleEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Role>> getByLocationId$(
        String locationId,
        {bool useCache = true,
        ModelFilter<Role>? modelFilter,
        List<RoleInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRoleLocationId,
        value: locationId,
        modelFilter: modelFilter,
        endpoint: RoleEndpoints.getManyByLocationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Organization?> getOrg$(
    Role role, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (role.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            role.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            role.org = org;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<RolePermission>> getPermissions$(
    Role role, {bool useCache = true, ModelFilter<RolePermission>? modelFilter, List<RolePermissionInclude>? includes}) {
    return RolePermissionStore.instance.getByRoleId$(
        role.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((permissions) {
        role.permissions = permissions;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Role recursiveUpsert(Role role, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Role'} 
        : const {};
    if (role.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        role.org = OrganizationStore.instance.recursiveUpsert(role.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (role.permissions != null && (!preventCircularSerialization || !upsertedTypes.contains('RolePermission'))) {
        role.permissions = RolePermissionStore.instance.recursiveListUpsert(role.permissions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(role);
}

  List<Role> recursiveListUpsert(List<Role> roles, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedRoles = <Role>[];
    for (var role in roles) {
        updatedRoles.add(recursiveUpsert(role, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedRoles;
}

//   @override
//   Role upsert(Role item) {
//     return recursiveUpsert(item);
//   }

}


class RoleInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      RoleInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (role) => RoleStore.instance
            .getOrg$(role, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (role) => RoleStore.instance
            .getOrg(role, modelFilter: modelFilter, includes: includes);
      }
}

	RoleInclude.permissions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RolePermission>? modelFilter,
    List<RolePermissionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (role) => RoleStore.instance
            .getPermissions$(role, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (role) => RoleStore.instance
            .getPermissions(role, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum RoleEndpoints implements Endpoint {

    getAll('/role', HttpMethod.post, List<Role>),
	getById('/role/byId/:id', HttpMethod.post, Role),
	getManyByOrgId('/role/byOrgId/:orgId', HttpMethod.post, List<Role>),
	getManyByKey('/role/byKey/:key', HttpMethod.post, List<Role>),
	getManyByName('/role/byName/:name', HttpMethod.post, List<Role>),
	getManyByCreatedAt('/role/byCreatedAt/:createdAt', HttpMethod.post, List<Role>),
	getManyByUpdatedAt('/role/byUpdatedAt/:updatedAt', HttpMethod.post, List<Role>),
	getManyByDeletedAt('/role/byDeletedAt/:deletedAt', HttpMethod.post, List<Role>),
	getManyByLocationId('/role/byLocationId/:locationId', HttpMethod.post, List<Role>);

    const RoleEndpoints(this.path, this.method, this.responseType);

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
