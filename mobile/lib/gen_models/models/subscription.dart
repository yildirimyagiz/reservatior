
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'membership_type.dart';
import 'organization.dart';
import 'pricing_rule.dart';
import 'agent.dart';
import 'agency.dart';
import 'payment.dart';


class Subscription implements PrismaModel<String, Subscription> , Id<String> {
    @override
String? id;
	String? orgId;
	String? userId;
	String? name;
	MembershipType? type;
	double? price;
	String? currency;
	String? billingCycle;
	int? maxProperties;
	int? maxListings;
	int? featuredListings;
	bool? prioritySupport;
	bool? apiAccess;
	double? commissionDiscount;
	double? loyaltyMultiplier;
	bool? isActive;
	dynamic userSubscriptions;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;
	List<PricingRule>? pricingRules;
	List<Agent>? agents;
	List<Agency>? agencies;
	List<Payment>? payments;
	int? $pricingRulesCount;
	int? $agentsCount;
	int? $agenciesCount;
	int? $paymentsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Subscription({ this.id,
	 this.orgId,
	 this.userId,
	 this.name,
	 this.type,
	 this.price,
	 this.currency = "USD",
	 this.billingCycle = "MONTHLY",
	 this.maxProperties = 1,
	 this.maxListings = 5,
	 this.featuredListings = 0,
	 this.prioritySupport = false,
	 this.apiAccess = false,
	 this.commissionDiscount = 0,
	 this.loyaltyMultiplier = 1,
	 this.isActive = true,
	required this.userSubscriptions,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
	 this.pricingRules,
	 this.agents,
	 this.agencies,
	 this.payments,
	this.$pricingRulesCount,
	this.$agentsCount,
	this.$agenciesCount,
	this.$paymentsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Subscription, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"userId": (m) => m.userId,

	"name": (m) => m.name,

	"type": (m) => m.type,

	"price": (m) => m.price,

	"currency": (m) => m.currency,

	"billingCycle": (m) => m.billingCycle,

	"maxProperties": (m) => m.maxProperties,

	"maxListings": (m) => m.maxListings,

	"featuredListings": (m) => m.featuredListings,

	"prioritySupport": (m) => m.prioritySupport,

	"apiAccess": (m) => m.apiAccess,

	"commissionDiscount": (m) => m.commissionDiscount,

	"loyaltyMultiplier": (m) => m.loyaltyMultiplier,

	"isActive": (m) => m.isActive,

	"userSubscriptions": (m) => m.userSubscriptions,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,

	"pricingRules": (m) => m.pricingRules,

	"agents": (m) => m.agents,

	"agencies": (m) => m.agencies,

	"payments": (m) => m.payments,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Subscription) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Subscription');
    }
    return propFunction as V? Function(Subscription);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Subscription.fromJson(JsonMap json) =>
      Subscription(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	userId: json['userId'] as String?,
	name: json['name'] as String?,
	type: json['type'] != null ? MembershipType.fromJson(json['type']) : null,
	price: json['price'] as double?,
	currency: json['currency'] as String?,
	billingCycle: json['billingCycle'] as String?,
	maxProperties: int.tryParse(json['maxProperties'].toString()),
	maxListings: int.tryParse(json['maxListings'].toString()),
	featuredListings: int.tryParse(json['featuredListings'].toString()),
	prioritySupport: json['prioritySupport'] as bool?,
	apiAccess: json['apiAccess'] as bool?,
	commissionDiscount: json['commissionDiscount']?.toDouble(),
	loyaltyMultiplier: json['loyaltyMultiplier']?.toDouble(),
	isActive: json['isActive'] as bool?,
	userSubscriptions: json['userSubscriptions'] as dynamic,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	pricingRules: json['pricingRules'] != null ? createModels<PricingRule>((json['pricingRules'] as List).cast<JsonMap>(), PricingRule.fromJson) : null,
	agents: json['agents'] != null ? createModels<Agent>((json['agents'] as List).cast<JsonMap>(), Agent.fromJson) : null,
	agencies: json['agencies'] != null ? createModels<Agency>((json['agencies'] as List).cast<JsonMap>(), Agency.fromJson) : null,
	payments: json['payments'] != null ? createModels<Payment>((json['payments'] as List).cast<JsonMap>(), Payment.fromJson) : null,
	$pricingRulesCount: json['_count']?['pricingRules'] as int?,
	$agentsCount: json['_count']?['agents'] as int?,
	$agenciesCount: json['_count']?['agencies'] as int?,
	$paymentsCount: json['_count']?['payments'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Subscription copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? userId,
		Value<String?>? name,
		Value<MembershipType?>? type,
		Value<double?>? price,
		Value<String?>? currency,
		Value<String?>? billingCycle,
		Value<int?>? maxProperties,
		Value<int?>? maxListings,
		Value<int?>? featuredListings,
		Value<bool?>? prioritySupport,
		Value<bool?>? apiAccess,
		Value<double?>? commissionDiscount,
		Value<double?>? loyaltyMultiplier,
		Value<bool?>? isActive,
		Value<dynamic>? userSubscriptions,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
		Value<List<PricingRule>?>? pricingRules,
		Value<List<Agent>?>? agents,
		Value<List<Agency>?>? agencies,
		Value<List<Payment>?>? payments,
		int? $pricingRulesCount,
		int? $agentsCount,
		int? $agenciesCount,
		int? $paymentsCount,
        }) {
        return Subscription(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		userId: userId != null ? userId.value : this.userId,
		name: name != null ? name.value : this.name,
		type: type != null ? type.value : this.type,
		price: price != null ? price.value : this.price,
		currency: currency != null ? currency.value : this.currency,
		billingCycle: billingCycle != null ? billingCycle.value : this.billingCycle,
		maxProperties: maxProperties != null ? maxProperties.value : this.maxProperties,
		maxListings: maxListings != null ? maxListings.value : this.maxListings,
		featuredListings: featuredListings != null ? featuredListings.value : this.featuredListings,
		prioritySupport: prioritySupport != null ? prioritySupport.value : this.prioritySupport,
		apiAccess: apiAccess != null ? apiAccess.value : this.apiAccess,
		commissionDiscount: commissionDiscount != null ? commissionDiscount.value : this.commissionDiscount,
		loyaltyMultiplier: loyaltyMultiplier != null ? loyaltyMultiplier.value : this.loyaltyMultiplier,
		isActive: isActive != null ? isActive.value : this.isActive,
		userSubscriptions: userSubscriptions != null ? userSubscriptions.value : this.userSubscriptions,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org,
		pricingRules: pricingRules != null ? pricingRules.value : this.pricingRules,
		agents: agents != null ? agents.value : this.agents,
		agencies: agencies != null ? agencies.value : this.agencies,
		payments: payments != null ? payments.value : this.payments,
		$pricingRulesCount: $pricingRulesCount ?? this.$pricingRulesCount,
		$agentsCount: $agentsCount ?? this.$agentsCount,
		$agenciesCount: $agenciesCount ?? this.$agenciesCount,
		$paymentsCount: $paymentsCount ?? this.$paymentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Subscription copyWithInstanceValues(Subscription subscription) {
        return Subscription(
            id: subscription.id ?? id,
		orgId: subscription.orgId ?? orgId,
		userId: subscription.userId ?? userId,
		name: subscription.name ?? name,
		type: subscription.type ?? type,
		price: subscription.price ?? price,
		currency: subscription.currency ?? currency,
		billingCycle: subscription.billingCycle ?? billingCycle,
		maxProperties: subscription.maxProperties ?? maxProperties,
		maxListings: subscription.maxListings ?? maxListings,
		featuredListings: subscription.featuredListings ?? featuredListings,
		prioritySupport: subscription.prioritySupport ?? prioritySupport,
		apiAccess: subscription.apiAccess ?? apiAccess,
		commissionDiscount: subscription.commissionDiscount ?? commissionDiscount,
		loyaltyMultiplier: subscription.loyaltyMultiplier ?? loyaltyMultiplier,
		isActive: subscription.isActive ?? isActive,
		userSubscriptions: subscription.userSubscriptions ?? userSubscriptions,
		createdBy: subscription.createdBy ?? createdBy,
		createdAt: subscription.createdAt ?? createdAt,
		updatedAt: subscription.updatedAt ?? updatedAt,
		org: subscription.org ?? org,
		pricingRules: subscription.pricingRules ?? pricingRules,
		agents: subscription.agents ?? agents,
		agencies: subscription.agencies ?? agencies,
		payments: subscription.payments ?? payments,
		$pricingRulesCount: subscription.$pricingRulesCount ?? $pricingRulesCount,
		$agentsCount: subscription.$agentsCount ?? $agentsCount,
		$agenciesCount: subscription.$agenciesCount ?? $agenciesCount,
		$paymentsCount: subscription.$paymentsCount ?? $paymentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Subscription mergeWithInstanceValues(Subscription subscription) {
        return Subscription(
            id: subscription.$assignedFields.contains('id') ? subscription.id : id,
		orgId: subscription.$assignedFields.contains('orgId') ? subscription.orgId : orgId,
		userId: subscription.$assignedFields.contains('userId') ? subscription.userId : userId,
		name: subscription.$assignedFields.contains('name') ? subscription.name : name,
		type: subscription.$assignedFields.contains('type') ? subscription.type : type,
		price: subscription.$assignedFields.contains('price') ? subscription.price : price,
		currency: subscription.$assignedFields.contains('currency') ? subscription.currency : currency,
		billingCycle: subscription.$assignedFields.contains('billingCycle') ? subscription.billingCycle : billingCycle,
		maxProperties: subscription.$assignedFields.contains('maxProperties') ? subscription.maxProperties : maxProperties,
		maxListings: subscription.$assignedFields.contains('maxListings') ? subscription.maxListings : maxListings,
		featuredListings: subscription.$assignedFields.contains('featuredListings') ? subscription.featuredListings : featuredListings,
		prioritySupport: subscription.$assignedFields.contains('prioritySupport') ? subscription.prioritySupport : prioritySupport,
		apiAccess: subscription.$assignedFields.contains('apiAccess') ? subscription.apiAccess : apiAccess,
		commissionDiscount: subscription.$assignedFields.contains('commissionDiscount') ? subscription.commissionDiscount : commissionDiscount,
		loyaltyMultiplier: subscription.$assignedFields.contains('loyaltyMultiplier') ? subscription.loyaltyMultiplier : loyaltyMultiplier,
		isActive: subscription.$assignedFields.contains('isActive') ? subscription.isActive : isActive,
		userSubscriptions: subscription.$assignedFields.contains('userSubscriptions') ? subscription.userSubscriptions : userSubscriptions,
		createdBy: subscription.$assignedFields.contains('createdBy') ? subscription.createdBy : createdBy,
		createdAt: subscription.$assignedFields.contains('createdAt') ? subscription.createdAt : createdAt,
		updatedAt: subscription.$assignedFields.contains('updatedAt') ? subscription.updatedAt : updatedAt,
		org: subscription.$assignedFields.contains('org') ? subscription.org : org,
		pricingRules: (subscription.$assignedFields.contains('pricingRules') && subscription.pricingRules != null) ? mergeModelLists(pricingRules, subscription.pricingRules) : pricingRules,
		agents: (subscription.$assignedFields.contains('agents') && subscription.agents != null) ? mergeModelLists(agents, subscription.agents) : agents,
		agencies: (subscription.$assignedFields.contains('agencies') && subscription.agencies != null) ? mergeModelLists(agencies, subscription.agencies) : agencies,
		payments: (subscription.$assignedFields.contains('payments') && subscription.payments != null) ? mergeModelLists(payments, subscription.payments) : payments,
		$pricingRulesCount: subscription.$pricingRulesCount ?? $pricingRulesCount,
		$agentsCount: subscription.$agentsCount ?? $agentsCount,
		$agenciesCount: subscription.$agenciesCount ?? $agenciesCount,
		$paymentsCount: subscription.$paymentsCount ?? $paymentsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Subscription updateWithInstanceValues(Subscription subscription) {
        if (subscription.$assignedFields.contains('id')) { id = subscription.id; }
		if (subscription.$assignedFields.contains('orgId')) { orgId = subscription.orgId; }
		if (subscription.$assignedFields.contains('userId')) { userId = subscription.userId; }
		if (subscription.$assignedFields.contains('name')) { name = subscription.name; }
		if (subscription.$assignedFields.contains('type')) { type = subscription.type; }
		if (subscription.$assignedFields.contains('price')) { price = subscription.price; }
		if (subscription.$assignedFields.contains('currency')) { currency = subscription.currency; }
		if (subscription.$assignedFields.contains('billingCycle')) { billingCycle = subscription.billingCycle; }
		if (subscription.$assignedFields.contains('maxProperties')) { maxProperties = subscription.maxProperties; }
		if (subscription.$assignedFields.contains('maxListings')) { maxListings = subscription.maxListings; }
		if (subscription.$assignedFields.contains('featuredListings')) { featuredListings = subscription.featuredListings; }
		if (subscription.$assignedFields.contains('prioritySupport')) { prioritySupport = subscription.prioritySupport; }
		if (subscription.$assignedFields.contains('apiAccess')) { apiAccess = subscription.apiAccess; }
		if (subscription.$assignedFields.contains('commissionDiscount')) { commissionDiscount = subscription.commissionDiscount; }
		if (subscription.$assignedFields.contains('loyaltyMultiplier')) { loyaltyMultiplier = subscription.loyaltyMultiplier; }
		if (subscription.$assignedFields.contains('isActive')) { isActive = subscription.isActive; }
		if (subscription.$assignedFields.contains('userSubscriptions')) { userSubscriptions = subscription.userSubscriptions; }
		if (subscription.$assignedFields.contains('createdBy')) { createdBy = subscription.createdBy; }
		if (subscription.$assignedFields.contains('createdAt')) { createdAt = subscription.createdAt; }
		if (subscription.$assignedFields.contains('updatedAt')) { updatedAt = subscription.updatedAt; }
		if (subscription.$assignedFields.contains('org')) { org = subscription.org; }
		if (subscription.$assignedFields.contains('pricingRules') && subscription.pricingRules != null) { pricingRules = mergeModelLists(pricingRules, subscription.pricingRules); }
		if (subscription.$assignedFields.contains('agents') && subscription.agents != null) { agents = mergeModelLists(agents, subscription.agents); }
		if (subscription.$assignedFields.contains('agencies') && subscription.agencies != null) { agencies = mergeModelLists(agencies, subscription.agencies); }
		if (subscription.$assignedFields.contains('payments') && subscription.payments != null) { payments = mergeModelLists(payments, subscription.payments); }
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
          ? {...?serializedTypes, 'Subscription'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(userId != null) 'userId': userId,
	if(name != null) 'name': name,
	if(type != null) 'type': type?.toJson(),
	if(price != null) 'price': price,
	if(currency != null) 'currency': currency,
	if(billingCycle != null) 'billingCycle': billingCycle,
	if(maxProperties != null) 'maxProperties': maxProperties,
	if(maxListings != null) 'maxListings': maxListings,
	if(featuredListings != null) 'featuredListings': featuredListings,
	if(prioritySupport != null) 'prioritySupport': prioritySupport,
	if(apiAccess != null) 'apiAccess': apiAccess,
	if(commissionDiscount != null) 'commissionDiscount': commissionDiscount,
	if(loyaltyMultiplier != null) 'loyaltyMultiplier': loyaltyMultiplier,
	if(isActive != null) 'isActive': isActive,
	if(userSubscriptions != null) 'userSubscriptions': userSubscriptions,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(pricingRules != null && (!preventCircularSerialization || !serializedModels.contains('PricingRule'))) 'pricingRules': pricingRules?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agents != null && (!preventCircularSerialization || !serializedModels.contains('Agent'))) 'agents': agents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(agencies != null && (!preventCircularSerialization || !serializedModels.contains('Agency'))) 'agencies': agencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(payments != null && (!preventCircularSerialization || !serializedModels.contains('Payment'))) 'payments': payments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($pricingRulesCount != null || $agentsCount != null || $agenciesCount != null || $paymentsCount != null) '_count': { 
		if ($pricingRulesCount != null) 'pricingRules': $pricingRulesCount, 
		if ($agentsCount != null) 'agents': $agentsCount, 
		if ($agenciesCount != null) 'agencies': $agenciesCount, 
		if ($paymentsCount != null) 'payments': $paymentsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Subscription &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    