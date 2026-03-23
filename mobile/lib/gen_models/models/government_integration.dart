
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'region.dart';
import 'sync_status.dart';
import 'organization.dart';
import 'user.dart';


class GovernmentIntegration implements PrismaModel<String, GovernmentIntegration> , Id<String> {
    @override
String? id;
	String? orgId;
	String? userId;
	Region? region;
	String? name;
	String? baseUrl;
	bool? isEnabled;
	String? apiKeyCiphertext;
	String? apiSecretCiphertext;
	String? tokenCiphertext;
	List<String>? scopes;
	DateTime? lastSyncAt;
	SyncStatus? status;
	String? lastError;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	User? user;
	int? $scopesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    GovernmentIntegration({ this.id,
	 this.orgId,
	 this.userId,
	 this.region,
	 this.name,
	 this.baseUrl,
	 this.isEnabled = false,
	 this.apiKeyCiphertext,
	 this.apiSecretCiphertext,
	 this.tokenCiphertext,
	 this.scopes,
	 this.lastSyncAt,
	 this.status = SyncStatus.IDLE,
	 this.lastError,
	 this.createdBy,
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

    Map<String, GetPropertyValueFunction<GovernmentIntegration, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"userId": (m) => m.userId,

	"region": (m) => m.region,

	"name": (m) => m.name,

	"baseUrl": (m) => m.baseUrl,

	"isEnabled": (m) => m.isEnabled,

	"apiKeyCiphertext": (m) => m.apiKeyCiphertext,

	"apiSecretCiphertext": (m) => m.apiSecretCiphertext,

	"tokenCiphertext": (m) => m.tokenCiphertext,

	"scopes": (m) => m.scopes,

	"lastSyncAt": (m) => m.lastSyncAt,

	"status": (m) => m.status,

	"lastError": (m) => m.lastError,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(GovernmentIntegration) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in GovernmentIntegration');
    }
    return propFunction as V? Function(GovernmentIntegration);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory GovernmentIntegration.fromJson(JsonMap json) =>
      GovernmentIntegration(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	userId: json['userId'] as String?,
	region: json['region'] != null ? Region.fromJson(json['region']) : null,
	name: json['name'] as String?,
	baseUrl: json['baseUrl'] as String?,
	isEnabled: json['isEnabled'] as bool?,
	apiKeyCiphertext: json['apiKeyCiphertext'] as String?,
	apiSecretCiphertext: json['apiSecretCiphertext'] as String?,
	tokenCiphertext: json['tokenCiphertext'] as String?,
	scopes: json['scopes'] != null ? (json['scopes'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	lastSyncAt: json['lastSyncAt'] != null ? DateTime.parse(json['lastSyncAt']) : null,
	status: json['status'] != null ? SyncStatus.fromJson(json['status']) : null,
	lastError: json['lastError'] as String?,
	createdBy: json['createdBy'] as String?,
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
    GovernmentIntegration copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? userId,
		Value<Region?>? region,
		Value<String?>? name,
		Value<String?>? baseUrl,
		Value<bool?>? isEnabled,
		Value<String?>? apiKeyCiphertext,
		Value<String?>? apiSecretCiphertext,
		Value<String?>? tokenCiphertext,
		Value<List<String>?>? scopes,
		Value<DateTime?>? lastSyncAt,
		Value<SyncStatus?>? status,
		Value<String?>? lastError,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<User?>? user,
		int? $scopesCount,
        }) {
        return GovernmentIntegration(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		userId: userId != null ? userId.value : this.userId,
		region: region != null ? region.value : this.region,
		name: name != null ? name.value : this.name,
		baseUrl: baseUrl != null ? baseUrl.value : this.baseUrl,
		isEnabled: isEnabled != null ? isEnabled.value : this.isEnabled,
		apiKeyCiphertext: apiKeyCiphertext != null ? apiKeyCiphertext.value : this.apiKeyCiphertext,
		apiSecretCiphertext: apiSecretCiphertext != null ? apiSecretCiphertext.value : this.apiSecretCiphertext,
		tokenCiphertext: tokenCiphertext != null ? tokenCiphertext.value : this.tokenCiphertext,
		scopes: scopes != null ? scopes.value : this.scopes,
		lastSyncAt: lastSyncAt != null ? lastSyncAt.value : this.lastSyncAt,
		status: status != null ? status.value : this.status,
		lastError: lastError != null ? lastError.value : this.lastError,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
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
    GovernmentIntegration copyWithInstanceValues(GovernmentIntegration governmentIntegration) {
        return GovernmentIntegration(
            id: governmentIntegration.id ?? id,
		orgId: governmentIntegration.orgId ?? orgId,
		userId: governmentIntegration.userId ?? userId,
		region: governmentIntegration.region ?? region,
		name: governmentIntegration.name ?? name,
		baseUrl: governmentIntegration.baseUrl ?? baseUrl,
		isEnabled: governmentIntegration.isEnabled ?? isEnabled,
		apiKeyCiphertext: governmentIntegration.apiKeyCiphertext ?? apiKeyCiphertext,
		apiSecretCiphertext: governmentIntegration.apiSecretCiphertext ?? apiSecretCiphertext,
		tokenCiphertext: governmentIntegration.tokenCiphertext ?? tokenCiphertext,
		scopes: governmentIntegration.scopes ?? scopes,
		lastSyncAt: governmentIntegration.lastSyncAt ?? lastSyncAt,
		status: governmentIntegration.status ?? status,
		lastError: governmentIntegration.lastError ?? lastError,
		createdBy: governmentIntegration.createdBy ?? createdBy,
		createdAt: governmentIntegration.createdAt ?? createdAt,
		updatedAt: governmentIntegration.updatedAt ?? updatedAt,
		deletedAt: governmentIntegration.deletedAt ?? deletedAt,
		org: governmentIntegration.org ?? org,
		user: governmentIntegration.user ?? user,
		$scopesCount: governmentIntegration.$scopesCount ?? $scopesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    GovernmentIntegration mergeWithInstanceValues(GovernmentIntegration governmentIntegration) {
        return GovernmentIntegration(
            id: governmentIntegration.$assignedFields.contains('id') ? governmentIntegration.id : id,
		orgId: governmentIntegration.$assignedFields.contains('orgId') ? governmentIntegration.orgId : orgId,
		userId: governmentIntegration.$assignedFields.contains('userId') ? governmentIntegration.userId : userId,
		region: governmentIntegration.$assignedFields.contains('region') ? governmentIntegration.region : region,
		name: governmentIntegration.$assignedFields.contains('name') ? governmentIntegration.name : name,
		baseUrl: governmentIntegration.$assignedFields.contains('baseUrl') ? governmentIntegration.baseUrl : baseUrl,
		isEnabled: governmentIntegration.$assignedFields.contains('isEnabled') ? governmentIntegration.isEnabled : isEnabled,
		apiKeyCiphertext: governmentIntegration.$assignedFields.contains('apiKeyCiphertext') ? governmentIntegration.apiKeyCiphertext : apiKeyCiphertext,
		apiSecretCiphertext: governmentIntegration.$assignedFields.contains('apiSecretCiphertext') ? governmentIntegration.apiSecretCiphertext : apiSecretCiphertext,
		tokenCiphertext: governmentIntegration.$assignedFields.contains('tokenCiphertext') ? governmentIntegration.tokenCiphertext : tokenCiphertext,
		scopes: governmentIntegration.$assignedFields.contains('scopes') ? governmentIntegration.scopes : scopes,
		lastSyncAt: governmentIntegration.$assignedFields.contains('lastSyncAt') ? governmentIntegration.lastSyncAt : lastSyncAt,
		status: governmentIntegration.$assignedFields.contains('status') ? governmentIntegration.status : status,
		lastError: governmentIntegration.$assignedFields.contains('lastError') ? governmentIntegration.lastError : lastError,
		createdBy: governmentIntegration.$assignedFields.contains('createdBy') ? governmentIntegration.createdBy : createdBy,
		createdAt: governmentIntegration.$assignedFields.contains('createdAt') ? governmentIntegration.createdAt : createdAt,
		updatedAt: governmentIntegration.$assignedFields.contains('updatedAt') ? governmentIntegration.updatedAt : updatedAt,
		deletedAt: governmentIntegration.$assignedFields.contains('deletedAt') ? governmentIntegration.deletedAt : deletedAt,
		org: governmentIntegration.$assignedFields.contains('org') ? governmentIntegration.org : org,
		user: governmentIntegration.$assignedFields.contains('user') ? governmentIntegration.user : user,
		$scopesCount: governmentIntegration.$scopesCount ?? $scopesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    GovernmentIntegration updateWithInstanceValues(GovernmentIntegration governmentIntegration) {
        if (governmentIntegration.$assignedFields.contains('id')) { id = governmentIntegration.id; }
		if (governmentIntegration.$assignedFields.contains('orgId')) { orgId = governmentIntegration.orgId; }
		if (governmentIntegration.$assignedFields.contains('userId')) { userId = governmentIntegration.userId; }
		if (governmentIntegration.$assignedFields.contains('region')) { region = governmentIntegration.region; }
		if (governmentIntegration.$assignedFields.contains('name')) { name = governmentIntegration.name; }
		if (governmentIntegration.$assignedFields.contains('baseUrl')) { baseUrl = governmentIntegration.baseUrl; }
		if (governmentIntegration.$assignedFields.contains('isEnabled')) { isEnabled = governmentIntegration.isEnabled; }
		if (governmentIntegration.$assignedFields.contains('apiKeyCiphertext')) { apiKeyCiphertext = governmentIntegration.apiKeyCiphertext; }
		if (governmentIntegration.$assignedFields.contains('apiSecretCiphertext')) { apiSecretCiphertext = governmentIntegration.apiSecretCiphertext; }
		if (governmentIntegration.$assignedFields.contains('tokenCiphertext')) { tokenCiphertext = governmentIntegration.tokenCiphertext; }
		if (governmentIntegration.$assignedFields.contains('scopes')) { scopes = governmentIntegration.scopes; }
		if (governmentIntegration.$assignedFields.contains('lastSyncAt')) { lastSyncAt = governmentIntegration.lastSyncAt; }
		if (governmentIntegration.$assignedFields.contains('status')) { status = governmentIntegration.status; }
		if (governmentIntegration.$assignedFields.contains('lastError')) { lastError = governmentIntegration.lastError; }
		if (governmentIntegration.$assignedFields.contains('createdBy')) { createdBy = governmentIntegration.createdBy; }
		if (governmentIntegration.$assignedFields.contains('createdAt')) { createdAt = governmentIntegration.createdAt; }
		if (governmentIntegration.$assignedFields.contains('updatedAt')) { updatedAt = governmentIntegration.updatedAt; }
		if (governmentIntegration.$assignedFields.contains('deletedAt')) { deletedAt = governmentIntegration.deletedAt; }
		if (governmentIntegration.$assignedFields.contains('org')) { org = governmentIntegration.org; }
		if (governmentIntegration.$assignedFields.contains('user')) { user = governmentIntegration.user; }
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
          ? {...?serializedTypes, 'GovernmentIntegration'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(userId != null) 'userId': userId,
	if(region != null) 'region': region?.toJson(),
	if(name != null) 'name': name,
	if(baseUrl != null) 'baseUrl': baseUrl,
	if(isEnabled != null) 'isEnabled': isEnabled,
	if(apiKeyCiphertext != null) 'apiKeyCiphertext': apiKeyCiphertext,
	if(apiSecretCiphertext != null) 'apiSecretCiphertext': apiSecretCiphertext,
	if(tokenCiphertext != null) 'tokenCiphertext': tokenCiphertext,
	if(scopes != null) 'scopes': scopes,
	if(lastSyncAt != null) 'lastSyncAt': lastSyncAt?.toIso8601String(),
	if(status != null) 'status': status?.toJson(),
	if(lastError != null) 'lastError': lastError,
	if(createdBy != null) 'createdBy': createdBy,
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
            identical(this, other) || other is GovernmentIntegration &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    