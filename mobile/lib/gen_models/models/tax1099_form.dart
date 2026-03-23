
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'u_s_tax_form.dart';
import 'organization.dart';
import 'contact.dart';


class Tax1099Form implements PrismaModel<String, Tax1099Form> , Id<String> {
    @override
String? id;
	String? orgId;
	String? recipientId;
	int? taxYear;
	USTaxForm? formType;
	double? amount;
	String? description;
	DateTime? issuedAt;
	DateTime? mailedAt;
	Organization? org;
	Contact? recipient;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Tax1099Form({ this.id,
	 this.orgId,
	 this.recipientId,
	 this.taxYear,
	 this.formType,
	 this.amount,
	 this.description,
	 this.issuedAt,
	 this.mailedAt,
	 this.org,
	 this.recipient,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Tax1099Form, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"recipientId": (m) => m.recipientId,

	"taxYear": (m) => m.taxYear,

	"formType": (m) => m.formType,

	"amount": (m) => m.amount,

	"description": (m) => m.description,

	"issuedAt": (m) => m.issuedAt,

	"mailedAt": (m) => m.mailedAt,

	"org": (m) => m.org,

	"recipient": (m) => m.recipient,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Tax1099Form) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Tax1099Form');
    }
    return propFunction as V? Function(Tax1099Form);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Tax1099Form.fromJson(JsonMap json) =>
      Tax1099Form(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	recipientId: json['recipientId'] as String?,
	taxYear: int.tryParse(json['taxYear'].toString()),
	formType: json['formType'] != null ? USTaxForm.fromJson(json['formType']) : null,
	amount: json['amount'] as double?,
	description: json['description'] as String?,
	issuedAt: json['issuedAt'] != null ? DateTime.parse(json['issuedAt']) : null,
	mailedAt: json['mailedAt'] != null ? DateTime.parse(json['mailedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	recipient: json['recipient'] != null ? Contact.fromJson(json['recipient'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Tax1099Form copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? recipientId,
		Value<int?>? taxYear,
		Value<USTaxForm?>? formType,
		Value<double?>? amount,
		Value<String?>? description,
		Value<DateTime?>? issuedAt,
		Value<DateTime?>? mailedAt,
		Value<Organization?>? org,
		Value<Contact?>? recipient,
        }) {
        return Tax1099Form(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		recipientId: recipientId != null ? recipientId.value : this.recipientId,
		taxYear: taxYear != null ? taxYear.value : this.taxYear,
		formType: formType != null ? formType.value : this.formType,
		amount: amount != null ? amount.value : this.amount,
		description: description != null ? description.value : this.description,
		issuedAt: issuedAt != null ? issuedAt.value : this.issuedAt,
		mailedAt: mailedAt != null ? mailedAt.value : this.mailedAt,
		org: org != null ? org.value : this.org,
		recipient: recipient != null ? recipient.value : this.recipient
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Tax1099Form copyWithInstanceValues(Tax1099Form tax1099Form) {
        return Tax1099Form(
            id: tax1099Form.id ?? id,
		orgId: tax1099Form.orgId ?? orgId,
		recipientId: tax1099Form.recipientId ?? recipientId,
		taxYear: tax1099Form.taxYear ?? taxYear,
		formType: tax1099Form.formType ?? formType,
		amount: tax1099Form.amount ?? amount,
		description: tax1099Form.description ?? description,
		issuedAt: tax1099Form.issuedAt ?? issuedAt,
		mailedAt: tax1099Form.mailedAt ?? mailedAt,
		org: tax1099Form.org ?? org,
		recipient: tax1099Form.recipient ?? recipient
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Tax1099Form mergeWithInstanceValues(Tax1099Form tax1099Form) {
        return Tax1099Form(
            id: tax1099Form.$assignedFields.contains('id') ? tax1099Form.id : id,
		orgId: tax1099Form.$assignedFields.contains('orgId') ? tax1099Form.orgId : orgId,
		recipientId: tax1099Form.$assignedFields.contains('recipientId') ? tax1099Form.recipientId : recipientId,
		taxYear: tax1099Form.$assignedFields.contains('taxYear') ? tax1099Form.taxYear : taxYear,
		formType: tax1099Form.$assignedFields.contains('formType') ? tax1099Form.formType : formType,
		amount: tax1099Form.$assignedFields.contains('amount') ? tax1099Form.amount : amount,
		description: tax1099Form.$assignedFields.contains('description') ? tax1099Form.description : description,
		issuedAt: tax1099Form.$assignedFields.contains('issuedAt') ? tax1099Form.issuedAt : issuedAt,
		mailedAt: tax1099Form.$assignedFields.contains('mailedAt') ? tax1099Form.mailedAt : mailedAt,
		org: tax1099Form.$assignedFields.contains('org') ? tax1099Form.org : org,
		recipient: tax1099Form.$assignedFields.contains('recipient') ? tax1099Form.recipient : recipient
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Tax1099Form updateWithInstanceValues(Tax1099Form tax1099Form) {
        if (tax1099Form.$assignedFields.contains('id')) { id = tax1099Form.id; }
		if (tax1099Form.$assignedFields.contains('orgId')) { orgId = tax1099Form.orgId; }
		if (tax1099Form.$assignedFields.contains('recipientId')) { recipientId = tax1099Form.recipientId; }
		if (tax1099Form.$assignedFields.contains('taxYear')) { taxYear = tax1099Form.taxYear; }
		if (tax1099Form.$assignedFields.contains('formType')) { formType = tax1099Form.formType; }
		if (tax1099Form.$assignedFields.contains('amount')) { amount = tax1099Form.amount; }
		if (tax1099Form.$assignedFields.contains('description')) { description = tax1099Form.description; }
		if (tax1099Form.$assignedFields.contains('issuedAt')) { issuedAt = tax1099Form.issuedAt; }
		if (tax1099Form.$assignedFields.contains('mailedAt')) { mailedAt = tax1099Form.mailedAt; }
		if (tax1099Form.$assignedFields.contains('org')) { org = tax1099Form.org; }
		if (tax1099Form.$assignedFields.contains('recipient')) { recipient = tax1099Form.recipient; }
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
          ? {...?serializedTypes, 'Tax1099Form'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(recipientId != null) 'recipientId': recipientId,
	if(taxYear != null) 'taxYear': taxYear,
	if(formType != null) 'formType': formType?.toJson(),
	if(amount != null) 'amount': amount,
	if(description != null) 'description': description,
	if(issuedAt != null) 'issuedAt': issuedAt?.toIso8601String(),
	if(mailedAt != null) 'mailedAt': mailedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(recipient != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'recipient': recipient?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Tax1099Form &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    