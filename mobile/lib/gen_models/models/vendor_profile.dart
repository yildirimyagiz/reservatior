
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';


class VendorProfile implements PrismaModel<String, VendorProfile> , Id<String> {
    @override
String? id;
	String? orgId;
	String? legalName;
	String? serviceAreas;
	int? defaultCommissionBps;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    VendorProfile({ this.id,
	 this.orgId,
	 this.legalName,
	 this.serviceAreas,
	 this.defaultCommissionBps,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<VendorProfile, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"legalName": (m) => m.legalName,

	"serviceAreas": (m) => m.serviceAreas,

	"defaultCommissionBps": (m) => m.defaultCommissionBps,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(VendorProfile) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in VendorProfile');
    }
    return propFunction as V? Function(VendorProfile);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory VendorProfile.fromJson(JsonMap json) =>
      VendorProfile(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	legalName: json['legalName'] as String?,
	serviceAreas: json['serviceAreas'] as String?,
	defaultCommissionBps: int.tryParse(json['defaultCommissionBps'].toString()),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    VendorProfile copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? legalName,
		Value<String?>? serviceAreas,
		Value<int?>? defaultCommissionBps,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
        }) {
        return VendorProfile(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		legalName: legalName != null ? legalName.value : this.legalName,
		serviceAreas: serviceAreas != null ? serviceAreas.value : this.serviceAreas,
		defaultCommissionBps: defaultCommissionBps != null ? defaultCommissionBps.value : this.defaultCommissionBps,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    VendorProfile copyWithInstanceValues(VendorProfile vendorProfile) {
        return VendorProfile(
            id: vendorProfile.id ?? id,
		orgId: vendorProfile.orgId ?? orgId,
		legalName: vendorProfile.legalName ?? legalName,
		serviceAreas: vendorProfile.serviceAreas ?? serviceAreas,
		defaultCommissionBps: vendorProfile.defaultCommissionBps ?? defaultCommissionBps,
		createdAt: vendorProfile.createdAt ?? createdAt,
		updatedAt: vendorProfile.updatedAt ?? updatedAt,
		deletedAt: vendorProfile.deletedAt ?? deletedAt,
		org: vendorProfile.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    VendorProfile mergeWithInstanceValues(VendorProfile vendorProfile) {
        return VendorProfile(
            id: vendorProfile.$assignedFields.contains('id') ? vendorProfile.id : id,
		orgId: vendorProfile.$assignedFields.contains('orgId') ? vendorProfile.orgId : orgId,
		legalName: vendorProfile.$assignedFields.contains('legalName') ? vendorProfile.legalName : legalName,
		serviceAreas: vendorProfile.$assignedFields.contains('serviceAreas') ? vendorProfile.serviceAreas : serviceAreas,
		defaultCommissionBps: vendorProfile.$assignedFields.contains('defaultCommissionBps') ? vendorProfile.defaultCommissionBps : defaultCommissionBps,
		createdAt: vendorProfile.$assignedFields.contains('createdAt') ? vendorProfile.createdAt : createdAt,
		updatedAt: vendorProfile.$assignedFields.contains('updatedAt') ? vendorProfile.updatedAt : updatedAt,
		deletedAt: vendorProfile.$assignedFields.contains('deletedAt') ? vendorProfile.deletedAt : deletedAt,
		org: vendorProfile.$assignedFields.contains('org') ? vendorProfile.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    VendorProfile updateWithInstanceValues(VendorProfile vendorProfile) {
        if (vendorProfile.$assignedFields.contains('id')) { id = vendorProfile.id; }
		if (vendorProfile.$assignedFields.contains('orgId')) { orgId = vendorProfile.orgId; }
		if (vendorProfile.$assignedFields.contains('legalName')) { legalName = vendorProfile.legalName; }
		if (vendorProfile.$assignedFields.contains('serviceAreas')) { serviceAreas = vendorProfile.serviceAreas; }
		if (vendorProfile.$assignedFields.contains('defaultCommissionBps')) { defaultCommissionBps = vendorProfile.defaultCommissionBps; }
		if (vendorProfile.$assignedFields.contains('createdAt')) { createdAt = vendorProfile.createdAt; }
		if (vendorProfile.$assignedFields.contains('updatedAt')) { updatedAt = vendorProfile.updatedAt; }
		if (vendorProfile.$assignedFields.contains('deletedAt')) { deletedAt = vendorProfile.deletedAt; }
		if (vendorProfile.$assignedFields.contains('org')) { org = vendorProfile.org; }
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
          ? {...?serializedTypes, 'VendorProfile'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(legalName != null) 'legalName': legalName,
	if(serviceAreas != null) 'serviceAreas': serviceAreas,
	if(defaultCommissionBps != null) 'defaultCommissionBps': defaultCommissionBps,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is VendorProfile &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    