
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contract.dart';
import 'organization.dart';


class ContractVersion implements PrismaModel<String, ContractVersion> , Id<String> {
    @override
String? id;
	String? orgId;
	String? contractId;
	int? version;
	String? documentUrl;
	String? checksum;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contract? contract;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ContractVersion({ this.id,
	 this.orgId,
	 this.contractId,
	 this.version,
	 this.documentUrl,
	 this.checksum,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contract,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ContractVersion, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"contractId": (m) => m.contractId,

	"version": (m) => m.version,

	"documentUrl": (m) => m.documentUrl,

	"checksum": (m) => m.checksum,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contract": (m) => m.contract,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ContractVersion) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ContractVersion');
    }
    return propFunction as V? Function(ContractVersion);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ContractVersion.fromJson(JsonMap json) =>
      ContractVersion(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	contractId: json['contractId'] as String?,
	version: int.tryParse(json['version'].toString()),
	documentUrl: json['documentUrl'] as String?,
	checksum: json['checksum'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contract: json['contract'] != null ? Contract.fromJson(json['contract'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ContractVersion copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? contractId,
		Value<int?>? version,
		Value<String?>? documentUrl,
		Value<String?>? checksum,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contract?>? contract,
		Value<Organization?>? org,
        }) {
        return ContractVersion(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		contractId: contractId != null ? contractId.value : this.contractId,
		version: version != null ? version.value : this.version,
		documentUrl: documentUrl != null ? documentUrl.value : this.documentUrl,
		checksum: checksum != null ? checksum.value : this.checksum,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contract: contract != null ? contract.value : this.contract,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ContractVersion copyWithInstanceValues(ContractVersion contractVersion) {
        return ContractVersion(
            id: contractVersion.id ?? id,
		orgId: contractVersion.orgId ?? orgId,
		contractId: contractVersion.contractId ?? contractId,
		version: contractVersion.version ?? version,
		documentUrl: contractVersion.documentUrl ?? documentUrl,
		checksum: contractVersion.checksum ?? checksum,
		createdBy: contractVersion.createdBy ?? createdBy,
		createdAt: contractVersion.createdAt ?? createdAt,
		updatedAt: contractVersion.updatedAt ?? updatedAt,
		deletedAt: contractVersion.deletedAt ?? deletedAt,
		contract: contractVersion.contract ?? contract,
		org: contractVersion.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ContractVersion mergeWithInstanceValues(ContractVersion contractVersion) {
        return ContractVersion(
            id: contractVersion.$assignedFields.contains('id') ? contractVersion.id : id,
		orgId: contractVersion.$assignedFields.contains('orgId') ? contractVersion.orgId : orgId,
		contractId: contractVersion.$assignedFields.contains('contractId') ? contractVersion.contractId : contractId,
		version: contractVersion.$assignedFields.contains('version') ? contractVersion.version : version,
		documentUrl: contractVersion.$assignedFields.contains('documentUrl') ? contractVersion.documentUrl : documentUrl,
		checksum: contractVersion.$assignedFields.contains('checksum') ? contractVersion.checksum : checksum,
		createdBy: contractVersion.$assignedFields.contains('createdBy') ? contractVersion.createdBy : createdBy,
		createdAt: contractVersion.$assignedFields.contains('createdAt') ? contractVersion.createdAt : createdAt,
		updatedAt: contractVersion.$assignedFields.contains('updatedAt') ? contractVersion.updatedAt : updatedAt,
		deletedAt: contractVersion.$assignedFields.contains('deletedAt') ? contractVersion.deletedAt : deletedAt,
		contract: contractVersion.$assignedFields.contains('contract') ? contractVersion.contract : contract,
		org: contractVersion.$assignedFields.contains('org') ? contractVersion.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ContractVersion updateWithInstanceValues(ContractVersion contractVersion) {
        if (contractVersion.$assignedFields.contains('id')) { id = contractVersion.id; }
		if (contractVersion.$assignedFields.contains('orgId')) { orgId = contractVersion.orgId; }
		if (contractVersion.$assignedFields.contains('contractId')) { contractId = contractVersion.contractId; }
		if (contractVersion.$assignedFields.contains('version')) { version = contractVersion.version; }
		if (contractVersion.$assignedFields.contains('documentUrl')) { documentUrl = contractVersion.documentUrl; }
		if (contractVersion.$assignedFields.contains('checksum')) { checksum = contractVersion.checksum; }
		if (contractVersion.$assignedFields.contains('createdBy')) { createdBy = contractVersion.createdBy; }
		if (contractVersion.$assignedFields.contains('createdAt')) { createdAt = contractVersion.createdAt; }
		if (contractVersion.$assignedFields.contains('updatedAt')) { updatedAt = contractVersion.updatedAt; }
		if (contractVersion.$assignedFields.contains('deletedAt')) { deletedAt = contractVersion.deletedAt; }
		if (contractVersion.$assignedFields.contains('contract')) { contract = contractVersion.contract; }
		if (contractVersion.$assignedFields.contains('org')) { org = contractVersion.org; }
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
          ? {...?serializedTypes, 'ContractVersion'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(contractId != null) 'contractId': contractId,
	if(version != null) 'version': version,
	if(documentUrl != null) 'documentUrl': documentUrl,
	if(checksum != null) 'checksum': checksum,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contract != null && (!preventCircularSerialization || !serializedModels.contains('Contract'))) 'contract': contract?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ContractVersion &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    