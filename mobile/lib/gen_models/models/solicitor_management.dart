
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact.dart';
import 'deal.dart';
import 'organization.dart';


class SolicitorManagement implements PrismaModel<String, SolicitorManagement> , Id<String> {
    @override
String? id;
	String? orgId;
	String? dealId;
	String? contactId;
	String? solicitorType;
	String? status;
	DateTime? engagedAt;
	DateTime? completedAt;
	double? fee;
	String? currency;
	String? notes;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contact? contact;
	Deal? deal;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    SolicitorManagement({ this.id,
	 this.orgId,
	 this.dealId,
	 this.contactId,
	 this.solicitorType,
	 this.status = "engaged",
	 this.engagedAt,
	 this.completedAt,
	 this.fee,
	 this.currency,
	 this.notes,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contact,
	 this.deal,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<SolicitorManagement, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"dealId": (m) => m.dealId,

	"contactId": (m) => m.contactId,

	"solicitorType": (m) => m.solicitorType,

	"status": (m) => m.status,

	"engagedAt": (m) => m.engagedAt,

	"completedAt": (m) => m.completedAt,

	"fee": (m) => m.fee,

	"currency": (m) => m.currency,

	"notes": (m) => m.notes,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contact": (m) => m.contact,

	"deal": (m) => m.deal,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(SolicitorManagement) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in SolicitorManagement');
    }
    return propFunction as V? Function(SolicitorManagement);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory SolicitorManagement.fromJson(JsonMap json) =>
      SolicitorManagement(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	dealId: json['dealId'] as String?,
	contactId: json['contactId'] as String?,
	solicitorType: json['solicitorType'] as String?,
	status: json['status'] as String?,
	engagedAt: json['engagedAt'] != null ? DateTime.parse(json['engagedAt']) : null,
	completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : null,
	fee: json['fee'] as double?,
	currency: json['currency'] as String?,
	notes: json['notes'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	deal: json['deal'] != null ? Deal.fromJson(json['deal'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    SolicitorManagement copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? dealId,
		Value<String?>? contactId,
		Value<String?>? solicitorType,
		Value<String?>? status,
		Value<DateTime?>? engagedAt,
		Value<DateTime?>? completedAt,
		Value<double?>? fee,
		Value<String?>? currency,
		Value<String?>? notes,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contact?>? contact,
		Value<Deal?>? deal,
		Value<Organization?>? org,
        }) {
        return SolicitorManagement(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		dealId: dealId != null ? dealId.value : this.dealId,
		contactId: contactId != null ? contactId.value : this.contactId,
		solicitorType: solicitorType != null ? solicitorType.value : this.solicitorType,
		status: status != null ? status.value : this.status,
		engagedAt: engagedAt != null ? engagedAt.value : this.engagedAt,
		completedAt: completedAt != null ? completedAt.value : this.completedAt,
		fee: fee != null ? fee.value : this.fee,
		currency: currency != null ? currency.value : this.currency,
		notes: notes != null ? notes.value : this.notes,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contact: contact != null ? contact.value : this.contact,
		deal: deal != null ? deal.value : this.deal,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    SolicitorManagement copyWithInstanceValues(SolicitorManagement solicitorManagement) {
        return SolicitorManagement(
            id: solicitorManagement.id ?? id,
		orgId: solicitorManagement.orgId ?? orgId,
		dealId: solicitorManagement.dealId ?? dealId,
		contactId: solicitorManagement.contactId ?? contactId,
		solicitorType: solicitorManagement.solicitorType ?? solicitorType,
		status: solicitorManagement.status ?? status,
		engagedAt: solicitorManagement.engagedAt ?? engagedAt,
		completedAt: solicitorManagement.completedAt ?? completedAt,
		fee: solicitorManagement.fee ?? fee,
		currency: solicitorManagement.currency ?? currency,
		notes: solicitorManagement.notes ?? notes,
		createdBy: solicitorManagement.createdBy ?? createdBy,
		createdAt: solicitorManagement.createdAt ?? createdAt,
		updatedAt: solicitorManagement.updatedAt ?? updatedAt,
		deletedAt: solicitorManagement.deletedAt ?? deletedAt,
		contact: solicitorManagement.contact ?? contact,
		deal: solicitorManagement.deal ?? deal,
		org: solicitorManagement.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    SolicitorManagement mergeWithInstanceValues(SolicitorManagement solicitorManagement) {
        return SolicitorManagement(
            id: solicitorManagement.$assignedFields.contains('id') ? solicitorManagement.id : id,
		orgId: solicitorManagement.$assignedFields.contains('orgId') ? solicitorManagement.orgId : orgId,
		dealId: solicitorManagement.$assignedFields.contains('dealId') ? solicitorManagement.dealId : dealId,
		contactId: solicitorManagement.$assignedFields.contains('contactId') ? solicitorManagement.contactId : contactId,
		solicitorType: solicitorManagement.$assignedFields.contains('solicitorType') ? solicitorManagement.solicitorType : solicitorType,
		status: solicitorManagement.$assignedFields.contains('status') ? solicitorManagement.status : status,
		engagedAt: solicitorManagement.$assignedFields.contains('engagedAt') ? solicitorManagement.engagedAt : engagedAt,
		completedAt: solicitorManagement.$assignedFields.contains('completedAt') ? solicitorManagement.completedAt : completedAt,
		fee: solicitorManagement.$assignedFields.contains('fee') ? solicitorManagement.fee : fee,
		currency: solicitorManagement.$assignedFields.contains('currency') ? solicitorManagement.currency : currency,
		notes: solicitorManagement.$assignedFields.contains('notes') ? solicitorManagement.notes : notes,
		createdBy: solicitorManagement.$assignedFields.contains('createdBy') ? solicitorManagement.createdBy : createdBy,
		createdAt: solicitorManagement.$assignedFields.contains('createdAt') ? solicitorManagement.createdAt : createdAt,
		updatedAt: solicitorManagement.$assignedFields.contains('updatedAt') ? solicitorManagement.updatedAt : updatedAt,
		deletedAt: solicitorManagement.$assignedFields.contains('deletedAt') ? solicitorManagement.deletedAt : deletedAt,
		contact: solicitorManagement.$assignedFields.contains('contact') ? solicitorManagement.contact : contact,
		deal: solicitorManagement.$assignedFields.contains('deal') ? solicitorManagement.deal : deal,
		org: solicitorManagement.$assignedFields.contains('org') ? solicitorManagement.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    SolicitorManagement updateWithInstanceValues(SolicitorManagement solicitorManagement) {
        if (solicitorManagement.$assignedFields.contains('id')) { id = solicitorManagement.id; }
		if (solicitorManagement.$assignedFields.contains('orgId')) { orgId = solicitorManagement.orgId; }
		if (solicitorManagement.$assignedFields.contains('dealId')) { dealId = solicitorManagement.dealId; }
		if (solicitorManagement.$assignedFields.contains('contactId')) { contactId = solicitorManagement.contactId; }
		if (solicitorManagement.$assignedFields.contains('solicitorType')) { solicitorType = solicitorManagement.solicitorType; }
		if (solicitorManagement.$assignedFields.contains('status')) { status = solicitorManagement.status; }
		if (solicitorManagement.$assignedFields.contains('engagedAt')) { engagedAt = solicitorManagement.engagedAt; }
		if (solicitorManagement.$assignedFields.contains('completedAt')) { completedAt = solicitorManagement.completedAt; }
		if (solicitorManagement.$assignedFields.contains('fee')) { fee = solicitorManagement.fee; }
		if (solicitorManagement.$assignedFields.contains('currency')) { currency = solicitorManagement.currency; }
		if (solicitorManagement.$assignedFields.contains('notes')) { notes = solicitorManagement.notes; }
		if (solicitorManagement.$assignedFields.contains('createdBy')) { createdBy = solicitorManagement.createdBy; }
		if (solicitorManagement.$assignedFields.contains('createdAt')) { createdAt = solicitorManagement.createdAt; }
		if (solicitorManagement.$assignedFields.contains('updatedAt')) { updatedAt = solicitorManagement.updatedAt; }
		if (solicitorManagement.$assignedFields.contains('deletedAt')) { deletedAt = solicitorManagement.deletedAt; }
		if (solicitorManagement.$assignedFields.contains('contact')) { contact = solicitorManagement.contact; }
		if (solicitorManagement.$assignedFields.contains('deal')) { deal = solicitorManagement.deal; }
		if (solicitorManagement.$assignedFields.contains('org')) { org = solicitorManagement.org; }
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
          ? {...?serializedTypes, 'SolicitorManagement'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(dealId != null) 'dealId': dealId,
	if(contactId != null) 'contactId': contactId,
	if(solicitorType != null) 'solicitorType': solicitorType,
	if(status != null) 'status': status,
	if(engagedAt != null) 'engagedAt': engagedAt?.toIso8601String(),
	if(completedAt != null) 'completedAt': completedAt?.toIso8601String(),
	if(fee != null) 'fee': fee,
	if(currency != null) 'currency': currency,
	if(notes != null) 'notes': notes,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(deal != null && (!preventCircularSerialization || !serializedModels.contains('Deal'))) 'deal': deal?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is SolicitorManagement &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    