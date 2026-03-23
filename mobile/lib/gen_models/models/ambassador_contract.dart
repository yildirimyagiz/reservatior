
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contract_status.dart';
import 'brand_ambassador.dart';
import 'organization.dart';


class AmbassadorContract implements PrismaModel<String, AmbassadorContract> , Id<String> {
    @override
String? id;
	String? orgId;
	String? ambassadorId;
	int? version;
	double? equityPercent;
	double? upfrontFee;
	String? currency;
	DateTime? startDate;
	DateTime? endDate;
	DateTime? signedAt;
	String? documentUrl;
	ContractStatus? status;
	String? notes;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	BrandAmbassador? ambassador;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    AmbassadorContract({ this.id,
	 this.orgId,
	 this.ambassadorId,
	 this.version,
	 this.equityPercent,
	 this.upfrontFee,
	 this.currency = "USD",
	 this.startDate,
	 this.endDate,
	 this.signedAt,
	 this.documentUrl,
	 this.status = ContractStatus.DRAFT,
	 this.notes,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.ambassador,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<AmbassadorContract, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"ambassadorId": (m) => m.ambassadorId,

	"version": (m) => m.version,

	"equityPercent": (m) => m.equityPercent,

	"upfrontFee": (m) => m.upfrontFee,

	"currency": (m) => m.currency,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"signedAt": (m) => m.signedAt,

	"documentUrl": (m) => m.documentUrl,

	"status": (m) => m.status,

	"notes": (m) => m.notes,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"ambassador": (m) => m.ambassador,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(AmbassadorContract) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in AmbassadorContract');
    }
    return propFunction as V? Function(AmbassadorContract);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory AmbassadorContract.fromJson(JsonMap json) =>
      AmbassadorContract(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	ambassadorId: json['ambassadorId'] as String?,
	version: int.tryParse(json['version'].toString()),
	equityPercent: json['equityPercent']?.toDouble(),
	upfrontFee: json['upfrontFee'] as double?,
	currency: json['currency'] as String?,
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	signedAt: json['signedAt'] != null ? DateTime.parse(json['signedAt']) : null,
	documentUrl: json['documentUrl'] as String?,
	status: json['status'] != null ? ContractStatus.fromJson(json['status']) : null,
	notes: json['notes'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	ambassador: json['ambassador'] != null ? BrandAmbassador.fromJson(json['ambassador'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    AmbassadorContract copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? ambassadorId,
		Value<int?>? version,
		Value<double?>? equityPercent,
		Value<double?>? upfrontFee,
		Value<String?>? currency,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<DateTime?>? signedAt,
		Value<String?>? documentUrl,
		Value<ContractStatus?>? status,
		Value<String?>? notes,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<BrandAmbassador?>? ambassador,
		Value<Organization?>? org,
        }) {
        return AmbassadorContract(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		ambassadorId: ambassadorId != null ? ambassadorId.value : this.ambassadorId,
		version: version != null ? version.value : this.version,
		equityPercent: equityPercent != null ? equityPercent.value : this.equityPercent,
		upfrontFee: upfrontFee != null ? upfrontFee.value : this.upfrontFee,
		currency: currency != null ? currency.value : this.currency,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		signedAt: signedAt != null ? signedAt.value : this.signedAt,
		documentUrl: documentUrl != null ? documentUrl.value : this.documentUrl,
		status: status != null ? status.value : this.status,
		notes: notes != null ? notes.value : this.notes,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		ambassador: ambassador != null ? ambassador.value : this.ambassador,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    AmbassadorContract copyWithInstanceValues(AmbassadorContract ambassadorContract) {
        return AmbassadorContract(
            id: ambassadorContract.id ?? id,
		orgId: ambassadorContract.orgId ?? orgId,
		ambassadorId: ambassadorContract.ambassadorId ?? ambassadorId,
		version: ambassadorContract.version ?? version,
		equityPercent: ambassadorContract.equityPercent ?? equityPercent,
		upfrontFee: ambassadorContract.upfrontFee ?? upfrontFee,
		currency: ambassadorContract.currency ?? currency,
		startDate: ambassadorContract.startDate ?? startDate,
		endDate: ambassadorContract.endDate ?? endDate,
		signedAt: ambassadorContract.signedAt ?? signedAt,
		documentUrl: ambassadorContract.documentUrl ?? documentUrl,
		status: ambassadorContract.status ?? status,
		notes: ambassadorContract.notes ?? notes,
		createdAt: ambassadorContract.createdAt ?? createdAt,
		updatedAt: ambassadorContract.updatedAt ?? updatedAt,
		deletedAt: ambassadorContract.deletedAt ?? deletedAt,
		ambassador: ambassadorContract.ambassador ?? ambassador,
		org: ambassadorContract.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    AmbassadorContract mergeWithInstanceValues(AmbassadorContract ambassadorContract) {
        return AmbassadorContract(
            id: ambassadorContract.$assignedFields.contains('id') ? ambassadorContract.id : id,
		orgId: ambassadorContract.$assignedFields.contains('orgId') ? ambassadorContract.orgId : orgId,
		ambassadorId: ambassadorContract.$assignedFields.contains('ambassadorId') ? ambassadorContract.ambassadorId : ambassadorId,
		version: ambassadorContract.$assignedFields.contains('version') ? ambassadorContract.version : version,
		equityPercent: ambassadorContract.$assignedFields.contains('equityPercent') ? ambassadorContract.equityPercent : equityPercent,
		upfrontFee: ambassadorContract.$assignedFields.contains('upfrontFee') ? ambassadorContract.upfrontFee : upfrontFee,
		currency: ambassadorContract.$assignedFields.contains('currency') ? ambassadorContract.currency : currency,
		startDate: ambassadorContract.$assignedFields.contains('startDate') ? ambassadorContract.startDate : startDate,
		endDate: ambassadorContract.$assignedFields.contains('endDate') ? ambassadorContract.endDate : endDate,
		signedAt: ambassadorContract.$assignedFields.contains('signedAt') ? ambassadorContract.signedAt : signedAt,
		documentUrl: ambassadorContract.$assignedFields.contains('documentUrl') ? ambassadorContract.documentUrl : documentUrl,
		status: ambassadorContract.$assignedFields.contains('status') ? ambassadorContract.status : status,
		notes: ambassadorContract.$assignedFields.contains('notes') ? ambassadorContract.notes : notes,
		createdAt: ambassadorContract.$assignedFields.contains('createdAt') ? ambassadorContract.createdAt : createdAt,
		updatedAt: ambassadorContract.$assignedFields.contains('updatedAt') ? ambassadorContract.updatedAt : updatedAt,
		deletedAt: ambassadorContract.$assignedFields.contains('deletedAt') ? ambassadorContract.deletedAt : deletedAt,
		ambassador: ambassadorContract.$assignedFields.contains('ambassador') ? ambassadorContract.ambassador : ambassador,
		org: ambassadorContract.$assignedFields.contains('org') ? ambassadorContract.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    AmbassadorContract updateWithInstanceValues(AmbassadorContract ambassadorContract) {
        if (ambassadorContract.$assignedFields.contains('id')) { id = ambassadorContract.id; }
		if (ambassadorContract.$assignedFields.contains('orgId')) { orgId = ambassadorContract.orgId; }
		if (ambassadorContract.$assignedFields.contains('ambassadorId')) { ambassadorId = ambassadorContract.ambassadorId; }
		if (ambassadorContract.$assignedFields.contains('version')) { version = ambassadorContract.version; }
		if (ambassadorContract.$assignedFields.contains('equityPercent')) { equityPercent = ambassadorContract.equityPercent; }
		if (ambassadorContract.$assignedFields.contains('upfrontFee')) { upfrontFee = ambassadorContract.upfrontFee; }
		if (ambassadorContract.$assignedFields.contains('currency')) { currency = ambassadorContract.currency; }
		if (ambassadorContract.$assignedFields.contains('startDate')) { startDate = ambassadorContract.startDate; }
		if (ambassadorContract.$assignedFields.contains('endDate')) { endDate = ambassadorContract.endDate; }
		if (ambassadorContract.$assignedFields.contains('signedAt')) { signedAt = ambassadorContract.signedAt; }
		if (ambassadorContract.$assignedFields.contains('documentUrl')) { documentUrl = ambassadorContract.documentUrl; }
		if (ambassadorContract.$assignedFields.contains('status')) { status = ambassadorContract.status; }
		if (ambassadorContract.$assignedFields.contains('notes')) { notes = ambassadorContract.notes; }
		if (ambassadorContract.$assignedFields.contains('createdAt')) { createdAt = ambassadorContract.createdAt; }
		if (ambassadorContract.$assignedFields.contains('updatedAt')) { updatedAt = ambassadorContract.updatedAt; }
		if (ambassadorContract.$assignedFields.contains('deletedAt')) { deletedAt = ambassadorContract.deletedAt; }
		if (ambassadorContract.$assignedFields.contains('ambassador')) { ambassador = ambassadorContract.ambassador; }
		if (ambassadorContract.$assignedFields.contains('org')) { org = ambassadorContract.org; }
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
          ? {...?serializedTypes, 'AmbassadorContract'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(ambassadorId != null) 'ambassadorId': ambassadorId,
	if(version != null) 'version': version,
	if(equityPercent != null) 'equityPercent': equityPercent,
	if(upfrontFee != null) 'upfrontFee': upfrontFee,
	if(currency != null) 'currency': currency,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(signedAt != null) 'signedAt': signedAt?.toIso8601String(),
	if(documentUrl != null) 'documentUrl': documentUrl,
	if(status != null) 'status': status?.toJson(),
	if(notes != null) 'notes': notes,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(ambassador != null && (!preventCircularSerialization || !serializedModels.contains('BrandAmbassador'))) 'ambassador': ambassador?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is AmbassadorContract &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    