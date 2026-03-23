
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'signature_status.dart';
import 'contract.dart';
import 'organization.dart';
import 'signature_signer.dart';


class SignatureRequest implements PrismaModel<String, SignatureRequest> , Id<String> {
    @override
String? id;
	String? orgId;
	String? contractId;
	String? provider;
	SignatureStatus? status;
	String? signUrl;
	String? signedDocumentUrl;
	DateTime? expiresAt;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contract? contract;
	Organization? org;
	List<SignatureSigner>? signers;
	int? $signersCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    SignatureRequest({ this.id,
	 this.orgId,
	 this.contractId,
	 this.provider,
	 this.status = SignatureStatus.PENDING,
	 this.signUrl,
	 this.signedDocumentUrl,
	 this.expiresAt,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contract,
	 this.org,
	 this.signers,
	this.$signersCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<SignatureRequest, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"contractId": (m) => m.contractId,

	"provider": (m) => m.provider,

	"status": (m) => m.status,

	"signUrl": (m) => m.signUrl,

	"signedDocumentUrl": (m) => m.signedDocumentUrl,

	"expiresAt": (m) => m.expiresAt,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contract": (m) => m.contract,

	"org": (m) => m.org,

	"signers": (m) => m.signers,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(SignatureRequest) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in SignatureRequest');
    }
    return propFunction as V? Function(SignatureRequest);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory SignatureRequest.fromJson(JsonMap json) =>
      SignatureRequest(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	contractId: json['contractId'] as String?,
	provider: json['provider'] as String?,
	status: json['status'] != null ? SignatureStatus.fromJson(json['status']) : null,
	signUrl: json['signUrl'] as String?,
	signedDocumentUrl: json['signedDocumentUrl'] as String?,
	expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contract: json['contract'] != null ? Contract.fromJson(json['contract'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	signers: json['signers'] != null ? createModels<SignatureSigner>((json['signers'] as List).cast<JsonMap>(), SignatureSigner.fromJson) : null,
	$signersCount: json['_count']?['signers'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    SignatureRequest copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? contractId,
		Value<String?>? provider,
		Value<SignatureStatus?>? status,
		Value<String?>? signUrl,
		Value<String?>? signedDocumentUrl,
		Value<DateTime?>? expiresAt,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contract?>? contract,
		Value<Organization?>? org,
		Value<List<SignatureSigner>?>? signers,
		int? $signersCount,
        }) {
        return SignatureRequest(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		contractId: contractId != null ? contractId.value : this.contractId,
		provider: provider != null ? provider.value : this.provider,
		status: status != null ? status.value : this.status,
		signUrl: signUrl != null ? signUrl.value : this.signUrl,
		signedDocumentUrl: signedDocumentUrl != null ? signedDocumentUrl.value : this.signedDocumentUrl,
		expiresAt: expiresAt != null ? expiresAt.value : this.expiresAt,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contract: contract != null ? contract.value : this.contract,
		org: org != null ? org.value : this.org,
		signers: signers != null ? signers.value : this.signers,
		$signersCount: $signersCount ?? this.$signersCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    SignatureRequest copyWithInstanceValues(SignatureRequest signatureRequest) {
        return SignatureRequest(
            id: signatureRequest.id ?? id,
		orgId: signatureRequest.orgId ?? orgId,
		contractId: signatureRequest.contractId ?? contractId,
		provider: signatureRequest.provider ?? provider,
		status: signatureRequest.status ?? status,
		signUrl: signatureRequest.signUrl ?? signUrl,
		signedDocumentUrl: signatureRequest.signedDocumentUrl ?? signedDocumentUrl,
		expiresAt: signatureRequest.expiresAt ?? expiresAt,
		createdBy: signatureRequest.createdBy ?? createdBy,
		createdAt: signatureRequest.createdAt ?? createdAt,
		updatedAt: signatureRequest.updatedAt ?? updatedAt,
		deletedAt: signatureRequest.deletedAt ?? deletedAt,
		contract: signatureRequest.contract ?? contract,
		org: signatureRequest.org ?? org,
		signers: signatureRequest.signers ?? signers,
		$signersCount: signatureRequest.$signersCount ?? $signersCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    SignatureRequest mergeWithInstanceValues(SignatureRequest signatureRequest) {
        return SignatureRequest(
            id: signatureRequest.$assignedFields.contains('id') ? signatureRequest.id : id,
		orgId: signatureRequest.$assignedFields.contains('orgId') ? signatureRequest.orgId : orgId,
		contractId: signatureRequest.$assignedFields.contains('contractId') ? signatureRequest.contractId : contractId,
		provider: signatureRequest.$assignedFields.contains('provider') ? signatureRequest.provider : provider,
		status: signatureRequest.$assignedFields.contains('status') ? signatureRequest.status : status,
		signUrl: signatureRequest.$assignedFields.contains('signUrl') ? signatureRequest.signUrl : signUrl,
		signedDocumentUrl: signatureRequest.$assignedFields.contains('signedDocumentUrl') ? signatureRequest.signedDocumentUrl : signedDocumentUrl,
		expiresAt: signatureRequest.$assignedFields.contains('expiresAt') ? signatureRequest.expiresAt : expiresAt,
		createdBy: signatureRequest.$assignedFields.contains('createdBy') ? signatureRequest.createdBy : createdBy,
		createdAt: signatureRequest.$assignedFields.contains('createdAt') ? signatureRequest.createdAt : createdAt,
		updatedAt: signatureRequest.$assignedFields.contains('updatedAt') ? signatureRequest.updatedAt : updatedAt,
		deletedAt: signatureRequest.$assignedFields.contains('deletedAt') ? signatureRequest.deletedAt : deletedAt,
		contract: signatureRequest.$assignedFields.contains('contract') ? signatureRequest.contract : contract,
		org: signatureRequest.$assignedFields.contains('org') ? signatureRequest.org : org,
		signers: (signatureRequest.$assignedFields.contains('signers') && signatureRequest.signers != null) ? mergeModelLists(signers, signatureRequest.signers) : signers,
		$signersCount: signatureRequest.$signersCount ?? $signersCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    SignatureRequest updateWithInstanceValues(SignatureRequest signatureRequest) {
        if (signatureRequest.$assignedFields.contains('id')) { id = signatureRequest.id; }
		if (signatureRequest.$assignedFields.contains('orgId')) { orgId = signatureRequest.orgId; }
		if (signatureRequest.$assignedFields.contains('contractId')) { contractId = signatureRequest.contractId; }
		if (signatureRequest.$assignedFields.contains('provider')) { provider = signatureRequest.provider; }
		if (signatureRequest.$assignedFields.contains('status')) { status = signatureRequest.status; }
		if (signatureRequest.$assignedFields.contains('signUrl')) { signUrl = signatureRequest.signUrl; }
		if (signatureRequest.$assignedFields.contains('signedDocumentUrl')) { signedDocumentUrl = signatureRequest.signedDocumentUrl; }
		if (signatureRequest.$assignedFields.contains('expiresAt')) { expiresAt = signatureRequest.expiresAt; }
		if (signatureRequest.$assignedFields.contains('createdBy')) { createdBy = signatureRequest.createdBy; }
		if (signatureRequest.$assignedFields.contains('createdAt')) { createdAt = signatureRequest.createdAt; }
		if (signatureRequest.$assignedFields.contains('updatedAt')) { updatedAt = signatureRequest.updatedAt; }
		if (signatureRequest.$assignedFields.contains('deletedAt')) { deletedAt = signatureRequest.deletedAt; }
		if (signatureRequest.$assignedFields.contains('contract')) { contract = signatureRequest.contract; }
		if (signatureRequest.$assignedFields.contains('org')) { org = signatureRequest.org; }
		if (signatureRequest.$assignedFields.contains('signers') && signatureRequest.signers != null) { signers = mergeModelLists(signers, signatureRequest.signers); }
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
          ? {...?serializedTypes, 'SignatureRequest'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(contractId != null) 'contractId': contractId,
	if(provider != null) 'provider': provider,
	if(status != null) 'status': status?.toJson(),
	if(signUrl != null) 'signUrl': signUrl,
	if(signedDocumentUrl != null) 'signedDocumentUrl': signedDocumentUrl,
	if(expiresAt != null) 'expiresAt': expiresAt?.toIso8601String(),
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contract != null && (!preventCircularSerialization || !serializedModels.contains('Contract'))) 'contract': contract?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(signers != null && (!preventCircularSerialization || !serializedModels.contains('SignatureSigner'))) 'signers': signers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($signersCount != null) '_count': { 
		if ($signersCount != null) 'signers': $signersCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is SignatureRequest &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    