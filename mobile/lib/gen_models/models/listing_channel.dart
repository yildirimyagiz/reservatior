
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'listing_channel_type.dart';
import 'listing.dart';
import 'organization.dart';


class ListingChannel implements PrismaModel<String, ListingChannel> , Id<String> {
    @override
String? id;
	String? orgId;
	String? listingId;
	ListingChannelType? channel;
	String? channelId;
	String? status;
	DateTime? lastSync;
	DateTime? createdAt;
	DateTime? updatedAt;
	Listing? listing;
	Organization? org;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ListingChannel({ this.id,
	 this.orgId,
	 this.listingId,
	 this.channel,
	 this.channelId,
	 this.status = "ACTIVE",
	 this.lastSync,
	 this.createdAt,
	 this.updatedAt,
	 this.listing,
	 this.org,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ListingChannel, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"listingId": (m) => m.listingId,

	"channel": (m) => m.channel,

	"channelId": (m) => m.channelId,

	"status": (m) => m.status,

	"lastSync": (m) => m.lastSync,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"listing": (m) => m.listing,

	"org": (m) => m.org,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ListingChannel) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ListingChannel');
    }
    return propFunction as V? Function(ListingChannel);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ListingChannel.fromJson(JsonMap json) =>
      ListingChannel(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	listingId: json['listingId'] as String?,
	channel: json['channel'] != null ? ListingChannelType.fromJson(json['channel']) : null,
	channelId: json['channelId'] as String?,
	status: json['status'] as String?,
	lastSync: json['lastSync'] != null ? DateTime.parse(json['lastSync']) : null,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ListingChannel copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? listingId,
		Value<ListingChannelType?>? channel,
		Value<String?>? channelId,
		Value<String?>? status,
		Value<DateTime?>? lastSync,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Listing?>? listing,
		Value<Organization?>? org,
        }) {
        return ListingChannel(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		listingId: listingId != null ? listingId.value : this.listingId,
		channel: channel != null ? channel.value : this.channel,
		channelId: channelId != null ? channelId.value : this.channelId,
		status: status != null ? status.value : this.status,
		lastSync: lastSync != null ? lastSync.value : this.lastSync,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ListingChannel copyWithInstanceValues(ListingChannel listingChannel) {
        return ListingChannel(
            id: listingChannel.id ?? id,
		orgId: listingChannel.orgId ?? orgId,
		listingId: listingChannel.listingId ?? listingId,
		channel: listingChannel.channel ?? channel,
		channelId: listingChannel.channelId ?? channelId,
		status: listingChannel.status ?? status,
		lastSync: listingChannel.lastSync ?? lastSync,
		createdAt: listingChannel.createdAt ?? createdAt,
		updatedAt: listingChannel.updatedAt ?? updatedAt,
		listing: listingChannel.listing ?? listing,
		org: listingChannel.org ?? org
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ListingChannel mergeWithInstanceValues(ListingChannel listingChannel) {
        return ListingChannel(
            id: listingChannel.$assignedFields.contains('id') ? listingChannel.id : id,
		orgId: listingChannel.$assignedFields.contains('orgId') ? listingChannel.orgId : orgId,
		listingId: listingChannel.$assignedFields.contains('listingId') ? listingChannel.listingId : listingId,
		channel: listingChannel.$assignedFields.contains('channel') ? listingChannel.channel : channel,
		channelId: listingChannel.$assignedFields.contains('channelId') ? listingChannel.channelId : channelId,
		status: listingChannel.$assignedFields.contains('status') ? listingChannel.status : status,
		lastSync: listingChannel.$assignedFields.contains('lastSync') ? listingChannel.lastSync : lastSync,
		createdAt: listingChannel.$assignedFields.contains('createdAt') ? listingChannel.createdAt : createdAt,
		updatedAt: listingChannel.$assignedFields.contains('updatedAt') ? listingChannel.updatedAt : updatedAt,
		listing: listingChannel.$assignedFields.contains('listing') ? listingChannel.listing : listing,
		org: listingChannel.$assignedFields.contains('org') ? listingChannel.org : org
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ListingChannel updateWithInstanceValues(ListingChannel listingChannel) {
        if (listingChannel.$assignedFields.contains('id')) { id = listingChannel.id; }
		if (listingChannel.$assignedFields.contains('orgId')) { orgId = listingChannel.orgId; }
		if (listingChannel.$assignedFields.contains('listingId')) { listingId = listingChannel.listingId; }
		if (listingChannel.$assignedFields.contains('channel')) { channel = listingChannel.channel; }
		if (listingChannel.$assignedFields.contains('channelId')) { channelId = listingChannel.channelId; }
		if (listingChannel.$assignedFields.contains('status')) { status = listingChannel.status; }
		if (listingChannel.$assignedFields.contains('lastSync')) { lastSync = listingChannel.lastSync; }
		if (listingChannel.$assignedFields.contains('createdAt')) { createdAt = listingChannel.createdAt; }
		if (listingChannel.$assignedFields.contains('updatedAt')) { updatedAt = listingChannel.updatedAt; }
		if (listingChannel.$assignedFields.contains('listing')) { listing = listingChannel.listing; }
		if (listingChannel.$assignedFields.contains('org')) { org = listingChannel.org; }
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
          ? {...?serializedTypes, 'ListingChannel'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(listingId != null) 'listingId': listingId,
	if(channel != null) 'channel': channel?.toJson(),
	if(channelId != null) 'channelId': channelId,
	if(status != null) 'status': status,
	if(lastSync != null) 'lastSync': lastSync?.toIso8601String(),
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ListingChannel &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    