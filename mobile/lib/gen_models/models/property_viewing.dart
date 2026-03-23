
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'user.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';


class PropertyViewing implements PrismaModel<String, PropertyViewing> , Id<String> {
    @override
String? id;
	String? orgId;
	String? propertyId;
	String? listingId;
	String? viewingType;
	DateTime? scheduledDate;
	int? duration;
	String? attendeeName;
	String? attendeeEmail;
	String? attendeePhone;
	String? attendeeType;
	String? status;
	String? assignedAgentId;
	String? feedback;
	String? interestedLevel;
	bool? followUpRequired;
	String? followUpNotes;
	DateTime? createdAt;
	DateTime? updatedAt;
	User? assignedAgent;
	Listing? listing;
	Organization? org;
	Property? property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    PropertyViewing({ this.id,
	 this.orgId,
	 this.propertyId,
	 this.listingId,
	 this.viewingType,
	 this.scheduledDate,
	 this.duration,
	 this.attendeeName,
	 this.attendeeEmail,
	 this.attendeePhone,
	 this.attendeeType,
	 this.status = "SCHEDULED",
	 this.assignedAgentId,
	 this.feedback,
	 this.interestedLevel,
	 this.followUpRequired = false,
	 this.followUpNotes,
	 this.createdAt,
	 this.updatedAt,
	 this.assignedAgent,
	 this.listing,
	 this.org,
	 this.property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<PropertyViewing, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"propertyId": (m) => m.propertyId,

	"listingId": (m) => m.listingId,

	"viewingType": (m) => m.viewingType,

	"scheduledDate": (m) => m.scheduledDate,

	"duration": (m) => m.duration,

	"attendeeName": (m) => m.attendeeName,

	"attendeeEmail": (m) => m.attendeeEmail,

	"attendeePhone": (m) => m.attendeePhone,

	"attendeeType": (m) => m.attendeeType,

	"status": (m) => m.status,

	"assignedAgentId": (m) => m.assignedAgentId,

	"feedback": (m) => m.feedback,

	"interestedLevel": (m) => m.interestedLevel,

	"followUpRequired": (m) => m.followUpRequired,

	"followUpNotes": (m) => m.followUpNotes,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"assignedAgent": (m) => m.assignedAgent,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"property": (m) => m.property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(PropertyViewing) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in PropertyViewing');
    }
    return propFunction as V? Function(PropertyViewing);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory PropertyViewing.fromJson(JsonMap json) =>
      PropertyViewing(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	propertyId: json['propertyId'] as String?,
	listingId: json['listingId'] as String?,
	viewingType: json['viewingType'] as String?,
	scheduledDate: json['scheduledDate'] != null ? DateTime.parse(json['scheduledDate']) : null,
	duration: int.tryParse(json['duration'].toString()),
	attendeeName: json['attendeeName'] as String?,
	attendeeEmail: json['attendeeEmail'] as String?,
	attendeePhone: json['attendeePhone'] as String?,
	attendeeType: json['attendeeType'] as String?,
	status: json['status'] as String?,
	assignedAgentId: json['assignedAgentId'] as String?,
	feedback: json['feedback'] as String?,
	interestedLevel: json['interestedLevel'] as String?,
	followUpRequired: json['followUpRequired'] as bool?,
	followUpNotes: json['followUpNotes'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	assignedAgent: json['assignedAgent'] != null ? User.fromJson(json['assignedAgent'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    PropertyViewing copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? propertyId,
		Value<String?>? listingId,
		Value<String?>? viewingType,
		Value<DateTime?>? scheduledDate,
		Value<int?>? duration,
		Value<String?>? attendeeName,
		Value<String?>? attendeeEmail,
		Value<String?>? attendeePhone,
		Value<String?>? attendeeType,
		Value<String?>? status,
		Value<String?>? assignedAgentId,
		Value<String?>? feedback,
		Value<String?>? interestedLevel,
		Value<bool?>? followUpRequired,
		Value<String?>? followUpNotes,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<User?>? assignedAgent,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Property?>? property,
        }) {
        return PropertyViewing(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		listingId: listingId != null ? listingId.value : this.listingId,
		viewingType: viewingType != null ? viewingType.value : this.viewingType,
		scheduledDate: scheduledDate != null ? scheduledDate.value : this.scheduledDate,
		duration: duration != null ? duration.value : this.duration,
		attendeeName: attendeeName != null ? attendeeName.value : this.attendeeName,
		attendeeEmail: attendeeEmail != null ? attendeeEmail.value : this.attendeeEmail,
		attendeePhone: attendeePhone != null ? attendeePhone.value : this.attendeePhone,
		attendeeType: attendeeType != null ? attendeeType.value : this.attendeeType,
		status: status != null ? status.value : this.status,
		assignedAgentId: assignedAgentId != null ? assignedAgentId.value : this.assignedAgentId,
		feedback: feedback != null ? feedback.value : this.feedback,
		interestedLevel: interestedLevel != null ? interestedLevel.value : this.interestedLevel,
		followUpRequired: followUpRequired != null ? followUpRequired.value : this.followUpRequired,
		followUpNotes: followUpNotes != null ? followUpNotes.value : this.followUpNotes,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		assignedAgent: assignedAgent != null ? assignedAgent.value : this.assignedAgent,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    PropertyViewing copyWithInstanceValues(PropertyViewing propertyViewing) {
        return PropertyViewing(
            id: propertyViewing.id ?? id,
		orgId: propertyViewing.orgId ?? orgId,
		propertyId: propertyViewing.propertyId ?? propertyId,
		listingId: propertyViewing.listingId ?? listingId,
		viewingType: propertyViewing.viewingType ?? viewingType,
		scheduledDate: propertyViewing.scheduledDate ?? scheduledDate,
		duration: propertyViewing.duration ?? duration,
		attendeeName: propertyViewing.attendeeName ?? attendeeName,
		attendeeEmail: propertyViewing.attendeeEmail ?? attendeeEmail,
		attendeePhone: propertyViewing.attendeePhone ?? attendeePhone,
		attendeeType: propertyViewing.attendeeType ?? attendeeType,
		status: propertyViewing.status ?? status,
		assignedAgentId: propertyViewing.assignedAgentId ?? assignedAgentId,
		feedback: propertyViewing.feedback ?? feedback,
		interestedLevel: propertyViewing.interestedLevel ?? interestedLevel,
		followUpRequired: propertyViewing.followUpRequired ?? followUpRequired,
		followUpNotes: propertyViewing.followUpNotes ?? followUpNotes,
		createdAt: propertyViewing.createdAt ?? createdAt,
		updatedAt: propertyViewing.updatedAt ?? updatedAt,
		assignedAgent: propertyViewing.assignedAgent ?? assignedAgent,
		listing: propertyViewing.listing ?? listing,
		org: propertyViewing.org ?? org,
		property: propertyViewing.property ?? property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    PropertyViewing mergeWithInstanceValues(PropertyViewing propertyViewing) {
        return PropertyViewing(
            id: propertyViewing.$assignedFields.contains('id') ? propertyViewing.id : id,
		orgId: propertyViewing.$assignedFields.contains('orgId') ? propertyViewing.orgId : orgId,
		propertyId: propertyViewing.$assignedFields.contains('propertyId') ? propertyViewing.propertyId : propertyId,
		listingId: propertyViewing.$assignedFields.contains('listingId') ? propertyViewing.listingId : listingId,
		viewingType: propertyViewing.$assignedFields.contains('viewingType') ? propertyViewing.viewingType : viewingType,
		scheduledDate: propertyViewing.$assignedFields.contains('scheduledDate') ? propertyViewing.scheduledDate : scheduledDate,
		duration: propertyViewing.$assignedFields.contains('duration') ? propertyViewing.duration : duration,
		attendeeName: propertyViewing.$assignedFields.contains('attendeeName') ? propertyViewing.attendeeName : attendeeName,
		attendeeEmail: propertyViewing.$assignedFields.contains('attendeeEmail') ? propertyViewing.attendeeEmail : attendeeEmail,
		attendeePhone: propertyViewing.$assignedFields.contains('attendeePhone') ? propertyViewing.attendeePhone : attendeePhone,
		attendeeType: propertyViewing.$assignedFields.contains('attendeeType') ? propertyViewing.attendeeType : attendeeType,
		status: propertyViewing.$assignedFields.contains('status') ? propertyViewing.status : status,
		assignedAgentId: propertyViewing.$assignedFields.contains('assignedAgentId') ? propertyViewing.assignedAgentId : assignedAgentId,
		feedback: propertyViewing.$assignedFields.contains('feedback') ? propertyViewing.feedback : feedback,
		interestedLevel: propertyViewing.$assignedFields.contains('interestedLevel') ? propertyViewing.interestedLevel : interestedLevel,
		followUpRequired: propertyViewing.$assignedFields.contains('followUpRequired') ? propertyViewing.followUpRequired : followUpRequired,
		followUpNotes: propertyViewing.$assignedFields.contains('followUpNotes') ? propertyViewing.followUpNotes : followUpNotes,
		createdAt: propertyViewing.$assignedFields.contains('createdAt') ? propertyViewing.createdAt : createdAt,
		updatedAt: propertyViewing.$assignedFields.contains('updatedAt') ? propertyViewing.updatedAt : updatedAt,
		assignedAgent: propertyViewing.$assignedFields.contains('assignedAgent') ? propertyViewing.assignedAgent : assignedAgent,
		listing: propertyViewing.$assignedFields.contains('listing') ? propertyViewing.listing : listing,
		org: propertyViewing.$assignedFields.contains('org') ? propertyViewing.org : org,
		property: propertyViewing.$assignedFields.contains('property') ? propertyViewing.property : property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    PropertyViewing updateWithInstanceValues(PropertyViewing propertyViewing) {
        if (propertyViewing.$assignedFields.contains('id')) { id = propertyViewing.id; }
		if (propertyViewing.$assignedFields.contains('orgId')) { orgId = propertyViewing.orgId; }
		if (propertyViewing.$assignedFields.contains('propertyId')) { propertyId = propertyViewing.propertyId; }
		if (propertyViewing.$assignedFields.contains('listingId')) { listingId = propertyViewing.listingId; }
		if (propertyViewing.$assignedFields.contains('viewingType')) { viewingType = propertyViewing.viewingType; }
		if (propertyViewing.$assignedFields.contains('scheduledDate')) { scheduledDate = propertyViewing.scheduledDate; }
		if (propertyViewing.$assignedFields.contains('duration')) { duration = propertyViewing.duration; }
		if (propertyViewing.$assignedFields.contains('attendeeName')) { attendeeName = propertyViewing.attendeeName; }
		if (propertyViewing.$assignedFields.contains('attendeeEmail')) { attendeeEmail = propertyViewing.attendeeEmail; }
		if (propertyViewing.$assignedFields.contains('attendeePhone')) { attendeePhone = propertyViewing.attendeePhone; }
		if (propertyViewing.$assignedFields.contains('attendeeType')) { attendeeType = propertyViewing.attendeeType; }
		if (propertyViewing.$assignedFields.contains('status')) { status = propertyViewing.status; }
		if (propertyViewing.$assignedFields.contains('assignedAgentId')) { assignedAgentId = propertyViewing.assignedAgentId; }
		if (propertyViewing.$assignedFields.contains('feedback')) { feedback = propertyViewing.feedback; }
		if (propertyViewing.$assignedFields.contains('interestedLevel')) { interestedLevel = propertyViewing.interestedLevel; }
		if (propertyViewing.$assignedFields.contains('followUpRequired')) { followUpRequired = propertyViewing.followUpRequired; }
		if (propertyViewing.$assignedFields.contains('followUpNotes')) { followUpNotes = propertyViewing.followUpNotes; }
		if (propertyViewing.$assignedFields.contains('createdAt')) { createdAt = propertyViewing.createdAt; }
		if (propertyViewing.$assignedFields.contains('updatedAt')) { updatedAt = propertyViewing.updatedAt; }
		if (propertyViewing.$assignedFields.contains('assignedAgent')) { assignedAgent = propertyViewing.assignedAgent; }
		if (propertyViewing.$assignedFields.contains('listing')) { listing = propertyViewing.listing; }
		if (propertyViewing.$assignedFields.contains('org')) { org = propertyViewing.org; }
		if (propertyViewing.$assignedFields.contains('property')) { property = propertyViewing.property; }
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
          ? {...?serializedTypes, 'PropertyViewing'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(propertyId != null) 'propertyId': propertyId,
	if(listingId != null) 'listingId': listingId,
	if(viewingType != null) 'viewingType': viewingType,
	if(scheduledDate != null) 'scheduledDate': scheduledDate?.toIso8601String(),
	if(duration != null) 'duration': duration,
	if(attendeeName != null) 'attendeeName': attendeeName,
	if(attendeeEmail != null) 'attendeeEmail': attendeeEmail,
	if(attendeePhone != null) 'attendeePhone': attendeePhone,
	if(attendeeType != null) 'attendeeType': attendeeType,
	if(status != null) 'status': status,
	if(assignedAgentId != null) 'assignedAgentId': assignedAgentId,
	if(feedback != null) 'feedback': feedback,
	if(interestedLevel != null) 'interestedLevel': interestedLevel,
	if(followUpRequired != null) 'followUpRequired': followUpRequired,
	if(followUpNotes != null) 'followUpNotes': followUpNotes,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(assignedAgent != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'assignedAgent': assignedAgent?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is PropertyViewing &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    