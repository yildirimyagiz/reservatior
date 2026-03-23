
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'investor_portfolio.dart';
import 'property.dart';


class InvestorProperty implements PrismaModel<String, InvestorProperty> , Id<String> {
    @override
String? id;
	String? portfolioId;
	String? propertyId;
	DateTime? acquiredAt;
	double? acquiredCost;
	double? mortgageBalance;
	double? mortgageRate;
	int? mortgageTerm;
	String? insuranceProvider;
	double? insuranceAmount;
	InvestorPortfolio? portfolio;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    InvestorProperty({ this.id,
	 this.portfolioId,
	 this.propertyId,
	 this.acquiredAt,
	 this.acquiredCost,
	 this.mortgageBalance,
	 this.mortgageRate,
	 this.mortgageTerm,
	 this.insuranceProvider,
	 this.insuranceAmount,
	 this.portfolio,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<InvestorProperty, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"portfolioId": (m) => m.portfolioId,

	"propertyId": (m) => m.propertyId,

	"acquiredAt": (m) => m.acquiredAt,

	"acquiredCost": (m) => m.acquiredCost,

	"mortgageBalance": (m) => m.mortgageBalance,

	"mortgageRate": (m) => m.mortgageRate,

	"mortgageTerm": (m) => m.mortgageTerm,

	"insuranceProvider": (m) => m.insuranceProvider,

	"insuranceAmount": (m) => m.insuranceAmount,

	"portfolio": (m) => m.portfolio,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(InvestorProperty) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in InvestorProperty');
    }
    return propFunction as V? Function(InvestorProperty);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory InvestorProperty.fromJson(JsonMap json) =>
      InvestorProperty(
        id: json['id'] as String?,
	portfolioId: json['portfolioId'] as String?,
	propertyId: json['propertyId'] as String?,
	acquiredAt: json['acquiredAt'] != null ? DateTime.parse(json['acquiredAt']) : null,
	acquiredCost: json['acquiredCost'] as double?,
	mortgageBalance: json['mortgageBalance'] as double?,
	mortgageRate: json['mortgageRate']?.toDouble(),
	mortgageTerm: int.tryParse(json['mortgageTerm'].toString()),
	insuranceProvider: json['insuranceProvider'] as String?,
	insuranceAmount: json['insuranceAmount'] as double?,
	portfolio: json['portfolio'] != null ? InvestorPortfolio.fromJson(json['portfolio'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    InvestorProperty copyWith({
        Value<String?>? id,
		Value<String?>? portfolioId,
		Value<String?>? propertyId,
		Value<DateTime?>? acquiredAt,
		Value<double?>? acquiredCost,
		Value<double?>? mortgageBalance,
		Value<double?>? mortgageRate,
		Value<int?>? mortgageTerm,
		Value<String?>? insuranceProvider,
		Value<double?>? insuranceAmount,
		Value<InvestorPortfolio?>? portfolio,
		Value<Property?>? property,
        }) {
        return InvestorProperty(
            id: id != null ? id.value : this.id,
		portfolioId: portfolioId != null ? portfolioId.value : this.portfolioId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		acquiredAt: acquiredAt != null ? acquiredAt.value : this.acquiredAt,
		acquiredCost: acquiredCost != null ? acquiredCost.value : this.acquiredCost,
		mortgageBalance: mortgageBalance != null ? mortgageBalance.value : this.mortgageBalance,
		mortgageRate: mortgageRate != null ? mortgageRate.value : this.mortgageRate,
		mortgageTerm: mortgageTerm != null ? mortgageTerm.value : this.mortgageTerm,
		insuranceProvider: insuranceProvider != null ? insuranceProvider.value : this.insuranceProvider,
		insuranceAmount: insuranceAmount != null ? insuranceAmount.value : this.insuranceAmount,
		portfolio: portfolio != null ? portfolio.value : this.portfolio,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    InvestorProperty copyWithInstanceValues(InvestorProperty investorProperty) {
        return InvestorProperty(
            id: investorProperty.id ?? id,
		portfolioId: investorProperty.portfolioId ?? portfolioId,
		propertyId: investorProperty.propertyId ?? propertyId,
		acquiredAt: investorProperty.acquiredAt ?? acquiredAt,
		acquiredCost: investorProperty.acquiredCost ?? acquiredCost,
		mortgageBalance: investorProperty.mortgageBalance ?? mortgageBalance,
		mortgageRate: investorProperty.mortgageRate ?? mortgageRate,
		mortgageTerm: investorProperty.mortgageTerm ?? mortgageTerm,
		insuranceProvider: investorProperty.insuranceProvider ?? insuranceProvider,
		insuranceAmount: investorProperty.insuranceAmount ?? insuranceAmount,
		portfolio: investorProperty.portfolio ?? portfolio,
		property: investorProperty.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    InvestorProperty mergeWithInstanceValues(InvestorProperty investorProperty) {
        return InvestorProperty(
            id: investorProperty.$assignedFields.contains('id') ? investorProperty.id : id,
		portfolioId: investorProperty.$assignedFields.contains('portfolioId') ? investorProperty.portfolioId : portfolioId,
		propertyId: investorProperty.$assignedFields.contains('propertyId') ? investorProperty.propertyId : propertyId,
		acquiredAt: investorProperty.$assignedFields.contains('acquiredAt') ? investorProperty.acquiredAt : acquiredAt,
		acquiredCost: investorProperty.$assignedFields.contains('acquiredCost') ? investorProperty.acquiredCost : acquiredCost,
		mortgageBalance: investorProperty.$assignedFields.contains('mortgageBalance') ? investorProperty.mortgageBalance : mortgageBalance,
		mortgageRate: investorProperty.$assignedFields.contains('mortgageRate') ? investorProperty.mortgageRate : mortgageRate,
		mortgageTerm: investorProperty.$assignedFields.contains('mortgageTerm') ? investorProperty.mortgageTerm : mortgageTerm,
		insuranceProvider: investorProperty.$assignedFields.contains('insuranceProvider') ? investorProperty.insuranceProvider : insuranceProvider,
		insuranceAmount: investorProperty.$assignedFields.contains('insuranceAmount') ? investorProperty.insuranceAmount : insuranceAmount,
		portfolio: investorProperty.$assignedFields.contains('portfolio') ? investorProperty.portfolio : portfolio,
		property: investorProperty.$assignedFields.contains('property') ? investorProperty.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    InvestorProperty updateWithInstanceValues(InvestorProperty investorProperty) {
        if (investorProperty.$assignedFields.contains('id')) { id = investorProperty.id; }
		if (investorProperty.$assignedFields.contains('portfolioId')) { portfolioId = investorProperty.portfolioId; }
		if (investorProperty.$assignedFields.contains('propertyId')) { propertyId = investorProperty.propertyId; }
		if (investorProperty.$assignedFields.contains('acquiredAt')) { acquiredAt = investorProperty.acquiredAt; }
		if (investorProperty.$assignedFields.contains('acquiredCost')) { acquiredCost = investorProperty.acquiredCost; }
		if (investorProperty.$assignedFields.contains('mortgageBalance')) { mortgageBalance = investorProperty.mortgageBalance; }
		if (investorProperty.$assignedFields.contains('mortgageRate')) { mortgageRate = investorProperty.mortgageRate; }
		if (investorProperty.$assignedFields.contains('mortgageTerm')) { mortgageTerm = investorProperty.mortgageTerm; }
		if (investorProperty.$assignedFields.contains('insuranceProvider')) { insuranceProvider = investorProperty.insuranceProvider; }
		if (investorProperty.$assignedFields.contains('insuranceAmount')) { insuranceAmount = investorProperty.insuranceAmount; }
		if (investorProperty.$assignedFields.contains('portfolio')) { portfolio = investorProperty.portfolio; }
		if (investorProperty.$assignedFields.contains('property')) { property = investorProperty.property; }
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
          ? {...?serializedTypes, 'InvestorProperty'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(portfolioId != null) 'portfolioId': portfolioId,
	if(propertyId != null) 'propertyId': propertyId,
	if(acquiredAt != null) 'acquiredAt': acquiredAt?.toIso8601String(),
	if(acquiredCost != null) 'acquiredCost': acquiredCost,
	if(mortgageBalance != null) 'mortgageBalance': mortgageBalance,
	if(mortgageRate != null) 'mortgageRate': mortgageRate,
	if(mortgageTerm != null) 'mortgageTerm': mortgageTerm,
	if(insuranceProvider != null) 'insuranceProvider': insuranceProvider,
	if(insuranceAmount != null) 'insuranceAmount': insuranceAmount,
	if(portfolio != null && (!preventCircularSerialization || !serializedModels.contains('InvestorPortfolio'))) 'portfolio': portfolio?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is InvestorProperty &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    