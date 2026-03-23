
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'social_impact_type.dart';
import 'social_impact_counter.dart';
import 'organization.dart';


class SocialImpactRecord implements PrismaModel<String, SocialImpactRecord> , Id<String> {
    @override
String? id;
	String? orgId;
	String? counterId;
	String? reservationId;
	SocialImpactType? impactType;
	int? quantity;
	double? amount;
	String? currency;
	String? description;
	DateTime? verifiedAt;
	String? verifiedBy;
	String? proofUrl;
	DateTime? deletedAt;
	DateTime? createdAt;
	SocialImpactCounter? counter;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    SocialImpactRecord({ this.id,
	 this.orgId,
	 this.counterId,
	 this.reservationId,
	 this.impactType,
	 this.quantity = 1,
	 this.amount,
	 this.currency = "USD",
	 this.description,
	 this.verifiedAt,
	 this.verifiedBy,
	 this.proofUrl,
	 this.deletedAt,
	 this.createdAt,
	 this.counter,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<SocialImpactRecord, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"counterId": (m) => m.counterId,

	"reservationId": (m) => m.reservationId,

	"impactType": (m) => m.impactType,

	"quantity": (m) => m.quantity,

	"amount": (m) => m.amount,

	"currency": (m) => m.currency,

	"description": (m) => m.description,

	"verifiedAt": (m) => m.verifiedAt,

	"verifiedBy": (m) => m.verifiedBy,

	"proofUrl": (m) => m.proofUrl,

	"deletedAt": (m) => m.deletedAt,

	"createdAt": (m) => m.createdAt,

	"counter": (m) => m.counter,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(SocialImpactRecord) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in SocialImpactRecord');
    }
    return propFunction as V? Function(SocialImpactRecord);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory SocialImpactRecord.fromJson(JsonMap json) =>
      SocialImpactRecord(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	counterId: json['counterId'] as String?,
	reservationId: json['reservationId'] as String?,
	impactType: json['impactType'] != null ? SocialImpactType.fromJson(json['impactType']) : null,
	quantity: int.tryParse(json['quantity'].toString()),
	amount: json['amount'] as double?,
	currency: json['currency'] as String?,
	description: json['description'] as String?,
	verifiedAt: json['verifiedAt'] != null ? DateTime.parse(json['verifiedAt']) : null,
	verifiedBy: json['verifiedBy'] as String?,
	proofUrl: json['proofUrl'] as String?,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	counter: json['counter'] != null ? SocialImpactCounter.fromJson(json['counter'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    SocialImpactRecord copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? counterId,
		Value<String?>? reservationId,
		Value<SocialImpactType?>? impactType,
		Value<int?>? quantity,
		Value<double?>? amount,
		Value<String?>? currency,
		Value<String?>? description,
		Value<DateTime?>? verifiedAt,
		Value<String?>? verifiedBy,
		Value<String?>? proofUrl,
		Value<DateTime?>? deletedAt,
		Value<DateTime?>? createdAt,
		Value<SocialImpactCounter?>? counter,
		Value<Organization?>? org,
        }) {
        return SocialImpactRecord(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		counterId: counterId != null ? counterId.value : this.counterId,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		impactType: impactType != null ? impactType.value : this.impactType,
		quantity: quantity != null ? quantity.value : this.quantity,
		amount: amount != null ? amount.value : this.amount,
		currency: currency != null ? currency.value : this.currency,
		description: description != null ? description.value : this.description,
		verifiedAt: verifiedAt != null ? verifiedAt.value : this.verifiedAt,
		verifiedBy: verifiedBy != null ? verifiedBy.value : this.verifiedBy,
		proofUrl: proofUrl != null ? proofUrl.value : this.proofUrl,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		counter: counter != null ? counter.value : this.counter,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    SocialImpactRecord copyWithInstanceValues(SocialImpactRecord socialImpactRecord) {
        return SocialImpactRecord(
            id: socialImpactRecord.id ?? id,
		orgId: socialImpactRecord.orgId ?? orgId,
		counterId: socialImpactRecord.counterId ?? counterId,
		reservationId: socialImpactRecord.reservationId ?? reservationId,
		impactType: socialImpactRecord.impactType ?? impactType,
		quantity: socialImpactRecord.quantity ?? quantity,
		amount: socialImpactRecord.amount ?? amount,
		currency: socialImpactRecord.currency ?? currency,
		description: socialImpactRecord.description ?? description,
		verifiedAt: socialImpactRecord.verifiedAt ?? verifiedAt,
		verifiedBy: socialImpactRecord.verifiedBy ?? verifiedBy,
		proofUrl: socialImpactRecord.proofUrl ?? proofUrl,
		deletedAt: socialImpactRecord.deletedAt ?? deletedAt,
		createdAt: socialImpactRecord.createdAt ?? createdAt,
		counter: socialImpactRecord.counter ?? counter,
		org: socialImpactRecord.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    SocialImpactRecord mergeWithInstanceValues(SocialImpactRecord socialImpactRecord) {
        return SocialImpactRecord(
            id: socialImpactRecord.$assignedFields.contains('id') ? socialImpactRecord.id : id,
		orgId: socialImpactRecord.$assignedFields.contains('orgId') ? socialImpactRecord.orgId : orgId,
		counterId: socialImpactRecord.$assignedFields.contains('counterId') ? socialImpactRecord.counterId : counterId,
		reservationId: socialImpactRecord.$assignedFields.contains('reservationId') ? socialImpactRecord.reservationId : reservationId,
		impactType: socialImpactRecord.$assignedFields.contains('impactType') ? socialImpactRecord.impactType : impactType,
		quantity: socialImpactRecord.$assignedFields.contains('quantity') ? socialImpactRecord.quantity : quantity,
		amount: socialImpactRecord.$assignedFields.contains('amount') ? socialImpactRecord.amount : amount,
		currency: socialImpactRecord.$assignedFields.contains('currency') ? socialImpactRecord.currency : currency,
		description: socialImpactRecord.$assignedFields.contains('description') ? socialImpactRecord.description : description,
		verifiedAt: socialImpactRecord.$assignedFields.contains('verifiedAt') ? socialImpactRecord.verifiedAt : verifiedAt,
		verifiedBy: socialImpactRecord.$assignedFields.contains('verifiedBy') ? socialImpactRecord.verifiedBy : verifiedBy,
		proofUrl: socialImpactRecord.$assignedFields.contains('proofUrl') ? socialImpactRecord.proofUrl : proofUrl,
		deletedAt: socialImpactRecord.$assignedFields.contains('deletedAt') ? socialImpactRecord.deletedAt : deletedAt,
		createdAt: socialImpactRecord.$assignedFields.contains('createdAt') ? socialImpactRecord.createdAt : createdAt,
		counter: socialImpactRecord.$assignedFields.contains('counter') ? socialImpactRecord.counter : counter,
		org: socialImpactRecord.$assignedFields.contains('org') ? socialImpactRecord.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    SocialImpactRecord updateWithInstanceValues(SocialImpactRecord socialImpactRecord) {
        if (socialImpactRecord.$assignedFields.contains('id')) { id = socialImpactRecord.id; }
		if (socialImpactRecord.$assignedFields.contains('orgId')) { orgId = socialImpactRecord.orgId; }
		if (socialImpactRecord.$assignedFields.contains('counterId')) { counterId = socialImpactRecord.counterId; }
		if (socialImpactRecord.$assignedFields.contains('reservationId')) { reservationId = socialImpactRecord.reservationId; }
		if (socialImpactRecord.$assignedFields.contains('impactType')) { impactType = socialImpactRecord.impactType; }
		if (socialImpactRecord.$assignedFields.contains('quantity')) { quantity = socialImpactRecord.quantity; }
		if (socialImpactRecord.$assignedFields.contains('amount')) { amount = socialImpactRecord.amount; }
		if (socialImpactRecord.$assignedFields.contains('currency')) { currency = socialImpactRecord.currency; }
		if (socialImpactRecord.$assignedFields.contains('description')) { description = socialImpactRecord.description; }
		if (socialImpactRecord.$assignedFields.contains('verifiedAt')) { verifiedAt = socialImpactRecord.verifiedAt; }
		if (socialImpactRecord.$assignedFields.contains('verifiedBy')) { verifiedBy = socialImpactRecord.verifiedBy; }
		if (socialImpactRecord.$assignedFields.contains('proofUrl')) { proofUrl = socialImpactRecord.proofUrl; }
		if (socialImpactRecord.$assignedFields.contains('deletedAt')) { deletedAt = socialImpactRecord.deletedAt; }
		if (socialImpactRecord.$assignedFields.contains('createdAt')) { createdAt = socialImpactRecord.createdAt; }
		if (socialImpactRecord.$assignedFields.contains('counter')) { counter = socialImpactRecord.counter; }
		if (socialImpactRecord.$assignedFields.contains('org')) { org = socialImpactRecord.org; }
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
          ? {...?serializedTypes, 'SocialImpactRecord'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(counterId != null) 'counterId': counterId,
	if(reservationId != null) 'reservationId': reservationId,
	if(impactType != null) 'impactType': impactType?.toJson(),
	if(quantity != null) 'quantity': quantity,
	if(amount != null) 'amount': amount,
	if(currency != null) 'currency': currency,
	if(description != null) 'description': description,
	if(verifiedAt != null) 'verifiedAt': verifiedAt?.toIso8601String(),
	if(verifiedBy != null) 'verifiedBy': verifiedBy,
	if(proofUrl != null) 'proofUrl': proofUrl,
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(counter != null && (!preventCircularSerialization || !serializedModels.contains('SocialImpactCounter'))) 'counter': counter?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is SocialImpactRecord &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    