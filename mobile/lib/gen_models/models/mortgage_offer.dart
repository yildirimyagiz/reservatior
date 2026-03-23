
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact.dart';
import 'organization.dart';
import 'property.dart';


class MortgageOffer implements PrismaModel<String, MortgageOffer> , Id<String> {
    @override
String? id;
	String? orgId;
	String? contactId;
	String? propertyId;
	String? lender;
	double? offerAmount;
	double? interestRate;
	int? termYears;
	double? monthlyPayment;
	String? currency;
	String? status;
	DateTime? offeredAt;
	DateTime? acceptedAt;
	DateTime? expiresAt;
	String? conditions;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contact? contact;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MortgageOffer({ this.id,
	 this.orgId,
	 this.contactId,
	 this.propertyId,
	 this.lender,
	 this.offerAmount,
	 this.interestRate,
	 this.termYears,
	 this.monthlyPayment,
	 this.currency,
	 this.status = "offered",
	 this.offeredAt,
	 this.acceptedAt,
	 this.expiresAt,
	 this.conditions,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contact,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MortgageOffer, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"contactId": (m) => m.contactId,

	"propertyId": (m) => m.propertyId,

	"lender": (m) => m.lender,

	"offerAmount": (m) => m.offerAmount,

	"interestRate": (m) => m.interestRate,

	"termYears": (m) => m.termYears,

	"monthlyPayment": (m) => m.monthlyPayment,

	"currency": (m) => m.currency,

	"status": (m) => m.status,

	"offeredAt": (m) => m.offeredAt,

	"acceptedAt": (m) => m.acceptedAt,

	"expiresAt": (m) => m.expiresAt,

	"conditions": (m) => m.conditions,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contact": (m) => m.contact,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MortgageOffer) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MortgageOffer');
    }
    return propFunction as V? Function(MortgageOffer);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MortgageOffer.fromJson(JsonMap json) =>
      MortgageOffer(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	contactId: json['contactId'] as String?,
	propertyId: json['propertyId'] as String?,
	lender: json['lender'] as String?,
	offerAmount: json['offerAmount'] as double?,
	interestRate: json['interestRate']?.toDouble(),
	termYears: int.tryParse(json['termYears'].toString()),
	monthlyPayment: json['monthlyPayment'] as double?,
	currency: json['currency'] as String?,
	status: json['status'] as String?,
	offeredAt: json['offeredAt'] != null ? DateTime.parse(json['offeredAt']) : null,
	acceptedAt: json['acceptedAt'] != null ? DateTime.parse(json['acceptedAt']) : null,
	expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
	conditions: json['conditions'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    MortgageOffer copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? contactId,
		Value<String?>? propertyId,
		Value<String?>? lender,
		Value<double?>? offerAmount,
		Value<double?>? interestRate,
		Value<int?>? termYears,
		Value<double?>? monthlyPayment,
		Value<String?>? currency,
		Value<String?>? status,
		Value<DateTime?>? offeredAt,
		Value<DateTime?>? acceptedAt,
		Value<DateTime?>? expiresAt,
		Value<String?>? conditions,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contact?>? contact,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return MortgageOffer(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		contactId: contactId != null ? contactId.value : this.contactId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		lender: lender != null ? lender.value : this.lender,
		offerAmount: offerAmount != null ? offerAmount.value : this.offerAmount,
		interestRate: interestRate != null ? interestRate.value : this.interestRate,
		termYears: termYears != null ? termYears.value : this.termYears,
		monthlyPayment: monthlyPayment != null ? monthlyPayment.value : this.monthlyPayment,
		currency: currency != null ? currency.value : this.currency,
		status: status != null ? status.value : this.status,
		offeredAt: offeredAt != null ? offeredAt.value : this.offeredAt,
		acceptedAt: acceptedAt != null ? acceptedAt.value : this.acceptedAt,
		expiresAt: expiresAt != null ? expiresAt.value : this.expiresAt,
		conditions: conditions != null ? conditions.value : this.conditions,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contact: contact != null ? contact.value : this.contact,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    MortgageOffer copyWithInstanceValues(MortgageOffer mortgageOffer) {
        return MortgageOffer(
            id: mortgageOffer.id ?? id,
		orgId: mortgageOffer.orgId ?? orgId,
		contactId: mortgageOffer.contactId ?? contactId,
		propertyId: mortgageOffer.propertyId ?? propertyId,
		lender: mortgageOffer.lender ?? lender,
		offerAmount: mortgageOffer.offerAmount ?? offerAmount,
		interestRate: mortgageOffer.interestRate ?? interestRate,
		termYears: mortgageOffer.termYears ?? termYears,
		monthlyPayment: mortgageOffer.monthlyPayment ?? monthlyPayment,
		currency: mortgageOffer.currency ?? currency,
		status: mortgageOffer.status ?? status,
		offeredAt: mortgageOffer.offeredAt ?? offeredAt,
		acceptedAt: mortgageOffer.acceptedAt ?? acceptedAt,
		expiresAt: mortgageOffer.expiresAt ?? expiresAt,
		conditions: mortgageOffer.conditions ?? conditions,
		createdBy: mortgageOffer.createdBy ?? createdBy,
		createdAt: mortgageOffer.createdAt ?? createdAt,
		updatedAt: mortgageOffer.updatedAt ?? updatedAt,
		deletedAt: mortgageOffer.deletedAt ?? deletedAt,
		contact: mortgageOffer.contact ?? contact,
		org: mortgageOffer.org ?? org,
		property: mortgageOffer.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MortgageOffer mergeWithInstanceValues(MortgageOffer mortgageOffer) {
        return MortgageOffer(
            id: mortgageOffer.$assignedFields.contains('id') ? mortgageOffer.id : id,
		orgId: mortgageOffer.$assignedFields.contains('orgId') ? mortgageOffer.orgId : orgId,
		contactId: mortgageOffer.$assignedFields.contains('contactId') ? mortgageOffer.contactId : contactId,
		propertyId: mortgageOffer.$assignedFields.contains('propertyId') ? mortgageOffer.propertyId : propertyId,
		lender: mortgageOffer.$assignedFields.contains('lender') ? mortgageOffer.lender : lender,
		offerAmount: mortgageOffer.$assignedFields.contains('offerAmount') ? mortgageOffer.offerAmount : offerAmount,
		interestRate: mortgageOffer.$assignedFields.contains('interestRate') ? mortgageOffer.interestRate : interestRate,
		termYears: mortgageOffer.$assignedFields.contains('termYears') ? mortgageOffer.termYears : termYears,
		monthlyPayment: mortgageOffer.$assignedFields.contains('monthlyPayment') ? mortgageOffer.monthlyPayment : monthlyPayment,
		currency: mortgageOffer.$assignedFields.contains('currency') ? mortgageOffer.currency : currency,
		status: mortgageOffer.$assignedFields.contains('status') ? mortgageOffer.status : status,
		offeredAt: mortgageOffer.$assignedFields.contains('offeredAt') ? mortgageOffer.offeredAt : offeredAt,
		acceptedAt: mortgageOffer.$assignedFields.contains('acceptedAt') ? mortgageOffer.acceptedAt : acceptedAt,
		expiresAt: mortgageOffer.$assignedFields.contains('expiresAt') ? mortgageOffer.expiresAt : expiresAt,
		conditions: mortgageOffer.$assignedFields.contains('conditions') ? mortgageOffer.conditions : conditions,
		createdBy: mortgageOffer.$assignedFields.contains('createdBy') ? mortgageOffer.createdBy : createdBy,
		createdAt: mortgageOffer.$assignedFields.contains('createdAt') ? mortgageOffer.createdAt : createdAt,
		updatedAt: mortgageOffer.$assignedFields.contains('updatedAt') ? mortgageOffer.updatedAt : updatedAt,
		deletedAt: mortgageOffer.$assignedFields.contains('deletedAt') ? mortgageOffer.deletedAt : deletedAt,
		contact: mortgageOffer.$assignedFields.contains('contact') ? mortgageOffer.contact : contact,
		org: mortgageOffer.$assignedFields.contains('org') ? mortgageOffer.org : org,
		property: mortgageOffer.$assignedFields.contains('property') ? mortgageOffer.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MortgageOffer updateWithInstanceValues(MortgageOffer mortgageOffer) {
        if (mortgageOffer.$assignedFields.contains('id')) { id = mortgageOffer.id; }
		if (mortgageOffer.$assignedFields.contains('orgId')) { orgId = mortgageOffer.orgId; }
		if (mortgageOffer.$assignedFields.contains('contactId')) { contactId = mortgageOffer.contactId; }
		if (mortgageOffer.$assignedFields.contains('propertyId')) { propertyId = mortgageOffer.propertyId; }
		if (mortgageOffer.$assignedFields.contains('lender')) { lender = mortgageOffer.lender; }
		if (mortgageOffer.$assignedFields.contains('offerAmount')) { offerAmount = mortgageOffer.offerAmount; }
		if (mortgageOffer.$assignedFields.contains('interestRate')) { interestRate = mortgageOffer.interestRate; }
		if (mortgageOffer.$assignedFields.contains('termYears')) { termYears = mortgageOffer.termYears; }
		if (mortgageOffer.$assignedFields.contains('monthlyPayment')) { monthlyPayment = mortgageOffer.monthlyPayment; }
		if (mortgageOffer.$assignedFields.contains('currency')) { currency = mortgageOffer.currency; }
		if (mortgageOffer.$assignedFields.contains('status')) { status = mortgageOffer.status; }
		if (mortgageOffer.$assignedFields.contains('offeredAt')) { offeredAt = mortgageOffer.offeredAt; }
		if (mortgageOffer.$assignedFields.contains('acceptedAt')) { acceptedAt = mortgageOffer.acceptedAt; }
		if (mortgageOffer.$assignedFields.contains('expiresAt')) { expiresAt = mortgageOffer.expiresAt; }
		if (mortgageOffer.$assignedFields.contains('conditions')) { conditions = mortgageOffer.conditions; }
		if (mortgageOffer.$assignedFields.contains('createdBy')) { createdBy = mortgageOffer.createdBy; }
		if (mortgageOffer.$assignedFields.contains('createdAt')) { createdAt = mortgageOffer.createdAt; }
		if (mortgageOffer.$assignedFields.contains('updatedAt')) { updatedAt = mortgageOffer.updatedAt; }
		if (mortgageOffer.$assignedFields.contains('deletedAt')) { deletedAt = mortgageOffer.deletedAt; }
		if (mortgageOffer.$assignedFields.contains('contact')) { contact = mortgageOffer.contact; }
		if (mortgageOffer.$assignedFields.contains('org')) { org = mortgageOffer.org; }
		if (mortgageOffer.$assignedFields.contains('property')) { property = mortgageOffer.property; }
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
          ? {...?serializedTypes, 'MortgageOffer'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(contactId != null) 'contactId': contactId,
	if(propertyId != null) 'propertyId': propertyId,
	if(lender != null) 'lender': lender,
	if(offerAmount != null) 'offerAmount': offerAmount,
	if(interestRate != null) 'interestRate': interestRate,
	if(termYears != null) 'termYears': termYears,
	if(monthlyPayment != null) 'monthlyPayment': monthlyPayment,
	if(currency != null) 'currency': currency,
	if(status != null) 'status': status,
	if(offeredAt != null) 'offeredAt': offeredAt?.toIso8601String(),
	if(acceptedAt != null) 'acceptedAt': acceptedAt?.toIso8601String(),
	if(expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
	if(conditions != null) 'conditions': conditions,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is MortgageOffer &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    