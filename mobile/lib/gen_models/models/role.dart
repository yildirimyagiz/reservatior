
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'member_role_key.dart';
import 'organization.dart';
import 'role_permission.dart';


class Role implements PrismaModel<String, Role> , Id<String> {
    @override
String? id;
	String? orgId;
	MemberRoleKey? key;
	String? name;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? locationId;
	Organization? org;
	List<RolePermission>? permissions;
	int? $permissionsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Role({ this.id,
	 this.orgId,
	 this.key,
	 this.name,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.locationId,
	 this.org,
	 this.permissions,
	this.$permissionsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Role, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"key": (m) => m.key,

	"name": (m) => m.name,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"locationId": (m) => m.locationId,

	"org": (m) => m.org,

	"permissions": (m) => m.permissions,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Role) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Role');
    }
    return propFunction as V? Function(Role);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Role.fromJson(JsonMap json) =>
      Role(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	key: json['key'] != null ? MemberRoleKey.fromJson(json['key']) : null,
	name: json['name'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	locationId: json['locationId'] as String?,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	permissions: json['permissions'] != null ? createModels<RolePermission>((json['permissions'] as List).cast<JsonMap>(), RolePermission.fromJson) : null,
	$permissionsCount: json['_count']?['permissions'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Role copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<MemberRoleKey?>? key,
		Value<String?>? name,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? locationId,
		Value<Organization?>? org,
		Value<List<RolePermission>?>? permissions,
		int? $permissionsCount,
        }) {
        return Role(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		key: key != null ? key.value : this.key,
		name: name != null ? name.value : this.name,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		locationId: locationId != null ? locationId.value : this.locationId,
		org: org != null ? org.value : this.org,
		permissions: permissions != null ? permissions.value : this.permissions,
		$permissionsCount: $permissionsCount ?? this.$permissionsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Role copyWithInstanceValues(Role role) {
        return Role(
            id: role.id ?? id,
		orgId: role.orgId ?? orgId,
		key: role.key ?? key,
		name: role.name ?? name,
		createdAt: role.createdAt ?? createdAt,
		updatedAt: role.updatedAt ?? updatedAt,
		deletedAt: role.deletedAt ?? deletedAt,
		locationId: role.locationId ?? locationId,
		org: role.org ?? org,
		permissions: role.permissions ?? permissions,
		$permissionsCount: role.$permissionsCount ?? $permissionsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Role mergeWithInstanceValues(Role role) {
        return Role(
            id: role.$assignedFields.contains('id') ? role.id : id,
		orgId: role.$assignedFields.contains('orgId') ? role.orgId : orgId,
		key: role.$assignedFields.contains('key') ? role.key : key,
		name: role.$assignedFields.contains('name') ? role.name : name,
		createdAt: role.$assignedFields.contains('createdAt') ? role.createdAt : createdAt,
		updatedAt: role.$assignedFields.contains('updatedAt') ? role.updatedAt : updatedAt,
		deletedAt: role.$assignedFields.contains('deletedAt') ? role.deletedAt : deletedAt,
		locationId: role.$assignedFields.contains('locationId') ? role.locationId : locationId,
		org: role.$assignedFields.contains('org') ? role.org : org,
		permissions: (role.$assignedFields.contains('permissions') && role.permissions != null) ? mergeModelLists(permissions, role.permissions) : permissions,
		$permissionsCount: role.$permissionsCount ?? $permissionsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Role updateWithInstanceValues(Role role) {
        if (role.$assignedFields.contains('id')) { id = role.id; }
		if (role.$assignedFields.contains('orgId')) { orgId = role.orgId; }
		if (role.$assignedFields.contains('key')) { key = role.key; }
		if (role.$assignedFields.contains('name')) { name = role.name; }
		if (role.$assignedFields.contains('createdAt')) { createdAt = role.createdAt; }
		if (role.$assignedFields.contains('updatedAt')) { updatedAt = role.updatedAt; }
		if (role.$assignedFields.contains('deletedAt')) { deletedAt = role.deletedAt; }
		if (role.$assignedFields.contains('locationId')) { locationId = role.locationId; }
		if (role.$assignedFields.contains('org')) { org = role.org; }
		if (role.$assignedFields.contains('permissions') && role.permissions != null) { permissions = mergeModelLists(permissions, role.permissions); }
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
          ? {...?serializedTypes, 'Role'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(key != null) 'key': key?.toJson(),
	if(name != null) 'name': name,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(locationId != null) 'locationId': locationId,
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(permissions != null && (!preventCircularSerialization || !serializedModels.contains('RolePermission'))) 'permissions': permissions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($permissionsCount != null) '_count': { 
		if ($permissionsCount != null) 'permissions': $permissionsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Role &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    