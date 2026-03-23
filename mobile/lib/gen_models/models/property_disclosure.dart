
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'property.dart';


class PropertyDisclosure implements PrismaModel<String, PropertyDisclosure> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? packStatus;
	DateTime? createdDate;
	DateTime? submittedDate;
	dynamic energyPerformanceCertificate;
	dynamic floorPlan;
	dynamic leaseholdInfo;
	dynamic boundaryPlan;
	dynamic planningPermission;
	dynamic propertyQuestionnaire;
	dynamic electricalSafety;
	dynamic gasSafety;
	dynamic fireSafety;
	String? completionNotes;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PropertyDisclosure({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.packStatus = "INCOMPLETE",
	 this.createdDate,
	 this.submittedDate,
	required this.energyPerformanceCertificate,
	required this.floorPlan,
	required this.leaseholdInfo,
	required this.boundaryPlan,
	required this.planningPermission,
	required this.propertyQuestionnaire,
	required this.electricalSafety,
	required this.gasSafety,
	required this.fireSafety,
	 this.completionNotes,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PropertyDisclosure, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"packStatus": (m) => m.packStatus,

	"createdDate": (m) => m.createdDate,

	"submittedDate": (m) => m.submittedDate,

	"energyPerformanceCertificate": (m) => m.energyPerformanceCertificate,

	"floorPlan": (m) => m.floorPlan,

	"leaseholdInfo": (m) => m.leaseholdInfo,

	"boundaryPlan": (m) => m.boundaryPlan,

	"planningPermission": (m) => m.planningPermission,

	"propertyQuestionnaire": (m) => m.propertyQuestionnaire,

	"electricalSafety": (m) => m.electricalSafety,

	"gasSafety": (m) => m.gasSafety,

	"fireSafety": (m) => m.fireSafety,

	"completionNotes": (m) => m.completionNotes,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PropertyDisclosure) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PropertyDisclosure');
    }
    return propFunction as V? Function(PropertyDisclosure);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PropertyDisclosure.fromJson(JsonMap json) =>
      PropertyDisclosure(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	packStatus: json['packStatus'] as String?,
	createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : null,
	submittedDate: json['submittedDate'] != null ? DateTime.parse(json['submittedDate']) : null,
	energyPerformanceCertificate: json['energyPerformanceCertificate'] as dynamic,
	floorPlan: json['floorPlan'] as dynamic,
	leaseholdInfo: json['leaseholdInfo'] as dynamic,
	boundaryPlan: json['boundaryPlan'] as dynamic,
	planningPermission: json['planningPermission'] as dynamic,
	propertyQuestionnaire: json['propertyQuestionnaire'] as dynamic,
	electricalSafety: json['electricalSafety'] as dynamic,
	gasSafety: json['gasSafety'] as dynamic,
	fireSafety: json['fireSafety'] as dynamic,
	completionNotes: json['completionNotes'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PropertyDisclosure copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? packStatus,
		Value<DateTime?>? createdDate,
		Value<DateTime?>? submittedDate,
		Value<dynamic>? energyPerformanceCertificate,
		Value<dynamic>? floorPlan,
		Value<dynamic>? leaseholdInfo,
		Value<dynamic>? boundaryPlan,
		Value<dynamic>? planningPermission,
		Value<dynamic>? propertyQuestionnaire,
		Value<dynamic>? electricalSafety,
		Value<dynamic>? gasSafety,
		Value<dynamic>? fireSafety,
		Value<String?>? completionNotes,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return PropertyDisclosure(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		packStatus: packStatus != null ? packStatus.value : this.packStatus,
		createdDate: createdDate != null ? createdDate.value : this.createdDate,
		submittedDate: submittedDate != null ? submittedDate.value : this.submittedDate,
		energyPerformanceCertificate: energyPerformanceCertificate != null ? energyPerformanceCertificate.value : this.energyPerformanceCertificate,
		floorPlan: floorPlan != null ? floorPlan.value : this.floorPlan,
		leaseholdInfo: leaseholdInfo != null ? leaseholdInfo.value : this.leaseholdInfo,
		boundaryPlan: boundaryPlan != null ? boundaryPlan.value : this.boundaryPlan,
		planningPermission: planningPermission != null ? planningPermission.value : this.planningPermission,
		propertyQuestionnaire: propertyQuestionnaire != null ? propertyQuestionnaire.value : this.propertyQuestionnaire,
		electricalSafety: electricalSafety != null ? electricalSafety.value : this.electricalSafety,
		gasSafety: gasSafety != null ? gasSafety.value : this.gasSafety,
		fireSafety: fireSafety != null ? fireSafety.value : this.fireSafety,
		completionNotes: completionNotes != null ? completionNotes.value : this.completionNotes,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PropertyDisclosure copyWithInstanceValues(PropertyDisclosure propertyDisclosure) {
        return PropertyDisclosure(
            id: propertyDisclosure.id ?? id,
		orgId: propertyDisclosure.orgId ?? orgId,
		propertyId: propertyDisclosure.propertyId ?? propertyId,
		packStatus: propertyDisclosure.packStatus ?? packStatus,
		createdDate: propertyDisclosure.createdDate ?? createdDate,
		submittedDate: propertyDisclosure.submittedDate ?? submittedDate,
		energyPerformanceCertificate: propertyDisclosure.energyPerformanceCertificate ?? energyPerformanceCertificate,
		floorPlan: propertyDisclosure.floorPlan ?? floorPlan,
		leaseholdInfo: propertyDisclosure.leaseholdInfo ?? leaseholdInfo,
		boundaryPlan: propertyDisclosure.boundaryPlan ?? boundaryPlan,
		planningPermission: propertyDisclosure.planningPermission ?? planningPermission,
		propertyQuestionnaire: propertyDisclosure.propertyQuestionnaire ?? propertyQuestionnaire,
		electricalSafety: propertyDisclosure.electricalSafety ?? electricalSafety,
		gasSafety: propertyDisclosure.gasSafety ?? gasSafety,
		fireSafety: propertyDisclosure.fireSafety ?? fireSafety,
		completionNotes: propertyDisclosure.completionNotes ?? completionNotes,
		createdAt: propertyDisclosure.createdAt ?? createdAt,
		updatedAt: propertyDisclosure.updatedAt ?? updatedAt,
		org: propertyDisclosure.org ?? org,
		property: propertyDisclosure.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PropertyDisclosure mergeWithInstanceValues(PropertyDisclosure propertyDisclosure) {
        return PropertyDisclosure(
            id: propertyDisclosure.$assignedFields.contains('id') ? propertyDisclosure.id : id,
		orgId: propertyDisclosure.$assignedFields.contains('orgId') ? propertyDisclosure.orgId : orgId,
		propertyId: propertyDisclosure.$assignedFields.contains('propertyId') ? propertyDisclosure.propertyId : propertyId,
		packStatus: propertyDisclosure.$assignedFields.contains('packStatus') ? propertyDisclosure.packStatus : packStatus,
		createdDate: propertyDisclosure.$assignedFields.contains('createdDate') ? propertyDisclosure.createdDate : createdDate,
		submittedDate: propertyDisclosure.$assignedFields.contains('submittedDate') ? propertyDisclosure.submittedDate : submittedDate,
		energyPerformanceCertificate: propertyDisclosure.$assignedFields.contains('energyPerformanceCertificate') ? propertyDisclosure.energyPerformanceCertificate : energyPerformanceCertificate,
		floorPlan: propertyDisclosure.$assignedFields.contains('floorPlan') ? propertyDisclosure.floorPlan : floorPlan,
		leaseholdInfo: propertyDisclosure.$assignedFields.contains('leaseholdInfo') ? propertyDisclosure.leaseholdInfo : leaseholdInfo,
		boundaryPlan: propertyDisclosure.$assignedFields.contains('boundaryPlan') ? propertyDisclosure.boundaryPlan : boundaryPlan,
		planningPermission: propertyDisclosure.$assignedFields.contains('planningPermission') ? propertyDisclosure.planningPermission : planningPermission,
		propertyQuestionnaire: propertyDisclosure.$assignedFields.contains('propertyQuestionnaire') ? propertyDisclosure.propertyQuestionnaire : propertyQuestionnaire,
		electricalSafety: propertyDisclosure.$assignedFields.contains('electricalSafety') ? propertyDisclosure.electricalSafety : electricalSafety,
		gasSafety: propertyDisclosure.$assignedFields.contains('gasSafety') ? propertyDisclosure.gasSafety : gasSafety,
		fireSafety: propertyDisclosure.$assignedFields.contains('fireSafety') ? propertyDisclosure.fireSafety : fireSafety,
		completionNotes: propertyDisclosure.$assignedFields.contains('completionNotes') ? propertyDisclosure.completionNotes : completionNotes,
		createdAt: propertyDisclosure.$assignedFields.contains('createdAt') ? propertyDisclosure.createdAt : createdAt,
		updatedAt: propertyDisclosure.$assignedFields.contains('updatedAt') ? propertyDisclosure.updatedAt : updatedAt,
		org: propertyDisclosure.$assignedFields.contains('org') ? propertyDisclosure.org : org,
		property: propertyDisclosure.$assignedFields.contains('property') ? propertyDisclosure.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PropertyDisclosure updateWithInstanceValues(PropertyDisclosure propertyDisclosure) {
        if (propertyDisclosure.$assignedFields.contains('id')) { id = propertyDisclosure.id; }
		if (propertyDisclosure.$assignedFields.contains('orgId')) { orgId = propertyDisclosure.orgId; }
		if (propertyDisclosure.$assignedFields.contains('propertyId')) { propertyId = propertyDisclosure.propertyId; }
		if (propertyDisclosure.$assignedFields.contains('packStatus')) { packStatus = propertyDisclosure.packStatus; }
		if (propertyDisclosure.$assignedFields.contains('createdDate')) { createdDate = propertyDisclosure.createdDate; }
		if (propertyDisclosure.$assignedFields.contains('submittedDate')) { submittedDate = propertyDisclosure.submittedDate; }
		if (propertyDisclosure.$assignedFields.contains('energyPerformanceCertificate')) { energyPerformanceCertificate = propertyDisclosure.energyPerformanceCertificate; }
		if (propertyDisclosure.$assignedFields.contains('floorPlan')) { floorPlan = propertyDisclosure.floorPlan; }
		if (propertyDisclosure.$assignedFields.contains('leaseholdInfo')) { leaseholdInfo = propertyDisclosure.leaseholdInfo; }
		if (propertyDisclosure.$assignedFields.contains('boundaryPlan')) { boundaryPlan = propertyDisclosure.boundaryPlan; }
		if (propertyDisclosure.$assignedFields.contains('planningPermission')) { planningPermission = propertyDisclosure.planningPermission; }
		if (propertyDisclosure.$assignedFields.contains('propertyQuestionnaire')) { propertyQuestionnaire = propertyDisclosure.propertyQuestionnaire; }
		if (propertyDisclosure.$assignedFields.contains('electricalSafety')) { electricalSafety = propertyDisclosure.electricalSafety; }
		if (propertyDisclosure.$assignedFields.contains('gasSafety')) { gasSafety = propertyDisclosure.gasSafety; }
		if (propertyDisclosure.$assignedFields.contains('fireSafety')) { fireSafety = propertyDisclosure.fireSafety; }
		if (propertyDisclosure.$assignedFields.contains('completionNotes')) { completionNotes = propertyDisclosure.completionNotes; }
		if (propertyDisclosure.$assignedFields.contains('createdAt')) { createdAt = propertyDisclosure.createdAt; }
		if (propertyDisclosure.$assignedFields.contains('updatedAt')) { updatedAt = propertyDisclosure.updatedAt; }
		if (propertyDisclosure.$assignedFields.contains('org')) { org = propertyDisclosure.org; }
		if (propertyDisclosure.$assignedFields.contains('property')) { property = propertyDisclosure.property; }
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
          ? {...?serializedTypes, 'PropertyDisclosure'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(packStatus != null) 'packStatus': packStatus,
	if(createdDate != null) 'createdDate': createdDate?.toIso8601String(),
	if(submittedDate != null) 'submittedDate': submittedDate?.toIso8601String(),
	if(energyPerformanceCertificate != null) 'energyPerformanceCertificate': energyPerformanceCertificate,
	if(floorPlan != null) 'floorPlan': floorPlan,
	if(leaseholdInfo != null) 'leaseholdInfo': leaseholdInfo,
	if(boundaryPlan != null) 'boundaryPlan': boundaryPlan,
	if(planningPermission != null) 'planningPermission': planningPermission,
	if(propertyQuestionnaire != null) 'propertyQuestionnaire': propertyQuestionnaire,
	if(electricalSafety != null) 'electricalSafety': electricalSafety,
	if(gasSafety != null) 'gasSafety': gasSafety,
	if(fireSafety != null) 'fireSafety': fireSafety,
	if(completionNotes != null) 'completionNotes': completionNotes,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PropertyDisclosure &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    