
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'user.dart';


class Currency implements PrismaModel<String, Currency> , Id<String> {
    @override
String? id;
	String? code;
	String? name;
	String? symbol;
	double? exchangeRate;
	bool? isActive;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Expense>? Expense;
	List<Payment>? Payment;
	List<PricingRule>? PricingRule;
	List<Property>? Property;
	List<Reservation>? Reservation;
	List<TaxRecord>? TaxRecord;
	List<User>? users;
	int? $ExpenseCount;
	int? $PaymentCount;
	int? $PricingRuleCount;
	int? $PropertyCount;
	int? $ReservationCount;
	int? $TaxRecordCount;
	int? $usersCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Currency({ this.id,
	 this.code,
	 this.name,
	 this.symbol,
	 this.exchangeRate,
	 this.isActive = true,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.Expense,
	 this.Payment,
	 this.PricingRule,
	 this.Property,
	 this.Reservation,
	 this.TaxRecord,
	 this.users,
	this.$ExpenseCount,
	this.$PaymentCount,
	this.$PricingRuleCount,
	this.$PropertyCount,
	this.$ReservationCount,
	this.$TaxRecordCount,
	this.$usersCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Currency, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"code": (m) => m.code,

	"name": (m) => m.name,

	"symbol": (m) => m.symbol,

	"exchangeRate": (m) => m.exchangeRate,

	"isActive": (m) => m.isActive,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"Expense": (m) => m.Expense,

	"Payment": (m) => m.Payment,

	"PricingRule": (m) => m.PricingRule,

	"Property": (m) => m.Property,

	"Reservation": (m) => m.Reservation,

	"TaxRecord": (m) => m.TaxRecord,

	"users": (m) => m.users,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Currency) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Currency');
    }
    return propFunction as V? Function(Currency);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Currency.fromJson(JsonMap json) =>
      Currency(
        id: json['id'] as String?,
	code: json['code'] as String?,
	name: json['name'] as String?,
	symbol: json['symbol'] as String?,
	exchangeRate: json['exchangeRate']?.toDouble(),
	isActive: json['isActive'] as bool?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	Expense: json['Expense'] != null ? createModels<Expense>((json['Expense'] as List).cast<JsonMap>(), Expense.fromJson) : null,
	Payment: json['Payment'] != null ? createModels<Payment>((json['Payment'] as List).cast<JsonMap>(), Payment.fromJson) : null,
	PricingRule: json['PricingRule'] != null ? createModels<PricingRule>((json['PricingRule'] as List).cast<JsonMap>(), PricingRule.fromJson) : null,
	Property: json['Property'] != null ? createModels<Property>((json['Property'] as List).cast<JsonMap>(), Property.fromJson) : null,
	Reservation: json['Reservation'] != null ? createModels<Reservation>((json['Reservation'] as List).cast<JsonMap>(), Reservation.fromJson) : null,
	TaxRecord: json['TaxRecord'] != null ? createModels<TaxRecord>((json['TaxRecord'] as List).cast<JsonMap>(), TaxRecord.fromJson) : null,
	users: json['users'] != null ? createModels<User>((json['users'] as List).cast<JsonMap>(), User.fromJson) : null,
	$ExpenseCount: json['_count']?['Expense'] as int?,
	$PaymentCount: json['_count']?['Payment'] as int?,
	$PricingRuleCount: json['_count']?['PricingRule'] as int?,
	$PropertyCount: json['_count']?['Property'] as int?,
	$ReservationCount: json['_count']?['Reservation'] as int?,
	$TaxRecordCount: json['_count']?['TaxRecord'] as int?,
	$usersCount: json['_count']?['users'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Currency copyWith({
        Value<String?>? id,
		Value<String?>? code,
		Value<String?>? name,
		Value<String?>? symbol,
		Value<double?>? exchangeRate,
		Value<bool?>? isActive,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Expense>?>? Expense,
		Value<List<Payment>?>? Payment,
		Value<List<PricingRule>?>? PricingRule,
		Value<List<Property>?>? Property,
		Value<List<Reservation>?>? Reservation,
		Value<List<TaxRecord>?>? TaxRecord,
		Value<List<User>?>? users,
		int? $ExpenseCount,
		int? $PaymentCount,
		int? $PricingRuleCount,
		int? $PropertyCount,
		int? $ReservationCount,
		int? $TaxRecordCount,
		int? $usersCount,
        }) {
        return Currency(
            id: id != null ? id.value : this.id,
		code: code != null ? code.value : this.code,
		name: name != null ? name.value : this.name,
		symbol: symbol != null ? symbol.value : this.symbol,
		exchangeRate: exchangeRate != null ? exchangeRate.value : this.exchangeRate,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		Expense: Expense != null ? Expense.value : this.Expense,
		Payment: Payment != null ? Payment.value : this.Payment,
		PricingRule: PricingRule != null ? PricingRule.value : this.PricingRule,
		Property: Property != null ? Property.value : this.Property,
		Reservation: Reservation != null ? Reservation.value : this.Reservation,
		TaxRecord: TaxRecord != null ? TaxRecord.value : this.TaxRecord,
		users: users != null ? users.value : this.users,
		$ExpenseCount: $ExpenseCount ?? this.$ExpenseCount,
		$PaymentCount: $PaymentCount ?? this.$PaymentCount,
		$PricingRuleCount: $PricingRuleCount ?? this.$PricingRuleCount,
		$PropertyCount: $PropertyCount ?? this.$PropertyCount,
		$ReservationCount: $ReservationCount ?? this.$ReservationCount,
		$TaxRecordCount: $TaxRecordCount ?? this.$TaxRecordCount,
		$usersCount: $usersCount ?? this.$usersCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Currency copyWithInstanceValues(Currency currency) {
        return Currency(
            id: currency.id ?? id,
		code: currency.code ?? code,
		name: currency.name ?? name,
		symbol: currency.symbol ?? symbol,
		exchangeRate: currency.exchangeRate ?? exchangeRate,
		isActive: currency.isActive ?? isActive,
		createdAt: currency.createdAt ?? createdAt,
		updatedAt: currency.updatedAt ?? updatedAt,
		deletedAt: currency.deletedAt ?? deletedAt,
		Expense: currency.Expense ?? Expense,
		Payment: currency.Payment ?? Payment,
		PricingRule: currency.PricingRule ?? PricingRule,
		Property: currency.Property ?? Property,
		Reservation: currency.Reservation ?? Reservation,
		TaxRecord: currency.TaxRecord ?? TaxRecord,
		users: currency.users ?? users,
		$ExpenseCount: currency.$ExpenseCount ?? $ExpenseCount,
		$PaymentCount: currency.$PaymentCount ?? $PaymentCount,
		$PricingRuleCount: currency.$PricingRuleCount ?? $PricingRuleCount,
		$PropertyCount: currency.$PropertyCount ?? $PropertyCount,
		$ReservationCount: currency.$ReservationCount ?? $ReservationCount,
		$TaxRecordCount: currency.$TaxRecordCount ?? $TaxRecordCount,
		$usersCount: currency.$usersCount ?? $usersCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Currency mergeWithInstanceValues(Currency currency) {
        return Currency(
            id: currency.$assignedFields.contains('id') ? currency.id : id,
		code: currency.$assignedFields.contains('code') ? currency.code : code,
		name: currency.$assignedFields.contains('name') ? currency.name : name,
		symbol: currency.$assignedFields.contains('symbol') ? currency.symbol : symbol,
		exchangeRate: currency.$assignedFields.contains('exchangeRate') ? currency.exchangeRate : exchangeRate,
		isActive: currency.$assignedFields.contains('isActive') ? currency.isActive : isActive,
		createdAt: currency.$assignedFields.contains('createdAt') ? currency.createdAt : createdAt,
		updatedAt: currency.$assignedFields.contains('updatedAt') ? currency.updatedAt : updatedAt,
		deletedAt: currency.$assignedFields.contains('deletedAt') ? currency.deletedAt : deletedAt,
		Expense: (currency.$assignedFields.contains('Expense') && currency.Expense != null) ? mergeModelLists(Expense, currency.Expense) : Expense,
		Payment: (currency.$assignedFields.contains('Payment') && currency.Payment != null) ? mergeModelLists(Payment, currency.Payment) : Payment,
		PricingRule: (currency.$assignedFields.contains('PricingRule') && currency.PricingRule != null) ? mergeModelLists(PricingRule, currency.PricingRule) : PricingRule,
		Property: (currency.$assignedFields.contains('Property') && currency.Property != null) ? mergeModelLists(Property, currency.Property) : Property,
		Reservation: (currency.$assignedFields.contains('Reservation') && currency.Reservation != null) ? mergeModelLists(Reservation, currency.Reservation) : Reservation,
		TaxRecord: (currency.$assignedFields.contains('TaxRecord') && currency.TaxRecord != null) ? mergeModelLists(TaxRecord, currency.TaxRecord) : TaxRecord,
		users: (currency.$assignedFields.contains('users') && currency.users != null) ? mergeModelLists(users, currency.users) : users,
		$ExpenseCount: currency.$ExpenseCount ?? $ExpenseCount,
		$PaymentCount: currency.$PaymentCount ?? $PaymentCount,
		$PricingRuleCount: currency.$PricingRuleCount ?? $PricingRuleCount,
		$PropertyCount: currency.$PropertyCount ?? $PropertyCount,
		$ReservationCount: currency.$ReservationCount ?? $ReservationCount,
		$TaxRecordCount: currency.$TaxRecordCount ?? $TaxRecordCount,
		$usersCount: currency.$usersCount ?? $usersCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Currency updateWithInstanceValues(Currency currency) {
        if (currency.$assignedFields.contains('id')) { id = currency.id; }
		if (currency.$assignedFields.contains('code')) { code = currency.code; }
		if (currency.$assignedFields.contains('name')) { name = currency.name; }
		if (currency.$assignedFields.contains('symbol')) { symbol = currency.symbol; }
		if (currency.$assignedFields.contains('exchangeRate')) { exchangeRate = currency.exchangeRate; }
		if (currency.$assignedFields.contains('isActive')) { isActive = currency.isActive; }
		if (currency.$assignedFields.contains('createdAt')) { createdAt = currency.createdAt; }
		if (currency.$assignedFields.contains('updatedAt')) { updatedAt = currency.updatedAt; }
		if (currency.$assignedFields.contains('deletedAt')) { deletedAt = currency.deletedAt; }
		if (currency.$assignedFields.contains('Expense') && currency.Expense != null) { Expense = mergeModelLists(Expense, currency.Expense); }
		if (currency.$assignedFields.contains('Payment') && currency.Payment != null) { Payment = mergeModelLists(Payment, currency.Payment); }
		if (currency.$assignedFields.contains('PricingRule') && currency.PricingRule != null) { PricingRule = mergeModelLists(PricingRule, currency.PricingRule); }
		if (currency.$assignedFields.contains('Property') && currency.Property != null) { Property = mergeModelLists(Property, currency.Property); }
		if (currency.$assignedFields.contains('Reservation') && currency.Reservation != null) { Reservation = mergeModelLists(Reservation, currency.Reservation); }
		if (currency.$assignedFields.contains('TaxRecord') && currency.TaxRecord != null) { TaxRecord = mergeModelLists(TaxRecord, currency.TaxRecord); }
		if (currency.$assignedFields.contains('users') && currency.users != null) { users = mergeModelLists(users, currency.users); }
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
          ? {...?serializedTypes, 'Currency'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(code != null) 'code': code,
	if(name != null) 'name': name,
	if(symbol != null) 'symbol': symbol,
	if(exchangeRate != null) 'exchangeRate': exchangeRate,
	if(isActive != null) 'isActive': isActive,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(Expense != null && (!preventCircularSerialization || !serializedModels.contains('Expense'))) 'Expense': Expense?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Payment != null && (!preventCircularSerialization || !serializedModels.contains('Payment'))) 'Payment': Payment?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(PricingRule != null && (!preventCircularSerialization || !serializedModels.contains('PricingRule'))) 'PricingRule': PricingRule?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(Reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'Reservation': Reservation?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(TaxRecord != null && (!preventCircularSerialization || !serializedModels.contains('TaxRecord'))) 'TaxRecord': TaxRecord?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(users != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'users': users?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($ExpenseCount != null || $PaymentCount != null || $PricingRuleCount != null || $PropertyCount != null || $ReservationCount != null || $TaxRecordCount != null || $usersCount != null) '_count': { 
		if ($ExpenseCount != null) 'Expense': $ExpenseCount, 
		if ($PaymentCount != null) 'Payment': $PaymentCount, 
		if ($PricingRuleCount != null) 'PricingRule': $PricingRuleCount, 
		if ($PropertyCount != null) 'Property': $PropertyCount, 
		if ($ReservationCount != null) 'Reservation': $ReservationCount, 
		if ($TaxRecordCount != null) 'TaxRecord': $TaxRecordCount, 
		if ($usersCount != null) 'users': $usersCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Currency &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    