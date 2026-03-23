
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'm_l_s_provider_key.dart';
import 'region.dart';
import 'sync_status.dart';
import 'organization.dart';
import 'm_l_s_external_listing.dart';
import 'm_l_s_sync_job.dart';


class MLSConnection implements PrismaModel<String, MLSConnection> , Id<String> {
    @override
String? id;
	String? orgId;
	MLSProviderKey? provider;
	String? name;
	String? baseUrl;
	bool? isEnabled;
	String? usernameCiphertext;
	String? passwordCiphertext;
	String? apiKeyCiphertext;
	String? tokenCiphertext;
	Region? region;
	dynamic config;
	DateTime? lastSyncAt;
	SyncStatus? status;
	String? lastError;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	List<MLSExternalListing>? externalListings;
	List<MLSSyncJob>? syncJobs;
	int? $externalListingsCount;
	int? $syncJobsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MLSConnection({ this.id,
	 this.orgId,
	 this.provider,
	 this.name,
	 this.baseUrl,
	 this.isEnabled = false,
	 this.usernameCiphertext,
	 this.passwordCiphertext,
	 this.apiKeyCiphertext,
	 this.tokenCiphertext,
	 this.region,
	required this.config,
	 this.lastSyncAt,
	 this.status = SyncStatus.IDLE,
	 this.lastError,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.externalListings,
	 this.syncJobs,
	this.$externalListingsCount,
	this.$syncJobsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MLSConnection, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"provider": (m) => m.provider,

	"name": (m) => m.name,

	"baseUrl": (m) => m.baseUrl,

	"isEnabled": (m) => m.isEnabled,

	"usernameCiphertext": (m) => m.usernameCiphertext,

	"passwordCiphertext": (m) => m.passwordCiphertext,

	"apiKeyCiphertext": (m) => m.apiKeyCiphertext,

	"tokenCiphertext": (m) => m.tokenCiphertext,

	"region": (m) => m.region,

	"config": (m) => m.config,

	"lastSyncAt": (m) => m.lastSyncAt,

	"status": (m) => m.status,

	"lastError": (m) => m.lastError,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"externalListings": (m) => m.externalListings,

	"syncJobs": (m) => m.syncJobs,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MLSConnection) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MLSConnection');
    }
    return propFunction as V? Function(MLSConnection);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MLSConnection.fromJson(JsonMap json) =>
      MLSConnection(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	provider: json['provider'] != null ? MLSProviderKey.fromJson(json['provider']) : null,
	name: json['name'] as String?,
	baseUrl: json['baseUrl'] as String?,
	isEnabled: json['isEnabled'] as bool?,
	usernameCiphertext: json['usernameCiphertext'] as String?,
	passwordCiphertext: json['passwordCiphertext'] as String?,
	apiKeyCiphertext: json['apiKeyCiphertext'] as String?,
	tokenCiphertext: json['tokenCiphertext'] as String?,
	region: json['region'] != null ? Region.fromJson(json['region']) : null,
	config: json['config'] as dynamic,
	lastSyncAt: json['lastSyncAt'] != null ? DateTime.parse(json['lastSyncAt']) : null,
	status: json['status'] != null ? SyncStatus.fromJson(json['status']) : null,
	lastError: json['lastError'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	externalListings: json['externalListings'] != null ? createModels<MLSExternalListing>((json['externalListings'] as List).cast<JsonMap>(), MLSExternalListing.fromJson) : null,
	syncJobs: json['syncJobs'] != null ? createModels<MLSSyncJob>((json['syncJobs'] as List).cast<JsonMap>(), MLSSyncJob.fromJson) : null,
	$externalListingsCount: json['_count']?['externalListings'] as int?,
	$syncJobsCount: json['_count']?['syncJobs'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MLSConnection copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<MLSProviderKey?>? provider,
		Value<String?>? name,
		Value<String?>? baseUrl,
		Value<bool?>? isEnabled,
		Value<String?>? usernameCiphertext,
		Value<String?>? passwordCiphertext,
		Value<String?>? apiKeyCiphertext,
		Value<String?>? tokenCiphertext,
		Value<Region?>? region,
		Value<dynamic>? config,
		Value<DateTime?>? lastSyncAt,
		Value<SyncStatus?>? status,
		Value<String?>? lastError,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<List<MLSExternalListing>?>? externalListings,
		Value<List<MLSSyncJob>?>? syncJobs,
		int? $externalListingsCount,
		int? $syncJobsCount,
        }) {
        return MLSConnection(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		provider: provider != null ? provider.value : this.provider,
		name: name != null ? name.value : this.name,
		baseUrl: baseUrl != null ? baseUrl.value : this.baseUrl,
		isEnabled: isEnabled != null ? isEnabled.value : this.isEnabled,
		usernameCiphertext: usernameCiphertext != null ? usernameCiphertext.value : this.usernameCiphertext,
		passwordCiphertext: passwordCiphertext != null ? passwordCiphertext.value : this.passwordCiphertext,
		apiKeyCiphertext: apiKeyCiphertext != null ? apiKeyCiphertext.value : this.apiKeyCiphertext,
		tokenCiphertext: tokenCiphertext != null ? tokenCiphertext.value : this.tokenCiphertext,
		region: region != null ? region.value : this.region,
		config: config != null ? config.value : this.config,
		lastSyncAt: lastSyncAt != null ? lastSyncAt.value : this.lastSyncAt,
		status: status != null ? status.value : this.status,
		lastError: lastError != null ? lastError.value : this.lastError,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		externalListings: externalListings != null ? externalListings.value : this.externalListings,
		syncJobs: syncJobs != null ? syncJobs.value : this.syncJobs,
		$externalListingsCount: $externalListingsCount ?? this.$externalListingsCount,
		$syncJobsCount: $syncJobsCount ?? this.$syncJobsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MLSConnection copyWithInstanceValues(MLSConnection mLSConnection) {
        return MLSConnection(
            id: mLSConnection.id ?? id,
		orgId: mLSConnection.orgId ?? orgId,
		provider: mLSConnection.provider ?? provider,
		name: mLSConnection.name ?? name,
		baseUrl: mLSConnection.baseUrl ?? baseUrl,
		isEnabled: mLSConnection.isEnabled ?? isEnabled,
		usernameCiphertext: mLSConnection.usernameCiphertext ?? usernameCiphertext,
		passwordCiphertext: mLSConnection.passwordCiphertext ?? passwordCiphertext,
		apiKeyCiphertext: mLSConnection.apiKeyCiphertext ?? apiKeyCiphertext,
		tokenCiphertext: mLSConnection.tokenCiphertext ?? tokenCiphertext,
		region: mLSConnection.region ?? region,
		config: mLSConnection.config ?? config,
		lastSyncAt: mLSConnection.lastSyncAt ?? lastSyncAt,
		status: mLSConnection.status ?? status,
		lastError: mLSConnection.lastError ?? lastError,
		createdBy: mLSConnection.createdBy ?? createdBy,
		createdAt: mLSConnection.createdAt ?? createdAt,
		updatedAt: mLSConnection.updatedAt ?? updatedAt,
		deletedAt: mLSConnection.deletedAt ?? deletedAt,
		org: mLSConnection.org ?? org,
		externalListings: mLSConnection.externalListings ?? externalListings,
		syncJobs: mLSConnection.syncJobs ?? syncJobs,
		$externalListingsCount: mLSConnection.$externalListingsCount ?? $externalListingsCount,
		$syncJobsCount: mLSConnection.$syncJobsCount ?? $syncJobsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MLSConnection mergeWithInstanceValues(MLSConnection mLSConnection) {
        return MLSConnection(
            id: mLSConnection.$assignedFields.contains('id') ? mLSConnection.id : id,
		orgId: mLSConnection.$assignedFields.contains('orgId') ? mLSConnection.orgId : orgId,
		provider: mLSConnection.$assignedFields.contains('provider') ? mLSConnection.provider : provider,
		name: mLSConnection.$assignedFields.contains('name') ? mLSConnection.name : name,
		baseUrl: mLSConnection.$assignedFields.contains('baseUrl') ? mLSConnection.baseUrl : baseUrl,
		isEnabled: mLSConnection.$assignedFields.contains('isEnabled') ? mLSConnection.isEnabled : isEnabled,
		usernameCiphertext: mLSConnection.$assignedFields.contains('usernameCiphertext') ? mLSConnection.usernameCiphertext : usernameCiphertext,
		passwordCiphertext: mLSConnection.$assignedFields.contains('passwordCiphertext') ? mLSConnection.passwordCiphertext : passwordCiphertext,
		apiKeyCiphertext: mLSConnection.$assignedFields.contains('apiKeyCiphertext') ? mLSConnection.apiKeyCiphertext : apiKeyCiphertext,
		tokenCiphertext: mLSConnection.$assignedFields.contains('tokenCiphertext') ? mLSConnection.tokenCiphertext : tokenCiphertext,
		region: mLSConnection.$assignedFields.contains('region') ? mLSConnection.region : region,
		config: mLSConnection.$assignedFields.contains('config') ? mLSConnection.config : config,
		lastSyncAt: mLSConnection.$assignedFields.contains('lastSyncAt') ? mLSConnection.lastSyncAt : lastSyncAt,
		status: mLSConnection.$assignedFields.contains('status') ? mLSConnection.status : status,
		lastError: mLSConnection.$assignedFields.contains('lastError') ? mLSConnection.lastError : lastError,
		createdBy: mLSConnection.$assignedFields.contains('createdBy') ? mLSConnection.createdBy : createdBy,
		createdAt: mLSConnection.$assignedFields.contains('createdAt') ? mLSConnection.createdAt : createdAt,
		updatedAt: mLSConnection.$assignedFields.contains('updatedAt') ? mLSConnection.updatedAt : updatedAt,
		deletedAt: mLSConnection.$assignedFields.contains('deletedAt') ? mLSConnection.deletedAt : deletedAt,
		org: mLSConnection.$assignedFields.contains('org') ? mLSConnection.org : org,
		externalListings: (mLSConnection.$assignedFields.contains('externalListings') && mLSConnection.externalListings != null) ? mergeModelLists(externalListings, mLSConnection.externalListings) : externalListings,
		syncJobs: (mLSConnection.$assignedFields.contains('syncJobs') && mLSConnection.syncJobs != null) ? mergeModelLists(syncJobs, mLSConnection.syncJobs) : syncJobs,
		$externalListingsCount: mLSConnection.$externalListingsCount ?? $externalListingsCount,
		$syncJobsCount: mLSConnection.$syncJobsCount ?? $syncJobsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MLSConnection updateWithInstanceValues(MLSConnection mLSConnection) {
        if (mLSConnection.$assignedFields.contains('id')) { id = mLSConnection.id; }
		if (mLSConnection.$assignedFields.contains('orgId')) { orgId = mLSConnection.orgId; }
		if (mLSConnection.$assignedFields.contains('provider')) { provider = mLSConnection.provider; }
		if (mLSConnection.$assignedFields.contains('name')) { name = mLSConnection.name; }
		if (mLSConnection.$assignedFields.contains('baseUrl')) { baseUrl = mLSConnection.baseUrl; }
		if (mLSConnection.$assignedFields.contains('isEnabled')) { isEnabled = mLSConnection.isEnabled; }
		if (mLSConnection.$assignedFields.contains('usernameCiphertext')) { usernameCiphertext = mLSConnection.usernameCiphertext; }
		if (mLSConnection.$assignedFields.contains('passwordCiphertext')) { passwordCiphertext = mLSConnection.passwordCiphertext; }
		if (mLSConnection.$assignedFields.contains('apiKeyCiphertext')) { apiKeyCiphertext = mLSConnection.apiKeyCiphertext; }
		if (mLSConnection.$assignedFields.contains('tokenCiphertext')) { tokenCiphertext = mLSConnection.tokenCiphertext; }
		if (mLSConnection.$assignedFields.contains('region')) { region = mLSConnection.region; }
		if (mLSConnection.$assignedFields.contains('config')) { config = mLSConnection.config; }
		if (mLSConnection.$assignedFields.contains('lastSyncAt')) { lastSyncAt = mLSConnection.lastSyncAt; }
		if (mLSConnection.$assignedFields.contains('status')) { status = mLSConnection.status; }
		if (mLSConnection.$assignedFields.contains('lastError')) { lastError = mLSConnection.lastError; }
		if (mLSConnection.$assignedFields.contains('createdBy')) { createdBy = mLSConnection.createdBy; }
		if (mLSConnection.$assignedFields.contains('createdAt')) { createdAt = mLSConnection.createdAt; }
		if (mLSConnection.$assignedFields.contains('updatedAt')) { updatedAt = mLSConnection.updatedAt; }
		if (mLSConnection.$assignedFields.contains('deletedAt')) { deletedAt = mLSConnection.deletedAt; }
		if (mLSConnection.$assignedFields.contains('org')) { org = mLSConnection.org; }
		if (mLSConnection.$assignedFields.contains('externalListings') && mLSConnection.externalListings != null) { externalListings = mergeModelLists(externalListings, mLSConnection.externalListings); }
		if (mLSConnection.$assignedFields.contains('syncJobs') && mLSConnection.syncJobs != null) { syncJobs = mergeModelLists(syncJobs, mLSConnection.syncJobs); }
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
          ? {...?serializedTypes, 'MLSConnection'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(provider != null) 'provider': provider?.toJson(),
	if(name != null) 'name': name,
	if(baseUrl != null) 'baseUrl': baseUrl,
	if(isEnabled != null) 'isEnabled': isEnabled,
	if(usernameCiphertext != null) 'usernameCiphertext': usernameCiphertext,
	if(passwordCiphertext != null) 'passwordCiphertext': passwordCiphertext,
	if(apiKeyCiphertext != null) 'apiKeyCiphertext': apiKeyCiphertext,
	if(tokenCiphertext != null) 'tokenCiphertext': tokenCiphertext,
	if(region != null) 'region': region?.toJson(),
	if(config != null) 'config': config,
	if(lastSyncAt != null) 'lastSyncAt': lastSyncAt?.toIso8601String(),
	if(status != null) 'status': status?.toJson(),
	if(lastError != null) 'lastError': lastError,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(externalListings != null && (!preventCircularSerialization || !serializedModels.contains('MLSExternalListing'))) 'externalListings': externalListings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(syncJobs != null && (!preventCircularSerialization || !serializedModels.contains('MLSSyncJob'))) 'syncJobs': syncJobs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($externalListingsCount != null || $syncJobsCount != null) '_count': { 
		if ($externalListingsCount != null) 'externalListings': $externalListingsCount, 
		if ($syncJobsCount != null) 'syncJobs': $syncJobsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MLSConnection &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    