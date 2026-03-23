
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'permission_key.dart';
import 'role_permission.dart';


class Permission implements PrismaModel<String, Permission> , Id<String> {
    @override
String? id;
	PermissionKey? key;
	String? name;
	String? description;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<RolePermission>? roles;
	int? $rolesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Permission({ this.id,
	 this.key,
	 this.name,
	 this.description,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.roles,
	this.$rolesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Permission, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"key": (m) => m.key,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"roles": (m) => m.roles,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Permission) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Permission');
    }
    return propFunction as V? Function(Permission);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Permission.fromJson(JsonMap json) =>
      Permission(
        id: json['id'] as String?,
	key: json['key'] != null ? PermissionKey.fromJson(json['key']) : null,
	name: json['name'] as String?,
	description: json['description'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	roles: json['roles'] != null ? createModels<RolePermission>((json['roles'] as List).cast<JsonMap>(), RolePermission.fromJson) : null,
	$rolesCount: json['_count']?['roles'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Permission copyWith({
        Value<String?>? id,
		Value<PermissionKey?>? key,
		Value<String?>? name,
		Value<String?>? description,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<RolePermission>?>? roles,
		int? $rolesCount,
        }) {
        return Permission(
            id: id != null ? id.value : this.id,
		key: key != null ? key.value : this.key,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		roles: roles != null ? roles.value : this.roles,
		$rolesCount: $rolesCount ?? this.$rolesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Permission copyWithInstanceValues(Permission permission) {
        return Permission(
            id: permission.id ?? id,
		key: permission.key ?? key,
		name: permission.name ?? name,
		description: permission.description ?? description,
		createdAt: permission.createdAt ?? createdAt,
		updatedAt: permission.updatedAt ?? updatedAt,
		deletedAt: permission.deletedAt ?? deletedAt,
		roles: permission.roles ?? roles,
		$rolesCount: permission.$rolesCount ?? $rolesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Permission mergeWithInstanceValues(Permission permission) {
        return Permission(
            id: permission.$assignedFields.contains('id') ? permission.id : id,
		key: permission.$assignedFields.contains('key') ? permission.key : key,
		name: permission.$assignedFields.contains('name') ? permission.name : name,
		description: permission.$assignedFields.contains('description') ? permission.description : description,
		createdAt: permission.$assignedFields.contains('createdAt') ? permission.createdAt : createdAt,
		updatedAt: permission.$assignedFields.contains('updatedAt') ? permission.updatedAt : updatedAt,
		deletedAt: permission.$assignedFields.contains('deletedAt') ? permission.deletedAt : deletedAt,
		roles: (permission.$assignedFields.contains('roles') && permission.roles != null) ? mergeModelLists(roles, permission.roles) : roles,
		$rolesCount: permission.$rolesCount ?? $rolesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Permission updateWithInstanceValues(Permission permission) {
        if (permission.$assignedFields.contains('id')) { id = permission.id; }
		if (permission.$assignedFields.contains('key')) { key = permission.key; }
		if (permission.$assignedFields.contains('name')) { name = permission.name; }
		if (permission.$assignedFields.contains('description')) { description = permission.description; }
		if (permission.$assignedFields.contains('createdAt')) { createdAt = permission.createdAt; }
		if (permission.$assignedFields.contains('updatedAt')) { updatedAt = permission.updatedAt; }
		if (permission.$assignedFields.contains('deletedAt')) { deletedAt = permission.deletedAt; }
		if (permission.$assignedFields.contains('roles') && permission.roles != null) { roles = mergeModelLists(roles, permission.roles); }
        return this;
    }

    /// Converts this instance to a JSON object.
    /// 
    /// [serializedTypes] - Internal parameter tracking which model types have been serialized
    /// in the current chain to prevent circular references.
    /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
    /// skipping relations whose types have already been serialized in the current chain.
    /// Set to false to serialize all relations (use with caution - may cause infinite loops).
    @override
    JsonMap toJson({
      Set<String>? serializedTypes,
      bool preventCircularSerialization = true,
    }) {
      final Set<String> serializedModels = preventCircularSerialization 
          ? {...?serializedTypes, 'Permission'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(key != null) 'key': key?.toJson(),
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(roles != null && (!preventCircularSerialization || !serializedModels.contains('RolePermission'))) 'roles': roles?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($rolesCount != null) '_count': { 
		if ($rolesCount != null) 'roles': $rolesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Permission &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    