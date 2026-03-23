
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class PermissionStore extends ModelStreamStore<String, Permission> {

  static PermissionStore? _instance;

  static PermissionStore get instance {
    _instance ??= PermissionStore();
    return _instance!;
  }

  PermissionStore() : super(Permission.fromJson) {
    if (_instance != null) {
        throw Exception(
            'PermissionStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending PermissionStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use PermissionStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getPermissionId(Permission permission) => permission.id;

	PermissionKey? getPermissionKey(Permission permission) => permission.key;

	String? getPermissionName(Permission permission) => permission.name;

	String? getPermissionDescription(Permission permission) => permission.description;

	DateTime? getPermissionCreatedAt(Permission permission) => permission.createdAt;

	DateTime? getPermissionUpdatedAt(Permission permission) => permission.updatedAt;

	DateTime? getPermissionDeletedAt(Permission permission) => permission.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Permission? getByKeyField(
    PermissionKey key,
    {ModelFilter<Permission>? modelFilter, List<PermissionInclude>? includes}
    ) =>
    getIncluding(getPermissionKey, key, modelFilter: modelFilter, includes: includes);

  
List<Permission> getByName(
    String name,
    {ModelFilter<Permission>? modelFilter, List<PermissionInclude>? includes}
    ) =>
    getManyIncluding(getPermissionName, name, modelFilter: modelFilter, includes: includes);

	
List<Permission> getByDescription(
    String description,
    {ModelFilter<Permission>? modelFilter, List<PermissionInclude>? includes}
    ) =>
    getManyIncluding(getPermissionDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Permission> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Permission>? modelFilter, List<PermissionInclude>? includes}
    ) =>
    getManyIncluding(getPermissionCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Permission> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Permission>? modelFilter, List<PermissionInclude>? includes}
    ) =>
    getManyIncluding(getPermissionUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Permission> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Permission>? modelFilter, List<PermissionInclude>? includes}
    ) =>
    getManyIncluding(getPermissionDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  

  /// GET RELATED MODELS 

  List<RolePermission> getRoles(
    Permission permission, {ModelFilter<RolePermission>? modelFilter, List<RolePermissionInclude>? includes}) {
    final roles = RolePermissionStore.instance.getByPermissionId(permission.$uid!, modelFilter: modelFilter, includes: includes);
    permission.roles = roles;
    // setIncludedReferencesForList(roles, includes: includes);
    return roles;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Permission>> getAll$({bool useCache = true, ModelFilter<Permission>? modelFilter, List<PermissionInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: PermissionEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Permission?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Permission>? modelFilter,
        List<PermissionInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getPermissionId,
        value: id,
        modelFilter: modelFilter,
        endpoint: PermissionEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Permission?> getByKeyField$(
        PermissionKey key,
        {bool useCache = true,
        ModelFilter<Permission>? modelFilter,
        List<PermissionInclude>? includes}) {
    final item$ = getByFieldValue$<PermissionKey>(
        getPropVal: getPermissionKey,
        value: key,
        modelFilter: modelFilter,
        endpoint: PermissionEndpoints.getByKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Permission>> getByName$(
        String name,
        {bool useCache = true,
        ModelFilter<Permission>? modelFilter,
        List<PermissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPermissionName,
        value: name,
        modelFilter: modelFilter,
        endpoint: PermissionEndpoints.getManyByName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Permission>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Permission>? modelFilter,
        List<PermissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getPermissionDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: PermissionEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Permission>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Permission>? modelFilter,
        List<PermissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPermissionCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: PermissionEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Permission>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Permission>? modelFilter,
        List<PermissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPermissionUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: PermissionEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Permission>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Permission>? modelFilter,
        List<PermissionInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getPermissionDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: PermissionEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  

  /// GET RELATED MODELS as STREAM

  Stream<List<RolePermission>> getRoles$(
    Permission permission, {bool useCache = true, ModelFilter<RolePermission>? modelFilter, List<RolePermissionInclude>? includes}) {
    return RolePermissionStore.instance.getByPermissionId$(
        permission.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((roles) {
        permission.roles = roles;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Permission recursiveUpsert(Permission permission, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Permission'} 
        : const {};
    if (permission.roles != null && (!preventCircularSerialization || !upsertedTypes.contains('RolePermission'))) {
        permission.roles = RolePermissionStore.instance.recursiveListUpsert(permission.roles!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(permission);
}

  List<Permission> recursiveListUpsert(List<Permission> permissions, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedPermissions = <Permission>[];
    for (var permission in permissions) {
        updatedPermissions.add(recursiveUpsert(permission, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedPermissions;
}

//   @override
//   Permission upsert(Permission item) {
//     return recursiveUpsert(item);
//   }

}


class PermissionInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      PermissionInclude.roles({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<RolePermission>? modelFilter,
    List<RolePermissionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (permission) => PermissionStore.instance
            .getRoles$(permission, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (permission) => PermissionStore.instance
            .getRoles(permission, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum PermissionEndpoints implements Endpoint {

    getAll('/permission', HttpMethod.post, List<Permission>),
	getById('/permission/byId/:id', HttpMethod.post, Permission),
	getByKey('/permission/byKey/:key', HttpMethod.post, Permission),
	getManyByName('/permission/byName/:name', HttpMethod.post, List<Permission>),
	getManyByDescription('/permission/byDescription/:description', HttpMethod.post, List<Permission>),
	getManyByCreatedAt('/permission/byCreatedAt/:createdAt', HttpMethod.post, List<Permission>),
	getManyByUpdatedAt('/permission/byUpdatedAt/:updatedAt', HttpMethod.post, List<Permission>),
	getManyByDeletedAt('/permission/byDeletedAt/:deletedAt', HttpMethod.post, List<Permission>);

    const PermissionEndpoints(this.path, this.method, this.responseType);

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
