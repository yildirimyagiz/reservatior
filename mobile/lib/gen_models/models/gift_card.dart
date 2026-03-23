
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';


class GiftCard implements PrismaModel<String, GiftCard> , Id<String> {
    @override
String? id;
	String? code;
	String? orgId;
	double? amount;
	double? balance;
	String? currency;
	DateTime? expiresAt;
	bool? isActive;
	String? issuedTo;
	String? issuedBy;
	String? issuedFor;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    GiftCard({ this.id,
	 this.code,
	 this.orgId,
	 this.amount,
	 this.balance,
	 this.currency = "USD",
	 this.expiresAt,
	 this.isActive = true,
	 this.issuedTo,
	 this.issuedBy,
	 this.issuedFor,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<GiftCard, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"code": (m) => m.code,

	"orgId": (m) => m.orgId,

	"amount": (m) => m.amount,

	"balance": (m) => m.balance,

	"currency": (m) => m.currency,

	"expiresAt": (m) => m.expiresAt,

	"isActive": (m) => m.isActive,

	"issuedTo": (m) => m.issuedTo,

	"issuedBy": (m) => m.issuedBy,

	"issuedFor": (m) => m.issuedFor,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(GiftCard) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in GiftCard');
    }
    return propFunction as V? Function(GiftCard);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory GiftCard.fromJson(JsonMap json) =>
      GiftCard(
        id: json['id'] as String?,
	code: json['code'] as String?,
	orgId: json['orgId'] as String?,
	amount: json['amount'] as double?,
	balance: json['balance'] as double?,
	currency: json['currency'] as String?,
	expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
	isActive: json['isActive'] as bool?,
	issuedTo: json['issuedTo'] as String?,
	issuedBy: json['issuedBy'] as String?,
	issuedFor: json['issuedFor'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    GiftCard copyWith({
        Value<String?>? id,
		Value<String?>? code,
		Value<String?>? orgId,
		Value<double?>? amount,
		Value<double?>? balance,
		Value<String?>? currency,
		Value<DateTime?>? expiresAt,
		Value<bool?>? isActive,
		Value<String?>? issuedTo,
		Value<String?>? issuedBy,
		Value<String?>? issuedFor,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
        }) {
        return GiftCard(
            id: id != null ? id.value : this.id,
		code: code != null ? code.value : this.code,
		orgId: orgId != null ? orgId.value : this.orgId,
		amount: amount != null ? amount.value : this.amount,
		balance: balance != null ? balance.value : this.balance,
		currency: currency != null ? currency.value : this.currency,
		expiresAt: expiresAt != null ? expiresAt.value : this.expiresAt,
		isActive: isActive != null ? isActive.value : this.isActive,
		issuedTo: issuedTo != null ? issuedTo.value : this.issuedTo,
		issuedBy: issuedBy != null ? issuedBy.value : this.issuedBy,
		issuedFor: issuedFor != null ? issuedFor.value : this.issuedFor,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    GiftCard copyWithInstanceValues(GiftCard giftCard) {
        return GiftCard(
            id: giftCard.id ?? id,
		code: giftCard.code ?? code,
		orgId: giftCard.orgId ?? orgId,
		amount: giftCard.amount ?? amount,
		balance: giftCard.balance ?? balance,
		currency: giftCard.currency ?? currency,
		expiresAt: giftCard.expiresAt ?? expiresAt,
		isActive: giftCard.isActive ?? isActive,
		issuedTo: giftCard.issuedTo ?? issuedTo,
		issuedBy: giftCard.issuedBy ?? issuedBy,
		issuedFor: giftCard.issuedFor ?? issuedFor,
		createdAt: giftCard.createdAt ?? createdAt,
		updatedAt: giftCard.updatedAt ?? updatedAt,
		org: giftCard.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    GiftCard mergeWithInstanceValues(GiftCard giftCard) {
        return GiftCard(
            id: giftCard.$assignedFields.contains('id') ? giftCard.id : id,
		code: giftCard.$assignedFields.contains('code') ? giftCard.code : code,
		orgId: giftCard.$assignedFields.contains('orgId') ? giftCard.orgId : orgId,
		amount: giftCard.$assignedFields.contains('amount') ? giftCard.amount : amount,
		balance: giftCard.$assignedFields.contains('balance') ? giftCard.balance : balance,
		currency: giftCard.$assignedFields.contains('currency') ? giftCard.currency : currency,
		expiresAt: giftCard.$assignedFields.contains('expiresAt') ? giftCard.expiresAt : expiresAt,
		isActive: giftCard.$assignedFields.contains('isActive') ? giftCard.isActive : isActive,
		issuedTo: giftCard.$assignedFields.contains('issuedTo') ? giftCard.issuedTo : issuedTo,
		issuedBy: giftCard.$assignedFields.contains('issuedBy') ? giftCard.issuedBy : issuedBy,
		issuedFor: giftCard.$assignedFields.contains('issuedFor') ? giftCard.issuedFor : issuedFor,
		createdAt: giftCard.$assignedFields.contains('createdAt') ? giftCard.createdAt : createdAt,
		updatedAt: giftCard.$assignedFields.contains('updatedAt') ? giftCard.updatedAt : updatedAt,
		org: giftCard.$assignedFields.contains('org') ? giftCard.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    GiftCard updateWithInstanceValues(GiftCard giftCard) {
        if (giftCard.$assignedFields.contains('id')) { id = giftCard.id; }
		if (giftCard.$assignedFields.contains('code')) { code = giftCard.code; }
		if (giftCard.$assignedFields.contains('orgId')) { orgId = giftCard.orgId; }
		if (giftCard.$assignedFields.contains('amount')) { amount = giftCard.amount; }
		if (giftCard.$assignedFields.contains('balance')) { balance = giftCard.balance; }
		if (giftCard.$assignedFields.contains('currency')) { currency = giftCard.currency; }
		if (giftCard.$assignedFields.contains('expiresAt')) { expiresAt = giftCard.expiresAt; }
		if (giftCard.$assignedFields.contains('isActive')) { isActive = giftCard.isActive; }
		if (giftCard.$assignedFields.contains('issuedTo')) { issuedTo = giftCard.issuedTo; }
		if (giftCard.$assignedFields.contains('issuedBy')) { issuedBy = giftCard.issuedBy; }
		if (giftCard.$assignedFields.contains('issuedFor')) { issuedFor = giftCard.issuedFor; }
		if (giftCard.$assignedFields.contains('createdAt')) { createdAt = giftCard.createdAt; }
		if (giftCard.$assignedFields.contains('updatedAt')) { updatedAt = giftCard.updatedAt; }
		if (giftCard.$assignedFields.contains('org')) { org = giftCard.org; }
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
          ? {...?serializedTypes, 'GiftCard'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(code != null) 'code': code,
	if(orgId != null) 'orgId': orgId,
	if(amount != null) 'amount': amount,
	if(balance != null) 'balance': balance,
	if(currency != null) 'currency': currency,
	if(expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
	if(isActive != null) 'isActive': isActive,
	if(issuedTo != null) 'issuedTo': issuedTo,
	if(issuedBy != null) 'issuedBy': issuedBy,
	if(issuedFor != null) 'issuedFor': issuedFor,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is GiftCard &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    