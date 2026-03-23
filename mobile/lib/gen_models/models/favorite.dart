
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'property.dart';
import 'user.dart';


class Favorite implements PrismaModel<String, Favorite> , Id<String> {
    @override
String? id;
	String? userId;
	String? propertyId;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Property? property;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Favorite({ this.id,
	 this.userId,
	 this.propertyId,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.property,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Favorite, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"propertyId": (m) => m.propertyId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"property": (m) => m.property,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Favorite) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Favorite');
    }
    return propFunction as V? Function(Favorite);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Favorite.fromJson(JsonMap json) =>
      Favorite(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	propertyId: json['propertyId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Favorite copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? propertyId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Property?>? property,
		Value<User?>? user,
        }) {
        return Favorite(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		property: property != null ? property.value : this.property,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Favorite copyWithInstanceValues(Favorite favorite) {
        return Favorite(
            id: favorite.id ?? id,
		userId: favorite.userId ?? userId,
		propertyId: favorite.propertyId ?? propertyId,
		createdAt: favorite.createdAt ?? createdAt,
		updatedAt: favorite.updatedAt ?? updatedAt,
		deletedAt: favorite.deletedAt ?? deletedAt,
		property: favorite.property ?? property,
		user: favorite.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Favorite mergeWithInstanceValues(Favorite favorite) {
        return Favorite(
            id: favorite.$assignedFields.contains('id') ? favorite.id : id,
		userId: favorite.$assignedFields.contains('userId') ? favorite.userId : userId,
		propertyId: favorite.$assignedFields.contains('propertyId') ? favorite.propertyId : propertyId,
		createdAt: favorite.$assignedFields.contains('createdAt') ? favorite.createdAt : createdAt,
		updatedAt: favorite.$assignedFields.contains('updatedAt') ? favorite.updatedAt : updatedAt,
		deletedAt: favorite.$assignedFields.contains('deletedAt') ? favorite.deletedAt : deletedAt,
		property: favorite.$assignedFields.contains('property') ? favorite.property : property,
		user: favorite.$assignedFields.contains('user') ? favorite.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Favorite updateWithInstanceValues(Favorite favorite) {
        if (favorite.$assignedFields.contains('id')) { id = favorite.id; }
		if (favorite.$assignedFields.contains('userId')) { userId = favorite.userId; }
		if (favorite.$assignedFields.contains('propertyId')) { propertyId = favorite.propertyId; }
		if (favorite.$assignedFields.contains('createdAt')) { createdAt = favorite.createdAt; }
		if (favorite.$assignedFields.contains('updatedAt')) { updatedAt = favorite.updatedAt; }
		if (favorite.$assignedFields.contains('deletedAt')) { deletedAt = favorite.deletedAt; }
		if (favorite.$assignedFields.contains('property')) { property = favorite.property; }
		if (favorite.$assignedFields.contains('user')) { user = favorite.user; }
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
          ? {...?serializedTypes, 'Favorite'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(propertyId != null) 'propertyId': propertyId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Favorite &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    