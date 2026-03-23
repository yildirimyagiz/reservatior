
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class RolePermissionStore extends ModelStreamStore<String, RolePermission> {

  static RolePermissionStore? _instance;

  static RolePermissionStore get instance {
    _instance ??= RolePermissionStore();
    return _instance!;
  }

  RolePermissionStore() : super(RolePermission.fromJson) {
    if (_instance != null) {
        throw Exception(
            'RolePermissionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending RolePermissionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use RolePermissionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getRolePermissionId(RolePermission rolePermission) => rolePermission.id;

	String? getRolePermissionRoleId(RolePermission rolePermission) => rolePermission.roleId;

	String? getRolePermissionPermissionId(RolePermission rolePermission) => rolePermission.permissionId;

	DateTime? getRolePermissionCreatedAt(RolePermission rolePermission) => rolePermission.createdAt;

	DateTime? getRolePermissionUpdatedAt(RolePermission rolePermission) => rolePermission.updatedAt;

	DateTime? getRolePermissionDeletedAt(RolePermission rolePermission) => rolePermission.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<RolePermission> getByRoleId(
    String roleId,
    {ModelFilter<RolePermission>? modelFilter, List<RolePermissionInclude>? includes}
    ) =>
    getManyIncluding(getRolePermissionRoleId, roleId, modelFilter: modelFilter, includes: includes);

	
List<RolePermission> getByPermissionId(
    String permissionId,
    {ModelFilter<RolePermission>? modelFilter, List<RolePermissionInclude>? includes}
    ) =>
    getManyIncluding(getRolePermissionPermissionId, permissionId, modelFilter: modelFilter, includes: includes);

	
List<RolePermission> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<RolePermission>? modelFilter, List<RolePermissionInclude>? includes}
    ) =>
    getManyIncluding(getRolePermissionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<RolePermission> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<RolePermission>? modelFilter, List<RolePermissionInclude>? includes}
    ) =>
    getManyIncluding(getRolePermissionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<RolePermission> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<RolePermission>? modelFilter, List<RolePermissionInclude>? includes}
    ) =>
    getManyIncluding(getRolePermissionDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Role? getRole(
    RolePermission rolePermission, {ModelFilter? modelFilter, List<RoleInclude>? includes}) {
    if (rolePermission.roleId == null) {
        return null;
    } else {
        final role = RoleStore.instance.getById(rolePermission.roleId!, includes: includes);
        rolePermission.role = role;
        // setIncludedReferences(role, includes: includes);
        return role;
    }
}

	Permission? getPermission(
    RolePermission rolePermission, {ModelFilter? modelFilter, List<PermissionInclude>? includes}) {
    if (rolePermission.permissionId == null) {
        return null;
    } else {
        final permission = PermissionStore.instance.getById(rolePermission.permissionId!, includes: includes);
        rolePermission.permission = permission;
        // setIncludedReferences(permission, includes: includes);
        return permission;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<RolePermission>> getAll$({bool useCache = true, ModelFilter<RolePermission>? modelFilter, List<RolePermissionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: RolePermissionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<RolePermission?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<RolePermission>? modelFilter,
        List<RolePermissionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getRolePermissionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: RolePermissionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<RolePermission>> getByRoleId$(
        String roleId,
        {bool useCache = true,
        ModelFilter<RolePermission>? modelFilter,
        List<RolePermissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRolePermissionRoleId,
        value: roleId,
        modelFilter: modelFilter,
        endpoint: RolePermissionEndpoints.getManyByRoleId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RolePermission>> getByPermissionId$(
        String permissionId,
        {bool useCache = true,
        ModelFilter<RolePermission>? modelFilter,
        List<RolePermissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getRolePermissionPermissionId,
        value: permissionId,
        modelFilter: modelFilter,
        endpoint: RolePermissionEndpoints.getManyByPermissionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RolePermission>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<RolePermission>? modelFilter,
        List<RolePermissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRolePermissionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: RolePermissionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RolePermission>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<RolePermission>? modelFilter,
        List<RolePermissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRolePermissionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: RolePermissionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<RolePermission>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<RolePermission>? modelFilter,
        List<RolePermissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getRolePermissionDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: RolePermissionEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Role?> getRole$(
    RolePermission rolePermission, {bool useCache = true, ModelFilter<Role>? modelFilter, List<RoleInclude>? includes}) {
    if (rolePermission.roleId == null) {
        return Stream.value(null);
    } else {
        return RoleStore.instance.getById$(
            rolePermission.roleId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((role) {
            rolePermission.role = role;
        });
    }
}

	Stream<Permission?> getPermission$(
    RolePermission rolePermission, {bool useCache = true, ModelFilter<Permission>? modelFilter, List<PermissionInclude>? includes}) {
    if (rolePermission.permissionId == null) {
        return Stream.value(null);
    } else {
        return PermissionStore.instance.getById$(
            rolePermission.permissionId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((permission) {
            rolePermission.permission = permission;
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
RolePermission recursiveUpsert(RolePermission rolePermission, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'RolePermission'} 
        : const {};
    if (rolePermission.role != null && (!preventCircularSerialization || !upsertedTypes.contains('Role'))) {
        rolePermission.role = RoleStore.instance.recursiveUpsert(rolePermission.role!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (rolePermission.permission != null && (!preventCircularSerialization || !upsertedTypes.contains('Permission'))) {
        rolePermission.permission = PermissionStore.instance.recursiveUpsert(rolePermission.permission!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(rolePermission);
}

  List<RolePermission> recursiveListUpsert(List<RolePermission> rolePermissions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedRolePermissions = <RolePermission>[];
    for (var rolePermission in rolePermissions) {
        updatedRolePermissions.add(recursiveUpsert(rolePermission, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedRolePermissions;
}

//   @override
//   RolePermission upsert(RolePermission item) {
//     return recursiveUpsert(item);
//   }

}


class RolePermissionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      RolePermissionInclude.role({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Role>? modelFilter,
    List<RoleInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rolePermission) => RolePermissionStore.instance
            .getRole$(rolePermission, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rolePermission) => RolePermissionStore.instance
            .getRole(rolePermission, modelFilter: modelFilter, includes: includes);
      }
}

	RolePermissionInclude.permission({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Permission>? modelFilter,
    List<PermissionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (rolePermission) => RolePermissionStore.instance
            .getPermission$(rolePermission, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (rolePermission) => RolePermissionStore.instance
            .getPermission(rolePermission, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum RolePermissionEndpoints implements Endpoint {

    getAll('/rolePermission', HttpMethod.post, List<RolePermission>),
	getById('/rolePermission/byId/:id', HttpMethod.post, RolePermission),
	getManyByRoleId('/rolePermission/byRoleId/:roleId', HttpMethod.post, List<RolePermission>),
	getManyByPermissionId('/rolePermission/byPermissionId/:permissionId', HttpMethod.post, List<RolePermission>),
	getManyByCreatedAt('/rolePermission/byCreatedAt/:createdAt', HttpMethod.post, List<RolePermission>),
	getManyByUpdatedAt('/rolePermission/byUpdatedAt/:updatedAt', HttpMethod.post, List<RolePermission>),
	getManyByDeletedAt('/rolePermission/byDeletedAt/:deletedAt', HttpMethod.post, List<RolePermission>);

    const RolePermissionEndpoints(this.path, this.method, this.responseType);

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
