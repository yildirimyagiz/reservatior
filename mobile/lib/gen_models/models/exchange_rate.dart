
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';


class ExchangeRate implements PrismaModel<String, ExchangeRate> , Id<String> {
    @override
String? id;
	String? orgId;
	String? baseCurrency;
	String? quoteCurrency;
	double? rate;
	DateTime? asOfDate;
	String? source;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ExchangeRate({ this.id,
	 this.orgId,
	 this.baseCurrency,
	 this.quoteCurrency,
	 this.rate,
	 this.asOfDate,
	 this.source,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ExchangeRate, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"baseCurrency": (m) => m.baseCurrency,

	"quoteCurrency": (m) => m.quoteCurrency,

	"rate": (m) => m.rate,

	"asOfDate": (m) => m.asOfDate,

	"source": (m) => m.source,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ExchangeRate) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ExchangeRate');
    }
    return propFunction as V? Function(ExchangeRate);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ExchangeRate.fromJson(JsonMap json) =>
      ExchangeRate(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	baseCurrency: json['baseCurrency'] as String?,
	quoteCurrency: json['quoteCurrency'] as String?,
	rate: json['rate'] as double?,
	asOfDate: json['asOfDate'] != null ? DateTime.parse(json['asOfDate']) : null,
	source: json['source'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ExchangeRate copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? baseCurrency,
		Value<String?>? quoteCurrency,
		Value<double?>? rate,
		Value<DateTime?>? asOfDate,
		Value<String?>? source,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
        }) {
        return ExchangeRate(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		baseCurrency: baseCurrency != null ? baseCurrency.value : this.baseCurrency,
		quoteCurrency: quoteCurrency != null ? quoteCurrency.value : this.quoteCurrency,
		rate: rate != null ? rate.value : this.rate,
		asOfDate: asOfDate != null ? asOfDate.value : this.asOfDate,
		source: source != null ? source.value : this.source,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ExchangeRate copyWithInstanceValues(ExchangeRate exchangeRate) {
        return ExchangeRate(
            id: exchangeRate.id ?? id,
		orgId: exchangeRate.orgId ?? orgId,
		baseCurrency: exchangeRate.baseCurrency ?? baseCurrency,
		quoteCurrency: exchangeRate.quoteCurrency ?? quoteCurrency,
		rate: exchangeRate.rate ?? rate,
		asOfDate: exchangeRate.asOfDate ?? asOfDate,
		source: exchangeRate.source ?? source,
		createdAt: exchangeRate.createdAt ?? createdAt,
		updatedAt: exchangeRate.updatedAt ?? updatedAt,
		deletedAt: exchangeRate.deletedAt ?? deletedAt,
		org: exchangeRate.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ExchangeRate mergeWithInstanceValues(ExchangeRate exchangeRate) {
        return ExchangeRate(
            id: exchangeRate.$assignedFields.contains('id') ? exchangeRate.id : id,
		orgId: exchangeRate.$assignedFields.contains('orgId') ? exchangeRate.orgId : orgId,
		baseCurrency: exchangeRate.$assignedFields.contains('baseCurrency') ? exchangeRate.baseCurrency : baseCurrency,
		quoteCurrency: exchangeRate.$assignedFields.contains('quoteCurrency') ? exchangeRate.quoteCurrency : quoteCurrency,
		rate: exchangeRate.$assignedFields.contains('rate') ? exchangeRate.rate : rate,
		asOfDate: exchangeRate.$assignedFields.contains('asOfDate') ? exchangeRate.asOfDate : asOfDate,
		source: exchangeRate.$assignedFields.contains('source') ? exchangeRate.source : source,
		createdAt: exchangeRate.$assignedFields.contains('createdAt') ? exchangeRate.createdAt : createdAt,
		updatedAt: exchangeRate.$assignedFields.contains('updatedAt') ? exchangeRate.updatedAt : updatedAt,
		deletedAt: exchangeRate.$assignedFields.contains('deletedAt') ? exchangeRate.deletedAt : deletedAt,
		org: exchangeRate.$assignedFields.contains('org') ? exchangeRate.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ExchangeRate updateWithInstanceValues(ExchangeRate exchangeRate) {
        if (exchangeRate.$assignedFields.contains('id')) { id = exchangeRate.id; }
		if (exchangeRate.$assignedFields.contains('orgId')) { orgId = exchangeRate.orgId; }
		if (exchangeRate.$assignedFields.contains('baseCurrency')) { baseCurrency = exchangeRate.baseCurrency; }
		if (exchangeRate.$assignedFields.contains('quoteCurrency')) { quoteCurrency = exchangeRate.quoteCurrency; }
		if (exchangeRate.$assignedFields.contains('rate')) { rate = exchangeRate.rate; }
		if (exchangeRate.$assignedFields.contains('asOfDate')) { asOfDate = exchangeRate.asOfDate; }
		if (exchangeRate.$assignedFields.contains('source')) { source = exchangeRate.source; }
		if (exchangeRate.$assignedFields.contains('createdAt')) { createdAt = exchangeRate.createdAt; }
		if (exchangeRate.$assignedFields.contains('updatedAt')) { updatedAt = exchangeRate.updatedAt; }
		if (exchangeRate.$assignedFields.contains('deletedAt')) { deletedAt = exchangeRate.deletedAt; }
		if (exchangeRate.$assignedFields.contains('org')) { org = exchangeRate.org; }
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
          ? {...?serializedTypes, 'ExchangeRate'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(baseCurrency != null) 'baseCurrency': baseCurrency,
	if(quoteCurrency != null) 'quoteCurrency': quoteCurrency,
	if(rate != null) 'rate': rate,
	if(asOfDate != null) 'asOfDate': asOfDate?.toIso8601String(),
	if(source != null) 'source': source,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ExchangeRate &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    