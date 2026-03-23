
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'rental_platform.dart';
import 'sync_direction.dart';
import 'sync_status.dart';
import 'organization.dart';
import 'external_rental_listing.dart';
import 'rental_sync_job.dart';


class ApiIntegration implements PrismaModel<String, ApiIntegration> , Id<String> {
    @override
String? id;
	String? orgId;
	RentalPlatform? platform;
	String? name;
	bool? isEnabled;
	String? apiKey;
	String? apiSecret;
	String? accessToken;
	String? refreshToken;
	DateTime? tokenExpiry;
	String? baseUrl;
	dynamic config;
	int? rateLimit;
	SyncDirection? syncDirection;
	bool? autoSync;
	int? syncInterval;
	DateTime? lastSyncAt;
	SyncStatus? lastSyncStatus;
	String? lastError;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	List<ExternalRentalListing>? externalListings;
	List<RentalSyncJob>? syncJobs;
	int? $externalListingsCount;
	int? $syncJobsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ApiIntegration({ this.id,
	 this.orgId,
	 this.platform,
	 this.name,
	 this.isEnabled = false,
	 this.apiKey,
	 this.apiSecret,
	 this.accessToken,
	 this.refreshToken,
	 this.tokenExpiry,
	 this.baseUrl,
	required this.config,
	 this.rateLimit = 1000,
	 this.syncDirection = SyncDirection.BIDIRECTIONAL,
	 this.autoSync = true,
	 this.syncInterval = 15,
	 this.lastSyncAt,
	 this.lastSyncStatus = SyncStatus.IDLE,
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

    Map<String, GetPropertyValueFunction<ApiIntegration, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"platform": (m) => m.platform,

	"name": (m) => m.name,

	"isEnabled": (m) => m.isEnabled,

	"apiKey": (m) => m.apiKey,

	"apiSecret": (m) => m.apiSecret,

	"accessToken": (m) => m.accessToken,

	"refreshToken": (m) => m.refreshToken,

	"tokenExpiry": (m) => m.tokenExpiry,

	"baseUrl": (m) => m.baseUrl,

	"config": (m) => m.config,

	"rateLimit": (m) => m.rateLimit,

	"syncDirection": (m) => m.syncDirection,

	"autoSync": (m) => m.autoSync,

	"syncInterval": (m) => m.syncInterval,

	"lastSyncAt": (m) => m.lastSyncAt,

	"lastSyncStatus": (m) => m.lastSyncStatus,

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
  V? Function(ApiIntegration) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ApiIntegration');
    }
    return propFunction as V? Function(ApiIntegration);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ApiIntegration.fromJson(JsonMap json) =>
      ApiIntegration(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	platform: json['platform'] != null ? RentalPlatform.fromJson(json['platform']) : null,
	name: json['name'] as String?,
	isEnabled: json['isEnabled'] as bool?,
	apiKey: json['apiKey'] as String?,
	apiSecret: json['apiSecret'] as String?,
	accessToken: json['accessToken'] as String?,
	refreshToken: json['refreshToken'] as String?,
	tokenExpiry: json['tokenExpiry'] != null ? DateTime.parse(json['tokenExpiry']) : null,
	baseUrl: json['baseUrl'] as String?,
	config: json['config'] as dynamic,
	rateLimit: int.tryParse(json['rateLimit'].toString()),
	syncDirection: json['syncDirection'] != null ? SyncDirection.fromJson(json['syncDirection']) : null,
	autoSync: json['autoSync'] as bool?,
	syncInterval: int.tryParse(json['syncInterval'].toString()),
	lastSyncAt: json['lastSyncAt'] != null ? DateTime.parse(json['lastSyncAt']) : null,
	lastSyncStatus: json['lastSyncStatus'] != null ? SyncStatus.fromJson(json['lastSyncStatus']) : null,
	lastError: json['lastError'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	externalListings: json['externalListings'] != null ? createModels<ExternalRentalListing>((json['externalListings'] as List).cast<JsonMap>(), ExternalRentalListing.fromJson) : null,
	syncJobs: json['syncJobs'] != null ? createModels<RentalSyncJob>((json['syncJobs'] as List).cast<JsonMap>(), RentalSyncJob.fromJson) : null,
	$externalListingsCount: json['_count']?['externalListings'] as int?,
	$syncJobsCount: json['_count']?['syncJobs'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ApiIntegration copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<RentalPlatform?>? platform,
		Value<String?>? name,
		Value<bool?>? isEnabled,
		Value<String?>? apiKey,
		Value<String?>? apiSecret,
		Value<String?>? accessToken,
		Value<String?>? refreshToken,
		Value<DateTime?>? tokenExpiry,
		Value<String?>? baseUrl,
		Value<dynamic>? config,
		Value<int?>? rateLimit,
		Value<SyncDirection?>? syncDirection,
		Value<bool?>? autoSync,
		Value<int?>? syncInterval,
		Value<DateTime?>? lastSyncAt,
		Value<SyncStatus?>? lastSyncStatus,
		Value<String?>? lastError,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<List<ExternalRentalListing>?>? externalListings,
		Value<List<RentalSyncJob>?>? syncJobs,
		int? $externalListingsCount,
		int? $syncJobsCount,
        }) {
        return ApiIntegration(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		platform: platform != null ? platform.value : this.platform,
		name: name != null ? name.value : this.name,
		isEnabled: isEnabled != null ? isEnabled.value : this.isEnabled,
		apiKey: apiKey != null ? apiKey.value : this.apiKey,
		apiSecret: apiSecret != null ? apiSecret.value : this.apiSecret,
		accessToken: accessToken != null ? accessToken.value : this.accessToken,
		refreshToken: refreshToken != null ? refreshToken.value : this.refreshToken,
		tokenExpiry: tokenExpiry != null ? tokenExpiry.value : this.tokenExpiry,
		baseUrl: baseUrl != null ? baseUrl.value : this.baseUrl,
		config: config != null ? config.value : this.config,
		rateLimit: rateLimit != null ? rateLimit.value : this.rateLimit,
		syncDirection: syncDirection != null ? syncDirection.value : this.syncDirection,
		autoSync: autoSync != null ? autoSync.value : this.autoSync,
		syncInterval: syncInterval != null ? syncInterval.value : this.syncInterval,
		lastSyncAt: lastSyncAt != null ? lastSyncAt.value : this.lastSyncAt,
		lastSyncStatus: lastSyncStatus != null ? lastSyncStatus.value : this.lastSyncStatus,
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
    ApiIntegration copyWithInstanceValues(ApiIntegration apiIntegration) {
        return ApiIntegration(
            id: apiIntegration.id ?? id,
		orgId: apiIntegration.orgId ?? orgId,
		platform: apiIntegration.platform ?? platform,
		name: apiIntegration.name ?? name,
		isEnabled: apiIntegration.isEnabled ?? isEnabled,
		apiKey: apiIntegration.apiKey ?? apiKey,
		apiSecret: apiIntegration.apiSecret ?? apiSecret,
		accessToken: apiIntegration.accessToken ?? accessToken,
		refreshToken: apiIntegration.refreshToken ?? refreshToken,
		tokenExpiry: apiIntegration.tokenExpiry ?? tokenExpiry,
		baseUrl: apiIntegration.baseUrl ?? baseUrl,
		config: apiIntegration.config ?? config,
		rateLimit: apiIntegration.rateLimit ?? rateLimit,
		syncDirection: apiIntegration.syncDirection ?? syncDirection,
		autoSync: apiIntegration.autoSync ?? autoSync,
		syncInterval: apiIntegration.syncInterval ?? syncInterval,
		lastSyncAt: apiIntegration.lastSyncAt ?? lastSyncAt,
		lastSyncStatus: apiIntegration.lastSyncStatus ?? lastSyncStatus,
		lastError: apiIntegration.lastError ?? lastError,
		createdBy: apiIntegration.createdBy ?? createdBy,
		createdAt: apiIntegration.createdAt ?? createdAt,
		updatedAt: apiIntegration.updatedAt ?? updatedAt,
		deletedAt: apiIntegration.deletedAt ?? deletedAt,
		org: apiIntegration.org ?? org,
		externalListings: apiIntegration.externalListings ?? externalListings,
		syncJobs: apiIntegration.syncJobs ?? syncJobs,
		$externalListingsCount: apiIntegration.$externalListingsCount ?? $externalListingsCount,
		$syncJobsCount: apiIntegration.$syncJobsCount ?? $syncJobsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ApiIntegration mergeWithInstanceValues(ApiIntegration apiIntegration) {
        return ApiIntegration(
            id: apiIntegration.$assignedFields.contains('id') ? apiIntegration.id : id,
		orgId: apiIntegration.$assignedFields.contains('orgId') ? apiIntegration.orgId : orgId,
		platform: apiIntegration.$assignedFields.contains('platform') ? apiIntegration.platform : platform,
		name: apiIntegration.$assignedFields.contains('name') ? apiIntegration.name : name,
		isEnabled: apiIntegration.$assignedFields.contains('isEnabled') ? apiIntegration.isEnabled : isEnabled,
		apiKey: apiIntegration.$assignedFields.contains('apiKey') ? apiIntegration.apiKey : apiKey,
		apiSecret: apiIntegration.$assignedFields.contains('apiSecret') ? apiIntegration.apiSecret : apiSecret,
		accessToken: apiIntegration.$assignedFields.contains('accessToken') ? apiIntegration.accessToken : accessToken,
		refreshToken: apiIntegration.$assignedFields.contains('refreshToken') ? apiIntegration.refreshToken : refreshToken,
		tokenExpiry: apiIntegration.$assignedFields.contains('tokenExpiry') ? apiIntegration.tokenExpiry : tokenExpiry,
		baseUrl: apiIntegration.$assignedFields.contains('baseUrl') ? apiIntegration.baseUrl : baseUrl,
		config: apiIntegration.$assignedFields.contains('config') ? apiIntegration.config : config,
		rateLimit: apiIntegration.$assignedFields.contains('rateLimit') ? apiIntegration.rateLimit : rateLimit,
		syncDirection: apiIntegration.$assignedFields.contains('syncDirection') ? apiIntegration.syncDirection : syncDirection,
		autoSync: apiIntegration.$assignedFields.contains('autoSync') ? apiIntegration.autoSync : autoSync,
		syncInterval: apiIntegration.$assignedFields.contains('syncInterval') ? apiIntegration.syncInterval : syncInterval,
		lastSyncAt: apiIntegration.$assignedFields.contains('lastSyncAt') ? apiIntegration.lastSyncAt : lastSyncAt,
		lastSyncStatus: apiIntegration.$assignedFields.contains('lastSyncStatus') ? apiIntegration.lastSyncStatus : lastSyncStatus,
		lastError: apiIntegration.$assignedFields.contains('lastError') ? apiIntegration.lastError : lastError,
		createdBy: apiIntegration.$assignedFields.contains('createdBy') ? apiIntegration.createdBy : createdBy,
		createdAt: apiIntegration.$assignedFields.contains('createdAt') ? apiIntegration.createdAt : createdAt,
		updatedAt: apiIntegration.$assignedFields.contains('updatedAt') ? apiIntegration.updatedAt : updatedAt,
		deletedAt: apiIntegration.$assignedFields.contains('deletedAt') ? apiIntegration.deletedAt : deletedAt,
		org: apiIntegration.$assignedFields.contains('org') ? apiIntegration.org : org,
		externalListings: (apiIntegration.$assignedFields.contains('externalListings') && apiIntegration.externalListings != null) ? mergeModelLists(externalListings, apiIntegration.externalListings) : externalListings,
		syncJobs: (apiIntegration.$assignedFields.contains('syncJobs') && apiIntegration.syncJobs != null) ? mergeModelLists(syncJobs, apiIntegration.syncJobs) : syncJobs,
		$externalListingsCount: apiIntegration.$externalListingsCount ?? $externalListingsCount,
		$syncJobsCount: apiIntegration.$syncJobsCount ?? $syncJobsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ApiIntegration updateWithInstanceValues(ApiIntegration apiIntegration) {
        if (apiIntegration.$assignedFields.contains('id')) { id = apiIntegration.id; }
		if (apiIntegration.$assignedFields.contains('orgId')) { orgId = apiIntegration.orgId; }
		if (apiIntegration.$assignedFields.contains('platform')) { platform = apiIntegration.platform; }
		if (apiIntegration.$assignedFields.contains('name')) { name = apiIntegration.name; }
		if (apiIntegration.$assignedFields.contains('isEnabled')) { isEnabled = apiIntegration.isEnabled; }
		if (apiIntegration.$assignedFields.contains('apiKey')) { apiKey = apiIntegration.apiKey; }
		if (apiIntegration.$assignedFields.contains('apiSecret')) { apiSecret = apiIntegration.apiSecret; }
		if (apiIntegration.$assignedFields.contains('accessToken')) { accessToken = apiIntegration.accessToken; }
		if (apiIntegration.$assignedFields.contains('refreshToken')) { refreshToken = apiIntegration.refreshToken; }
		if (apiIntegration.$assignedFields.contains('tokenExpiry')) { tokenExpiry = apiIntegration.tokenExpiry; }
		if (apiIntegration.$assignedFields.contains('baseUrl')) { baseUrl = apiIntegration.baseUrl; }
		if (apiIntegration.$assignedFields.contains('config')) { config = apiIntegration.config; }
		if (apiIntegration.$assignedFields.contains('rateLimit')) { rateLimit = apiIntegration.rateLimit; }
		if (apiIntegration.$assignedFields.contains('syncDirection')) { syncDirection = apiIntegration.syncDirection; }
		if (apiIntegration.$assignedFields.contains('autoSync')) { autoSync = apiIntegration.autoSync; }
		if (apiIntegration.$assignedFields.contains('syncInterval')) { syncInterval = apiIntegration.syncInterval; }
		if (apiIntegration.$assignedFields.contains('lastSyncAt')) { lastSyncAt = apiIntegration.lastSyncAt; }
		if (apiIntegration.$assignedFields.contains('lastSyncStatus')) { lastSyncStatus = apiIntegration.lastSyncStatus; }
		if (apiIntegration.$assignedFields.contains('lastError')) { lastError = apiIntegration.lastError; }
		if (apiIntegration.$assignedFields.contains('createdBy')) { createdBy = apiIntegration.createdBy; }
		if (apiIntegration.$assignedFields.contains('createdAt')) { createdAt = apiIntegration.createdAt; }
		if (apiIntegration.$assignedFields.contains('updatedAt')) { updatedAt = apiIntegration.updatedAt; }
		if (apiIntegration.$assignedFields.contains('deletedAt')) { deletedAt = apiIntegration.deletedAt; }
		if (apiIntegration.$assignedFields.contains('org')) { org = apiIntegration.org; }
		if (apiIntegration.$assignedFields.contains('externalListings') && apiIntegration.externalListings != null) { externalListings = mergeModelLists(externalListings, apiIntegration.externalListings); }
		if (apiIntegration.$assignedFields.contains('syncJobs') && apiIntegration.syncJobs != null) { syncJobs = mergeModelLists(syncJobs, apiIntegration.syncJobs); }
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
          ? {...?serializedTypes, 'ApiIntegration'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(platform != null) 'platform': platform?.toJson(),
	if(name != null) 'name': name,
	if(isEnabled != null) 'isEnabled': isEnabled,
	if(apiKey != null) 'apiKey': apiKey,
	if(apiSecret != null) 'apiSecret': apiSecret,
	if(accessToken != null) 'accessToken': accessToken,
	if(refreshToken != null) 'refreshToken': refreshToken,
	if(tokenExpiry != null) 'tokenExpiry': tokenExpiry?.toIso8601String(),
	if(baseUrl != null) 'baseUrl': baseUrl,
	if(config != null) 'config': config,
	if(rateLimit != null) 'rateLimit': rateLimit,
	if(syncDirection != null) 'syncDirection': syncDirection?.toJson(),
	if(autoSync != null) 'autoSync': autoSync,
	if(syncInterval != null) 'syncInterval': syncInterval,
	if(lastSyncAt != null) 'lastSyncAt': lastSyncAt?.toIso8601String(),
	if(lastSyncStatus != null) 'lastSyncStatus': lastSyncStatus?.toJson(),
	if(lastError != null) 'lastError': lastError,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(externalListings != null && (!preventCircularSerialization || !serializedModels.contains('ExternalRentalListing'))) 'externalListings': externalListings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(syncJobs != null && (!preventCircularSerialization || !serializedModels.contains('RentalSyncJob'))) 'syncJobs': syncJobs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
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
            identical(this, other) || other is ApiIntegration &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    