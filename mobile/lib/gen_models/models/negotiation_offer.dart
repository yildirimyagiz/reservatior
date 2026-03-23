
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'negotiation_party.dart';
import 'negotiation_offer_status.dart';
import 'payment_negotiation.dart';
import 'organization.dart';


class NegotiationOffer implements PrismaModel<String, NegotiationOffer> , Id<String> {
    @override
String? id;
	String? orgId;
	String? negotiationId;
	NegotiationParty? offeredBy;
	int? installmentCount;
	double? firstPaymentPct;
	double? totalAmount;
	String? currency;
	String? notes;
	NegotiationOfferStatus? status;
	DateTime? offeredAt;
	DateTime? expiresAt;
	DateTime? respondedAt;
	PaymentNegotiation? negotiation;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    NegotiationOffer({ this.id,
	 this.orgId,
	 this.negotiationId,
	 this.offeredBy,
	 this.installmentCount,
	 this.firstPaymentPct,
	 this.totalAmount,
	 this.currency = "USD",
	 this.notes,
	 this.status = NegotiationOfferStatus.PENDING,
	 this.offeredAt,
	 this.expiresAt,
	 this.respondedAt,
	 this.negotiation,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<NegotiationOffer, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"negotiationId": (m) => m.negotiationId,

	"offeredBy": (m) => m.offeredBy,

	"installmentCount": (m) => m.installmentCount,

	"firstPaymentPct": (m) => m.firstPaymentPct,

	"totalAmount": (m) => m.totalAmount,

	"currency": (m) => m.currency,

	"notes": (m) => m.notes,

	"status": (m) => m.status,

	"offeredAt": (m) => m.offeredAt,

	"expiresAt": (m) => m.expiresAt,

	"respondedAt": (m) => m.respondedAt,

	"negotiation": (m) => m.negotiation,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(NegotiationOffer) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in NegotiationOffer');
    }
    return propFunction as V? Function(NegotiationOffer);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory NegotiationOffer.fromJson(JsonMap json) =>
      NegotiationOffer(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	negotiationId: json['negotiationId'] as String?,
	offeredBy: json['offeredBy'] != null ? NegotiationParty.fromJson(json['offeredBy']) : null,
	installmentCount: int.tryParse(json['installmentCount'].toString()),
	firstPaymentPct: json['firstPaymentPct']?.toDouble(),
	totalAmount: json['totalAmount'] as double?,
	currency: json['currency'] as String?,
	notes: json['notes'] as String?,
	status: json['status'] != null ? NegotiationOfferStatus.fromJson(json['status']) : null,
	offeredAt: json['offeredAt'] != null ? DateTime.parse(json['offeredAt']) : null,
	expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
	respondedAt: json['respondedAt'] != null ? DateTime.parse(json['respondedAt']) : null,
	negotiation: json['negotiation'] != null ? PaymentNegotiation.fromJson(json['negotiation'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    NegotiationOffer copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? negotiationId,
		Value<NegotiationParty?>? offeredBy,
		Value<int?>? installmentCount,
		Value<double?>? firstPaymentPct,
		Value<double?>? totalAmount,
		Value<String?>? currency,
		Value<String?>? notes,
		Value<NegotiationOfferStatus?>? status,
		Value<DateTime?>? offeredAt,
		Value<DateTime?>? expiresAt,
		Value<DateTime?>? respondedAt,
		Value<PaymentNegotiation?>? negotiation,
		Value<Organization?>? org,
        }) {
        return NegotiationOffer(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		negotiationId: negotiationId != null ? negotiationId.value : this.negotiationId,
		offeredBy: offeredBy != null ? offeredBy.value : this.offeredBy,
		installmentCount: installmentCount != null ? installmentCount.value : this.installmentCount,
		firstPaymentPct: firstPaymentPct != null ? firstPaymentPct.value : this.firstPaymentPct,
		totalAmount: totalAmount != null ? totalAmount.value : this.totalAmount,
		currency: currency != null ? currency.value : this.currency,
		notes: notes != null ? notes.value : this.notes,
		status: status != null ? status.value : this.status,
		offeredAt: offeredAt != null ? offeredAt.value : this.offeredAt,
		expiresAt: expiresAt != null ? expiresAt.value : this.expiresAt,
		respondedAt: respondedAt != null ? respondedAt.value : this.respondedAt,
		negotiation: negotiation != null ? negotiation.value : this.negotiation,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    NegotiationOffer copyWithInstanceValues(NegotiationOffer negotiationOffer) {
        return NegotiationOffer(
            id: negotiationOffer.id ?? id,
		orgId: negotiationOffer.orgId ?? orgId,
		negotiationId: negotiationOffer.negotiationId ?? negotiationId,
		offeredBy: negotiationOffer.offeredBy ?? offeredBy,
		installmentCount: negotiationOffer.installmentCount ?? installmentCount,
		firstPaymentPct: negotiationOffer.firstPaymentPct ?? firstPaymentPct,
		totalAmount: negotiationOffer.totalAmount ?? totalAmount,
		currency: negotiationOffer.currency ?? currency,
		notes: negotiationOffer.notes ?? notes,
		status: negotiationOffer.status ?? status,
		offeredAt: negotiationOffer.offeredAt ?? offeredAt,
		expiresAt: negotiationOffer.expiresAt ?? expiresAt,
		respondedAt: negotiationOffer.respondedAt ?? respondedAt,
		negotiation: negotiationOffer.negotiation ?? negotiation,
		org: negotiationOffer.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    NegotiationOffer mergeWithInstanceValues(NegotiationOffer negotiationOffer) {
        return NegotiationOffer(
            id: negotiationOffer.$assignedFields.contains('id') ? negotiationOffer.id : id,
		orgId: negotiationOffer.$assignedFields.contains('orgId') ? negotiationOffer.orgId : orgId,
		negotiationId: negotiationOffer.$assignedFields.contains('negotiationId') ? negotiationOffer.negotiationId : negotiationId,
		offeredBy: negotiationOffer.$assignedFields.contains('offeredBy') ? negotiationOffer.offeredBy : offeredBy,
		installmentCount: negotiationOffer.$assignedFields.contains('installmentCount') ? negotiationOffer.installmentCount : installmentCount,
		firstPaymentPct: negotiationOffer.$assignedFields.contains('firstPaymentPct') ? negotiationOffer.firstPaymentPct : firstPaymentPct,
		totalAmount: negotiationOffer.$assignedFields.contains('totalAmount') ? negotiationOffer.totalAmount : totalAmount,
		currency: negotiationOffer.$assignedFields.contains('currency') ? negotiationOffer.currency : currency,
		notes: negotiationOffer.$assignedFields.contains('notes') ? negotiationOffer.notes : notes,
		status: negotiationOffer.$assignedFields.contains('status') ? negotiationOffer.status : status,
		offeredAt: negotiationOffer.$assignedFields.contains('offeredAt') ? negotiationOffer.offeredAt : offeredAt,
		expiresAt: negotiationOffer.$assignedFields.contains('expiresAt') ? negotiationOffer.expiresAt : expiresAt,
		respondedAt: negotiationOffer.$assignedFields.contains('respondedAt') ? negotiationOffer.respondedAt : respondedAt,
		negotiation: negotiationOffer.$assignedFields.contains('negotiation') ? negotiationOffer.negotiation : negotiation,
		org: negotiationOffer.$assignedFields.contains('org') ? negotiationOffer.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    NegotiationOffer updateWithInstanceValues(NegotiationOffer negotiationOffer) {
        if (negotiationOffer.$assignedFields.contains('id')) { id = negotiationOffer.id; }
		if (negotiationOffer.$assignedFields.contains('orgId')) { orgId = negotiationOffer.orgId; }
		if (negotiationOffer.$assignedFields.contains('negotiationId')) { negotiationId = negotiationOffer.negotiationId; }
		if (negotiationOffer.$assignedFields.contains('offeredBy')) { offeredBy = negotiationOffer.offeredBy; }
		if (negotiationOffer.$assignedFields.contains('installmentCount')) { installmentCount = negotiationOffer.installmentCount; }
		if (negotiationOffer.$assignedFields.contains('firstPaymentPct')) { firstPaymentPct = negotiationOffer.firstPaymentPct; }
		if (negotiationOffer.$assignedFields.contains('totalAmount')) { totalAmount = negotiationOffer.totalAmount; }
		if (negotiationOffer.$assignedFields.contains('currency')) { currency = negotiationOffer.currency; }
		if (negotiationOffer.$assignedFields.contains('notes')) { notes = negotiationOffer.notes; }
		if (negotiationOffer.$assignedFields.contains('status')) { status = negotiationOffer.status; }
		if (negotiationOffer.$assignedFields.contains('offeredAt')) { offeredAt = negotiationOffer.offeredAt; }
		if (negotiationOffer.$assignedFields.contains('expiresAt')) { expiresAt = negotiationOffer.expiresAt; }
		if (negotiationOffer.$assignedFields.contains('respondedAt')) { respondedAt = negotiationOffer.respondedAt; }
		if (negotiationOffer.$assignedFields.contains('negotiation')) { negotiation = negotiationOffer.negotiation; }
		if (negotiationOffer.$assignedFields.contains('org')) { org = negotiationOffer.org; }
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
          ? {...?serializedTypes, 'NegotiationOffer'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(negotiationId != null) 'negotiationId': negotiationId,
	if(offeredBy != null) 'offeredBy': offeredBy?.toJson(),
	if(installmentCount != null) 'installmentCount': installmentCount,
	if(firstPaymentPct != null) 'firstPaymentPct': firstPaymentPct,
	if(totalAmount != null) 'totalAmount': totalAmount,
	if(currency != null) 'currency': currency,
	if(notes != null) 'notes': notes,
	if(status != null) 'status': status?.toJson(),
	if(offeredAt != null) 'offeredAt': offeredAt?.toIso8601String(),
	if(expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
	if(respondedAt != null) 'respondedAt': respondedAt?.toIso8601String(),
	if(negotiation != null && (!preventCircularSerialization || !serializedModels.contains('PaymentNegotiation'))) 'negotiation': negotiation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is NegotiationOffer &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    