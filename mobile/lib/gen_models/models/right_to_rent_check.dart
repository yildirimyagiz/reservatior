
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact.dart';
import 'lease.dart';
import 'organization.dart';


class RightToRentCheck implements PrismaModel<String, RightToRentCheck> , Id<String> {
    @override
String? id;
	String? orgId;
	String? leaseId;
	String? contactId;
	String? checkType;
	String? reference;
	String? status;
	DateTime? checkedAt;
	DateTime? expiresAt;
	dynamic result;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contact? contact;
	Lease? lease;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    RightToRentCheck({ this.id,
	 this.orgId,
	 this.leaseId,
	 this.contactId,
	 this.checkType,
	 this.reference,
	 this.status = "pending",
	 this.checkedAt,
	 this.expiresAt,
	required this.result,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contact,
	 this.lease,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<RightToRentCheck, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"leaseId": (m) => m.leaseId,

	"contactId": (m) => m.contactId,

	"checkType": (m) => m.checkType,

	"reference": (m) => m.reference,

	"status": (m) => m.status,

	"checkedAt": (m) => m.checkedAt,

	"expiresAt": (m) => m.expiresAt,

	"result": (m) => m.result,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contact": (m) => m.contact,

	"lease": (m) => m.lease,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(RightToRentCheck) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in RightToRentCheck');
    }
    return propFunction as V? Function(RightToRentCheck);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory RightToRentCheck.fromJson(JsonMap json) =>
      RightToRentCheck(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	leaseId: json['leaseId'] as String?,
	contactId: json['contactId'] as String?,
	checkType: json['checkType'] as String?,
	reference: json['reference'] as String?,
	status: json['status'] as String?,
	checkedAt: json['checkedAt'] != null ? DateTime.parse(json['checkedAt']) : null,
	expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
	result: json['result'] as dynamic,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contact: json['contact'] != null ? Contact.fromJson(json['contact'] as JsonMap) : null,
	lease: json['lease'] != null ? Lease.fromJson(json['lease'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    RightToRentCheck copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? leaseId,
		Value<String?>? contactId,
		Value<String?>? checkType,
		Value<String?>? reference,
		Value<String?>? status,
		Value<DateTime?>? checkedAt,
		Value<DateTime?>? expiresAt,
		Value<dynamic>? result,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contact?>? contact,
		Value<Lease?>? lease,
		Value<Organization?>? org,
        }) {
        return RightToRentCheck(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		contactId: contactId != null ? contactId.value : this.contactId,
		checkType: checkType != null ? checkType.value : this.checkType,
		reference: reference != null ? reference.value : this.reference,
		status: status != null ? status.value : this.status,
		checkedAt: checkedAt != null ? checkedAt.value : this.checkedAt,
		expiresAt: expiresAt != null ? expiresAt.value : this.expiresAt,
		result: result != null ? result.value : this.result,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contact: contact != null ? contact.value : this.contact,
		lease: lease != null ? lease.value : this.lease,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    RightToRentCheck copyWithInstanceValues(RightToRentCheck rightToRentCheck) {
        return RightToRentCheck(
            id: rightToRentCheck.id ?? id,
		orgId: rightToRentCheck.orgId ?? orgId,
		leaseId: rightToRentCheck.leaseId ?? leaseId,
		contactId: rightToRentCheck.contactId ?? contactId,
		checkType: rightToRentCheck.checkType ?? checkType,
		reference: rightToRentCheck.reference ?? reference,
		status: rightToRentCheck.status ?? status,
		checkedAt: rightToRentCheck.checkedAt ?? checkedAt,
		expiresAt: rightToRentCheck.expiresAt ?? expiresAt,
		result: rightToRentCheck.result ?? result,
		createdBy: rightToRentCheck.createdBy ?? createdBy,
		createdAt: rightToRentCheck.createdAt ?? createdAt,
		updatedAt: rightToRentCheck.updatedAt ?? updatedAt,
		deletedAt: rightToRentCheck.deletedAt ?? deletedAt,
		contact: rightToRentCheck.contact ?? contact,
		lease: rightToRentCheck.lease ?? lease,
		org: rightToRentCheck.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    RightToRentCheck mergeWithInstanceValues(RightToRentCheck rightToRentCheck) {
        return RightToRentCheck(
            id: rightToRentCheck.$assignedFields.contains('id') ? rightToRentCheck.id : id,
		orgId: rightToRentCheck.$assignedFields.contains('orgId') ? rightToRentCheck.orgId : orgId,
		leaseId: rightToRentCheck.$assignedFields.contains('leaseId') ? rightToRentCheck.leaseId : leaseId,
		contactId: rightToRentCheck.$assignedFields.contains('contactId') ? rightToRentCheck.contactId : contactId,
		checkType: rightToRentCheck.$assignedFields.contains('checkType') ? rightToRentCheck.checkType : checkType,
		reference: rightToRentCheck.$assignedFields.contains('reference') ? rightToRentCheck.reference : reference,
		status: rightToRentCheck.$assignedFields.contains('status') ? rightToRentCheck.status : status,
		checkedAt: rightToRentCheck.$assignedFields.contains('checkedAt') ? rightToRentCheck.checkedAt : checkedAt,
		expiresAt: rightToRentCheck.$assignedFields.contains('expiresAt') ? rightToRentCheck.expiresAt : expiresAt,
		result: rightToRentCheck.$assignedFields.contains('result') ? rightToRentCheck.result : result,
		createdBy: rightToRentCheck.$assignedFields.contains('createdBy') ? rightToRentCheck.createdBy : createdBy,
		createdAt: rightToRentCheck.$assignedFields.contains('createdAt') ? rightToRentCheck.createdAt : createdAt,
		updatedAt: rightToRentCheck.$assignedFields.contains('updatedAt') ? rightToRentCheck.updatedAt : updatedAt,
		deletedAt: rightToRentCheck.$assignedFields.contains('deletedAt') ? rightToRentCheck.deletedAt : deletedAt,
		contact: rightToRentCheck.$assignedFields.contains('contact') ? rightToRentCheck.contact : contact,
		lease: rightToRentCheck.$assignedFields.contains('lease') ? rightToRentCheck.lease : lease,
		org: rightToRentCheck.$assignedFields.contains('org') ? rightToRentCheck.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    RightToRentCheck updateWithInstanceValues(RightToRentCheck rightToRentCheck) {
        if (rightToRentCheck.$assignedFields.contains('id')) { id = rightToRentCheck.id; }
		if (rightToRentCheck.$assignedFields.contains('orgId')) { orgId = rightToRentCheck.orgId; }
		if (rightToRentCheck.$assignedFields.contains('leaseId')) { leaseId = rightToRentCheck.leaseId; }
		if (rightToRentCheck.$assignedFields.contains('contactId')) { contactId = rightToRentCheck.contactId; }
		if (rightToRentCheck.$assignedFields.contains('checkType')) { checkType = rightToRentCheck.checkType; }
		if (rightToRentCheck.$assignedFields.contains('reference')) { reference = rightToRentCheck.reference; }
		if (rightToRentCheck.$assignedFields.contains('status')) { status = rightToRentCheck.status; }
		if (rightToRentCheck.$assignedFields.contains('checkedAt')) { checkedAt = rightToRentCheck.checkedAt; }
		if (rightToRentCheck.$assignedFields.contains('expiresAt')) { expiresAt = rightToRentCheck.expiresAt; }
		if (rightToRentCheck.$assignedFields.contains('result')) { result = rightToRentCheck.result; }
		if (rightToRentCheck.$assignedFields.contains('createdBy')) { createdBy = rightToRentCheck.createdBy; }
		if (rightToRentCheck.$assignedFields.contains('createdAt')) { createdAt = rightToRentCheck.createdAt; }
		if (rightToRentCheck.$assignedFields.contains('updatedAt')) { updatedAt = rightToRentCheck.updatedAt; }
		if (rightToRentCheck.$assignedFields.contains('deletedAt')) { deletedAt = rightToRentCheck.deletedAt; }
		if (rightToRentCheck.$assignedFields.contains('contact')) { contact = rightToRentCheck.contact; }
		if (rightToRentCheck.$assignedFields.contains('lease')) { lease = rightToRentCheck.lease; }
		if (rightToRentCheck.$assignedFields.contains('org')) { org = rightToRentCheck.org; }
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
          ? {...?serializedTypes, 'RightToRentCheck'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(leaseId != null) 'leaseId': leaseId,
	if(contactId != null) 'contactId': contactId,
	if(checkType != null) 'checkType': checkType,
	if(reference != null) 'reference': reference,
	if(status != null) 'status': status,
	if(checkedAt != null) 'checkedAt': checkedAt?.toIso8601String(),
	if(expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
	if(result != null) 'result': result,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contact != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'contact': contact?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'lease': lease?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is RightToRentCheck &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    