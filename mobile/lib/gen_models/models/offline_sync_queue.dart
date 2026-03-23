
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'mobile_device.dart';
import 'organization.dart';
import 'user.dart';


class OfflineSyncQueue implements PrismaModel<String, OfflineSyncQueue> , Id<String> {
    @override
String? id;
	String? orgId;
	String? userId;
	String? deviceId;
	String? entityType;
	String? entityId;
	String? operation;
	dynamic data;
	int? version;
	String? syncStatus;
	DateTime? createdAt;
	DateTime? syncedAt;
	MobileDevice? device;
	Organization? org;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    OfflineSyncQueue({ this.id,
	 this.orgId,
	 this.userId,
	 this.deviceId,
	 this.entityType,
	 this.entityId,
	 this.operation,
	required this.data,
	 this.version = 1,
	 this.syncStatus = "PENDING",
	 this.createdAt,
	 this.syncedAt,
	 this.device,
	 this.org,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<OfflineSyncQueue, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"userId": (m) => m.userId,

	"deviceId": (m) => m.deviceId,

	"entityType": (m) => m.entityType,

	"entityId": (m) => m.entityId,

	"operation": (m) => m.operation,

	"data": (m) => m.data,

	"version": (m) => m.version,

	"syncStatus": (m) => m.syncStatus,

	"createdAt": (m) => m.createdAt,

	"syncedAt": (m) => m.syncedAt,

	"device": (m) => m.device,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(OfflineSyncQueue) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in OfflineSyncQueue');
    }
    return propFunction as V? Function(OfflineSyncQueue);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory OfflineSyncQueue.fromJson(JsonMap json) =>
      OfflineSyncQueue(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	userId: json['userId'] as String?,
	deviceId: json['deviceId'] as String?,
	entityType: json['entityType'] as String?,
	entityId: json['entityId'] as String?,
	operation: json['operation'] as String?,
	data: json['data'] as dynamic,
	version: int.tryParse(json['version'].toString()),
	syncStatus: json['syncStatus'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	syncedAt: json['syncedAt'] != null ? DateTime.parse(json['syncedAt']) : null,
	device: json['device'] != null ? MobileDevice.fromJson(json['device'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    OfflineSyncQueue copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? userId,
		Value<String?>? deviceId,
		Value<String?>? entityType,
		Value<String?>? entityId,
		Value<String?>? operation,
		Value<dynamic>? data,
		Value<int?>? version,
		Value<String?>? syncStatus,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? syncedAt,
		Value<MobileDevice?>? device,
		Value<Organization?>? org,
		Value<User?>? user,
        }) {
        return OfflineSyncQueue(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		userId: userId != null ? userId.value : this.userId,
		deviceId: deviceId != null ? deviceId.value : this.deviceId,
		entityType: entityType != null ? entityType.value : this.entityType,
		entityId: entityId != null ? entityId.value : this.entityId,
		operation: operation != null ? operation.value : this.operation,
		data: data != null ? data.value : this.data,
		version: version != null ? version.value : this.version,
		syncStatus: syncStatus != null ? syncStatus.value : this.syncStatus,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		syncedAt: syncedAt != null ? syncedAt.value : this.syncedAt,
		device: device != null ? device.value : this.device,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    OfflineSyncQueue copyWithInstanceValues(OfflineSyncQueue offlineSyncQueue) {
        return OfflineSyncQueue(
            id: offlineSyncQueue.id ?? id,
		orgId: offlineSyncQueue.orgId ?? orgId,
		userId: offlineSyncQueue.userId ?? userId,
		deviceId: offlineSyncQueue.deviceId ?? deviceId,
		entityType: offlineSyncQueue.entityType ?? entityType,
		entityId: offlineSyncQueue.entityId ?? entityId,
		operation: offlineSyncQueue.operation ?? operation,
		data: offlineSyncQueue.data ?? data,
		version: offlineSyncQueue.version ?? version,
		syncStatus: offlineSyncQueue.syncStatus ?? syncStatus,
		createdAt: offlineSyncQueue.createdAt ?? createdAt,
		syncedAt: offlineSyncQueue.syncedAt ?? syncedAt,
		device: offlineSyncQueue.device ?? device,
		org: offlineSyncQueue.org ?? org,
		user: offlineSyncQueue.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    OfflineSyncQueue mergeWithInstanceValues(OfflineSyncQueue offlineSyncQueue) {
        return OfflineSyncQueue(
            id: offlineSyncQueue.$assignedFields.contains('id') ? offlineSyncQueue.id : id,
		orgId: offlineSyncQueue.$assignedFields.contains('orgId') ? offlineSyncQueue.orgId : orgId,
		userId: offlineSyncQueue.$assignedFields.contains('userId') ? offlineSyncQueue.userId : userId,
		deviceId: offlineSyncQueue.$assignedFields.contains('deviceId') ? offlineSyncQueue.deviceId : deviceId,
		entityType: offlineSyncQueue.$assignedFields.contains('entityType') ? offlineSyncQueue.entityType : entityType,
		entityId: offlineSyncQueue.$assignedFields.contains('entityId') ? offlineSyncQueue.entityId : entityId,
		operation: offlineSyncQueue.$assignedFields.contains('operation') ? offlineSyncQueue.operation : operation,
		data: offlineSyncQueue.$assignedFields.contains('data') ? offlineSyncQueue.data : data,
		version: offlineSyncQueue.$assignedFields.contains('version') ? offlineSyncQueue.version : version,
		syncStatus: offlineSyncQueue.$assignedFields.contains('syncStatus') ? offlineSyncQueue.syncStatus : syncStatus,
		createdAt: offlineSyncQueue.$assignedFields.contains('createdAt') ? offlineSyncQueue.createdAt : createdAt,
		syncedAt: offlineSyncQueue.$assignedFields.contains('syncedAt') ? offlineSyncQueue.syncedAt : syncedAt,
		device: offlineSyncQueue.$assignedFields.contains('device') ? offlineSyncQueue.device : device,
		org: offlineSyncQueue.$assignedFields.contains('org') ? offlineSyncQueue.org : org,
		user: offlineSyncQueue.$assignedFields.contains('user') ? offlineSyncQueue.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    OfflineSyncQueue updateWithInstanceValues(OfflineSyncQueue offlineSyncQueue) {
        if (offlineSyncQueue.$assignedFields.contains('id')) { id = offlineSyncQueue.id; }
		if (offlineSyncQueue.$assignedFields.contains('orgId')) { orgId = offlineSyncQueue.orgId; }
		if (offlineSyncQueue.$assignedFields.contains('userId')) { userId = offlineSyncQueue.userId; }
		if (offlineSyncQueue.$assignedFields.contains('deviceId')) { deviceId = offlineSyncQueue.deviceId; }
		if (offlineSyncQueue.$assignedFields.contains('entityType')) { entityType = offlineSyncQueue.entityType; }
		if (offlineSyncQueue.$assignedFields.contains('entityId')) { entityId = offlineSyncQueue.entityId; }
		if (offlineSyncQueue.$assignedFields.contains('operation')) { operation = offlineSyncQueue.operation; }
		if (offlineSyncQueue.$assignedFields.contains('data')) { data = offlineSyncQueue.data; }
		if (offlineSyncQueue.$assignedFields.contains('version')) { version = offlineSyncQueue.version; }
		if (offlineSyncQueue.$assignedFields.contains('syncStatus')) { syncStatus = offlineSyncQueue.syncStatus; }
		if (offlineSyncQueue.$assignedFields.contains('createdAt')) { createdAt = offlineSyncQueue.createdAt; }
		if (offlineSyncQueue.$assignedFields.contains('syncedAt')) { syncedAt = offlineSyncQueue.syncedAt; }
		if (offlineSyncQueue.$assignedFields.contains('device')) { device = offlineSyncQueue.device; }
		if (offlineSyncQueue.$assignedFields.contains('org')) { org = offlineSyncQueue.org; }
		if (offlineSyncQueue.$assignedFields.contains('user')) { user = offlineSyncQueue.user; }
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
          ? {...?serializedTypes, 'OfflineSyncQueue'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(userId != null) 'userId': userId,
	if(deviceId != null) 'deviceId': deviceId,
	if(entityType != null) 'entityType': entityType,
	if(entityId != null) 'entityId': entityId,
	if(operation != null) 'operation': operation,
	if(data != null) 'data': data,
	if(version != null) 'version': version,
	if(syncStatus != null) 'syncStatus': syncStatus,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(syncedAt != null) 'syncedAt': syncedAt?.toIso8601String(),
	if(device != null && (!preventCircularSerialization || !serializedModels.contains('MobileDevice'))) 'device': device?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is OfflineSyncQueue &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    