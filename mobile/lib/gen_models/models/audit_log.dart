
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'user.dart';


class AuditLog implements PrismaModel<String, AuditLog> , Id<String> {
    @override
String? id;
	String? orgId;
	String? userId;
	String? action;
	String? entityType;
	String? entityId;
	dynamic oldValues;
	dynamic newValues;
	dynamic changes;
	String? ipAddress;
	String? userAgent;
	String? sessionId;
	DateTime? createdAt;
	Organization? org;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AuditLog({ this.id,
	 this.orgId,
	 this.userId,
	 this.action,
	 this.entityType,
	 this.entityId,
	required this.oldValues,
	required this.newValues,
	required this.changes,
	 this.ipAddress,
	 this.userAgent,
	 this.sessionId,
	 this.createdAt,
	 this.org,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AuditLog, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"userId": (m) => m.userId,

	"action": (m) => m.action,

	"entityType": (m) => m.entityType,

	"entityId": (m) => m.entityId,

	"oldValues": (m) => m.oldValues,

	"newValues": (m) => m.newValues,

	"changes": (m) => m.changes,

	"ipAddress": (m) => m.ipAddress,

	"userAgent": (m) => m.userAgent,

	"sessionId": (m) => m.sessionId,

	"createdAt": (m) => m.createdAt,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AuditLog) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AuditLog');
    }
    return propFunction as V? Function(AuditLog);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AuditLog.fromJson(JsonMap json) =>
      AuditLog(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	userId: json['userId'] as String?,
	action: json['action'] as String?,
	entityType: json['entityType'] as String?,
	entityId: json['entityId'] as String?,
	oldValues: json['oldValues'] as dynamic,
	newValues: json['newValues'] as dynamic,
	changes: json['changes'] as dynamic,
	ipAddress: json['ipAddress'] as String?,
	userAgent: json['userAgent'] as String?,
	sessionId: json['sessionId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AuditLog copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? userId,
		Value<String?>? action,
		Value<String?>? entityType,
		Value<String?>? entityId,
		Value<dynamic>? oldValues,
		Value<dynamic>? newValues,
		Value<dynamic>? changes,
		Value<String?>? ipAddress,
		Value<String?>? userAgent,
		Value<String?>? sessionId,
		Value<DateTime?>? createdAt,
		Value<Organization?>? org,
		Value<User?>? user,
        }) {
        return AuditLog(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		userId: userId != null ? userId.value : this.userId,
		action: action != null ? action.value : this.action,
		entityType: entityType != null ? entityType.value : this.entityType,
		entityId: entityId != null ? entityId.value : this.entityId,
		oldValues: oldValues != null ? oldValues.value : this.oldValues,
		newValues: newValues != null ? newValues.value : this.newValues,
		changes: changes != null ? changes.value : this.changes,
		ipAddress: ipAddress != null ? ipAddress.value : this.ipAddress,
		userAgent: userAgent != null ? userAgent.value : this.userAgent,
		sessionId: sessionId != null ? sessionId.value : this.sessionId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AuditLog copyWithInstanceValues(AuditLog auditLog) {
        return AuditLog(
            id: auditLog.id ?? id,
		orgId: auditLog.orgId ?? orgId,
		userId: auditLog.userId ?? userId,
		action: auditLog.action ?? action,
		entityType: auditLog.entityType ?? entityType,
		entityId: auditLog.entityId ?? entityId,
		oldValues: auditLog.oldValues ?? oldValues,
		newValues: auditLog.newValues ?? newValues,
		changes: auditLog.changes ?? changes,
		ipAddress: auditLog.ipAddress ?? ipAddress,
		userAgent: auditLog.userAgent ?? userAgent,
		sessionId: auditLog.sessionId ?? sessionId,
		createdAt: auditLog.createdAt ?? createdAt,
		org: auditLog.org ?? org,
		user: auditLog.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AuditLog mergeWithInstanceValues(AuditLog auditLog) {
        return AuditLog(
            id: auditLog.$assignedFields.contains('id') ? auditLog.id : id,
		orgId: auditLog.$assignedFields.contains('orgId') ? auditLog.orgId : orgId,
		userId: auditLog.$assignedFields.contains('userId') ? auditLog.userId : userId,
		action: auditLog.$assignedFields.contains('action') ? auditLog.action : action,
		entityType: auditLog.$assignedFields.contains('entityType') ? auditLog.entityType : entityType,
		entityId: auditLog.$assignedFields.contains('entityId') ? auditLog.entityId : entityId,
		oldValues: auditLog.$assignedFields.contains('oldValues') ? auditLog.oldValues : oldValues,
		newValues: auditLog.$assignedFields.contains('newValues') ? auditLog.newValues : newValues,
		changes: auditLog.$assignedFields.contains('changes') ? auditLog.changes : changes,
		ipAddress: auditLog.$assignedFields.contains('ipAddress') ? auditLog.ipAddress : ipAddress,
		userAgent: auditLog.$assignedFields.contains('userAgent') ? auditLog.userAgent : userAgent,
		sessionId: auditLog.$assignedFields.contains('sessionId') ? auditLog.sessionId : sessionId,
		createdAt: auditLog.$assignedFields.contains('createdAt') ? auditLog.createdAt : createdAt,
		org: auditLog.$assignedFields.contains('org') ? auditLog.org : org,
		user: auditLog.$assignedFields.contains('user') ? auditLog.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AuditLog updateWithInstanceValues(AuditLog auditLog) {
        if (auditLog.$assignedFields.contains('id')) { id = auditLog.id; }
		if (auditLog.$assignedFields.contains('orgId')) { orgId = auditLog.orgId; }
		if (auditLog.$assignedFields.contains('userId')) { userId = auditLog.userId; }
		if (auditLog.$assignedFields.contains('action')) { action = auditLog.action; }
		if (auditLog.$assignedFields.contains('entityType')) { entityType = auditLog.entityType; }
		if (auditLog.$assignedFields.contains('entityId')) { entityId = auditLog.entityId; }
		if (auditLog.$assignedFields.contains('oldValues')) { oldValues = auditLog.oldValues; }
		if (auditLog.$assignedFields.contains('newValues')) { newValues = auditLog.newValues; }
		if (auditLog.$assignedFields.contains('changes')) { changes = auditLog.changes; }
		if (auditLog.$assignedFields.contains('ipAddress')) { ipAddress = auditLog.ipAddress; }
		if (auditLog.$assignedFields.contains('userAgent')) { userAgent = auditLog.userAgent; }
		if (auditLog.$assignedFields.contains('sessionId')) { sessionId = auditLog.sessionId; }
		if (auditLog.$assignedFields.contains('createdAt')) { createdAt = auditLog.createdAt; }
		if (auditLog.$assignedFields.contains('org')) { org = auditLog.org; }
		if (auditLog.$assignedFields.contains('user')) { user = auditLog.user; }
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
          ? {...?serializedTypes, 'AuditLog'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(userId != null) 'userId': userId,
	if(action != null) 'action': action,
	if(entityType != null) 'entityType': entityType,
	if(entityId != null) 'entityId': entityId,
	if(oldValues != null) 'oldValues': oldValues,
	if(newValues != null) 'newValues': newValues,
	if(changes != null) 'changes': changes,
	if(ipAddress != null) 'ipAddress': ipAddress,
	if(userAgent != null) 'userAgent': userAgent,
	if(sessionId != null) 'sessionId': sessionId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AuditLog &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    