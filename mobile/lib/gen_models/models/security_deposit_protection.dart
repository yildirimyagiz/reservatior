
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'lease.dart';
import 'organization.dart';


class SecurityDepositProtection implements PrismaModel<String, SecurityDepositProtection> , Id<String> {
    @override
String? id;
	String? orgId;
	String? leaseId;
	String? schemeProvider;
	String? schemeReference;
	double? depositAmount;
	String? currency;
	String? protectionStatus;
	DateTime? protectedDate;
	DateTime? releasedDate;
	dynamic tenantDetails;
	dynamic landlordDetails;
	String? disputeStatus;
	String? disputeReason;
	String? disputeResolution;
	DateTime? createdAt;
	DateTime? updatedAt;
	Lease? lease;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    SecurityDepositProtection({ this.id,
	 this.orgId,
	 this.leaseId,
	 this.schemeProvider,
	 this.schemeReference,
	 this.depositAmount,
	 this.currency = "USD",
	 this.protectionStatus = "PENDING",
	 this.protectedDate,
	 this.releasedDate,
	required this.tenantDetails,
	required this.landlordDetails,
	 this.disputeStatus,
	 this.disputeReason,
	 this.disputeResolution,
	 this.createdAt,
	 this.updatedAt,
	 this.lease,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<SecurityDepositProtection, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"leaseId": (m) => m.leaseId,

	"schemeProvider": (m) => m.schemeProvider,

	"schemeReference": (m) => m.schemeReference,

	"depositAmount": (m) => m.depositAmount,

	"currency": (m) => m.currency,

	"protectionStatus": (m) => m.protectionStatus,

	"protectedDate": (m) => m.protectedDate,

	"releasedDate": (m) => m.releasedDate,

	"tenantDetails": (m) => m.tenantDetails,

	"landlordDetails": (m) => m.landlordDetails,

	"disputeStatus": (m) => m.disputeStatus,

	"disputeReason": (m) => m.disputeReason,

	"disputeResolution": (m) => m.disputeResolution,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"lease": (m) => m.lease,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(SecurityDepositProtection) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in SecurityDepositProtection');
    }
    return propFunction as V? Function(SecurityDepositProtection);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory SecurityDepositProtection.fromJson(JsonMap json) =>
      SecurityDepositProtection(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	leaseId: json['leaseId'] as String?,
	schemeProvider: json['schemeProvider'] as String?,
	schemeReference: json['schemeReference'] as String?,
	depositAmount: json['depositAmount'] as double?,
	currency: json['currency'] as String?,
	protectionStatus: json['protectionStatus'] as String?,
	protectedDate: json['protectedDate'] != null ? DateTime.parse(json['protectedDate']) : null,
	releasedDate: json['releasedDate'] != null ? DateTime.parse(json['releasedDate']) : null,
	tenantDetails: json['tenantDetails'] as dynamic,
	landlordDetails: json['landlordDetails'] as dynamic,
	disputeStatus: json['disputeStatus'] as String?,
	disputeReason: json['disputeReason'] as String?,
	disputeResolution: json['disputeResolution'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	lease: json['lease'] != null ? Lease.fromJson(json['lease'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    SecurityDepositProtection copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? leaseId,
		Value<String?>? schemeProvider,
		Value<String?>? schemeReference,
		Value<double?>? depositAmount,
		Value<String?>? currency,
		Value<String?>? protectionStatus,
		Value<DateTime?>? protectedDate,
		Value<DateTime?>? releasedDate,
		Value<dynamic>? tenantDetails,
		Value<dynamic>? landlordDetails,
		Value<String?>? disputeStatus,
		Value<String?>? disputeReason,
		Value<String?>? disputeResolution,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Lease?>? lease,
		Value<Organization?>? org,
        }) {
        return SecurityDepositProtection(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		leaseId: leaseId != null ? leaseId.value : this.leaseId,
		schemeProvider: schemeProvider != null ? schemeProvider.value : this.schemeProvider,
		schemeReference: schemeReference != null ? schemeReference.value : this.schemeReference,
		depositAmount: depositAmount != null ? depositAmount.value : this.depositAmount,
		currency: currency != null ? currency.value : this.currency,
		protectionStatus: protectionStatus != null ? protectionStatus.value : this.protectionStatus,
		protectedDate: protectedDate != null ? protectedDate.value : this.protectedDate,
		releasedDate: releasedDate != null ? releasedDate.value : this.releasedDate,
		tenantDetails: tenantDetails != null ? tenantDetails.value : this.tenantDetails,
		landlordDetails: landlordDetails != null ? landlordDetails.value : this.landlordDetails,
		disputeStatus: disputeStatus != null ? disputeStatus.value : this.disputeStatus,
		disputeReason: disputeReason != null ? disputeReason.value : this.disputeReason,
		disputeResolution: disputeResolution != null ? disputeResolution.value : this.disputeResolution,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		lease: lease != null ? lease.value : this.lease,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    SecurityDepositProtection copyWithInstanceValues(SecurityDepositProtection securityDepositProtection) {
        return SecurityDepositProtection(
            id: securityDepositProtection.id ?? id,
		orgId: securityDepositProtection.orgId ?? orgId,
		leaseId: securityDepositProtection.leaseId ?? leaseId,
		schemeProvider: securityDepositProtection.schemeProvider ?? schemeProvider,
		schemeReference: securityDepositProtection.schemeReference ?? schemeReference,
		depositAmount: securityDepositProtection.depositAmount ?? depositAmount,
		currency: securityDepositProtection.currency ?? currency,
		protectionStatus: securityDepositProtection.protectionStatus ?? protectionStatus,
		protectedDate: securityDepositProtection.protectedDate ?? protectedDate,
		releasedDate: securityDepositProtection.releasedDate ?? releasedDate,
		tenantDetails: securityDepositProtection.tenantDetails ?? tenantDetails,
		landlordDetails: securityDepositProtection.landlordDetails ?? landlordDetails,
		disputeStatus: securityDepositProtection.disputeStatus ?? disputeStatus,
		disputeReason: securityDepositProtection.disputeReason ?? disputeReason,
		disputeResolution: securityDepositProtection.disputeResolution ?? disputeResolution,
		createdAt: securityDepositProtection.createdAt ?? createdAt,
		updatedAt: securityDepositProtection.updatedAt ?? updatedAt,
		lease: securityDepositProtection.lease ?? lease,
		org: securityDepositProtection.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    SecurityDepositProtection mergeWithInstanceValues(SecurityDepositProtection securityDepositProtection) {
        return SecurityDepositProtection(
            id: securityDepositProtection.$assignedFields.contains('id') ? securityDepositProtection.id : id,
		orgId: securityDepositProtection.$assignedFields.contains('orgId') ? securityDepositProtection.orgId : orgId,
		leaseId: securityDepositProtection.$assignedFields.contains('leaseId') ? securityDepositProtection.leaseId : leaseId,
		schemeProvider: securityDepositProtection.$assignedFields.contains('schemeProvider') ? securityDepositProtection.schemeProvider : schemeProvider,
		schemeReference: securityDepositProtection.$assignedFields.contains('schemeReference') ? securityDepositProtection.schemeReference : schemeReference,
		depositAmount: securityDepositProtection.$assignedFields.contains('depositAmount') ? securityDepositProtection.depositAmount : depositAmount,
		currency: securityDepositProtection.$assignedFields.contains('currency') ? securityDepositProtection.currency : currency,
		protectionStatus: securityDepositProtection.$assignedFields.contains('protectionStatus') ? securityDepositProtection.protectionStatus : protectionStatus,
		protectedDate: securityDepositProtection.$assignedFields.contains('protectedDate') ? securityDepositProtection.protectedDate : protectedDate,
		releasedDate: securityDepositProtection.$assignedFields.contains('releasedDate') ? securityDepositProtection.releasedDate : releasedDate,
		tenantDetails: securityDepositProtection.$assignedFields.contains('tenantDetails') ? securityDepositProtection.tenantDetails : tenantDetails,
		landlordDetails: securityDepositProtection.$assignedFields.contains('landlordDetails') ? securityDepositProtection.landlordDetails : landlordDetails,
		disputeStatus: securityDepositProtection.$assignedFields.contains('disputeStatus') ? securityDepositProtection.disputeStatus : disputeStatus,
		disputeReason: securityDepositProtection.$assignedFields.contains('disputeReason') ? securityDepositProtection.disputeReason : disputeReason,
		disputeResolution: securityDepositProtection.$assignedFields.contains('disputeResolution') ? securityDepositProtection.disputeResolution : disputeResolution,
		createdAt: securityDepositProtection.$assignedFields.contains('createdAt') ? securityDepositProtection.createdAt : createdAt,
		updatedAt: securityDepositProtection.$assignedFields.contains('updatedAt') ? securityDepositProtection.updatedAt : updatedAt,
		lease: securityDepositProtection.$assignedFields.contains('lease') ? securityDepositProtection.lease : lease,
		org: securityDepositProtection.$assignedFields.contains('org') ? securityDepositProtection.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    SecurityDepositProtection updateWithInstanceValues(SecurityDepositProtection securityDepositProtection) {
        if (securityDepositProtection.$assignedFields.contains('id')) { id = securityDepositProtection.id; }
		if (securityDepositProtection.$assignedFields.contains('orgId')) { orgId = securityDepositProtection.orgId; }
		if (securityDepositProtection.$assignedFields.contains('leaseId')) { leaseId = securityDepositProtection.leaseId; }
		if (securityDepositProtection.$assignedFields.contains('schemeProvider')) { schemeProvider = securityDepositProtection.schemeProvider; }
		if (securityDepositProtection.$assignedFields.contains('schemeReference')) { schemeReference = securityDepositProtection.schemeReference; }
		if (securityDepositProtection.$assignedFields.contains('depositAmount')) { depositAmount = securityDepositProtection.depositAmount; }
		if (securityDepositProtection.$assignedFields.contains('currency')) { currency = securityDepositProtection.currency; }
		if (securityDepositProtection.$assignedFields.contains('protectionStatus')) { protectionStatus = securityDepositProtection.protectionStatus; }
		if (securityDepositProtection.$assignedFields.contains('protectedDate')) { protectedDate = securityDepositProtection.protectedDate; }
		if (securityDepositProtection.$assignedFields.contains('releasedDate')) { releasedDate = securityDepositProtection.releasedDate; }
		if (securityDepositProtection.$assignedFields.contains('tenantDetails')) { tenantDetails = securityDepositProtection.tenantDetails; }
		if (securityDepositProtection.$assignedFields.contains('landlordDetails')) { landlordDetails = securityDepositProtection.landlordDetails; }
		if (securityDepositProtection.$assignedFields.contains('disputeStatus')) { disputeStatus = securityDepositProtection.disputeStatus; }
		if (securityDepositProtection.$assignedFields.contains('disputeReason')) { disputeReason = securityDepositProtection.disputeReason; }
		if (securityDepositProtection.$assignedFields.contains('disputeResolution')) { disputeResolution = securityDepositProtection.disputeResolution; }
		if (securityDepositProtection.$assignedFields.contains('createdAt')) { createdAt = securityDepositProtection.createdAt; }
		if (securityDepositProtection.$assignedFields.contains('updatedAt')) { updatedAt = securityDepositProtection.updatedAt; }
		if (securityDepositProtection.$assignedFields.contains('lease')) { lease = securityDepositProtection.lease; }
		if (securityDepositProtection.$assignedFields.contains('org')) { org = securityDepositProtection.org; }
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
          ? {...?serializedTypes, 'SecurityDepositProtection'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(leaseId != null) 'leaseId': leaseId,
	if(schemeProvider != null) 'schemeProvider': schemeProvider,
	if(schemeReference != null) 'schemeReference': schemeReference,
	if(depositAmount != null) 'depositAmount': depositAmount,
	if(currency != null) 'currency': currency,
	if(protectionStatus != null) 'protectionStatus': protectionStatus,
	if(protectedDate != null) 'protectedDate': protectedDate?.toIso8601String(),
	if(releasedDate != null) 'releasedDate': releasedDate?.toIso8601String(),
	if(tenantDetails != null) 'tenantDetails': tenantDetails,
	if(landlordDetails != null) 'landlordDetails': landlordDetails,
	if(disputeStatus != null) 'disputeStatus': disputeStatus,
	if(disputeReason != null) 'disputeReason': disputeReason,
	if(disputeResolution != null) 'disputeResolution': disputeResolution,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(lease != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'lease': lease?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is SecurityDepositProtection &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    