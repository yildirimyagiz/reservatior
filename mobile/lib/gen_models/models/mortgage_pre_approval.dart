
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact.dart';
import 'deal.dart';
import 'organization.dart';


class MortgagePreApproval implements PrismaModel<String, MortgagePreApproval> , Id<String> {
    @override
String? id;
	String? orgId;
	String? dealId;
	String? contactId;
	String? lenderName;
	String? mortgageType;
	int? mortgageTerm;
	double? interestRate;
	double? arrangementFee;
	double? valuationFee;
	double? loanAmount;
	double? depositAmount;
	double? loanToValue;
	double? monthlyPayment;
	double? totalPayable;
	String? offerStatus;
	DateTime? offerDate;
	DateTime? expiryDate;
	DateTime? acceptedDate;
	String? solicitorName;
	String? solicitorEmail;
	DateTime? createdAt;
	DateTime? updatedAt;
	Contact? contact;
	Deal? deal;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    MortgagePreApproval({ this.id,
	 this.orgId,
	 this.dealId,
	 this.contactId,
	 this.lenderName,
	 this.mortgageType,
	 this.mortgageTerm,
	 this.interestRate,
	 this.arrangementFee,
	 this.valuationFee,
	 this.loanAmount,
	 this.depositAmount,
	 this.loanToValue,
	 this.monthlyPayment,
	 this.totalPayable,
	 this.offerStatus = "OFFERED",
	 this.offerDate,
	 this.expiryDate,
	 this.acceptedDate,
	 this.solicitorName,
	 this.solicitorEmail,
	 this.createdAt,
	 this.updatedAt,
	 this.contact,
	 this.deal,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<MortgagePreApproval, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"dealId": (m) => m.dealId,

	"contactId": (m) => m.contactId,

	"lenderName": (m) => m.lenderName,

	"mortgageType": (m) => m.mortgageType,

	"mortgageTerm": (m) => m.mortgageTerm,

	"interestRate": (m) => m.interestRate,

	"arrangementFee": (m) => m.arrangementFee,

	"valuationFee": (m) => m.valuationFee,

	"loanAmount": (m) => m.loanAmount,

	"depositAmount": (m) => m.depositAmount,

	"loanToValue": (m) => m.loanToValue,

	"monthlyPayment": (m) => m.monthlyPayment,

	"totalPayable": (m) => m.totalPayable,

	"offerStatus": (m) => m.offerStatus,

	"offerDate": (m) => m.offerDate,

	"expiryDate": (m) => m.expiryDate,

	"acceptedDate": (m) => m.acceptedDate,

	"solicitorName": (m) => m.solicitorName,

	"solicitorEmail": (m) => m.solicitorEmail,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"contact": (m) => m.contact,

	"deal": (m) => m.deal,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(MortgagePreApproval) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in MortgagePreApproval');
    }
    return propFunction as V? Function(MortgagePreApproval);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory MortgagePreApproval.fromJson(JsonMap json) =>
      MortgagePreApproval(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	dealId: json['dealId'] as String?,
	contactId: json['contactId'] as String?,
	lenderName: json['lenderName'] as String?,
	mortgageType: json['mortgageType'] as String?,
	mortgageTerm: int.tryParse(json['mortgageTerm'].toString()),
	interestRate: json['interestRate']?.toDouble(),
	arrangementFee: json['arrangementFee'] as double?,
	valuationFee: json['valuationFee'] as double?,
	loanAmount: json['loanAmount'] as double?,
	depositAmount: json['depositAmount'] as double?,
	loanToValue: json['loanToValue']?.toDouble(),
	monthlyPayment: json['monthlyPayment'] as double?,
	totalPayable: json['totalPayable'] as double?,
	offerStatus: json['offerStatus'] as String?,
	offerDate: json['offerDate'] != null ? DateTime.parse(json['offerDate']) : null,
	expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null,
	acceptedDate: json['acceptedDate'] != null ? DateTime.parse(json['acceptedDate']) : null,
	solicitorName: json['solicitorName'] as String?,
	solicitorEmail: json['solicitorEmail'] as String?,
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
    MortgagePreApproval copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? dealId,
		Value<String?>? contactId,
		Value<String?>? lenderName,
		Value<String?>? mortgageType,
		Value<int?>? mortgageTerm,
		Value<double?>? interestRate,
		Value<double?>? arrangementFee,
		Value<double?>? valuationFee,
		Value<double?>? loanAmount,
		Value<double?>? depositAmount,
		Value<double?>? loanToValue,
		Value<double?>? monthlyPayment,
		Value<double?>? totalPayable,
		Value<String?>? offerStatus,
		Value<DateTime?>? offerDate,
		Value<DateTime?>? expiryDate,
		Value<DateTime?>? acceptedDate,
		Value<String?>? solicitorName,
		Value<String?>? solicitorEmail,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Contact?>? contact,
		Value<Deal?>? deal,
		Value<Organization?>? org,
        }) {
        return MortgagePreApproval(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		dealId: dealId != null ? dealId.value : this.dealId,
		contactId: contactId != null ? contactId.value : this.contactId,
		lenderName: lenderName != null ? lenderName.value : this.lenderName,
		mortgageType: mortgageType != null ? mortgageType.value : this.mortgageType,
		mortgageTerm: mortgageTerm != null ? mortgageTerm.value : this.mortgageTerm,
		interestRate: interestRate != null ? interestRate.value : this.interestRate,
		arrangementFee: arrangementFee != null ? arrangementFee.value : this.arrangementFee,
		valuationFee: valuationFee != null ? valuationFee.value : this.valuationFee,
		loanAmount: loanAmount != null ? loanAmount.value : this.loanAmount,
		depositAmount: depositAmount != null ? depositAmount.value : this.depositAmount,
		loanToValue: loanToValue != null ? loanToValue.value : this.loanToValue,
		monthlyPayment: monthlyPayment != null ? monthlyPayment.value : this.monthlyPayment,
		totalPayable: totalPayable != null ? totalPayable.value : this.totalPayable,
		offerStatus: offerStatus != null ? offerStatus.value : this.offerStatus,
		offerDate: offerDate != null ? offerDate.value : this.offerDate,
		expiryDate: expiryDate != null ? expiryDate.value : this.expiryDate,
		acceptedDate: acceptedDate != null ? acceptedDate.value : this.acceptedDate,
		solicitorName: solicitorName != null ? solicitorName.value : this.solicitorName,
		solicitorEmail: solicitorEmail != null ? solicitorEmail.value : this.solicitorEmail,
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
    MortgagePreApproval copyWithInstanceValues(MortgagePreApproval mortgagePreApproval) {
        return MortgagePreApproval(
            id: mortgagePreApproval.id ?? id,
		orgId: mortgagePreApproval.orgId ?? orgId,
		dealId: mortgagePreApproval.dealId ?? dealId,
		contactId: mortgagePreApproval.contactId ?? contactId,
		lenderName: mortgagePreApproval.lenderName ?? lenderName,
		mortgageType: mortgagePreApproval.mortgageType ?? mortgageType,
		mortgageTerm: mortgagePreApproval.mortgageTerm ?? mortgageTerm,
		interestRate: mortgagePreApproval.interestRate ?? interestRate,
		arrangementFee: mortgagePreApproval.arrangementFee ?? arrangementFee,
		valuationFee: mortgagePreApproval.valuationFee ?? valuationFee,
		loanAmount: mortgagePreApproval.loanAmount ?? loanAmount,
		depositAmount: mortgagePreApproval.depositAmount ?? depositAmount,
		loanToValue: mortgagePreApproval.loanToValue ?? loanToValue,
		monthlyPayment: mortgagePreApproval.monthlyPayment ?? monthlyPayment,
		totalPayable: mortgagePreApproval.totalPayable ?? totalPayable,
		offerStatus: mortgagePreApproval.offerStatus ?? offerStatus,
		offerDate: mortgagePreApproval.offerDate ?? offerDate,
		expiryDate: mortgagePreApproval.expiryDate ?? expiryDate,
		acceptedDate: mortgagePreApproval.acceptedDate ?? acceptedDate,
		solicitorName: mortgagePreApproval.solicitorName ?? solicitorName,
		solicitorEmail: mortgagePreApproval.solicitorEmail ?? solicitorEmail,
		createdAt: mortgagePreApproval.createdAt ?? createdAt,
		updatedAt: mortgagePreApproval.updatedAt ?? updatedAt,
		contact: mortgagePreApproval.contact ?? contact,
		deal: mortgagePreApproval.deal ?? deal,
		org: mortgagePreApproval.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    MortgagePreApproval mergeWithInstanceValues(MortgagePreApproval mortgagePreApproval) {
        return MortgagePreApproval(
            id: mortgagePreApproval.$assignedFields.contains('id') ? mortgagePreApproval.id : id,
		orgId: mortgagePreApproval.$assignedFields.contains('orgId') ? mortgagePreApproval.orgId : orgId,
		dealId: mortgagePreApproval.$assignedFields.contains('dealId') ? mortgagePreApproval.dealId : dealId,
		contactId: mortgagePreApproval.$assignedFields.contains('contactId') ? mortgagePreApproval.contactId : contactId,
		lenderName: mortgagePreApproval.$assignedFields.contains('lenderName') ? mortgagePreApproval.lenderName : lenderName,
		mortgageType: mortgagePreApproval.$assignedFields.contains('mortgageType') ? mortgagePreApproval.mortgageType : mortgageType,
		mortgageTerm: mortgagePreApproval.$assignedFields.contains('mortgageTerm') ? mortgagePreApproval.mortgageTerm : mortgageTerm,
		interestRate: mortgagePreApproval.$assignedFields.contains('interestRate') ? mortgagePreApproval.interestRate : interestRate,
		arrangementFee: mortgagePreApproval.$assignedFields.contains('arrangementFee') ? mortgagePreApproval.arrangementFee : arrangementFee,
		valuationFee: mortgagePreApproval.$assignedFields.contains('valuationFee') ? mortgagePreApproval.valuationFee : valuationFee,
		loanAmount: mortgagePreApproval.$assignedFields.contains('loanAmount') ? mortgagePreApproval.loanAmount : loanAmount,
		depositAmount: mortgagePreApproval.$assignedFields.contains('depositAmount') ? mortgagePreApproval.depositAmount : depositAmount,
		loanToValue: mortgagePreApproval.$assignedFields.contains('loanToValue') ? mortgagePreApproval.loanToValue : loanToValue,
		monthlyPayment: mortgagePreApproval.$assignedFields.contains('monthlyPayment') ? mortgagePreApproval.monthlyPayment : monthlyPayment,
		totalPayable: mortgagePreApproval.$assignedFields.contains('totalPayable') ? mortgagePreApproval.totalPayable : totalPayable,
		offerStatus: mortgagePreApproval.$assignedFields.contains('offerStatus') ? mortgagePreApproval.offerStatus : offerStatus,
		offerDate: mortgagePreApproval.$assignedFields.contains('offerDate') ? mortgagePreApproval.offerDate : offerDate,
		expiryDate: mortgagePreApproval.$assignedFields.contains('expiryDate') ? mortgagePreApproval.expiryDate : expiryDate,
		acceptedDate: mortgagePreApproval.$assignedFields.contains('acceptedDate') ? mortgagePreApproval.acceptedDate : acceptedDate,
		solicitorName: mortgagePreApproval.$assignedFields.contains('solicitorName') ? mortgagePreApproval.solicitorName : solicitorName,
		solicitorEmail: mortgagePreApproval.$assignedFields.contains('solicitorEmail') ? mortgagePreApproval.solicitorEmail : solicitorEmail,
		createdAt: mortgagePreApproval.$assignedFields.contains('createdAt') ? mortgagePreApproval.createdAt : createdAt,
		updatedAt: mortgagePreApproval.$assignedFields.contains('updatedAt') ? mortgagePreApproval.updatedAt : updatedAt,
		contact: mortgagePreApproval.$assignedFields.contains('contact') ? mortgagePreApproval.contact : contact,
		deal: mortgagePreApproval.$assignedFields.contains('deal') ? mortgagePreApproval.deal : deal,
		org: mortgagePreApproval.$assignedFields.contains('org') ? mortgagePreApproval.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    MortgagePreApproval updateWithInstanceValues(MortgagePreApproval mortgagePreApproval) {
        if (mortgagePreApproval.$assignedFields.contains('id')) { id = mortgagePreApproval.id; }
		if (mortgagePreApproval.$assignedFields.contains('orgId')) { orgId = mortgagePreApproval.orgId; }
		if (mortgagePreApproval.$assignedFields.contains('dealId')) { dealId = mortgagePreApproval.dealId; }
		if (mortgagePreApproval.$assignedFields.contains('contactId')) { contactId = mortgagePreApproval.contactId; }
		if (mortgagePreApproval.$assignedFields.contains('lenderName')) { lenderName = mortgagePreApproval.lenderName; }
		if (mortgagePreApproval.$assignedFields.contains('mortgageType')) { mortgageType = mortgagePreApproval.mortgageType; }
		if (mortgagePreApproval.$assignedFields.contains('mortgageTerm')) { mortgageTerm = mortgagePreApproval.mortgageTerm; }
		if (mortgagePreApproval.$assignedFields.contains('interestRate')) { interestRate = mortgagePreApproval.interestRate; }
		if (mortgagePreApproval.$assignedFields.contains('arrangementFee')) { arrangementFee = mortgagePreApproval.arrangementFee; }
		if (mortgagePreApproval.$assignedFields.contains('valuationFee')) { valuationFee = mortgagePreApproval.valuationFee; }
		if (mortgagePreApproval.$assignedFields.contains('loanAmount')) { loanAmount = mortgagePreApproval.loanAmount; }
		if (mortgagePreApproval.$assignedFields.contains('depositAmount')) { depositAmount = mortgagePreApproval.depositAmount; }
		if (mortgagePreApproval.$assignedFields.contains('loanToValue')) { loanToValue = mortgagePreApproval.loanToValue; }
		if (mortgagePreApproval.$assignedFields.contains('monthlyPayment')) { monthlyPayment = mortgagePreApproval.monthlyPayment; }
		if (mortgagePreApproval.$assignedFields.contains('totalPayable')) { totalPayable = mortgagePreApproval.totalPayable; }
		if (mortgagePreApproval.$assignedFields.contains('offerStatus')) { offerStatus = mortgagePreApproval.offerStatus; }
		if (mortgagePreApproval.$assignedFields.contains('offerDate')) { offerDate = mortgagePreApproval.offerDate; }
		if (mortgagePreApproval.$assignedFields.contains('expiryDate')) { expiryDate = mortgagePreApproval.expiryDate; }
		if (mortgagePreApproval.$assignedFields.contains('acceptedDate')) { acceptedDate = mortgagePreApproval.acceptedDate; }
		if (mortgagePreApproval.$assignedFields.contains('solicitorName')) { solicitorName = mortgagePreApproval.solicitorName; }
		if (mortgagePreApproval.$assignedFields.contains('solicitorEmail')) { solicitorEmail = mortgagePreApproval.solicitorEmail; }
		if (mortgagePreApproval.$assignedFields.contains('createdAt')) { createdAt = mortgagePreApproval.createdAt; }
		if (mortgagePreApproval.$assignedFields.contains('updatedAt')) { updatedAt = mortgagePreApproval.updatedAt; }
		if (mortgagePreApproval.$assignedFields.contains('contact')) { contact = mortgagePreApproval.contact; }
		if (mortgagePreApproval.$assignedFields.contains('deal')) { deal = mortgagePreApproval.deal; }
		if (mortgagePreApproval.$assignedFields.contains('org')) { org = mortgagePreApproval.org; }
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
          ? {...?serializedTypes, 'MortgagePreApproval'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(dealId != null) 'dealId': dealId,
	if(contactId != null) 'contactId': contactId,
	if(lenderName != null) 'lenderName': lenderName,
	if(mortgageType != null) 'mortgageType': mortgageType,
	if(mortgageTerm != null) 'mortgageTerm': mortgageTerm,
	if(interestRate != null) 'interestRate': interestRate,
	if(arrangementFee != null) 'arrangementFee': arrangementFee,
	if(valuationFee != null) 'valuationFee': valuationFee,
	if(loanAmount != null) 'loanAmount': loanAmount,
	if(depositAmount != null) 'depositAmount': depositAmount,
	if(loanToValue != null) 'loanToValue': loanToValue,
	if(monthlyPayment != null) 'monthlyPayment': monthlyPayment,
	if(totalPayable != null) 'totalPayable': totalPayable,
	if(offerStatus != null) 'offerStatus': offerStatus,
	if(offerDate != null) 'offerDate': offerDate?.toIso8601String(),
	if(expiryDate != null) 'expiryDate': expiryDate?.toIso8601String(),
	if(acceptedDate != null) 'acceptedDate': acceptedDate?.toIso8601String(),
	if(solicitorName != null) 'solicitorName': solicitorName,
	if(solicitorEmail != null) 'solicitorEmail': solicitorEmail,
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
            identical(this, other) || other is MortgagePreApproval &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    