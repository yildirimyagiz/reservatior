
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'user.dart';


class Session implements PrismaModel<String, Session> , Id<String> {
    @override
String? id;
	String? userId;
	String? tokenHash;
	DateTime? expiresAt;
	String? ip;
	String? userAgent;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Session({ this.id,
	 this.userId,
	 this.tokenHash,
	 this.expiresAt,
	 this.ip,
	 this.userAgent,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Session, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"tokenHash": (m) => m.tokenHash,

	"expiresAt": (m) => m.expiresAt,

	"ip": (m) => m.ip,

	"userAgent": (m) => m.userAgent,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Session) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Session');
    }
    return propFunction as V? Function(Session);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Session.fromJson(JsonMap json) =>
      Session(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	tokenHash: json['tokenHash'] as String?,
	expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
	ip: json['ip'] as String?,
	userAgent: json['userAgent'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Session copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? tokenHash,
		Value<DateTime?>? expiresAt,
		Value<String?>? ip,
		Value<String?>? userAgent,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<User?>? user,
        }) {
        return Session(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		tokenHash: tokenHash != null ? tokenHash.value : this.tokenHash,
		expiresAt: expiresAt != null ? expiresAt.value : this.expiresAt,
		ip: ip != null ? ip.value : this.ip,
		userAgent: userAgent != null ? userAgent.value : this.userAgent,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Session copyWithInstanceValues(Session session) {
        return Session(
            id: session.id ?? id,
		userId: session.userId ?? userId,
		tokenHash: session.tokenHash ?? tokenHash,
		expiresAt: session.expiresAt ?? expiresAt,
		ip: session.ip ?? ip,
		userAgent: session.userAgent ?? userAgent,
		createdAt: session.createdAt ?? createdAt,
		updatedAt: session.updatedAt ?? updatedAt,
		deletedAt: session.deletedAt ?? deletedAt,
		user: session.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Session mergeWithInstanceValues(Session session) {
        return Session(
            id: session.$assignedFields.contains('id') ? session.id : id,
		userId: session.$assignedFields.contains('userId') ? session.userId : userId,
		tokenHash: session.$assignedFields.contains('tokenHash') ? session.tokenHash : tokenHash,
		expiresAt: session.$assignedFields.contains('expiresAt') ? session.expiresAt : expiresAt,
		ip: session.$assignedFields.contains('ip') ? session.ip : ip,
		userAgent: session.$assignedFields.contains('userAgent') ? session.userAgent : userAgent,
		createdAt: session.$assignedFields.contains('createdAt') ? session.createdAt : createdAt,
		updatedAt: session.$assignedFields.contains('updatedAt') ? session.updatedAt : updatedAt,
		deletedAt: session.$assignedFields.contains('deletedAt') ? session.deletedAt : deletedAt,
		user: session.$assignedFields.contains('user') ? session.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Session updateWithInstanceValues(Session session) {
        if (session.$assignedFields.contains('id')) { id = session.id; }
		if (session.$assignedFields.contains('userId')) { userId = session.userId; }
		if (session.$assignedFields.contains('tokenHash')) { tokenHash = session.tokenHash; }
		if (session.$assignedFields.contains('expiresAt')) { expiresAt = session.expiresAt; }
		if (session.$assignedFields.contains('ip')) { ip = session.ip; }
		if (session.$assignedFields.contains('userAgent')) { userAgent = session.userAgent; }
		if (session.$assignedFields.contains('createdAt')) { createdAt = session.createdAt; }
		if (session.$assignedFields.contains('updatedAt')) { updatedAt = session.updatedAt; }
		if (session.$assignedFields.contains('deletedAt')) { deletedAt = session.deletedAt; }
		if (session.$assignedFields.contains('user')) { user = session.user; }
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
          ? {...?serializedTypes, 'Session'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(tokenHash != null) 'tokenHash': tokenHash,
	if(expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
	if(ip != null) 'ip': ip,
	if(userAgent != null) 'userAgent': userAgent,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Session &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    