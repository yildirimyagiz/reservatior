
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'commission_rule_type.dart';
import 'reference_source.dart';
import 'payment.dart';


class CommissionRule implements PrismaModel<String, CommissionRule> , Id<String> {
    @override
String? id;
	String? providerId;
	CommissionRuleType? ruleType;
	DateTime? startDate;
	DateTime? endDate;
	double? commission;
	int? minVolume;
	int? maxVolume;
	dynamic conditions;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	ReferenceSource? provider;
	List<Payment>? Payment;
	int? $PaymentCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    CommissionRule({ this.id,
	 this.providerId,
	 this.ruleType,
	 this.startDate,
	 this.endDate,
	 this.commission,
	 this.minVolume,
	 this.maxVolume,
	required this.conditions,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.provider,
	 this.Payment,
	this.$PaymentCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<CommissionRule, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"providerId": (m) => m.providerId,

	"ruleType": (m) => m.ruleType,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"commission": (m) => m.commission,

	"minVolume": (m) => m.minVolume,

	"maxVolume": (m) => m.maxVolume,

	"conditions": (m) => m.conditions,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"provider": (m) => m.provider,

	"Payment": (m) => m.Payment,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(CommissionRule) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in CommissionRule');
    }
    return propFunction as V? Function(CommissionRule);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory CommissionRule.fromJson(JsonMap json) =>
      CommissionRule(
        id: json['id'] as String?,
	providerId: json['providerId'] as String?,
	ruleType: json['ruleType'] != null ? CommissionRuleType.fromJson(json['ruleType']) : null,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	commission: json['commission']?.toDouble(),
	minVolume: int.tryParse(json['minVolume'].toString()),
	maxVolume: int.tryParse(json['maxVolume'].toString()),
	conditions: json['conditions'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	provider: json['provider'] != null ? ReferenceSource.fromJson(json['provider'] as JsonMap) : null,
	Payment: json['Payment'] != null ? createModels<Payment>((json['Payment'] as List).cast<JsonMap>(), Payment.fromJson) : null,
	$PaymentCount: json['_count']?['Payment'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    CommissionRule copyWith({
        Value<String?>? id,
		Value<String?>? providerId,
		Value<CommissionRuleType?>? ruleType,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<double?>? commission,
		Value<int?>? minVolume,
		Value<int?>? maxVolume,
		Value<dynamic>? conditions,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<ReferenceSource?>? provider,
		Value<List<Payment>?>? Payment,
		int? $PaymentCount,
        }) {
        return CommissionRule(
            id: id != null ? id.value : this.id,
		providerId: providerId != null ? providerId.value : this.providerId,
		ruleType: ruleType != null ? ruleType.value : this.ruleType,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		commission: commission != null ? commission.value : this.commission,
		minVolume: minVolume != null ? minVolume.value : this.minVolume,
		maxVolume: maxVolume != null ? maxVolume.value : this.maxVolume,
		conditions: conditions != null ? conditions.value : this.conditions,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		provider: provider != null ? provider.value : this.provider,
		Payment: Payment != null ? Payment.value : this.Payment,
		$PaymentCount: $PaymentCount ?? this.$PaymentCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    CommissionRule copyWithInstanceValues(CommissionRule commissionRule) {
        return CommissionRule(
            id: commissionRule.id ?? id,
		providerId: commissionRule.providerId ?? providerId,
		ruleType: commissionRule.ruleType ?? ruleType,
		startDate: commissionRule.startDate ?? startDate,
		endDate: commissionRule.endDate ?? endDate,
		commission: commissionRule.commission ?? commission,
		minVolume: commissionRule.minVolume ?? minVolume,
		maxVolume: commissionRule.maxVolume ?? maxVolume,
		conditions: commissionRule.conditions ?? conditions,
		createdAt: commissionRule.createdAt ?? createdAt,
		updatedAt: commissionRule.updatedAt ?? updatedAt,
		deletedAt: commissionRule.deletedAt ?? deletedAt,
		provider: commissionRule.provider ?? provider,
		Payment: commissionRule.Payment ?? Payment,
		$PaymentCount: commissionRule.$PaymentCount ?? $PaymentCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    CommissionRule mergeWithInstanceValues(CommissionRule commissionRule) {
        return CommissionRule(
            id: commissionRule.$assignedFields.contains('id') ? commissionRule.id : id,
		providerId: commissionRule.$assignedFields.contains('providerId') ? commissionRule.providerId : providerId,
		ruleType: commissionRule.$assignedFields.contains('ruleType') ? commissionRule.ruleType : ruleType,
		startDate: commissionRule.$assignedFields.contains('startDate') ? commissionRule.startDate : startDate,
		endDate: commissionRule.$assignedFields.contains('endDate') ? commissionRule.endDate : endDate,
		commission: commissionRule.$assignedFields.contains('commission') ? commissionRule.commission : commission,
		minVolume: commissionRule.$assignedFields.contains('minVolume') ? commissionRule.minVolume : minVolume,
		maxVolume: commissionRule.$assignedFields.contains('maxVolume') ? commissionRule.maxVolume : maxVolume,
		conditions: commissionRule.$assignedFields.contains('conditions') ? commissionRule.conditions : conditions,
		createdAt: commissionRule.$assignedFields.contains('createdAt') ? commissionRule.createdAt : createdAt,
		updatedAt: commissionRule.$assignedFields.contains('updatedAt') ? commissionRule.updatedAt : updatedAt,
		deletedAt: commissionRule.$assignedFields.contains('deletedAt') ? commissionRule.deletedAt : deletedAt,
		provider: commissionRule.$assignedFields.contains('provider') ? commissionRule.provider : provider,
		Payment: (commissionRule.$assignedFields.contains('Payment') && commissionRule.Payment != null) ? mergeModelLists(Payment, commissionRule.Payment) : Payment,
		$PaymentCount: commissionRule.$PaymentCount ?? $PaymentCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    CommissionRule updateWithInstanceValues(CommissionRule commissionRule) {
        if (commissionRule.$assignedFields.contains('id')) { id = commissionRule.id; }
		if (commissionRule.$assignedFields.contains('providerId')) { providerId = commissionRule.providerId; }
		if (commissionRule.$assignedFields.contains('ruleType')) { ruleType = commissionRule.ruleType; }
		if (commissionRule.$assignedFields.contains('startDate')) { startDate = commissionRule.startDate; }
		if (commissionRule.$assignedFields.contains('endDate')) { endDate = commissionRule.endDate; }
		if (commissionRule.$assignedFields.contains('commission')) { commission = commissionRule.commission; }
		if (commissionRule.$assignedFields.contains('minVolume')) { minVolume = commissionRule.minVolume; }
		if (commissionRule.$assignedFields.contains('maxVolume')) { maxVolume = commissionRule.maxVolume; }
		if (commissionRule.$assignedFields.contains('conditions')) { conditions = commissionRule.conditions; }
		if (commissionRule.$assignedFields.contains('createdAt')) { createdAt = commissionRule.createdAt; }
		if (commissionRule.$assignedFields.contains('updatedAt')) { updatedAt = commissionRule.updatedAt; }
		if (commissionRule.$assignedFields.contains('deletedAt')) { deletedAt = commissionRule.deletedAt; }
		if (commissionRule.$assignedFields.contains('provider')) { provider = commissionRule.provider; }
		if (commissionRule.$assignedFields.contains('Payment') && commissionRule.Payment != null) { Payment = mergeModelLists(Payment, commissionRule.Payment); }
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
          ? {...?serializedTypes, 'CommissionRule'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(providerId != null) 'providerId': providerId,
	if(ruleType != null) 'ruleType': ruleType?.toJson(),
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(commission != null) 'commission': commission,
	if(minVolume != null) 'minVolume': minVolume,
	if(maxVolume != null) 'maxVolume': maxVolume,
	if(conditions != null) 'conditions': conditions,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(provider != null && (!preventCircularSerialization || !serializedModels.contains('ReferenceSource'))) 'provider': provider?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(Payment != null && (!preventCircularSerialization || !serializedModels.contains('Payment'))) 'Payment': Payment?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($PaymentCount != null) '_count': { 
		if ($PaymentCount != null) 'Payment': $PaymentCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is CommissionRule &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    