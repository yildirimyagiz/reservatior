
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'lease.dart';
import 'organization.dart';
import 'contact.dart';


class RentArrears implements PrismaModel<String, RentArrears> , Id<String> {
    @override
String? id;
	String? orgId;
	String? leaseId;
	String? tenantId;
	DateTime? periodStart;
	DateTime? periodEnd;
	double? rentDue;
	double? rentPaid;
	double? arrearsAmount;
	String? status;
	DateTime? lastPaymentDate;
	bool? noticeSent;
	DateTime? noticeDate;
	String? noticeType;
	bool? legalAction;
	String? legalReference;
	DateTime? courtDate;
	double? recoveryAmount;
	double? writeOffAmount;
	DateTime? createdAt;
	DateTime? updatedAt;
	Lease? lease;
	Organization? org;
	Contact? tenant;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    RentArrears({ this.id,
	 this.orgId,
	 this.leaseId,
	 this.tenantId,
	 this.periodStart,
	 this.periodEnd,
	 this.rentDue,
	 this.rentPaid = 0,
	 this.arrearsAmount = 0,
	 this.status = "CURRENT",
	 this.lastPaymentDate,
	 this.noticeSent = false,
	 this.noticeDate,
	 this.noticeType,
	 this.legalAction = false,
	 this.legalReference,
	 this.courtDate,
	 this.recoveryAmount = 0,
	 this.writeOffAmount = 0,
	 this.createdAt,
	 this.updatedAt,
	 this.lease,
	 this.org,
	 this.tenant,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<RentArrears, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"leaseId": (m) => m.leaseId,

	"tenantId": (m) => m.tenantId,

	"periodStart": (m) => m.periodStart,

	"periodEnd": (m) => m.periodEnd,

	"rentDue": (m) => m.rentDue,

	"rentPaid": (m) => m.rentPaid,

	"arrearsAmount": (m) => m.arrearsAmount,

	"status": (m) => m.status,

	"lastPaymentDate": (m) => m.lastPaymentDate,

	"noticeSent": (m) => m.noticeSent,

	"noticeDate": (m) => m.noticeDate,

	"noticeType": (m) => m.noticeType,

	"legalAction": (m) => m.legalAction,

	"legalReference": (m) => m.legalReference,

	"courtDate": (m) => m.courtDate,

	"recoveryAmount": (m) => m.recoveryAmount,

	"writeOffAmount": (m) => m.writeOffAmount,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"lease": (m) => m.lease,

	"org": (m) => m.org,

	"tenant": (m) => m.tenant,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(RentArrears) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in RentArrears');
    }
    return propFunction as V? Function(RentArrears);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory RentArrears.fromJson(JsonMap json) =>
      RentArrears(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	leaseId: json['leaseId'] as String?,
	tenantId: json['tenantId'] as String?,
	periodStart: json['periodStart'] != null ? DateTime.parse(json['periodStart']) : null,
	periodEnd: json['periodEnd'] != null ? DateTime.parse(json['periodEnd']) : null,
	rentDue: json['rentDue'] as double?,
	rentPaid: json['rentPaid'] as double?,
	arrearsAmount: json['arrearsAmount'] as double?,
	status: json['status'] as String?,
	lastPaymentDate: json['lastPaymentDate'] != null ? DateTime.parse(json['lastPaymentDate']) : null,
	noticeSent: json['noticeSent'] as bool?,
	noticeDate: json['noticeDate'] != null ? DateTime.parse(json['noticeDate']) : null,
	noticeType: json['noticeType'] as String?,
	legalAction: json['legalAction'] as bool?,
	legalReference: json['legalReference'] as String?,
	courtDate: json['courtDate'] != null ? DateTime.parse(json['courtDate']) : null,
	recoveryAmount: json['recoveryAmount'] as double?,
	writeOffAmount: json['writeOffAmount'] as double?,
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
    RentArrears copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? leaseId,
		Value<String?>? tenantId,
		Value<DateTime?>? periodStart,
		Value<DateTime?>? periodEnd,
		Value<double?>? rentDue,
		Value<double?>? rentPaid,
		Value<double?>? arrearsAmount,
		Value<String?>? status,
		Value<DateTime?>? lastPaymentDate,
		Value<bool?>? noticeSent,
		Value<DateTime?>? noticeDate,
		Value<String?>? noticeType,
		Value<bool?>? legalAction,
		Value<String?>? legalReference,
		Value<DateTime?>? courtDate,
		Value<double?>? recoveryAmount,
		Value<double?>? writeOffAmount,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Lease?>? lease,
		Value<Organization?>? org,
		Value<Contact?>? tenant,
        }) {
        return RentArrears(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		tenantId: tenantId != null ? tenantId.value : this.tenantId,
		periodStart: periodStart != null ? periodStart.value : this.periodStart,
		periodEnd: periodEnd != null ? periodEnd.value : this.periodEnd,
		rentDue: rentDue != null ? rentDue.value : this.rentDue,
		rentPaid: rentPaid != null ? rentPaid.value : this.rentPaid,
		arrearsAmount: arrearsAmount != null ? arrearsAmount.value : this.arrearsAmount,
		status: status != null ? status.value : this.status,
		lastPaymentDate: lastPaymentDate != null ? lastPaymentDate.value : this.lastPaymentDate,
		noticeSent: noticeSent != null ? noticeSent.value : this.noticeSent,
		noticeDate: noticeDate != null ? noticeDate.value : this.noticeDate,
		noticeType: noticeType != null ? noticeType.value : this.noticeType,
		legalAction: legalAction != null ? legalAction.value : this.legalAction,
		legalReference: legalReference != null ? legalReference.value : this.legalReference,
		courtDate: courtDate != null ? courtDate.value : this.courtDate,
		recoveryAmount: recoveryAmount != null ? recoveryAmount.value : this.recoveryAmount,
		writeOffAmount: writeOffAmount != null ? writeOffAmount.value : this.writeOffAmount,
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
    RentArrears copyWithInstanceValues(RentArrears rentArrears) {
        return RentArrears(
            id: rentArrears.id ?? id,
		orgId: rentArrears.orgId ?? orgId,
		leaseId: rentArrears.leaseId ?? leaseId,
		tenantId: rentArrears.tenantId ?? tenantId,
		periodStart: rentArrears.periodStart ?? periodStart,
		periodEnd: rentArrears.periodEnd ?? periodEnd,
		rentDue: rentArrears.rentDue ?? rentDue,
		rentPaid: rentArrears.rentPaid ?? rentPaid,
		arrearsAmount: rentArrears.arrearsAmount ?? arrearsAmount,
		status: rentArrears.status ?? status,
		lastPaymentDate: rentArrears.lastPaymentDate ?? lastPaymentDate,
		noticeSent: rentArrears.noticeSent ?? noticeSent,
		noticeDate: rentArrears.noticeDate ?? noticeDate,
		noticeType: rentArrears.noticeType ?? noticeType,
		legalAction: rentArrears.legalAction ?? legalAction,
		legalReference: rentArrears.legalReference ?? legalReference,
		courtDate: rentArrears.courtDate ?? courtDate,
		recoveryAmount: rentArrears.recoveryAmount ?? recoveryAmount,
		writeOffAmount: rentArrears.writeOffAmount ?? writeOffAmount,
		createdAt: rentArrears.createdAt ?? createdAt,
		updatedAt: rentArrears.updatedAt ?? updatedAt,
		lease: rentArrears.lease ?? lease,
		org: rentArrears.org ?? org,
		tenant: rentArrears.tenant ?? tenant
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    RentArrears mergeWithInstanceValues(RentArrears rentArrears) {
        return RentArrears(
            id: rentArrears.$assignedFields.contains('id') ? rentArrears.id : id,
		orgId: rentArrears.$assignedFields.contains('orgId') ? rentArrears.orgId : orgId,
		leaseId: rentArrears.$assignedFields.contains('leaseId') ? rentArrears.leaseId : leaseId,
		tenantId: rentArrears.$assignedFields.contains('tenantId') ? rentArrears.tenantId : tenantId,
		periodStart: rentArrears.$assignedFields.contains('periodStart') ? rentArrears.periodStart : periodStart,
		periodEnd: rentArrears.$assignedFields.contains('periodEnd') ? rentArrears.periodEnd : periodEnd,
		rentDue: rentArrears.$assignedFields.contains('rentDue') ? rentArrears.rentDue : rentDue,
		rentPaid: rentArrears.$assignedFields.contains('rentPaid') ? rentArrears.rentPaid : rentPaid,
		arrearsAmount: rentArrears.$assignedFields.contains('arrearsAmount') ? rentArrears.arrearsAmount : arrearsAmount,
		status: rentArrears.$assignedFields.contains('status') ? rentArrears.status : status,
		lastPaymentDate: rentArrears.$assignedFields.contains('lastPaymentDate') ? rentArrears.lastPaymentDate : lastPaymentDate,
		noticeSent: rentArrears.$assignedFields.contains('noticeSent') ? rentArrears.noticeSent : noticeSent,
		noticeDate: rentArrears.$assignedFields.contains('noticeDate') ? rentArrears.noticeDate : noticeDate,
		noticeType: rentArrears.$assignedFields.contains('noticeType') ? rentArrears.noticeType : noticeType,
		legalAction: rentArrears.$assignedFields.contains('legalAction') ? rentArrears.legalAction : legalAction,
		legalReference: rentArrears.$assignedFields.contains('legalReference') ? rentArrears.legalReference : legalReference,
		courtDate: rentArrears.$assignedFields.contains('courtDate') ? rentArrears.courtDate : courtDate,
		recoveryAmount: rentArrears.$assignedFields.contains('recoveryAmount') ? rentArrears.recoveryAmount : recoveryAmount,
		writeOffAmount: rentArrears.$assignedFields.contains('writeOffAmount') ? rentArrears.writeOffAmount : writeOffAmount,
		createdAt: rentArrears.$assignedFields.contains('createdAt') ? rentArrears.createdAt : createdAt,
		updatedAt: rentArrears.$assignedFields.contains('updatedAt') ? rentArrears.updatedAt : updatedAt,
		lease: rentArrears.$assignedFields.contains('lease') ? rentArrears.lease : lease,
		org: rentArrears.$assignedFields.contains('org') ? rentArrears.org : org,
		tenant: rentArrears.$assignedFields.contains('tenant') ? rentArrears.tenant : tenant
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    RentArrears updateWithInstanceValues(RentArrears rentArrears) {
        if (rentArrears.$assignedFields.contains('id')) { id = rentArrears.id; }
		if (rentArrears.$assignedFields.contains('orgId')) { orgId = rentArrears.orgId; }
		if (rentArrears.$assignedFields.contains('leaseId')) { leaseId = rentArrears.leaseId; }
		if (rentArrears.$assignedFields.contains('tenantId')) { tenantId = rentArrears.tenantId; }
		if (rentArrears.$assignedFields.contains('periodStart')) { periodStart = rentArrears.periodStart; }
		if (rentArrears.$assignedFields.contains('periodEnd')) { periodEnd = rentArrears.periodEnd; }
		if (rentArrears.$assignedFields.contains('rentDue')) { rentDue = rentArrears.rentDue; }
		if (rentArrears.$assignedFields.contains('rentPaid')) { rentPaid = rentArrears.rentPaid; }
		if (rentArrears.$assignedFields.contains('arrearsAmount')) { arrearsAmount = rentArrears.arrearsAmount; }
		if (rentArrears.$assignedFields.contains('status')) { status = rentArrears.status; }
		if (rentArrears.$assignedFields.contains('lastPaymentDate')) { lastPaymentDate = rentArrears.lastPaymentDate; }
		if (rentArrears.$assignedFields.contains('noticeSent')) { noticeSent = rentArrears.noticeSent; }
		if (rentArrears.$assignedFields.contains('noticeDate')) { noticeDate = rentArrears.noticeDate; }
		if (rentArrears.$assignedFields.contains('noticeType')) { noticeType = rentArrears.noticeType; }
		if (rentArrears.$assignedFields.contains('legalAction')) { legalAction = rentArrears.legalAction; }
		if (rentArrears.$assignedFields.contains('legalReference')) { legalReference = rentArrears.legalReference; }
		if (rentArrears.$assignedFields.contains('courtDate')) { courtDate = rentArrears.courtDate; }
		if (rentArrears.$assignedFields.contains('recoveryAmount')) { recoveryAmount = rentArrears.recoveryAmount; }
		if (rentArrears.$assignedFields.contains('writeOffAmount')) { writeOffAmount = rentArrears.writeOffAmount; }
		if (rentArrears.$assignedFields.contains('createdAt')) { createdAt = rentArrears.createdAt; }
		if (rentArrears.$assignedFields.contains('updatedAt')) { updatedAt = rentArrears.updatedAt; }
		if (rentArrears.$assignedFields.contains('lease')) { lease = rentArrears.lease; }
		if (rentArrears.$assignedFields.contains('org')) { org = rentArrears.org; }
		if (rentArrears.$assignedFields.contains('tenant')) { tenant = rentArrears.tenant; }
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
          ? {...?serializedTypes, 'RentArrears'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(leaseId != null) 'leaseId': leaseId,
	if(tenantId != null) 'tenantId': tenantId,
	if(periodStart != null) 'periodStart': periodStart?.toIso8601String(),
	if(periodEnd != null) 'periodEnd': periodEnd?.toIso8601String(),
	if(rentDue != null) 'rentDue': rentDue,
	if(rentPaid != null) 'rentPaid': rentPaid,
	if(arrearsAmount != null) 'arrearsAmount': arrearsAmount,
	if(status != null) 'status': status,
	if(lastPaymentDate != null) 'lastPaymentDate': lastPaymentDate?.toIso8601String(),
	if(noticeSent != null) 'noticeSent': noticeSent,
	if(noticeDate != null) 'noticeDate': noticeDate?.toIso8601String(),
	if(noticeType != null) 'noticeType': noticeType,
	if(legalAction != null) 'legalAction': legalAction,
	if(legalReference != null) 'legalReference': legalReference,
	if(courtDate != null) 'courtDate': courtDate?.toIso8601String(),
	if(recoveryAmount != null) 'recoveryAmount': recoveryAmount,
	if(writeOffAmount != null) 'writeOffAmount': writeOffAmount,
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
            identical(this, other) || other is RentArrears &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    