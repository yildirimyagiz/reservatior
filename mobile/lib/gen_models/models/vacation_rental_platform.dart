
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'rental_platform.dart';
import 'rental_status.dart';
import 'vacation_rental.dart';


class VacationRentalPlatform implements PrismaModel<String, VacationRentalPlatform> , Id<String> {
    @override
String? id;
	String? rentalId;
	RentalPlatform? platform;
	String? externalId;
	String? externalUrl;
	RentalStatus? status;
	DateTime? lastSyncedAt;
	bool? syncEnabled;
	DateTime? createdAt;
	DateTime? updatedAt;
	VacationRental? rental;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    VacationRentalPlatform({ this.id,
	 this.rentalId,
	 this.platform,
	 this.externalId,
	 this.externalUrl,
	 this.status = RentalStatus.DRAFT,
	 this.lastSyncedAt,
	 this.syncEnabled = true,
	 this.createdAt,
	 this.updatedAt,
	 this.rental,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<VacationRentalPlatform, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"rentalId": (m) => m.rentalId,

	"platform": (m) => m.platform,

	"externalId": (m) => m.externalId,

	"externalUrl": (m) => m.externalUrl,

	"status": (m) => m.status,

	"lastSyncedAt": (m) => m.lastSyncedAt,

	"syncEnabled": (m) => m.syncEnabled,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"rental": (m) => m.rental,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(VacationRentalPlatform) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in VacationRentalPlatform');
    }
    return propFunction as V? Function(VacationRentalPlatform);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory VacationRentalPlatform.fromJson(JsonMap json) =>
      VacationRentalPlatform(
        id: json['id'] as String?,
	rentalId: json['rentalId'] as String?,
	platform: json['platform'] != null ? RentalPlatform.fromJson(json['platform']) : null,
	externalId: json['externalId'] as String?,
	externalUrl: json['externalUrl'] as String?,
	status: json['status'] != null ? RentalStatus.fromJson(json['status']) : null,
	lastSyncedAt: json['lastSyncedAt'] != null ? DateTime.parse(json['lastSyncedAt']) : null,
	syncEnabled: json['syncEnabled'] as bool?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	rental: json['rental'] != null ? VacationRental.fromJson(json['rental'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    VacationRentalPlatform copyWith({
        Value<String?>? id,
		Value<String?>? rentalId,
		Value<RentalPlatform?>? platform,
		Value<String?>? externalId,
		Value<String?>? externalUrl,
		Value<RentalStatus?>? status,
		Value<DateTime?>? lastSyncedAt,
		Value<bool?>? syncEnabled,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<VacationRental?>? rental,
        }) {
        return VacationRentalPlatform(
            id: id != null ? id.value : this.id,
		rentalId: rentalId != null ? rentalId.value : this.rentalId,
		platform: platform != null ? platform.value : this.platform,
		externalId: externalId != null ? externalId.value : this.externalId,
		externalUrl: externalUrl != null ? externalUrl.value : this.externalUrl,
		status: status != null ? status.value : this.status,
		lastSyncedAt: lastSyncedAt != null ? lastSyncedAt.value : this.lastSyncedAt,
		syncEnabled: syncEnabled != null ? syncEnabled.value : this.syncEnabled,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		rental: rental != null ? rental.value : this.rental
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    VacationRentalPlatform copyWithInstanceValues(VacationRentalPlatform vacationRentalPlatform) {
        return VacationRentalPlatform(
            id: vacationRentalPlatform.id ?? id,
		rentalId: vacationRentalPlatform.rentalId ?? rentalId,
		platform: vacationRentalPlatform.platform ?? platform,
		externalId: vacationRentalPlatform.externalId ?? externalId,
		externalUrl: vacationRentalPlatform.externalUrl ?? externalUrl,
		status: vacationRentalPlatform.status ?? status,
		lastSyncedAt: vacationRentalPlatform.lastSyncedAt ?? lastSyncedAt,
		syncEnabled: vacationRentalPlatform.syncEnabled ?? syncEnabled,
		createdAt: vacationRentalPlatform.createdAt ?? createdAt,
		updatedAt: vacationRentalPlatform.updatedAt ?? updatedAt,
		rental: vacationRentalPlatform.rental ?? rental
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    VacationRentalPlatform mergeWithInstanceValues(VacationRentalPlatform vacationRentalPlatform) {
        return VacationRentalPlatform(
            id: vacationRentalPlatform.$assignedFields.contains('id') ? vacationRentalPlatform.id : id,
		rentalId: vacationRentalPlatform.$assignedFields.contains('rentalId') ? vacationRentalPlatform.rentalId : rentalId,
		platform: vacationRentalPlatform.$assignedFields.contains('platform') ? vacationRentalPlatform.platform : platform,
		externalId: vacationRentalPlatform.$assignedFields.contains('externalId') ? vacationRentalPlatform.externalId : externalId,
		externalUrl: vacationRentalPlatform.$assignedFields.contains('externalUrl') ? vacationRentalPlatform.externalUrl : externalUrl,
		status: vacationRentalPlatform.$assignedFields.contains('status') ? vacationRentalPlatform.status : status,
		lastSyncedAt: vacationRentalPlatform.$assignedFields.contains('lastSyncedAt') ? vacationRentalPlatform.lastSyncedAt : lastSyncedAt,
		syncEnabled: vacationRentalPlatform.$assignedFields.contains('syncEnabled') ? vacationRentalPlatform.syncEnabled : syncEnabled,
		createdAt: vacationRentalPlatform.$assignedFields.contains('createdAt') ? vacationRentalPlatform.createdAt : createdAt,
		updatedAt: vacationRentalPlatform.$assignedFields.contains('updatedAt') ? vacationRentalPlatform.updatedAt : updatedAt,
		rental: vacationRentalPlatform.$assignedFields.contains('rental') ? vacationRentalPlatform.rental : rental
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    VacationRentalPlatform updateWithInstanceValues(VacationRentalPlatform vacationRentalPlatform) {
        if (vacationRentalPlatform.$assignedFields.contains('id')) { id = vacationRentalPlatform.id; }
		if (vacationRentalPlatform.$assignedFields.contains('rentalId')) { rentalId = vacationRentalPlatform.rentalId; }
		if (vacationRentalPlatform.$assignedFields.contains('platform')) { platform = vacationRentalPlatform.platform; }
		if (vacationRentalPlatform.$assignedFields.contains('externalId')) { externalId = vacationRentalPlatform.externalId; }
		if (vacationRentalPlatform.$assignedFields.contains('externalUrl')) { externalUrl = vacationRentalPlatform.externalUrl; }
		if (vacationRentalPlatform.$assignedFields.contains('status')) { status = vacationRentalPlatform.status; }
		if (vacationRentalPlatform.$assignedFields.contains('lastSyncedAt')) { lastSyncedAt = vacationRentalPlatform.lastSyncedAt; }
		if (vacationRentalPlatform.$assignedFields.contains('syncEnabled')) { syncEnabled = vacationRentalPlatform.syncEnabled; }
		if (vacationRentalPlatform.$assignedFields.contains('createdAt')) { createdAt = vacationRentalPlatform.createdAt; }
		if (vacationRentalPlatform.$assignedFields.contains('updatedAt')) { updatedAt = vacationRentalPlatform.updatedAt; }
		if (vacationRentalPlatform.$assignedFields.contains('rental')) { rental = vacationRentalPlatform.rental; }
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
          ? {...?serializedTypes, 'VacationRentalPlatform'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(rentalId != null) 'rentalId': rentalId,
	if(platform != null) 'platform': platform?.toJson(),
	if(externalId != null) 'externalId': externalId,
	if(externalUrl != null) 'externalUrl': externalUrl,
	if(status != null) 'status': status?.toJson(),
	if(lastSyncedAt != null) 'lastSyncedAt': lastSyncedAt?.toIso8601String(),
	if(syncEnabled != null) 'syncEnabled': syncEnabled,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(rental != null && (!preventCircularSerialization || !serializedModels.contains('VacationRental'))) 'rental': rental?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is VacationRentalPlatform &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    