
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'user.dart';
import 'offline_sync_queue.dart';


class MobileDevice implements PrismaModel<String, MobileDevice> , Id<String> {
    @override
String? id;
	String? orgId;
	String? userId;
	String? deviceId;
	String? deviceType;
	String? deviceToken;
	String? appVersion;
	String? osVersion;
	bool? isActive;
	DateTime? lastLoginAt;
	dynamic notificationPreferences;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;
	User? user;
	List<OfflineSyncQueue>? offlineSyncQueues;
	int? $offlineSyncQueuesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MobileDevice({ this.id,
	 this.orgId,
	 this.userId,
	 this.deviceId,
	 this.deviceType,
	 this.deviceToken,
	 this.appVersion,
	 this.osVersion,
	 this.isActive = true,
	 this.lastLoginAt,
	required this.notificationPreferences,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
	 this.user,
	 this.offlineSyncQueues,
	this.$offlineSyncQueuesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MobileDevice, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"userId": (m) => m.userId,

	"deviceId": (m) => m.deviceId,

	"deviceType": (m) => m.deviceType,

	"deviceToken": (m) => m.deviceToken,

	"appVersion": (m) => m.appVersion,

	"osVersion": (m) => m.osVersion,

	"isActive": (m) => m.isActive,

	"lastLoginAt": (m) => m.lastLoginAt,

	"notificationPreferences": (m) => m.notificationPreferences,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,

	"user": (m) => m.user,

	"offlineSyncQueues": (m) => m.offlineSyncQueues,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MobileDevice) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MobileDevice');
    }
    return propFunction as V? Function(MobileDevice);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MobileDevice.fromJson(JsonMap json) =>
      MobileDevice(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	userId: json['userId'] as String?,
	deviceId: json['deviceId'] as String?,
	deviceType: json['deviceType'] as String?,
	deviceToken: json['deviceToken'] as String?,
	appVersion: json['appVersion'] as String?,
	osVersion: json['osVersion'] as String?,
	isActive: json['isActive'] as bool?,
	lastLoginAt: json['lastLoginAt'] != null ? DateTime.parse(json['lastLoginAt']) : null,
	notificationPreferences: json['notificationPreferences'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
	offlineSyncQueues: json['offlineSyncQueues'] != null ? createModels<OfflineSyncQueue>((json['offlineSyncQueues'] as List).cast<JsonMap>(), OfflineSyncQueue.fromJson) : null,
	$offlineSyncQueuesCount: json['_count']?['offlineSyncQueues'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MobileDevice copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? userId,
		Value<String?>? deviceId,
		Value<String?>? deviceType,
		Value<String?>? deviceToken,
		Value<String?>? appVersion,
		Value<String?>? osVersion,
		Value<bool?>? isActive,
		Value<DateTime?>? lastLoginAt,
		Value<dynamic>? notificationPreferences,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
		Value<User?>? user,
		Value<List<OfflineSyncQueue>?>? offlineSyncQueues,
		int? $offlineSyncQueuesCount,
        }) {
        return MobileDevice(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		userId: userId != null ? userId.value : this.userId,
		deviceId: deviceId != null ? deviceId.value : this.deviceId,
		deviceType: deviceType != null ? deviceType.value : this.deviceType,
		deviceToken: deviceToken != null ? deviceToken.value : this.deviceToken,
		appVersion: appVersion != null ? appVersion.value : this.appVersion,
		osVersion: osVersion != null ? osVersion.value : this.osVersion,
		isActive: isActive != null ? isActive.value : this.isActive,
		lastLoginAt: lastLoginAt != null ? lastLoginAt.value : this.lastLoginAt,
		notificationPreferences: notificationPreferences != null ? notificationPreferences.value : this.notificationPreferences,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user,
		offlineSyncQueues: offlineSyncQueues != null ? offlineSyncQueues.value : this.offlineSyncQueues,
		$offlineSyncQueuesCount: $offlineSyncQueuesCount ?? this.$offlineSyncQueuesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MobileDevice copyWithInstanceValues(MobileDevice mobileDevice) {
        return MobileDevice(
            id: mobileDevice.id ?? id,
		orgId: mobileDevice.orgId ?? orgId,
		userId: mobileDevice.userId ?? userId,
		deviceId: mobileDevice.deviceId ?? deviceId,
		deviceType: mobileDevice.deviceType ?? deviceType,
		deviceToken: mobileDevice.deviceToken ?? deviceToken,
		appVersion: mobileDevice.appVersion ?? appVersion,
		osVersion: mobileDevice.osVersion ?? osVersion,
		isActive: mobileDevice.isActive ?? isActive,
		lastLoginAt: mobileDevice.lastLoginAt ?? lastLoginAt,
		notificationPreferences: mobileDevice.notificationPreferences ?? notificationPreferences,
		createdAt: mobileDevice.createdAt ?? createdAt,
		updatedAt: mobileDevice.updatedAt ?? updatedAt,
		org: mobileDevice.org ?? org,
		user: mobileDevice.user ?? user,
		offlineSyncQueues: mobileDevice.offlineSyncQueues ?? offlineSyncQueues,
		$offlineSyncQueuesCount: mobileDevice.$offlineSyncQueuesCount ?? $offlineSyncQueuesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MobileDevice mergeWithInstanceValues(MobileDevice mobileDevice) {
        return MobileDevice(
            id: mobileDevice.$assignedFields.contains('id') ? mobileDevice.id : id,
		orgId: mobileDevice.$assignedFields.contains('orgId') ? mobileDevice.orgId : orgId,
		userId: mobileDevice.$assignedFields.contains('userId') ? mobileDevice.userId : userId,
		deviceId: mobileDevice.$assignedFields.contains('deviceId') ? mobileDevice.deviceId : deviceId,
		deviceType: mobileDevice.$assignedFields.contains('deviceType') ? mobileDevice.deviceType : deviceType,
		deviceToken: mobileDevice.$assignedFields.contains('deviceToken') ? mobileDevice.deviceToken : deviceToken,
		appVersion: mobileDevice.$assignedFields.contains('appVersion') ? mobileDevice.appVersion : appVersion,
		osVersion: mobileDevice.$assignedFields.contains('osVersion') ? mobileDevice.osVersion : osVersion,
		isActive: mobileDevice.$assignedFields.contains('isActive') ? mobileDevice.isActive : isActive,
		lastLoginAt: mobileDevice.$assignedFields.contains('lastLoginAt') ? mobileDevice.lastLoginAt : lastLoginAt,
		notificationPreferences: mobileDevice.$assignedFields.contains('notificationPreferences') ? mobileDevice.notificationPreferences : notificationPreferences,
		createdAt: mobileDevice.$assignedFields.contains('createdAt') ? mobileDevice.createdAt : createdAt,
		updatedAt: mobileDevice.$assignedFields.contains('updatedAt') ? mobileDevice.updatedAt : updatedAt,
		org: mobileDevice.$assignedFields.contains('org') ? mobileDevice.org : org,
		user: mobileDevice.$assignedFields.contains('user') ? mobileDevice.user : user,
		offlineSyncQueues: (mobileDevice.$assignedFields.contains('offlineSyncQueues') && mobileDevice.offlineSyncQueues != null) ? mergeModelLists(offlineSyncQueues, mobileDevice.offlineSyncQueues) : offlineSyncQueues,
		$offlineSyncQueuesCount: mobileDevice.$offlineSyncQueuesCount ?? $offlineSyncQueuesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MobileDevice updateWithInstanceValues(MobileDevice mobileDevice) {
        if (mobileDevice.$assignedFields.contains('id')) { id = mobileDevice.id; }
		if (mobileDevice.$assignedFields.contains('orgId')) { orgId = mobileDevice.orgId; }
		if (mobileDevice.$assignedFields.contains('userId')) { userId = mobileDevice.userId; }
		if (mobileDevice.$assignedFields.contains('deviceId')) { deviceId = mobileDevice.deviceId; }
		if (mobileDevice.$assignedFields.contains('deviceType')) { deviceType = mobileDevice.deviceType; }
		if (mobileDevice.$assignedFields.contains('deviceToken')) { deviceToken = mobileDevice.deviceToken; }
		if (mobileDevice.$assignedFields.contains('appVersion')) { appVersion = mobileDevice.appVersion; }
		if (mobileDevice.$assignedFields.contains('osVersion')) { osVersion = mobileDevice.osVersion; }
		if (mobileDevice.$assignedFields.contains('isActive')) { isActive = mobileDevice.isActive; }
		if (mobileDevice.$assignedFields.contains('lastLoginAt')) { lastLoginAt = mobileDevice.lastLoginAt; }
		if (mobileDevice.$assignedFields.contains('notificationPreferences')) { notificationPreferences = mobileDevice.notificationPreferences; }
		if (mobileDevice.$assignedFields.contains('createdAt')) { createdAt = mobileDevice.createdAt; }
		if (mobileDevice.$assignedFields.contains('updatedAt')) { updatedAt = mobileDevice.updatedAt; }
		if (mobileDevice.$assignedFields.contains('org')) { org = mobileDevice.org; }
		if (mobileDevice.$assignedFields.contains('user')) { user = mobileDevice.user; }
		if (mobileDevice.$assignedFields.contains('offlineSyncQueues') && mobileDevice.offlineSyncQueues != null) { offlineSyncQueues = mergeModelLists(offlineSyncQueues, mobileDevice.offlineSyncQueues); }
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
          ? {...?serializedTypes, 'MobileDevice'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(userId != null) 'userId': userId,
	if(deviceId != null) 'deviceId': deviceId,
	if(deviceType != null) 'deviceType': deviceType,
	if(deviceToken != null) 'deviceToken': deviceToken,
	if(appVersion != null) 'appVersion': appVersion,
	if(osVersion != null) 'osVersion': osVersion,
	if(isActive != null) 'isActive': isActive,
	if(lastLoginAt != null) 'lastLoginAt': lastLoginAt?.toIso8601String(),
	if(notificationPreferences != null) 'notificationPreferences': notificationPreferences,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(offlineSyncQueues != null && (!preventCircularSerialization || !serializedModels.contains('OfflineSyncQueue'))) 'offlineSyncQueues': offlineSyncQueues?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($offlineSyncQueuesCount != null) '_count': { 
		if ($offlineSyncQueuesCount != null) 'offlineSyncQueues': $offlineSyncQueuesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MobileDevice &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    