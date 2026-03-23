
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'payment_negotiation_status.dart';
import 'organization.dart';
import 'reservation.dart';
import 'negotiation_offer.dart';
import 'payment_installment.dart';


class PaymentNegotiation implements PrismaModel<String, PaymentNegotiation> , Id<String> {
    @override
String? id;
	String? orgId;
	String? reservationId;
	String? tenantContactId;
	String? ownerContactId;
	String? ownerUserId;
	PaymentNegotiationStatus? status;
	int? maxInstallments;
	double? minFirstPaymentPct;
	bool? platformValidated;
	String? validationNotes;
	String? agreedOfferId;
	DateTime? agreedAt;
	DateTime? expiresAt;
	DateTime? reminderSentAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	Reservation? reservation;
	List<NegotiationOffer>? offers;
	List<PaymentInstallment>? installments;
	int? $offersCount;
	int? $installmentsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PaymentNegotiation({ this.id,
	 this.orgId,
	 this.reservationId,
	 this.tenantContactId,
	 this.ownerContactId,
	 this.ownerUserId,
	 this.status = PaymentNegotiationStatus.NEGOTIATING,
	 this.maxInstallments = 6,
	 this.minFirstPaymentPct = 0.3,
	 this.platformValidated = false,
	 this.validationNotes,
	 this.agreedOfferId,
	 this.agreedAt,
	 this.expiresAt,
	 this.reminderSentAt,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.reservation,
	 this.offers,
	 this.installments,
	this.$offersCount,
	this.$installmentsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PaymentNegotiation, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"reservationId": (m) => m.reservationId,

	"tenantContactId": (m) => m.tenantContactId,

	"ownerContactId": (m) => m.ownerContactId,

	"ownerUserId": (m) => m.ownerUserId,

	"status": (m) => m.status,

	"maxInstallments": (m) => m.maxInstallments,

	"minFirstPaymentPct": (m) => m.minFirstPaymentPct,

	"platformValidated": (m) => m.platformValidated,

	"validationNotes": (m) => m.validationNotes,

	"agreedOfferId": (m) => m.agreedOfferId,

	"agreedAt": (m) => m.agreedAt,

	"expiresAt": (m) => m.expiresAt,

	"reminderSentAt": (m) => m.reminderSentAt,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"reservation": (m) => m.reservation,

	"offers": (m) => m.offers,

	"installments": (m) => m.installments,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PaymentNegotiation) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PaymentNegotiation');
    }
    return propFunction as V? Function(PaymentNegotiation);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PaymentNegotiation.fromJson(JsonMap json) =>
      PaymentNegotiation(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	reservationId: json['reservationId'] as String?,
	tenantContactId: json['tenantContactId'] as String?,
	ownerContactId: json['ownerContactId'] as String?,
	ownerUserId: json['ownerUserId'] as String?,
	status: json['status'] != null ? PaymentNegotiationStatus.fromJson(json['status']) : null,
	maxInstallments: int.tryParse(json['maxInstallments'].toString()),
	minFirstPaymentPct: json['minFirstPaymentPct']?.toDouble(),
	platformValidated: json['platformValidated'] as bool?,
	validationNotes: json['validationNotes'] as String?,
	agreedOfferId: json['agreedOfferId'] as String?,
	agreedAt: json['agreedAt'] != null ? DateTime.parse(json['agreedAt']) : null,
	expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
	reminderSentAt: json['reminderSentAt'] != null ? DateTime.parse(json['reminderSentAt']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	reservation: json['reservation'] != null ? Reservation.fromJson(json['reservation'] as JsonMap) : null,
	offers: json['offers'] != null ? createModels<NegotiationOffer>((json['offers'] as List).cast<JsonMap>(), NegotiationOffer.fromJson) : null,
	installments: json['installments'] != null ? createModels<PaymentInstallment>((json['installments'] as List).cast<JsonMap>(), PaymentInstallment.fromJson) : null,
	$offersCount: json['_count']?['offers'] as int?,
	$installmentsCount: json['_count']?['installments'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PaymentNegotiation copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? reservationId,
		Value<String?>? tenantContactId,
		Value<String?>? ownerContactId,
		Value<String?>? ownerUserId,
		Value<PaymentNegotiationStatus?>? status,
		Value<int?>? maxInstallments,
		Value<double?>? minFirstPaymentPct,
		Value<bool?>? platformValidated,
		Value<String?>? validationNotes,
		Value<String?>? agreedOfferId,
		Value<DateTime?>? agreedAt,
		Value<DateTime?>? expiresAt,
		Value<DateTime?>? reminderSentAt,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<Reservation?>? reservation,
		Value<List<NegotiationOffer>?>? offers,
		Value<List<PaymentInstallment>?>? installments,
		int? $offersCount,
		int? $installmentsCount,
        }) {
        return PaymentNegotiation(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		reservationId: reservationId != null ? reservationId.value : this.reservationId,
		tenantContactId: tenantContactId != null ? tenantContactId.value : this.tenantContactId,
		ownerContactId: ownerContactId != null ? ownerContactId.value : this.ownerContactId,
		ownerUserId: ownerUserId != null ? ownerUserId.value : this.ownerUserId,
		status: status != null ? status.value : this.status,
		maxInstallments: maxInstallments != null ? maxInstallments.value : this.maxInstallments,
		minFirstPaymentPct: minFirstPaymentPct != null ? minFirstPaymentPct.value : this.minFirstPaymentPct,
		platformValidated: platformValidated != null ? platformValidated.value : this.platformValidated,
		validationNotes: validationNotes != null ? validationNotes.value : this.validationNotes,
		agreedOfferId: agreedOfferId != null ? agreedOfferId.value : this.agreedOfferId,
		agreedAt: agreedAt != null ? agreedAt.value : this.agreedAt,
		expiresAt: expiresAt != null ? expiresAt.value : this.expiresAt,
		reminderSentAt: reminderSentAt != null ? reminderSentAt.value : this.reminderSentAt,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		reservation: reservation != null ? reservation.value : this.reservation,
		offers: offers != null ? offers.value : this.offers,
		installments: installments != null ? installments.value : this.installments,
		$offersCount: $offersCount ?? this.$offersCount,
		$installmentsCount: $installmentsCount ?? this.$installmentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PaymentNegotiation copyWithInstanceValues(PaymentNegotiation paymentNegotiation) {
        return PaymentNegotiation(
            id: paymentNegotiation.id ?? id,
		orgId: paymentNegotiation.orgId ?? orgId,
		reservationId: paymentNegotiation.reservationId ?? reservationId,
		tenantContactId: paymentNegotiation.tenantContactId ?? tenantContactId,
		ownerContactId: paymentNegotiation.ownerContactId ?? ownerContactId,
		ownerUserId: paymentNegotiation.ownerUserId ?? ownerUserId,
		status: paymentNegotiation.status ?? status,
		maxInstallments: paymentNegotiation.maxInstallments ?? maxInstallments,
		minFirstPaymentPct: paymentNegotiation.minFirstPaymentPct ?? minFirstPaymentPct,
		platformValidated: paymentNegotiation.platformValidated ?? platformValidated,
		validationNotes: paymentNegotiation.validationNotes ?? validationNotes,
		agreedOfferId: paymentNegotiation.agreedOfferId ?? agreedOfferId,
		agreedAt: paymentNegotiation.agreedAt ?? agreedAt,
		expiresAt: paymentNegotiation.expiresAt ?? expiresAt,
		reminderSentAt: paymentNegotiation.reminderSentAt ?? reminderSentAt,
		createdAt: paymentNegotiation.createdAt ?? createdAt,
		updatedAt: paymentNegotiation.updatedAt ?? updatedAt,
		deletedAt: paymentNegotiation.deletedAt ?? deletedAt,
		org: paymentNegotiation.org ?? org,
		reservation: paymentNegotiation.reservation ?? reservation,
		offers: paymentNegotiation.offers ?? offers,
		installments: paymentNegotiation.installments ?? installments,
		$offersCount: paymentNegotiation.$offersCount ?? $offersCount,
		$installmentsCount: paymentNegotiation.$installmentsCount ?? $installmentsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PaymentNegotiation mergeWithInstanceValues(PaymentNegotiation paymentNegotiation) {
        return PaymentNegotiation(
            id: paymentNegotiation.$assignedFields.contains('id') ? paymentNegotiation.id : id,
		orgId: paymentNegotiation.$assignedFields.contains('orgId') ? paymentNegotiation.orgId : orgId,
		reservationId: paymentNegotiation.$assignedFields.contains('reservationId') ? paymentNegotiation.reservationId : reservationId,
		tenantContactId: paymentNegotiation.$assignedFields.contains('tenantContactId') ? paymentNegotiation.tenantContactId : tenantContactId,
		ownerContactId: paymentNegotiation.$assignedFields.contains('ownerContactId') ? paymentNegotiation.ownerContactId : ownerContactId,
		ownerUserId: paymentNegotiation.$assignedFields.contains('ownerUserId') ? paymentNegotiation.ownerUserId : ownerUserId,
		status: paymentNegotiation.$assignedFields.contains('status') ? paymentNegotiation.status : status,
		maxInstallments: paymentNegotiation.$assignedFields.contains('maxInstallments') ? paymentNegotiation.maxInstallments : maxInstallments,
		minFirstPaymentPct: paymentNegotiation.$assignedFields.contains('minFirstPaymentPct') ? paymentNegotiation.minFirstPaymentPct : minFirstPaymentPct,
		platformValidated: paymentNegotiation.$assignedFields.contains('platformValidated') ? paymentNegotiation.platformValidated : platformValidated,
		validationNotes: paymentNegotiation.$assignedFields.contains('validationNotes') ? paymentNegotiation.validationNotes : validationNotes,
		agreedOfferId: paymentNegotiation.$assignedFields.contains('agreedOfferId') ? paymentNegotiation.agreedOfferId : agreedOfferId,
		agreedAt: paymentNegotiation.$assignedFields.contains('agreedAt') ? paymentNegotiation.agreedAt : agreedAt,
		expiresAt: paymentNegotiation.$assignedFields.contains('expiresAt') ? paymentNegotiation.expiresAt : expiresAt,
		reminderSentAt: paymentNegotiation.$assignedFields.contains('reminderSentAt') ? paymentNegotiation.reminderSentAt : reminderSentAt,
		createdAt: paymentNegotiation.$assignedFields.contains('createdAt') ? paymentNegotiation.createdAt : createdAt,
		updatedAt: paymentNegotiation.$assignedFields.contains('updatedAt') ? paymentNegotiation.updatedAt : updatedAt,
		deletedAt: paymentNegotiation.$assignedFields.contains('deletedAt') ? paymentNegotiation.deletedAt : deletedAt,
		org: paymentNegotiation.$assignedFields.contains('org') ? paymentNegotiation.org : org,
		reservation: paymentNegotiation.$assignedFields.contains('reservation') ? paymentNegotiation.reservation : reservation,
		offers: (paymentNegotiation.$assignedFields.contains('offers') && paymentNegotiation.offers != null) ? mergeModelLists(offers, paymentNegotiation.offers) : offers,
		installments: (paymentNegotiation.$assignedFields.contains('installments') && paymentNegotiation.installments != null) ? mergeModelLists(installments, paymentNegotiation.installments) : installments,
		$offersCount: paymentNegotiation.$offersCount ?? $offersCount,
		$installmentsCount: paymentNegotiation.$installmentsCount ?? $installmentsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PaymentNegotiation updateWithInstanceValues(PaymentNegotiation paymentNegotiation) {
        if (paymentNegotiation.$assignedFields.contains('id')) { id = paymentNegotiation.id; }
		if (paymentNegotiation.$assignedFields.contains('orgId')) { orgId = paymentNegotiation.orgId; }
		if (paymentNegotiation.$assignedFields.contains('reservationId')) { reservationId = paymentNegotiation.reservationId; }
		if (paymentNegotiation.$assignedFields.contains('tenantContactId')) { tenantContactId = paymentNegotiation.tenantContactId; }
		if (paymentNegotiation.$assignedFields.contains('ownerContactId')) { ownerContactId = paymentNegotiation.ownerContactId; }
		if (paymentNegotiation.$assignedFields.contains('ownerUserId')) { ownerUserId = paymentNegotiation.ownerUserId; }
		if (paymentNegotiation.$assignedFields.contains('status')) { status = paymentNegotiation.status; }
		if (paymentNegotiation.$assignedFields.contains('maxInstallments')) { maxInstallments = paymentNegotiation.maxInstallments; }
		if (paymentNegotiation.$assignedFields.contains('minFirstPaymentPct')) { minFirstPaymentPct = paymentNegotiation.minFirstPaymentPct; }
		if (paymentNegotiation.$assignedFields.contains('platformValidated')) { platformValidated = paymentNegotiation.platformValidated; }
		if (paymentNegotiation.$assignedFields.contains('validationNotes')) { validationNotes = paymentNegotiation.validationNotes; }
		if (paymentNegotiation.$assignedFields.contains('agreedOfferId')) { agreedOfferId = paymentNegotiation.agreedOfferId; }
		if (paymentNegotiation.$assignedFields.contains('agreedAt')) { agreedAt = paymentNegotiation.agreedAt; }
		if (paymentNegotiation.$assignedFields.contains('expiresAt')) { expiresAt = paymentNegotiation.expiresAt; }
		if (paymentNegotiation.$assignedFields.contains('reminderSentAt')) { reminderSentAt = paymentNegotiation.reminderSentAt; }
		if (paymentNegotiation.$assignedFields.contains('createdAt')) { createdAt = paymentNegotiation.createdAt; }
		if (paymentNegotiation.$assignedFields.contains('updatedAt')) { updatedAt = paymentNegotiation.updatedAt; }
		if (paymentNegotiation.$assignedFields.contains('deletedAt')) { deletedAt = paymentNegotiation.deletedAt; }
		if (paymentNegotiation.$assignedFields.contains('org')) { org = paymentNegotiation.org; }
		if (paymentNegotiation.$assignedFields.contains('reservation')) { reservation = paymentNegotiation.reservation; }
		if (paymentNegotiation.$assignedFields.contains('offers') && paymentNegotiation.offers != null) { offers = mergeModelLists(offers, paymentNegotiation.offers); }
		if (paymentNegotiation.$assignedFields.contains('installments') && paymentNegotiation.installments != null) { installments = mergeModelLists(installments, paymentNegotiation.installments); }
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
          ? {...?serializedTypes, 'PaymentNegotiation'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(reservationId != null) 'reservationId': reservationId,
	if(tenantContactId != null) 'tenantContactId': tenantContactId,
	if(ownerContactId != null) 'ownerContactId': ownerContactId,
	if(ownerUserId != null) 'ownerUserId': ownerUserId,
	if(status != null) 'status': status?.toJson(),
	if(maxInstallments != null) 'maxInstallments': maxInstallments,
	if(minFirstPaymentPct != null) 'minFirstPaymentPct': minFirstPaymentPct,
	if(platformValidated != null) 'platformValidated': platformValidated,
	if(validationNotes != null) 'validationNotes': validationNotes,
	if(agreedOfferId != null) 'agreedOfferId': agreedOfferId,
	if(agreedAt != null) 'agreedAt': agreedAt?.toIso8601String(),
	if(expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
	if(reminderSentAt != null) 'reminderSentAt': reminderSentAt?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(reservation != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'reservation': reservation?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(offers != null && (!preventCircularSerialization || !serializedModels.contains('NegotiationOffer'))) 'offers': offers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(installments != null && (!preventCircularSerialization || !serializedModels.contains('PaymentInstallment'))) 'installments': installments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($offersCount != null || $installmentsCount != null) '_count': { 
		if ($offersCount != null) 'offers': $offersCount, 
		if ($installmentsCount != null) 'installments': $installmentsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PaymentNegotiation &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    