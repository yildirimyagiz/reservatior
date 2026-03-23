
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'risk_tolerance.dart';
import 'organization.dart';
import 'user.dart';
import 'investor_property.dart';


class InvestorPortfolio implements PrismaModel<String, InvestorPortfolio> , Id<String> {
    @override
String? id;
	String? userId;
	String? name;
	double? targetIrr;
	RiskTolerance? riskTolerance;
	String? investmentHorizon;
	double? totalInvested;
	double? currentValue;
	double? totalReturns;
	String? organizationId;
	Organization? organization;
	User? user;
	List<InvestorProperty>? properties;
	int? $propertiesCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    InvestorPortfolio({ this.id,
	 this.userId,
	 this.name,
	 this.targetIrr,
	 this.riskTolerance,
	 this.investmentHorizon,
	 this.totalInvested = 0,
	 this.currentValue = 0,
	 this.totalReturns = 0,
	 this.organizationId,
	 this.organization,
	 this.user,
	 this.properties,
	this.$propertiesCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<InvestorPortfolio, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"name": (m) => m.name,

	"targetIrr": (m) => m.targetIrr,

	"riskTolerance": (m) => m.riskTolerance,

	"investmentHorizon": (m) => m.investmentHorizon,

	"totalInvested": (m) => m.totalInvested,

	"currentValue": (m) => m.currentValue,

	"totalReturns": (m) => m.totalReturns,

	"organizationId": (m) => m.organizationId,

	"organization": (m) => m.organization,

	"user": (m) => m.user,

	"properties": (m) => m.properties,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(InvestorPortfolio) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in InvestorPortfolio');
    }
    return propFunction as V? Function(InvestorPortfolio);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory InvestorPortfolio.fromJson(JsonMap json) =>
      InvestorPortfolio(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	name: json['name'] as String?,
	targetIrr: json['targetIrr']?.toDouble(),
	riskTolerance: json['riskTolerance'] != null ? RiskTolerance.fromJson(json['riskTolerance']) : null,
	investmentHorizon: json['investmentHorizon'] as String?,
	totalInvested: json['totalInvested'] as double?,
	currentValue: json['currentValue'] as double?,
	totalReturns: json['totalReturns'] as double?,
	organizationId: json['organizationId'] as String?,
	organization: json['organization'] != null ? Organization.fromJson(json['organization'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
	properties: json['properties'] != null ? createModels<InvestorProperty>((json['properties'] as List).cast<JsonMap>(), InvestorProperty.fromJson) : null,
	$propertiesCount: json['_count']?['properties'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    InvestorPortfolio copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? name,
		Value<double?>? targetIrr,
		Value<RiskTolerance?>? riskTolerance,
		Value<String?>? investmentHorizon,
		Value<double?>? totalInvested,
		Value<double?>? currentValue,
		Value<double?>? totalReturns,
		Value<String?>? organizationId,
		Value<Organization?>? organization,
		Value<User?>? user,
		Value<List<InvestorProperty>?>? properties,
		int? $propertiesCount,
        }) {
        return InvestorPortfolio(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		name: name != null ? name.value : this.name,
		targetIrr: targetIrr != null ? targetIrr.value : this.targetIrr,
		riskTolerance: riskTolerance != null ? riskTolerance.value : this.riskTolerance,
		investmentHorizon: investmentHorizon != null ? investmentHorizon.value : this.investmentHorizon,
		totalInvested: totalInvested != null ? totalInvested.value : this.totalInvested,
		currentValue: currentValue != null ? currentValue.value : this.currentValue,
		totalReturns: totalReturns != null ? totalReturns.value : this.totalReturns,
		organizationId: organizationId != null ? organizationId.value : this.organizationId,
		organization: organization != null ? organization.value : this.organization,
		user: user != null ? user.value : this.user,
		properties: properties != null ? properties.value : this.properties,
		$propertiesCount: $propertiesCount ?? this.$propertiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    InvestorPortfolio copyWithInstanceValues(InvestorPortfolio investorPortfolio) {
        return InvestorPortfolio(
            id: investorPortfolio.id ?? id,
		userId: investorPortfolio.userId ?? userId,
		name: investorPortfolio.name ?? name,
		targetIrr: investorPortfolio.targetIrr ?? targetIrr,
		riskTolerance: investorPortfolio.riskTolerance ?? riskTolerance,
		investmentHorizon: investorPortfolio.investmentHorizon ?? investmentHorizon,
		totalInvested: investorPortfolio.totalInvested ?? totalInvested,
		currentValue: investorPortfolio.currentValue ?? currentValue,
		totalReturns: investorPortfolio.totalReturns ?? totalReturns,
		organizationId: investorPortfolio.organizationId ?? organizationId,
		organization: investorPortfolio.organization ?? organization,
		user: investorPortfolio.user ?? user,
		properties: investorPortfolio.properties ?? properties,
		$propertiesCount: investorPortfolio.$propertiesCount ?? $propertiesCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    InvestorPortfolio mergeWithInstanceValues(InvestorPortfolio investorPortfolio) {
        return InvestorPortfolio(
            id: investorPortfolio.$assignedFields.contains('id') ? investorPortfolio.id : id,
		userId: investorPortfolio.$assignedFields.contains('userId') ? investorPortfolio.userId : userId,
		name: investorPortfolio.$assignedFields.contains('name') ? investorPortfolio.name : name,
		targetIrr: investorPortfolio.$assignedFields.contains('targetIrr') ? investorPortfolio.targetIrr : targetIrr,
		riskTolerance: investorPortfolio.$assignedFields.contains('riskTolerance') ? investorPortfolio.riskTolerance : riskTolerance,
		investmentHorizon: investorPortfolio.$assignedFields.contains('investmentHorizon') ? investorPortfolio.investmentHorizon : investmentHorizon,
		totalInvested: investorPortfolio.$assignedFields.contains('totalInvested') ? investorPortfolio.totalInvested : totalInvested,
		currentValue: investorPortfolio.$assignedFields.contains('currentValue') ? investorPortfolio.currentValue : currentValue,
		totalReturns: investorPortfolio.$assignedFields.contains('totalReturns') ? investorPortfolio.totalReturns : totalReturns,
		organizationId: investorPortfolio.$assignedFields.contains('organizationId') ? investorPortfolio.organizationId : organizationId,
		organization: investorPortfolio.$assignedFields.contains('organization') ? investorPortfolio.organization : organization,
		user: investorPortfolio.$assignedFields.contains('user') ? investorPortfolio.user : user,
		properties: (investorPortfolio.$assignedFields.contains('properties') && investorPortfolio.properties != null) ? mergeModelLists(properties, investorPortfolio.properties) : properties,
		$propertiesCount: investorPortfolio.$propertiesCount ?? $propertiesCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    InvestorPortfolio updateWithInstanceValues(InvestorPortfolio investorPortfolio) {
        if (investorPortfolio.$assignedFields.contains('id')) { id = investorPortfolio.id; }
		if (investorPortfolio.$assignedFields.contains('userId')) { userId = investorPortfolio.userId; }
		if (investorPortfolio.$assignedFields.contains('name')) { name = investorPortfolio.name; }
		if (investorPortfolio.$assignedFields.contains('targetIrr')) { targetIrr = investorPortfolio.targetIrr; }
		if (investorPortfolio.$assignedFields.contains('riskTolerance')) { riskTolerance = investorPortfolio.riskTolerance; }
		if (investorPortfolio.$assignedFields.contains('investmentHorizon')) { investmentHorizon = investorPortfolio.investmentHorizon; }
		if (investorPortfolio.$assignedFields.contains('totalInvested')) { totalInvested = investorPortfolio.totalInvested; }
		if (investorPortfolio.$assignedFields.contains('currentValue')) { currentValue = investorPortfolio.currentValue; }
		if (investorPortfolio.$assignedFields.contains('totalReturns')) { totalReturns = investorPortfolio.totalReturns; }
		if (investorPortfolio.$assignedFields.contains('organizationId')) { organizationId = investorPortfolio.organizationId; }
		if (investorPortfolio.$assignedFields.contains('organization')) { organization = investorPortfolio.organization; }
		if (investorPortfolio.$assignedFields.contains('user')) { user = investorPortfolio.user; }
		if (investorPortfolio.$assignedFields.contains('properties') && investorPortfolio.properties != null) { properties = mergeModelLists(properties, investorPortfolio.properties); }
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
          ? {...?serializedTypes, 'InvestorPortfolio'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(name != null) 'name': name,
	if(targetIrr != null) 'targetIrr': targetIrr,
	if(riskTolerance != null) 'riskTolerance': riskTolerance?.toJson(),
	if(investmentHorizon != null) 'investmentHorizon': investmentHorizon,
	if(totalInvested != null) 'totalInvested': totalInvested,
	if(currentValue != null) 'currentValue': currentValue,
	if(totalReturns != null) 'totalReturns': totalReturns,
	if(organizationId != null) 'organizationId': organizationId,
	if(organization != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'organization': organization?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(properties != null && (!preventCircularSerialization || !serializedModels.contains('InvestorProperty'))) 'properties': properties?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($propertiesCount != null) '_count': { 
		if ($propertiesCount != null) 'properties': $propertiesCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is InvestorPortfolio &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    