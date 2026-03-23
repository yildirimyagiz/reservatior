
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'availability.dart';
import 'discount.dart';
import 'currency.dart';
import 'property.dart';
import 'reservation.dart';
import 'subscription.dart';
import 'listing.dart';


class PricingRule implements PrismaModel<String, PricingRule> , Id<String> {
    @override
String? id;
	String? listingId;
	String? name;
	String? description;
	String? ruleType;
	dynamic conditions;
	dynamic actions;
	int? priority;
	bool? isActive;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	double? basePrice;
	String? strategy;
	DateTime? startDate;
	DateTime? endDate;
	int? minNights;
	int? maxNights;
	dynamic weekdayPrices;
	dynamic taxRules;
	dynamic discountRules;
	String? currencyId;
	List<Availability>? Availability;
	List<Discount>? Discounts;
	Currency? currency;
	Property? Property;
	List<Reservation>? Reservation;
	List<Subscription>? Subscriptions;
	Listing? Listing;
	int? $AvailabilityCount;
	int? $DiscountsCount;
	int? $ReservationCount;
	int? $SubscriptionsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PricingRule({ this.id,
	 this.listingId,
	 this.name,
	 this.description,
	 this.ruleType = "dynamic",
	required this.conditions,
	required this.actions,
	 this.priority = 1,
	 this.isActive = true,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.basePrice,
	 this.strategy = "FIXED",
	 this.startDate,
	 this.endDate,
	 this.minNights = 1,
	 this.maxNights = 30,
	required this.weekdayPrices,
	required this.taxRules,
	required this.discountRules,
	 this.currencyId,
	 this.Availability,
	 this.Discounts,
	 this.currency,
	 this.Property,
	 this.Reservation,
	 this.Subscriptions,
	 this.Listing,
	this.$AvailabilityCount,
	this.$DiscountsCount,
	this.$ReservationCount,
	this.$SubscriptionsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PricingRule, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"listingId": (m) => m.listingId,

	"name": (m) => m.name,

	"description": (m) => m.description,

	"ruleType": (m) => m.ruleType,

	"conditions": (m) => m.conditions,

	"actions": (m) => m.actions,

	"priority": (m) => m.priority,

	"isActive": (m) => m.isActive,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"basePrice": (m) => m.basePrice,

	"strategy": (m) => m.strategy,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"minNights": (m) => m.minNights,

	"maxNights": (m) => m.maxNights,

	"weekdayPrices": (m) => m.weekdayPrices,

	"taxRules": (m) => m.taxRules,

	"discountRules": (m) => m.discountRules,

	"currencyId": (m) => m.currencyId,

	"Availability": (m) => m.Availability,

	"Discounts": (m) => m.Discounts,

	"currency": (m) => m.currency,

	"Property": (m) => m.Property,

	"Reservation": (m) => m.Reservation,

	"Subscriptions": (m) => m.Subscriptions,

	"Listing": (m) => m.Listing,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PricingRule) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PricingRule');
    }
    return propFunction as V? Function(PricingRule);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PricingRule.fromJson(JsonMap json) =>
      PricingRule(
        id: json['id'] as String?,
	listingId: json['listingId'] as String?,
	name: json['name'] as String?,
	description: json['description'] as String?,
	ruleType: json['ruleType'] as String?,
	conditions: json['conditions'] as dynamic,
	actions: json['actions'] as dynamic,
	priority: int.tryParse(json['priority'].toString()),
	isActive: json['isActive'] as bool?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	basePrice: json['basePrice']?.toDouble(),
	strategy: json['strategy'] as String?,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	minNights: int.tryParse(json['minNights'].toString()),
	maxNights: int.tryParse(json['maxNights'].toString()),
	weekdayPrices: json['weekdayPrices'] as dynamic,
	taxRules: json['taxRules'] as dynamic,
	discountRules: json['discountRules'] as dynamic,
	currencyId: json['currencyId'] as String?,
	Availability: json['Availability'] != null ? createModels<Availability>((json['Availability'] as List).cast<JsonMap>(), Availability.fromJson) : null,
	Discounts: json['Discounts'] != null ? createModels<Discount>((json['Discounts'] as List).cast<JsonMap>(), Discount.fromJson) : null,
	currency: json['currency'] != null ? Currency.fromJson(json['currency'] as JsonMap) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	Reservation: json['Reservation'] != null ? createModels<Reservation>((json['Reservation'] as List).cast<JsonMap>(), Reservation.fromJson) : null,
	Subscriptions: json['Subscriptions'] != null ? createModels<Subscription>((json['Subscriptions'] as List).cast<JsonMap>(), Subscription.fromJson) : null,
	Listing: json['Listing'] != null ? Listing.fromJson(json['Listing'] as JsonMap) : null,
	$AvailabilityCount: json['_count']?['Availability'] as int?,
	$DiscountsCount: json['_count']?['Discounts'] as int?,
	$ReservationCount: json['_count']?['Reservation'] as int?,
	$SubscriptionsCount: json['_count']?['Subscriptions'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PricingRule copyWith({
        Value<String?>? id,
		Value<String?>? listingId,
		Value<String?>? name,
		Value<String?>? description,
		Value<String?>? ruleType,
		Value<dynamic>? conditions,
		Value<dynamic>? actions,
		Value<int?>? priority,
		Value<bool?>? isActive,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<double?>? basePrice,
		Value<String?>? strategy,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<int?>? minNights,
		Value<int?>? maxNights,
		Value<dynamic>? weekdayPrices,
		Value<dynamic>? taxRules,
		Value<dynamic>? discountRules,
		Value<String?>? currencyId,
		Value<List<Availability>?>? Availability,
		Value<List<Discount>?>? Discounts,
		Value<Currency?>? currency,
		Value<Property?>? Property,
		Value<List<Reservation>?>? Reservation,
		Value<List<Subscription>?>? Subscriptions,
		Value<Listing?>? Listing,
		int? $AvailabilityCount,
		int? $DiscountsCount,
		int? $ReservationCount,
		int? $SubscriptionsCount,
        }) {
        return PricingRule(
            id: id != null ? id.value : this.id,
		listingId: listingId != null ? listingId.value : this.listingId,
		name: name != null ? name.value : this.name,
		description: description != null ? description.value : this.description,
		ruleType: ruleType != null ? ruleType.value : this.ruleType,
		conditions: conditions != null ? conditions.value : this.conditions,
		actions: actions != null ? actions.value : this.actions,
		priority: priority != null ? priority.value : this.priority,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		basePrice: basePrice != null ? basePrice.value : this.basePrice,
		strategy: strategy != null ? strategy.value : this.strategy,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		minNights: minNights != null ? minNights.value : this.minNights,
		maxNights: maxNights != null ? maxNights.value : this.maxNights,
		weekdayPrices: weekdayPrices != null ? weekdayPrices.value : this.weekdayPrices,
		taxRules: taxRules != null ? taxRules.value : this.taxRules,
		discountRules: discountRules != null ? discountRules.value : this.discountRules,
		currencyId: currencyId != null ? currencyId.value : this.currencyId,
		Availability: Availability != null ? Availability.value : this.Availability,
		Discounts: Discounts != null ? Discounts.value : this.Discounts,
		currency: currency != null ? currency.value : this.currency,
		Property: Property != null ? Property.value : this.Property,
		Reservation: Reservation != null ? Reservation.value : this.Reservation,
		Subscriptions: Subscriptions != null ? Subscriptions.value : this.Subscriptions,
		Listing: Listing != null ? Listing.value : this.Listing,
		$AvailabilityCount: $AvailabilityCount ?? this.$AvailabilityCount,
		$DiscountsCount: $DiscountsCount ?? this.$DiscountsCount,
		$ReservationCount: $ReservationCount ?? this.$ReservationCount,
		$SubscriptionsCount: $SubscriptionsCount ?? this.$SubscriptionsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PricingRule copyWithInstanceValues(PricingRule pricingRule) {
        return PricingRule(
            id: pricingRule.id ?? id,
		listingId: pricingRule.listingId ?? listingId,
		name: pricingRule.name ?? name,
		description: pricingRule.description ?? description,
		ruleType: pricingRule.ruleType ?? ruleType,
		conditions: pricingRule.conditions ?? conditions,
		actions: pricingRule.actions ?? actions,
		priority: pricingRule.priority ?? priority,
		isActive: pricingRule.isActive ?? isActive,
		createdAt: pricingRule.createdAt ?? createdAt,
		updatedAt: pricingRule.updatedAt ?? updatedAt,
		deletedAt: pricingRule.deletedAt ?? deletedAt,
		basePrice: pricingRule.basePrice ?? basePrice,
		strategy: pricingRule.strategy ?? strategy,
		startDate: pricingRule.startDate ?? startDate,
		endDate: pricingRule.endDate ?? endDate,
		minNights: pricingRule.minNights ?? minNights,
		maxNights: pricingRule.maxNights ?? maxNights,
		weekdayPrices: pricingRule.weekdayPrices ?? weekdayPrices,
		taxRules: pricingRule.taxRules ?? taxRules,
		discountRules: pricingRule.discountRules ?? discountRules,
		currencyId: pricingRule.currencyId ?? currencyId,
		Availability: pricingRule.Availability ?? Availability,
		Discounts: pricingRule.Discounts ?? Discounts,
		currency: pricingRule.currency ?? currency,
		Property: pricingRule.Property ?? Property,
		Reservation: pricingRule.Reservation ?? Reservation,
		Subscriptions: pricingRule.Subscriptions ?? Subscriptions,
		Listing: pricingRule.Listing ?? Listing,
		$AvailabilityCount: pricingRule.$AvailabilityCount ?? $AvailabilityCount,
		$DiscountsCount: pricingRule.$DiscountsCount ?? $DiscountsCount,
		$ReservationCount: pricingRule.$ReservationCount ?? $ReservationCount,
		$SubscriptionsCount: pricingRule.$SubscriptionsCount ?? $SubscriptionsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PricingRule mergeWithInstanceValues(PricingRule pricingRule) {
        return PricingRule(
            id: pricingRule.$assignedFields.contains('id') ? pricingRule.id : id,
		listingId: pricingRule.$assignedFields.contains('listingId') ? pricingRule.listingId : listingId,
		name: pricingRule.$assignedFields.contains('name') ? pricingRule.name : name,
		description: pricingRule.$assignedFields.contains('description') ? pricingRule.description : description,
		ruleType: pricingRule.$assignedFields.contains('ruleType') ? pricingRule.ruleType : ruleType,
		conditions: pricingRule.$assignedFields.contains('conditions') ? pricingRule.conditions : conditions,
		actions: pricingRule.$assignedFields.contains('actions') ? pricingRule.actions : actions,
		priority: pricingRule.$assignedFields.contains('priority') ? pricingRule.priority : priority,
		isActive: pricingRule.$assignedFields.contains('isActive') ? pricingRule.isActive : isActive,
		createdAt: pricingRule.$assignedFields.contains('createdAt') ? pricingRule.createdAt : createdAt,
		updatedAt: pricingRule.$assignedFields.contains('updatedAt') ? pricingRule.updatedAt : updatedAt,
		deletedAt: pricingRule.$assignedFields.contains('deletedAt') ? pricingRule.deletedAt : deletedAt,
		basePrice: pricingRule.$assignedFields.contains('basePrice') ? pricingRule.basePrice : basePrice,
		strategy: pricingRule.$assignedFields.contains('strategy') ? pricingRule.strategy : strategy,
		startDate: pricingRule.$assignedFields.contains('startDate') ? pricingRule.startDate : startDate,
		endDate: pricingRule.$assignedFields.contains('endDate') ? pricingRule.endDate : endDate,
		minNights: pricingRule.$assignedFields.contains('minNights') ? pricingRule.minNights : minNights,
		maxNights: pricingRule.$assignedFields.contains('maxNights') ? pricingRule.maxNights : maxNights,
		weekdayPrices: pricingRule.$assignedFields.contains('weekdayPrices') ? pricingRule.weekdayPrices : weekdayPrices,
		taxRules: pricingRule.$assignedFields.contains('taxRules') ? pricingRule.taxRules : taxRules,
		discountRules: pricingRule.$assignedFields.contains('discountRules') ? pricingRule.discountRules : discountRules,
		currencyId: pricingRule.$assignedFields.contains('currencyId') ? pricingRule.currencyId : currencyId,
		Availability: (pricingRule.$assignedFields.contains('Availability') && pricingRule.Availability != null) ? mergeModelLists(Availability, pricingRule.Availability) : Availability,
		Discounts: (pricingRule.$assignedFields.contains('Discounts') && pricingRule.Discounts != null) ? mergeModelLists(Discounts, pricingRule.Discounts) : Discounts,
		currency: pricingRule.$assignedFields.contains('currency') ? pricingRule.currency : currency,
		Property: pricingRule.$assignedFields.contains('Property') ? pricingRule.Property : Property,
		Reservation: (pricingRule.$assignedFields.contains('Reservation') && pricingRule.Reservation != null) ? mergeModelLists(Reservation, pricingRule.Reservation) : Reservation,
		Subscriptions: (pricingRule.$assignedFields.contains('Subscriptions') && pricingRule.Subscriptions != null) ? mergeModelLists(Subscriptions, pricingRule.Subscriptions) : Subscriptions,
		Listing: pricingRule.$assignedFields.contains('Listing') ? pricingRule.Listing : Listing,
		$AvailabilityCount: pricingRule.$AvailabilityCount ?? $AvailabilityCount,
		$DiscountsCount: pricingRule.$DiscountsCount ?? $DiscountsCount,
		$ReservationCount: pricingRule.$ReservationCount ?? $ReservationCount,
		$SubscriptionsCount: pricingRule.$SubscriptionsCount ?? $SubscriptionsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PricingRule updateWithInstanceValues(PricingRule pricingRule) {
        if (pricingRule.$assignedFields.contains('id')) { id = pricingRule.id; }
		if (pricingRule.$assignedFields.contains('listingId')) { listingId = pricingRule.listingId; }
		if (pricingRule.$assignedFields.contains('name')) { name = pricingRule.name; }
		if (pricingRule.$assignedFields.contains('description')) { description = pricingRule.description; }
		if (pricingRule.$assignedFields.contains('ruleType')) { ruleType = pricingRule.ruleType; }
		if (pricingRule.$assignedFields.contains('conditions')) { conditions = pricingRule.conditions; }
		if (pricingRule.$assignedFields.contains('actions')) { actions = pricingRule.actions; }
		if (pricingRule.$assignedFields.contains('priority')) { priority = pricingRule.priority; }
		if (pricingRule.$assignedFields.contains('isActive')) { isActive = pricingRule.isActive; }
		if (pricingRule.$assignedFields.contains('createdAt')) { createdAt = pricingRule.createdAt; }
		if (pricingRule.$assignedFields.contains('updatedAt')) { updatedAt = pricingRule.updatedAt; }
		if (pricingRule.$assignedFields.contains('deletedAt')) { deletedAt = pricingRule.deletedAt; }
		if (pricingRule.$assignedFields.contains('basePrice')) { basePrice = pricingRule.basePrice; }
		if (pricingRule.$assignedFields.contains('strategy')) { strategy = pricingRule.strategy; }
		if (pricingRule.$assignedFields.contains('startDate')) { startDate = pricingRule.startDate; }
		if (pricingRule.$assignedFields.contains('endDate')) { endDate = pricingRule.endDate; }
		if (pricingRule.$assignedFields.contains('minNights')) { minNights = pricingRule.minNights; }
		if (pricingRule.$assignedFields.contains('maxNights')) { maxNights = pricingRule.maxNights; }
		if (pricingRule.$assignedFields.contains('weekdayPrices')) { weekdayPrices = pricingRule.weekdayPrices; }
		if (pricingRule.$assignedFields.contains('taxRules')) { taxRules = pricingRule.taxRules; }
		if (pricingRule.$assignedFields.contains('discountRules')) { discountRules = pricingRule.discountRules; }
		if (pricingRule.$assignedFields.contains('currencyId')) { currencyId = pricingRule.currencyId; }
		if (pricingRule.$assignedFields.contains('Availability') && pricingRule.Availability != null) { Availability = mergeModelLists(Availability, pricingRule.Availability); }
		if (pricingRule.$assignedFields.contains('Discounts') && pricingRule.Discounts != null) { Discounts = mergeModelLists(Discounts, pricingRule.Discounts); }
		if (pricingRule.$assignedFields.contains('currency')) { currency = pricingRule.currency; }
		if (pricingRule.$assignedFields.contains('Property')) { Property = pricingRule.Property; }
		if (pricingRule.$assignedFields.contains('Reservation') && pricingRule.Reservation != null) { Reservation = mergeModelLists(Reservation, pricingRule.Reservation); }
		if (pricingRule.$assignedFields.contains('Subscriptions') && pricingRule.Subscriptions != null) { Subscriptions = mergeModelLists(Subscriptions, pricingRule.Subscriptions); }
		if (pricingRule.$assignedFields.contains('Listing')) { Listing = pricingRule.Listing; }
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
          ? {...?serializedTypes, 'PricingRule'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(listingId != null) 'listingId': listingId,
	if(name != null) 'name': name,
	if(description != null) 'description': description,
	if(ruleType != null) 'ruleType': ruleType,
	if(conditions != null) 'conditions': conditions,
	if(actions != null) 'actions': actions,
	if(priority != null) 'priority': priority,
	if(isActive != null) 'isActive': isActive,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(basePrice != null) 'basePrice': basePrice,
	if(strategy != null) 'strategy': strategy,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(minNights != null) 'minNights': minNights,
	if(maxNights != null) 'maxNights': maxNights,
	if(weekdayPrices != null) 'weekdayPrices': weekdayPrices,
	if(taxRules != null) 'taxRules': taxRules,
	if(discountRules != null) 'discountRules': discountRules,
	if(currencyId != null) 'currencyId': currencyId,
	if(Availability != null && (!preventCircularSerialization || !serializedModels.contains('Availability'))) 'Availability': Availability?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Discounts != null && (!preventCircularSerialization || !serializedModels.contains('Discount'))) 'Discounts': Discounts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(currency != null && (!preventCircularSerialization || !serializedModels.contains('Currency'))) 'currency': currency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'Reservation': Reservation?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Subscriptions != null && (!preventCircularSerialization || !serializedModels.contains('Subscription'))) 'Subscriptions': Subscriptions?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'Listing': Listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($AvailabilityCount != null || $DiscountsCount != null || $ReservationCount != null || $SubscriptionsCount != null) '_count': { 
		if ($AvailabilityCount != null) 'Availability': $AvailabilityCount, 
		if ($DiscountsCount != null) 'Discounts': $DiscountsCount, 
		if ($ReservationCount != null) 'Reservation': $ReservationCount, 
		if ($SubscriptionsCount != null) 'Subscriptions': $SubscriptionsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PricingRule &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    