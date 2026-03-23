
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'user.dart';


class ApiKey implements PrismaModel<String, ApiKey> , Id<String> {
    @override
String? id;
	String? userId;
	String? orgId;
	String? name;
	String? keyHash;
	List<String>? scopes;
	DateTime? lastUsedAt;
	DateTime? expiresAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	User? user;
	int? $scopesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ApiKey({ this.id,
	 this.userId,
	 this.orgId,
	 this.name,
	 this.keyHash,
	 this.scopes,
	 this.lastUsedAt,
	 this.expiresAt,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.user,
	this.$scopesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ApiKey, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"orgId": (m) => m.orgId,

	"name": (m) => m.name,

	"keyHash": (m) => m.keyHash,

	"scopes": (m) => m.scopes,

	"lastUsedAt": (m) => m.lastUsedAt,

	"expiresAt": (m) => m.expiresAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ApiKey) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ApiKey');
    }
    return propFunction as V? Function(ApiKey);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ApiKey.fromJson(JsonMap json) =>
      ApiKey(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	orgId: json['orgId'] as String?,
	name: json['name'] as String?,
	keyHash: json['keyHash'] as String?,
	scopes: json['scopes'] != null ? (json['scopes'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	lastUsedAt: json['lastUsedAt'] != null ? DateTime.parse(json['lastUsedAt']) : null,
	expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
	$scopesCount: json['_count']?['scopes'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ApiKey copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? orgId,
		Value<String?>? name,
		Value<String?>? keyHash,
		Value<List<String>?>? scopes,
		Value<DateTime?>? lastUsedAt,
		Value<DateTime?>? expiresAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<User?>? user,
		int? $scopesCount,
        }) {
        return ApiKey(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		orgId: orgId != null ? orgId.value : this.orgId,
		name: name != null ? name.value : this.name,
		keyHash: keyHash != null ? keyHash.value : this.keyHash,
		scopes: scopes != null ? scopes.value : this.scopes,
		lastUsedAt: lastUsedAt != null ? lastUsedAt.value : this.lastUsedAt,
		expiresAt: expiresAt != null ? expiresAt.value : this.expiresAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user,
		$scopesCount: $scopesCount ?? this.$scopesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ApiKey copyWithInstanceValues(ApiKey apiKey) {
        return ApiKey(
            id: apiKey.id ?? id,
		userId: apiKey.userId ?? userId,
		orgId: apiKey.orgId ?? orgId,
		name: apiKey.name ?? name,
		keyHash: apiKey.keyHash ?? keyHash,
		scopes: apiKey.scopes ?? scopes,
		lastUsedAt: apiKey.lastUsedAt ?? lastUsedAt,
		expiresAt: apiKey.expiresAt ?? expiresAt,
		createdAt: apiKey.createdAt ?? createdAt,
		updatedAt: apiKey.updatedAt ?? updatedAt,
		deletedAt: apiKey.deletedAt ?? deletedAt,
		org: apiKey.org ?? org,
		user: apiKey.user ?? user,
		$scopesCount: apiKey.$scopesCount ?? $scopesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ApiKey mergeWithInstanceValues(ApiKey apiKey) {
        return ApiKey(
            id: apiKey.$assignedFields.contains('id') ? apiKey.id : id,
		userId: apiKey.$assignedFields.contains('userId') ? apiKey.userId : userId,
		orgId: apiKey.$assignedFields.contains('orgId') ? apiKey.orgId : orgId,
		name: apiKey.$assignedFields.contains('name') ? apiKey.name : name,
		keyHash: apiKey.$assignedFields.contains('keyHash') ? apiKey.keyHash : keyHash,
		scopes: apiKey.$assignedFields.contains('scopes') ? apiKey.scopes : scopes,
		lastUsedAt: apiKey.$assignedFields.contains('lastUsedAt') ? apiKey.lastUsedAt : lastUsedAt,
		expiresAt: apiKey.$assignedFields.contains('expiresAt') ? apiKey.expiresAt : expiresAt,
		createdAt: apiKey.$assignedFields.contains('createdAt') ? apiKey.createdAt : createdAt,
		updatedAt: apiKey.$assignedFields.contains('updatedAt') ? apiKey.updatedAt : updatedAt,
		deletedAt: apiKey.$assignedFields.contains('deletedAt') ? apiKey.deletedAt : deletedAt,
		org: apiKey.$assignedFields.contains('org') ? apiKey.org : org,
		user: apiKey.$assignedFields.contains('user') ? apiKey.user : user,
		$scopesCount: apiKey.$scopesCount ?? $scopesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ApiKey updateWithInstanceValues(ApiKey apiKey) {
        if (apiKey.$assignedFields.contains('id')) { id = apiKey.id; }
		if (apiKey.$assignedFields.contains('userId')) { userId = apiKey.userId; }
		if (apiKey.$assignedFields.contains('orgId')) { orgId = apiKey.orgId; }
		if (apiKey.$assignedFields.contains('name')) { name = apiKey.name; }
		if (apiKey.$assignedFields.contains('keyHash')) { keyHash = apiKey.keyHash; }
		if (apiKey.$assignedFields.contains('scopes')) { scopes = apiKey.scopes; }
		if (apiKey.$assignedFields.contains('lastUsedAt')) { lastUsedAt = apiKey.lastUsedAt; }
		if (apiKey.$assignedFields.contains('expiresAt')) { expiresAt = apiKey.expiresAt; }
		if (apiKey.$assignedFields.contains('createdAt')) { createdAt = apiKey.createdAt; }
		if (apiKey.$assignedFields.contains('updatedAt')) { updatedAt = apiKey.updatedAt; }
		if (apiKey.$assignedFields.contains('deletedAt')) { deletedAt = apiKey.deletedAt; }
		if (apiKey.$assignedFields.contains('org')) { org = apiKey.org; }
		if (apiKey.$assignedFields.contains('user')) { user = apiKey.user; }
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
          ? {...?serializedTypes, 'ApiKey'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(orgId != null) 'orgId': orgId,
	if(name != null) 'name': name,
	if(keyHash != null) 'keyHash': keyHash,
	if(scopes != null) 'scopes': scopes,
	if(lastUsedAt != null) 'lastUsedAt': lastUsedAt?.toIso8601String(),
	if(expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($scopesCount != null) '_count': { 
		if ($scopesCount != null) 'scopes': $scopesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ApiKey &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    