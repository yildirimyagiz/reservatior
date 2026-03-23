
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'discount_type.dart';
import 'pricing_rule.dart';
import 'property.dart';
import 'reservation.dart';


class Discount implements PrismaModel<String, Discount> , Id<String> {
    DateTime? deletedAt;
	@override
String? id;
	String? name;
	String? description;
	String? code;
	double? value;
	DiscountType? type;
	DateTime? startDate;
	DateTime? endDate;
	int? maxUsage;
	int? currentUsage;
	bool? isActive;
	DateTime? createdAt;
	DateTime? updatedAt;
	String? propertyId;
	String? pricingRuleId;
	PricingRule? PricingRule;
	Property? Property;
	List<Reservation>? Reservation;
	int? $ReservationCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Discount({ this.deletedAt,
	 this.id,
	 this.name,
	 this.description,
	 this.code,
	 this.value,
	 this.type,
	 this.startDate,
	 this.endDate,
	 this.maxUsage,
	 this.currentUsage = 0,
	 this.isActive = true,
	 this.createdAt,
	 this.updatedAt,
	 this.propertyId,
	 this.pricingRuleId,
	 this.PricingRule,
	 this.Property,
	 this.Reservation,
	this.$ReservationCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Discount, dynamic>> propertyValueFunctionMap = {
      "deletedAt": (m) => m.deletedAt,

	"id": (m) => m.id,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"code": (m) => m.code,

	"value": (m) => m.value,

	"type": (m) => m.type,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"maxUsage": (m) => m.maxUsage,

	"currentUsage": (m) => m.currentUsage,

	"isActive": (m) => m.isActive,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"propertyId": (m) => m.propertyId,

	"pricingRuleId": (m) => m.pricingRuleId,

	"PricingRule": (m) => m.PricingRule,

	"Property": (m) => m.Property,

	"Reservation": (m) => m.Reservation,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Discount) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Discount');
    }
    return propFunction as V? Function(Discount);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Discount.fromJson(JsonMap json) =>
      Discount(
        deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	id: json['id'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	code: json['code'] as String?,
	value: json['value']?.toDouble(),
	type: json['type'] != null ? DiscountType.fromJson(json['type']) : null,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	maxUsage: int.tryParse(json['maxUsage'].toString()),
	currentUsage: int.tryParse(json['currentUsage'].toString()),
	isActive: json['isActive'] as bool?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	propertyId: json['propertyId'] as String?,
	pricingRuleId: json['pricingRuleId'] as String?,
	PricingRule: json['PricingRule'] != null ? PricingRule.fromJson(json['PricingRule'] as JsonMap) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	Reservation: json['Reservation'] != null ? createModels<Reservation>((json['Reservation'] as List).cast<JsonMap>(), Reservation.fromJson) : null,
	$ReservationCount: json['_count']?['Reservation'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Discount copyWith({
        Value<DateTime?>? deletedAt,
		Value<String?>? id,
		Value<String?>? name,
		Value<String?>? description,
		Value<String?>? code,
		Value<double?>? value,
		Value<DiscountType?>? type,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<int?>? maxUsage,
		Value<int?>? currentUsage,
		Value<bool?>? isActive,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<String?>? propertyId,
		Value<String?>? pricingRuleId,
		Value<PricingRule?>? PricingRule,
		Value<Property?>? Property,
		Value<List<Reservation>?>? Reservation,
		int? $ReservationCount,
        }) {
        return Discount(
            deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		id: id != null ? id.value : this.id,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		code: code != null ? code.value : this.code,
		value: value != null ? value.value : this.value,
		type: type != null ? type.value : this.type,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		maxUsage: maxUsage != null ? maxUsage.value : this.maxUsage,
		currentUsage: currentUsage != null ? currentUsage.value : this.currentUsage,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		pricingRuleId: pricingRuleId != null ? pricingRuleId.value : this.pricingRuleId,
		PricingRule: PricingRule != null ? PricingRule.value : this.PricingRule,
		Property: Property != null ? Property.value : this.Property,
		Reservation: Reservation != null ? Reservation.value : this.Reservation,
		$ReservationCount: $ReservationCount ?? this.$ReservationCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Discount copyWithInstanceValues(Discount discount) {
        return Discount(
            deletedAt: discount.deletedAt ?? deletedAt,
		id: discount.id ?? id,
		name: discount.name ?? name,
		description: discount.description ?? description,
		code: discount.code ?? code,
		value: discount.value ?? value,
		type: discount.type ?? type,
		startDate: discount.startDate ?? startDate,
		endDate: discount.endDate ?? endDate,
		maxUsage: discount.maxUsage ?? maxUsage,
		currentUsage: discount.currentUsage ?? currentUsage,
		isActive: discount.isActive ?? isActive,
		createdAt: discount.createdAt ?? createdAt,
		updatedAt: discount.updatedAt ?? updatedAt,
		propertyId: discount.propertyId ?? propertyId,
		pricingRuleId: discount.pricingRuleId ?? pricingRuleId,
		PricingRule: discount.PricingRule ?? PricingRule,
		Property: discount.Property ?? Property,
		Reservation: discount.Reservation ?? Reservation,
		$ReservationCount: discount.$ReservationCount ?? $ReservationCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Discount mergeWithInstanceValues(Discount discount) {
        return Discount(
            deletedAt: discount.$assignedFields.contains('deletedAt') ? discount.deletedAt : deletedAt,
		id: discount.$assignedFields.contains('id') ? discount.id : id,
		name: discount.$assignedFields.contains('name') ? discount.name : name,
		description: discount.$assignedFields.contains('description') ? discount.description : description,
		code: discount.$assignedFields.contains('code') ? discount.code : code,
		value: discount.$assignedFields.contains('value') ? discount.value : value,
		type: discount.$assignedFields.contains('type') ? discount.type : type,
		startDate: discount.$assignedFields.contains('startDate') ? discount.startDate : startDate,
		endDate: discount.$assignedFields.contains('endDate') ? discount.endDate : endDate,
		maxUsage: discount.$assignedFields.contains('maxUsage') ? discount.maxUsage : maxUsage,
		currentUsage: discount.$assignedFields.contains('currentUsage') ? discount.currentUsage : currentUsage,
		isActive: discount.$assignedFields.contains('isActive') ? discount.isActive : isActive,
		createdAt: discount.$assignedFields.contains('createdAt') ? discount.createdAt : createdAt,
		updatedAt: discount.$assignedFields.contains('updatedAt') ? discount.updatedAt : updatedAt,
		propertyId: discount.$assignedFields.contains('propertyId') ? discount.propertyId : propertyId,
		pricingRuleId: discount.$assignedFields.contains('pricingRuleId') ? discount.pricingRuleId : pricingRuleId,
		PricingRule: discount.$assignedFields.contains('PricingRule') ? discount.PricingRule : PricingRule,
		Property: discount.$assignedFields.contains('Property') ? discount.Property : Property,
		Reservation: (discount.$assignedFields.contains('Reservation') && discount.Reservation != null) ? mergeModelLists(Reservation, discount.Reservation) : Reservation,
		$ReservationCount: discount.$ReservationCount ?? $ReservationCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Discount updateWithInstanceValues(Discount discount) {
        if (discount.$assignedFields.contains('deletedAt')) { deletedAt = discount.deletedAt; }
		if (discount.$assignedFields.contains('id')) { id = discount.id; }
		if (discount.$assignedFields.contains('name')) { name = discount.name; }
		if (discount.$assignedFields.contains('description')) { description = discount.description; }
		if (discount.$assignedFields.contains('code')) { code = discount.code; }
		if (discount.$assignedFields.contains('value')) { value = discount.value; }
		if (discount.$assignedFields.contains('type')) { type = discount.type; }
		if (discount.$assignedFields.contains('startDate')) { startDate = discount.startDate; }
		if (discount.$assignedFields.contains('endDate')) { endDate = discount.endDate; }
		if (discount.$assignedFields.contains('maxUsage')) { maxUsage = discount.maxUsage; }
		if (discount.$assignedFields.contains('currentUsage')) { currentUsage = discount.currentUsage; }
		if (discount.$assignedFields.contains('isActive')) { isActive = discount.isActive; }
		if (discount.$assignedFields.contains('createdAt')) { createdAt = discount.createdAt; }
		if (discount.$assignedFields.contains('updatedAt')) { updatedAt = discount.updatedAt; }
		if (discount.$assignedFields.contains('propertyId')) { propertyId = discount.propertyId; }
		if (discount.$assignedFields.contains('pricingRuleId')) { pricingRuleId = discount.pricingRuleId; }
		if (discount.$assignedFields.contains('PricingRule')) { PricingRule = discount.PricingRule; }
		if (discount.$assignedFields.contains('Property')) { Property = discount.Property; }
		if (discount.$assignedFields.contains('Reservation') && discount.Reservation != null) { Reservation = mergeModelLists(Reservation, discount.Reservation); }
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
          ? {...?serializedTypes, 'Discount'} 
          : const {};
      return {
        if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(id != null) 'id': id,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(code != null) 'code': code,
	if(value != null) 'value': value,
	if(type != null) 'type': type?.toJson(),
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(maxUsage != null) 'maxUsage': maxUsage,
	if(currentUsage != null) 'currentUsage': currentUsage,
	if(isActive != null) 'isActive': isActive,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(propertyId != null) 'propertyId': propertyId,
	if(pricingRuleId != null) 'pricingRuleId': pricingRuleId,
	if(PricingRule != null && (!preventCircularSerialization || !serializedModels.contains('PricingRule'))) 'PricingRule': PricingRule?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'Reservation': Reservation?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($ReservationCount != null) '_count': { 
		if ($ReservationCount != null) 'Reservation': $ReservationCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Discount &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    