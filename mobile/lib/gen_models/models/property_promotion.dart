
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'property_promotion_type.dart';
import 'property_promotion_status.dart';
import 'property.dart';
import 'agency.dart';
import 'agent.dart';
import 'user.dart';


class PropertyPromotion implements PrismaModel<String, PropertyPromotion> , Id<String> {
    @override
String? id;
	String? propertyId;
	String? agencyId;
	String? agentId;
	PropertyPromotionType? promotionType;
	PropertyPromotionStatus? status;
	DateTime? startDate;
	DateTime? endDate;
	double? price;
	String? currency;
	bool? isAutoRenew;
	List<String>? features;
	String? paymentHistoryId;
	String? userId;
	DateTime? createdAt;
	DateTime? updatedAt;
	Property? Property;
	Agency? Agency;
	Agent? Agent;
	User? User;
	int? $featuresCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PropertyPromotion({ this.id,
	 this.propertyId,
	 this.agencyId,
	 this.agentId,
	 this.promotionType,
	 this.status = PropertyPromotionStatus.ACTIVE,
	 this.startDate,
	 this.endDate,
	 this.price,
	 this.currency = "USD",
	 this.isAutoRenew = false,
	 this.features,
	 this.paymentHistoryId,
	 this.userId,
	 this.createdAt,
	 this.updatedAt,
	 this.Property,
	 this.Agency,
	 this.Agent,
	 this.User,
	this.$featuresCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PropertyPromotion, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"propertyId": (m) => m.propertyId,

	"agencyId": (m) => m.agencyId,

	"agentId": (m) => m.agentId,

	"promotionType": (m) => m.promotionType,

	"status": (m) => m.status,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"price": (m) => m.price,

	"currency": (m) => m.currency,

	"isAutoRenew": (m) => m.isAutoRenew,

	"features": (m) => m.features,

	"paymentHistoryId": (m) => m.paymentHistoryId,

	"userId": (m) => m.userId,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"Property": (m) => m.Property,

	"Agency": (m) => m.Agency,

	"Agent": (m) => m.Agent,

	"User": (m) => m.User,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PropertyPromotion) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PropertyPromotion');
    }
    return propFunction as V? Function(PropertyPromotion);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PropertyPromotion.fromJson(JsonMap json) =>
      PropertyPromotion(
        id: json['id'] as String?,
	propertyId: json['propertyId'] as String?,
	agencyId: json['agencyId'] as String?,
	agentId: json['agentId'] as String?,
	promotionType: json['promotionType'] != null ? PropertyPromotionType.fromJson(json['promotionType']) : null,
	status: json['status'] != null ? PropertyPromotionStatus.fromJson(json['status']) : null,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	price: json['price']?.toDouble(),
	currency: json['currency'] as String?,
	isAutoRenew: json['isAutoRenew'] as bool?,
	features: json['features'] != null ? (json['features'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	paymentHistoryId: json['paymentHistoryId'] as String?,
	userId: json['userId'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
	Agency: json['Agency'] != null ? Agency.fromJson(json['Agency'] as JsonMap) : null,
	Agent: json['Agent'] != null ? Agent.fromJson(json['Agent'] as JsonMap) : null,
	User: json['User'] != null ? User.fromJson(json['User'] as JsonMap) : null,
	$featuresCount: json['_count']?['features'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PropertyPromotion copyWith({
        Value<String?>? id,
		Value<String?>? propertyId,
		Value<String?>? agencyId,
		Value<String?>? agentId,
		Value<PropertyPromotionType?>? promotionType,
		Value<PropertyPromotionStatus?>? status,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<double?>? price,
		Value<String?>? currency,
		Value<bool?>? isAutoRenew,
		Value<List<String>?>? features,
		Value<String?>? paymentHistoryId,
		Value<String?>? userId,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Property?>? Property,
		Value<Agency?>? Agency,
		Value<Agent?>? Agent,
		Value<User?>? User,
		int? $featuresCount,
        }) {
        return PropertyPromotion(
            id: id != null ? id.value : this.id,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		agencyId: agencyId != null ? agencyId.value : this.agencyId,
		agentId: agentId != null ? agentId.value : this.agentId,
		promotionType: promotionType != null ? promotionType.value : this.promotionType,
		status: status != null ? status.value : this.status,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		price: price != null ? price.value : this.price,
		currency: currency != null ? currency.value : this.currency,
		isAutoRenew: isAutoRenew != null ? isAutoRenew.value : this.isAutoRenew,
		features: features != null ? features.value : this.features,
		paymentHistoryId: paymentHistoryId != null ? paymentHistoryId.value : this.paymentHistoryId,
		userId: userId != null ? userId.value : this.userId,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		Property: Property != null ? Property.value : this.Property,
		Agency: Agency != null ? Agency.value : this.Agency,
		Agent: Agent != null ? Agent.value : this.Agent,
		User: User != null ? User.value : this.User,
		$featuresCount: $featuresCount ?? this.$featuresCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PropertyPromotion copyWithInstanceValues(PropertyPromotion propertyPromotion) {
        return PropertyPromotion(
            id: propertyPromotion.id ?? id,
		propertyId: propertyPromotion.propertyId ?? propertyId,
		agencyId: propertyPromotion.agencyId ?? agencyId,
		agentId: propertyPromotion.agentId ?? agentId,
		promotionType: propertyPromotion.promotionType ?? promotionType,
		status: propertyPromotion.status ?? status,
		startDate: propertyPromotion.startDate ?? startDate,
		endDate: propertyPromotion.endDate ?? endDate,
		price: propertyPromotion.price ?? price,
		currency: propertyPromotion.currency ?? currency,
		isAutoRenew: propertyPromotion.isAutoRenew ?? isAutoRenew,
		features: propertyPromotion.features ?? features,
		paymentHistoryId: propertyPromotion.paymentHistoryId ?? paymentHistoryId,
		userId: propertyPromotion.userId ?? userId,
		createdAt: propertyPromotion.createdAt ?? createdAt,
		updatedAt: propertyPromotion.updatedAt ?? updatedAt,
		Property: propertyPromotion.Property ?? Property,
		Agency: propertyPromotion.Agency ?? Agency,
		Agent: propertyPromotion.Agent ?? Agent,
		User: propertyPromotion.User ?? User,
		$featuresCount: propertyPromotion.$featuresCount ?? $featuresCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PropertyPromotion mergeWithInstanceValues(PropertyPromotion propertyPromotion) {
        return PropertyPromotion(
            id: propertyPromotion.$assignedFields.contains('id') ? propertyPromotion.id : id,
		propertyId: propertyPromotion.$assignedFields.contains('propertyId') ? propertyPromotion.propertyId : propertyId,
		agencyId: propertyPromotion.$assignedFields.contains('agencyId') ? propertyPromotion.agencyId : agencyId,
		agentId: propertyPromotion.$assignedFields.contains('agentId') ? propertyPromotion.agentId : agentId,
		promotionType: propertyPromotion.$assignedFields.contains('promotionType') ? propertyPromotion.promotionType : promotionType,
		status: propertyPromotion.$assignedFields.contains('status') ? propertyPromotion.status : status,
		startDate: propertyPromotion.$assignedFields.contains('startDate') ? propertyPromotion.startDate : startDate,
		endDate: propertyPromotion.$assignedFields.contains('endDate') ? propertyPromotion.endDate : endDate,
		price: propertyPromotion.$assignedFields.contains('price') ? propertyPromotion.price : price,
		currency: propertyPromotion.$assignedFields.contains('currency') ? propertyPromotion.currency : currency,
		isAutoRenew: propertyPromotion.$assignedFields.contains('isAutoRenew') ? propertyPromotion.isAutoRenew : isAutoRenew,
		features: propertyPromotion.$assignedFields.contains('features') ? propertyPromotion.features : features,
		paymentHistoryId: propertyPromotion.$assignedFields.contains('paymentHistoryId') ? propertyPromotion.paymentHistoryId : paymentHistoryId,
		userId: propertyPromotion.$assignedFields.contains('userId') ? propertyPromotion.userId : userId,
		createdAt: propertyPromotion.$assignedFields.contains('createdAt') ? propertyPromotion.createdAt : createdAt,
		updatedAt: propertyPromotion.$assignedFields.contains('updatedAt') ? propertyPromotion.updatedAt : updatedAt,
		Property: propertyPromotion.$assignedFields.contains('Property') ? propertyPromotion.Property : Property,
		Agency: propertyPromotion.$assignedFields.contains('Agency') ? propertyPromotion.Agency : Agency,
		Agent: propertyPromotion.$assignedFields.contains('Agent') ? propertyPromotion.Agent : Agent,
		User: propertyPromotion.$assignedFields.contains('User') ? propertyPromotion.User : User,
		$featuresCount: propertyPromotion.$featuresCount ?? $featuresCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PropertyPromotion updateWithInstanceValues(PropertyPromotion propertyPromotion) {
        if (propertyPromotion.$assignedFields.contains('id')) { id = propertyPromotion.id; }
		if (propertyPromotion.$assignedFields.contains('propertyId')) { propertyId = propertyPromotion.propertyId; }
		if (propertyPromotion.$assignedFields.contains('agencyId')) { agencyId = propertyPromotion.agencyId; }
		if (propertyPromotion.$assignedFields.contains('agentId')) { agentId = propertyPromotion.agentId; }
		if (propertyPromotion.$assignedFields.contains('promotionType')) { promotionType = propertyPromotion.promotionType; }
		if (propertyPromotion.$assignedFields.contains('status')) { status = propertyPromotion.status; }
		if (propertyPromotion.$assignedFields.contains('startDate')) { startDate = propertyPromotion.startDate; }
		if (propertyPromotion.$assignedFields.contains('endDate')) { endDate = propertyPromotion.endDate; }
		if (propertyPromotion.$assignedFields.contains('price')) { price = propertyPromotion.price; }
		if (propertyPromotion.$assignedFields.contains('currency')) { currency = propertyPromotion.currency; }
		if (propertyPromotion.$assignedFields.contains('isAutoRenew')) { isAutoRenew = propertyPromotion.isAutoRenew; }
		if (propertyPromotion.$assignedFields.contains('features')) { features = propertyPromotion.features; }
		if (propertyPromotion.$assignedFields.contains('paymentHistoryId')) { paymentHistoryId = propertyPromotion.paymentHistoryId; }
		if (propertyPromotion.$assignedFields.contains('userId')) { userId = propertyPromotion.userId; }
		if (propertyPromotion.$assignedFields.contains('createdAt')) { createdAt = propertyPromotion.createdAt; }
		if (propertyPromotion.$assignedFields.contains('updatedAt')) { updatedAt = propertyPromotion.updatedAt; }
		if (propertyPromotion.$assignedFields.contains('Property')) { Property = propertyPromotion.Property; }
		if (propertyPromotion.$assignedFields.contains('Agency')) { Agency = propertyPromotion.Agency; }
		if (propertyPromotion.$assignedFields.contains('Agent')) { Agent = propertyPromotion.Agent; }
		if (propertyPromotion.$assignedFields.contains('User')) { User = propertyPromotion.User; }
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
          ? {...?serializedTypes, 'PropertyPromotion'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(propertyId != null) 'propertyId': propertyId,
	if(agencyId != null) 'agencyId': agencyId,
	if(agentId != null) 'agentId': agentId,
	if(promotionType != null) 'promotionType': promotionType?.toJson(),
	if(status != null) 'status': status?.toJson(),
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(price != null) 'price': price,
	if(currency != null) 'currency': currency,
	if(isAutoRenew != null) 'isAutoRenew': isAutoRenew,
	if(features != null) 'features': features,
	if(paymentHistoryId != null) 'paymentHistoryId': paymentHistoryId,
	if(userId != null) 'userId': userId,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Agency != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'Agency': Agency?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Agent != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'Agent': Agent?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(User != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'User': User?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
		if ($featuresCount != null) '_count': { 
		if ($featuresCount != null) 'features': $featuresCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PropertyPromotion &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    