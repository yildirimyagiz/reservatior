
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'agency.dart';
import 'agent.dart';
import 'user.dart';


class Language implements PrismaModel<String, Language> , Id<String> {
    @override
String? id;
	String? code;
	String? name;
	String? nativeName;
	bool? isRTL;
	bool? isActive;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	String? agencyId;
	String? agentId;
	String? userId;
	Agency? Agency;
	Agent? Agent;
	User? User;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Language({ this.id,
	 this.code,
	 this.name,
	 this.nativeName,
	 this.isRTL = false,
	 this.isActive = true,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.agencyId,
	 this.agentId,
	 this.userId,
	 this.Agency,
	 this.Agent,
	 this.User,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Language, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"code": (m) => m.code,

	"name": (m) => m.name,

	"nativeName": (m) => m.nativeName,

	"isRTL": (m) => m.isRTL,

	"isActive": (m) => m.isActive,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"agencyId": (m) => m.agencyId,

	"agentId": (m) => m.agentId,

	"userId": (m) => m.userId,

	"Agency": (m) => m.Agency,

	"Agent": (m) => m.Agent,

	"User": (m) => m.User,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Language) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Language');
    }
    return propFunction as V? Function(Language);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Language.fromJson(JsonMap json) =>
      Language(
        id: json['id'] as String?,
	code: json['code'] as String?,
	name: json['name'] as String?,
	nativeName: json['nativeName'] as String?,
	isRTL: json['isRTL'] as bool?,
	isActive: json['isActive'] as bool?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	agencyId: json['agencyId'] as String?,
	agentId: json['agentId'] as String?,
	userId: json['userId'] as String?,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	Agent: json['Agent'] != null ? Agent.fromJson(json['Agent'] as JsonMap) : null,
	User: json['User'] != null ? User.fromJson(json['User'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Language copyWith({
        Value<String?>? id,
		Value<String?>? code,
		Value<String?>? name,
		Value<String?>? nativeName,
		Value<bool?>? isRTL,
		Value<bool?>? isActive,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<String?>? agencyId,
		Value<String?>? agentId,
		Value<String?>? userId,
		Value<Agency?>? Agency,
		Value<Agent?>? Agent,
		Value<User?>? User,
        }) {
        return Language(
            id: id != null ? id.value : this.id,
		code: code != null ? code.value : this.code,
		name: name != null ? name.value : this.name,
		nativeName: nativeName != null ? nativeName.value : this.nativeName,
		isRTL: isRTL != null ? isRTL.value : this.isRTL,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		agentId: agentId != null ? agentId.value : this.agentId,
		userId: userId != null ? userId.value : this.userId,
		Agency: Agency != null ? Agency.value : this.Agency,
		Agent: Agent != null ? Agent.value : this.Agent,
		User: User != null ? User.value : this.User
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Language copyWithInstanceValues(Language language) {
        return Language(
            id: language.id ?? id,
		code: language.code ?? code,
		name: language.name ?? name,
		nativeName: language.nativeName ?? nativeName,
		isRTL: language.isRTL ?? isRTL,
		isActive: language.isActive ?? isActive,
		createdAt: language.createdAt ?? createdAt,
		updatedAt: language.updatedAt ?? updatedAt,
		deletedAt: language.deletedAt ?? deletedAt,
		agencyId: language.agencyId ?? agencyId,
		agentId: language.agentId ?? agentId,
		userId: language.userId ?? userId,
		Agency: language.Agency ?? Agency,
		Agent: language.Agent ?? Agent,
		User: language.User ?? User
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Language mergeWithInstanceValues(Language language) {
        return Language(
            id: language.$assignedFields.contains('id') ? language.id : id,
		code: language.$assignedFields.contains('code') ? language.code : code,
		name: language.$assignedFields.contains('name') ? language.name : name,
		nativeName: language.$assignedFields.contains('nativeName') ? language.nativeName : nativeName,
		isRTL: language.$assignedFields.contains('isRTL') ? language.isRTL : isRTL,
		isActive: language.$assignedFields.contains('isActive') ? language.isActive : isActive,
		createdAt: language.$assignedFields.contains('createdAt') ? language.createdAt : createdAt,
		updatedAt: language.$assignedFields.contains('updatedAt') ? language.updatedAt : updatedAt,
		deletedAt: language.$assignedFields.contains('deletedAt') ? language.deletedAt : deletedAt,
		agencyId: language.$assignedFields.contains('agencyId') ? language.agencyId : agencyId,
		agentId: language.$assignedFields.contains('agentId') ? language.agentId : agentId,
		userId: language.$assignedFields.contains('userId') ? language.userId : userId,
		Agency: language.$assignedFields.contains('Agency') ? language.Agency : Agency,
		Agent: language.$assignedFields.contains('Agent') ? language.Agent : Agent,
		User: language.$assignedFields.contains('User') ? language.User : User
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Language updateWithInstanceValues(Language language) {
        if (language.$assignedFields.contains('id')) { id = language.id; }
		if (language.$assignedFields.contains('code')) { code = language.code; }
		if (language.$assignedFields.contains('name')) { name = language.name; }
		if (language.$assignedFields.contains('nativeName')) { nativeName = language.nativeName; }
		if (language.$assignedFields.contains('isRTL')) { isRTL = language.isRTL; }
		if (language.$assignedFields.contains('isActive')) { isActive = language.isActive; }
		if (language.$assignedFields.contains('createdAt')) { createdAt = language.createdAt; }
		if (language.$assignedFields.contains('updatedAt')) { updatedAt = language.updatedAt; }
		if (language.$assignedFields.contains('deletedAt')) { deletedAt = language.deletedAt; }
		if (language.$assignedFields.contains('agencyId')) { agencyId = language.agencyId; }
		if (language.$assignedFields.contains('agentId')) { agentId = language.agentId; }
		if (language.$assignedFields.contains('userId')) { userId = language.userId; }
		if (language.$assignedFields.contains('Agency')) { Agency = language.Agency; }
		if (language.$assignedFields.contains('Agent')) { Agent = language.Agent; }
		if (language.$assignedFields.contains('User')) { User = language.User; }
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
          ? {...?serializedTypes, 'Language'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(code != null) 'code': code,
	if(name != null) 'name': name,
	if(nativeName != null) 'nativeName': nativeName,
	if(isRTL != null) 'isRTL': isRTL,
	if(isActive != null) 'isActive': isActive,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(agencyId != null) 'agencyId': agencyId,
	if(agentId != null) 'agentId': agentId,
	if(userId != null) 'userId': userId,
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Agent != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'Agent': Agent?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(User != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'User': User?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Language &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    