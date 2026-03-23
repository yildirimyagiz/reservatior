
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'user.dart';


class UserActivityLog implements PrismaModel<String, UserActivityLog> , Id<String> {
    @override
String? id;
	String? userId;
	String? orgId;
	String? action;
	String? entityType;
	String? entityId;
	dynamic metadata;
	String? ipAddress;
	String? userAgent;
	DateTime? createdAt;
	Organization? org;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    UserActivityLog({ this.id,
	 this.userId,
	 this.orgId,
	 this.action,
	 this.entityType,
	 this.entityId,
	required this.metadata,
	 this.ipAddress,
	 this.userAgent,
	 this.createdAt,
	 this.org,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<UserActivityLog, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"orgId": (m) => m.orgId,

	"action": (m) => m.action,

	"entityType": (m) => m.entityType,

	"entityId": (m) => m.entityId,

	"metadata": (m) => m.metadata,

	"ipAddress": (m) => m.ipAddress,

	"userAgent": (m) => m.userAgent,

	"createdAt": (m) => m.createdAt,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(UserActivityLog) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in UserActivityLog');
    }
    return propFunction as V? Function(UserActivityLog);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory UserActivityLog.fromJson(JsonMap json) =>
      UserActivityLog(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	orgId: json['orgId'] as String?,
	action: json['action'] as String?,
	entityType: json['entityType'] as String?,
	entityId: json['entityId'] as String?,
	metadata: json['metadata'] as dynamic,
	ipAddress: json['ipAddress'] as String?,
	userAgent: json['userAgent'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    UserActivityLog copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? orgId,
		Value<String?>? action,
		Value<String?>? entityType,
		Value<String?>? entityId,
		Value<dynamic>? metadata,
		Value<String?>? ipAddress,
		Value<String?>? userAgent,
		Value<DateTime?>? createdAt,
		Value<Organization?>? org,
		Value<User?>? user,
        }) {
        return UserActivityLog(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		orgId: orgId != null ? orgId.value : this.orgId,
		action: action != null ? action.value : this.action,
		entityType: entityType != null ? entityType.value : this.entityType,
		entityId: entityId != null ? entityId.value : this.entityId,
		metadata: metadata != null ? metadata.value : this.metadata,
		ipAddress: ipAddress != null ? ipAddress.value : this.ipAddress,
		userAgent: userAgent != null ? userAgent.value : this.userAgent,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    UserActivityLog copyWithInstanceValues(UserActivityLog userActivityLog) {
        return UserActivityLog(
            id: userActivityLog.id ?? id,
		userId: userActivityLog.userId ?? userId,
		orgId: userActivityLog.orgId ?? orgId,
		action: userActivityLog.action ?? action,
		entityType: userActivityLog.entityType ?? entityType,
		entityId: userActivityLog.entityId ?? entityId,
		metadata: userActivityLog.metadata ?? metadata,
		ipAddress: userActivityLog.ipAddress ?? ipAddress,
		userAgent: userActivityLog.userAgent ?? userAgent,
		createdAt: userActivityLog.createdAt ?? createdAt,
		org: userActivityLog.org ?? org,
		user: userActivityLog.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    UserActivityLog mergeWithInstanceValues(UserActivityLog userActivityLog) {
        return UserActivityLog(
            id: userActivityLog.$assignedFields.contains('id') ? userActivityLog.id : id,
		userId: userActivityLog.$assignedFields.contains('userId') ? userActivityLog.userId : userId,
		orgId: userActivityLog.$assignedFields.contains('orgId') ? userActivityLog.orgId : orgId,
		action: userActivityLog.$assignedFields.contains('action') ? userActivityLog.action : action,
		entityType: userActivityLog.$assignedFields.contains('entityType') ? userActivityLog.entityType : entityType,
		entityId: userActivityLog.$assignedFields.contains('entityId') ? userActivityLog.entityId : entityId,
		metadata: userActivityLog.$assignedFields.contains('metadata') ? userActivityLog.metadata : metadata,
		ipAddress: userActivityLog.$assignedFields.contains('ipAddress') ? userActivityLog.ipAddress : ipAddress,
		userAgent: userActivityLog.$assignedFields.contains('userAgent') ? userActivityLog.userAgent : userAgent,
		createdAt: userActivityLog.$assignedFields.contains('createdAt') ? userActivityLog.createdAt : createdAt,
		org: userActivityLog.$assignedFields.contains('org') ? userActivityLog.org : org,
		user: userActivityLog.$assignedFields.contains('user') ? userActivityLog.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    UserActivityLog updateWithInstanceValues(UserActivityLog userActivityLog) {
        if (userActivityLog.$assignedFields.contains('id')) { id = userActivityLog.id; }
		if (userActivityLog.$assignedFields.contains('userId')) { userId = userActivityLog.userId; }
		if (userActivityLog.$assignedFields.contains('orgId')) { orgId = userActivityLog.orgId; }
		if (userActivityLog.$assignedFields.contains('action')) { action = userActivityLog.action; }
		if (userActivityLog.$assignedFields.contains('entityType')) { entityType = userActivityLog.entityType; }
		if (userActivityLog.$assignedFields.contains('entityId')) { entityId = userActivityLog.entityId; }
		if (userActivityLog.$assignedFields.contains('metadata')) { metadata = userActivityLog.metadata; }
		if (userActivityLog.$assignedFields.contains('ipAddress')) { ipAddress = userActivityLog.ipAddress; }
		if (userActivityLog.$assignedFields.contains('userAgent')) { userAgent = userActivityLog.userAgent; }
		if (userActivityLog.$assignedFields.contains('createdAt')) { createdAt = userActivityLog.createdAt; }
		if (userActivityLog.$assignedFields.contains('org')) { org = userActivityLog.org; }
		if (userActivityLog.$assignedFields.contains('user')) { user = userActivityLog.user; }
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
          ? {...?serializedTypes, 'UserActivityLog'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(orgId != null) 'orgId': orgId,
	if(action != null) 'action': action,
	if(entityType != null) 'entityType': entityType,
	if(entityId != null) 'entityId': entityId,
	if(metadata != null) 'metadata': metadata,
	if(ipAddress != null) 'ipAddress': ipAddress,
	if(userAgent != null) 'userAgent': userAgent,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is UserActivityLog &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    