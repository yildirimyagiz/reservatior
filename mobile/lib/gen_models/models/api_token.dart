
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'user.dart';


class ApiToken implements PrismaModel<String, ApiToken> , Id<String> {
    @override
String? id;
	String? userId;
	String? name;
	String? tokenHash;
	List<String>? scopes;
	DateTime? lastUsedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	User? user;
	int? $scopesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ApiToken({ this.id,
	 this.userId,
	 this.name,
	 this.tokenHash,
	 this.scopes,
	 this.lastUsedAt,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.user,
	this.$scopesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ApiToken, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"name": (m) => m.name,

	"tokenHash": (m) => m.tokenHash,

	"scopes": (m) => m.scopes,

	"lastUsedAt": (m) => m.lastUsedAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ApiToken) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ApiToken');
    }
    return propFunction as V? Function(ApiToken);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ApiToken.fromJson(JsonMap json) =>
      ApiToken(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	name: json['name'] as String?,
	tokenHash: json['tokenHash'] as String?,
	scopes: json['scopes'] != null ? (json['scopes'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	lastUsedAt: json['lastUsedAt'] != null ? DateTime.parse(json['lastUsedAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
	$scopesCount: json['_count']?['scopes'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ApiToken copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? name,
		Value<String?>? tokenHash,
		Value<List<String>?>? scopes,
		Value<DateTime?>? lastUsedAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<User?>? user,
		int? $scopesCount,
        }) {
        return ApiToken(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		name: name != null ? name.value : this.name,
		tokenHash: tokenHash != null ? tokenHash.value : this.tokenHash,
		scopes: scopes != null ? scopes.value : this.scopes,
		lastUsedAt: lastUsedAt != null ? lastUsedAt.value : this.lastUsedAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		user: user != null ? user.value : this.user,
		$scopesCount: $scopesCount ?? this.$scopesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ApiToken copyWithInstanceValues(ApiToken apiToken) {
        return ApiToken(
            id: apiToken.id ?? id,
		userId: apiToken.userId ?? userId,
		name: apiToken.name ?? name,
		tokenHash: apiToken.tokenHash ?? tokenHash,
		scopes: apiToken.scopes ?? scopes,
		lastUsedAt: apiToken.lastUsedAt ?? lastUsedAt,
		createdAt: apiToken.createdAt ?? createdAt,
		updatedAt: apiToken.updatedAt ?? updatedAt,
		deletedAt: apiToken.deletedAt ?? deletedAt,
		user: apiToken.user ?? user,
		$scopesCount: apiToken.$scopesCount ?? $scopesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ApiToken mergeWithInstanceValues(ApiToken apiToken) {
        return ApiToken(
            id: apiToken.$assignedFields.contains('id') ? apiToken.id : id,
		userId: apiToken.$assignedFields.contains('userId') ? apiToken.userId : userId,
		name: apiToken.$assignedFields.contains('name') ? apiToken.name : name,
		tokenHash: apiToken.$assignedFields.contains('tokenHash') ? apiToken.tokenHash : tokenHash,
		scopes: apiToken.$assignedFields.contains('scopes') ? apiToken.scopes : scopes,
		lastUsedAt: apiToken.$assignedFields.contains('lastUsedAt') ? apiToken.lastUsedAt : lastUsedAt,
		createdAt: apiToken.$assignedFields.contains('createdAt') ? apiToken.createdAt : createdAt,
		updatedAt: apiToken.$assignedFields.contains('updatedAt') ? apiToken.updatedAt : updatedAt,
		deletedAt: apiToken.$assignedFields.contains('deletedAt') ? apiToken.deletedAt : deletedAt,
		user: apiToken.$assignedFields.contains('user') ? apiToken.user : user,
		$scopesCount: apiToken.$scopesCount ?? $scopesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ApiToken updateWithInstanceValues(ApiToken apiToken) {
        if (apiToken.$assignedFields.contains('id')) { id = apiToken.id; }
		if (apiToken.$assignedFields.contains('userId')) { userId = apiToken.userId; }
		if (apiToken.$assignedFields.contains('name')) { name = apiToken.name; }
		if (apiToken.$assignedFields.contains('tokenHash')) { tokenHash = apiToken.tokenHash; }
		if (apiToken.$assignedFields.contains('scopes')) { scopes = apiToken.scopes; }
		if (apiToken.$assignedFields.contains('lastUsedAt')) { lastUsedAt = apiToken.lastUsedAt; }
		if (apiToken.$assignedFields.contains('createdAt')) { createdAt = apiToken.createdAt; }
		if (apiToken.$assignedFields.contains('updatedAt')) { updatedAt = apiToken.updatedAt; }
		if (apiToken.$assignedFields.contains('deletedAt')) { deletedAt = apiToken.deletedAt; }
		if (apiToken.$assignedFields.contains('user')) { user = apiToken.user; }
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
          ? {...?serializedTypes, 'ApiToken'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(name != null) 'name': name,
	if(tokenHash != null) 'tokenHash': tokenHash,
	if(scopes != null) 'scopes': scopes,
	if(lastUsedAt != null) 'lastUsedAt': lastUsedAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
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
            identical(this, other) || other is ApiToken &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    