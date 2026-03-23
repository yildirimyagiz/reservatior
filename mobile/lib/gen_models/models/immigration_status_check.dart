
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'lease.dart';
import 'organization.dart';
import 'contact.dart';


class ImmigrationStatusCheck implements PrismaModel<String, ImmigrationStatusCheck> , Id<String> {
    @override
String? id;
	String? orgId;
	String? leaseId;
	String? tenantId;
	String? checkStatus;
	DateTime? checkDate;
	DateTime? validUntil;
	String? immigrationStatus;
	String? visaType;
	DateTime? visaExpiry;
	String? documentType;
	String? documentNumber;
	bool? documentVerified;
	String? shareCode;
	String? checkReference;
	String? notes;
	DateTime? createdAt;
	DateTime? updatedAt;
	Lease? lease;
	Organization? org;
	Contact? tenant;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ImmigrationStatusCheck({ this.id,
	 this.orgId,
	 this.leaseId,
	 this.tenantId,
	 this.checkStatus = "PENDING",
	 this.checkDate,
	 this.validUntil,
	 this.immigrationStatus,
	 this.visaType,
	 this.visaExpiry,
	 this.documentType,
	 this.documentNumber,
	 this.documentVerified = false,
	 this.shareCode,
	 this.checkReference,
	 this.notes,
	 this.createdAt,
	 this.updatedAt,
	 this.lease,
	 this.org,
	 this.tenant,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ImmigrationStatusCheck, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"leaseId": (m) => m.leaseId,

	"tenantId": (m) => m.tenantId,

	"checkStatus": (m) => m.checkStatus,

	"checkDate": (m) => m.checkDate,

	"validUntil": (m) => m.validUntil,

	"immigrationStatus": (m) => m.immigrationStatus,

	"visaType": (m) => m.visaType,

	"visaExpiry": (m) => m.visaExpiry,

	"documentType": (m) => m.documentType,

	"documentNumber": (m) => m.documentNumber,

	"documentVerified": (m) => m.documentVerified,

	"shareCode": (m) => m.shareCode,

	"checkReference": (m) => m.checkReference,

	"notes": (m) => m.notes,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"lease": (m) => m.lease,

	"org": (m) => m.org,

	"tenant": (m) => m.tenant,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ImmigrationStatusCheck) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ImmigrationStatusCheck');
    }
    return propFunction as V? Function(ImmigrationStatusCheck);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ImmigrationStatusCheck.fromJson(JsonMap json) =>
      ImmigrationStatusCheck(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	leaseId: json['leaseId'] as String?,
	tenantId: json['tenantId'] as String?,
	checkStatus: json['checkStatus'] as String?,
	checkDate: json['checkDate'] != null ? DateTime.parse(json['checkDate']) : null,
	validUntil: json['validUntil'] != null ? DateTime.parse(json['validUntil']) : null,
	immigrationStatus: json['immigrationStatus'] as String?,
	visaType: json['visaType'] as String?,
	visaExpiry: json['visaExpiry'] != null ? DateTime.parse(json['visaExpiry']) : null,
	documentType: json['documentType'] as String?,
	documentNumber: json['documentNumber'] as String?,
	documentVerified: json['documentVerified'] as bool?,
	shareCode: json['shareCode'] as String?,
	checkReference: json['checkReference'] as String?,
	notes: json['notes'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	lease: json['lease'] != null ? Lease.fromJson(json['lease'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	tenant: json['tenant'] != null ? Contact.fromJson(json['tenant'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ImmigrationStatusCheck copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? leaseId,
		Value<String?>? tenantId,
		Value<String?>? checkStatus,
		Value<DateTime?>? checkDate,
		Value<DateTime?>? validUntil,
		Value<String?>? immigrationStatus,
		Value<String?>? visaType,
		Value<DateTime?>? visaExpiry,
		Value<String?>? documentType,
		Value<String?>? documentNumber,
		Value<bool?>? documentVerified,
		Value<String?>? shareCode,
		Value<String?>? checkReference,
		Value<String?>? notes,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Lease?>? lease,
		Value<Organization?>? org,
		Value<Contact?>? tenant,
        }) {
        return ImmigrationStatusCheck(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		tenantId: tenantId != null ? tenantId.value : this.tenantId,
		checkStatus: checkStatus != null ? checkStatus.value : this.checkStatus,
		checkDate: checkDate != null ? checkDate.value : this.checkDate,
		validUntil: validUntil != null ? validUntil.value : this.validUntil,
		immigrationStatus: immigrationStatus != null ? immigrationStatus.value : this.immigrationStatus,
		visaType: visaType != null ? visaType.value : this.visaType,
		visaExpiry: visaExpiry != null ? visaExpiry.value : this.visaExpiry,
		documentType: documentType != null ? documentType.value : this.documentType,
		documentNumber: documentNumber != null ? documentNumber.value : this.documentNumber,
		documentVerified: documentVerified != null ? documentVerified.value : this.documentVerified,
		shareCode: shareCode != null ? shareCode.value : this.shareCode,
		checkReference: checkReference != null ? checkReference.value : this.checkReference,
		notes: notes != null ? notes.value : this.notes,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		lease: lease != null ? lease.value : this.lease,
		org: org != null ? org.value : this.org,
		tenant: tenant != null ? tenant.value : this.tenant
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ImmigrationStatusCheck copyWithInstanceValues(ImmigrationStatusCheck immigrationStatusCheck) {
        return ImmigrationStatusCheck(
            id: immigrationStatusCheck.id ?? id,
		orgId: immigrationStatusCheck.orgId ?? orgId,
		leaseId: immigrationStatusCheck.leaseId ?? leaseId,
		tenantId: immigrationStatusCheck.tenantId ?? tenantId,
		checkStatus: immigrationStatusCheck.checkStatus ?? checkStatus,
		checkDate: immigrationStatusCheck.checkDate ?? checkDate,
		validUntil: immigrationStatusCheck.validUntil ?? validUntil,
		immigrationStatus: immigrationStatusCheck.immigrationStatus ?? immigrationStatus,
		visaType: immigrationStatusCheck.visaType ?? visaType,
		visaExpiry: immigrationStatusCheck.visaExpiry ?? visaExpiry,
		documentType: immigrationStatusCheck.documentType ?? documentType,
		documentNumber: immigrationStatusCheck.documentNumber ?? documentNumber,
		documentVerified: immigrationStatusCheck.documentVerified ?? documentVerified,
		shareCode: immigrationStatusCheck.shareCode ?? shareCode,
		checkReference: immigrationStatusCheck.checkReference ?? checkReference,
		notes: immigrationStatusCheck.notes ?? notes,
		createdAt: immigrationStatusCheck.createdAt ?? createdAt,
		updatedAt: immigrationStatusCheck.updatedAt ?? updatedAt,
		lease: immigrationStatusCheck.lease ?? lease,
		org: immigrationStatusCheck.org ?? org,
		tenant: immigrationStatusCheck.tenant ?? tenant
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ImmigrationStatusCheck mergeWithInstanceValues(ImmigrationStatusCheck immigrationStatusCheck) {
        return ImmigrationStatusCheck(
            id: immigrationStatusCheck.$assignedFields.contains('id') ? immigrationStatusCheck.id : id,
		orgId: immigrationStatusCheck.$assignedFields.contains('orgId') ? immigrationStatusCheck.orgId : orgId,
		leaseId: immigrationStatusCheck.$assignedFields.contains('leaseId') ? immigrationStatusCheck.leaseId : leaseId,
		tenantId: immigrationStatusCheck.$assignedFields.contains('tenantId') ? immigrationStatusCheck.tenantId : tenantId,
		checkStatus: immigrationStatusCheck.$assignedFields.contains('checkStatus') ? immigrationStatusCheck.checkStatus : checkStatus,
		checkDate: immigrationStatusCheck.$assignedFields.contains('checkDate') ? immigrationStatusCheck.checkDate : checkDate,
		validUntil: immigrationStatusCheck.$assignedFields.contains('validUntil') ? immigrationStatusCheck.validUntil : validUntil,
		immigrationStatus: immigrationStatusCheck.$assignedFields.contains('immigrationStatus') ? immigrationStatusCheck.immigrationStatus : immigrationStatus,
		visaType: immigrationStatusCheck.$assignedFields.contains('visaType') ? immigrationStatusCheck.visaType : visaType,
		visaExpiry: immigrationStatusCheck.$assignedFields.contains('visaExpiry') ? immigrationStatusCheck.visaExpiry : visaExpiry,
		documentType: immigrationStatusCheck.$assignedFields.contains('documentType') ? immigrationStatusCheck.documentType : documentType,
		documentNumber: immigrationStatusCheck.$assignedFields.contains('documentNumber') ? immigrationStatusCheck.documentNumber : documentNumber,
		documentVerified: immigrationStatusCheck.$assignedFields.contains('documentVerified') ? immigrationStatusCheck.documentVerified : documentVerified,
		shareCode: immigrationStatusCheck.$assignedFields.contains('shareCode') ? immigrationStatusCheck.shareCode : shareCode,
		checkReference: immigrationStatusCheck.$assignedFields.contains('checkReference') ? immigrationStatusCheck.checkReference : checkReference,
		notes: immigrationStatusCheck.$assignedFields.contains('notes') ? immigrationStatusCheck.notes : notes,
		createdAt: immigrationStatusCheck.$assignedFields.contains('createdAt') ? immigrationStatusCheck.createdAt : createdAt,
		updatedAt: immigrationStatusCheck.$assignedFields.contains('updatedAt') ? immigrationStatusCheck.updatedAt : updatedAt,
		lease: immigrationStatusCheck.$assignedFields.contains('lease') ? immigrationStatusCheck.lease : lease,
		org: immigrationStatusCheck.$assignedFields.contains('org') ? immigrationStatusCheck.org : org,
		tenant: immigrationStatusCheck.$assignedFields.contains('tenant') ? immigrationStatusCheck.tenant : tenant
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ImmigrationStatusCheck updateWithInstanceValues(ImmigrationStatusCheck immigrationStatusCheck) {
        if (immigrationStatusCheck.$assignedFields.contains('id')) { id = immigrationStatusCheck.id; }
		if (immigrationStatusCheck.$assignedFields.contains('orgId')) { orgId = immigrationStatusCheck.orgId; }
		if (immigrationStatusCheck.$assignedFields.contains('leaseId')) { leaseId = immigrationStatusCheck.leaseId; }
		if (immigrationStatusCheck.$assignedFields.contains('tenantId')) { tenantId = immigrationStatusCheck.tenantId; }
		if (immigrationStatusCheck.$assignedFields.contains('checkStatus')) { checkStatus = immigrationStatusCheck.checkStatus; }
		if (immigrationStatusCheck.$assignedFields.contains('checkDate')) { checkDate = immigrationStatusCheck.checkDate; }
		if (immigrationStatusCheck.$assignedFields.contains('validUntil')) { validUntil = immigrationStatusCheck.validUntil; }
		if (immigrationStatusCheck.$assignedFields.contains('immigrationStatus')) { immigrationStatus = immigrationStatusCheck.immigrationStatus; }
		if (immigrationStatusCheck.$assignedFields.contains('visaType')) { visaType = immigrationStatusCheck.visaType; }
		if (immigrationStatusCheck.$assignedFields.contains('visaExpiry')) { visaExpiry = immigrationStatusCheck.visaExpiry; }
		if (immigrationStatusCheck.$assignedFields.contains('documentType')) { documentType = immigrationStatusCheck.documentType; }
		if (immigrationStatusCheck.$assignedFields.contains('documentNumber')) { documentNumber = immigrationStatusCheck.documentNumber; }
		if (immigrationStatusCheck.$assignedFields.contains('documentVerified')) { documentVerified = immigrationStatusCheck.documentVerified; }
		if (immigrationStatusCheck.$assignedFields.contains('shareCode')) { shareCode = immigrationStatusCheck.shareCode; }
		if (immigrationStatusCheck.$assignedFields.contains('checkReference')) { checkReference = immigrationStatusCheck.checkReference; }
		if (immigrationStatusCheck.$assignedFields.contains('notes')) { notes = immigrationStatusCheck.notes; }
		if (immigrationStatusCheck.$assignedFields.contains('createdAt')) { createdAt = immigrationStatusCheck.createdAt; }
		if (immigrationStatusCheck.$assignedFields.contains('updatedAt')) { updatedAt = immigrationStatusCheck.updatedAt; }
		if (immigrationStatusCheck.$assignedFields.contains('lease')) { lease = immigrationStatusCheck.lease; }
		if (immigrationStatusCheck.$assignedFields.contains('org')) { org = immigrationStatusCheck.org; }
		if (immigrationStatusCheck.$assignedFields.contains('tenant')) { tenant = immigrationStatusCheck.tenant; }
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
          ? {...?serializedTypes, 'ImmigrationStatusCheck'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(leaseId != null) 'leaseId': leaseId,
	if(tenantId != null) 'tenantId': tenantId,
	if(checkStatus != null) 'checkStatus': checkStatus,
	if(checkDate != null) 'checkDate': checkDate?.toIso8601String(),
	if(validUntil != null) 'validUntil': validUntil?.toIso8601String(),
	if(immigrationStatus != null) 'immigrationStatus': immigrationStatus,
	if(visaType != null) 'visaType': visaType,
	if(visaExpiry != null) 'visaExpiry': visaExpiry?.toIso8601String(),
	if(documentType != null) 'documentType': documentType,
	if(documentNumber != null) 'documentNumber': documentNumber,
	if(documentVerified != null) 'documentVerified': documentVerified,
	if(shareCode != null) 'shareCode': shareCode,
	if(checkReference != null) 'checkReference': checkReference,
	if(notes != null) 'notes': notes,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'lease': lease?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(tenant != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'tenant': tenant?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ImmigrationStatusCheck &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    