
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'listing_status.dart';
import 'listing.dart';
import 'organization.dart';


class ListingStatusHistory implements PrismaModel<String, ListingStatusHistory> , Id<String> {
    @override
String? id;
	String? orgId;
	String? listingId;
	ListingStatus? status;
	DateTime? fromDate;
	DateTime? toDate;
	String? reason;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Listing? listing;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ListingStatusHistory({ this.id,
	 this.orgId,
	 this.listingId,
	 this.status,
	 this.fromDate,
	 this.toDate,
	 this.reason,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.listing,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ListingStatusHistory, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"listingId": (m) => m.listingId,

	"status": (m) => m.status,

	"fromDate": (m) => m.fromDate,

	"toDate": (m) => m.toDate,

	"reason": (m) => m.reason,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"listing": (m) => m.listing,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ListingStatusHistory) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ListingStatusHistory');
    }
    return propFunction as V? Function(ListingStatusHistory);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ListingStatusHistory.fromJson(JsonMap json) =>
      ListingStatusHistory(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	listingId: json['listingId'] as String?,
	status: json['status'] != null ? ListingStatus.fromJson(json['status']) : null,
	fromDate: json['fromDate'] != null ? DateTime.parse(json['fromDate']) : null,
	toDate: json['toDate'] != null ? DateTime.parse(json['toDate']) : null,
	reason: json['reason'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ListingStatusHistory copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? listingId,
		Value<ListingStatus?>? status,
		Value<DateTime?>? fromDate,
		Value<DateTime?>? toDate,
		Value<String?>? reason,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Listing?>? listing,
		Value<Organization?>? org,
        }) {
        return ListingStatusHistory(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		listingId: listingId != null ? listingId.value : this.listingId,
		status: status != null ? status.value : this.status,
		fromDate: fromDate != null ? fromDate.value : this.fromDate,
		toDate: toDate != null ? toDate.value : this.toDate,
		reason: reason != null ? reason.value : this.reason,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ListingStatusHistory copyWithInstanceValues(ListingStatusHistory listingStatusHistory) {
        return ListingStatusHistory(
            id: listingStatusHistory.id ?? id,
		orgId: listingStatusHistory.orgId ?? orgId,
		listingId: listingStatusHistory.listingId ?? listingId,
		status: listingStatusHistory.status ?? status,
		fromDate: listingStatusHistory.fromDate ?? fromDate,
		toDate: listingStatusHistory.toDate ?? toDate,
		reason: listingStatusHistory.reason ?? reason,
		createdBy: listingStatusHistory.createdBy ?? createdBy,
		createdAt: listingStatusHistory.createdAt ?? createdAt,
		updatedAt: listingStatusHistory.updatedAt ?? updatedAt,
		deletedAt: listingStatusHistory.deletedAt ?? deletedAt,
		listing: listingStatusHistory.listing ?? listing,
		org: listingStatusHistory.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ListingStatusHistory mergeWithInstanceValues(ListingStatusHistory listingStatusHistory) {
        return ListingStatusHistory(
            id: listingStatusHistory.$assignedFields.contains('id') ? listingStatusHistory.id : id,
		orgId: listingStatusHistory.$assignedFields.contains('orgId') ? listingStatusHistory.orgId : orgId,
		listingId: listingStatusHistory.$assignedFields.contains('listingId') ? listingStatusHistory.listingId : listingId,
		status: listingStatusHistory.$assignedFields.contains('status') ? listingStatusHistory.status : status,
		fromDate: listingStatusHistory.$assignedFields.contains('fromDate') ? listingStatusHistory.fromDate : fromDate,
		toDate: listingStatusHistory.$assignedFields.contains('toDate') ? listingStatusHistory.toDate : toDate,
		reason: listingStatusHistory.$assignedFields.contains('reason') ? listingStatusHistory.reason : reason,
		createdBy: listingStatusHistory.$assignedFields.contains('createdBy') ? listingStatusHistory.createdBy : createdBy,
		createdAt: listingStatusHistory.$assignedFields.contains('createdAt') ? listingStatusHistory.createdAt : createdAt,
		updatedAt: listingStatusHistory.$assignedFields.contains('updatedAt') ? listingStatusHistory.updatedAt : updatedAt,
		deletedAt: listingStatusHistory.$assignedFields.contains('deletedAt') ? listingStatusHistory.deletedAt : deletedAt,
		listing: listingStatusHistory.$assignedFields.contains('listing') ? listingStatusHistory.listing : listing,
		org: listingStatusHistory.$assignedFields.contains('org') ? listingStatusHistory.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ListingStatusHistory updateWithInstanceValues(ListingStatusHistory listingStatusHistory) {
        if (listingStatusHistory.$assignedFields.contains('id')) { id = listingStatusHistory.id; }
		if (listingStatusHistory.$assignedFields.contains('orgId')) { orgId = listingStatusHistory.orgId; }
		if (listingStatusHistory.$assignedFields.contains('listingId')) { listingId = listingStatusHistory.listingId; }
		if (listingStatusHistory.$assignedFields.contains('status')) { status = listingStatusHistory.status; }
		if (listingStatusHistory.$assignedFields.contains('fromDate')) { fromDate = listingStatusHistory.fromDate; }
		if (listingStatusHistory.$assignedFields.contains('toDate')) { toDate = listingStatusHistory.toDate; }
		if (listingStatusHistory.$assignedFields.contains('reason')) { reason = listingStatusHistory.reason; }
		if (listingStatusHistory.$assignedFields.contains('createdBy')) { createdBy = listingStatusHistory.createdBy; }
		if (listingStatusHistory.$assignedFields.contains('createdAt')) { createdAt = listingStatusHistory.createdAt; }
		if (listingStatusHistory.$assignedFields.contains('updatedAt')) { updatedAt = listingStatusHistory.updatedAt; }
		if (listingStatusHistory.$assignedFields.contains('deletedAt')) { deletedAt = listingStatusHistory.deletedAt; }
		if (listingStatusHistory.$assignedFields.contains('listing')) { listing = listingStatusHistory.listing; }
		if (listingStatusHistory.$assignedFields.contains('org')) { org = listingStatusHistory.org; }
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
          ? {...?serializedTypes, 'ListingStatusHistory'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(listingId != null) 'listingId': listingId,
	if(status != null) 'status': status?.toJson(),
	if(fromDate != null) 'fromDate': fromDate?.toIso8601String(),
	if(toDate != null) 'toDate': toDate?.toIso8601String(),
	if(reason != null) 'reason': reason,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ListingStatusHistory &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    