
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact.dart';
import 'deal.dart';
import 'organization.dart';


class AttorneyManagement implements PrismaModel<String, AttorneyManagement> , Id<String> {
    @override
String? id;
	String? orgId;
	String? dealId;
	String? contactId;
	String? solicitorFirm;
	String? solicitorName;
	String? solicitorEmail;
	String? solicitorPhone;
	String? appointmentType;
	DateTime? appointmentDate;
	String? appointmentNotes;
	String? status;
	DateTime? searchDate;
	DateTime? draftContractDate;
	DateTime? finalContractDate;
	DateTime? completionDate;
	String? completionNotes;
	dynamic fees;
	DateTime? createdAt;
	DateTime? updatedAt;
	Contact? contact;
	Deal? deal;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AttorneyManagement({ this.id,
	 this.orgId,
	 this.dealId,
	 this.contactId,
	 this.solicitorFirm,
	 this.solicitorName,
	 this.solicitorEmail,
	 this.solicitorPhone,
	 this.appointmentType,
	 this.appointmentDate,
	 this.appointmentNotes,
	 this.status = "ASSIGNED",
	 this.searchDate,
	 this.draftContractDate,
	 this.finalContractDate,
	 this.completionDate,
	 this.completionNotes,
	required this.fees,
	 this.createdAt,
	 this.updatedAt,
	 this.contact,
	 this.deal,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AttorneyManagement, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"dealId": (m) => m.dealId,

	"contactId": (m) => m.contactId,

	"solicitorFirm": (m) => m.solicitorFirm,

	"solicitorName": (m) => m.solicitorName,

	"solicitorEmail": (m) => m.solicitorEmail,

	"solicitorPhone": (m) => m.solicitorPhone,

	"appointmentType": (m) => m.appointmentType,

	"appointmentDate": (m) => m.appointmentDate,

	"appointmentNotes": (m) => m.appointmentNotes,

	"status": (m) => m.status,

	"searchDate": (m) => m.searchDate,

	"draftContractDate": (m) => m.draftContractDate,

	"finalContractDate": (m) => m.finalContractDate,

	"completionDate": (m) => m.completionDate,

	"completionNotes": (m) => m.completionNotes,

	"fees": (m) => m.fees,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"contact": (m) => m.contact,

	"deal": (m) => m.deal,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AttorneyManagement) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AttorneyManagement');
    }
    return propFunction as V? Function(AttorneyManagement);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AttorneyManagement.fromJson(JsonMap json) =>
      AttorneyManagement(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	dealId: json['dealId'] as String?,
	contactId: json['contactId'] as String?,
	solicitorFirm: json['solicitorFirm'] as String?,
	solicitorName: json['solicitorName'] as String?,
	solicitorEmail: json['solicitorEmail'] as String?,
	solicitorPhone: json['solicitorPhone'] as String?,
	appointmentType: json['appointmentType'] as String?,
	appointmentDate: json['appointmentDate'] != null ? DateTime.parse(json['appointmentDate']) : null,
	appointmentNotes: json['appointmentNotes'] as String?,
	status: json['status'] as String?,
	searchDate: json['searchDate'] != null ? DateTime.parse(json['searchDate']) : null,
	draftContractDate: json['draftContractDate'] != null ? DateTime.parse(json['draftContractDate']) : null,
	finalContractDate: json['finalContractDate'] != null ? DateTime.parse(json['finalContractDate']) : null,
	completionDate: json['completionDate'] != null ? DateTime.parse(json['completionDate']) : null,
	completionNotes: json['completionNotes'] as String?,
	fees: json['fees'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	deal: json['deal'] != null ? Deal.fromJson(json['deal'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AttorneyManagement copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? dealId,
		Value<String?>? contactId,
		Value<String?>? solicitorFirm,
		Value<String?>? solicitorName,
		Value<String?>? solicitorEmail,
		Value<String?>? solicitorPhone,
		Value<String?>? appointmentType,
		Value<DateTime?>? appointmentDate,
		Value<String?>? appointmentNotes,
		Value<String?>? status,
		Value<DateTime?>? searchDate,
		Value<DateTime?>? draftContractDate,
		Value<DateTime?>? finalContractDate,
		Value<DateTime?>? completionDate,
		Value<String?>? completionNotes,
		Value<dynamic>? fees,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Contact?>? contact,
		Value<Deal?>? deal,
		Value<Organization?>? org,
        }) {
        return AttorneyManagement(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		dealId: dealId != null ? dealId.value : this.dealId,
		contactId: contactId != null ? contactId.value : this.contactId,
		solicitorFirm: solicitorFirm != null ? solicitorFirm.value : this.solicitorFirm,
		solicitorName: solicitorName != null ? solicitorName.value : this.solicitorName,
		solicitorEmail: solicitorEmail != null ? solicitorEmail.value : this.solicitorEmail,
		solicitorPhone: solicitorPhone != null ? solicitorPhone.value : this.solicitorPhone,
		appointmentType: appointmentType != null ? appointmentType.value : this.appointmentType,
		appointmentDate: appointmentDate != null ? appointmentDate.value : this.appointmentDate,
		appointmentNotes: appointmentNotes != null ? appointmentNotes.value : this.appointmentNotes,
		status: status != null ? status.value : this.status,
		searchDate: searchDate != null ? searchDate.value : this.searchDate,
		draftContractDate: draftContractDate != null ? draftContractDate.value : this.draftContractDate,
		finalContractDate: finalContractDate != null ? finalContractDate.value : this.finalContractDate,
		completionDate: completionDate != null ? completionDate.value : this.completionDate,
		completionNotes: completionNotes != null ? completionNotes.value : this.completionNotes,
		fees: fees != null ? fees.value : this.fees,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		contact: contact != null ? contact.value : this.contact,
		deal: deal != null ? deal.value : this.deal,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AttorneyManagement copyWithInstanceValues(AttorneyManagement attorneyManagement) {
        return AttorneyManagement(
            id: attorneyManagement.id ?? id,
		orgId: attorneyManagement.orgId ?? orgId,
		dealId: attorneyManagement.dealId ?? dealId,
		contactId: attorneyManagement.contactId ?? contactId,
		solicitorFirm: attorneyManagement.solicitorFirm ?? solicitorFirm,
		solicitorName: attorneyManagement.solicitorName ?? solicitorName,
		solicitorEmail: attorneyManagement.solicitorEmail ?? solicitorEmail,
		solicitorPhone: attorneyManagement.solicitorPhone ?? solicitorPhone,
		appointmentType: attorneyManagement.appointmentType ?? appointmentType,
		appointmentDate: attorneyManagement.appointmentDate ?? appointmentDate,
		appointmentNotes: attorneyManagement.appointmentNotes ?? appointmentNotes,
		status: attorneyManagement.status ?? status,
		searchDate: attorneyManagement.searchDate ?? searchDate,
		draftContractDate: attorneyManagement.draftContractDate ?? draftContractDate,
		finalContractDate: attorneyManagement.finalContractDate ?? finalContractDate,
		completionDate: attorneyManagement.completionDate ?? completionDate,
		completionNotes: attorneyManagement.completionNotes ?? completionNotes,
		fees: attorneyManagement.fees ?? fees,
		createdAt: attorneyManagement.createdAt ?? createdAt,
		updatedAt: attorneyManagement.updatedAt ?? updatedAt,
		contact: attorneyManagement.contact ?? contact,
		deal: attorneyManagement.deal ?? deal,
		org: attorneyManagement.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AttorneyManagement mergeWithInstanceValues(AttorneyManagement attorneyManagement) {
        return AttorneyManagement(
            id: attorneyManagement.$assignedFields.contains('id') ? attorneyManagement.id : id,
		orgId: attorneyManagement.$assignedFields.contains('orgId') ? attorneyManagement.orgId : orgId,
		dealId: attorneyManagement.$assignedFields.contains('dealId') ? attorneyManagement.dealId : dealId,
		contactId: attorneyManagement.$assignedFields.contains('contactId') ? attorneyManagement.contactId : contactId,
		solicitorFirm: attorneyManagement.$assignedFields.contains('solicitorFirm') ? attorneyManagement.solicitorFirm : solicitorFirm,
		solicitorName: attorneyManagement.$assignedFields.contains('solicitorName') ? attorneyManagement.solicitorName : solicitorName,
		solicitorEmail: attorneyManagement.$assignedFields.contains('solicitorEmail') ? attorneyManagement.solicitorEmail : solicitorEmail,
		solicitorPhone: attorneyManagement.$assignedFields.contains('solicitorPhone') ? attorneyManagement.solicitorPhone : solicitorPhone,
		appointmentType: attorneyManagement.$assignedFields.contains('appointmentType') ? attorneyManagement.appointmentType : appointmentType,
		appointmentDate: attorneyManagement.$assignedFields.contains('appointmentDate') ? attorneyManagement.appointmentDate : appointmentDate,
		appointmentNotes: attorneyManagement.$assignedFields.contains('appointmentNotes') ? attorneyManagement.appointmentNotes : appointmentNotes,
		status: attorneyManagement.$assignedFields.contains('status') ? attorneyManagement.status : status,
		searchDate: attorneyManagement.$assignedFields.contains('searchDate') ? attorneyManagement.searchDate : searchDate,
		draftContractDate: attorneyManagement.$assignedFields.contains('draftContractDate') ? attorneyManagement.draftContractDate : draftContractDate,
		finalContractDate: attorneyManagement.$assignedFields.contains('finalContractDate') ? attorneyManagement.finalContractDate : finalContractDate,
		completionDate: attorneyManagement.$assignedFields.contains('completionDate') ? attorneyManagement.completionDate : completionDate,
		completionNotes: attorneyManagement.$assignedFields.contains('completionNotes') ? attorneyManagement.completionNotes : completionNotes,
		fees: attorneyManagement.$assignedFields.contains('fees') ? attorneyManagement.fees : fees,
		createdAt: attorneyManagement.$assignedFields.contains('createdAt') ? attorneyManagement.createdAt : createdAt,
		updatedAt: attorneyManagement.$assignedFields.contains('updatedAt') ? attorneyManagement.updatedAt : updatedAt,
		contact: attorneyManagement.$assignedFields.contains('contact') ? attorneyManagement.contact : contact,
		deal: attorneyManagement.$assignedFields.contains('deal') ? attorneyManagement.deal : deal,
		org: attorneyManagement.$assignedFields.contains('org') ? attorneyManagement.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AttorneyManagement updateWithInstanceValues(AttorneyManagement attorneyManagement) {
        if (attorneyManagement.$assignedFields.contains('id')) { id = attorneyManagement.id; }
		if (attorneyManagement.$assignedFields.contains('orgId')) { orgId = attorneyManagement.orgId; }
		if (attorneyManagement.$assignedFields.contains('dealId')) { dealId = attorneyManagement.dealId; }
		if (attorneyManagement.$assignedFields.contains('contactId')) { contactId = attorneyManagement.contactId; }
		if (attorneyManagement.$assignedFields.contains('solicitorFirm')) { solicitorFirm = attorneyManagement.solicitorFirm; }
		if (attorneyManagement.$assignedFields.contains('solicitorName')) { solicitorName = attorneyManagement.solicitorName; }
		if (attorneyManagement.$assignedFields.contains('solicitorEmail')) { solicitorEmail = attorneyManagement.solicitorEmail; }
		if (attorneyManagement.$assignedFields.contains('solicitorPhone')) { solicitorPhone = attorneyManagement.solicitorPhone; }
		if (attorneyManagement.$assignedFields.contains('appointmentType')) { appointmentType = attorneyManagement.appointmentType; }
		if (attorneyManagement.$assignedFields.contains('appointmentDate')) { appointmentDate = attorneyManagement.appointmentDate; }
		if (attorneyManagement.$assignedFields.contains('appointmentNotes')) { appointmentNotes = attorneyManagement.appointmentNotes; }
		if (attorneyManagement.$assignedFields.contains('status')) { status = attorneyManagement.status; }
		if (attorneyManagement.$assignedFields.contains('searchDate')) { searchDate = attorneyManagement.searchDate; }
		if (attorneyManagement.$assignedFields.contains('draftContractDate')) { draftContractDate = attorneyManagement.draftContractDate; }
		if (attorneyManagement.$assignedFields.contains('finalContractDate')) { finalContractDate = attorneyManagement.finalContractDate; }
		if (attorneyManagement.$assignedFields.contains('completionDate')) { completionDate = attorneyManagement.completionDate; }
		if (attorneyManagement.$assignedFields.contains('completionNotes')) { completionNotes = attorneyManagement.completionNotes; }
		if (attorneyManagement.$assignedFields.contains('fees')) { fees = attorneyManagement.fees; }
		if (attorneyManagement.$assignedFields.contains('createdAt')) { createdAt = attorneyManagement.createdAt; }
		if (attorneyManagement.$assignedFields.contains('updatedAt')) { updatedAt = attorneyManagement.updatedAt; }
		if (attorneyManagement.$assignedFields.contains('contact')) { contact = attorneyManagement.contact; }
		if (attorneyManagement.$assignedFields.contains('deal')) { deal = attorneyManagement.deal; }
		if (attorneyManagement.$assignedFields.contains('org')) { org = attorneyManagement.org; }
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
          ? {...?serializedTypes, 'AttorneyManagement'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(dealId != null) 'dealId': dealId,
	if(contactId != null) 'contactId': contactId,
	if(solicitorFirm != null) 'solicitorFirm': solicitorFirm,
	if(solicitorName != null) 'solicitorName': solicitorName,
	if(solicitorEmail != null) 'solicitorEmail': solicitorEmail,
	if(solicitorPhone != null) 'solicitorPhone': solicitorPhone,
	if(appointmentType != null) 'appointmentType': appointmentType,
	if(appointmentDate != null) 'appointmentDate': appointmentDate?.toIso8601String(),
	if(appointmentNotes != null) 'appointmentNotes': appointmentNotes,
	if(status != null) 'status': status,
	if(searchDate != null) 'searchDate': searchDate?.toIso8601String(),
	if(draftContractDate != null) 'draftContractDate': draftContractDate?.toIso8601String(),
	if(finalContractDate != null) 'finalContractDate': finalContractDate?.toIso8601String(),
	if(completionDate != null) 'completionDate': completionDate?.toIso8601String(),
	if(completionNotes != null) 'completionNotes': completionNotes,
	if(fees != null) 'fees': fees,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(deal != null && (!preventCircularSerialization || !serializedModels.contains('Deal'))) 'deal': deal?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AttorneyManagement &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    