
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'role.dart';
import 'permission.dart';


class RolePermission implements PrismaModel<String, RolePermission> , Id<String> {
    @override
String? id;
	String? roleId;
	String? permissionId;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Role? role;
	Permission? permission;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    RolePermission({ this.id,
	 this.roleId,
	 this.permissionId,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.role,
	 this.permission,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<RolePermission, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"roleId": (m) => m.roleId,

	"permissionId": (m) => m.permissionId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"role": (m) => m.role,

	"permission": (m) => m.permission,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(RolePermission) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in RolePermission');
    }
    return propFunction as V? Function(RolePermission);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory RolePermission.fromJson(JsonMap json) =>
      RolePermission(
        id: json['id'] as String?,
	roleId: json['roleId'] as String?,
	permissionId: json['permissionId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	role: json['role'] != null ? Role.fromJson(json['role'] as JsonMap) : null,
	permission: json['permission'] != null ? Permission.fromJson(json['permission'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    RolePermission copyWith({
        Value<String?>? id,
		Value<String?>? roleId,
		Value<String?>? permissionId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Role?>? role,
		Value<Permission?>? permission,
        }) {
        return RolePermission(
            id: id != null ? id.value : this.id,
		roleId: roleId != null ? roleId.value : this.roleId,
		permissionId: permissionId != null ? permissionId.value : this.permissionId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		role: role != null ? role.value : this.role,
		permission: permission != null ? permission.value : this.permission
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    RolePermission copyWithInstanceValues(RolePermission rolePermission) {
        return RolePermission(
            id: rolePermission.id ?? id,
		roleId: rolePermission.roleId ?? roleId,
		permissionId: rolePermission.permissionId ?? permissionId,
		createdAt: rolePermission.createdAt ?? createdAt,
		updatedAt: rolePermission.updatedAt ?? updatedAt,
		deletedAt: rolePermission.deletedAt ?? deletedAt,
		role: rolePermission.role ?? role,
		permission: rolePermission.permission ?? permission
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    RolePermission mergeWithInstanceValues(RolePermission rolePermission) {
        return RolePermission(
            id: rolePermission.$assignedFields.contains('id') ? rolePermission.id : id,
		roleId: rolePermission.$assignedFields.contains('roleId') ? rolePermission.roleId : roleId,
		permissionId: rolePermission.$assignedFields.contains('permissionId') ? rolePermission.permissionId : permissionId,
		createdAt: rolePermission.$assignedFields.contains('createdAt') ? rolePermission.createdAt : createdAt,
		updatedAt: rolePermission.$assignedFields.contains('updatedAt') ? rolePermission.updatedAt : updatedAt,
		deletedAt: rolePermission.$assignedFields.contains('deletedAt') ? rolePermission.deletedAt : deletedAt,
		role: rolePermission.$assignedFields.contains('role') ? rolePermission.role : role,
		permission: rolePermission.$assignedFields.contains('permission') ? rolePermission.permission : permission
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    RolePermission updateWithInstanceValues(RolePermission rolePermission) {
        if (rolePermission.$assignedFields.contains('id')) { id = rolePermission.id; }
		if (rolePermission.$assignedFields.contains('roleId')) { roleId = rolePermission.roleId; }
		if (rolePermission.$assignedFields.contains('permissionId')) { permissionId = rolePermission.permissionId; }
		if (rolePermission.$assignedFields.contains('createdAt')) { createdAt = rolePermission.createdAt; }
		if (rolePermission.$assignedFields.contains('updatedAt')) { updatedAt = rolePermission.updatedAt; }
		if (rolePermission.$assignedFields.contains('deletedAt')) { deletedAt = rolePermission.deletedAt; }
		if (rolePermission.$assignedFields.contains('role')) { role = rolePermission.role; }
		if (rolePermission.$assignedFields.contains('permission')) { permission = rolePermission.permission; }
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
          ? {...?serializedTypes, 'RolePermission'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(roleId != null) 'roleId': roleId,
	if(permissionId != null) 'permissionId': permissionId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(role != null && (!preventCircularSerialization || !serializedModels.contains('Role'))) 'role': role?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(permission != null && (!preventCircularSerialization || !serializedModels.contains('Permission'))) 'permission': permission?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is RolePermission &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    